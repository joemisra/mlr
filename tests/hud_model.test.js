const assert = require('node:assert/strict');
const test = require('node:test');

const Model = require('../hud_model.js');

test('HUD reducer composes level maps and semantic colors by logical coordinate', () => {
	const state = Model.createState();
	const levels = Array.from({ length: 64 }, (_, index) => index % 16);
	Model.applyEvent(state, 'grid_level_map', [8, 8, ...levels]);
	assert.equal(state.grid.levels[Model.gridIndex(8, 8)], 0);
	assert.equal(state.grid.levels[Model.gridIndex(15, 15)], 15);

	const colors = [];
	for (let index = 0; index < 16; index++) colors.push(index, 255 - index, 40);
	Model.applyEvent(state, 'grid_color_map', [4, 4, ...colors]);
	assert.deepEqual(state.grid.colors[Model.gridIndex(7, 7)], [15, 240, 40]);
	Model.applyEvent(state, 'grid_press', [7, 7, 1]);
	assert.equal(state.grid.pressed['7:7'], 1);
	Model.applyEvent(state, 'grid_press', [7, 7, 0]);
	assert.equal(state.grid.pressed['7:7'], undefined);
});

test('pattern snapshot and playhead events preserve zero-based protocol fields', () => {
	const state = Model.createState();
	const steps = [{
		cut: { track: -1, slice: 5, gateLength: 4 },
		probability: 9,
		condition: -4,
		locks: { transpose: { value: 7, behavior: 'set' } }
	}];
	Model.applyEvent(state, 'pattern_snapshot', [JSON.stringify({
		targetType: 'group', targetId: 2, running: 1, bars: 3, currentBar: 1,
		length: 37, rateNumerator: 3, rateDenominator: 2, defaultTrack: 4,
		playheadBar: 1, playheadStep: 0, decisionOutcome: 'conditionSkip', steps
	})]);
	assert.equal(state.pattern.targetId, 2);
	assert.equal(state.pattern.steps[0].slice, 5);
	assert.equal(state.pattern.steps[0].track, -1);
	assert.equal(state.pattern.steps[0].condition, -4);
	assert.equal(state.pattern.steps[0].lockCount, 2);
	assert.equal(state.pattern.decisionOutcome, 'conditionSkip');
	Model.applyEvent(state, 'pattern_playhead', ['track', 2, 0, 12]);
	assert.equal(state.pattern.playheadStep, 0);
	Model.applyEvent(state, 'pattern_playhead', ['group', 2, 2, 12, 'probabilityPlay']);
	assert.equal(state.pattern.playheadStep, 12);
	assert.equal(state.pattern.decisionOutcome, 'probabilityPlay');
	Model.applyEvent(state, 'pattern_playhead', ['group', 2, 2, 13, 'bogus']);
	assert.equal(state.pattern.decisionOutcome, '');
});

test('sample selection pages banks and assignment state without committing audio', () => {
	const state = Model.createState();
	Model.applyEvent(state, 'bank', ['ready', '/bank.json', '/samples', 20]);
	for (let index = 0; index < 20; index++) {
		Model.applyEvent(state, 'sample', [index, index + 8, `Sample ${index + 1}`,
			`/samples/${index}.wav`, 'WAVE', 1, 1000, 48000,
			'kick', 'kit kick', 240, 50, 30]);
	}
	Model.applyEvent(state, 'assignment', [3, 18, 26]);
	Model.selectTrack(state, 3);
	assert.equal(state.selectedSample, 18);
	assert.equal(state.samplePage, 1);
	assert.equal(Model.pageSamples(state).length, 4);
	Model.selectSample(state, 2);
	assert.equal(state.selectedTrack, 3);
	assert.equal(state.bank.assignments[3], 18);
	assert.equal(state.bank.samples[2].category, 'kick');
	assert.equal(state.bank.samples[2].family, 'kit kick');
	assert.deepEqual(state.bank.samples[2].color, [240, 50, 30]);
	Model.applyEvent(state, 'sample_browser', [1, 5, 7, 2]);
	assert.equal(state.sampleBrowserActive, 1);
	assert.equal(state.sampleBrowserPage, 2);
	assert.equal(state.selectedTrack, 5);
	assert.equal(state.selectedSample, 7);
	Model.applyEvent(state, 'browser_selection', [-1, 11]);
	assert.equal(state.selectedSample, 11);
});

test('portable hit regions, page navigation, help mappings, and malformed events are safe', () => {
	const state = Model.createState();
	const regions = [Model.hitRegion('under', 0, 0, 50, 50, { action: 'a' }),
		Model.hitRegion('over', 10, 10, 20, 20, { action: 'b' })];
	assert.equal(Model.regionAt(regions, 15, 15).id, 'over');
	assert.equal(Model.regionAt(regions, 100, 100), null);
	assert.equal(Model.setPage(state, 'samples'), 'samples');
	assert.equal(Model.setPage(state, 'bogus'), 'samples');
	assert.equal(Model.modeName(2, { active: 1 }), 'ṛta');
	assert.match(Model.describeCell(2, 0, 8, { active: 1 }, 'follow').detail, /ṛta step/);
	state.editor.targetType = 'group';
	assert.match(Model.describeCell(2, 12, 12, state.editor, 'locks').detail, /Track lock/);
	state.editor.parameter = 'condition';
	assert.match(Model.describeCell(2, 0, 13, state.editor, 'locks').detail, /every 2 pattern visits/);
	assert.match(Model.describeCell(2, 15, 13, state.editor, 'locks').detail, /every 9 pattern visits/);
	assert.doesNotThrow(() => Model.applyEvent(state, 'pattern_snapshot', ['not-json']));
	assert.doesNotThrow(() => Model.applyEvent(state, 'unknown', [Infinity, null]));
});

test('runtime color roles retain portable labels, categories, and RGB state', () => {
	const state = Model.createState();
	Model.applyEvent(state, 'color_role', ['rta.triggerGate', 'RTA', 45, 230, 105]);
	Model.applyEvent(state, 'color_role', ['group.3', 'GROUP', 245, 205, 30]);
	assert.deepEqual(state.colorLab.order, ['rta.triggerGate', 'group.3']);
	assert.equal(state.colorLab.selected, 'rta.triggerGate');
	assert.equal(state.colorLab.roles['rta.triggerGate'].label, 'Trigger Gate');
	assert.equal(state.colorLab.roles['group.3'].label, 'Group 3');
	assert.deepEqual(state.colorLab.roles['group.3'].color, [245, 205, 30]);
});

test('channel-strip state, selected group, and selected meter stream remain portable', () => {
	const state = Model.createState();
	assert.equal(state.channelStrips.length, 8);
	assert.equal(state.channelStrips[0].engine, 0);
	assert.equal(state.channelStrips[0].cutoff, 1);
	assert.equal(Model.selectChannelStrip(state, 5), 5);
	Model.applyEvent(state, 'channel_strip', [5, 1, 0.71, 0.4, 0.3,
		-24, 6, 30, 250, 9, 3, 0.75, 4, -3]);
	assert.deepEqual({
		engine: state.channelStrips[5].engine,
		cutoff: state.channelStrips[5].cutoff,
		filterMod: state.channelStrips[5].filterMod,
		threshold: state.channelStrips[5].threshold,
		mix: state.channelStrips[5].mix,
		drive: state.channelStrips[5].drive
	}, { engine: 1, cutoff: 0.71, filterMod: 0.4, threshold: -24, mix: 0.75, drive: 4 });
	Model.applyEvent(state, 'channel_strip_meter', [5, -9, -14, 3]);
	assert.equal(state.channelStrips[5].inputDb, -9);
	assert.equal(state.channelStrips[5].outputDb, -14);
	assert.equal(state.channelStrips[5].reduction, 8);
	Model.applyEvent(state, 'channel_strip', [5, 0, 1, 1, 0, -18, 4, 10, 120, 6, 0, 1, 0, 0]);
	Model.applyEvent(state, 'channel_strip_meter', [5, -9, -14, 0]);
	assert.equal(state.channelStrips[5].reduction, 0);
});

test('plugin rack inventory, slot state, latency, and strip sub-tabs remain portable', () => {
	const state = Model.createState();
	assert.equal(state.pluginRacks.length, 8);
	assert.equal(state.pluginRacks[0].slots.length, 4);
	Model.applyEvent(state, 'rack_inventory', [JSON.stringify({
		vst3: [{ format: 'vst3', uri: 'C74_VST3:/Delay', name: 'Delay' }],
		au: [{ format: 'au', uri: 'C74_AU:/Reverb', name: 'Reverb' }]
	})]);
	Model.applyEvent(state, 'rack_state', [2, 1, JSON.stringify({
		format: 'vst3', name: 'Delay', loaded: 1, bypassed: 0, latencySamples: 128
	})]);
	Model.applyEvent(state, 'rack_latency', [2, 128, 2.666, 1]);
	assert.equal(state.rackInventory.vst3[0].name, 'Delay');
	assert.equal(state.pluginRacks[2].slots[1].name, 'Delay');
	assert.equal(state.pluginRacks[2].latencySamples, 128);
	assert.equal(state.rackLatencyMismatch, 1);
	assert.equal(Model.setStripView(state, 'rack'), 'rack');
	assert.equal(Model.setStripView(state, 'bogus'), 'builtin');
});

test('large rack inventories transfer atomically without erasing the last good list', () => {
	const state = Model.createState();
	Model.applyEvent(state, 'rack_inventory', [JSON.stringify({
		vst3: [{ format: 'vst3', uri: 'C74_VST3:/Old', name: 'Old' }], au: []
	})]);
	Model.applyEvent(state, 'rack_inventory_status', ['listing', 4, 0, 0,
		'Reading the Max plugin cache']);
	Model.applyEvent(state, 'rack_inventory_begin', [5, 'vst3', 3]);
	Model.applyEvent(state, 'rack_inventory_item', [5, 'vst3', 0,
		'C74_VST3:/A', 'Effect A']);
	Model.applyEvent(state, 'rack_inventory_item', [5, 'vst3', 1,
		'C74_VST3:/B', 'Effect B']);
	Model.applyEvent(state, 'rack_inventory_end', [5, 'vst3']);
	assert.equal(state.rackInventory.vst3[0].name, 'Old',
		'incomplete transfer must not replace the last known-good list');
	Model.applyEvent(state, 'rack_inventory_begin', [6, 'vst3', 2]);
	Model.applyEvent(state, 'rack_inventory_item', [6, 'vst3', 0,
		'C74_VST3:/A', 'Effect A']);
	Model.applyEvent(state, 'rack_inventory_item', [6, 'vst3', 1,
		'C74_VST3:/B', 'Effect B']);
	Model.applyEvent(state, 'rack_inventory_end', [6, 'vst3']);
	Model.applyEvent(state, 'rack_inventory_status', ['ready', 6, 2, 0,
		'Plugin cache ready']);
	assert.deepEqual(state.rackInventory.vst3.map((entry) => entry.name),
		['Effect A', 'Effect B']);
	assert.equal(state.rackInventoryStatus.phase, 'ready');
});

test('session state and missing resource notices are normalized for the HUD', () => {
	const state = Model.createState();
	Model.applyEvent(state, 'session_state', [JSON.stringify({
		name: 'Night Jam', path: '/Sessions/Night Jam.mlr-session', dirty: 1,
		busy: 0, missing: [{ type: 'sample', path: '/old/kick.wav' }]
	})]);
	Model.applyEvent(state, 'session_missing', [1, 'recording', '/old/1.wav', 1]);
	assert.equal(state.session.name, 'Night Jam');
	assert.equal(state.session.dirty, 1);
	assert.equal(state.session.missing.length, 2);
	assert.equal(state.session.missing[1].ambiguous, 1);
	assert.equal(Model.setPage(state, 'session'), 'session');
});
