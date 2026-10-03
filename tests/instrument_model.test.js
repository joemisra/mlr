const test = require('node:test');
const assert = require('node:assert/strict');
const model = require('../instrument_model');
test('kick physical parameter mappings round trip and sanitize old or malformed state', () => {
 for (const id of model.KICK_LOCKS) {
  const def = model.definition(id);
  assert.equal(model.fromNormalized(id,0),def.gridMin);
  assert.equal(model.fromNormalized(id,1),def.gridMax);
  for (let i=0;i<=15;i++) assert.ok(Math.abs(model.toNormalized(id,model.fromNormalized(id,i/15))-i/15)<1e-12);
  assert.equal(model.clampValue(id,NaN),def.initial);
  assert.equal(model.clampValue(id,1e9),def.max);
 }
 assert.equal(Object.keys(model.sanitize()).length,12);
 for (const id of model.KICK_LOCKS) assert.equal(model.sanitize()[id],model.definition(id).initial);
 assert.equal(model.idForRNBO('fmIndex'),'kickFM');
 assert.equal(model.idForRNBO('drive'),'kickDrive');
});

test('custom grid ranges preserve nonlinear scaling and clamp display positions',()=>{
 const range={min:40,max:80};
 assert.equal(model.fromNormalized('kickPitch',0,range),40);
 assert.equal(model.fromNormalized('kickPitch',1,range),80);
 assert.ok(Math.abs(model.fromNormalized('kickPitch',.5,range)-Math.sqrt(3200))<1e-10);
 assert.equal(model.toNormalized('kickPitch',120,range),1);
 assert.deepEqual(model.mappingRange('kickPitch',{min:80,max:40}),{min:20,max:120});
});


test('expanded engine values survive storage and custom grid scaling',()=>{
 const values={kickPitch:1800,kickDecay:25000,kickFM:24};
 for (const id of Object.keys(values)) assert.equal(model.sanitize(values)[id],values[id]);
 for(const id of model.KICK_LOCKS){
  const def=model.definition(id), range={min:def.min,max:def.max};
  assert.equal(model.fromNormalized(id,1,range),def.max);
  assert.equal(model.fromNormalized(id,0,range),def.min);
 }
});
