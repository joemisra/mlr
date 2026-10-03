const test = require('node:test');
const assert = require('node:assert/strict');
const {compile} = require('../sequence64_native_compile');
const kick = require('../instrument_model');

function fixture(length = 4) {
    const snapshot = {patterns: {}, tracks: Array.from({length:16}, () => ({group:7,buffer:0}))};
    [14,13,12,11,10,9].forEach((track, group) => {
        snapshot.tracks[track].group = group;
        snapshot.patterns['group:'+group] = {rateNumerator:1,rateDenominator:1,bars:[{length,steps:
            Array.from({length}, (_,step) => ({cut:step === 0 ? {track,slice:0,gateLength:1} : null,
                locks:{},condition:0,probability:15}))}]};
    });
    return snapshot;
}
const options = {epoch:1,generation:1,groupIds:[0,1,2,3,4,5]};
test('native compiler rejects invalid equal rates instead of accepting them as 1×', () => {
    for (const value of [0, -1, 17, 1.5]) {
        const source = fixture();
        source.patterns['group:0'].rateNumerator = value;
        source.patterns['group:0'].rateDenominator = value;
        assert.throws(() => compile(source, options), /invalid.*rate numerator/);
    }
});
test('native compiler prepares six complete simultaneous frames without starting transport', () => {
    const source = fixture(); const before = JSON.stringify(source);
    const plan = compile(source, options);
    assert.equal(plan.length, 4); assert.equal(plan.eventCount, 6);
    assert.deepEqual(plan.messages[0], ['begin',1,1,4]);
    assert.deepEqual(plan.messages.at(-1), ['commit',1,1]);
    assert.deepEqual(plan.messages.slice(1,-1).map((message) => message.slice(3,6)),
        [[0,1,16],[0,2,15],[0,3,14],[0,4,13],[0,5,12],[0,6,11]]);
    assert.ok(plan.messages.slice(1,-1).every((message) => message.length === 19 && message.slice(7).every(Number.isFinite)));
    assert.equal(plan.messages.some((message) => message[0] === 'start'), false);
    assert.equal(JSON.stringify(source), before);
});
test('native compiler folds instrument locks into a hit and restores baseline on the next hit', () => {
    const source = fixture(); const steps = source.patterns['group:0'].bars[0].steps;
    source.tracks[14].instrumentParameters = {kickPitch:72};
    steps[0].locks.kickPitch = {value:1800,behavior:'set'};
    steps[1].cut = {track:14,slice:1,gateLength:1};
    steps[1].locks.slice = {value:5,behavior:'set'};
    const frames = compile(source,{...options,groupIds:[0]}).messages.filter((message) => message[0] === 'event');
    assert.equal(frames[0][7], 1800); assert.equal(frames[1][7], 72); assert.equal(frames[1][6], 5);
    assert.deepEqual(frames[1].slice(7),kick.KICK_LOCKS.map((id) => kick.sanitize(source.tracks[14].instrumentParameters)[id]));
});
test('native compiler expands independent lengths into one bounded repeating cycle', () => {
    const source = fixture(3);
    source.patterns['group:1'].bars[0].length = 2;
    const plan = compile(source,{...options,groupIds:[0,1]});
    assert.equal(plan.length, 6);
    const frames = plan.messages.filter((message) => message[0] === 'event');
    assert.deepEqual(frames.filter((message) => message[4] === 1).map((message) => message[3]),[0,3]);
    assert.deepEqual(frames.filter((message) => message[4] === 2).map((message) => message[3]),[0,2,4]);
    const large = fixture(63); large.patterns['group:1'].bars[0].length = 61;
    assert.throws(() => compile(large,{...options,groupIds:[0,1]}),/exceeds 512/);
});
for (const [name, mutate, expected] of [
    ['probability',s=>s.patterns['group:0'].bars[0].steps[0].probability=7,/probability/],
    ['condition',s=>s.patterns['group:0'].bars[0].steps[0].condition=2,/conditions/],
    ['rate',s=>s.patterns['group:0'].rateNumerator=2,/1×/],
    ['phrase',s=>s.patterns['track:14']=s.patterns['group:0'],/phrases/],
    ['shape',s=>s.patterns['group:0'].bars[0].steps[0].locks.kickPitch={value:80,behavior:'glide'},/shapes/],
    ['generic lock',s=>s.patterns['group:0'].bars[0].steps[0].locks.volume={value:7,behavior:'set'},/unsupported lock/],
    ['group mismatch',s=>s.tracks[14].group=1,/belong/],
    ['sample slot',s=>s.tracks[14].buffer=23,/sample slot/],
    ['implicit track',s=>s.patterns['group:0'].bars[0].steps[0].cut.track=-1,/explicit cut/],
    ['gate',s=>s.patterns['group:0'].bars[0].steps[0].cut.gateLength=4,/gated/],
    ['modulation',s=>s.modulation={routes:[{}]},/modulation/],
    ['automation',s=>s.automation={playing:1},/automation/]
]) test('native prototype rejects '+name+' instead of altering its semantics',()=>{
    const source=fixture();mutate(source);assert.throws(()=>compile(source,options),expected);
});
