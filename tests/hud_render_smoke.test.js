const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'hud.js'), 'utf8');
const Model = require('../hud_model.js');

function createHarness() {
	const commands = [];
	const tasks = [];
	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		tasks.push(this);
	}
	Task.prototype.schedule = function () {};
	Task.prototype.cancel = function () {};
	const mgraphics = { size: [720, 480] };
	for (const method of ['init', 'redraw', 'set_source_rgba', 'rectangle', 'fill',
		'set_line_width', 'stroke', 'move_to', 'line_to', 'select_font_face',
		'set_font_size', 'show_text']) mgraphics[method] = function () {};
	const context = vm.createContext({
		autowatch: 0, inlets: 0, outlets: 0, mgraphics, Task,
		require(name) {
			if (name === 'hud_model.js') return Model;
			throw new Error(`unexpected module ${name}`);
		},
		outlet(...args) { commands.push(args); }
	});
	vm.runInContext(SOURCE, context, { filename: 'hud.js' });
	return { context, commands, mgraphics };
}

test('all HUD pages paint and expose bounded hit regions from 480x320 upward', () => {
	const harness = createHarness();
	for (const size of [[480, 320], [720, 480], [1100, 700]]) {
		harness.mgraphics.size = size;
		for (const page of Model.HUD_PAGES) {
			harness.context.page(page);
			assert.doesNotThrow(() => harness.context.paint());
			assert.equal(harness.context.hitRegions.some((region) => region.id === `tab:${page}`), true);
			for (const region of harness.context.hitRegions) {
				assert.equal(Number.isFinite(region.x + region.y + region.width + region.height), true);
				assert.equal(region.width >= 0 && region.height >= 0, true);
				assert.equal(region.x >= 0 && region.y >= 0, true);
				assert.equal(region.x + region.width <= size[0] + 0.01, true,
					`${page} region ${region.id} exceeds width at ${size.join('x')}`);
				assert.equal(region.y + region.height <= size[1] + 0.01, true,
					`${page} region ${region.id} exceeds height at ${size.join('x')}`);
			}
		}
	}
});

test('live virtual keys and pattern steps remain read-only', () => {
	const harness = createHarness();
	harness.context.page('live');
	harness.context.paint();
	const grid = harness.context.hitRegions.find((region) => region.id === 'grid:0:0');
	harness.context.activateRegion(grid, false);
	assert.deepEqual(harness.commands, []);

	harness.context.page('pattern');
	harness.context.paint();
	const step = harness.context.hitRegions.find((region) => region.id === 'pattern_step:0');
	harness.context.activateRegion(step, false);
	assert.deepEqual(harness.commands, []);
});

test('live page exposes a capture-and-reinitialize recovery control', () => {
	const harness = createHarness();
	harness.context.page('live');
	harness.context.paint();
	const recovery = harness.context.hitRegions.find((region) =>
		region.id === 'display_recover');
	assert.ok(recovery);
	harness.context.activateRegion(recovery, false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'display_recover'), true);
});

test('sample click auditions and a double-click also commits the assignment', () => {
	const harness = createHarness();
	harness.context.bank('ready', '/bank.json', '/samples', 1);
	harness.context.sample(0, 8, 'Kick', '/samples/kick.wav', 'WAVE', 1, 400, 48000);
	harness.context.page('samples');
	harness.context.paint();
	const sample = harness.context.hitRegions.find((region) => region.id === 'sample:0');
	const event = { clientX: sample.x + 2, clientY: sample.y + 2 };
	harness.context.onpointerup(event);
	assert.equal(harness.commands.some((command) => command[1] === 'sample_assign'), false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'sample_audition' && command[2] === 0), true);
	harness.context.onpointerup(event);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'sample_assign' && command[2] === 0 && command[3] === 0), true);
});

test('sample controls open folder scanning and the physical grid browser', () => {
	const harness = createHarness();
	harness.context.bank('ready', '/samples', '/samples', 1, 'smart-folder');
	harness.context.sample(0, 8, 'Kit Kick 01', '/samples/Kit Kick 01.wav',
		'WAVE', 1, 400, 48000, 'kick', 'kit kick', 240, 60, 35);
	harness.context.page('samples');
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'bank_scan'), false);
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'sample_grid'), false);
	assert.equal(harness.commands.some((command) => command[1] === 'bank_scan'), true);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'sample_grid' && command[2] === 1 &&
		command[3] === 0 && command[4] === -1), true);
});

test('sample page uses one wide sixteen-row column for tracks and bank samples', () => {
	const harness = createHarness();
	harness.context.bank('ready', '/bank.json', '/samples', 16);
	for (let index = 0; index < 16; index++) {
		harness.context.sample(index, index + 8,
			`A deliberately long sample filename number ${index + 1}.wav`,
			`/samples/long/path/${index + 1}.wav`, 'WAVE', 1, 400, 48000);
	}
	harness.context.page('samples');
	harness.context.paint();
	const tracks = harness.context.hitRegions.filter((region) =>
		region.id.startsWith('sample_track:'));
	const samples = harness.context.hitRegions.filter((region) =>
		/^sample:\d+$/.test(region.id));
	assert.equal(tracks.length, 16);
	assert.equal(samples.length, 16);
	assert.equal(new Set(tracks.map((region) => region.x)).size, 1);
	assert.equal(new Set(samples.map((region) => region.x)).size, 1);
	assert.equal(new Set(tracks.map((region) => region.y)).size, 16);
	assert.equal(new Set(samples.map((region) => region.y)).size, 16);
	assert.equal(samples[0].width > 180, true);
});

test('opening an empty Colors page automatically requests a fresh snapshot', () => {
	const harness = createHarness();
	harness.context.page('colors');
	assert.equal(harness.commands.some((command) => command[1] === 'snapshot'), true);
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) =>
		region.id === 'color_snapshot_retry'), true);
});

test('channel-strip page selects a group and edits its DSP controls', () => {
	const harness = createHarness();
	harness.context.channel_strip(0, 0, 1, 1, 0, -18, 4, 10, 120, 6, 0, 1, 0, 0);
	harness.context.page('strip');
	harness.context.paint();
	assert.equal(harness.commands.some((command) => command[1] === 'strip_snapshot'), true);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'strip_select' && command[2] === 0), true);
	const groupSix = harness.context.hitRegions.find((region) => region.id === 'strip_group:5');
	harness.context.activateRegion(groupSix, false);
	assert.equal(harness.context.state.selectedChannelStrip, 5);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'strip_select' && command[2] === 5), true);
	harness.context.paint();
	const clean = harness.context.hitRegions.find((region) => region.id === 'strip:5:engine:1');
	harness.context.activateRegion(clean, false);
	assert.equal(harness.context.state.channelStrips[5].engine, 1);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'strip_set' && command[2] === 5 &&
		command[3] === 'engine' && command[4] === 1), true);
});

test('rack sub-tab loads, bypasses, opens, clears, and reorders effects', () => {
	const harness = createHarness();
	harness.context.rack_inventory(JSON.stringify({ vst3: [
		{ format: 'vst3', uri: 'C74_VST3:/Vendor/Delay', name: 'Delay' }
	], au: [] }));
	harness.context.rack_state(0, 0, JSON.stringify({ name: 'Empty', status: 'empty' }));
	harness.context.page('strip');
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'strip_tab:rack'), false);
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'rack_load:0'), true);
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'rack_load:0'), false);
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'rack_plugin:0'), false);
	assert.equal(harness.commands.some((command) => command[1] === 'rack_load' &&
		command[2] === 0 && command[3] === 0 && command[4] === 'vst3'), true);
	harness.context.paint();
	for (const [id, command] of [['rack_bypass:0', 'rack_bypass'], ['rack_open:0', 'rack_open'],
		['rack_clear:0', 'rack_clear'], ['rack_down:0', 'rack_move']]) {
		harness.context.activateRegion(harness.context.hitRegions.find((region) => region.id === id), false);
		assert.equal(harness.commands.some((message) => message[1] === command), true, command);
	}
});

test('rack chooser keeps its old list visible while a paced refresh is in progress', () => {
	const harness = createHarness();
	harness.context.rack_inventory(JSON.stringify({ vst3: [
		{ format: 'vst3', uri: 'C74_VST3:/Vendor/Delay', name: 'Delay' }
	], au: [] }));
	harness.context.rack_inventory_status('listing', 2, 0, 0, 'Reading cache');
	harness.context.page('strip');
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'strip_tab:rack'), false);
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'rack_load:0'), false);
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'rack_plugin:0'), true);
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'rack_refresh'), true);
});

test('Session page exposes commands, dirty state, missing files, and save/discard/cancel confirmation', () => {
	const harness = createHarness();
	harness.context.session_state(JSON.stringify({ name: 'Jam', dirty: 1, busy: 0,
		confirmation: 'open', message: 'Save changes?', missing: [
			{ type: 'sample', path: '/missing/kick.wav' }
		] }));
	harness.context.page('session');
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'session_command:session_save'), true);
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'session_command:session_save'), false);
	for (const choice of ['save', 'discard', 'cancel']) {
		harness.context.activateRegion(harness.context.hitRegions.find((region) =>
			region.id === `session_confirm:${choice}`), false);
	}
	assert.equal(harness.commands.some((command) => command[1] === 'session_save'), true);
	assert.equal(harness.commands.filter((command) => command[1] === 'session_confirm').length, 3);
});

test('color lab edits one runtime role and exposes non-persistent reset controls', () => {
	const harness = createHarness();
	harness.context.color_role('rta.trigger', 'RTA', 0, 210, 255);
	harness.context.color_role('page.mainBase', 'PAGE', 18, 72, 180);
	harness.context.page('colors');
	harness.context.paint();
	const greenMaximum = harness.context.hitRegions.find((region) =>
		region.id === 'color_channel:1:255');
	assert.ok(greenMaximum);
	harness.context.activateRegion(greenMaximum, false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'color_role' && command[2] === 'rta.trigger' &&
		command[4] === 255), true);
	const reset = harness.context.hitRegions.find((region) => region.id === 'color_reset_role');
	harness.context.activateRegion(reset, false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'color_reset' && command[2] === 'rta.trigger'), true);
});
