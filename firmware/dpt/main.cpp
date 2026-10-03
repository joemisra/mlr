// First RNBO/DPT bring-up: gate 1 -> original kick -> codec outputs 1/2.
// Does not replace Oopsy and does not route audio through the external DAC.
#include "daisy_dpt.h"
#include "util/CpuLoadMeter.h"
#include <cstddef>
#include <cstdint>
#include <cstring>

#define RNBO_NOSTL
#define RNBO_NOTHROW
#define RNBO_USE_FLOAT32
#define RNBO_FIXEDLISTSIZE 64
#define RNBO_USECUSTOMALLOCATOR
#define RNBO_USECUSTOMPLATFORMPRINT

#define MLR_RNBO_ALLOCATION_FAILURE() do { __disable_irq(); while(true) {} } while(false)
#include "rnbo_allocator.h"
#include "generated/rnbo_source.h"
#include "kick_cv.h"
namespace RNBO { namespace Platform {
static void printMessage(const char*) {}
static void printErrorMessage(const char*) {}
} }

static constexpr size_t block_size = 48;
static constexpr float sample_rate = 48000.f;
static daisy::dpt::DPT hardware;
static RNBO::rnbomatic<> synth;
static daisy::CpuLoadMeter cpu;
static KickCV::State cv;
static RNBO::ParameterIndex cv_parameters[8];
volatile float rnbo_cv_raw[8]={};
volatile float rnbo_cv_position[8]={};
// Inspect these through ST-Link after flashing and triggering; no fabricated estimates.
volatile float rnbo_cpu_average = 0.f;
volatile float rnbo_cpu_peak = 0.f;
volatile uint32_t rnbo_hit_count = 0;
volatile uint32_t rnbo_block_faults = 0;

static void Audio(daisy::AudioHandle::InputBuffer, daisy::AudioHandle::OutputBuffer out, size_t size) {
    cpu.OnBlockStart();
    if(size != block_size) {
        for(size_t ch=0; ch<2; ++ch) for(size_t i=0;i<size;++i) out[ch][i]=0.f;
        ++rnbo_block_faults;
    } else {
        hardware.ProcessAnalogControls();
        float readings[8];
        for(unsigned i=0;i<8;++i){readings[i]=hardware.GetAdcValue(daisy::dpt::CV_1+i);rnbo_cv_raw[i]=readings[i];}
        cv.sample(readings);
        for(unsigned i=0;i<8;++i)rnbo_cv_position[i]=cv.positions[i];
        hardware.ProcessDigitalControls();
        if(hardware.gate_in_1_trig) {
            KickCV::apply(synth,cv_parameters,cv);
            synth.processBangMessage(RNBO::TAG("hit"), RNBO::TAG(""), RNBO::TimeNow);
            ++rnbo_hit_count;
        }
        synth.process(nullptr, 0, out, 2, size);
        for(size_t ch=0; ch<2; ++ch) for(size_t i=0;i<size;++i) out[ch][i] *= 0.5f;
    }
    cpu.OnBlockEnd();
    rnbo_cpu_average = cpu.GetAvgCpuLoad(); rnbo_cpu_peak = cpu.GetMaxCpuLoad();
}
int main() {
    hardware.Init();
    hardware.SetAudioSampleRate(daisy::SaiHandle::Config::SampleRate::SAI_48KHZ);
    hardware.SetAudioBlockSize(block_size);
    synth.initialize();
    synth.prepareToProcess(sample_rate, block_size, true);
    if(synth.getNumInputChannels()!=0 || synth.getNumOutputChannels()!=2) return 1;
    if(!KickCV::resolve(synth,cv_parameters)) return 2;
    // Prime initialization events before prohibiting any further allocations.
    RNBO::SampleValue left[block_size]={},right[block_size]={};
    RNBO::SampleValue* buffers[]={left,right};
    synth.process(nullptr,0,buffers,2,block_size);
    rnbo_pool_sealed=true;
    cpu.Init(sample_rate,block_size);
    hardware.StartAudio(Audio);
    while(true) daisy::System::Delay(10);
}
