const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const model = require('../clap_instrument_model');
// Execute this scalar subset of codebox math as JS. This tests the equations,
// not RNBO compilation or the audio driver.
function voice(sr=48000,debug=false) {
 const source=fs.readFileSync(path.join(__dirname,'../rnbo_clap_voice.genexpr'),'utf8');
 const states=[...source.matchAll(/@state (.*);/g)].map(m=>'let '+m[1]+';').join('\n');
 const body=source.replace(/@state .*;/g,'');
 const names=['count','scatter','tailDecayMs','burstDecayMs','spacingMs','filterHz','balance','tailLevel','filterQ','brightness','drive','level'];
 return new Function('sr', `const {exp,sin,tan,tanh,floor}=Math;
 const minimum=Math.min, maximum=Math.max;
 const wrap=(v,lo,hi)=>v-Math.floor((v-lo)/(hi-lo))*(hi-lo);
 const clamp=(v,lo,hi)=>minimum(hi,maximum(lo,v));
 const samplerate=()=>sr;
 ${states}
 return (trigger,params)=>{let out1=0; const in1=trigger;
 ${names.map((name,i)=>`const in${i+2}=params.${name};`).join('\n')}
 ${body}
 return ${debug ? "{sample:out1,pulse:burstPulse,tail:tailEnv}" : "out1"};};`)(sr);
}
function params(edge) {
 return Object.fromEntries(model.CLAP_LOCKS.map(id=>{
  const d=model.definition(id);return [d.rnbo,d[edge||'initial']];
 }));
}
test('clap DSP produces a finite bounded signal at default and extreme controls',()=>{
 for(const sr of [44100,48000,96000])for(const edge of ['initial','min','max']) {
  const step=voice(sr),p=params(edge);let energy=0;
  for(let i=0;i<sr*1.2;i++){
   const sample=step(i===0?1:0,p);
   assert.ok(Number.isFinite(sample));
   assert.ok(Math.abs(sample)<=p.level/Math.tanh(p.drive)+1e-10);
   energy+=sample*sample;
  }
  if(edge!=='min') assert.ok(energy>0.01);
 }
});
test('clap tails decay and edits between hits do not change the captured sound',()=>{
 const a=voice(),b=voice(),p=params(),changed=params('max');let tail=0;
 for(let i=0;i<96000;i++){
  const x=a(i===0?1:0,p),y=b(i===0?1:0,i===0?p:changed);
  assert.equal(x,y);
  if(i>95000)tail=Math.max(tail,Math.abs(x));
 }
 assert.ok(tail<1e-8);
 assert.notEqual(a(1,p),b(1,changed));
});

test('clap emits the chosen burst count at sample-accurate intervals and starts tail on the last burst',()=>{
 for(const sr of [44100,48000,96000])for(const count of [1,3,8]){
  const step=voice(sr,true),p={...params(),count,spacingMs:10,scatter:0},events=[];
  for(let i=0;i<sr*.09;i++){
   const s=step(i===0?1:0,p);
   if(s.pulse)events.push(i);
   if(i<(count-1)*sr*.01)assert.equal(s.tail,0);
  }
  assert.deepEqual(events,Array.from({length:count},(_,i)=>i*Math.round(sr*.01)));
 }
});
test('scatter stays within ±45 percent and retrigger cancels pending bursts',()=>{
 const step=voice(48000,true),p={...params(),count:8,spacingMs:10,scatter:1},events=[];
 for(let i=0;i<6000;i++)if(step(i===0?1:0,p).pulse)events.push(i);
 assert.equal(events.length,8);
 const gaps=events.slice(1).map((n,i)=>n-events[i]);
 assert.ok(new Set(gaps).size>1);
 for(const gap of gaps)assert.ok(gap>=264&&gap<=696);
 const other=voice(48000,true);other(1,p);
 for(let i=0;i<100;i++)other(0,p);
 other(1,{...p,count:1});
 for(let i=0;i<6000;i++)assert.equal(other(0,p).pulse,0);
});
