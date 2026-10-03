const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const patch = JSON.parse(fs.readFileSync(path.join(__dirname, '../sequence64_native_probe.maxpat'))).patcher;
const boxes = Object.fromEntries(patch.boxes.map(({box}) => [box.id, box]));
const edges = patch.lines.map(({patchline}) => patchline);
function connected(source, outlet, destination, inlet) {
    return edges.some((edge) => edge.source[0] === source && edge.source[1] === outlet &&
        edge.destination[0] === destination && edge.destination[1] === inlet);
}
test('native probe isolates the pulse and six recorded outputs from V8 and production buses', () => {
    assert.equal(boxes.player.text, 'mlr.sequence_player');
    assert.ok(connected('phase',0,'half',0));
    assert.ok(connected('half',0,'edge',0));
    assert.ok(connected('edge',0,'player',1));
    assert.equal(edges.filter((edge) => edge.destination[0] === 'player' && edge.destination[1] === 1).length, 1);
    assert.ok(connected('player',0,'route',0));
    for (let channel = 0; channel < 6; channel++) {
        assert.ok(connected('route',channel,'hit'+channel,0));
        assert.ok(connected('hit'+channel,0,'click'+channel,0));
        assert.ok(connected('click'+channel,0,'record',channel));
    }
    assert.equal(boxes.record.text, 'record~ #0native_probe 6');
    assert.equal(boxes.buffer.text, 'buffer~ #0native_probe 10000 6');
    for (const box of Object.values(boxes).filter((box) => box.maxclass === 'newobj'))
        assert.doesNotMatch(box.text, /^(?:[er]?adc~|[er]?dac~|send|receive|s|r|rnbo~|node\.script)\b/);
    assert.ok(connected('stallclock',0,'stallscript',0));
    assert.equal(edges.filter((edge) => edge.source[0] === 'stallscript').length, 1);
    assert.ok(connected('stallscript',0,'stallreport',0));
});
test('native probe publishes a complete fixture without starting playback on load', () => {
    const messages = boxes.fixture.text.split(',').map((message) => message.trim().split(/\s+/));
    assert.deepEqual(messages[0], ['begin','1','1','4']);
    assert.deepEqual(messages.at(-1), ['commit','1','1']);
    assert.equal(messages.length, 8);
    messages.slice(1,-1).forEach((message, group) => {
        assert.equal(message.length, 19);
        assert.deepEqual(message.slice(0,7), ['event','1','1','0',String(group+1),String(16-group),'0']);
        assert.ok(message.slice(7).every((value) => value === '1'));
    });
    assert.deepEqual(edges.filter((edge) => edge.source[0] === 'load').map((edge) => edge.destination), [['fixture',0]]);
    assert.ok(connected('fixture',0,'player',0));
    assert.ok(connected('runorder',1,'record',0));
    assert.ok(connected('runorder',0,'runsel',0));
});
