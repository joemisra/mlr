const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const model = require('../clap_instrument_model');

const read = name => JSON.parse(fs.readFileSync(path.join(__dirname,'..',name),'utf8')).patcher;
const box = (patch,id) => patch.boxes.find(entry=>entry.box.id===id)?.box;
const wired = (patch,source,outlet,destination,inlet=0) => patch.lines.some(entry=>{
 const line=entry.patchline;
 return line.source[0]===source && line.source[1]===outlet && line.destination[0]===destination && line.destination[1]===inlet;
});

test('clap lab keeps stable RNBO audio ports and follows native Track 12 presses',()=>{
 const patch=read('rnbo_clap.maxpat'), engine=box(patch,'obj-rnbo');
 assert.deepEqual(engine.outletInfo.IOInfo.filter(port=>port.type==='signal').map(port=>port.index),[1,2]);
 assert.deepEqual(engine.outlettype.slice(0,2),['signal','signal']);
 assert.deepEqual(engine.inletInfo.IOInfo.map(port=>[port.type,port.index]),[['event',1]]);
 assert.equal(box(patch,'obj-trackreceive').text,'r 13input');
 assert.equal(box(patch,'obj-unpack').text,'unpack i i');
 assert.equal(box(patch,'obj-selectpress').text,'sel 1');
 assert.ok(wired(patch,'obj-trackreceive',0,'obj-unpack'));
 assert.ok(wired(patch,'obj-unpack',1,'obj-selectpress'));
 assert.ok(wired(patch,'obj-selectpress',0,'obj-trigger'));
 assert.equal(box(patch,'clap-step').text,'r rnbo_clap_step');
 assert.equal(box(patch,'clap-owned').text,'r rnbo_clap_owned_param');
 assert.ok(wired(patch,'clap-owned',0,'clap-route'));
 assert.ok(wired(patch,'clap-step',0,'clap-step-unpack'));
 assert.equal(box(patch,'obj-globaltrigger').text,'r rnbo_clap_trigger');
 assert.equal(box(patch,'clap-router').text,'s gridrouter');
 const audioLines=patch.lines.filter(entry=>entry.patchline.source[0]===engine.id && box(patch,entry.patchline.destination[0])?.text?.startsWith('*~'));
 assert.deepEqual(audioLines.map(entry=>entry.patchline.source[1]).sort(),[0,1]);
});

test('clap host fields and RNBO params match the twelve-control schema',()=>{
 const patch=read('rnbo_clap.maxpat'), engine=box(patch,'obj-rnbo');
 assert.equal(box(patch,'clap-route').text,'route '+model.CLAP_LOCKS.map(id=>model.definition(id).rnbo).join(' '));
 for(const id of model.CLAP_LOCKS){
  const def=model.definition(id), rnboId='rnbo-param-'+def.rnbo;
  const param=box(engine.patcher,rnboId);
  assert.ok(param,`missing ${rnboId}`);
  assert.ok(param.text.includes(`@min ${def.min} @max ${def.max}`));
  const control=box(patch,'control-'+def.rnbo);
  assert.equal(control.minimum,def.min); assert.equal(control.maximum,def.max);
  for(const edge of ['min','max']){
   const field=box(patch,`${id}-${edge}`);
   assert.equal(field.minimum,def.min); assert.equal(field.maximum,def.max);
  }
 }
 assert.equal(box(patch,'range-script').text,'v8 clap_lab_ranges.js');
});

test('clap cache flushes every latched control before a hit',()=>{
 const patch=read('rnbo_clap.maxpat'), core=read('rnbo_clap_voice.rnbopat');
 assert.equal(box(patch,'clap-fire').text,'t b b');
 assert.ok(wired(patch,'clap-fire',1,'clap-values'));
 assert.ok(wired(patch,'clap-values',0,'clap-unpack'));
 assert.ok(wired(patch,'clap-fire',0,'obj-rnbo'));
 assert.ok(wired(patch,'clap-cache',0,'clap-values',1));
 for(let index=0;index<12;index++){
  assert.ok(wired(patch,'clap-step-unpack',index,'clap-cache',index));
 }
 const dsp=box(core,'obj-dsp'), source=fs.readFileSync(path.join(__dirname,'..','rnbo_clap_voice.genexpr'),'utf8').trimEnd();
 assert.equal(dsp.code,dsp.rnbo_extra_attributes.code);
 assert.equal(dsp.code,source);
 assert.equal(dsp.numinlets,13);
 const hitBlock=dsp.code.match(/if \(trig > 0\) \{([\s\S]*?)\}/)[1];
 for(let inlet=2;inlet<=13;inlet++) assert.match(hitBlock,new RegExp(`= in${inlet};`));
 const tail=dsp.code.replace(/if \(trig > 0\) \{[\s\S]*?\}/,'');
 assert.doesNotMatch(tail,/\bin(?:[2-9]|1[0-3])\b/);
 assert.match(dsp.code,/let burstPulse =/);
 assert.match(dsp.code,/let high =/);
});

test('clap controls use silent cache feedback and the manual RNBO path',()=>{
 const patch=read('rnbo_clap.maxpat');
 for(const id of model.CLAP_LOCKS){
  const def=model.definition(id), control='control-'+def.rnbo;
  assert.equal(box(patch,control).maxclass,'flonum');
  assert.equal(box(patch,control+'-set').text,'prepend set');
  assert.ok(wired(patch,control,0,control+'-pre'));
  assert.ok(wired(patch,control+'-pre',0,'clap-manual'));
  assert.ok(wired(patch,control+'-set',0,control));
 }
});

test('clap range recall validates pairs and the preset owns only range fields',()=>{
 const sent=[], outputs=[]; let pendingTask;
 const context=vm.createContext({
  require:()=>model,
  messnamed:(...args)=>sent.push(args),
  outlet:(...args)=>outputs.push(args),
  Task:function(fn){this.cancel=()=>{};this.schedule=()=>{pendingTask=fn;};}
 });
 vm.runInContext(fs.readFileSync(path.join(__dirname,'..','clap_lab_ranges.js'),'utf8'),context);
 context.setrange('clapFilterHz','min',1200);
 context.setrange('clapFilterHz','max',8000);
 pendingTask();
 assert.deepEqual(sent.at(-1),['gridrouter','clapRange','clapFilterHz',1200,8000]);
 context.setrange('clapFilterHz','min',9000);
 pendingTask();
 assert.deepEqual(sent.at(-1),['gridrouter','clapRange','clapFilterHz',1200,8000]);
 assert.match(outputs.at(-1)[2],/rejected/);

 const patch=read('rnbo_clap.maxpat'), preset=box(patch,'range-presets');
 assert.equal(preset.maxclass,'preset');
 assert.equal(preset.embed===undefined ? 1 : preset.embed,1);
 assert.equal(preset.dirty,1);
 const destinations=patch.lines.filter(entry=>entry.patchline.source[0]==='range-presets').map(entry=>entry.patchline.destination[0]).sort();
 assert.deepEqual(destinations,model.CLAP_LOCKS.flatMap(id=>[id+'-min',id+'-max']).sort());
});

test('native bridge delivers clap values in the parameter phase before track press',()=>{
 const patch=read('sequence64_audio_bridge.maxpat');
 assert.equal(box(patch,'clap-route').text,'route 13');
 assert.equal(box(patch,'clap-send').text,'s rnbo_clap_step');
 assert.ok(wired(patch,'obj-actiontrigger',3,'clap-group'));
 assert.ok(wired(patch,'clap-group',1,'clap-route'));
 assert.ok(wired(patch,'clap-route',0,'clap-slice'));
 assert.ok(wired(patch,'clap-slice',1,'clap-send'));
});
