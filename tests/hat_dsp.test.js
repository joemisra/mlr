const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const model = require('../hat_instrument_model');
// Execute this scalar subset of codebox math as JS. This tests the equations,
// not RNBO compilation or the audio driver.
function voice(sr=48000) {
 const source=fs.readFileSync(path.join(__dirname,'../rnbo_hat_voice.genexpr'),'utf8');
 const states=[...source.matchAll(/@state (.*);/g)].map(m=>'let '+m[1]+';').join('\n');
 const body=source.replace(/@state .*;/g,'');
 const names=['metalHz','inharmonicity','noiseDecayMs','decayMs','spread','filterHz','metalLevel','noiseLevel','filterQ','attack','drive','level'];
 return new Function('sr', `const {exp,sin,tan,tanh}=Math;
 const minimum=Math.min, maximum=Math.max;
 const wrap=(v,lo,hi)=>v-Math.floor((v-lo)/(hi-lo))*(hi-lo);
 const clamp=(v,lo,hi)=>minimum(hi,maximum(lo,v));
 const samplerate=()=>sr;
 ${states}
 return (trigger,params)=>{let out1=0; const in1=trigger;
 ${names.map((name,i)=>`const in${i+2}=params.${name};`).join('\n')}
 ${body}
 return out1;};`)(sr);
}
function params(edge) {
 return Object.fromEntries(model.HAT_LOCKS.map(id=>{
  const d=model.definition(id);return [d.rnbo,d[edge||'initial']];
 }));
}
test('hat DSP produces a finite bounded signal at default and extreme controls',()=>{
 for(const sr of [44100,48000,96000])for(const edge of ['initial','min','max']) {
  const step=voice(sr),p=params(edge);let energy=0;
  for(let i=0;i<sr/4;i++){
   const sample=step(i===0?1:0,p);
   assert.ok(Number.isFinite(sample));
   assert.ok(Math.abs(sample)<=p.level/Math.tanh(p.drive)+1e-10);
   energy+=sample*sample;
  }
  if(edge!=='min') assert.ok(energy>0.01);
 }
});
test('hat tails decay and edits between hits do not change the captured sound',()=>{
 const a=voice(),b=voice(),p=params(),changed=params('max');let tail=0;
 for(let i=0;i<48000;i++){
  const x=a(i===0?1:0,p),y=b(i===0?1:0,i===0?p:changed);
  assert.equal(x,y);
  if(i>47000)tail=Math.max(tail,Math.abs(x));
 }
 assert.ok(tail<1e-8);
 assert.notEqual(a(1,p),b(1,changed));
});
