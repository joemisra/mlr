#pragma once
#include <cmath>
#include <cstring>
// Physical ranges match instrument_model.js default grid spans.
namespace KickCV {
struct Mapping { const char* name; float minimum, maximum; enum Curve { Linear, Square, Log } curve; };
static constexpr Mapping mappings[8] = {
 {"baseHz",20,120,Mapping::Log}, {"ampDecayMs",20,2000,Mapping::Log},
 {"fmIndex",0,4,Mapping::Square}, {"drive",0.25f,8,Mapping::Log},
 {"pitchAmount",0,600,Mapping::Square}, {"pitchDecayMs",1,300,Mapping::Log},
 {"fmRatio",0.125f,8,Mapping::Log}, {"resonMix",0,1,Mapping::Linear}
};
inline float normalized(float bipolar) {
 if(!std::isfinite(bipolar))return 0.5f;
 const float n=(bipolar+1.f)*0.5f;
 return n<0?0:n>1?1:n;
}
inline float value(unsigned index,float n) {
 n=n<0?0:n>1?1:n;
 const auto& m=mappings[index];
 if(m.curve==Mapping::Log)return m.minimum*std::pow(m.maximum/m.minimum,n);
 if(m.curve==Mapping::Square)n*=n;
 return m.minimum+(m.maximum-m.minimum)*n;
}
struct State {
 float positions[8]={}; bool primed=false;
 // Called at 1 kHz: approximately 5 ms of smoothing, no additional startup sweep.
 void sample(const float* bipolar) {
  for(unsigned i=0;i<8;++i){float n=normalized(bipolar[i]);positions[i]=primed?positions[i]+0.18126925f*(n-positions[i]):n;}
  primed=true;
 }
};
template<class Synth> bool resolve(Synth& synth, RNBO::ParameterIndex* indices) {
 for(unsigned i=0;i<8;++i){
  bool found=false;
  for(RNBO::ParameterIndex p=0;p<synth.getNumParameters();++p)
   if(std::strcmp(synth.getParameterId(p),mappings[i].name)==0){indices[i]=p;found=true;break;}
  if(!found)return false;
 }
 return true;
}
template<class Synth> void apply(Synth& synth,const RNBO::ParameterIndex* indices,const State& state) {
 for(unsigned i=0;i<8;++i)synth.setParameterValue(indices[i],value(i,state.positions[i]),RNBO::TimeNow);
}
}
