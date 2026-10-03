// Run the actual exported RNBO code on the host before putting it on DPT.
#define RNBO_USE_FLOAT32
#define RNBO_NOSTL
#define RNBO_NOTHROW
#define RNBO_FIXEDLISTSIZE 64
#define RNBO_USECUSTOMALLOCATOR
#include <cstdlib>
#define MLR_RNBO_ALLOCATION_FAILURE() std::abort()
#include "rnbo_allocator.h"
#include "generated/rnbo_source.h"
#include "kick_cv.h"
#include <cmath>
#include <cstdio>
#include <cstring>
int main() {
 RNBO::rnbomatic<> synth;
 synth.initialize(); synth.prepareToProcess(48000,48,true);
 if(synth.getNumInputChannels()!=0 || synth.getNumOutputChannels()!=2) return 1;
 bool hit=false;
 for(RNBO::MessageIndex i=0;i<synth.getNumMessages();++i) if(std::strcmp(synth.getMessageInfo(i).tag,"hit")==0) hit=true;
 if(!hit) return 2;
 RNBO::SampleValue left[48]={},right[48]={}; RNBO::SampleValue* outputs[]={left,right};
 synth.process(nullptr,0,outputs,2,48);
 for(int i=0;i<48;i++) if(left[i]!=0 || right[i]!=0)return 3;
 rnbo_pool_sealed=true;
 synth.processBangMessage(RNBO::TAG("hit"),RNBO::TAG(""),RNBO::TimeNow);
 double energy=0,peak=0,tail=0;
 for(int block=0;block<4000;block++) {
  synth.process(nullptr,0,outputs,2,48);
  for(int i=0;i<48;i++) {
   if(!std::isfinite(left[i])||left[i]!=right[i])return 4;
   energy+=left[i]*left[i]; peak=std::fmax(peak,std::fabs(left[i]));
   if(block>=3900)tail=std::fmax(tail,std::fabs(left[i]));
  }
 }
 std::printf("Startup arena: %zu / 32768 bytes; no allocations after seal\n",size_t(rnbo_pool_used));
 std::printf("RNBO export: energy=%.6f peak=%.6f tail=%.9f\n",energy,peak,tail);
 if(!(energy>0.01 && peak<2 && tail<0.00001))return 5;
 RNBO::ParameterIndex indices[8];
 if(!KickCV::resolve(synth,indices))return 6;
 if(KickCV::normalized(-2)!=0 || KickCV::normalized(0)!=0.5f || KickCV::normalized(2)!=1)return 7;
 const float test_positions[]={-1.f,0.f,1.f};
 for(float raw : test_positions) {
  KickCV::State controls;float readings[8];for(auto& v:readings)v=raw;controls.sample(readings);
  KickCV::apply(synth,indices,controls);
  for(unsigned i=0;i<8;++i) {
   const float expected=KickCV::value(i,(raw+1)*0.5f);
   if(std::fabs(synth.getParameterValue(indices[i])-expected)>0.0001f)return 8;
  }
  synth.processBangMessage(RNBO::TAG("hit"),RNBO::TAG(""),RNBO::TimeNow);
  double cv_energy=0;
  for(int block=0;block<250;++block){
   synth.process(nullptr,0,outputs,2,48);
   for(auto v:left){if(!std::isfinite(v))return 9;cv_energy+=v*v;}
  }
  if(cv_energy<0.00001)return 10;
 }
 KickCV::State smooth;float low[8]={-1,-1,-1,-1,-1,-1,-1,-1},high[8]={1,1,1,1,1,1,1,1};
 smooth.sample(low);smooth.sample(high);
 if(smooth.positions[0]<=0 || smooth.positions[0]>=1)return 11;
 for(int i=0;i<100;++i)smooth.sample(high);
 if(smooth.positions[0]<0.999f)return 12;
 std::puts("Eight CV mappings: endpoints, parameter IDs, smoothing and sealed-arena triggering passed");
 return 0;
}
