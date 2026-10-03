const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs');
const {engines}=require('../synth_engine_catalog');
const read=f=>JSON.parse(fs.readFileSync(require('node:path').join(__dirname,'..',f))).patcher;
const box=(p,id)=>p.boxes.find(b=>b.box.id===id).box;
const wired=(p,a,b,o=0,i=0)=>p.lines.some(l=>JSON.stringify(l.patchline.source)===JSON.stringify([a,o])&&JSON.stringify(l.patchline.destination)===JSON.stringify([b,i]));
function voice(e,rate=48000){
 const source=fs.readFileSync(require('node:path').join(__dirname,'../rnbo_'+e.id+'_voice.genexpr'),'utf8');
 const states=[...source.matchAll(/@state (.*);/g)].map(m=>'let '+m[1]+';').join('\n');
 return new Function('rate',`const {exp,sin,tan,tanh,floor,pow,abs}=Math; const minimum=Math.min,maximum=Math.max;
 const wrap=(v,lo,hi)=>v-Math.floor((v-lo)/(hi-lo))*(hi-lo),clamp=(v,lo,hi)=>minimum(hi,maximum(lo,v)),samplerate=()=>rate;
 ${states}
 return (in1,p)=>{let out1=0;${e.parameters.map((p,i)=>`const in${i+2}=p.${p.rnbo};`).join('\n')}
 ${source.replace(/@state .*;/g,'')}
 return out1;};`)(rate);
}
for(const e of engines){
 test(e.name+' schema, presets and native packet wiring agree',()=>{
  const m=require('../'+e.id+'_instrument_model'),p=read('rnbo_'+e.id+'.maxpat'),rnbo=box(p,'obj-rnbo').patcher;
  assert.equal(new Set(e.parameters.map(p=>p.id)).size,12);
  assert.deepEqual(m[e.id.toUpperCase()+'_PAGES'].flatMap(p=>p.parameters).sort(),e.parameters.map(p=>p.id).sort());
  e.parameters.forEach((d,i)=>{
   assert.equal(m.fromNormalized(d.id,0),d.gridMin);assert.equal(m.fromNormalized(d.id,1),d.gridMax);
   assert.ok(wired(rnbo,'rnbo-param-'+d.rnbo,'rnbo-voice',0,i+1));
   assert.ok(wired(p,e.id+'-step-unpack',e.id+'-cache',i,i));
   assert.ok(wired(p,e.id+'-route',e.id+'-cache',i,i));
   assert.ok(wired(p,'control-'+d.rnbo,'control-'+d.rnbo+'-pre'));
   assert.ok(wired(p,'control-'+d.rnbo+'-pre',e.id+'-manual'));
   assert.equal(box(p,'control-'+d.rnbo+'-set').text,'prepend set');
   assert.equal(box(p,'control-'+d.rnbo).minimum,d.min);
   assert.equal(box(p,'control-'+d.rnbo).maximum,d.max);
   for(const preset of e.presets){const v=preset.values[d.rnbo]??d.initial;assert.ok(v>=d.min&&v<=d.max);}
  });
  assert.ok(wired(p,e.id+'-fire',e.id+'-values',1));
  assert.ok(wired(p,e.id+'-fire','obj-rnbo'));
  assert.ok(wired(p,e.id+'-cache',e.id+'-values',0,1));
  assert.equal(box(p,'obj-trackreceive').text,'r '+(e.track+2)+'input');
  const presetTargets=p.lines.filter(l=>l.patchline.source[0]==='range-presets').map(l=>l.patchline.destination[0]).sort();
  assert.deepEqual(presetTargets,e.parameters.flatMap(d=>[d.id+'-min',d.id+'-max']).sort());
  const dsp=box(read('rnbo_'+e.id+'_voice.rnbopat'),'obj-dsp');assert.equal(dsp.code,fs.readFileSync(require('node:path').join(__dirname,'../rnbo_'+e.id+'_voice.genexpr'),'utf8').trimEnd());
  const bridge=read('sequence64_audio_bridge.maxpat');assert.equal(box(bridge,e.id+'-route').text,'route '+(e.track+2));assert.ok(wired(bridge,'obj-actiontrigger',e.id+'-group',3));
 });
 test(e.name+' equations stay finite at bounds and capture controls per hit',()=>{
  const params=edge=>Object.fromEntries(e.parameters.map(p=>[p.rnbo,p[edge]]));
  for(const rate of [44100,48000,96000])for(const edge of ['min','initial','max']){
   const step=voice(e,rate),p=params(edge);let energy=0;assert.equal(step(0,p),0);
   for(let i=0;i<rate*.3;i++){const x=step(i===0?1:0,p);assert.ok(Number.isFinite(x));assert.ok(Math.abs(x)<=p.level/Math.tanh(p.drive)+1e-9);energy+=x*x;}
   if(edge==='initial')assert.ok(energy>.01);
  }
  const a=voice(e),b=voice(e),p=params('initial'),changed=params('max');let tail=0;
  for(let i=0;i<48000*8;i++){const x=a(i===0?1:0,p),y=b(i===0?1:0,i===0?p:changed);assert.equal(x,y);if(i>48000*7.9)tail=Math.max(tail,Math.abs(x));}
  assert.ok(tail<1e-7);
 });
}
test('external eight-voice mode reserves the upper bank separately',()=>{
 const p=read('rnbo_drum_outputs.maxpat');assert.equal(box(p,'mode-enabled').text,'> 0');assert.equal(box(p,'upper-enabled').text,'== 2');
 assert.ok(wired(p,'mode-clip','mode-enabled'));assert.ok(wired(p,'mode-enabled','mode-signal'));assert.ok(wired(p,'mode-clip','upper-enabled'));assert.ok(wired(p,'upper-enabled','upper-signal'));
 engines.forEach((e,i)=>{assert.ok(wired(p,e.id+'-gain','dac',0,i+4));assert.ok(wired(p,'upper-gain',e.id+'-gain',0,1));assert.equal(box(read('rnbo_'+e.id+'.maxpat'),'route-reserve').text,'r~ mlr_synth_es9_active');});
 const cv=read('mlr_cv_outputs.maxpat');assert.ok(wired(cv,'obj-config-sig','synth-cv-level'));assert.ok(wired(cv,'synth-cv-free','synth-cv-level',0,1));
});
