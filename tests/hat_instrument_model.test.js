const test = require('node:test');
const assert = require('node:assert/strict');
const model = require('../hat_instrument_model');

test('hat model exposes twelve physical parameters over three pages',()=>{
 assert.equal(model.HAT_TRACK,12);
 assert.equal(model.HAT_LOCKS.length,12);
 assert.deepEqual(model.HAT_PAGES.map(page=>page.parameters.length),[4,4,4]);
 assert.deepEqual(new Set(model.HAT_PAGES.flatMap(page=>page.parameters)),new Set(model.HAT_LOCKS));
 for(const id of model.HAT_LOCKS){
  const def=model.definition(id);
  assert.equal(model.fromNormalized(id,0),def.gridMin);
  assert.equal(model.fromNormalized(id,1),def.gridMax);
  assert.equal(model.idForRNBO(def.rnbo),id);
  assert.equal(model.clampValue(id,NaN),def.initial);
 }
});

test('hat custom ranges retain scaling and reject reversed spans',()=>{
 const range={min:100,max:400};
 assert.ok(Math.abs(model.fromNormalized('hatPitch',.5,range)-200)<1e-10);
 assert.equal(model.toNormalized('hatPitch',800,range),1);
 assert.deepEqual(model.mappingRange('hatPitch',{min:400,max:100}),{min:300,max:1800});
 assert.equal(Object.keys(model.sanitize()).length,12);
});
