const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const root = path.resolve(__dirname, '..');
const source = fs.readFileSync(path.join(root, 'serialosc_list_devices.js'), 'utf8');

function createHarness() {
	const outlets = [];
	const tasks = [];

	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.scheduledDelay = null;
		tasks.push(this);
	}
	Task.prototype.schedule = function (delay) { this.scheduledDelay = delay; };
	Task.prototype.cancel = function () { this.scheduledDelay = null; };

	const context = vm.createContext({
		Task,
		inlet: 0,
		messagename: '',
		arrayfromargs(args) { return Array.prototype.slice.call(args); },
		outlet(...args) { outlets.push(args); },
		post() {}
	});
	vm.runInContext(source, context, { filename: 'serialosc_list_devices.js' });
	return { context, outlets, tasks };
}

test('serialosc discovery registers hot-plug notification and settles into one redraw', () => {
	const harness = createHarness();
	const serialosc = harness.context;

	serialosc.startQuery();
	assert.equal(harness.outlets.some((message) =>
		message[0] === 0 && message[1] === '/serialosc/notify'), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 0 && message[1] === '/serialosc/list'), true);

	serialosc.list('/serialosc/device', 'm-test', 'monome grid', 12345);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 12345), true);
	assert.equal(serialosc.deviceSettleTask.scheduledDelay, 200);
	serialosc.deviceSettleTask.callback.call(serialosc.deviceSettleTask.owner);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 3 && message[1] === 'bang'), true);
});

test('serialosc add and remove notifications re-register and refresh device ports', () => {
	const harness = createHarness();
	const serialosc = harness.context;
	harness.outlets.length = 0;

	serialosc.messagename = '/serialosc/add';
	serialosc.anything('m-test');
	assert.deepEqual(harness.outlets.slice(0, 4), [
		[1, 0],
		[2, 0],
		[0, '/serialosc/notify', '127.0.0.1', 57888],
		[0, '/serialosc/list', '127.0.0.1', 57888]
	]);

	harness.outlets.length = 0;
	serialosc.messagename = '/serialosc/remove';
	serialosc.anything('m-test');
	assert.equal(harness.outlets.some((message) =>
		message[0] === 0 && message[1] === '/serialosc/notify'), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 0 && message[1] === '/serialosc/list'), true);
});

test('hot-plug settle outlet is wired to the root hardware-resync command', () => {
	const listPatch = JSON.parse(fs.readFileSync(
		path.join(root, 'serialosc_list_devices.maxpat'), 'utf8')).patcher;
	const rootPatch = JSON.parse(fs.readFileSync(path.join(root, '_mlr.maxpat'), 'utf8')).patcher;
	const listConnection = listPatch.lines.some(({ patchline }) =>
		patchline.source[0] === 'obj-js' && patchline.source[1] === 3 &&
		patchline.destination[0] === 'obj-resync');
	assert.equal(listConnection, true);

	const rootBank = rootPatch.boxes.find(({ box }) => box.id === 'obj-30').box;
	const resync = rootPatch.boxes.find(({ box }) => box.id === 'obj-grid-hardware-resync').box;
	assert.equal(rootBank.numoutlets, 3);
	assert.equal(resync.text, 'hardwareResync');
	assert.equal(rootPatch.lines.some(({ patchline }) =>
		patchline.source[0] === 'obj-30' && patchline.source[1] === 2 &&
		patchline.destination[0] === 'obj-grid-hardware-resync'), true);
	assert.equal(rootPatch.lines.some(({ patchline }) =>
		patchline.source[0] === 'obj-grid-hardware-resync' &&
		patchline.destination[0] === 'obj-gr-io'), true);
});

test('root edition controls both route to the grid router', () => {
	const rootPatch = JSON.parse(fs.readFileSync(path.join(root, '_mlr.maxpat'), 'utf8')).patcher;
	const edition256 = rootPatch.boxes.find(({ box }) => box.id === 'obj-113').box;
	const edition128 = rootPatch.boxes.find(({ box }) => box.id === 'obj-64').box;
	assert.equal(edition256.text, 'edition 256');
	assert.equal(edition128.text, 'edition 128');
	for (const source of ['obj-113', 'obj-64']) {
		assert.equal(rootPatch.lines.some(({ patchline }) =>
			patchline.source[0] === source && patchline.source[1] === 0 &&
			patchline.destination[0] === 'obj-gr-io'), true);
	}
});
