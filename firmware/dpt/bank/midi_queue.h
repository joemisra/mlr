#pragma once
#include "midi_state.h"
#include <atomic>
namespace Bank {
// Single foreground producer / audio-interrupt consumer. Full queue drops newest event.
struct Queue {
 static constexpr unsigned capacity=128;
 Event events[capacity]; std::atomic<unsigned> write{0},read{0};
 bool push(Event e){unsigned w=write.load(std::memory_order_relaxed),r=read.load(std::memory_order_acquire);if(w-r>=capacity)return false;events[w%capacity]=e;write.store(w+1,std::memory_order_release);return true;}
 bool pop(Event& e){unsigned r=read.load(std::memory_order_relaxed),w=write.load(std::memory_order_acquire);if(r==w)return false;e=events[r%capacity];read.store(r+1,std::memory_order_release);return true;}
};
}
