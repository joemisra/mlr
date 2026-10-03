#include "sequence_player_core.hpp"
#include <cstdlib>
#include <iostream>
#include <limits>
#include <memory>
#include <new>
#include <thread>

static std::atomic<unsigned> allocations{0};
void* operator new(std::size_t size) {
    allocations.fetch_add(1, std::memory_order_relaxed);
    if (auto* result = std::malloc(size)) return result;
    throw std::bad_alloc{};
}
void* operator new[](std::size_t size) { return ::operator new(size); }
void operator delete(void* value) noexcept { std::free(value); }
void operator delete[](void* value) noexcept { std::free(value); }

static void check(bool pass, const char* description) {
    if (!pass) { std::cerr << "FAIL: " << description << '\n'; std::exit(1); }
}
using Player = mlr::SequencePlayer;
static Player::Event hit(unsigned group, unsigned track = 16, double value = 1) {
    Player::Event result;
    result.group = group; result.track = track; result.slice = 3; result.values.fill(value);
    return result;
}
static void sixDrumsWithoutProducer() {
    auto player = std::make_unique<Player>();
    check(player->begin(1, 1, 4), "begin six drums");
    for (unsigned group = 1; group <= 6; ++group)
        check(player->event(1, 1, 0, hit(group, 17 - group)), "cache simultaneous drum frame");
    check(player->commit(1, 1), "publish six drums");
    check(!player->running(), "commit does not start playback");
    check(player->start(1), "explicit start");
    unsigned frames = 0, pulses = 0;
    std::array<unsigned, 8> groups{};
    const auto before = allocations.load();
    // More than six minutes of subdivisions at 120 BPM, no producer work.
    for (unsigned tick = 0; tick < 12000; ++tick) {
        unsigned atTick = 0;
        player->pulse([&](const Player::Event& event, unsigned step, unsigned generation) {
            check(step == 0 && generation == 1, "all simultaneous frames have one native step/generation");
            check(event.cacheEpoch == 1, "telemetry carries its immutable cache epoch");
            check(event.values[0] == 1 && event.values[11] == 1, "complete parameter frame");
            ++frames; ++atTick; ++groups[event.group - 1];
        });
        check(atTick == (tick % 4 == 0 ? 6u : 0u), "all six hits occur on the intended pulse");
        ++pulses;
    }
    check(allocations.load() == before, "pulse path performs no heap allocations");
    check(pulses == 12000 && frames == 18000, "cached clip plays without refills");
    for (unsigned group = 0; group < 6; ++group) check(groups[group] == 3000, "no missing group hits");
}
static void atomicPublicationAndSafety() {
    auto player = std::make_unique<Player>();
    check(player->begin(1, 1, 1), "initial clip");
    check(player->event(1, 1, 0, hit(1)), "initial frame");
    check(player->commit(1, 1) && player->start(1), "activate initial clip");
    auto expect = [&](unsigned expected) {
        unsigned count = 0;
        player->pulse([&](const Player::Event&, unsigned, unsigned generation) {
            check(generation == expected, "publication is whole-generation"); ++count;
        });
        check(count == 1, "one active frame");
    };
    expect(1);
    check(player->begin(1, 2, 1), "prepare replacement while playing");
    check(player->event(1, 2, 0, hit(1, 16, 2)), "replacement frame");
    expect(1); expect(1); // staging is invisible until commit
    check(player->commit(1, 2), "commit replacement"); expect(2);
    check(!player->begin(1, 1, 1), "reject stale generation");
    check(player->begin(1, 3, 1), "invalid upload");
    check(player->event(1, 3, 0, hit(1)), "first frame of invalid upload");
    check(!player->event(1, 3, 0, hit(1)), "reject duplicate group rather than overwrite");
    check(!player->commit(1, 3), "invalid upload cannot commit"); expect(2);
    check(player->cancel(1, 1), "cancel group");
    check(player->begin(1, 4, 1) && player->event(1, 4, 0, hit(1)) && player->commit(1, 4), "publish after cancel");
    unsigned count = 0;
    auto countFrame = [&](const Player::Event&, unsigned, unsigned) { ++count; };
    player->pulse(countFrame); check(count == 0, "commit cannot resurrect cancelled ownership");
    check(player->resume(1, 1), "explicit resume"); player->pulse(countFrame); check(count == 1, "resumed group plays");
    player->stop(); player->pulse(countFrame); check(count == 1, "stop suppresses next pulse");
    check(player->begin(1, 5, 1), "stage before reset");
    const auto epoch = player->reset();
    check(epoch == 2 && !player->commit(1, 5) && !player->start(1), "reset invalidates old uploads and starts");
    check(!player->cancel(1, 1) && !player->resume(1, 1), "old safety messages cannot alter new epoch");
    check(player->start(2), "start current epoch without a cache"); player->pulse(countFrame);
    check(count == 1, "reset does not replay old cache");
    check(player->begin(2, 1, 1) && player->event(2, 1, 0, hit(1)) && player->commit(2, 1), "load new epoch");
    player->pulse(countFrame); check(count == 2, "new epoch plays");
    check(player->begin(2, 2, 1), "stage nonfinite parameters");
    auto bad = hit(1); bad.values[4] = std::numeric_limits<double>::infinity();
    check(!player->event(2, 2, 0, bad) && !player->commit(2, 2), "reject nonfinite frames");
}
static void phaseAndFeedback() {
    auto player = std::make_unique<Player>();
    auto load = [&](unsigned generation, unsigned length) {
        check(player->begin(1, generation, length), "begin phase clip");
        for (unsigned step = 0; step < length; ++step) check(player->event(1, generation, step, hit(1)), "phase frame");
        check(player->commit(1, generation), "phase commit");
    };
    load(1, 4); player->start(1);
    unsigned latest = 99;
    auto sink = [&](const Player::Event&, unsigned step, unsigned) { latest = step; };
    player->pulse(sink); check(latest == 0, "first pulse starts at step zero");
    player->stop(); player->pulse(sink); check(latest == 0, "stop freezes cursor");
    player->start(1); player->pulse(sink); check(latest == 1, "resume preserves cursor");
    load(2, 3); player->pulse(sink); check(latest == 2, "replacement preserves cursor modulo new length");
    player->rewind(); player->pulse(sink); check(latest == 0, "rewind applies on native boundary");
    check(player->begin(1, 3, 1), "feedback clip");
    check(player->event(1, 3, 0, hit(1)) && player->event(1, 3, 0, hit(2)) && player->commit(1, 3), "two feedback frames");
    unsigned calls = 0;
    player->pulse([&](const Player::Event&, unsigned, unsigned) {
        ++calls;
        player->pulse([&](const Player::Event&, unsigned, unsigned) { ++calls; });
        player->stop();
    });
    check(calls == 1, "reentrant pulse is ignored and native stop suppresses remaining groups");
}
static void concurrentPreparation() {
    auto player = std::make_unique<Player>();
    player->start(1);
    std::atomic<bool> done{false};
    std::atomic<unsigned> outputs{0};
    std::thread consumer([&] {
        while (!done.load(std::memory_order_acquire)) {
            player->pulse([&](const Player::Event& event, unsigned, unsigned generation) {
                for (double value : event.values) check(value == generation, "concurrent publication never tears parameters");
                ++outputs;
            });
        }
    });
    for (unsigned generation = 1; generation <= 2000; ++generation) {
        while (!player->begin(1, generation, 8)) std::this_thread::yield();
        for (unsigned step = 0; step < 8; ++step)
            for (unsigned group = 1; group <= 6; ++group)
                check(player->event(1, generation, step, hit(group, 17 - group, generation)), "concurrent stage");
        check(player->commit(1, generation), "concurrent commit");
    }
    done.store(true, std::memory_order_release); consumer.join();
    check(outputs > 0, "native pulses continue during producer uploads");
}
int main() {
    sixDrumsWithoutProducer(); atomicPublicationAndSafety(); phaseAndFeedback(); concurrentPreparation();
    std::cout << "native player: cached six-drum pulses, zero pulse allocations, atomic publication, cancellation, reset, phase and concurrent preparation passed\n";
}
