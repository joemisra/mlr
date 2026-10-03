'use strict';
const assert=require('node:assert/strict');
const fs=require('node:fs');
const os=require('node:os');
const path=require('node:path');
const vm=require('node:vm');
const {test,after}=require('node:test');
const {build,discover}=require('../scripts/build_editions');
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'mlr-editions-'));
after(()=>fs.rmSync(temp,{recursive:true,force:true}));
for(const edition of ['mlr','rta']) build(edition,path.join(temp,edition));
const read=(edition,file)=>fs.readFileSync(path.join(temp,edition,file),'utf8');
const patch=(edition,file)=>JSON.parse(read(edition,file)).patcher;
function boxes(p) {return p.boxes.flatMap(({box})=>[box,...(box.patcher?boxes(box.patcher):[])]);}
function fragments() {
 return {router:{tracks:Array.from({length:16},(_,id)=>({id,group:id%8,buffer:8+id})),
 groups:Array.from({length:8},(_,id)=>({id,volume:90})),automation:{events:[{x:2,y:1,state:1}],playing:true}},
 bank:{samples:[],assignments:Array(16).fill(-1)},channelStrips:Array.from({length:8},(_,id)=>({id,cutoff:0.7})),
 rack:{groups:Array.from({length:8},(_,id)=>({id,slots:Array.from({length:4},()=>({name:'Empty',loaded:0}))}))},
 transport:{bpm:123,quantize:16}};
}

test('edition manifests are explicit and complete; MLR has no sequencer or instrument dependencies',()=>{
 for(const edition of ['mlr','rta']) {
  const manifest=require('../editions/'+edition+'.json');
  assert.deepEqual(manifest.files.slice().sort(),discover(edition));
  assert.deepEqual(JSON.parse(read(edition,'package.json')),{name:edition,version:'1.0.0',private:true,license:'GPL-2.0-only'});
  assert.equal(boxes(patch(edition,'rec.maxpat')).filter(b=>b.name==='rec_b.maxpat').length,8);
  assert.ok(fs.existsSync(path.join(temp,edition,'rec_b.maxpat')));
  for(const file of ['fade.mxb','session.mxb','file.abs.mxb','showMeter.mxb','64num.abs.mxb']) assert.ok(fs.existsSync(path.join(temp,edition,file)),file);
  const project=JSON.parse(read(edition,edition+'.maxproj'));
  assert.equal(project.contents.patchers['session.mxb'].kind,'patcher');
  for(const file of fs.readdirSync(path.join(temp,edition))) {
   if(!file.endsWith('.maxpat'))continue;
   const p=patch(edition,file);
   function check(p) {
    const ids=new Set(p.boxes.map(({box})=>box.id));
    for(const {patchline:l} of p.lines||[]) {
     assert.ok(ids.has(l.source[0]),`${file}: missing source ${l.source[0]}`);
     assert.ok(ids.has(l.destination[0]),`${file}: missing destination ${l.destination[0]}`);
    }
    for(const {box} of p.boxes)if(box.patcher)check(box.patcher);
   }
   check(p);
   assert.equal(boxes(p).some(b=>/max_mcp|p MaxMSP-Agent|p debug-tool/.test(b.text||'')),false);
  }
 }
 const files=fs.readdirSync(path.join(temp,'mlr'));
 assert.equal(files.some(f=>/^(rnbo_|dpt_|sequence64_|scene_model|modulation_model)/.test(f)),false);
 const topology=files.filter(f=>f.endsWith('.maxpat')).flatMap(f=>boxes(patch('mlr',f)));
 assert.equal(topology.some(b=>/^(sequence64_audio_bridge|mlr_modulation|mlr_cv_outputs)( |$)/.test(b.text||'')),false);
 assert.ok(topology.some(b=>b.text==='r mlr_capture_pulse'));
 assert.ok(topology.some(b=>b.text==='s mlr_capture_pulse'));
 assert.deepEqual(JSON.parse(read('mlr','mlr.local.example.json')),{mechatrellis:false,editorColors:false,cvPulseEnabled:false});
});

test('rta assigns its eight RNBO tracks to groups 8–1 without changing sample or MLR defaults',()=>{
 const tracks=(edition,file)=>boxes(patch(edition,file)).filter(b=>b.name==='ch.maxpat')
  .sort((a,b)=>a.args[0]-b.args[0]).map(b=>Array.from(b.args));
 const mlr=tracks('mlr','_mlr.maxpat'),rta=tracks('rta','rta_engine.maxpat');
 assert.deepEqual(mlr.map(t=>t[1]),[8,8,8,7,7,7,6,6,6,5,5,5,4,4,4]);
 assert.deepEqual(rta.slice(0,7),mlr.slice(0,7));
 assert.deepEqual(rta.slice(7),Array.from({length:8},(_,i)=>[i+9,8-i]));
});

test('rta entry owns one HUD, clock, engine and lab with explicit audio and teardown',()=>{
 const entry=patch('rta','_rta.maxpat'),engine=patch('rta','rta_engine.maxpat');
 assert.equal(boxes(entry).filter(b=>b.name==='hud.maxpat').length,1);
 assert.equal(boxes(entry).filter(b=>b.name==='time.maxpat').length,1);
 assert.deepEqual(boxes(entry).find(b=>b.name==='time.maxpat').offset,[-33,-60]);
 assert.equal(boxes(engine).some(b=>b.name==='hud.maxpat'||b.name==='time.maxpat'),false);
 assert.equal(boxes(entry).filter(b=>b.text==='rta_engine').length,1);
 assert.equal(boxes(entry).filter(b=>b.text==='rnbo_drum_lab').length,1);
 assert.ok(boxes(entry).some(b=>b.text==='closebang'));
 assert.ok(boxes(entry).some(b=>b.text==='; gridrouter sessionStopAndReset; sample_bank previewStop; rta_dsp 0'));
 assert.ok(boxes(engine).some(b=>b.text==='r rta_dsp'));
 assert.ok(boxes(engine).some(b=>b.text==='r rta_master_level'));
 assert.equal(fs.existsSync(path.join(temp,'rta','_mlr.maxpat')),false);
 assert.equal(fs.existsSync(path.join(temp,'rta','mlr_session_service.maxpat')),true);
});

test('base sessions round-trip without sequencer fields; rta imports them and MLR rejects full sessions',()=>{
 const base=require(path.join(temp,'mlr','mlr_session_core.js'));
 const rta=require(path.join(temp,'rta','mlr_session_core.js'));
 const doc=base.buildDocument(fragments());
 assert.equal(doc.format,'mlr-base-session');assert.equal(doc.version,1);
 assert.equal('rta' in doc,false);assert.equal('modulation' in doc,false);assert.equal('instrumentPresets' in doc,false);
 assert.deepEqual(base.validateDocument(doc),{valid:true,errors:[]});
 assert.equal(doc.automation.playing,false);
 const imported=rta.migrateDocument(doc);
 assert.equal(imported.format,'mlr-session');assert.equal(imported.version,4);
 assert.deepEqual(rta.validateDocument(imported),{valid:true,errors:[]});
 assert.deepEqual(imported.tracks,doc.tracks);assert.deepEqual(imported.automation.events,doc.automation.events);
 assert.deepEqual(imported.bank,doc.bank);assert.deepEqual(imported.channelStrips,doc.channelStrips);
 assert.equal(base.validateDocument(imported).valid,false);
 assert.equal(rta.validateDocument(rta.migrateDocument({...doc,version:99})).valid,false);
 assert.equal(base.validateDocument({...doc,rta:{patterns:{}}}).valid,false);
 const bundle=path.join(temp,'session.mlr-session');fs.mkdirSync(bundle);
 fs.writeFileSync(path.join(bundle,'session.json'),JSON.stringify(doc));
 const manager=require(path.join(temp,'mlr','mlr_session_manager.js'));
 assert.deepEqual(manager.readDocument(bundle).document,doc);
 fs.writeFileSync(path.join(bundle,'session.json'),JSON.stringify(imported));
 assert.throws(()=>manager.readDocument(bundle),/Open this sequencer session in rta/);
});

test('generated MLR HUD renders every available page without rta navigation',()=>{
 const Model=require(path.join(temp,'mlr','hud_model.js'));
 assert.deepEqual(Model.HUD_PAGES,['live','strip','samples','session','help']);
 const labels=[];
 const graphics={size:[936,550],show_text(text){labels.push(text);}};
 for(const name of ['init','redraw','set_source_rgba','rectangle','fill','set_line_width','stroke','move_to','line_to','select_font_face','set_font_size'])graphics[name]=()=>{};
 function Task(){}Task.prototype.schedule=()=>{};Task.prototype.cancel=()=>{};
 const ctx=vm.createContext({autowatch:0,inlets:0,outlets:0,require:()=>Model,mgraphics:graphics,Task,outlet:()=>{}});
 vm.runInContext(read('mlr','hud.js'),ctx);
 for(const page of Model.HUD_PAGES) {ctx.state.page=page;ctx.paint();}
 assert.equal(labels.some(label=>/ṛta|ṚTA|ऋत/.test(label)),false);
 assert.equal(Model.describeCell(2,0,4,{},'follow').detail,'Latch group 1');
 assert.equal(Model.describeCell(2,11,1,{},'follow').detail,'Loop division for track 1');
});
