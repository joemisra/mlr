#pragma once

#include <array>
#include <atomic>
#include <cmath>
#include <cstdint>

namespace mlr {

// One producer prepares clips; native pulses are the sole consumer. Three
// fixed banks let preparation, publication and playback proceed independently.
// No bank is edited while published or active. Pulse never waits for a writer.
class SequencePlayer {
public:
    static constexpr unsigned maxSteps = 512;
    static constexpr unsigned groups = 8;
    static constexpr unsigned parameters = 12;
    struct Event {
        unsigned group = 0;       // 1..8; zero denotes an empty slot
        unsigned track = 0;       // Max track input bus 11..16 (six drums)
        unsigned slice = 0;
        unsigned cacheEpoch = 0; // assigned by preparation, never by the caller
        std::array<double, parameters> values{};
    };

    SequencePlayer() {
        static_assert(std::atomic<unsigned>::is_always_lock_free,
                      "native player requires lock-free integer atomics");
        static_assert(std::atomic<int>::is_always_lock_free,
                      "native player requires lock-free bank publication");
        static_assert(std::atomic<std::uint64_t>::is_always_lock_free,
                      "native player requires lock-free cancellation epochs");
    }
    SequencePlayer(const SequencePlayer&) = delete;
    SequencePlayer& operator=(const SequencePlayer&) = delete;

    unsigned epoch() const { return epoch_.load(std::memory_order_acquire); }
    bool running() const { return runningEpoch_.load(std::memory_order_acquire) == epoch(); }

    // Preparation methods must be serialized by the embedding application.
    bool begin(unsigned epoch, unsigned generation, unsigned length) {
        abort();
        if (epoch != this->epoch() || !generation || length == 0 || length > maxSteps) return false;
        if (producerEpoch_ != epoch) { producerEpoch_ = epoch; producerGeneration_ = 0; }
        if (generation <= producerGeneration_) return false;
        // Reset invalidates old publications even if no clock is running.
        const int pending = pending_.load(std::memory_order_acquire);
        if (pending >= 0 && banks_[pending].epoch != epoch) {
            int expected = pending;
            if (pending_.compare_exchange_strong(expected, -1, std::memory_order_acq_rel))
                banks_[pending].state.store(freeBank, std::memory_order_release);
        }
        for (unsigned i = 0; i < banks_.size(); ++i) {
            unsigned expected = freeBank;
            if (!banks_[i].state.compare_exchange_strong(expected, writingBank, std::memory_order_acq_rel)) continue;
            staging_ = static_cast<int>(i);
            auto& bank = banks_[i];
            bank.epoch = epoch; bank.generation = generation; bank.length = length;
            for (auto& step : bank.steps) for (auto& event : step) event.group = 0;
            validStaging_ = true;
            return true;
        }
        return false;
    }

    bool event(unsigned epoch, unsigned generation, unsigned step, const Event& event) {
        if (!matchesStaging(epoch, generation)) return false;
        auto& bank = banks_[staging_];
        if (step >= bank.length || event.group < 1 || event.group > groups ||
            event.track < 11 || event.track > 16 || event.slice > 15) return invalidate();
        for (double value : event.values) if (!std::isfinite(value)) return invalidate();
        auto& slot = bank.steps[step][event.group - 1];
        if (slot.group) return invalidate(); // never silently overwrite a hit
        slot = event;
        slot.cacheEpoch = epoch;
        return true;
    }

    bool commit(unsigned epoch, unsigned generation) {
        if (!matchesStaging(epoch, generation) || !validStaging_) return false;
        const int published = staging_;
        banks_[published].state.store(publishedBank, std::memory_order_release);
        const int previous = pending_.exchange(published, std::memory_order_acq_rel);
        if (previous >= 0) banks_[previous].state.store(freeBank, std::memory_order_release);
        staging_ = -1;
        producerGeneration_ = generation;
        return true;
    }

    void abort() {
        if (staging_ >= 0) banks_[staging_].state.store(freeBank, std::memory_order_release);
        staging_ = -1; validStaging_ = false;
    }

    bool start(unsigned epoch) {
        if (epoch != this->epoch()) return false;
        runningEpoch_.store(epoch, std::memory_order_release);
        return true;
    }
    void stop() { runningEpoch_.store(0, std::memory_order_release); }
    void rewind() { rewind_.store(true, std::memory_order_release); }
    unsigned reset() {
        stop();
        const auto next = epoch_.fetch_add(1, std::memory_order_acq_rel) + 1;
        cancelled_.store(static_cast<std::uint64_t>(next) << 32, std::memory_order_release);
        rewind();
        return next;
    }
    bool cancel(unsigned epoch, unsigned group) {
        return changeCancellation(epoch, group, true);
    }
    bool resume(unsigned epoch, unsigned group) {
        return changeCancellation(epoch, group, false);
    }

    // Sink runs synchronously on the native pulse thread. Max feedback may
    // stop/cancel/reset during output; re-check those atomics between frames.
    // Reentrant/concurrent pulses are dropped rather than racing consumer state.
    template <class Sink> void pulse(Sink&& sink) {
        if (pulsing_.test_and_set(std::memory_order_acquire)) return;
        struct Guard { std::atomic_flag& flag; ~Guard() { flag.clear(std::memory_order_release); } } guard{pulsing_};
        const auto epoch = this->epoch();
        if (active_ >= 0 && banks_[active_].epoch != epoch) {
            banks_[active_].state.store(freeBank, std::memory_order_release);
            active_ = -1; cursor_ = 0;
        }
        const int next = pending_.exchange(-1, std::memory_order_acq_rel);
        if (next >= 0) {
            if (banks_[next].epoch != epoch) banks_[next].state.store(freeBank, std::memory_order_release);
            else {
                if (active_ >= 0) banks_[active_].state.store(freeBank, std::memory_order_release);
                active_ = next;
                banks_[next].state.store(activeBank, std::memory_order_release);
                cursor_ %= banks_[next].length;
            }
        }
        if (rewind_.exchange(false, std::memory_order_acq_rel)) cursor_ = 0;
        if (active_ < 0 || !running() || this->epoch() != epoch) return;
        const auto& bank = banks_[active_];
        const auto step = cursor_;
        cursor_ = (cursor_ + 1) % bank.length;
        for (const auto& event : bank.steps[step]) {
            if (!running() || this->epoch() != epoch) break;
            const auto cancelled = cancelled_.load(std::memory_order_acquire);
            if (event.group && !(static_cast<unsigned>(cancelled) & (1u << (event.group - 1))))
                sink(event, step, bank.generation);
        }
    }

private:
    enum : unsigned { freeBank, writingBank, publishedBank, activeBank };
    struct Bank {
        std::atomic<unsigned> state{freeBank};
        unsigned epoch = 0, generation = 0, length = 1;
        std::array<std::array<Event, groups>, maxSteps> steps{};
    };
    bool matchesStaging(unsigned epoch, unsigned generation) const {
        return staging_ >= 0 && epoch == this->epoch() &&
               banks_[staging_].epoch == epoch && banks_[staging_].generation == generation;
    }
    bool invalidate() { validStaging_ = false; return false; }
    bool changeCancellation(unsigned epoch, unsigned group, bool cancel) {
        if (group < 1 || group > groups) return false;
        auto state = cancelled_.load(std::memory_order_acquire);
        const auto bit = std::uint64_t{1} << (group - 1);
        do {
            if (epoch != this->epoch() || (state >> 32) != epoch) return false;
            const auto next = cancel ? state | bit : state & ~bit;
            if (cancelled_.compare_exchange_weak(state, next, std::memory_order_acq_rel)) return true;
        } while (true);
    }
    std::array<Bank, 3> banks_{};
    std::atomic<int> pending_{-1};
    std::atomic<unsigned> epoch_{1}, runningEpoch_{0};
    std::atomic<std::uint64_t> cancelled_{std::uint64_t{1} << 32};
    std::atomic<bool> rewind_{false};
    std::atomic_flag pulsing_ = ATOMIC_FLAG_INIT;
    int staging_ = -1, active_ = -1;
    unsigned producerEpoch_ = 0, producerGeneration_ = 0, cursor_ = 0;
    bool validStaging_ = false;
};
} // namespace mlr
