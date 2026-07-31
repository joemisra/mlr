const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const BRIDGE_PATH = path.join(__dirname, '..', 'grid_matrix_bridge.js');
const BRIDGE_SOURCE = fs.readFileSync(BRIDGE_PATH, 'utf8');
const MAIN_PATCH_PATH = path.join(__dirname, '..', '_mlr.maxpat');

function createHarness() {
	const matrices = new Map();
	const outlets = [];

	function createState(width, height) {
		return {
			dim: [width, height],
			data: new Uint8Array(width * height),
			clearCount: 0
		};
	}

	class JitterMatrix {
		constructor(planecount, type, width, height) {
			this.planecount = planecount;
			this.type = type;
			this.localState = createState(width, height);
			this.matrixName = null;
		}

		set name(value) {
			this.matrixName = value;
			if (!matrices.has(value)) matrices.set(value, this.localState);
		}

		get name() {
			return this.matrixName;
		}

		get state() {
			return this.matrixName ? matrices.get(this.matrixName) : this.localState;
		}

		set dim(value) {
			const state = this.state;
			state.dim = Array.from(value);
			state.data = new Uint8Array(state.dim[0] * state.dim[1]);
		}

		get dim() {
			return Array.from(this.state.dim);
		}

		clear() {
			this.state.data.fill(0);
			this.state.clearCount++;
		}

		setcell2d(x, y, value) {
			this.state.data[y * this.state.dim[0] + x] = value;
		}

		copymatrixtoarray(target) {
			target.set(this.state.data);
		}

		copyarraytomatrix(source) {
			this.state.data.set(source);
		}

		fillplane(plane, value) {
			this.state.data.fill(value);
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
		matrix() {
			return matrices.get('grid_matrix_io_state');
		},
		message(name) {
			context.messagename = name;
			context.anything();
		},
		clearOutlets() {
			outlets.length = 0;
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
});
