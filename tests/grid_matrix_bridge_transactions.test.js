const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const BRIDGE_PATH = path.join(__dirname, '..', 'grid_matrix_bridge.js');
const BRIDGE_SOURCE = fs.readFileSync(BRIDGE_PATH, 'utf8');
const ANIMATION_PATH = path.join(__dirname, '..', 'grid_anim_engine.js');
const ANIMATION_SOURCE = fs.readFileSync(ANIMATION_PATH, 'utf8');
const MAIN_PATCH_PATH = path.join(__dirname, '..', '_mlr.maxpat');
const MATRIX_PATCH_PATH = path.join(__dirname, '..', 'grid_matrix_io.maxpat');

function createHarness() {
	const outlets = [];
	const hudMessages = [];
	const namedMessages = [];

	class JitterMatrix {
		constructor() {
			throw new Error('display state must not depend on JitterMatrix construction');
		}
	}

	const context = vm.createContext({
		JitterMatrix,
		Uint8Array,
		arrayfromargs(args) {
			return Array.prototype.slice.call(args);
		},
		jsarguments: [],
		messagename: '',
		messnamed(...args) {
			if (args[0] === 'mlr_hud_state') hudMessages.push(args.slice(1));
			else namedMessages.push(args);
		},
		outlet(...args) {
			outlets.push(args);
		},
		post() {}
	});

	vm.runInContext(BRIDGE_SOURCE, context, { filename: BRIDGE_PATH });
	context.set_edition(256);

	return {
		context,
		outlets,
		hudMessages,
		namedMessages,
		matrix(name = 'grid_matrix_io_state') {
			if (name.endsWith('_anim_level')) return { data: context.animationLevels };
			if (name.endsWith('_anim_mask')) return { data: context.animationMask };
			return { data: context.foreground, clearCount: context.foregroundClearCount };
		},
		createAnimationEngine() {
			const animationOutlets = [];
			const animationContext = vm.createContext({
				JitterMatrix,
				Uint8Array,
				arrayfromargs(args) {
					return Array.prototype.slice.call(args);
				},
				jsarguments: [],
				messagename: '',
				outlet(...args) {
					animationOutlets.push(args);
					if (args[1] === 'animcell') context.animcell(...args.slice(2));
					else if (args[1] === 'animclear') context.animclear();
					else if (args[1] === 'flush') context.flush();
				},
				post() {}
			});
			vm.runInContext(ANIMATION_SOURCE, animationContext, { filename: ANIMATION_PATH });
			animationContext.edition_msg(256);
			return { context: animationContext, outlets: animationOutlets };
		},
		message(name) {
			context.messagename = name;
			context.anything();
		},
		clearOutlets() {
			outlets.length = 0;
			hudMessages.length = 0;
			namedMessages.length = 0;
		}
	};
}

test('beginupdate batches and flushes changes without clearing existing cells', () => {
	const harness = createHarness();
	const bridge = harness.context;
	bridge.setcell(1, 1, 9);
	const clearsBefore = harness.matrix().clearCount;
	harness.clearOutlets();

	harness.message('beginupdate');
	bridge.setcell(2, 2, 7);

	assert.equal(harness.matrix().clearCount, clearsBefore);
	assert.equal(harness.matrix().data[1 * 16 + 1], 9);
	assert.equal(harness.matrix().data[2 * 16 + 2], 7);
	assert.equal(harness.outlets.length, 0);

	harness.message('endupdate');
	assert.equal(harness.outlets.length, 4);
	assert.equal(harness.outlets.every((message) =>
		message[1] === '/box/grid/led/level/map'), true);
});

test('animations use a transient mask and cannot fade the router-owned row to zero', () => {
	const harness = createHarness();
	const bridge = harness.context;
	const animation = harness.createAnimationEngine();
	for (let x = 0; x < 16; x++) bridge.setcell(x, 9, x === 4 ? 12 : 5);
	const baseBefore = Array.from(harness.matrix().data.slice(9 * 16, 10 * 16));

	function renderedCell(x, y) {
		harness.clearOutlets();
		bridge.flush();
		const ox = x < 8 ? 0 : 8;
		const oy = y < 8 ? 0 : 8;
		const packet = harness.outlets.find((message) =>
			message[1] === '/box/grid/led/level/map' &&
			message[2] === ox && message[3] === oy);
		return packet[4 + (y - oy) * 8 + (x - ox)];
	}

	animation.context.line(9, 0, 15, 15, 0, 0, 2);
	animation.context.tick();
	assert.equal(renderedCell(4, 9), 15);
	assert.equal(harness.matrix('grid_matrix_io_state_anim_mask').data[9 * 16 + 4], 1);
	assert.deepEqual(Array.from(harness.matrix().data.slice(9 * 16, 10 * 16)), baseBefore);

	animation.context.tick();
	animation.context.tick();
	assert.equal(renderedCell(4, 9), 0);
	assert.deepEqual(Array.from(harness.matrix().data.slice(9 * 16, 10 * 16)), baseBefore);

	animation.context.tick();
	assert.equal(renderedCell(4, 9), 12);
	assert.equal(harness.matrix('grid_matrix_io_state_anim_mask').data[9 * 16 + 4], 0);
	assert.deepEqual(Array.from(harness.matrix().data.slice(9 * 16, 10 * 16)), baseBefore);
});

test('bridge loadbang preserves live byte state and requests an authoritative resync', () => {
	const harness = createHarness();
	const bridge = harness.context;
	bridge.setcell(6, 7, 13);
	harness.namedMessages.length = 0;
	bridge.loadbang();
	assert.equal(harness.matrix().data[7 * 16 + 6], 13);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'hardwareResync'), true);
});

test('bridge and animator use direct byte state without named Jitter matrices', () => {
	const patch = JSON.parse(fs.readFileSync(MATRIX_PATCH_PATH, 'utf8')).patcher;
	const boxTexts = patch.boxes.map(({ box }) => box.text || '');
	assert.equal(boxTexts.some((text) => text.startsWith('jit.matrix ')), false);
	assert.doesNotMatch(BRIDGE_SOURCE, /JitterMatrix/);
	assert.doesNotMatch(ANIMATION_SOURCE, /JitterMatrix/);
	assert.match(BRIDGE_SOURCE, /function animcell\(/);
	assert.match(ANIMATION_SOURCE, /outlet\(0, "animcell"/);
	assert.equal(patch.lines.some(({ patchline }) =>
		patchline.source[0] === 'obj-anim' && patchline.source[1] === 0 &&
		patchline.destination[0] === 'obj-bridge'), true);
});

test('beginframe remains a clearing full-page transaction', () => {
	const harness = createHarness();
	const bridge = harness.context;
	bridge.setcell(1, 1, 9);
	const clearsBefore = harness.matrix().clearCount;
	harness.clearOutlets();

	harness.message('beginframe');
	assert.equal(harness.matrix().clearCount, clearsBefore + 1);
	assert.equal(harness.matrix().data[1 * 16 + 1], 0);
	bridge.setcell(3, 3, 11);
	assert.equal(harness.outlets.length, 0);

	harness.message('endframe');
	assert.equal(harness.matrix().data[3 * 16 + 3], 11);
	assert.equal(harness.outlets.length, 4);
});

test('replaceframe validates and atomically swaps complete foreground/background state', () => {
	const harness = createHarness();
	const bridge = harness.context;
	bridge.setcell(1, 1, 9);
	const clearsBefore = harness.matrix().clearCount;
	const foreground = new Array(16 * 16).fill(0);
	const background = new Array(16 * 16).fill(0);
	foreground[3 * 16 + 2] = 7;
	background[3 * 16 + 2] = 12;
	foreground[5 * 16 + 4] = 15;
	harness.clearOutlets();

	bridge.replaceframe.apply(bridge, [16, 16].concat(foreground, background));

	assert.equal(harness.matrix().clearCount, clearsBefore);
	assert.equal(harness.matrix().data[1 * 16 + 1], 0);
	assert.equal(harness.matrix().data[3 * 16 + 2], 7);
	assert.equal(harness.matrix().data[5 * 16 + 4], 15);
	assert.equal(harness.outlets.length, 4);
	const levelMap = harness.hudMessages.find((message) =>
		message[0] === 'grid_level_map' && message[1] === 0 && message[2] === 0);
	assert.equal(levelMap[3 + 3 * 8 + 2], 12);
});

test('replaceframe rejects incomplete or mismatched frames without touching live state', () => {
	const harness = createHarness();
	const bridge = harness.context;
	bridge.setcell(6, 7, 13);
	harness.clearOutlets();

	bridge.replaceframe(16, 16, 1, 2, 3);
	bridge.replaceframe.apply(bridge, [8, 8].concat(new Array(128).fill(0)));

	assert.equal(harness.matrix().data[7 * 16 + 6], 13);
	assert.equal(harness.outlets.length, 0);
	assert.equal(harness.hudMessages.length, 0);
});

test('replaceframe preserves standard serialosc maps for native sizes and dual 128', () => {
	const harness = createHarness();
	const bridge = harness.context;
	for (const [edition, width, height, mapCount] of [
		[64, 8, 8, 1],
		[128, 16, 8, 2],
		[256, 16, 16, 4]
	]) {
		bridge.set_edition(edition);
		bridge.dual128Mode = 0;
		harness.clearOutlets();
		const cells = width * height;
		bridge.replaceframe.apply(bridge,
			[width, height].concat(new Array(cells).fill(5), new Array(cells).fill(0)));
		assert.equal(harness.outlets.length, mapCount);
		assert.equal(harness.outlets.every((message) =>
			message[0] === 0 && message[1] === '/box/grid/led/level/map'), true);
	}

	bridge.dual128Mode = 1;
	harness.clearOutlets();
	bridge.replaceframe.apply(bridge,
		[16, 16].concat(new Array(256).fill(6), new Array(256).fill(0)));
	assert.deepEqual(harness.outlets.map((message) => message[0]), [0, 0, 1, 1]);
	assert.deepEqual(harness.outlets.map((message) => message[3]), [0, 0, 0, 0]);
});

test('4x4 color maps emit one OSC message and remap the lower dual-128 grid', () => {
	const harness = createHarness();
	const bridge = harness.context;
	const colors = Array.from({ length: 48 }, (_, index) => index * 7);
	bridge.mechatrellis(1);
	harness.clearOutlets();

	bridge.colormap.apply(bridge, [4, 8].concat(colors));
	assert.equal(harness.outlets.length, 1);
	assert.deepEqual(Array.from(harness.outlets[0].slice(0, 4)),
		[0, '/box/grid/led/color/map', 4, 8]);
	assert.equal(harness.outlets[0].length, 52);
	assert.equal(harness.outlets[0].at(-1), 255);

	bridge.dual128Mode = 1;
	harness.clearOutlets();
	bridge.colormap.apply(bridge, [4, 8].concat(colors));
	assert.equal(harness.outlets.length, 1);
	assert.deepEqual(Array.from(harness.outlets[0].slice(0, 4)),
		[1, '/box/grid/led/color/map', 4, 0]);

	harness.clearOutlets();
	bridge.colormap.apply(bridge, [4, 6].concat(colors));
	assert.equal(harness.outlets.length, 0);
});

test('MechaTrellis private OSC is blocked by default and standard levels remain active', () => {
	const harness = createHarness();
	const bridge = harness.context;
	const colors = Array.from({ length: 48 }, (_, index) => index);
	harness.clearOutlets();

	bridge.colorcell(1, 2, 3, 4, 5);
	bridge.colorall(3, 4, 5);
	bridge.colormap.apply(bridge, [0, 0].concat(colors));
	bridge.colorpresetstore(1);
	bridge.colorpresetrecall(1);
	bridge.rgbcell(1, 2, 3, 4, 5);
	bridge.rgball(3, 4, 5);
	bridge.level8cell(1, 2, 127);
	bridge.level8all(127);
	bridge.intensity8(127);
	assert.equal(harness.outlets.length, 0);

	bridge.setcell(1, 2, 9);
	bridge.flush();
	assert.equal(harness.outlets.length, 4);
	assert.equal(harness.outlets.every((message) =>
		message[1] === '/box/grid/led/level/map'), true);

	bridge.mechatrellis(1);
	harness.clearOutlets();
	bridge.colorcell(1, 2, 3, 4, 5);
	assert.deepEqual(Array.from(harness.outlets[0]),
		[0, '/box/grid/led/color/set', 1, 2, 3, 4, 5]);
});

test('HUD receives composed brightness and semantic color before hardware filtering', () => {
	const harness = createHarness();
	const bridge = harness.context;
	harness.clearOutlets();
	bridge.setcell(2, 3, 4);
	bridge.setcell_bg(2, 3, 11);
	bridge.colorcell(2, 3, 9, 80, 210);
	bridge.send_level_maps();
	const levelMap = harness.hudMessages.find((message) =>
		message[0] === 'grid_level_map' && message[1] === 0 && message[2] === 0);
	assert.ok(levelMap);
	assert.equal(levelMap[3 + 3 * 8 + 2], 11);
	assert.deepEqual(harness.hudMessages.find((message) =>
		message[0] === 'grid_color_cell'), ['grid_color_cell', 2, 3, 9, 80, 210]);
	assert.equal(harness.outlets.some((message) =>
		message[1] === '/box/grid/led/color/set'), false);
});

test('diagnostic snapshot reports Max-side levels, colors, presets, and packet counters', () => {
	const harness = createHarness();
	const bridge = harness.context;
	bridge.mechatrellis(1);
	bridge.setcell(2, 3, 7);
	bridge.setcell_bg(2, 3, 11);
	bridge.colorcell(2, 3, 9, 80, 210);
	bridge.colorpresetstore(2);
	const animation = harness.createAnimationEngine();
	animation.context.kf(2, 3, 4, 0, 11, 1);
	animation.context.tick();
	bridge.send_level_maps();
	harness.namedMessages.length = 0;

	bridge.diagnostic_snapshot('incident-1');
	const message = harness.namedMessages.find((candidate) =>
		candidate[0] === 'gridrouter' && candidate[1] === 'displayDiagnosticSnapshot');
	assert.ok(message);
	assert.equal(message[2], 'incident-1');
	const snapshot = JSON.parse(message[3]);
	assert.equal(snapshot.foreground[3 * 16 + 2], 7);
	assert.equal(snapshot.animationLevels[3 * 16 + 2], 4);
	assert.equal(snapshot.animationMask[3 * 16 + 2], 1);
	assert.equal(snapshot.composite[3 * 16 + 2], 4);
	assert.equal(snapshot.animationMaskHash !== snapshot.backgroundHash, true);
	assert.deepEqual(snapshot.colors.slice((3 * 16 + 2) * 3, (3 * 16 + 2) * 3 + 3),
		[9, 80, 210]);
	assert.equal(snapshot.presetHashes[2] !== null, true);
	assert.equal(snapshot.packetStats.colorSetPackets, 1);
	assert.equal(snapshot.packetStats.presetStorePackets, 1);
	assert.equal(snapshot.packetStats.levelFrames >= 1, true);
});

test('main MLR patch loads workstation-local hardware settings with safe defaults', () => {
	const patch = JSON.parse(fs.readFileSync(MAIN_PATCH_PATH, 'utf8'));
	const startup = patch.patcher.boxes
		.map((entry) => entry.box)
		.find((box) => box.id === 'obj-187');
	const startupSource = fs.readFileSync(
		path.join(__dirname, '..', 'mlr_startup.js'), 'utf8');

	assert.equal(startup.text, 'js mlr_startup.js');
	assert.match(startupSource, /mechatrellis:\s*false/);
	assert.match(startupSource, /editorColors:\s*false/);
	assert.match(startupSource, /var startupApplyTask = new Task\(reload, this\)/);
	assert.match(startupSource, /startupApplyTask\.schedule\(250\)/);
});
