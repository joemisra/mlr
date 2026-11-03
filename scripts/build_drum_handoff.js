#!/usr/bin/env node
// Standalone development handoff; separate from the MLR / rta product releases.
const fs=require('node:fs'),path=require('node:path'),cp=require('node:child_process'),crypto=require('node:crypto');
const root=path.resolve(__dirname,'..');
function build(dest){
 dest=path.resolve(dest);if(fs.existsSync(dest))throw Error('Choose a fresh output directory: '+dest);
 const read=f=>JSON.parse(fs.readFileSync(path.join(root,f),'utf8'));
 const map=read('firmware/dpt/bank/midi-map.json');fs.mkdirSync(dest,{recursive:true});
 const save=(f,d)=>fs.writeFileSync(path.join(dest,f),JSON.stringify(d,null,2)+'\n');
 const copy=(f,to=f)=>{fs.mkdirSync(path.dirname(path.join(dest,to)),{recursive:true});fs.copyFileSync(path.join(root,f),path.join(dest,to));};
 const shell=()=>({patcher:{fileversion:1,appversion:read('rnbo_drum_lab.maxpat').patcher.appversion,rect:[80,80,960,1040],openinpresentation:1,boxes:[],lines:[]}});
 const box=(p,id,text,cls='newobj',extra={})=>p.boxes.push({box:{id,maxclass:cls,...(text?{text}:{}),patching_rect:[20,20+28*p.boxes.length,350,22],...extra}});
 const wire=(p,a,o,b,i=0)=>p.lines.push({patchline:{source:[a,o],destination:[b,i]}});
 const remove=(p,ids)=>{p.boxes=p.boxes.filter(x=>!ids.includes(x.box.id));p.lines=p.lines.filter(x=>!ids.includes(x.patchline.source[0])&&!ids.includes(x.patchline.destination[0]));};
 const ui=(p,id,text,cls,rect,extra={})=>box(p,id,text,cls,{presentation:1,presentation_rect:rect,...extra});
 copy('dpt_pack21.maxpat');
 for(const [v,e] of map.entries()){
  for(const f of [`dpt_${e.name}_midi.maxpat`,`${e.name}_lab_ranges.js`,`rnbo_${e.name}_voice.rnbopat`])copy(f);
  if(fs.existsSync(path.join(root,`rnbo_${e.name}_voice.genexpr`)))copy(`rnbo_${e.name}_voice.genexpr`);
  const model=e.name==='kick'?'instrument_model.js':e.name+'_instrument_model.js';copy(model);
  let d=read(`rnbo_${e.name}.maxpat`),p=d.patcher;delete p.dependency_cache;
  // Host owns the audio switch; all voices feed its stereo mixer through buses.
  remove(p,p.boxes.filter(x=>x.box.maxclass==='ezdac~'||/^dac~/.test(x.box.text||'')).map(x=>x.box.id));
  box(p,'midi-notes',`r drumkit_note_${e.name}`);box(p,'midi-hit',`drumkit_hit ${v===7?1:0}`);
  wire(p,'midi-notes',0,'midi-hit');wire(p,e.name+'-cache',0,'midi-hit',1);
  box(p,'midi-fire','t b l');wire(p,'midi-hit',0,'midi-fire');wire(p,'midi-fire',1,e.name+'-unpack');wire(p,'midi-fire',0,'obj-rnbo');
  p.boxes.find(x=>x.box.id==='dpt-local').box.text='expr (!$i1) || $i2';box(p,'monitor-local','r drumkit_local_monitor');box(p,'monitor-order','t b i');wire(p,'monitor-local',0,'monitor-order');wire(p,'monitor-order',1,'dpt-local',1);wire(p,'monitor-order',0,'dpt-local');
  save(`rnbo_${e.name}.maxpat`,d);
 }
 for(const f of ['instrument_parameter_model.js','synth_engine_catalog.js'])copy(f);
 // Velocity belongs to a hit snapshot, never the next hit's baseline.
 let d=shell(),p=d.patcher;p.openinpresentation=0;
 box(p,'note',null,'inlet',{patching_rect:[20,20,30,22]});box(p,'baseline',null,'inlet',{patching_rect:[450,20,30,22]});box(p,'reg','zl reg');wire(p,'baseline',0,'reg',1);
 box(p,'nv','unpack i i');wire(p,'note',0,'nv');box(p,'vel','/ 127.');wire(p,'nv',1,'vel');box(p,'nonzero','> 0');wire(p,'nv',1,'nonzero');box(p,'gate','gate 1 0');wire(p,'nonzero',0,'gate');wire(p,'nv',0,'gate',1);
 box(p,'order','t b i');wire(p,'gate',0,'order');wire(p,'order',0,'reg');box(p,'pitch','clip 12 96');wire(p,'order',1,'pitch');box(p,'pitch-store','i');wire(p,'pitch',0,'pitch-store',1);
 box(p,'values','unpack '+Array(12).fill('f').join(' '));wire(p,'reg',0,'values');box(p,'snapshot','pack '+Array(12).fill('0.').join(' '));box(p,'level','* 1.');wire(p,'vel',0,'level',1);wire(p,'values',11,'level');wire(p,'level',0,'snapshot',11);
 for(let i=1;i<11;i++)wire(p,'values',i,'snapshot',i);
 box(p,'bass-select','+ 1');box(p,'bass-arg','loadmess #1');wire(p,'bass-arg',0,'bass-select');box(p,'pitch-source','switch 2');wire(p,'bass-select',0,'pitch-source');wire(p,'values',0,'pitch-source',1);box(p,'pitch-bang','t b');wire(p,'values',0,'pitch-bang');wire(p,'pitch-bang',0,'pitch-store');wire(p,'pitch-store',0,'pitch-source',2);wire(p,'pitch-source',0,'snapshot');
 box(p,'out',null,'outlet');wire(p,'snapshot',0,'out');save('drumkit_hit.maxpat',d);
 // Native byte parsing and per-channel CC conversion, with no JavaScript timing path.
 d=shell();p=d.patcher;p.openinpresentation=0;box(p,'in',null,'inlet');box(p,'iter','iter');wire(p,'in',0,'iter');box(p,'parse','midiparse');wire(p,'iter',0,'parse');
 box(p,'notes','gate 8');box(p,'cc','gate 8');box(p,'channels','split 1 8');box(p,'ignore-channel','0','message');wire(p,'parse',6,'channels');wire(p,'channels',0,'notes');wire(p,'channels',0,'cc');wire(p,'channels',1,'ignore-channel');wire(p,'ignore-channel',0,'notes');wire(p,'ignore-channel',0,'cc');wire(p,'parse',0,'notes',1);wire(p,'parse',2,'cc',1);
 map.forEach((e,v)=>{
  box(p,'send-'+v,'s drumkit_note_'+e.name);wire(p,'notes',v,'send-'+v);
  box(p,'route-'+v,'route '+e.parameters.map(x=>x.cc).join(' '));wire(p,'cc',v,'route-'+v);
  box(p,'param-'+v,'s rnbo_'+e.name+'_param');
  e.parameters.forEach((x,i)=>{
   const id=`cc-${v}-${i}`,lo=x.gridMin,hi=x.gridMax;
   if(x.scale==='log'){
    box(p,id,`scale 0 127 ${Math.log(lo)} ${Math.log(hi)}`);box(p,id+'curve','expr exp($f1)');wire(p,id,0,id+'curve');
   }else{
    box(p,id,'scale 0 127 0. 1.');box(p,id+'curve',x.scale==='square'?'expr $f1 * $f1':'* 1.');wire(p,id,0,id+'curve');
    box(p,id+'range',`scale 0. 1. ${Number(lo).toFixed(8)} ${Number(hi).toFixed(8)}`);wire(p,id+'curve',0,id+'range');
   }
   wire(p,'route-'+v,i,id);box(p,id+'name','prepend '+x.rnbo);wire(p,id+(x.scale==='log'?'curve':'range'),0,id+'name');wire(p,id+'name',0,'param-'+v);
  });
 });save('drumkit_midi.maxpat',d);
 d=read('rnbo_drum_lab.maxpat');p=d.patcher;delete p.dependency_cache;
 remove(p,p.boxes.filter(x=>x.box.id.startsWith('knobs')||x.box.id.startsWith('output-')||['outputs','level-default'].includes(x.box.id)).map(x=>x.box.id));
 p.boxes.find(x=>x.box.id==='title').box.text='Eight-voice drum lab';
 p.boxes.find(x=>x.box.id==='footer').box.text='Standalone MIDI instrument. One instance per Max process. Save range presets in the individual lab patch.';
 save('drumkit_labs.maxpat',d);
 d=shell();p=d.patcher;
 ui(p,'title','Eight-voice drum instrument','comment',[20,10,900,28],{fontsize:22});
 ui(p,'help','Channels 1–8: Kick · Snare · Hat · Clap · Tom · Rim · Bell · Bass. CC 20–31: voice parameters.','comment',[20,45,900,24]);
 ui(p,'port-label','MIDI input','comment',[20,80,90,22]);ui(p,'port',null,'umenu',[110,80,290,24],{items:['Choose MIDI input']});
 ui(p,'refresh','Refresh MIDI','textbutton',[410,80,115,24]);box(p,'refresh-order','t b b');wire(p,'refresh',0,'refresh-order');box(p,'minus','-1','message');wire(p,'refresh-order',1,'minus');box(p,'info','midiinfo');wire(p,'minus',0,'info',1);wire(p,'info',0,'port');
 box(p,'port-prefix','prepend port');wire(p,'port',1,'port-prefix');box(p,'midiin','midiin none @matchport 1');wire(p,'port-prefix',0,'midiin');box(p,'programmatic','r drumkit_midi_in');box(p,'in',null,'inlet');
 box(p,'local','gate 1 1');box(p,'dpt','gate 1 0');box(p,'enabled','r dpt_enabled');box(p,'inverse','expr (!$i1) || $i2');wire(p,'enabled',0,'inverse');wire(p,'inverse',0,'local');wire(p,'enabled',0,'dpt');
 for(const id of ['midiin','programmatic','in']){wire(p,id,0,'local',1);wire(p,id,0,'dpt',1);}
 box(p,'parser','drumkit_midi');wire(p,'local',0,'parser');box(p,'relay','s dpt_midi_bytes');wire(p,'dpt',0,'relay');
 box(p,'load','loadbang');wire(p,'load',0,'refresh-order');box(p,'refresh-dpt','s dpt_refresh');wire(p,'refresh-order',0,'refresh-dpt');
 ui(p,'audio-label','Local audio','comment',[550,80,95,22]);ui(p,'audio',null,'toggle',[650,80,24,24]);box(p,'dac','dac~ 1 2');wire(p,'audio',0,'dac');
 ui(p,'master-label','Local level','comment',[700,80,80,22]);ui(p,'master',null,'flonum',[785,80,70,24],{minimum:0,maximum:1});box(p,'master-default','loadmess 0.25');wire(p,'master-default',0,'master');
 ui(p,'monitor-label','Also monitor local audio in DPT mode','comment',[20,110,300,22]);ui(p,'monitor',null,'toggle',[325,110,22,22]);box(p,'monitor-send','s drumkit_local_monitor');wire(p,'monitor',0,'monitor-send');box(p,'monitor-order','t b i');wire(p,'monitor',0,'monitor-order');wire(p,'monitor-order',1,'inverse',1);wire(p,'monitor-order',0,'inverse');box(p,'monitor-default','loadmess 0');wire(p,'monitor-default',0,'monitor');p.rect[3]=1080;
 ui(p,'embedded',null,'bpatcher',[0,145,940,900],{name:'drumkit_labs.maxpat',numinlets:0,numoutlets:0});
 for(const [side,ch] of [['left',0],['right',1]]){
  box(p,'mix-'+side,'*~ 0.25');wire(p,'master',0,'mix-'+side,1);wire(p,'mix-'+side,0,'dac',ch);
  map.forEach((e,v)=>{box(p,`audio-${side}-${v}`,`r~ rnbo_${e.name}_${side}`);wire(p,`audio-${side}-${v}`,0,'mix-'+side);});
 }
 save('Drum Instrument.maxpat',d);
 // Refresh button also updates the output list inside the embedded lab.
 const labs=JSON.parse(fs.readFileSync(path.join(dest,'drumkit_labs.maxpat')));box(labs.patcher,'handoff-refresh','r dpt_refresh');wire(labs.patcher,'handoff-refresh',0,'dpt-midiinfo');save('drumkit_labs.maxpat',labs);
 save('Drum Instrument.maxproj',{name:'Drum Instrument',version:1,creationdate:0,modificationdate:0,viewrect:[0,0,600,400],autoorganize:0,hideprojectwindow:1,autolocalize:0,contents:{patchers:Object.fromEntries(fs.readdirSync(dest).filter(f=>f.endsWith('.maxpat')).map(f=>[f,{kind:'patcher',local:1,...(f==='Drum Instrument.maxpat'?{toplevel:1}: {})}])),code:Object.fromEntries(fs.readdirSync(dest).filter(f=>f.endsWith('.js')).map(f=>[f,{kind:'javascript',local:1}]))},layout:{},searchpath:{},detailsvisible:0,amxdtype:0,readonly:0,devpath:'.'});
 copy('docs/drum-instrument-handoff.md','START HERE.md');
 const fw='firmware/dpt/bank/';copy(fw+'build/sram/mlr_rnbo_bank_sram.bin','DPT/mlr_rnbo_bank_sram.bin');copy(fw+'midi-map.json','DPT/midi-map.json');
 for(const f of ['main.cpp','channel_knobs.h','midi_state.h','midi_queue.h','usb_protocol.h','physical_ranges.h','bank_parameters.h','Makefile','build.py','rnbo_arena.ld','noise_compat.py','math_compat.py','midi_test.cpp','smoke.cpp'])copy(fw+f,'DPT/source/'+f);
 for(const f of ['rnbo_allocator.h'])copy('firmware/dpt/'+f,'DPT/'+f);
 for(const f of ['rnbo_source.h','rnbo_source.original.h','daisy_dpt_bank.cpp','usb_midi_bank.cpp'])copy(fw+'generated/'+f,'DPT/source/generated/'+f);
 fs.cpSync(path.join(root,fw,'generated/common'),path.join(dest,'DPT/source/generated/common'),{recursive:true});
 const helper=fs.readFileSync(path.join(root,fw+'build/helper/bank_flash_helper.bin'));
 if(!helper.includes(fs.readFileSync(path.join(root,fw+'build/sram/mlr_rnbo_bank_sram.bin'))))throw Error('ST-Link helper payload is stale');
 for(const f of ['flash_helper.cpp','flash_helper.mk'])copy(fw+'build/'+f,'DPT/ST-Link/'+f);
 copy(fw+'build/helper/bank_flash_helper.bin','DPT/ST-Link/bank_flash_helper.bin');
 copy('firmware/dpt/.deps/libdaisy/LICENSE','DPT/LICENSE-libDaisy.txt');
 copy(fw+'build/sram/build-inputs.json','DPT/build-inputs.json');copy(fw+'build/bootloader-backup/dsy_bootloader_v6_4-intdfu-2000ms.bin','DPT/dsy_bootloader_v6_4-intdfu-2000ms.bin');
 const hash=b=>crypto.createHash('sha256').update(b).digest('hex');const bin=fs.readFileSync(path.join(dest,'DPT/mlr_rnbo_bank_sram.bin'));
 const installed=read(fw+'build/bootloader-backup/installation.json');if(hash(bin)!==installed.sha256)throw Error('Firmware differs from verified installed binary');
 save('DPT/firmware-info.json',{bytes:bin.length,sha256:hash(bin),applicationStorage:'0x90040000',execution:'0x24000000',bootloader:'Daisy v6.4 internal USB DFU, 2000ms',channelKnobs:installed.channel_knobs,origin:'Previously installed binary; flash readback verified. No new firmware build or hardware flash performed for this handoff.'});
 save('SOURCE.json',{kind:'development handoff snapshot',head:cp.execFileSync('git',['rev-parse','HEAD'],{cwd:root,encoding:'utf8'}).trim(),workingTreeStatus:cp.execFileSync('git',['status','--short'],{cwd:root,encoding:'utf8'}),builtAt:new Date().toISOString()});
 const files=[];function walk(dir){for(const x of fs.readdirSync(dir,{withFileTypes:true})){const f=path.join(dir,x.name);if(x.isDirectory())walk(f);else files.push(f);}}walk(dest);
 fs.writeFileSync(path.join(dest,'SHA256SUMS.txt'),files.sort().map(f=>hash(fs.readFileSync(f))+'  '+path.relative(dest,f)).join('\n')+'\n');
 return dest;
}
if(require.main===module){if(!process.argv[2])throw Error('Usage: node scripts/build_drum_handoff.js FRESH_DIRECTORY');console.log(build(process.argv[2]));}
module.exports={build};
