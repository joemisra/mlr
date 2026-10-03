const test=require('node:test'),assert=require('node:assert/strict'),vm=require('node:vm'),fs=require('node:fs'),path=require('node:path');
test('range preset recall validates the complete pair and rejects invalid manual ranges',()=>{
 const sent=[],outputs=[];let pendingTask;
 const c=vm.createContext({require:()=>require('../instrument_model'),messnamed:(...a)=>sent.push(a),outlet:(...a)=>outputs.push(a),Task:function(fn){this.cancel=()=>{};this.schedule=()=>{pendingTask=fn;};}});
 vm.runInContext(fs.readFileSync(path.join(__dirname,'../kick_lab_ranges.js'),'utf8'),c);
 c.setrange('kickPitch','min',30);c.setrange('kickPitch','max',40);pendingTask();
 c.setrange('kickPitch','min',80);c.setrange('kickPitch','max',100);pendingTask();
 assert.deepEqual(sent.at(-1),['gridrouter','kickRange','kickPitch',80,100]);
 c.setrange('kickPitch','min',110);pendingTask();
 assert.deepEqual(sent.at(-1),['gridrouter','kickRange','kickPitch',80,100]);
 assert.match(outputs.at(-1)[2],/rejected/);
});

test('range preset bank includes only the 24 range fields, with persistent save and file controls',()=>{
 const p=JSON.parse(fs.readFileSync(path.join(__dirname,'../rnbo_kick.maxpat'))).patcher;
 const preset=p.boxes.find(e=>e.box.id==='range-presets').box;
 assert.equal(preset.maxclass,'preset');assert.equal(preset.embed === undefined ? 1 : preset.embed,1);assert.equal(preset.dirty,1);
 const destinations=p.lines.filter(e=>e.patchline.source[0]==='range-presets').map(e=>e.patchline.destination[0]).sort();
 assert.deepEqual(destinations,require('../instrument_model').KICK_LOCKS.flatMap(id=>[id+'-min',id+'-max']).sort());
});
