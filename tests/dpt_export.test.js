const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const root=path.join(__dirname,'..');
const load=f=>JSON.parse(fs.readFileSync(path.join(root,f))).patcher;
test('DPT export harness embeds the unchanged kick core and has no live audio or MLR subscriptions',()=>{
 const p=load('firmware/dpt/rnbo_kick_export.maxpat');
 const engine=p.boxes.find(b=>b.box.id==='engine').box;
 const r=engine.patcher,voice=r.boxes.find(b=>b.box.id==='rnbo-voice').box;
 assert.deepEqual(voice.patcher,load('rnbo_kick_voice.rnbopat'));
 assert.equal(r.boxes.find(b=>b.box.id==='rnbo-in').box.text,'inport hit');
 assert.equal(voice.text,'p kick_core');
 for(const b of p.boxes)assert.doesNotMatch(b.box.text||'',/dac~|rnbo_kick_trigger|\br\s+16input/);
 assert.ok(p.lines.every(l=>l.patchline.source[0]!=='engine'||l.patchline.source[1]===3));
 const original=load('rnbo_kick.maxpat').boxes.find(b=>b.box.id==='obj-rnbo').box.patcher;
 const params=x=>x.boxes.filter(b=>b.box.text?.startsWith('param ')).map(b=>b.box.text);
 assert.deepEqual(params(r),params(original));
 assert.deepEqual(r.lines,original.lines);
});

test('eight-voice export embeds original cores with unique params, hit inputs and mono outputs',()=>{
 const p=load('firmware/dpt/bank/rnbo_bank_export.maxpat');
 const r=p.boxes.find(b=>b.box.id==='engine').box.patcher;
 const names=['kick','snare','hat','clap','tom','rim','bell','bass'];
 const ids=r.boxes.map(b=>b.box.id);assert.equal(new Set(ids).size,ids.length);
 const unique=r.boxes.map(b=>b.box.rnbo_uniqueid).filter(Boolean);assert.equal(new Set(unique).size,unique.length);
 const params=r.boxes.filter(b=>b.box.text?.startsWith('param ')).map(b=>b.box.text.split(' ')[1]);assert.equal(params.length,96);assert.equal(new Set(params).size,96);
 names.forEach((name,i)=>{
  assert.deepEqual(r.boxes.find(b=>b.box.id===name+'-rnbo-voice').box.patcher,load('rnbo_'+name+'_voice.rnbopat'));
  assert.equal(r.boxes.find(b=>b.box.id===name+'-rnbo-in').box.text,'inport hit_'+name);
  assert.equal(r.boxes.find(b=>b.box.id===name+'-rnbo-out1').box.text,'out~ '+(i+1));
 });
 for(const line of r.lines){assert.ok(ids.includes(line.patchline.source[0]));assert.ok(ids.includes(line.patchline.destination[0]));}
 assert.ok(p.lines.every(l=>l.patchline.source[0]!=='engine'||l.patchline.source[1]===9));
 const manifest=JSON.parse(fs.readFileSync(path.join(root,'firmware/dpt/bank/midi-map.json')));
 manifest.forEach((e,i)=>{assert.equal(e.channel,i+1);e.parameters.forEach((param,j)=>{assert.equal(param.cc,20+j);assert.ok(params.includes(param.exportId));});});
});
