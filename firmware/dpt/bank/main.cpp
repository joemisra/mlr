#include "daisy_dpt.h"
#include "util/CpuLoadMeter.h"
#define RNBO_NOSTL
#define RNBO_NOTHROW
#define RNBO_USE_FLOAT32
#define RNBO_FIXEDLISTSIZE 64
#define RNBO_USECUSTOMALLOCATOR
#define RNBO_USECUSTOMPLATFORMPRINT
#define MLR_RNBO_POOL_SIZE 131072
#define MLR_RNBO_POOL_ATTRIBUTE __attribute__((section(".rnbo_arena")))
#define MLR_RNBO_ALLOCATION_FAILURE() do { __disable_irq(); while(true) {} } while(false)
#include "../rnbo_allocator.h"
#include "generated/rnbo_source.h"
#include "channel_knobs.h"
#include "midi_queue.h"
#include "usb_protocol.h"
namespace RNBO { namespace Platform { static void printMessage(const char*) {} static void printErrorMessage(const char*) {} } }
static daisy::dpt::DPT hardware;
static RNBO::rnbomatic<> synth;
static daisy::CpuLoadMeter cpu;
static uint32_t block_budget_ticks;
static Bank::Controls controls;
static Bank::Queue incoming __attribute__((section(".rnbo_arena")));
static Bank::ChannelKnobs knobs;
static daisy::GPIO usb_vbus;
static RNBO::ParameterIndex indices[8][12];
static RNBO::MessageTag hits[8];
static RNBO::SampleValue samples[8][48];
static RNBO::SampleValue* outputs[8]={samples[0],samples[1],samples[2],samples[3],samples[4],samples[5],samples[6],samples[7]};
// Debugger-visible startup progress: 1 main, 2 hardware, 3 initialize,
// 4 prepare, 5 resolve, 6 prime, 7 MIDI, 8 audio started; 0xE1 bad export.
volatile uint32_t rnbo_startup_stage=0,rnbo_audio_blocks=0,rnbo_midi_notes_received=0;
volatile uint32_t rnbo_audio_overruns=0,rnbo_midi_ignored=0,rnbo_usb_events=0,rnbo_usb_invalid=0,rnbo_usb_ready=0;
volatile float rnbo_cpu_average=0,rnbo_cpu_peak=0;
volatile uint32_t rnbo_midi_dropped=0,rnbo_hits[8]={},rnbo_block_faults=0;
static bool Resolve() {
 const char* tags[]={"hit_kick","hit_snare","hit_hat","hit_clap","hit_tom","hit_rim","hit_bell","hit_bass"};
 for(unsigned v=0;v<8;++v){
  hits[v]=RNBO::TAG(tags[v]);bool has_hit=false;
  for(RNBO::MessageIndex m=0;m<synth.getNumMessages();++m)if(std::strcmp(synth.getMessageInfo(m).tag,tags[v])==0)has_hit=true;
  if(!has_hit)return false;
  for(unsigned p=0;p<12;++p){bool found=false;
   for(RNBO::ParameterIndex i=0;i<synth.getNumParameters();++i)if(std::strcmp(synth.getParameterId(i),Bank::parameters[v][p].id)==0){indices[v][p]=i;found=true;break;}
   if(!found)return false;
  }
 }
 return true;
}
static void Hit(unsigned voice,const float* values) {
 for(unsigned p=0;p<12;++p)synth.setParameterValue(indices[voice][p],values[p],RNBO::TimeNow);
 synth.processBangMessage(hits[voice],RNBO::TAG(""),RNBO::TimeNow);++rnbo_hits[voice];
}
static void Audio(daisy::AudioHandle::InputBuffer,daisy::AudioHandle::OutputBuffer out,size_t size) {
 const uint32_t started=daisy::System::GetTick();
 ++rnbo_audio_blocks;
 cpu.OnBlockStart();
 if(size!=48){for(unsigned c=0;c<2;++c)for(size_t i=0;i<size;++i)out[c][i]=0;++rnbo_block_faults;}
 else {
  hardware.ProcessAnalogControls();float raw[8];for(unsigned i=0;i<8;++i)raw[i]=Bank::ChannelKnobs::position(hardware.GetAdcValue(daisy::dpt::CV_1+i));
  Bank::Event event;for(unsigned n=0;n<32&&incoming.pop(event);++n)controls.accept(event,Hit);
  hardware.ProcessDigitalControls();
  if(hardware.gate_in_1_trig)Hit(0,controls.values[0]);
  // Gate 2 uses the current snare baseline at full velocity; release leaves its tail alone.
  if(hardware.gate_in_2_trig)Hit(1,controls.values[1]);
  synth.process(nullptr,0,outputs,8,48);
  for(unsigned i=0;i<48;++i){float mix=0;for(unsigned v=0;v<8;++v)mix+=knobs.process(v,samples[v][i],raw[v])*0.25f;mix=std::isfinite(mix)?(mix>1?1:mix< -1?-1:mix):0;out[0][i]=out[1][i]=mix;}
 }
 cpu.OnBlockEnd();if(uint32_t(daisy::System::GetTick()-started)>block_budget_ticks)++rnbo_audio_overruns;rnbo_cpu_average=cpu.GetAvgCpuLoad();rnbo_cpu_peak=cpu.GetMaxCpuLoad();
}
int main(){
 incoming.write.store(0);incoming.read.store(0);
 rnbo_startup_stage=1;
 hardware.Init();rnbo_startup_stage=2;hardware.SetAudioSampleRate(daisy::SaiHandle::Config::SampleRate::SAI_48KHZ);hardware.SetAudioBlockSize(48);
 synth.initialize();rnbo_startup_stage=3;
 synth.prepareToProcess(48000,48,true);rnbo_startup_stage=4;
 if(synth.getNumInputChannels()!=0||synth.getNumOutputChannels()!=8||!Resolve()){rnbo_startup_stage=0xE1;while(true){}}
 rnbo_startup_stage=5;
 synth.process(nullptr,0,outputs,8,48);rnbo_pool_sealed=true;rnbo_startup_stage=6;
 usb_vbus.Init(daisy::Pin(daisy::PORTA,9),daisy::GPIO::Mode::INPUT,daisy::GPIO::Pull::NOPULL);
 hardware.midi.StartReceive();rnbo_startup_stage=7;cpu.Init(48000,48);block_budget_ticks=daisy::System::GetTickFreq()/1000;hardware.StartAudio(Audio);
 rnbo_startup_stage=8;
 bool midi_gate=false;uint32_t midi_gate_started=0;
 while(true){
  // The old USB HAL can stall while resetting an unpowered USB PHY.
  // Keep gates/UART/audio running when the host cable is absent.
  if(!rnbo_usb_ready&&usb_vbus.Read()){
   daisy::MidiUsbHandler::Config usb_config;
   usb_config.transport_config.periph=daisy::MidiUsbTransport::Config::INTERNAL;
   hardware.usb_midi.Init(usb_config);hardware.usb_midi.StartReceive();rnbo_usb_ready=1;
  }
  if(midi_gate&&uint32_t(daisy::System::GetNow()-midi_gate_started)>=10){
   dsy_gpio_write(&hardware.gate_out_1,false);midi_gate=false;
  }
  for(unsigned source=0;source<2;++source){
  if(source==1&&!rnbo_usb_ready)continue;
  if(source==0)hardware.midi.Listen();else hardware.usb_midi.Listen();
  while(source==0?hardware.midi.HasEvents():hardware.usb_midi.HasEvents()){
   auto m=source==0?hardware.midi.PopEvent():hardware.usb_midi.PopEvent();
   if(source==1)++rnbo_usb_events;
   if(m.type==daisy::SystemCommon&&m.sc_type==daisy::SystemExclusive){
    Bank::Event e{};
    if(Bank::decodeLab(m.sysex_data,m.sysex_message_len,e)){
     if(!incoming.push(e))++rnbo_midi_dropped;
     if(e.type==0xF2){midi_gate_started=daisy::System::GetNow();midi_gate=true;dsy_gpio_write(&hardware.gate_out_1,true);}
    }else ++rnbo_usb_invalid;
    continue;
   }
   // Reception diagnostic on every channel, independent of voice routing.
   // Repeated notes extend the 10 ms pulse; zero-velocity Note On is ignored.
   if(m.type==daisy::NoteOn&&m.data[1]>0){
    ++rnbo_midi_notes_received;midi_gate_started=daisy::System::GetNow();
    midi_gate=true;dsy_gpio_write(&hardware.gate_out_1,true);
   }
   if(m.channel<8&&((m.type==daisy::NoteOn&&m.data[1]>0)||(m.type==daisy::ControlChange&&m.data[0]>=20&&m.data[0]<=31))){
    Bank::Event e={uint8_t(m.type==daisy::NoteOn?0x90:0xB0),uint8_t(m.channel),m.data[0],m.data[1]};
    if(!incoming.push(e))++rnbo_midi_dropped;
   }else ++rnbo_midi_ignored;
  }
  }
 }
}
