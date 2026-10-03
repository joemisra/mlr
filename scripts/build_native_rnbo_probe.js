// Build a hardware-silent capture using the actual embedded RNBO drum voices.
const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
const patch = JSON.parse(fs.readFileSync(path.join(root, 'sequence64_native_probe.maxpat'))).patcher;
const removed = /^(hit|click)\d$/;
patch.boxes = patch.boxes.filter(({box}) => !removed.test(box.id));
patch.lines = patch.lines.filter(({patchline}) => !removed.test(patchline.source[0]) && !removed.test(patchline.destination[0]));
const boxes = Object.fromEntries(patch.boxes.map(({box}) => [box.id, box]));
boxes.title.text = 'Native RNBO probe — six actual voices plus a click reference; no hardware audio output';
boxes.record.text = 'record~ #0native_probe 7';
boxes.buffer.text = 'buffer~ #0native_probe 10000 7';
boxes.write.text = 'writewave /tmp/mlr-native-rnbo-probe.wav';
boxes.writenote.text = 'Seven-channel capture: kick, snare, hat, clap, tom, rim, then native click reference. One hit per second.';
const messages = ['begin 1 1 16'];
function add(id, text, x, y) {
    patch.boxes.push({box:{id,maxclass:'newobj',text,patching_rect:[x,y,200,22]}});
}
function connect(source,outlet,destination,inlet) {
    patch.lines.push({patchline:{source:[source,outlet],destination:[destination,inlet]}});
}
['kick','snare','hat','clap','tom','rim'].forEach((id, channel) => {
    const lab = JSON.parse(fs.readFileSync(path.join(root, 'rnbo_'+id+'.maxpat'))).patcher;
    const model = require(path.join(root,id === 'kick' ? 'instrument_model.js' : id+'_instrument_model.js'));
    const locks = model[id.toUpperCase()+'_LOCKS'];
    const baseline = model.sanitize({});
    // Short tails provide quiet pre-hit windows for onset measurement.
    for (const parameter of locks) if (/Decay$/.test(parameter)) baseline[parameter] = model.clampValue(parameter, 30);
    messages.push(['event',1,1,0,channel+1,16-channel,0,...locks.map((parameter) => baseline[parameter])].join(' '));
    const rnbo = JSON.parse(JSON.stringify(lab.boxes.find(({box}) => box.id === 'obj-rnbo').box));
    rnbo.id = id+'-voice'; rnbo.varname = id+'_probe_voice'; rnbo.autosave = 0;
    rnbo.text = 'rnbo~ @title mlr-'+id+'-native-probe @dumpoutlet 1';
    delete rnbo.snapshot; delete rnbo.saved_attribute_attributes;
    delete rnbo.saved_object_attributes.uuid;
    rnbo.patching_rect = [channel*260+40,1800,245,22];
    patch.boxes.push({box:rnbo});
    add(id+'-slice','zl slice 2',channel*260+40,1550);
    add(id+'-order','t b l',channel*260+40,1600);
    add(id+'-unpack','unpack '+locks.map(() => 'f').join(' '),channel*260+40,1650);
    connect('route',channel,id+'-slice',0);
    connect(id+'-slice',1,id+'-order',0);
    connect(id+'-order',1,id+'-unpack',0);
    connect(id+'-order',0,rnbo.id,0);
    // Copy each lab's exact parameter-name adapter from its cached unpack path.
    locks.forEach((parameter,index) => {
        const edge = lab.lines.find(({patchline}) => patchline.source[0] === id+'-unpack' && patchline.source[1] === index).patchline;
        const adapter = lab.boxes.find(({box}) => box.id === edge.destination[0]).box;
        add(id+'-param-'+index,adapter.text,channel*260+40,1700+index*26);
        connect(id+'-unpack',index,id+'-param-'+index,0);
        connect(id+'-param-'+index,0,rnbo.id,0);
    });
    connect(rnbo.id,0,'record',channel);
});
messages.push('commit 1 1'); boxes.fixture.text = messages.join(', ');
add('reference-bang','t b',1600,1550); add('reference-click','click~',1600,1600);
connect('route',0,'reference-bang',0); connect('reference-bang',0,'reference-click',0);
connect('reference-click',0,'record',6);
fs.writeFileSync(path.join(root,'sequence64_native_rnbo_probe.maxpat'),JSON.stringify({patcher:patch},null,2)+'\n');
