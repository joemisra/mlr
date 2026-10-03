const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
function read(name){return JSON.parse(fs.readFileSync(path.join(__dirname,'..',name))).patcher;}
function boxes(p){return Object.fromEntries(p.boxes.map(({box})=>[box.id,box]));}
function connected(p,s,o,d,i){return p.lines.some(({patchline:e})=>e.source[0]===s&&e.source[1]===o&&e.destination[0]===d&&e.destination[1]===i);}
test('optional native bridge sends frames directly while deferring only polled observations and acknowledgements',()=>{
 const p=read('sequence64_native_bridge.maxpat'),b=boxes(p);
 assert.equal(b.player.text,'mlr.sequence_player production');
 assert.ok(connected(p,'pulse',0,'player',1));assert.ok(connected(p,'control',0,'player',0));
 assert.ok(connected(p,'player',0,'frame',0));assert.equal(b.frame.text,'s sequence64_native_frame');
 assert.ok(connected(p,'player',1,'report-prefix',0));assert.ok(connected(p,'report-prefix',0,'report-defer',0));
 assert.ok(connected(p,'report-defer',0,'report',0));assert.equal(b.report.text,'s gridrouter');
 assert.ok(connected(p,'cancel',0,'cancel-prefix',0));assert.equal(b['cancel-prefix'].text,'prepend cancelcurrent');
 assert.ok(connected(p,'cancel-prefix',0,'player',0));assert.equal(b['stop-receive'].text,'r [mlr]stop');
 assert.ok(connected(p,'stop-receive',0,'stop',0));assert.ok(connected(p,'stop',0,'player',0));
 assert.equal(b['observe-clock'].text,'qmetro 33');assert.ok(connected(p,'observe',0,'player',0));
 assert.ok(connected(p,'hello-unpack',2,'hello-version',0));assert.equal(b['hello-version'].text,'sel 1');
 assert.ok(connected(p,'hello-version',0,'observe-on',0));
 assert.equal(connected(p,'load',0,'observe-on',0),false,'older binaries cannot start a polling error loop');
 assert.ok(connected(p,'offline',0,'report',0),'closing notification survives destruction of deferlow');
 const dispatch=read('sequence64_audio_bridge.maxpat');
 assert.ok(connected(dispatch,'native-frame',0,'obj-actiontrigger',0));
});
test('integration probe uses actual embedded voices and production parameter-before-press routing without hardware output',()=>{
 const p=read('sequence64_native_integration_probe.maxpat'),b=boxes(p);
 assert.equal(b.player.text,'sequence64_native_bridge');assert.equal(b.router.text,'v8 grid_router.js @autowatch 0');
 assert.deepEqual(b.dispatch.patcher,read('sequence64_audio_bridge.maxpat'));
 ['kick','snare','hat','clap','tom','rim'].forEach((id,ch)=>{
  const lab=boxes(read('rnbo_'+id+'.maxpat'));
  assert.deepEqual(b[id+'-voice'].patcher,lab['obj-rnbo'].patcher);
  assert.equal(b[id+'-step'].text,'r rnbo_'+id+'_step');assert.equal(b[id+'-press'].text,'r '+(16-ch)+'input');
  assert.equal(b[id+'-order'].text,'t b b');assert.ok(connected(p,id+'-order',1,id+'-values',0));
  assert.ok(connected(p,id+'-values',0,id+'-unpack',0));assert.ok(connected(p,id+'-order',0,id+'-voice',0));
  assert.ok(connected(p,id+'-voice',0,'record',ch));
 });
 assert.equal(b.record.text,'record~ #0native_probe 7');
 for(const box of p.boxes.map(({box})=>box).filter(box=>box.maxclass==='newobj'))
  assert.doesNotMatch(box.text,/^(?:[er]?adc~|[er]?dac~|send~|s~)\b/);
});
