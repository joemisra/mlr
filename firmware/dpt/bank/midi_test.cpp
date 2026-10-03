#include "midi_queue.h"
#include "channel_knobs.h"
#include "usb_protocol.h"
#include <cassert>
#include <cmath>
#include <cstdio>
int main(){
 using K=Bank::ChannelKnobs;
 assert(K::position(-2)==0&&K::position(2)==1&&K::position(0)==0.5f);
 assert(K::level(0)==0&&K::level(.75f)==1&&K::level(1)==1);
 assert(K::saturation(.75f)==1&&K::saturation(1)==4);
 K k;
 for(unsigned v=0;v<8;++v){
  float y=0;for(unsigned i=0;i<48000;++i)y=k.process(v,.1f,.75f);
  assert(std::fabs(y-.1f)<.0001f);
  for(unsigned i=0;i<48000;++i)y=k.process(v,.1f,1);
  assert(y>.30f&&y<.31f);assert(std::fabs(k.process(v,-.1f,1)+y)<.0001f);
  for(unsigned i=0;i<48000;++i)y=k.process(v,.1f,0);
  assert(std::fabs(y)<.00001f);
 }
 Bank::Controls c;unsigned hits=0;float last[12]={};unsigned voice=99;
 auto hit=[&](unsigned v,const float* values){++hits;voice=v;for(unsigned p=0;p<12;++p)last[p]=values[p];};
 for(unsigned v=0;v<8;++v){
  c.accept({0xB0,uint8_t(v),20,127},hit);
  assert(std::fabs(c.values[v][0]-Bank::parameters[v][0].hi)<.001f);
  c.accept({0x90,uint8_t(v),48,64},hit);assert(voice==v);
  assert(std::fabs(last[11]-c.values[v][11]*64/127.f)<.0001f);
  if(v==7)assert(last[0]==48);
 }
 assert(hits==8);c.accept({0x90,0,36,0},hit);c.accept({0x90,8,36,127},hit);c.accept({0x80,0,36,127},hit);assert(hits==8);
 const float base=c.values[0][11];c.accept({0x90,0,36,1},hit);c.accept({0x90,0,36,127},hit);assert(last[11]==base);
 for(unsigned v=0;v<8;++v)for(unsigned p=0;p<12;++p){
  assert(std::fabs(Bank::Controls::map(v,p,0)-Bank::parameters[v][p].lo)<.001f);
  assert(std::fabs(Bank::Controls::map(v,p,127)-Bank::parameters[v][p].hi)<.001f);
 }
 Bank::Queue q;Bank::Event e;
 for(unsigned i=0;i<128;++i)assert(q.push({0x90,0,uint8_t(i),127}));
 assert(!q.push({0x90,0,0,127}));
 for(unsigned i=0;i<128;++i){assert(q.pop(e));assert(e.a==i);}assert(!q.pop(e));
 for(unsigned i=0;i<10000;++i){assert(q.push({0x90,0,60,127}));assert(q.pop(e));assert(e.a==60);}
 uint8_t packet[43]={125,77,76,82,1,2,7};
 for(unsigned i=7;i<43;++i)packet[i]=127;
 Bank::Event lab{};assert(Bank::decodeLab(packet,43,lab));
 const auto before=c.values[7][0];c.accept(lab,hit);assert(last[0]==Bank::physicalRanges[7][0][1]);assert(c.values[7][0]==before);
 packet[5]=3;assert(Bank::decodeLab(packet,43,lab));auto beforeHits=hits;c.accept(lab,hit);assert(hits==beforeHits);assert(c.values[7][0]==Bank::physicalRanges[7][0][1]);
 packet[5]=2;assert(!Bank::decodeLab(packet,42,lab));packet[6]=8;assert(!Bank::decodeLab(packet,43,lab));packet[6]=0;packet[10]=128;assert(!Bank::decodeLab(packet,43,lab));
 uint8_t edit[11]={125,77,76,82,1,1,0,0,0,0,0};assert(Bank::decodeLab(edit,11,lab));c.accept(lab,hit);assert(c.values[0][0]==Bank::physicalRanges[0][0][0]);
 std::puts("MIDI channels, CC ranges, velocity, note-off, bass pitch and FIFO checks passed");
}
