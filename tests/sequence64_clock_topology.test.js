const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');

function readPatcher(filename) {
	return JSON.parse(fs.readFileSync(path.join(root, filename), 'utf8')).patcher;
}

function boxById(patcher, id) {
	const entry = patcher.boxes.find(({ box }) => box.id === id);
	assert.ok(entry, `missing ${id}`);
	return entry.box;
}

function hasConnection(patcher, sourceId, sourceOutlet, destinationId, destinationInlet) {
	return patcher.lines.some(({ patchline }) =>
		patchline.source[0] === sourceId &&
		patchline.source[1] === sourceOutlet &&
		patchline.destination[0] === destinationId &&
		patchline.destination[1] === destinationInlet);
}

test('sequence64 clock is phase-locked at 16 steps per quarter note', () => {
	const time = readPatcher('time.maxpat');

	assert.equal(boxById(time, 'obj-34').text, 'rate~ 2');
	assert.equal(boxById(time, 'obj-seq-rate').text, 'rate~ 0.125');
	assert.equal(boxById(time, 'obj-seq-threshold').text, '>=~ 0.5');
	assert.equal(boxById(time, 'obj-seq-edge').text, 'edge~');
	assert.equal(boxById(time, 'obj-seq-send').text, 's sequence64_pulse');

	assert.equal(hasConnection(time, 'obj-95', 0, 'obj-seq-rate', 0), true);
	assert.equal(hasConnection(time, 'obj-seq-rate', 0, 'obj-seq-threshold', 0), true);
	assert.equal(hasConnection(time, 'obj-seq-threshold', 0, 'obj-seq-edge', 0), true);
	assert.equal(hasConnection(time, 'obj-seq-edge', 0, 'obj-seq-bang', 0), true);
	assert.equal(hasConnection(time, 'obj-seq-edge', 1, 'obj-seq-bang', 0), true);
	assert.equal(hasConnection(time, 'obj-seq-bang', 0, 'obj-seq-send', 0), true);
});

test('grid router receives the dedicated sequence64 pulse on inlet 4', () => {
	const io = readPatcher('grid_router_io.maxpat');

	assert.equal(boxById(io, 'obj-rseqpulse').text, 'r sequence64_pulse');
	assert.equal(boxById(io, 'obj-router').numinlets, 4);
	assert.equal(hasConnection(io, 'obj-rseqpulse', 0, 'obj-router', 3), true);
});

test('sequence64 has a group-local immediate player trigger that bypasses only the legacy quantize gate', () => {
	const player = readPatcher('pl.maxpat');

	assert.equal(boxById(player, 'obj-sequence64-trigger-now').text,
		'r #1[mlr]pl-trig-now');
	assert.equal(hasConnection(player,
		'obj-sequence64-trigger-now', 0, 'obj-68', 0), true);

	// Ordinary grid input still arms obj-70 and waits for the global quantizer.
	assert.equal(boxById(player, 'obj-104').text, 'r [mlr]trig');
	assert.equal(hasConnection(player, 'obj-104', 0, 'obj-70', 1), true);
	assert.equal(hasConnection(player, 'obj-70', 0, 'obj-68', 0), true);
});
