const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const read=f=>JSON.parse(fs.readFileSync(path.join(__dirname,'..',f),'utf8')).patcher;
const box=(p,id)=>p.boxes.find(e=>e.box.id===id)?.box;
const wired=(p,a,b,o=0,i=0)=>p.lines.some(e=>e.patchline.source[0]===a&&e.patchline.source[1]===o&&e.patchline.destination[0]===b&&e.patchline.destination[1]===i);
test('6mix sends four independent mono voices to USB 9–12 with a bounded smoothed level',()=>{
 const p=read('rnbo_drum_outputs.maxpat');assert.equal(box(p,'dac').text,'dac~ 9 10 11 12 13 14 15 16');
 assert.equal(box(p,'level-clip').text,'clip 0. 1.');assert.equal(box(p,'mode-signal').text,'sig~ 0.');
 assert.ok(wired(p,'level','level-clip'));assert.ok(wired(p,'level-clip','level-pack'));assert.ok(wired(p,'level-pack','level-signal'));assert.ok(wired(p,'level-signal','send-gain'));assert.ok(wired(p,'mode-smooth','send-gain',0,1));
 ['kick','snare','hat','clap'].forEach((name,i)=>{
  assert.equal(box(p,name+'-in').text,'r~ rnbo_'+name+'_left');
  assert.ok(wired(p,name+'-in',name+'-gain'));assert.ok(wired(p,'send-gain',name+'-gain',0,1));assert.ok(wired(p,name+'-gain','dac',0,i));
 });
 assert.equal(box(p,'reservation').text,'s~ mlr_drum_es9_active');
 assert.ok(wired(p,'mode-signal','reserved-max'));assert.ok(wired(p,'mode-smooth','reserved-max',0,1));assert.ok(wired(p,'reserved-max','reserved-active'));assert.ok(wired(p,'reserved-active','reservation'));
});
test('CV configuration is preserved and occupied jack banks are independently interlocked',()=>{
 const p=read('mlr_cv_outputs.maxpat');assert.equal(box(p,'drum-reservation').text,'r~ mlr_drum_es9_active');assert.equal(box(p,'drum-cv-free').text,'!-~ 1.');
 assert.ok(wired(p,'drum-reservation','drum-cv-free'));assert.ok(wired(p,'drum-cv-free','drum-cv-level',0,1));assert.ok(wired(p,'obj-config-sig','drum-cv-level'));
 for(let i=1;i<=8;i++)assert.ok(wired(p,i<=4?'drum-cv-level':'synth-cv-level','obj-level'+i,0,1));
});
test('each lab gates only its stereo DAC feed, leaving the individual signal buses intact',()=>{
 for(const name of ['kick','snare','hat','clap']){
  const p=read('rnbo_'+name+'.maxpat');assert.equal(box(p,'route-reserve').text,'r~ mlr_drum_es9_active');
  assert.ok(wired(p,'route-reserve','route-stereo'));assert.ok(wired(p,'route-stereo','route-smooth'));
  for(const [gain,side,send,port] of [['obj-outputgain','left','obj-sendleft',0],['obj-outputgain2','right','obj-sendright',1]]){
   assert.ok(wired(p,gain,'dpt-mute-'+side));assert.ok(wired(p,'dpt-mute-'+side,send));assert.ok(wired(p,'dpt-mute-'+side,'route-'+side));assert.ok(wired(p,'route-smooth','route-'+side,0,1));assert.ok(wired(p,'route-'+side,'audio-switch',0,port));assert.equal(wired(p,gain,'audio-switch',0,port),false);
  }
 }
 const host=read('rnbo_drum_lab.maxpat');assert.equal(box(host,'output-default').text,'loadmess 0');assert.ok(wired(host,'output-mode','outputs'));assert.ok(wired(host,'output-level','outputs',0,1));
});
