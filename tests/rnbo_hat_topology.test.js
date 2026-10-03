const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const model = require('../hat_instrument_model');

const read = name => JSON.parse(fs.readFileSync(path.join(__dirname,'..',name),'utf8')).patcher;
const box = (patch,id) => patch.boxes.find(entry=>entry.box.id===id)?.box;
const wired = (patch,source,outlet,destination,inlet=0) => patch.lines.some(entry=>{
 const line=entry.patchline;
 return line.source[0]===source && line.source[1]===outlet && line.destination[0]===destination && line.destination[1]===inlet;
});

test('hat lab keeps stable RNBO audio ports and follows native Track 13 presses',()=>{
 const patch=read('rnbo_hat.maxpat'), engine=box(patch,'obj-rnbo');
 assert.deepEqual(engine.outletInfo.IOInfo.filter(port=>port.type==='signal').map(port=>port.index),[1,2]);
 assert.deepEqual(engine.outlettype.slice(0,2),['signal','signal']);
 assert.deepEqual(engine.inletInfo.IOInfo.map(port=>[port.type,port.index]),[['event',1]]);
 assert.equal(box(patch,'obj-trackreceive').text,'r 14input');
 assert.equal(box(patch,'obj-unpack').text,'unpack i i');
 assert.equal(box(patch,'obj-selectpress').text,'sel 1');
 assert.ok(wired(patch,'obj-trackreceive',0,'obj-unpack'));
 assert.ok(wired(patch,'obj-unpack',1,'obj-selectpress'));
 assert.ok(wired(patch,'obj-selectpress',0,'obj-trigger'));
 assert.equal(box(patch,'hat-step').text,'r rnbo_hat_step');
 assert.equal(box(patch,'hat-owned').text,'r rnbo_hat_owned_param');
 assert.ok(wired(patch,'hat-owned',0,'hat-route'));
 assert.ok(wired(patch,'hat-step',0,'hat-step-unpack'));
 assert.equal(box(patch,'obj-globaltrigger').text,'r rnbo_hat_trigger');
 assert.equal(box(patch,'hat-router').text,'s gridrouter');
 const audioLines=patch.lines.filter(entry=>entry.patchline.source[0]===engine.id && box(patch,entry.patchline.destination[0])?.text?.startsWith('*~'));
 assert.deepEqual(audioLines.map(entry=>entry.patchline.source[1]).sort(),[0,1]);
});

test('hat host fields and RNBO params match the twelve-control schema',()=>{
 const patch=read('rnbo_hat.maxpat'), engine=box(patch,'obj-rnbo');
 assert.equal(box(patch,'hat-route').text,'route '+model.HAT_LOCKS.map(id=>model.definition(id).rnbo).join(' '));
 for(const id of model.HAT_LOCKS){
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
 assert.equal(box(patch,'range-script').text,'v8 hat_lab_ranges.js');
});

test('hat cache flushes every latched control before a hit',()=>{
 const patch=read('rnbo_hat.maxpat'), core=read('rnbo_hat_voice.rnbopat');
 assert.equal(box(patch,'hat-fire').text,'t b b');
 assert.ok(wired(patch,'hat-fire',1,'hat-values'));
 assert.ok(wired(patch,'hat-values',0,'hat-unpack'));
 assert.ok(wired(patch,'hat-fire',0,'obj-rnbo'));
 assert.ok(wired(patch,'hat-cache',0,'hat-values',1));
 for(let index=0;index<12;index++){
  assert.ok(wired(patch,'hat-step-unpack',index,'hat-cache',index));
 }
 const dsp=box(core,'obj-dsp'), source=fs.readFileSync(path.join(__dirname,'..','rnbo_hat_voice.genexpr'),'utf8').trimEnd();
 assert.equal(dsp.code,dsp.rnbo_extra_attributes.code);
 assert.equal(dsp.code,source);
 assert.equal(dsp.numinlets,13);
 const hitBlock=dsp.code.match(/if \(trig > 0\) \{([\s\S]*?)\}/)[1];
 for(let inlet=2;inlet<=13;inlet++) assert.match(hitBlock,new RegExp(`= in${inlet};`));
 const tail=dsp.code.replace(/if \(trig > 0\) \{[\s\S]*?\}/,'');
 assert.doesNotMatch(tail,/\bin(?:[2-9]|1[0-3])\b/);
 assert.match(dsp.code,/let metal =/);
 assert.match(dsp.code,/let high =/);
});

test('hat controls use silent cache feedback and the manual RNBO path',()=>{
 const patch=read('rnbo_hat.maxpat');
 for(const id of model.HAT_LOCKS){
  const def=model.definition(id), control='control-'+def.rnbo;
  assert.equal(box(patch,control).maxclass,'flonum');
  assert.equal(box(patch,control+'-set').text,'prepend set');
  assert.ok(wired(patch,control,0,control+'-pre'));
  assert.ok(wired(patch,control+'-pre',0,'hat-manual'));
  assert.ok(wired(patch,control+'-set',0,control));
 }
});

test('hat range recall validates pairs and the preset owns only range fields',()=>{
 const sent=[], outputs=[]; let pendingTask;
 const context=vm.createContext({
  require:()=>model,
  messnamed:(...args)=>sent.push(args),
  outlet:(...args)=>outputs.push(args),
  Task:function(fn){this.cancel=()=>{};this.schedule=()=>{pendingTask=fn;};}
 });
 vm.runInContext(fs.readFileSync(path.join(__dirname,'..','hat_lab_ranges.js'),'utf8'),context);
 context.setrange('hatFilterHz','min',1200);
 context.setrange('hatFilterHz','max',8000);
 pendingTask();
 assert.deepEqual(sent.at(-1),['gridrouter','hatRange','hatFilterHz',1200,8000]);
 context.setrange('hatFilterHz','min',9000);
 pendingTask();
 assert.deepEqual(sent.at(-1),['gridrouter','hatRange','hatFilterHz',1200,8000]);
 assert.match(outputs.at(-1)[2],/rejected/);

 const patch=read('rnbo_hat.maxpat'), preset=box(patch,'range-presets');
 assert.equal(preset.maxclass,'preset');
 assert.equal(preset.embed===undefined ? 1 : preset.embed,1);
 assert.equal(preset.dirty,1);
 const destinations=patch.lines.filter(entry=>entry.patchline.source[0]==='range-presets').map(entry=>entry.patchline.destination[0]).sort();
 assert.deepEqual(destinations,model.HAT_LOCKS.flatMap(id=>[id+'-min',id+'-max']).sort());
});

test('native bridge delivers hat values in the parameter phase before track press',()=>{
 const patch=read('sequence64_audio_bridge.maxpat');
 assert.equal(box(patch,'hat-route').text,'route 14');
 assert.equal(box(patch,'hat-send').text,'s rnbo_hat_step');
 assert.ok(wired(patch,'obj-actiontrigger',3,'hat-group'));
 assert.ok(wired(patch,'hat-group',1,'hat-route'));
 assert.ok(wired(patch,'hat-route',0,'hat-slice'));
 assert.ok(wired(patch,'hat-slice',1,'hat-send'));
});
