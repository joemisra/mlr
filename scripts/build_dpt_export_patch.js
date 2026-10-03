#!/usr/bin/env node
// Silent, self-contained export harness. Does not subscribe to MLR or enable audio.
const fs=require('node:fs'),path=require('node:path');
const root=path.resolve(__dirname,'..');
const host=JSON.parse(fs.readFileSync(path.join(root,'rnbo_kick.maxpat')));
const rnbo=structuredClone(host.patcher.boxes.find(e=>e.box.id==='obj-rnbo').box);
rnbo.id='engine';rnbo.varname='dpt_export_engine';rnbo.text='rnbo~ @dumpoutlet 1';rnbo.patching_rect=[30,140,220,22];
rnbo.saved_object_attributes.uuid='9dd03d93-a123-442b-8f19-7022d7bd1131';
delete rnbo.snapshot;delete rnbo.presentation;delete rnbo.presentation_rect;
const inlet=rnbo.patcher.boxes.find(e=>e.box.id==='rnbo-in').box;
inlet.text='inport hit';inlet.rnbo_classname='inport';delete inlet.rnboinfo;delete inlet.rnbo_extra_attributes;
const voice=rnbo.patcher.boxes.find(e=>e.box.id==='rnbo-voice').box;
voice.text='p kick_core';voice.patcher=JSON.parse(fs.readFileSync(path.join(root,'rnbo_kick_voice.rnbopat'))).patcher;
const box=(id,text,x,y)=>({box:{id,maxclass:'newobj',text,patching_rect:[x,y,350,22]}});
const line=(a,b,o=0,i=0)=>({patchline:{source:[a,o],destination:[b,i]}});
const p={fileversion:1,appversion:host.patcher.appversion,rect:[100,100,730,300],boxes:[
 {box:{id:'note',maxclass:'comment',text:'DPT kick export — silent harness. Exports on open; no hardware flashing.',patching_rect:[30,25,660,22]}},
 {box:rnbo},box('script','v8 dpt_export.js',30,90),box('load','loadbang',400,90),
 {box:{id:'again',maxclass:'message',text:'bang',patching_rect:[400,130,60,22]}}
],lines:[line('load','script'),line('again','script'),line('script','engine'),line('engine','script',3)]};
fs.writeFileSync(path.join(root,'firmware/dpt/rnbo_kick_export.maxpat'),JSON.stringify({patcher:p},null,2)+'\n');
