const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const root=path.join(__dirname,'..');
const read=f=>JSON.parse(fs.readFileSync(path.join(root,f))).patcher;
const b=(p,id)=>p.boxes.find(x=>x.box.id===id)?.box;
const wired=(p,a,o,d,i=0)=>p.lines.some(x=>x.patchline.source[0]===a&&x.patchline.source[1]===o&&x.patchline.destination[0]===d&&x.patchline.destination[1]===i);
const map=JSON.parse(fs.readFileSync(path.join(root,'firmware/dpt/bank/midi-map.json')));
test('DPT uses native encoders with ordered full snapshots and separate baseline edits',()=>{
 map.forEach((v,i)=>{
  const lab=read('rnbo_'+v.name+'.maxpat'),p=read('dpt_'+v.name+'_midi.maxpat');
  assert.ok(wired(lab,v.name+'-values',0,'dpt-bridge',1));assert.ok(wired(lab,v.name+'-manual',1,'dpt-bridge'));assert.ok(wired(lab,v.name+'-owned',0,'dpt-bridge'));
  assert.equal(b(p,'voice').text,'prepend list '+i);assert.equal(b(p,'snapshot').text.split(' ').length,37);
  assert.ok(wired(p,'hit-order',1,'hit-op'));assert.ok(wired(p,'hit-order',0,'unpack'));assert.equal(b(p,'hit-op').text,'set list 2');assert.equal(b(p,'sync-op').text,'set list 3');
  v.parameters.forEach((x,k)=>{assert.equal(b(p,'encode-'+k).text,`dpt_pack21 ${Number(x.min).toFixed(8)} ${Number(x.max).toFixed(8)}`);for(let j=0;j<3;j++)assert.ok(wired(p,'bytes-'+k,j,'snapshot',3*k+j));});
  assert.equal(b(p,'gate').text,'gate 1 0');assert.ok(p.boxes.every(x=>!/(v8|js |defer|pipe |delay )/.test(x.box.text||'')));
  const ids=new Set(lab.boxes.map(x=>x.box.id));for(const l of lab.lines){assert.ok(ids.has(l.patchline.source[0]));assert.ok(ids.has(l.patchline.destination[0]));}
 });
});
test('DPT starts local with no MIDI output port; changing port precedes synchronization',()=>{
 const p=read('rnbo_drum_lab.maxpat');assert.equal(b(p,'dpt-default').text,'loadmess 0');assert.equal(b(p,'dpt-out').text,'midiout none @matchport 1');assert.ok(wired(p,'dpt-port-order',1,'dpt-port-prefix'));assert.ok(wired(p,'dpt-port-order',0,'dpt-sync-send'));
});
test('21-bit encoder uses native scaling, clamps and rounds before splitting bytes',()=>{
 const p=read('dpt_pack21.maxpat');
 assert.equal(b(p,'in').maxclass,'inlet');assert.equal(b(p,'out').maxclass,'outlet');
 assert.equal(b(p,'scale').text,'scale #1 #2 0. 2097151.');
 assert.equal(b(p,'clip').text,'clip 0. 2097151.');assert.equal(b(p,'round').text,'+ 0.5');
 assert.ok(wired(p,'scale',0,'clip'));assert.ok(wired(p,'clip',0,'round'));assert.ok(wired(p,'round',0,'order'));
});
