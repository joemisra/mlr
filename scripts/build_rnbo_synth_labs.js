#!/usr/bin/env node
// Rebuild the four catalog-based labs from the shared adapter template.
// Commit/save any user-edited embedded range presets before regeneration.
const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto');
const root=path.resolve(__dirname,'..');
const {engines}=require(path.join(root,'synth_engine_catalog'));
const templateModel=require(path.join(root,'clap_instrument_model'));
const read=name=>fs.readFileSync(path.join(root,name),'utf8');
const write=(name,data)=>fs.writeFileSync(path.join(root,name),data);
const json=(name,data)=>write(name,JSON.stringify(data,null,4)+'\n');
for(const e of engines){
 const replacements={clap:e.id,Clap:e.name,CLAP:e.id.toUpperCase(),'Track 12':'Track '+(e.track+1),'13input':(e.track+2)+'input'};
 templateModel.CLAP_LOCKS.forEach((id,i)=>{
  replacements[id]=e.parameters[i].id;
  replacements[templateModel.definition(id).rnbo]=e.parameters[i].rnbo;
 });
 const escape=s=>s.replace(/[.*+?^${}()|[\]\\]/g,'\\$&');
 const re=new RegExp(Object.keys(replacements).sort((a,b)=>b.length-a.length).map(escape).join('|'),'g');
 const replace=s=>s.replace(re,key=>replacements[key]);
 const host=JSON.parse(replace(read('rnbo_clap.maxpat')));
 const boxes=Object.fromEntries(host.patcher.boxes.map(b=>[b.box.id,b.box]));
 const rnbo=boxes['obj-rnbo'];
 rnbo.saved_object_attributes.uuid=crypto.createHash('md5').update('mlr-original-'+e.id).digest('hex').replace(/(.{8})(.{4})(.{4})(.{4})(.{12})/,'$1-$2-$3-$4-$5');
 delete rnbo.snapshot;
 for(const [i,p] of e.parameters.entries()){
  const b=rnbo.patcher.boxes.find(b=>b.box.id==='rnbo-param-'+p.rnbo).box;
  b.text=`param ${p.rnbo} ${p.initial} @min ${p.min} @max ${p.max}`+(p.unit?` @unit ${p.unit}`:'');
  rnbo.rnboattrcache[p.rnbo].value=p.initial;
  for(const id of ['control-'+p.rnbo,p.id+'-min',p.id+'-max'])Object.assign(boxes[id],{minimum:p.min,maximum:p.max});
  boxes['label-'+p.rnbo].text=p.name+(p.unit?' · '+p.unit:'');
  boxes[p.id+'-range-label'].text=boxes['label-'+p.rnbo].text;
  for(const line of rnbo.patcher.lines){
   if(line.patchline.source[0]===b.id&&line.patchline.destination[0]==='rnbo-voice')line.patchline.destination[1]=i+1;
  }
 }
 boxes[e.id+'-cache'].text='pak '+e.parameters.map(p=>Number.isInteger(p.initial)?p.initial+'.0':p.initial).join(' ');
 boxes['obj-title'].text='RNBO '+e.name+' laboratory';
 boxes['obj-outputnote'].text='Audio buses stay active; combined lab selects stereo or eight external outputs.';
 boxes['obj-paramnote'].text='parameter bus: '+e.parameters[0].rnbo+' '+e.parameters[0].initial;
 boxes['obj-presets'].text='starting sounds: '+e.presets.map(p=>p.name).join(' / ');
 boxes['route-reserve'].text='r~ mlr_synth_es9_active';
 ['obj-deep','obj-knock','obj-hollow'].forEach((id,i)=>{
  boxes[id].text=e.parameters.map(p=>p.rnbo+' '+(e.presets[i].values[p.rnbo]??p.initial)).join(', ');
  boxes['choose-'+id].text=e.presets[i].name;
 });
 e.pageIndices.forEach((indices,i)=>{
  boxes['range-page-'+i].text=e.pageNames[i];
  indices.forEach((n,j)=>{
   const p=e.parameters[n],x=25+280*i,y=703+60*j;
   boxes['label-'+p.rnbo].presentation_rect.splice(0,2,x,220+68*j);
   boxes['control-'+p.rnbo].presentation_rect.splice(0,2,x,243+68*j);
   for(const [suffix,dx,dy] of [['range-label',0,0],['min-label',0,22],['min',40,22],['max-label',125,22],['max',165,22]]){
    for(const rect of ['presentation_rect','patching_rect'])if(boxes[p.id+'-'+suffix][rect])boxes[p.id+'-'+suffix][rect].splice(0,2,x+dx,y+dy);
   }
  });
 });
 json('rnbo_'+e.id+'.maxpat',host);
 const core=JSON.parse(read('rnbo_clap_voice.rnbopat'));
 const dsp=core.patcher.boxes.find(b=>b.box.id==='obj-dsp').box;
 dsp.code=read('rnbo_'+e.id+'_voice.genexpr').trimEnd();dsp.rnbo_extra_attributes.code=dsp.code;
 core.patcher.boxes.find(b=>b.box.id==='obj-title').box.text='MLR '+e.name+' core';
 json('rnbo_'+e.id+'_voice.rnbopat',core);
 write(e.id+'_lab_ranges.js',read('clap_lab_ranges.js').replace(/clap/g,e.id).replace(/CLAP/g,e.id.toUpperCase()));
 write(e.id+'_instrument_model.js',`var catalog; try { catalog = require("synth_engine_catalog.js"); } catch (error) { catalog = require("./synth_engine_catalog.js"); }\nvar factory; try { factory = require("instrument_parameter_model.js"); } catch (error) { factory = require("./instrument_parameter_model.js"); }\nvar model = factory.create(catalog.engines.filter(function (e) { return e.id === "${e.id}"; })[0]);\nObject.keys(model).forEach(function (key) { exports[key] = model[key]; });\n`);
}

// Restore native DPT routing after regenerating the template-based labs.
require("./build_dpt_lab");
