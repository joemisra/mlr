const test = require('node:test');
const assert = require('node:assert/strict');
const model = require('../snare_instrument_model');

test('snare model exposes twelve physical parameters over three pages',()=>{
 assert.equal(model.SNARE_TRACK,13);
 assert.equal(model.SNARE_LOCKS.length,12);
 assert.deepEqual(model.SNARE_PAGES.map(page=>page.parameters.length),[4,4,4]);
 assert.deepEqual(new Set(model.SNARE_PAGES.flatMap(page=>page.parameters)),new Set(model.SNARE_LOCKS));
 for(const id of model.SNARE_LOCKS){
  const def=model.definition(id);
  assert.equal(model.fromNormalized(id,0),def.gridMin);
  assert.equal(model.fromNormalized(id,1),def.gridMax);
  assert.equal(model.idForRNBO(def.rnbo),id);
  assert.equal(model.clampValue(id,NaN),def.initial);
 }
});

test('snare custom ranges retain scaling and reject reversed spans',()=>{
 const range={min:100,max:400};
 assert.ok(Math.abs(model.fromNormalized('snareBodyHz',.5,range)-200)<1e-10);
 assert.equal(model.toNormalized('snareBodyHz',800,range),1);
 assert.deepEqual(model.mappingRange('snareBodyHz',{min:400,max:100}),{min:90,max:320});
 assert.equal(Object.keys(model.sanitize()).length,12);
});
