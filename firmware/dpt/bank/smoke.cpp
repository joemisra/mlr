#include <cstdlib>
#include <initializer_list>
#include <cstdio>
#include <cmath>
#define RNBO_NOSTL
#define RNBO_NOTHROW
#define RNBO_USE_FLOAT32
#define RNBO_FIXEDLISTSIZE 64
#define RNBO_USECUSTOMALLOCATOR
#define MLR_RNBO_POOL_SIZE 131072
#define MLR_RNBO_ALLOCATION_FAILURE() std::abort()
#include "../rnbo_allocator.h"
#include "generated/rnbo_source.h"
#include "midi_state.h"
int main(){
 // Verify the float32 portability shim preserves the original exact integer sequence.
 for(uint32_t initial : {12344u,23455u,34566u}){uint32_t state=initial;for(unsigned i=0;i<100000;++i){uint32_t expected=uint32_t((uint64_t(state+1u)*16807u)%2147483647u)-1u;state=mlr_dpt_noise_next(state);if(state!=expected)return 8;}}
 RNBO::rnbomatic<> synth;synth.initialize();synth.prepareToProcess(48000,48,true);
 if(synth.getNumInputChannels()!=0||synth.getNumOutputChannels()!=8)return 1;
 RNBO::ParameterIndex indices[8][12];RNBO::MessageTag tags[8];
 for(unsigned v=0;v<8;++v){
  char tag[32];std::snprintf(tag,sizeof(tag),"hit_%s",Bank::names[v]);tags[v]=RNBO::TAG(tag);
  bool hit_found=false;for(RNBO::MessageIndex m=0;m<synth.getNumMessages();++m)if(std::strcmp(synth.getMessageInfo(m).tag,tag)==0)hit_found=true;
  if(!hit_found)return 2;
  for(unsigned p=0;p<12;++p){bool found=false;for(RNBO::ParameterIndex i=0;i<synth.getNumParameters();++i)if(std::strcmp(synth.getParameterId(i),Bank::parameters[v][p].id)==0){indices[v][p]=i;found=true;break;}if(!found){std::printf("Missing %s\n",Bank::parameters[v][p].id);return 3;}}
 }
 RNBO::SampleValue buffers[8][48]={};RNBO::SampleValue* out[8];for(unsigned v=0;v<8;++v)out[v]=buffers[v];
 synth.process(nullptr,0,out,8,48);rnbo_pool_sealed=true;
 for(auto& channel:buffers)for(auto value:channel)if(value!=0)return 4;
 Bank::Controls controls;
 auto hit=[&](unsigned v,const float* params){for(unsigned p=0;p<12;++p)synth.setParameterValue(indices[v][p],params[p],RNBO::TimeNow);synth.processBangMessage(tags[v],RNBO::TAG(""),RNBO::TimeNow);};
 double energy[8]={},peak[8]={};
 for(unsigned v=0;v<8;++v){
  controls.accept({0x90,uint8_t(v),48,100},hit);
  synth.process(nullptr,0,out,8,48);
  // Voices not yet triggered must remain silent on their dedicated outputs.
  for(unsigned other=v+1;other<8;++other)for(auto value:buffers[other])if(value!=0)return 5;
 }
 // Simultaneous tails and repeated MIDI/CC traffic with the allocation arena sealed.
 for(unsigned block=0;block<8000;++block){
  if(block%250==0)for(unsigned v=0;v<8;++v){controls.accept({0xB0,uint8_t(v),20,uint8_t((block/250*13)%128)},hit);controls.accept({0x90,uint8_t(v),uint8_t(24+block/250),100},hit);}
  synth.process(nullptr,0,out,8,48);
  for(unsigned v=0;v<8;++v)for(auto value:buffers[v]){if(!std::isfinite(value))return 6;energy[v]+=value*value;peak[v]=std::fmax(peak[v],std::fabs(value));}
 }
 for(unsigned v=0;v<8;++v){std::printf("%s energy=%.3f peak=%.6f\n",Bank::names[v],energy[v],peak[v]);if(energy[v]<.01||peak[v]>4.1)return 7;}
 std::printf("Eight exported voices passed; host arena %zu / %zu bytes; no runtime allocations\n",size_t(rnbo_pool_used),sizeof(rnbo_pool));
}
