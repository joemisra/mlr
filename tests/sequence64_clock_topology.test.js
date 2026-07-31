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

test('sample replacement reports file metadata before sending replace to buffer~', () => {
	const fileList = readPatcher('file_list.maxpat');
	const fileRead = boxById(fileList, 'obj-29').patcher;

	assert.equal(boxById(fileRead, 'obj-34').text, 'pack s 0 0 0. 0.');
	assert.equal(boxById(fileRead, 'obj-35').text, 'prepend diagnosticBufferLoad');
	assert.equal(boxById(fileRead, 'obj-36').text, 's gridrouter');

	assert.equal(hasConnection(fileRead, 'obj-8', 0, 'obj-34', 0), true);
	assert.equal(hasConnection(fileRead, 'obj-6', 1, 'obj-34', 1), true);
	assert.equal(hasConnection(fileRead, 'obj-29', 0, 'obj-34', 2), true);
	assert.equal(hasConnection(fileRead, 'obj-29', 3, 'obj-34', 3), true);
	assert.equal(hasConnection(fileRead, 'obj-29', 2, 'obj-34', 4), true);
	assert.equal(hasConnection(fileRead, 'obj-34', 0, 'obj-35', 0), true);
	assert.equal(hasConnection(fileRead, 'obj-35', 0, 'obj-36', 0), true);

	const diagnosticLine = fileRead.lines.find(({ patchline }) =>
		patchline.source[0] === 'obj-8' && patchline.destination[0] === 'obj-34');
	const replaceLine = fileRead.lines.find(({ patchline }) =>
		patchline.source[0] === 'obj-8' && patchline.destination[0] === 'obj-12');
	assert.equal(diagnosticLine.patchline.order, 0);
	assert.equal(replaceLine.patchline.order, 1);
});

test('portable sample bank feeds the existing loader, track menus, and random range', () => {
	const fileList = readPatcher('file_list.maxpat');
	const channel = readPatcher('ch.maxpat');
	const manifest = JSON.parse(fs.readFileSync(path.join(root, 'sample-bank.json'), 'utf8'));

	assert.equal(boxById(fileList, 'obj-sample-bank-js').text, 'js sample_bank.js');
	assert.equal(boxById(fileList, 'obj-sample-bank-command').text, 'r sample_bank');
	assert.equal(hasConnection(fileList,
		'obj-sample-bank-type', 0, 'obj-29', 0), true);
	assert.equal(hasConnection(fileList,
		'obj-sample-bank-path', 0, 'obj-29', 1), true);
	assert.equal(hasConnection(fileList,
		'obj-sample-bank-coll', 0, 'obj-25', 0), true);

	assert.equal(boxById(channel, 'obj-sample-bank-select').text,
		'r #1[sample]select');
	assert.equal(boxById(channel, 'obj-sample-bank-count').text,
		'r [samplebank]count');
	assert.equal(hasConnection(channel,
		'obj-sample-bank-select', 0, 'obj-24', 0), true);
	assert.equal(hasConnection(channel,
		'obj-sample-bank-count', 0, 'obj-54', 1), true);

	assert.equal(manifest.version, 1);
	assert.equal(manifest.root, 'samples');
	assert.equal(Array.isArray(manifest.samples), true);
	assert.equal(Array.isArray(manifest.trackAssignments), true);
});
