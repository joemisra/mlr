const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

test('kick RNBO port metadata keeps audio wiring stable during compilation', () => {
  const patch = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'rnbo_kick.maxpat'), 'utf8')).patcher;
  const engine = patch.boxes.map(entry => entry.box).find(box => box.varname === 'kick_rnbo');
  assert.ok(engine, 'host contains the RNBO engine');
  const signalPorts = engine.outletInfo.IOInfo.filter(port => port.type === 'signal');
  assert.deepEqual(signalPorts.map(port => port.index), [1, 2]);
  assert.deepEqual(engine.outlettype.slice(0, 2), ['signal', 'signal']);
  assert.deepEqual(engine.inletInfo.IOInfo.map(port => [port.type, port.index]), [['event', 1]]);

  const boxes = new Map(patch.boxes.map(entry => [entry.box.id, entry.box]));
  const audioLines = patch.lines.map(entry => entry.patchline).filter(line =>
    line.source[0] === engine.id && boxes.get(line.destination[0]).text?.startsWith('*~'));
  assert.deepEqual(audioLines.map(line => line.source[1]).sort(), [0, 1],
    'audio must leave the first two outlets, not Max/RNBO metadata outlets');
});

test('native kick values are released before the corresponding press and flushed before RNBO bang', () => {
 const read = name => JSON.parse(fs.readFileSync(path.join(__dirname,'..',name),'utf8')).patcher;
 const bridge = read('sequence64_audio_bridge.maxpat'), host = read('rnbo_kick.maxpat');
 const box = (p,id) => p.boxes.find(e=>e.box.id===id).box;
 const wired = (p,s,o,d,i=0) => p.lines.some(e=>e.patchline.source[0]===s && e.patchline.source[1]===o && e.patchline.destination[0]===d && e.patchline.destination[1]===i);
 assert.equal(box(bridge,'obj-actiontrigger').text,'t l l l l');
 assert.ok(wired(bridge,'obj-actiontrigger',3,'kick-group'));
 assert.ok(wired(bridge,'kick-group',1,'kick-route'));
 assert.equal(box(bridge,'kick-route').text,'route 16');
 assert.ok(wired(bridge,'kick-route',0,'kick-slice'));
 assert.ok(wired(bridge,'kick-slice',1,'kick-send'));
 assert.equal(box(bridge,'kick-send').text,'s rnbo_kick_step');
 assert.equal(box(host,'kick-fire').text,'t b b');
 assert.ok(wired(host,'kick-fire',1,'kick-values'));
 assert.ok(wired(host,'kick-values',0,'kick-unpack'));
 assert.ok(wired(host,'kick-fire',0,'obj-rnbo'));
 assert.ok(wired(host,'kick-cache',0,'kick-values',1),'cache updates do not emit params before compilation');
 const core = box(read('rnbo_kick_voice.rnbopat'),'obj-dsp');
 assert.equal(core.code,core.rnbo_extra_attributes.code);
 assert.match(core.code,/if \(trig > 0\) \{\s+hitBase = in2;\s+hitDecay = in5;\s+hitFM = in6;/);
});

test('native bridge releases snare values before the Track 14 press',()=>{
 const read = name => JSON.parse(fs.readFileSync(path.join(__dirname,'..',name),'utf8')).patcher;
 const bridge=read('sequence64_audio_bridge.maxpat'), host=read('rnbo_snare.maxpat');
 const box=(p,id)=>p.boxes.find(e=>e.box.id===id).box;
 const wired=(p,s,o,d,i=0)=>p.lines.some(e=>e.patchline.source[0]===s&&e.patchline.source[1]===o&&e.patchline.destination[0]===d&&e.patchline.destination[1]===i);
 assert.ok(wired(bridge,'obj-actiontrigger',3,'snare-group'));
 assert.ok(wired(bridge,'snare-group',1,'snare-route'));
 assert.equal(box(bridge,'snare-route').text,'route 15');
 assert.ok(wired(bridge,'snare-route',0,'snare-slice'));
 assert.ok(wired(bridge,'snare-slice',1,'snare-send'));
 assert.equal(box(bridge,'snare-send').text,'s rnbo_snare_step');
 assert.ok(wired(host,'snare-step',0,'snare-step-unpack'));
 for(let index=0;index<12;index++) assert.ok(wired(host,'snare-step-unpack',index,'snare-cache',index));
});

test('RNBO engine and lab fields match the expanded physical schema',()=>{
 const model=require('../instrument_model');
 const p=JSON.parse(fs.readFileSync(path.join(__dirname,'../rnbo_kick.maxpat'),'utf8')).patcher;
 const engine=p.boxes.find(e=>e.box.id==='obj-rnbo').box;
 for(const id of model.KICK_LOCKS){
  const def=model.definition(id);
  const param=engine.patcher.boxes.find(e=>e.box.text?.startsWith(`param ${def.rnbo} `)).box;
  assert.ok(param.text.includes(`@min ${def.min} @max ${def.max}`));
  for(const edge of ['min','max']){
   const field=p.boxes.find(e=>e.box.id===`${id}-${edge}`).box;
   assert.equal(field.minimum,def.min);assert.equal(field.maximum,def.max);
  }
 }
});

test('every kick parameter has a native cache slot and is captured by the DSP at trigger time',()=>{
 const read=name=>JSON.parse(fs.readFileSync(path.join(__dirname,'..',name))).patcher;
 const p=read('rnbo_kick.maxpat'),core=read('rnbo_kick_voice.rnbopat');
 const model=require('../instrument_model');
 const boxes=new Map(p.boxes.map(e=>[e.box.id,e.box]));
 assert.equal(boxes.get('kick-route').text,'route '+model.KICK_LOCKS.map(id=>model.definition(id).rnbo).join(' '));
 for(let i=0;i<12;i++){
  for(const source of ['kick-route','kick-step-unpack'])assert.ok(p.lines.some(e=>e.patchline.source[0]===source && e.patchline.source[1]===i && e.patchline.destination[0]==='kick-cache' && e.patchline.destination[1]===i));
 }
 const dsp=core.boxes.find(e=>e.box.id==='obj-dsp').box;
 assert.equal(dsp.numinlets,13);
 const hitBlock=dsp.code.match(/if \(trig > 0\) \{([\s\S]*?)\}/)[1];
 for(let i=2;i<=13;i++)assert.match(hitBlock,new RegExp('= in'+i+';'));
 const remaining=dsp.code.replace(/if \(trig > 0\) \{[\s\S]*?\}/,'');
 assert.doesNotMatch(remaining,/\bin(?:[2-9]|1[0-3])\b/,'no parameter is read continuously after the trigger');
 assert.ok(core.lines.some(e=>e.patchline.source[0]==='obj-level-signal' && e.patchline.destination[0]==='obj-dsp' && e.patchline.destination[1]===12));
});

test('manual numeric controls use the shared baseline path and silent cached-value feedback',()=>{
 const p=JSON.parse(fs.readFileSync(path.join(__dirname,'../rnbo_kick.maxpat'))).patcher;
 const model=require('../instrument_model');
 const wired=(s,o,d)=>p.lines.some(e=>e.patchline.source[0]===s&&e.patchline.source[1]===o&&e.patchline.destination[0]===d);
 for(const id of model.KICK_LOCKS){
  const def=model.definition(id),name='control-'+def.rnbo;
  const control=p.boxes.find(e=>e.box.id===name).box;
  assert.equal(control.maxclass,'flonum');assert.equal(control.maximum,def.max);
  assert.ok(wired(name,0,name+'-pre'));assert.ok(wired(name+'-pre',0,'kick-manual'));
  assert.equal(p.boxes.find(e=>e.box.id===name+'-set').box.text,'prepend set');
  assert.ok(wired(name+'-set',0,name));
 }
});
