const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),os=require('node:os'),path=require('node:path'),crypto=require('node:crypto');
const {build}=require('../scripts/build_drum_handoff');
test('standalone drum handoff closes its dependencies and preserves hit/MIDI ownership',t=>{
 const tmp=fs.mkdtempSync(path.join(os.tmpdir(),'drum-handoff-'));t.after(()=>fs.rmSync(tmp,{recursive:true,force:true}));const out=build(path.join(tmp,'bundle'));
 const read=f=>JSON.parse(fs.readFileSync(path.join(out,f)));const p=f=>read(f).patcher;
 const b=(q,id)=>q.boxes.find(x=>x.box.id===id).box;
 const wired=(q,a,o,z,i=0)=>q.lines.some(x=>JSON.stringify(x.patchline.source)===JSON.stringify([a,o])&&JSON.stringify(x.patchline.destination)===JSON.stringify([z,i]));
 const main=p('Drum Instrument.maxpat'),midi=p('drumkit_midi.maxpat'),hit=p('drumkit_hit.maxpat'),labs=p('drumkit_labs.maxpat');
 assert.equal(b(main,'midiin').text,'midiin none @matchport 1');assert.equal(b(main,'dac').text,'dac~ 1 2');assert.equal(b(main,'local').text,'gate 1 1');assert.equal(b(main,'dpt').text,'gate 1 0');
 assert.ok(wired(main,'minus',0,'info',1));assert.ok(wired(main,'midiin',0,'local',1));assert.ok(wired(main,'midiin',0,'dpt',1));
 assert.equal(b(midi,'channels').text,'split 1 8');assert.ok(wired(midi,'channels',1,'ignore-channel'));assert.ok(wired(midi,'ignore-channel',0,'notes'));
 assert.equal(b(hit,'pitch-source').text,'switch 2');assert.ok(wired(main,'monitor-order',1,'inverse',1));assert.ok(wired(main,'monitor-order',0,'inverse'));assert.ok(wired(hit,'baseline',0,'reg',1));assert.ok(wired(hit,'nonzero',0,'gate'));assert.ok(wired(hit,'vel',0,'level',1));assert.ok(wired(hit,'level',0,'snapshot',11));
 const map=read('DPT/midi-map.json');
 for(const [v,e] of map.entries()){
  const q=p(`rnbo_${e.name}.maxpat`);assert.ok(!q.boxes.some(x=>x.box.maxclass==='ezdac~'||/^dac~/.test(x.box.text||'')));
  assert.ok(wired(q,e.name+'-cache',0,'midi-hit',1));assert.equal(b(q,'midi-hit').text,`drumkit_hit ${v===7?1:0}`);assert.ok(wired(q,'midi-fire',1,e.name+'-unpack'));assert.ok(wired(q,'midi-fire',0,'obj-rnbo'));
  assert.equal(b(midi,'send-'+v).text,'s drumkit_note_'+e.name);assert.equal(b(midi,'route-'+v).text,'route '+e.parameters.map(x=>x.cc).join(' '));
 }
 assert.ok(!labs.boxes.some(x=>/^knobs/.test(x.box.id)||x.box.id==='outputs'));
 assert.ok(!fs.existsSync(path.join(out,'grid_router.js')));assert.ok(!fs.existsSync(path.join(out,'_mlr.maxpat')));assert.ok(!fs.existsSync(path.join(out,'node_modules')));
 // Every serialized cord endpoint and executable patch dependency must be included.
 function inspect(q){const ids=new Set(q.boxes.map(x=>x.box.id));for(const x of q.lines){assert.ok(ids.has(x.patchline.source[0]));assert.ok(ids.has(x.patchline.destination[0]));}for(const {box:c} of q.boxes){if(c.patcher)inspect(c.patcher);if(c.maxclass==='bpatcher')assert.ok(fs.existsSync(path.join(out,c.name)),c.name);if(/^v8 |^js /.test(c.text||'')){const f=c.text.split(' ')[1];assert.ok(fs.existsSync(path.join(out,f)),f);}}}
 for(const f of fs.readdirSync(out).filter(x=>/\.maxpat$/.test(x)))inspect(p(f));
 const bin=fs.readFileSync(path.join(out,'DPT/mlr_rnbo_bank_sram.bin'));assert.equal(bin.length,272248);assert.equal(crypto.createHash('sha256').update(bin).digest('hex'),read('DPT/firmware-info.json').sha256);
 assert.ok(fs.readFileSync(path.join(out,'DPT/ST-Link/bank_flash_helper.bin')).includes(bin));
 for(const row of fs.readFileSync(path.join(out,'SHA256SUMS.txt'),'utf8').trim().split('\n')){const [hash,f]=row.split('  ');assert.equal(crypto.createHash('sha256').update(fs.readFileSync(path.join(out,f))).digest('hex'),hash,f);}
 assert.throws(()=>build(out),/fresh output/);
});
