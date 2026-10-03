#pragma once
#include "bank_parameters.h"
#include <cmath>
#include <cstdint>
namespace Bank {
struct Event { uint8_t type,channel,a,b; float values[12]{}; }; // types 0x90 and 0xB0; channels zero-based
struct Controls {
 float values[8][12];
 Controls(){for(unsigned v=0;v<8;++v)for(unsigned p=0;p<12;++p)values[v][p]=parameters[v][p].initial;}
 static float map(unsigned voice,unsigned param,unsigned value) {
  const auto& p=parameters[voice][param];float n=value/127.f;
  if(p.curve==2)return p.lo*std::pow(p.hi/p.lo,n);
  if(p.curve==1)n*=n;
  return p.lo+(p.hi-p.lo)*n;
 }
 // Run exclusively in the audio callback; parsing/queueing lives in the foreground.
 template<class Hit> void accept(Event e,Hit hit) {
  if(e.channel>=8||e.a>127||e.b>127)return;
  if(e.type==0xF1){if(e.a<12)values[e.channel][e.a]=e.values[0];return;}
  if(e.type==0xF3){for(unsigned p=0;p<12;++p)values[e.channel][p]=e.values[p];return;}
  if(e.type==0xF2){hit(e.channel,e.values);return;}
  if(e.type==0xB0){if(e.a>=20&&e.a<=31)values[e.channel][e.a-20]=map(e.channel,e.a-20,e.b);return;}
  if(e.type!=0x90||e.b==0)return;
  float snapshot[12];for(unsigned p=0;p<12;++p)snapshot[p]=values[e.channel][p];
  if(e.channel==7)snapshot[0]=e.a<12?12:e.a>96?96:e.a;
  snapshot[11]*=e.b/127.f;
  hit(e.channel,snapshot);
 }
};
}
