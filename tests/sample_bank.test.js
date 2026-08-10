const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'sample_bank.js'), 'utf8');

function createHarness(files, folders = {}) {
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

	function Folder(folderPath) {
		this.pathname = folderPath;
		this.entries = folders[folderPath] || [];
		this.count = this.entries.length;
		this.index = 0;
	}
	Folder.prototype.reset = function () { this.index = 0; };
	Object.defineProperty(Folder.prototype, 'end', {
		get() { return this.index >= this.entries.length; }
	});
	Object.defineProperty(Folder.prototype, 'filename', {
		get() { return this.end ? '' : this.entries[this.index].name; }
	});
	Object.defineProperty(Folder.prototype, 'filetype', {
		get() { return this.end ? '' : this.entries[this.index].type; }
	});
	Folder.prototype.next = function () { this.index++; };
	Folder.prototype.close = function () {};

	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.scheduled = false;
		tasks.push(this);
	}
	Task.prototype.schedule = function () { this.scheduled = true; };
	Task.prototype.cancel = function () { this.scheduled = false; };

	const context = vm.createContext({
		File, Folder,
		Task,
		patcher: { filepath: '/project/file_list.maxpat' },
		arrayfromargs(args) { return Array.prototype.slice.call(args); },
		messnamed(...args) { namedMessages.push(args); },
		post() {}
	});
	// Match Max's legacy [js] runtime rather than Node's modern Array API.
	vm.runInContext('Array.prototype.fill = undefined;', context);
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

	const resetIndex = harness.namedMessages.findIndex((message) =>
		message[0] === '[samplebank]coll' && message[1] === 'clear');
	assert.equal(resetIndex >= 0, true);
	assert.deepEqual(harness.namedMessages.slice(resetIndex, resetIndex + 2), [
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

	harness.context.bufferMetadata('/project/samples/drums/a.wav', 8, 2, 1250, 48000);
	harness.context.assign(5, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'sample' &&
		message[2] === 0 && message[7] === 2 && message[8] === 1250), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '7[sample]select' && message[1] === 9), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'assignment' &&
		message[2] === 5 && message[3] === 1), true);
});

test('an invalid bank reports an error without replacing the current session bank', () => {
	const harness = createHarness({
		'/project/sample-bank.json': JSON.stringify({ version: 1, root: '.', samples: ['ok.wav'] }),
		'/project/bad.json': '{bad json'
	});
	harness.context.reload();
	runScheduledTasks(harness);
	assert.equal(harness.context.manifestPath, '/project/sample-bank.json');
	harness.context.read('/project/bad.json');
	assert.equal(harness.context.manifestPath, '/project/sample-bank.json');
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'notice' && message[2] === 'error'), true);
});

test('legacy Max list files import quoted and relative audio paths without rewriting them', () => {
	const legacy = [
		'1, rec 1000. 1_rec;',
		'9, "/Volumes/Samples/Blue Loop.wav" 2000. Blue Loop.wav;',
		'10, drums/kick.wav 500. kick.wav;',
		'11, "Yambe-akka 1:/Samples/Old Loop.aif" 4000. Old Loop.aif;',
		'12, drums/kick.wav 500. duplicate.wav;'
	].join('\r');
	const harness = createHarness({ '/project/session.list': legacy });

	harness.context.read('/project/session.list');
	runScheduledTasks(harness);

	assert.equal(harness.context.bankSource, 'legacy-list');
	assert.equal(harness.context.pendingSamples.length, 3);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]path' && message[1] === '/Volumes/Samples/Blue Loop.wav'), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]path' && message[1] === '/project/drums/kick.wav'), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]path' &&
		message[1] === 'Yambe-akka 1:/Samples/Old Loop.aif'), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'bank' &&
		message[6] === 'legacy-list'), true);
});

test('smart folder scan groups, sorts, and colors filename families before loading', () => {
	const harness = createHarness({}, {
		'/samples': [
			{ name: 'Drums', type: 'fold' },
			{ name: 'Warm_Pad_02.wav', type: 'WAVE' },
			{ name: '.hidden.wav', type: 'WAVE' }
		],
		'/samples/Drums': [
			{ name: 'Kit_Kick_02.wav', type: 'WAVE' },
			{ name: 'Kit_Snare_07.wav', type: 'WAVE' },
			{ name: 'Kit_Kick_01.wav', type: 'WAVE' },
			{ name: 'notes.txt', type: 'TEXT' }
		]
	});

	harness.context.scanFolder('/samples');
	runScheduledTasks(harness);

	assert.equal(harness.context.bankSource, 'smart-folder');
	assert.equal(harness.context.pendingSamples.length, 4);
	assert.deepEqual(Array.from(harness.context.sampleRecords, (sample) => sample.category),
		['kick', 'kick', 'snare-clap', 'melodic']);
	assert.equal(harness.context.sampleRecords[0].family,
		harness.context.sampleRecords[1].family);
	assert.deepEqual(Array.from(harness.context.sampleRecords[0].color),
		Array.from(harness.context.sampleRecords[1].color));
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'sample' &&
		message[10] === 'kick' && Number.isFinite(message[12])), true);

	harness.context.preview(1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_sample_preview' && message[1] === 'preview' &&
		message[2] === '/samples/Drums/Kit_Kick_02.wav'), true);
	harness.context.browserOpen(3, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserReset' &&
		message[2] === 4), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserColor' &&
		message[2] === 0 && Number.isFinite(message[3])), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserOpen' &&
		message[2] === 3 && message[3] === 1), true);
	harness.context.browserOpen(2, -1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserOpen' &&
		message[2] === 2 && message[3] === 2), true);
	harness.context.previewStop();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_sample_preview' && message[1] === 'stop'), true);
});

test('smart folder scan is bounded to the 240 physical sample cells', () => {
	const entries = Array.from({ length: 260 }, (_, index) => ({
		name: `Series_Kick_${String(index + 1).padStart(3, '0')}.wav`,
		type: 'WAVE'
	}));
	const harness = createHarness({}, { '/large': entries });

	harness.context.scanFolder('/large');
	runScheduledTasks(harness, 400);

	assert.equal(harness.context.pendingSamples.length, 240);
	assert.equal(harness.context.sampleRecords.length, 240);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]count' && message[1] === 240), true);
});

test('an empty folder scan leaves the current bank intact', () => {
	const harness = createHarness({
		'/project/sample-bank.json': JSON.stringify({ samples: ['keep.wav'] })
	}, { '/empty': [{ name: 'notes.txt', type: 'TEXT' }] });
	harness.context.reload();
	runScheduledTasks(harness);
	const before = Array.from(harness.context.pendingSamples);

	harness.context.scanFolder('/empty');
	runScheduledTasks(harness);

	assert.deepEqual(Array.from(harness.context.pendingSamples), before);
	assert.equal(harness.context.manifestPath, '/project/sample-bank.json');
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'notice' &&
		message[2] === 'warn' && /No WAV or AIFF/.test(message[3])), true);
});
