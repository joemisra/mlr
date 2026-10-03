const test=require('node:test'),assert=require('node:assert/strict'),L=require('../grid_label');
test('bitmap fits the top eight rows and uses a timed hold and fade',()=>{
 const mask=L.bitmap('BODY',16,16);
 assert.ok(mask.some(Boolean));assert.equal(mask.slice(128).some(Boolean),false);
 assert.equal(L.opacity(499),1);assert.equal(L.opacity(750),.5);assert.equal(L.opacity(1000),0);
 assert.equal(L.level(4,true,1),15);assert.equal(L.level(4,false,1),2);assert.equal(L.level(4,true,0),4);
 assert.deepEqual(L.color([20,70,90],true,0),[20,70,90]);
 assert.equal(L.bitmap('PITCH',8,8).length,64);
});
