const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const root=path.join(__dirname,'..');
const p=JSON.parse(fs.readFileSync(path.join(root,'rnbo_drum_lab.maxpat'),'utf8')).patcher;
const box=id=>p.boxes.find(e=>e.box.id===id).box;
const wired=(a,o,b)=>p.lines.some(e=>e.patchline.source[0]===a&&e.patchline.source[1]===o&&e.patchline.destination[0]===b);
test('drum lab loads exactly one of each existing voice and keeps scrollable controls',()=>{
 const labs=p.boxes.map(e=>e.box).filter(b=>b.maxclass==='bpatcher');
 assert.equal(labs.length,8);
 for(const name of ['kick','snare','hat','clap','tom','rim','bell','bass']){
  const b=box('lab-'+name);
  assert.equal(b.name,`rnbo_${name}.maxpat`);
  assert.equal(b.enablevscroll,1);
  assert.equal(b.hidden,name==='kick'?0:1);
  const child=JSON.parse(fs.readFileSync(path.join(root,b.name),'utf8')).patcher;
  assert.equal(child.openinpresentation,1);
  assert.equal(child.boxes.filter(e=>e.box.text?.startsWith('rnbo~')).length,1);
 }
});
test('tabs change visibility only and initialize the kick view',()=>{
 assert.ok(wired('initial',0,'defer'));assert.ok(wired('defer',0,'tabs'));assert.ok(wired('tabs',0,'select'));
 ['kick','snare','hat','clap','tom','rim','bell','bass'].forEach((name,i)=>{
  assert.ok(wired('select',i,'show-'+name));assert.ok(wired('show-'+name,0,'window'));
  const commands=box('show-'+name).text.split(', ');
  assert.equal(commands.length,8);
  assert.equal(commands.filter(c=>c.startsWith('script show ')).length,1);
  assert.ok(commands.includes('script show lab_'+name));
  for(const other of ['kick','snare','hat','clap','tom','rim','bell','bass'].filter(n=>n!==name))assert.ok(commands.includes('script hide lab_'+other));
 });
 assert.equal(p.boxes.some(e=>/poly~|mute |replace |rnbo_.*trigger/.test(e.box.text||'')),false);
});
