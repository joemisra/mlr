const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'sample_bank.js'), 'utf8');

function createHarness(files) {
	const namedMessages = [];
	const tasks = [];

	function File(filename) {
		const contents = files[filename];
		this.isopen = contents !== undefined;
		this.position = 0;
		this._lines = this.isopen ? contents.match(/[^\n]*\n|[^\n]+$/g) || [] : [];
		this.eof = this.isopen ? contents.length : 0;
	}
	File.prototype.readline = function () {
		const line = this._lines.shift() || '';
		this.position += line.length;
		return line;
	};
	File.prototype.close = function () { this.isopen = false; };

	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.scheduled = false;
		tasks.push(this);
	}
	Task.prototype.schedule = function () { this.scheduled = true; };
	Task.prototype.cancel = function () { this.scheduled = false; };

	const context = vm.createContext({
		File,
		Task,
		patcher: { filepath: '/project/file_list.maxpat' },
		arrayfromargs(args) { return Array.prototype.slice.call(args); },
		messnamed(...args) { namedMessages.push(args); },
		post() {}
	});
	vm.runInContext(SOURCE, context, { filename: 'sample_bank.js' });
	return { context, namedMessages, tasks };
}

function runScheduledTasks(harness, limit = 100) {
	for (let pass = 0; pass < limit; pass++) {
		const task = harness.tasks.find((candidate) => candidate.scheduled);
		if (!task) return;
		task.scheduled = false;
		task.callback.call(task.owner);
	}
	throw new Error('sample-bank task did not settle');
}

test('sample bank resolves relative paths, scopes randomize, and assigns tracks deterministically', () => {
	const manifest = JSON.stringify({
		version: 1,
		root: 'samples',
		samples: ['drums/a.wav', 'loops/b.aif'],
		trackAssignments: [1, 0]
	});
	const harness = createHarness({ '/project/sample-bank.json': manifest });

	harness.context.reload();
	runScheduledTasks(harness);

	assert.deepEqual(harness.namedMessages.slice(0, 2), [
		['[samplebank]coll', 'clear'],
		['[samplebank]reset', 'bang']
	]);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]type' && message[1] === 'WAVE'), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]path' &&
		message[1] === '/project/samples/drums/a.wav'), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]type' && message[1] === 'AIFF'), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]count' && message[1] === 2), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[sample]select' && message[1] === 9), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '3[sample]select' && message[1] === 8), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '4[sample]select' && message[1] === 8), true);
});
