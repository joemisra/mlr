"use strict";

// Preparation only. Never called by the native pulse path. Until the full
// sequencer contract is implemented, fail closed rather than drop features.
const drums = [
    ['kick', require('./instrument_model.js'), 14],
    ['snare', require('./snare_instrument_model.js'), 13],
    ['hat', require('./hat_instrument_model.js'), 12],
    ['clap', require('./clap_instrument_model.js'), 11],
    ['tom', require('./tom_instrument_model.js'), 10],
    ['rim', require('./rim_instrument_model.js'), 9]
].map(([id, model, track]) => ({ id, model, track, locks: model[id.toUpperCase() + '_LOCKS'] }));
const maxSteps = 512;
function fail(message) { throw new Error('Native prototype: ' + message); }
function integer(value, minimum, maximum, label) {
    if (!Number.isInteger(value) || value < minimum || value > maximum) fail('invalid ' + label);
    return value;
}
function gcd(a, b) { while (b) [a, b] = [b, a % b]; return a; }
function flatten(pattern, label) {
    if (!pattern || !Array.isArray(pattern.bars) || !pattern.bars.length || pattern.bars.length > 8)
        fail(label + ' needs validated bars');
    const numerator = integer(pattern.rateNumerator ?? 1, 1, 16, label + ' rate numerator');
    const denominator = integer(pattern.rateDenominator ?? 1, 1, 16, label + ' rate denominator');
    if (numerator !== denominator) fail(label + ' uses a rate other than 1×');
    return pattern.bars.flatMap((bar) => {
        integer(bar.length, 1, 64, label + ' bar length');
        if (!Array.isArray(bar.steps) || bar.steps.length < bar.length) fail(label + ' is missing steps');
        return bar.steps.slice(0, bar.length);
    });
}
function hasPhraseContent(pattern) {
    return pattern && Array.isArray(pattern.bars) && pattern.bars.some((bar) =>
        bar.steps.slice(0, bar.length).some((step) => step && (step.cut || Object.keys(step.locks || {}).length)));
}
function compile(snapshot, options) {
    const { epoch, generation, groupIds } = options || {};
    integer(epoch, 1, 2147483647, 'epoch'); integer(generation, 1, 2147483647, 'generation');
    if (!snapshot || !snapshot.patterns || !Array.isArray(snapshot.tracks)) fail('needs a router snapshot');
    if (!Array.isArray(groupIds) || !groupIds.length || groupIds.length > 8 || new Set(groupIds).size !== groupIds.length)
        fail('choose distinct groups explicitly');
    if ((snapshot.modulation?.routes || []).length) fail('modulation routes are not supported yet');
    if (snapshot.automation?.playing || snapshot.automation?.recording || Object.values(snapshot.targetAutomation || {}).some((state) =>
        state && (state.playing || state.recording))) fail('active legacy automation is not supported yet');
    let length = 1;
    const groups = groupIds.map((group) => {
        integer(group, 0, 7, 'group');
        const steps = flatten(snapshot.patterns['group:' + group], 'group ' + (group + 1));
        length = length / gcd(length, steps.length) * steps.length;
        if (length > maxSteps) fail('combined group cycle exceeds 512 subdivisions');
        const frames = steps.map((step) => {
            if (!step || typeof step !== 'object') fail('missing normalized step');
            if ((step.condition ?? 0) !== 0 || (step.probability ?? 15) !== 15)
                fail('conditions and probability are not supported yet');
            const locks = step.locks || {};
            if (!step.cut) {
                if (Object.keys(locks).length) fail('lock-only steps are not supported yet');
                return null;
            }
            const trackIndex = integer(step.cut.track, 0, 15, 'explicit cut track');
            const drum = drums.find((entry) => entry.track === trackIndex);
            if (!drum) fail('sample and melodic tracks are not supported yet');
            const track = snapshot.tracks[trackIndex];
            if (!track || track.group !== group) fail('cut track does not belong to its group');
            if (track.buffer) fail('clear the drum sample slot before isolated synth playback');
            if (hasPhraseContent(snapshot.patterns['track:' + trackIndex])) fail('track phrases are not supported yet');
            if ((step.cut.gateLength ?? 1) !== 1) fail('gated steps are not supported yet');
            for (const id of Object.keys(locks)) {
                if (id !== 'slice' && !drum.locks.includes(id)) fail('unsupported lock ' + id);
                if ((locks[id].behavior || 'set') !== 'set') fail('parameter shapes are not supported yet');
            }
            const slice = integer(locks.slice ? locks.slice.value : step.cut.slice, 0, 15, 'slice');
            const baseline = drum.model.sanitize(track.instrumentParameters);
            const values = drum.locks.map((id) => locks[id] ? drum.model.clampValue(id, locks[id].value) : baseline[id]);
            return [group + 1, trackIndex + 2, slice, ...values];
        });
        return { frames };
    });
    const messages = [['begin', epoch, generation, length]];
    for (let step = 0; step < length; step++) {
        for (const group of groups) {
            const frame = group.frames[step % group.frames.length];
            if (frame) messages.push(['event', epoch, generation, step, ...frame]);
        }
    }
    messages.push(['commit', epoch, generation]);
    return { epoch, generation, length, eventCount: messages.length - 2, messages };
}
exports.compile = compile;
exports.maxSteps = maxSteps;
