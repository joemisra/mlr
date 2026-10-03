#include "ext.h"
#include "ext_obex.h"
#include "sequence_player_core.hpp"
#include <mutex>
#include <new>
#include <cstring>

struct Telemetry {
    std::array<std::atomic<std::uint64_t>, 8> latest{};
    std::array<std::atomic<std::uint64_t>, 8> observed{};
    unsigned serial = 0; // written only by the core's guarded pulse consumer
    Telemetry() {
        for (auto& value : latest) value.store(0, std::memory_order_relaxed);
        for (auto& value : observed) value.store(0, std::memory_order_relaxed);
    }
};
struct PlayerObject {
    t_object object;
    mlr::SequencePlayer* player;
    std::mutex* producer;
    void* pulseProxy;
    long inlet;
    void* frames;
    void* reports;
    bool production;
    Telemetry* telemetry;
};
static t_class* playerClass = nullptr;
static std::atomic<PlayerObject*> productionOwner{nullptr};

static bool integer(const t_atom& atom, unsigned& value, bool zero = false) {
    if (atom_gettype(&atom) != A_LONG) return false;
    const auto number = atom_getlong(&atom);
    if (number < (zero ? 0 : 1) || number > 2147483647L) return false;
    value = static_cast<unsigned>(number);
    return true;
}

static void playerBang(PlayerObject* x) {
    if (proxy_getinlet(reinterpret_cast<t_object*>(x)) != 1) return;
    x->player->pulse([x](const mlr::SequencePlayer::Event& event, unsigned, unsigned) {
        const auto epoch = event.cacheEpoch;
        const auto serial = (++x->telemetry->serial & 0x7fffffU);
        const auto observation = (static_cast<std::uint64_t>(epoch) << 32) |
            (static_cast<std::uint64_t>(serial) << 9) | (event.track << 4) | event.slice;
        x->telemetry->latest[event.group - 1].store(observation, std::memory_order_release);
        t_atom frame[15];
        atom_setlong(frame, event.group);
        atom_setlong(frame + 1, event.track);
        atom_setlong(frame + 2, event.slice);
        for (unsigned i = 0; i < 12; ++i) atom_setfloat(frame + 3 + i, event.values[i]);
        outlet_list(x->frames, nullptr, 15, frame);
    });
}

static void playerCommand(PlayerObject* x, t_symbol* command, long count, t_atom* args) {
    if (proxy_getinlet(reinterpret_cast<t_object*>(x)) != 0) return;
    const char* name = command->s_name;
    unsigned epoch = 0, generation = 0, number = 0;
    bool accepted = false;
    bool committed = false;
    // Only preparation takes a producer mutex. Pulses and emergency safety
    // controls never take it, and a bank remains private until commit.
    if (!std::strcmp(name, "begin") || !std::strcmp(name, "event") ||
        !std::strcmp(name, "commit") || !std::strcmp(name, "abort")) {
        std::lock_guard<std::mutex> guard(*x->producer);
        if (!std::strcmp(name, "abort") && count == 0) { x->player->abort(); accepted = true; }
        else if (count >= 2 && integer(args[0], epoch) && integer(args[1], generation)) {
            if (!std::strcmp(name, "begin") && count == 3 && integer(args[2], number))
                accepted = x->player->begin(epoch, generation, number);
            else if (!std::strcmp(name, "commit") && count == 2)
                committed = accepted = x->player->commit(epoch, generation);
            else if (!std::strcmp(name, "event") && count == 18 && integer(args[2], number, true)) {
                mlr::SequencePlayer::Event event;
                bool valid = integer(args[3], event.group) && integer(args[4], event.track) && integer(args[5], event.slice, true);
                for (unsigned i = 0; i < 12; ++i) {
                    const auto type = atom_gettype(args + 6 + i);
                    valid = valid && (type == A_LONG || type == A_FLOAT);
                    event.values[i] = atom_getfloat(args + 6 + i);
                }
                if (valid) accepted = x->player->event(epoch, generation, number, event);
            }
        }
        if (!accepted) x->player->abort(); // a bad upload never publishes a partial clip
    } else if (!std::strcmp(name, "stop") && count == 0) {
        x->player->stop(); accepted = true;
    } else if (!std::strcmp(name, "reset") && count == 0) {
        const auto next = x->player->reset();
        t_atom report; atom_setlong(&report, next);
        outlet_anything(x->reports, gensym("epoch"), 1, &report); accepted = true;
    } else if (!std::strcmp(name, "rewind") && count == 0) {
        x->player->rewind(); accepted = true;
    } else if (!std::strcmp(name, "start") && count == 1 && integer(args[0], epoch)) {
        accepted = x->player->start(epoch);
    } else if (!std::strcmp(name, "cancelcurrent") && count == 1 && integer(args[0], number)) {
        accepted = x->player->cancel(x->player->epoch(), number);
    } else if (!std::strcmp(name, "hello") && count == 1 && integer(args[0], number)) {
        t_atom report[3]; atom_setlong(report, x->player->epoch()); atom_setlong(report + 1, number);
        atom_setlong(report + 2, 1); // complete handoff/observation protocol version
        outlet_anything(x->reports, gensym("hello"), 3, report); accepted = true;
    } else if (!std::strcmp(name, "observe") && count == 0) {
        for (unsigned group = 0; group < 8; ++group) {
            const auto value = x->telemetry->latest[group].load(std::memory_order_acquire);
            const auto observed = x->telemetry->observed[group].exchange(value, std::memory_order_acq_rel);
            if (!value || value == observed || (value >> 32) != x->player->epoch()) continue;
            t_atom report[4];
            atom_setlong(report, value >> 32); atom_setlong(report + 1, group + 1);
            atom_setlong(report + 2, (value >> 4) & 31); atom_setlong(report + 3, value & 15);
            outlet_anything(x->reports, gensym("frame"), 4, report);
        }
        accepted = true;
    } else if (count == 2 && integer(args[0], epoch) && integer(args[1], number)) {
        if (!std::strcmp(name, "cancel")) accepted = x->player->cancel(epoch, number);
        else if (!std::strcmp(name, "resume")) accepted = x->player->resume(epoch, number);
    } else if (!std::strcmp(name, "status") && count == 0) {
        t_atom report[2]; atom_setlong(report, x->player->epoch()); atom_setlong(report + 1, x->player->running());
        outlet_anything(x->reports, gensym("status"), 2, report); accepted = true;
    }
    // Reports are outside the preparation mutex: feedback must not deadlock it.
    if (committed) {
        t_atom report[2]; atom_setlong(report, epoch); atom_setlong(report + 1, generation);
        outlet_anything(x->reports, gensym("committed"), 2, report);
    }
    if (!accepted) {
        object_error(reinterpret_cast<t_object*>(x), "rejected %s (invalid, stale, unsupported, or no free bank)", name);
        t_atom report; atom_setsym(&report, command);
        outlet_anything(x->reports, gensym("rejected"), 1, &report);
    }
}

static void playerFree(PlayerObject* x) {
    if (x->production) productionOwner.store(nullptr, std::memory_order_release);
    if (x->pulseProxy) object_free(x->pulseProxy);
    delete x->player;
    delete x->producer;
    delete x->telemetry;
}

static void* playerNew(t_symbol*, long count, t_atom* args) {
    auto* x = static_cast<PlayerObject*>(object_alloc(playerClass));
    if (!x) return nullptr;
    x->player = nullptr; x->producer = nullptr; x->pulseProxy = nullptr;
    x->production = false;
    x->telemetry = nullptr;
    if (count == 1 && atom_gettype(args) == A_SYM && !std::strcmp(atom_getsym(args)->s_name, "production")) {
        PlayerObject* expected = nullptr;
        if (!productionOwner.compare_exchange_strong(expected, x, std::memory_order_acq_rel)) {
            object_error(reinterpret_cast<t_object*>(x), "only one production native bridge may be open");
            object_free(x); return nullptr;
        }
        x->production = true;
    }
    try { x->player = new mlr::SequencePlayer; x->producer = new std::mutex; x->telemetry = new Telemetry; }
    catch (const std::bad_alloc&) { object_free(x); return nullptr; }
    x->pulseProxy = proxy_new(reinterpret_cast<t_object*>(x), 1, &x->inlet);
    x->reports = outlet_new(x, nullptr);
    x->frames = outlet_new(x, nullptr);
    return x;
}

extern "C" C74_EXPORT void ext_main(void*) {
    playerClass = class_new("mlr.sequence_player", reinterpret_cast<method>(playerNew),
                            reinterpret_cast<method>(playerFree), sizeof(PlayerObject), nullptr, A_GIMME, 0);
    class_addmethod(playerClass, reinterpret_cast<method>(playerBang), "bang", 0);
    class_addmethod(playerClass, reinterpret_cast<method>(playerCommand), "anything", A_GIMME, 0);
    class_register(CLASS_BOX, playerClass);
}
