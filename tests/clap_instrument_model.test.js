const test=require('node:test');
const assert=require('node:assert/strict');
const m=require('../clap_instrument_model');
test('clap maps twelve controls across three pages and quantizes burst count',()=>{
 assert.equal(m.CLAP_TRACK,11);
 assert.equal(m.CLAP_LOCKS.length,12);
 assert.deepEqual(new Set(m.CLAP_PAGES.flatMap(p=>p.parameters)),new Set(m.CLAP_LOCKS));
 for(const id of m.CLAP_LOCKS){
  const d=m.definition(id);
  assert.equal(m.fromNormalized(id,0),d.gridMin);
  assert.equal(m.fromNormalized(id,1),d.gridMax);
  assert.equal(m.idForRNBO(d.rnbo),id);
  assert.equal(m.clampValue(id,NaN),d.initial);
 }
 assert.equal(m.clampValue('clapCount',3.7),4);
 assert.equal(m.clampValue('clapCount',100),8);
 for(let i=0;i<=16;i++)assert.ok(Number.isInteger(m.fromNormalized('clapCount',i/16)));
 assert.equal(m.sanitize({clapCount:4.2}).clapCount,4);
 assert.equal(m.fromNormalized('clapFilterHz',.5,{min:500,max:2000}),1000);
});
