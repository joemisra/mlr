#!/usr/bin/env node
'use strict';

// Build independent Max projects from an explicit, reviewed source manifest.
// Source Max JSON is never rewritten. Only the edition copies are transformed.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const ROOT = path.resolve(__dirname, '..');
const patch = file => JSON.parse(fs.readFileSync(path.join(ROOT, file), 'utf8'));
const clone = value => JSON.parse(JSON.stringify(value));
const binaryPatch = file => fs.readFileSync(path.join(ROOT,file)).subarray(4,8).toString()==='pmax';
const outputName = file => binaryPatch(file) && !file.endsWith('.mxb') ? file+'.mxb' : file;
// Reviewed dependencies inside opaque legacy binary patchers.
const legacyDependencies = { '64midi.abs.mxb': ['64num.abs.mxb'] };

function removeBoxes(p, predicate) {
 const removed = new Set(p.boxes.filter(e => predicate(e.box)).map(e => e.box.id));
 p.boxes = p.boxes.filter(e => !removed.has(e.box.id));
 p.lines = (p.lines || []).filter(e => !removed.has(e.patchline.source[0]) && !removed.has(e.patchline.destination[0]));
}
function visit(p, fn) {
 fn(p);
 for (const {box} of p.boxes || []) if (box.patcher) visit(box.patcher, fn);
}
function object(id, text, x=20, y=600) {
 return {box:{id, maxclass:'newobj', text, patching_rect:[x,y,180,22]}};
}
function connect(p, source, outlet, destination, inlet) {
 p.lines.push({patchline:{source:[source,outlet], destination:[destination,inlet]}});
}
function transformPatch(file, document, edition) {
 const d=clone(document), main=file==='_mlr.maxpat', base=edition==='mlr';
 visit(d.patcher, p => {
  delete p.dependency_cache; // no developer machine search paths in either project
  removeBoxes(p,b => /max_mcp|p MaxMSP-Agent|p debug-tool/.test(b.text || ''));
  if (base) removeBoxes(p,b => /^(sequence64_audio_bridge|mlr_modulation|mlr_cv_outputs)( |$)/.test(b.text || '') || b.id==='obj-rseqpulse');
  for (const {box:b} of p.boxes) {
   // RNBO occupies visible tracks 8–15 (native ch buses 9–16).
   // Keep sample-track arguments intact and give each instrument its own group.
   if (!base && b.name==='ch.maxpat' && b.args && b.args[0]>=9 && b.args[0]<=16) b.args[1]=17-b.args[0];
   // Legacy recorder bpatchers still name the old .pat extension.
   if (b.maxclass==='bpatcher' && /\.pat$/.test(b.name||'')) {
    const modern=b.name.replace(/\.pat$/,'.maxpat');
    if (fs.existsSync(path.join(ROOT,modern))) b.name=modern;
   }
   if (b.maxclass==='bpatcher' && b.name && fs.existsSync(path.join(ROOT,b.name))) b.name=outputName(b.name);
   // These two message boxes cache old preset dialog paths, not sample data.
   if (b.maxclass==='message' && /^Mac:\/Users\/Kero\/.+\/dope-preset(?:_flist)?$/.test(b.text||'')) b.text=path.basename(b.text);
   if (base && typeof b.text==='string') b.text=b.text.replaceAll('sequence64_pulse','mlr_capture_pulse');
  }
 });
 if (file==='hud.maxpat' && !base) {
  d.patcher.rect=[80,80,936,550];
  const ui=d.patcher.boxes.find(({box})=>box.id==='obj-hud-ui').box;
  ui.presentation_rect=[0,0,936,550];ui.patching_rect=[0,0,936,550];
 }
 if (main) {
  d.patcher.rect=[80,80,1000,674];
  if (!base) {
   removeBoxes(d.patcher,b => ['obj-hud-button','obj-hud-open','obj-hud-pcontrol','obj-hud-host','obj-106'].includes(b.id));
   d.patcher.boxes.push(object('rta-master','r rta_master_level'),object('rta-dsp','r rta_dsp',220));
   connect(d.patcher,'rta-master',0,'obj-119',0);
   connect(d.patcher,'rta-dsp',0,'obj-104',0);
  }
 }
 return d;
}
function rtaEntry() {
 const p={fileversion:1,appversion:{major:9,minor:1,revision:5,architecture:'x64',modernui:1},
  classnamespace:'box',rect:[80,80,960,650],bglocked:1,openinpresentation:1,boxes:[],lines:[]};
 p.boxes.push(object('engine','rta_engine',20,720));
 p.boxes.push({box:{id:'hud',maxclass:'bpatcher',name:'hud.maxpat',numinlets:1,numoutlets:0,
  border:0,offset:[0,0],patching_rect:[12,88,936,550],presentation:1,presentation_rect:[12,88,936,550]}});
 p.boxes.push({box:{id:'clock',maxclass:'bpatcher',name:'time.maxpat',numinlets:0,numoutlets:0,
  border:0,offset:[-33,-60],patching_rect:[12,8,282,64],presentation:1,presentation_rect:[12,8,282,64]}});
 p.boxes.push({box:{id:'audio',maxclass:'toggle',patching_rect:[316,16,24,24],presentation:1,presentation_rect:[316,16,24,24]}});
 p.boxes.push({box:{id:'audio-label',maxclass:'comment',text:'Audio',patching_rect:[346,18,55,20],presentation:1,presentation_rect:[346,18,55,20]}});
 p.boxes.push(object('audio-send','s rta_dsp',20,760));connect(p,'audio',0,'audio-send',0);
 p.boxes.push({box:{id:'master',maxclass:'slider',floatoutput:0,min:0,size:159,patching_rect:[420,18,150,22],presentation:1,presentation_rect:[420,18,150,22]}});
 p.boxes.push({box:{id:'master-label',maxclass:'comment',text:'Master volume',patching_rect:[420,44,140,20],presentation:1,presentation_rect:[420,44,140,20]}});
 p.boxes.push(object('master-send','s rta_master_level',220,760));connect(p,'master',0,'master-send',0);
 p.boxes.push(object('master-default','loadmess 120',420,760));connect(p,'master-default',0,'master',0);
 p.boxes.push(object('audio-default','loadmess 0',620,760));connect(p,'audio-default',0,'audio',0);
 p.boxes.push(object('lab','rnbo_drum_lab',20,800));
 p.boxes.push({box:{id:'lab-open',maxclass:'message',text:'open',patching_rect:[610,16,90,24],presentation:1,presentation_rect:[610,16,90,24]}});
 p.boxes.push({box:{id:'lab-label',maxclass:'comment',text:'Instrument controls',patching_rect:[610,44,145,20],presentation:1,presentation_rect:[610,44,145,20]}});
 p.boxes.push(object('lab-window','pcontrol',220,800));connect(p,'lab-open',0,'lab-window',0);connect(p,'lab-window',0,'lab',0);
 p.boxes.push(object('close','closebang',20,840));
 p.boxes.push({box:{id:'teardown',maxclass:'message',text:'; gridrouter sessionStopAndReset; sample_bank previewStop; rta_dsp 0',patching_rect:[220,840,590,22]}});
 connect(p,'close',0,'teardown',0);
 return {patcher:p};
}

// Dependency inspection is a verification step, never an implicit release glob.
// Only references to project-owned files are collected; built-in Max objects
// and installed RNBO/Max libraries remain host requirements.
function references(file, content) {
 const result=new Set(legacyDependencies[file] || []);
 function add(name) {
  if (!name || name.includes('#')) return;
  name=name.replace(/^\.\//,'');
  if (!fs.existsSync(path.join(ROOT,name)) && name.endsWith('.mxb') && fs.existsSync(path.join(ROOT,name.slice(0,-4)))) name=name.slice(0,-4);
  if(fs.existsSync(path.join(ROOT,name)) && fs.statSync(path.join(ROOT,name)).isFile()) result.add(name);
 }
 if (file.endsWith('.js')) {
  for(const m of content.matchAll(/(?:require|include)\(["']([^"']+)["']\)/g)) add(m[1]);
 } else {
  let data;try {data=JSON.parse(content);} catch (_) {return result;}
  function walk(value) {
   if(!value || typeof value!=='object')return;
   if(value.maxclass) {
    for(const key of ['name','filename','pic','file']) add(value[key]);
    const text=String(value.text||''), words=text.split(/\s+/);
    for(const word of words) add(word.replace(/^"|"$/g,''));
    if(value.maxclass==='newobj') {
     add(words[0]); add(words[0]+'.maxpat'); add(words[0]+'.mxb');
     if(['js','v8','v8ui','jsui','node.script'].includes(words[0]))add(words[1]);
    }
   }
   for(const [key,child] of Object.entries(value)) if(key!=='dependency_cache')walk(child);
  }
  walk(data);
 }
 return result;
}
const baseOptional = file => /^(?:sequence64_|rnbo_|dpt_|.*instrument.*\.js$|.*lab_ranges\.js$|synth_engine_catalog\.js$|scene_model\.js$|modulation_model\.js$)/.test(file);
function transformed(file, edition) {
 if(file.endsWith('.maxpat'))return JSON.stringify(transformPatch(file,patch(file),edition),null,2)+'\n';
 let content=fs.readFileSync(path.join(ROOT,file));
 if(file.endsWith('.js') && edition==='mlr') content=Buffer.from(content.toString().replaceAll('sequence64_pulse','mlr_capture_pulse'));
 return content;
}
function discover(edition) {
 const found=new Set(['_mlr.maxpat','mlr_product.js','license_mlr.txt','mlr_info.txt','mlr.local.example.json','sample-bank.json']);
 if(edition==='rta')for(const f of ['hud.maxpat','time.maxpat','rnbo_drum_lab.maxpat','sequence64_editor_reference.md','grid_routing_reference.md'])found.add(f);
 for(const file of found) {
  for(const dep of references(file,transformed(file,edition).toString())) {
   if(edition==='mlr' && baseOptional(dep))continue;
   // Optional native prototype is not a shipping runtime dependency.
   if(dep==='sequence64_native_compile.js')continue;
   found.add(dep);
  }
 }
 return [...found].sort();
}
function build(edition, destination) {
 if(!['mlr','rta'].includes(edition))throw Error('Choose mlr or rta');
 const manifest=JSON.parse(fs.readFileSync(path.join(ROOT,'editions',edition+'.json'),'utf8'));
 const expected=discover(edition);
 const missing=expected.filter(file=>!manifest.files.includes(file));
 if(missing.length)throw Error('Manifest is missing dependencies: '+missing.join(', '));
 if(fs.existsSync(destination))throw Error('Destination already exists; choose a new directory: '+destination);
 fs.mkdirSync(destination,{recursive:true});
 const product={id:edition,name:edition==='rta'?'ṛta':'MLR',rta:edition==='rta'};
 for(const file of manifest.files) {
  if(path.isAbsolute(file)||file.split('/').includes('..'))throw Error('Invalid manifest path');
  const target=edition==='rta'&&file==='_mlr.maxpat'?'rta_engine.maxpat':outputName(file);
  fs.mkdirSync(path.dirname(path.join(destination,target)),{recursive:true});
  fs.writeFileSync(path.join(destination,target),transformed(file,edition));
 }
 fs.writeFileSync(path.join(destination,'mlr_product.js'),'"use strict";\nmodule.exports = Object.freeze('+JSON.stringify(product)+');\n');
 // Runtime Node scripts use Max's max-api and built-ins. Do not ship the
 // development Socket.IO bridge dependency or its placeholder package license.
 fs.writeFileSync(path.join(destination,'package.json'),JSON.stringify({name:edition,version:'1.0.0',private:true,license:'GPL-2.0-only'},null,2)+'\n');
 // The example itself is safe to copy on ordinary monome rigs.
 fs.writeFileSync(path.join(destination,'mlr.local.example.json'),JSON.stringify({mechatrellis:false,editorColors:false,cvPulseEnabled:false},null,2)+'\n');
 if(edition==='rta')fs.writeFileSync(path.join(destination,'_rta.maxpat'),JSON.stringify(rtaEntry(),null,2)+'\n');
 const entry=edition==='rta'?'_rta.maxpat':'_mlr.maxpat';
 const files=fs.readdirSync(destination);
 const project={name:edition,version:1,autoorganize:0,hideprojectwindow:1,autolocalize:0,
  contents:{patchers:{},code:{},data:{}},searchpath:{},includepackages:0};
 for(const file of files) {
  const kind=/\.(maxpat|mxb)$/.test(file)?'patcher':file.endsWith('.js')?'javascript':'data';
  const category=kind==='patcher'?'patchers':kind==='javascript'?'code':'data';
  project.contents[category][file]={kind,local:1,...(file===entry?{toplevel:1}:{})};
 }
 fs.writeFileSync(path.join(destination,edition+'.maxproj'),JSON.stringify(project,null,2)+'\n');
 fs.copyFileSync(path.join(ROOT,'editions',edition+'-README.md'),path.join(destination,'START-HERE.md'));
 fs.copyFileSync(path.join(ROOT,'docs/mlr-rta-split.md'),path.join(destination,'SPLIT-NOTES.md'));
 const hashes={};
 for(const file of fs.readdirSync(destination).sort()) {
  if(fs.statSync(path.join(destination,file)).isFile())hashes[file]=crypto.createHash('sha256').update(fs.readFileSync(path.join(destination,file))).digest('hex');
 }
 fs.writeFileSync(path.join(destination,'BUILD.json'),JSON.stringify({edition,entry,files:hashes},null,2)+'\n');
 return {edition,entry,destination,files:Object.keys(hashes).length};
}
if(require.main===module) {
 const [edition, destination]=process.argv.slice(2);
 if(edition==='--discover') {
  for(const id of ['mlr','rta'])console.log(JSON.stringify({edition:id,files:discover(id)},null,2));
 } else {
  if(!destination)throw Error('Usage: node scripts/build_editions.js mlr|rta OUTPUT_DIRECTORY');
  console.log(JSON.stringify(build(edition,path.resolve(destination))));
 }
}
module.exports={build,discover,references,transformPatch,rtaEntry};
