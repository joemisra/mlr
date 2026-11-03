const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'sample_bank.js'), 'utf8');

function createHarness(files, folders = {}) {
	const namedMessages = [];
	const tasks = [];
	const dictionaries = {};

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
		this.scheduledDelay = null;
		tasks.push(this);
	}
	Task.prototype.schedule = function (delay) {
		this.scheduled = true;
		this.scheduledDelay = delay;
	};
	Task.prototype.cancel = function () {
		this.scheduled = false;
		this.scheduledDelay = null;
	};

	function Dict(name) {
		this.name = name;
	}
	Dict.prototype.parse = function (payload) {
		dictionaries[this.name] = JSON.parse(payload);
	};
	Dict.prototype.stringify = function () {
		return JSON.stringify(dictionaries[this.name] || {});
	};

	const context = vm.createContext({
		File, Folder, Dict,
		Task,
		patcher: { filepath: '/project/file_list.maxpat' },
		arrayfromargs(args) { return Array.prototype.slice.call(args); },
		messnamed(...args) { namedMessages.push(args); },
		post() {}
	});
	// Match Max's legacy [js] runtime rather than Node's modern Array API.
	vm.runInContext('Array.prototype.fill = undefined;', context);
	vm.runInContext(SOURCE, context, { filename: 'sample_bank.js' });
	return { context, namedMessages, tasks, dictionaries };
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
	assert.equal(harness.context.loadTask.scheduledDelay, 75);
	const stopIndex = harness.namedMessages.findIndex((message) =>
		message[0] === '[mlr]stop' && message[1] === 'bang');
	const resetBeforeLoad = harness.namedMessages.findIndex((message) =>
		message[0] === '[samplebank]coll' && message[1] === 'clear');
	assert.equal(stopIndex >= 0 && stopIndex < resetBeforeLoad, true);
	assert.equal(harness.namedMessages.filter((message) =>
		/^[1-8]\[pl\]stop$/.test(message[0]) && message[1] === 'int').length, 8);
	assert.equal(harness.namedMessages.filter((message) =>
		message[0] === 'sequence64_audio_cancel' && message[1] === 'int').length, 8);
	assert.equal(harness.namedMessages.some((message) => message[0] === '[samplebank]path'), false);
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

	harness.context.bufferMetadata('/project/samples/drums/a.wav', 9, 2, 1250, 48000);
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

test('Scene recall synchronizes one-based track buffers without retriggering sample menus', () => {
	const manifest = JSON.stringify({
		version: 1,
		root: 'samples',
		samples: ['a.wav', 'b.wav']
	});
	const harness = createHarness({ '/project/sample-bank.json': manifest });
	harness.context.reload();
	runScheduledTasks(harness);
	const menuMessagesBefore = harness.namedMessages.filter((message) =>
		/\[sample\]select$/.test(message[0])).length;

	assert.equal(harness.context.syncTrackBuffer(0, 9), true);
	assert.equal(harness.context.syncTrackBuffer(1, 10), true);
	assert.equal(harness.context.syncTrackBuffer(2, 8), true);
	assert.deepEqual(Array.from(harness.context.runtimeAssignments.slice(0, 3)), [0, 1, -1]);
	assert.equal(harness.namedMessages.filter((message) =>
		/\[sample\]select$/.test(message[0])).length, menuMessagesBefore);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_hud_state' && message[1] === 'assignment' &&
		message[2] === 0 && message[3] === 0), true);
	assert.equal(harness.context.syncTrackBuffer(16, 9), false);
});

test('version-two manifests resolve per-folder roots into one stable catalog', () => {
	const manifest = JSON.stringify({
		version: 2,
		folders: [
			{ id: 'folder:0', name: 'Drums', path: 'samples/drums' },
			{ id: 'folder:1', name: 'Textures', path: 'samples/textures' }
		],
		samples: [
			{ folderId: 'folder:0', path: 'kick.wav' },
			{ folderId: 'folder:1', path: 'air.aif' }
		],
		trackAssignments: [1]
	});
	const harness = createHarness({ '/project/multi.json': manifest });

	harness.context.read('/project/multi.json');
	runScheduledTasks(harness);
	assert.deepEqual(Array.from(harness.context.pendingSamples), [
		'/project/samples/drums/kick.wav', '/project/samples/textures/air.aif'
	]);
	assert.equal(harness.context.sampleFolders.length, 2);
	assert.equal(harness.context.sampleRecords[1].folderId, 'folder:1');
	assert.equal(harness.context.runtimeAssignments[0], 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserReference' &&
		message[2] === 0 && message[3] === 1 && message[4] === 'folder:1' &&
		message[5] === 'air.aif'), true);
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

test('multiple scanned folders append stable samples and expose folder-local grid views', () => {
	const folders = {
		'/drums': [{ name: 'Kick.wav', type: 'WAVE' }],
		'/textures': [{ name: 'Air.wav', type: 'WAVE' }]
	};
	const harness = createHarness({}, folders);

	harness.context.scanFolder('/drums');
	runScheduledTasks(harness);
	harness.context.assign(0, 0);
	harness.context.scanFolder('/textures');
	runScheduledTasks(harness);

	assert.equal(harness.context.bankSource, 'folder-library');
	assert.deepEqual(Array.from(harness.context.pendingSamples),
		['/drums/Kick.wav', '/textures/Air.wav']);
	assert.equal(harness.context.sampleFolders.length, 2);
	assert.equal(harness.context.runtimeAssignments[0], 0,
		'adding a folder must not renumber an assigned sample');

	harness.context.browserOpen(1, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserReset' &&
		message[2] === 1 && message[3] === 2 && message[4] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserColor' &&
		message[2] === 0 && message[6] === 1), true);

	harness.context.selectFolder(0, 0);
	assert.equal(harness.context.activeFolderId, 'folder:0');
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'sampleBrowserOpen' &&
		message[2] === 0 && message[3] === 0), true);

	folders['/drums'].push({ name: 'Clap.wav', type: 'WAVE' });
	harness.context.scanFolder('/drums');
	runScheduledTasks(harness);
	assert.deepEqual(Array.from(harness.context.pendingSamples),
		['/drums/Kick.wav', '/textures/Air.wav', '/drums/Clap.wav']);
	assert.equal(harness.context.runtimeAssignments[0], 0);
	harness.context.sessionSnapshot('folders');
	const snapshot = harness.dictionaries.mlr_session_bank_fragment;
	assert.equal(snapshot.folders.length, 2);
	assert.equal(snapshot.samples[2].folderId, 'folder:0');
	assert.equal(snapshot.activeFolderId, undefined,
		'viewed folder is runtime state, not session data');
});

test('per-track capture allocates the next catalog buffer and registers a durable sample', () => {
	const harness = createHarness({
		'/project/sample-bank.json': JSON.stringify({ samples: ['kick.wav'] })
	});
	harness.context.reload();
	runScheduledTasks(harness);
	harness.namedMessages.length = 0;

	assert.equal(harness.context.capturePress(2), true);
	const pending = harness.context.pendingCapture;
	assert.equal(pending.bufferIndex, 10);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_track_capture' && message[1] === 'press' &&
		message[2] === 2 && message[3] === 10), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_session_recording_state' && message[1] === 1), true);

	assert.equal(harness.context.captureRelease(2), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_track_capture' && message[1] === 'release' &&
		message[2] === 2), true);
	harness.context.captureEngineState('complete', 2, 10, 2000);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_session_recording_export' && message[1] === 'capture' &&
		message[2] === pending.id && message[3] === '10file'), true);

	harness.context.captureCommitted(pending.id, pending.temporaryPath, 2, 10, 2000, 'input');
	assert.equal(harness.context.sampleRecords[1].kind, 'recording');
	assert.equal(harness.context.sampleRecords[1].recordingId, pending.id);
	assert.equal(harness.context.runtimeAssignments[2], 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '4[sample]select' && message[1] === 9), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'recordingRegistered' &&
		message[2] === pending.id && message[3] === 10), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'mlr_session_recording_state' && message[1] === 0), true);

	harness.context.sessionSnapshot('capture');
	const snapshot = harness.dictionaries.mlr_session_bank_fragment;
	assert.equal(snapshot.samples[1].kind, 'recording');
	assert.equal(snapshot.samples[1].recordingId, pending.id);
	assert.equal(snapshot.samples[1].path, '');
});

test('session apply restores catalog recordings from resolved bundle sidecars', () => {
	const harness = createHarness({
		'/project/sample-bank.json': JSON.stringify({ samples: ['kick.wav'] })
	});
	harness.context.reload();
	runScheduledTasks(harness);
	harness.context.capturePress(2);
	const pending = harness.context.pendingCapture;
	harness.context.captureCommitted(pending.id, pending.temporaryPath, 2, 10, 2000, 'input');
	harness.context.sessionSnapshot('capture');

	harness.dictionaries.session_with_capture = {
		bank: harness.dictionaries.mlr_session_bank_fragment,
		recordings: [{
			id: pending.id,
			source: 'input',
			bufferIndex: 10,
			bufferName: '10file',
			catalogSample: 1,
			resolvedPath: '/sessions/Test.mlr-session/recordings/recording-01.wav'
		}]
	};
	harness.namedMessages.length = 0;
	assert.equal(harness.context.sessionApplyDict('session_with_capture'), true);
	runScheduledTasks(harness);

	assert.equal(harness.context.sampleRecords.length, 2);
	assert.equal(harness.context.sampleRecords[1].recordingId, pending.id);
	assert.equal(harness.context.sampleRecords[1].path,
		'/sessions/Test.mlr-session/recordings/recording-01.wav');
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[samplebank]path' &&
		message[1] === '/sessions/Test.mlr-session/recordings/recording-01.wav'), true);
});

test('dropping several audio files preserves assignments, deduplicates, and groups parent folders', () => {
	const h = createHarness({}, { '/kit': [{ name: 'Kick.wav', type: 'WAVE' }] });
	h.context.scanFolder('/kit'); runScheduledTasks(h);
	h.context.assign(3, 0);
	h.context.importFile('/New Sounds/Air.wav');
	h.context.importFile('/New Sounds/Pad.aiff');
	h.context.importFile('/New Sounds/Air.wav');
	h.context.importFile('/kit/Kick.wav');
	assert.equal(h.context.importFile('/bad.txt'), false);
	runScheduledTasks(h);
	assert.deepEqual(Array.from(h.context.pendingSamples), ['/kit/Kick.wav', '/New Sounds/Air.wav', '/New Sounds/Pad.aiff']);
	assert.equal(h.context.sampleFolders.length, 2);
	assert.equal(h.context.runtimeAssignments[3], 0);
	assert.equal(h.context.sampleFolders[1].name, 'New Sounds');
});

test('removing all folders keeps catalog buffers and assignments through save/reopen and slot reuse', () => {
	const h = createHarness({}, { '/kit': [{ name: 'Kick.wav', type: 'WAVE' }] });
	h.context.scanFolder('/kit'); runScheduledTasks(h);
	h.context.assign(3, 0);
	h.namedMessages.length = 0;
	assert.equal(h.context.removeFolder('folder:0'), true);
	assert.equal(h.context.sampleFolders.length, 0);
	assert.equal(h.context.sampleRecords[0].folderId, '');
	assert.equal(h.context.runtimeAssignments[3], 0);
	assert.equal(h.namedMessages.some(m => m[0] === '[samplebank]reset' || m[0] === '[mlr]stop'), false);
	h.context.sessionSnapshot('removed');
	const saved = h.dictionaries.mlr_session_bank_fragment;
	assert.equal(saved.samples[0].folderId, '');
	h.context.sessionApply(JSON.stringify(saved)); runScheduledTasks(h);
	assert.equal(h.context.sampleFolders.length, 0);
	assert.equal(h.context.sampleRecords[0].path, '/kit/Kick.wav');
	assert.equal(h.context.runtimeAssignments[3], 0);
	h.context.importFile('/other/Air.wav'); runScheduledTasks(h);
	assert.equal(h.context.sampleFolders[0].id, 'folder:0');
	assert.deepEqual(Array.from(h.context.sampleFolders[0].sampleIndices), [1]);
	assert.equal(h.context.sampleRecords[0].folderId, '');
	h.context.scanFolder('/kit'); runScheduledTasks(h);
	assert.equal(h.context.sampleRecords.length, 2);
	assert.equal(h.context.sampleRecords[0].folderId, 'folder:1');
	assert.equal(h.context.runtimeAssignments[3], 0);
});

test('drops wait for an active load and removal refuses to mutate its catalog', () => {
	const h = createHarness({ '/project/sample-bank.json': JSON.stringify({ samples: ['kick.wav'] }) });
	h.context.reload();
	assert.equal(h.context.removeFolder('folder:0'), false);
	h.context.importFile('/other/Pad.wav');
	h.context.importDroppedFiles();
	assert.equal(h.context.droppedPaths.length, 1);
	runScheduledTasks(h);
	assert.equal(h.context.sampleRecords.length, 2);
	assert.equal(h.context.runtimeAssignments[0], 0);
});
