#pragma once
#include <cstddef>
#include <cstring>
#ifndef MLR_RNBO_POOL_SIZE
#define MLR_RNBO_POOL_SIZE 32768
#endif
#ifndef MLR_RNBO_POOL_ATTRIBUTE
#define MLR_RNBO_POOL_ATTRIBUTE
#endif
// Startup-only arena; these instruments have no resizable sample buffers.
// Trap unexpected runtime allocation instead of allocating in the audio callback.
alignas(std::max_align_t) static unsigned char rnbo_pool[MLR_RNBO_POOL_SIZE] MLR_RNBO_POOL_ATTRIBUTE;
volatile size_t rnbo_pool_used = 0;
volatile bool rnbo_pool_sealed = false;
volatile bool rnbo_allocation_fault = false;
namespace RNBO { namespace Platform {
static void allocationFault() { rnbo_allocation_fault = true; MLR_RNBO_ALLOCATION_FAILURE(); }
void* malloc(size_t n) {
    if(n == 0) return nullptr;
    constexpr size_t alignment = alignof(std::max_align_t);
    const size_t header = alignment;
    if(rnbo_pool_sealed || n > sizeof(rnbo_pool) - header) allocationFault();
    const size_t total = (n + header + alignment - 1) & ~(alignment - 1);
    if(total > sizeof(rnbo_pool) - rnbo_pool_used) allocationFault();
    auto p = rnbo_pool + rnbo_pool_used;
    std::memcpy(p, &n, sizeof(n)); rnbo_pool_used += total;
    return p + header;
}
void free(void*) {} // No teardown/reinitialization in this first target.
void* realloc(void* old, size_t n) {
    if(!old) return malloc(n);
    if(!n) return nullptr;
    size_t previous; std::memcpy(&previous, static_cast<unsigned char*>(old)-alignof(std::max_align_t), sizeof(previous));
    if(n <= previous) return old;
    auto p = malloc(n); std::memcpy(p, old, previous); return p;
}
void* calloc(size_t count, size_t n) {
    if(count && n > sizeof(rnbo_pool)/count) allocationFault();
    auto p = malloc(count*n); if(p) std::memset(p, 0, count*n); return p;
}
} }
