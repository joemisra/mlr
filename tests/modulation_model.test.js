const assert = require('node:assert/strict');
const test = require('node:test');

const Modulation = require('../modulation_model.js');

test('standard source defaults and settings sanitize into portable ranges', () => {
	assert.deepEqual(Modulation.defaultSource('lfo1').rate, [1, 4]);
	assert.deepEqual(Modulation.defaultSource('lfo2').rate, [1, 8]);
	const lfo = Modulation.sanitizeSource('lfo1', {
		rate: [3, 0], shape: 'triangle', phase: 2, polarity: 'unipolar', reset: 'transport'
	});
	assert.deepEqual(lfo.rate, [3, 1]);
	assert.equal(lfo.shape, 'triangle');
	assert.equal(lfo.phase, 1);
	assert.equal(lfo.polarity, 'unipolar');
	const envelope = Modulation.sanitizeSource('adsr', {
		attack: -4, decay: 80, sustain: 4, release: 100000
	});
	assert.deepEqual(envelope, {
		type: 'adsr', attack: 0.1, decay: 80, sustain: 1, release: 60000
	});
});

test('routes are target-local, signed, deduplicated, and removable', () => {
	let state = Modulation.createState();
	state = Modulation.setRoute(state, {
		scope: 'group', targetId: 3, parameterId: 'filter', sourceId: 'lfo1', amount: 4
	});
	state = Modulation.setRoute(state, {
		scope: 'group', targetId: 3, parameterId: 'filter', sourceId: 'lfo1', amount: -0.35
	});
	assert.equal(state.routes.length, 1);
	assert.equal(state.routes[0].amount, -0.35);
	assert.equal(state.routes[0].enabled, true);
	assert.deepEqual(state.sources['group:3:lfo1'], Modulation.defaultSource('lfo1'));
	state = Modulation.clearRoute(state, 'group', 3, 'filter', 'lfo1');
	assert.equal(state.routes.length, 0);
});

test('unknown future sources and destinations survive but cannot activate', () => {
	const state = Modulation.sanitizeState({
		sources: { 'track:4:asl-cloud': { type: 'asl', script: 'loop{to(1,1)}', enabled: true } },
		routes: [{ scope: 'track', targetId: 4, parameterId: 'pan',
			sourceId: 'asl-cloud', amount: 0.8, enabled: true }]
	});
	assert.equal(state.sources['track:4:asl-cloud'].script, 'loop{to(1,1)}');
	assert.equal(state.sources['track:4:asl-cloud'].enabled, false);
	assert.equal(state.routes[0].parameterId, 'pan');
	assert.equal(state.routes[0].sourceId, 'asl-cloud');
	assert.equal(state.routes[0].enabled, false);
});

test('malformed targets and duplicate route identities do not leak into state', () => {
	const state = Modulation.sanitizeState({
		sources: { 'group:99:lfo1': {}, 'group:1:lfo1': { rate: [1, 2] } },
		routes: [
			{ scope: 'group', targetId: 1, parameterId: 'filter', sourceId: 'lfo1', amount: 0.2 },
			{ scope: 'group', targetId: 1, parameterId: 'filter', sourceId: 'lfo1', amount: 0.6 },
			{ scope: 'track', targetId: 99, parameterId: 'filter', sourceId: 'lfo1', amount: 1 }
		]
	});
	assert.deepEqual(Object.keys(state.sources), ['group:1:lfo1']);
	assert.equal(state.routes.length, 1);
	assert.equal(state.routes[0].amount, 0.6);
});
