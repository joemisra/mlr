#pragma once
#include <cmath>
namespace Bank {
// Post-engine performance controls: retain presets, velocity and step locks.
// Position 0..0.75 fades to unity; 0.75..1 adds up to 4x soft drive.
struct ChannelKnobs {
 float gain[8]={}, drive[8]={};
 static float position(float raw) {
  if(!std::isfinite(raw))return 0;
  float n=(raw+1.f)*0.5f;
  return n<0?0:n>1?1:n;
 }
 static float level(float n) {float x=n/0.75f;return x>=1?1:x*x;}
 static float saturation(float n) {return n<=0.75f?1:1+12*(n-0.75f);}
 // Audio-rate smoothing also changes already-ringing tails without zipper noise.
 float process(unsigned voice,float sample,float n) {
  gain[voice]+=0.00041658f*(level(n)-gain[voice]);
  drive[voice]+=0.00041658f*(saturation(n)-drive[voice]);
  const float d=drive[voice]<1?1:drive[voice];
  const float x=std::isfinite(sample)?sample:0;
  return gain[voice]*x*d/(1+(d-1)*std::fabs(x));
 }
};
}
