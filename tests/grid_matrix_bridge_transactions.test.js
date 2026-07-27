const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const BRIDGE_PATH = path.join(__dirname, '..', 'grid_matrix_bridge.js');
const BRIDGE_SOURCE = fs.readFileSync(BRIDGE_PATH, 'utf8');

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
