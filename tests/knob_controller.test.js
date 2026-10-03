const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const model = require('../knob_controller_model');
test('pickup catches proximity or crossing, suppresses duplicates and rearms after external edits', () => {
 const p = new model.Pickup();
 assert.equal(p.move(1,10,.5,'kick').accepted,false);
 assert.equal(p.move(1,80,.5,'kick').accepted,true);
 p.commit(1,80/127);
 assert.equal(p.move(1,80,80/127,'kick').accepted,false);
 assert.equal(p.move(1,90,80/127,'kick').accepted,true);
 p.commit(1,90/127);
 assert.equal(p.move(1,100,.2,'kick').accepted,false);
 assert.equal(p.move(1,95,.2,'snare').accepted,false);
 assert.equal(p.move(1,25,.2,'snare').accepted,true);
 assert.equal(p.move(1,-1,.2,'snare').accepted,false);
 p.reset();assert.equal(p.move(1,110,.2,'snare').accepted,false);
});
function inputHarness() {
 const messages=[],outlets=[],stores={},runtime={epoch:1,live:false},tasks=[];
 function Task(callback,owner){this.callback=callback;this.owner=owner;tasks.push(this);}
 Task.prototype.schedule=function(delay){this.delay=delay;};
 Task.prototype.cancel=function(){this.delay=null;};
 function Dict(name) { this.name=name; }
 Dict.prototype.stringify=function(){return JSON.stringify(stores[this.name]||{});};
 Dict.prototype.parse=function(json){stores[this.name]=JSON.parse(json);};
 const c=vm.createContext({Dict,Task,Global:function(){return runtime;},require:()=>model,arrayfromargs:a=>Array.from(a),
  messnamed:(...a)=>messages.push(a),outlet:(...a)=>outlets.push(a)});
 vm.runInContext(fs.readFileSync(path.join(__dirname,'../mlr_knob_input.js'),'utf8'),c);
 c.loadbang();return {c,messages,outlets,stores,runtime,tasks};
}
test('CC 32–47 routes one-based knob numbers, filtering channel and other CCs', () => {
 const {c,messages}=inputHarness();c.cc(64,32,1);assert.equal(messages.length,0);
 c.port('hachi-ni');messages.length=0;
 for(let i=0;i<16;i++)c.cc(70,32+i,1);
 assert.equal(messages.length,0);c.flush();
 assert.equal(messages.length,1);assert.deepEqual(messages[0].slice(0,3),['gridrouter','knobBatch',1]);
 assert.deepEqual(JSON.parse(messages[0][3]),Array.from({length:16},(_,i)=>({knob:i+1,first:70,last:70,bar:-1,step:-1})));
 messages.length=0;c.cc(60,31,1);c.cc(60,48,1);c.cc(60,32,2);c.cc(-1,32,1);
 assert.equal(messages.length,0);
 c.channel(2);messages.length=0;c.cc(50,32,1);c.cc(50,32,2);
 c.flush();assert.equal(messages.length,1);assert.equal(JSON.parse(messages[0][3])[0].knob,1);
 c.port('all');assert.equal(c.inputPort,'hachi-ni');
});
test('MIDI learn consumes repeated movement safely and only commits complete maps', () => {
 const {c,messages,stores}=inputHarness();c.port('hachi-ni');c.learn();messages.length=0;
 for(let i=0;i<16;i++){c.cc(30,i+60,3);c.cc(40,i+60,3);}
 // Last repeated movement may edit after learning finishes; everything before
 // completion was consumed and no knob was assigned twice.
 assert.deepEqual(stores.mlr_knob_bindings.bindings,Array.from({length:16},(_,i)=>({cc:60+i,channel:3})));
 assert.equal(messages.length,0);c.flush();assert.equal(messages.length,1);
 assert.equal(JSON.parse(messages[0][3])[0].knob,16);
 c.learn();c.cc(0,10,1);c.cancel();
 assert.equal(c.bindings[0].cc,60);
 stores.bad={bindings:Array(16).fill({cc:32,channel:1})};c.dictionary('bad');
 assert.equal(c.bindings[0].cc,60);
 assert.equal(model.sanitizeBindings(Array(16).fill({cc:1,channel:1})),null);
});
test('MIDI topology packs value/CC/channel before deferring and selects inputs rather than outputs', () => {
 const p=JSON.parse(fs.readFileSync(path.join(__dirname,'../mlr_knob_input.maxpat'))).patcher;
 const b=id=>p.boxes.find(x=>x.box.id===id).box;
 const wire=(a,o,d,i=0)=>p.lines.some(x=>JSON.stringify(x.patchline.source)===JSON.stringify([a,o])&&JSON.stringify(x.patchline.destination)===JSON.stringify([d,i]));
 assert.equal(b('input').text,'ctlin none @matchport 1');
 for(let i=0;i<3;i++)assert.ok(wire('input',i,'pack',i));
 assert.ok(wire('pack',0,'defer'));assert.ok(wire('defer',0,'cc'));
 assert.ok(wire('refresh-message',0,'info',1));assert.ok(wire('load-inputs',0,'info',1));
 assert.ok(wire('script',1,'input'));assert.ok(wire('map',0,'script'));
 for(const file of ['mlr_knob_input.maxpat','rnbo_drum_lab.maxpat']) {
  const p=JSON.parse(fs.readFileSync(path.join(__dirname,'..',file))).patcher;
  const ids=new Set(p.boxes.map(x=>x.box.id));
  assert.equal(ids.size,p.boxes.length);
  for(const l of p.lines){assert.ok(ids.has(l.patchline.source[0]));assert.ok(ids.has(l.patchline.destination[0]));}
 }
});

test('thousands of MIDI CCs become one bounded frame with pickup endpoints and latest values', () => {
 const {c,messages,tasks}=inputHarness();c.port('hachi-ni');messages.length=0;
 for(let i=0;i<4000;i++)c.cc(i%128,32+(i%12),1);
 assert.equal(messages.length,0);assert.equal(tasks[0].delay,33);
 c.flush();assert.equal(messages.length,1);
 const values=JSON.parse(messages[0][3]);assert.equal(values.length,12);
 for(let k=0;k<12;k++){
  const v=values.find(v=>v.knob===k+1);
  const last=3999-((3999-k)%12);
  assert.equal(v.first,k);assert.equal(v.last,last%128);
 }
 c.flush();assert.equal(messages.length,1); // trailing flush has no backlog
 c.cc(values[0].last,32+values[0].knob-1,1);c.flush();assert.equal(messages.length,1);
});
test('pending MIDI cannot leak across disconnect, learning, remapping, focus epochs or live step boundaries', () => {
 const {c,messages,runtime}=inputHarness();c.port('hachi-ni');messages.length=0;
 c.cc(40,32,1);runtime.epoch++;c.flush();assert.equal(messages.length,0);
 c.cc(40,32,1);c.flush();assert.equal(messages.length,1); // same physical value, new focus
 messages.length=0;c.cc(70,32,1);c.port('none');messages.length=0;c.flush();assert.equal(messages.length,0);
 c.port('hachi-ni');c.cc(30,32,1);c.channel(2);messages.length=0;c.flush();assert.equal(messages.length,0);
 c.cc(60,32,2);c.learn();messages.length=0;c.flush();assert.equal(messages.length,0);c.cancel();
 runtime.live=true;runtime.bar=0;runtime.step=3;
 c.cc(20,32,2);runtime.step=4;c.cc(100,32,2);messages.length=0;c.flush();
 assert.deepEqual(JSON.parse(messages[0][3]),[{knob:1,first:100,last:100,bar:0,step:4}]);
});
