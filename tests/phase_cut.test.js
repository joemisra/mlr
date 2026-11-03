const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const Phase=require('../phase_cut_model.js');
test('phase controls bound unsafe values and keep separate preset copies',()=>{
 const cut=Phase.sanitize({enabled:5,division:5,chance:Infinity,range:999,repeat:-1,wet:2,fade_ms:0,presets:[{range:2}]});
 assert.equal(cut.enabled,0);assert.equal(cut.division,4);assert.equal(cut.range,16);assert.equal(cut.repeat,0);assert.equal(cut.wet,1);assert.equal(cut.fade_ms,2);
 assert.equal(cut.presets.length,4);assert.equal(Phase.valid(cut),true);
 cut.presets[0].range=8;assert.equal(cut.range,16);
 for(const factory of Phase.FACTORIES)assert.equal(Phase.valid(Phase.sanitize(factory.values)),true);
});
test('phase reader is before the existing fade and strip, with untouched base sync telemetry',()=>{
 const p=JSON.parse(fs.readFileSync(path.join(__dirname,'../pl.maxpat'),'utf8')).patcher;
 const wire=(s,o,d,i)=>p.lines.some(e=>JSON.stringify(e.patchline.source)===JSON.stringify([s,o])&&JSON.stringify(e.patchline.destination)===JSON.stringify([d,i]));
 for(let i=0;i<2;i++){assert.ok(wire('obj-98',i,'obj-phasecut',i));assert.ok(wire('obj-phasecut',i,'obj-1',i));assert.equal(wire('obj-98',i,'obj-1',i),false);}
 assert.ok(wire('obj-98',2,'obj-phasecut',2));assert.ok(wire('obj-98',2,'obj-112',0));
 assert.ok(wire('obj-94',1,'obj-phasecut',6));
 for(const e of p.lines){const w=e.patchline;if(w.destination[0]==='obj-98'&&w.destination[1]>0&&!w.disabled)assert.ok(wire(w.source[0],w.source[1],'obj-phasecut',w.destination[1]+3));}
 const reader=JSON.parse(fs.readFileSync(path.join(__dirname,'../mlr_phase_cut.maxpat'),'utf8')).patcher;
 assert.equal(reader.boxes.some(e=>e.box.text==='reset'),false,'changing source must preserve controls and buffer association');
 assert.ok(reader.boxes.some(e=>e.box.text==='prepend epoch'));
});

test('triplet and 64th rates and slice ramps survive presets, including legacy flat sessions',()=>{
 const labels=['1/4','1/8','1/8T','1/16','1/16T','1/32','1/32T','1/64'];
 assert.deepEqual(Phase.CHOICES.division.map(Phase.rateLabel),labels);
 for(const division of Phase.CHOICES.division)for(const ramp of Phase.CHOICES.ramp){
  const cut=Phase.sanitize({division,ramp,presets:[{division,ramp}]});
  assert.equal(Phase.valid(cut),true);assert.equal(cut.division,division);assert.equal(cut.ramp,ramp);
  assert.deepEqual(Phase.sanitize(JSON.parse(JSON.stringify(cut))),cut);
 }
 const legacy=Phase.sanitize({presets:[{}]});delete legacy.ramp;delete legacy.presets[0].ramp;
 assert.equal(Phase.valid(legacy),true);
 assert.equal(Phase.sanitize(legacy).ramp,0);assert.equal(Phase.sanitize(legacy).presets[0].ramp,0);
 assert.equal(Phase.valid({...legacy,ramp:3}),false);
});
