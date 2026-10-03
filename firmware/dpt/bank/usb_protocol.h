#pragma once
#include "midi_state.h"
#include "physical_ranges.h"
namespace Bank {
// Non-commercial SysEx: 7D 'MLR' version=1, command, zero-based voice.
// Command 1: parameter index + 21-bit physical value. Command 2: 12-value hit.
inline bool decodeLab(const uint8_t* d,unsigned size,Event& e){
 if(size<7||d[0]!=125||d[1]!=77||d[2]!=76||d[3]!=82||d[4]!=1||d[6]>=8)return false;
 for(unsigned i=0;i<size;++i)if(d[i]>127)return false;
 if((d[5]==1&&(size!=11||d[7]>=12))||((d[5]==2||d[5]==3)&&size!=43)||(d[5]!=1&&d[5]!=2&&d[5]!=3))return false;
 e={};e.channel=d[6];e.type=uint8_t(0xF0+d[5]);e.a=d[5]==1?d[7]:0;
 unsigned count=d[5]==1?1:12,start=d[5]==1?8:7;
 for(unsigned i=0;i<count;++i){unsigned p=d[5]==1?e.a:i,j=start+3*i;
  uint32_t n=uint32_t(d[j])*16384u+uint32_t(d[j+1])*128u+d[j+2];
  e.values[i]=physicalRanges[e.channel][p][0]+(physicalRanges[e.channel][p][1]-physicalRanges[e.channel][p][0])*(float(n)/2097151.f);
 }
 return true;
}
}
