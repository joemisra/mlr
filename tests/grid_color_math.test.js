const assert = require('node:assert/strict');
const test = require('node:test');

const ColorMath = require('../grid_color_math.js');

test('color math implements the bounded Role modifier vocabulary', () => {
	assert.deepEqual(ColorMath.applyOperation([240, 20, 100], [30, 50, 200], 'replace'),
		[30, 50, 200]);
	assert.deepEqual(ColorMath.applyOperation([240, 20, 100], [30, 50, 200], 'add'),
		[255, 70, 255]);
	assert.deepEqual(ColorMath.applyOperation([240, 20, 100], [30, 50, 200], 'half_add'),
		[135, 35, 150]);
	assert.deepEqual(ColorMath.applyOperation([20, 80, 100], [30, 50, 200], 'sub'),
		[0, 30, 0]);
	assert.deepEqual(ColorMath.applyOperation([20, 80, 100], [30, 50, 200], 'half_sub'),
		[0, 15, 0]);
	assert.deepEqual(ColorMath.applyOperation([255, 128, 0], [128, 128, 255], 'mul'),
		[128, 64, 0]);
});

test('modifier strength interpolates after the operation and clamps malformed input', () => {
	assert.deepEqual(ColorMath.applyModifier([20, 40, 60], {
		op: 'add', rgb: [100, 200, 300], amount: 128
	}), [70, 140, 158]);
	assert.deepEqual(ColorMath.applyModifier([20, 40, 60], {
		op: 'mul', rgb: [-10, 128, 999], amount: 255
	}), [0, 20, 60]);
	assert.deepEqual(ColorMath.applyModifier([20, 40, 60], null), [20, 40, 60]);
});

test('Motion composes after State and therefore has visual priority', () => {
	const role = [200, 50, 20];
	const state = { op: 'mul', rgb: [128, 128, 128], amount: 255 };
	const motion = { op: 'half_add', rgb: [255, 255, 255], amount: 255 };
	assert.deepEqual(ColorMath.compose(role, state, motion), [177, 140, 132]);
});

test('frame composition never derives or mutates canonical brightness from RGB', () => {
	const levels = [-2, 8, 19];
	const frame = ColorMath.composeFrame(levels,
		[[255, 0, 0], [0, 255, 0], [0, 0, 255]],
		[null, { op: 'add', rgb: [20, 20, 20], amount: 255 }, null],
		[null, null, { op: 'replace', rgb: [255, 255, 255], amount: 128 }]);
	assert.deepEqual(frame.levels, [0, 8, 15]);
	assert.deepEqual(frame.colors, [[255, 0, 0], [20, 255, 20], [128, 128, 255]]);
	assert.deepEqual(levels, [-2, 8, 19]);
});
