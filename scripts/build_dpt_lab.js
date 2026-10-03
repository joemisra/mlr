// Generate native Max MIDI encoders and add DPT routing to the existing labs.
const fs=require('fs'),path=require('path');
const root=path.resolve(__dirname,'..');
const read=f=>JSON.parse(fs.readFileSync(path.join(root,f),'utf8'));
const save=(f,p)=>fs.writeFileSync(path.join(root,f),JSON.stringify(p,null,4)+'\n');
const map=read('firmware/dpt/bank/midi-map.json');
fs.writeFileSync(path.join(root,'firmware/dpt/bank/physical_ranges.h'),'#pragma once\nnamespace Bank {\nstatic constexpr float physicalRanges[8][12][2]={\n'+map.map(v=>'{'+v.parameters.map(p=>'{'+Number(p.min).toFixed(8)+'f,'+Number(p.max).toFixed(8)+'f}').join(',')+'}').join(',\n')+'\n};\n}\n');
const shell=()=>({patcher:{fileversion:1,appversion:read('rnbo_drum_lab.maxpat').patcher.appversion,rect:[100,100,1000,750],boxes:[],lines:[]}});
function box(p,id,text,cls='newobj',extra={}){p.boxes.push({box:{id,maxclass:cls,...(text?{text}:{}),patching_rect:[20,20+p.boxes.length*26,300,22],...extra}});}
function wire(p,a,o,b,i=0){p.lines.push({patchline:{source:[a,o],destination:[b,i]}});}
function add(p,id,text,cls,extra){if(!p.boxes.some(b=>b.box.id===id))box(p,id,text,cls,extra);}
function link(p,a,o,b,i=0){if(!p.lines.some(l=>JSON.stringify(l.patchline.source)===JSON.stringify([a,o])&&JSON.stringify(l.patchline.destination)===JSON.stringify([b,i])))wire(p,a,o,b,i);}
let doc=shell(),p=doc.patcher;
box(p,'in',null,'inlet');box(p,'scale','scale #1 #2 0. 2097151.');box(p,'clip','clip 0. 2097151.');box(p,'round','+ 0.5');box(p,'order','t i i i');box(p,'hi','expr ($i1 >> 14) & 127');box(p,'mid','expr ($i1 >> 7) & 127');box(p,'lo','expr $i1 & 127');box(p,'pack','pack 0 0 0');box(p,'out',null,'outlet');wire(p,'in',0,'scale');wire(p,'scale',0,'clip');wire(p,'clip',0,'round');wire(p,'round',0,'order');['hi','mid','lo'].forEach((id,i)=>{wire(p,'order',i,id);wire(p,id,0,'pack',i)});wire(p,'pack',0,'out');save('dpt_pack21.maxpat',doc);
for(const [v,voice] of map.entries()){
 doc=shell();p=doc.patcher;
 box(p,'manual',null,'inlet');box(p,'hit',null, 'inlet',{patching_rect:[350,20,40,22]});
 box(p,'route','route '+voice.parameters.map(x=>x.rnbo).join(' '));wire(p,'manual',0,'route');
 box(p,'unpack','unpack '+Array(12).fill('f').join(' '));wire(p,'hit',0,'unpack');
 box(p,'sync',null,'inlet',{patching_rect:[650,20,40,22]});
 box(p,'sync-order','t l b');box(p,'hit-order','t l b');box(p,'sync-op','set list 3','message');box(p,'hit-op','set list 2','message');
 // Opcode must be set before the native list encoder emits its packet.
 wire(p,'sync',0,'sync-order');wire(p,'sync-order',1,'sync-op');wire(p,'sync-order',0,'unpack');
 p.lines=p.lines.filter(l=>l.patchline.source[0]!=='hit');wire(p,'hit',0,'hit-order');wire(p,'hit-order',1,'hit-op');wire(p,'hit-order',0,'unpack');
 box(p,'snapshot','pack '+Array(36).fill('0').join(' '));
 box(p,'opcode','prepend list 2');wire(p,'hit-op',0,'opcode');wire(p,'sync-op',0,'opcode');
 box(p,'voice',`prepend list ${v}`);wire(p,'snapshot',0,'voice');wire(p,'voice',0,'opcode');
 box(p,'prefix','prepend list 240 125 77 76 82 1');wire(p,'opcode',0,'prefix');
 box(p,'end','append 247');wire(p,'prefix',0,'end');
 box(p,'enabled','r dpt_enabled');box(p,'gate','gate 1 0');wire(p,'enabled',0,'gate');wire(p,'end',0,'gate',1);
 box(p,'send','s dpt_midi_bytes');wire(p,'gate',0,'send');
 voice.parameters.forEach((x,i)=>{
  const enc=`dpt_pack21 ${Number(x.min).toFixed(8)} ${Number(x.max).toFixed(8)}`;
  box(p,'edit-'+i,enc);wire(p,'route',i,'edit-'+i);
  box(p,'edit-prefix-'+i,`prepend list 240 125 77 76 82 1 1 ${v} ${i}`);wire(p,'edit-'+i,0,'edit-prefix-'+i);wire(p,'edit-prefix-'+i,0,'end');
  box(p,'encode-'+i,enc);wire(p,'unpack',i,'encode-'+i);
  box(p,'bytes-'+i,'unpack i i i');wire(p,'encode-'+i,0,'bytes-'+i);
  for(let k=0;k<3;k++)wire(p,'bytes-'+i,k,'snapshot',3*i+k);
 });save(`dpt_${voice.name}_midi.maxpat`,doc);
 doc=read(`rnbo_${voice.name}.maxpat`);p=doc.patcher;const n=voice.name;
 add(p,'dpt-bridge',`dpt_${n}_midi`);link(p,n+'-manual',1,'dpt-bridge');link(p,n+'-owned',0,'dpt-bridge');link(p,n+'-values',0,'dpt-bridge',1);
 add(p,'dpt-sync-values','zl reg');link(p,n+'-cache',0,'dpt-sync-values',1);link(p,'dpt-sync-values',0,'dpt-bridge',2);
 add(p,'dpt-sync-enabled','sel 1');add(p,'dpt-sync-receive','r dpt_sync');add(p,'dpt-sync-gate','gate 1 0');
 add(p,'dpt-enabled','r dpt_enabled');link(p,'dpt-enabled',0,'dpt-sync-enabled');add(p,'dpt-sync-defer','deferlow');p.lines=p.lines.filter(l=>!(l.patchline.source[0]==='dpt-sync-enabled'&&l.patchline.destination[0]==='dpt-sync-values'));link(p,'dpt-sync-enabled',0,'dpt-sync-defer');link(p,'dpt-sync-defer',0,'dpt-sync-values');link(p,'dpt-enabled',0,'dpt-sync-gate');link(p,'dpt-sync-receive',0,'dpt-sync-gate',1);link(p,'dpt-sync-gate',0,'dpt-sync-values');add(p,'dpt-local','!- 1');add(p,'dpt-local-signal','sig~ 1');add(p,'dpt-local-smooth','rampsmooth~ 240 240');link(p,'dpt-enabled',0,'dpt-local');link(p,'dpt-local',0,'dpt-local-signal');link(p,'dpt-local-signal',0,'dpt-local-smooth');
 for(const [suffix,gain] of [['left','obj-outputgain'],['right','obj-outputgain2']]){
  const id='dpt-mute-'+suffix;add(p,id,'*~');
  for(const l of p.lines)if(l.patchline.source[0]===gain&&l.patchline.destination[0]!==id)l.patchline.source=[id,0];
  link(p,gain,0,id);link(p,'dpt-local-smooth',0,id,1);
 }save(`rnbo_${n}.maxpat`,doc);
}
doc=read('rnbo_drum_lab.maxpat');p=doc.patcher;
if(!p.boxes.some(b=>b.box.id==='dpt-destination')){
 for(const {box:b} of p.boxes)if(b.presentation_rect&&b.presentation_rect[1]>=195)b.presentation_rect[1]+=68;
 p.rect[3]+=68;
}
add(p,'dpt-destination','', 'tab',{tabs:['Local RNBO','DPT USB MIDI'],presentation:1,presentation_rect:[20,193,270,28]});
add(p,'dpt-enable-send','s dpt_enabled');link(p,'dpt-destination',0,'dpt-enable-send');
add(p,'dpt-default','loadmess 0');link(p,'dpt-default',0,'dpt-destination');
add(p,'dpt-port','', 'umenu',{presentation:1,presentation_rect:[310,195,300,24],items:['Choose DPT MIDI port']});
add(p,'dpt-refresh','Refresh ports','textbutton',{presentation:1,presentation_rect:[625,195,115,24]});
add(p,'dpt-refresh-bang','t b');add(p,'dpt-midiinfo','midiinfo');link(p,'dpt-refresh',0,'dpt-refresh-bang');link(p,'dpt-refresh-bang',0,'dpt-midiinfo');add(p,'dpt-load','loadbang');link(p,'dpt-load',0,'dpt-midiinfo');link(p,'dpt-midiinfo',0,'dpt-port');
add(p,'dpt-sync-send','s dpt_sync');add(p,'dpt-port-order','t b s');link(p,'dpt-port',1,'dpt-port-order');link(p,'dpt-port-order',0,'dpt-sync-send');
 p.lines=p.lines.filter(l=>!(l.patchline.source[0]==='dpt-port'&&l.patchline.destination[0]==='dpt-port-prefix'));
 add(p,'dpt-port-prefix','prepend port');link(p,'dpt-port-order',1,'dpt-port-prefix');add(p,'dpt-out','midiout none @matchport 1');link(p,'dpt-port-prefix',0,'dpt-out');
add(p,'dpt-data','r dpt_midi_bytes');link(p,'dpt-data',0,'dpt-out');
add(p,'dpt-note','Choose the Daisy MIDI port, then DPT USB MIDI. Controls + locks go to DPT; listen to its audio outputs.','comment',{presentation:1,presentation_rect:[20,230,880,22]});
save('rnbo_drum_lab.maxpat',doc);
