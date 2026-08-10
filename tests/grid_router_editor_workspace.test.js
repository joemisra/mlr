const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const ROUTER_PATH = path.join(__dirname, '..', 'grid_router.js');
const ROUTER_SOURCE = fs.readFileSync(ROUTER_PATH, 'utf8');

function createHarness(sharedGlobalStores, layoutMode = 'legacy') {
	const outlets = [];
	const namedMessages = [];
	const hudMessages = [];
	const posts = [];
	const tasks = [];
	const diagnosticLines = [];
	const timeline = [];
	const globalStores = sharedGlobalStores || Object.create(null);

	function Global(name) {
		if (!globalStores[name]) globalStores[name] = {};
		return globalStores[name];
	}

	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.interval = 0;
		this.running = false;
		this.scheduledDelay = null;
		tasks.push(this);
	}
	Task.prototype.schedule = function (delay) {
		this.scheduledDelay = delay;
		this.running = true;
	};
	Task.prototype.cancel = function () {
		this.running = false;
		this.scheduledDelay = null;
	};
	Task.prototype.repeat = function () { this.running = true; };

	function File(filename, access) {
		this.filename = filename;
		this.access = access;
		this.position = 0;
		this.isopen = true;
		this._eof = 0;
	}
	Object.defineProperty(File.prototype, 'eof', {
		get() { return this._eof; },
		set(value) {
			this._eof = value;
			if (value === 0) diagnosticLines.length = 0;
		}
	});
	File.prototype.writeline = function (line) {
		diagnosticLines.push(line);
		this.position += line.length + 1;
		this._eof = this.position;
	};
	File.prototype.close = function () {
		this.isopen = false;
	};

	const context = vm.createContext({
		File,
		Global,
		Task,
		arrayfromargs(args) {
			return Array.prototype.slice.call(args);
		},
		inlet: 0,
		messagename: '',
		messnamed(...args) {
			if (args[0] === 'mlr_hud_state') {
				hudMessages.push(args.slice(1));
				return;
			}
			namedMessages.push(args);
			timeline.push(['messnamed', ...args]);
			// The real patch holds this list in sequence64_audio_bridge.maxpat and
			// releases it on the next raw audio-derived pulse. JS unit tests do not
			// execute Max patchers, so mirror that native release here to retain the
			// existing end-to-end trigger assertions.
			if (args[0] === 'sequence64_audio_arm') {
				const channel = args[1];
				const track = args[2];
				const slice = args[3];
				const nativeMessages = [
					[`${track}input`, slice, 1],
					[`${channel}[mlr]pl-trig-now`, 'bang'],
					[`${track}input`, slice, 0]
				];
				for (const message of nativeMessages) {
					namedMessages.push(message);
					timeline.push(['native', ...message]);
				}
			}
		},
		outlet(...args) {
			outlets.push(args);
			timeline.push(['outlet', ...args]);
		},
		post(...args) {
			posts.push(args.join(''));
		}
	});

	vm.runInContext(ROUTER_SOURCE, context, { filename: ROUTER_PATH });
	context.s.kmod = 2;
	context.s.edition = 256;
	context.s.gridWidth = 16;
	context.s.gridHeight = 16;
	context.resetEditorWorkspaceState(true);
	context.editorLayout(layoutMode);

	return {
		context,
		globalStores,
		namedMessages,
		hudMessages,
		outlets,
		posts,
		tasks,
		diagnosticLines,
		timeline,
		clearLog() {
			namedMessages.length = 0;
			hudMessages.length = 0;
			outlets.length = 0;
			posts.length = 0;
			timeline.length = 0;
		}
	};
}

function createSequence64Harness(sharedGlobalStores) {
	return createHarness(sharedGlobalStores, 'sequence64');
}

function audioMessages(harness) {
	return harness.namedMessages.filter((message) =>
		message[0] !== 'togridmatrixanim' && message[0] !== 'togridmatrixio');
}

function hasLed(harness, x, y, level) {
	return harness.outlets.some((message) =>
		(message[0] === 1 && message[1] === 'setcell' &&
			message[2] === x && message[3] === y && message[4] === level) ||
		(message[0] === 1 && message[1] === 'replaceframe' &&
			message[4 + y * message[2] + x] === level));
}

function selectTrack(harness, trackIdx) {
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(15, trackIdx + 1, 1);
	router.dispatch(13, 0, 0);
}

function selectGroup(harness, groupIdx) {
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(groupIdx, 0, 1);
	router.dispatch(13, 0, 0);
}

test('inactive workspace preserves legacy mode-2 routing', () => {
	const harness = createHarness();
	const router = harness.context;

	router.dispatch(0, 3, 1);
	router.dispatch(15, 1, 1);
	router.dispatch(12, 8, 1);

	assert.deepEqual(audioMessages(harness), [
		['1[ch]timestretch', 'int', 1],
		['2[box]rev', 'int', 1],
		['9[box]rndOff', 'int', 1]
	]);
	assert.equal(router.s.channels[0].timestretch, 1);
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.equal(router.s.tracks[7].randomOffset, 1);
});

test('per-track Randomize column taps open samples and holds retain the legacy Max bus', () => {
	const harness = createHarness();
	const router = harness.context;
	harness.clearLog();

	// Physical column 9, row 4 addresses the third MLR track (2[box] is row 1).
	router.dispatch(8, 3, 1);
	assert.equal(router.modRandomizeHoldTask.running, true);
	assert.equal(harness.namedMessages.some((message) => /\[box\]rnd$/.test(message[0])), false);
	router.dispatch(8, 3, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'browserOpen' &&
		message[2] === 2 && message[3] === -1), true);
	assert.equal(harness.namedMessages.some((message) => /\[box\]rnd$/.test(message[0])), false);

	harness.clearLog();
	router.dispatch(8, 3, 1);
	router.modRandomizeHoldTask.callback.call(router.modRandomizeHoldTask.owner);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '4[box]rnd' && message[1] === 'int' && message[2] === 1), true);
	router.dispatch(8, 3, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'browserOpen'), false);
});

test('resolved Randomize holds remain compatible with the legacy automation recorder', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.automation.armed = true;

	router.dispatch(8, 2, 1);
	router.dispatch(8, 2, 0);
	assert.equal(router.s.automation.recording, false);
	assert.equal(router.s.automation.events.length, 0);

	router.dispatch(8, 2, 1);
	router.modRandomizeHoldTask.callback.call(router.modRandomizeHoldTask.owner);
	router.dispatch(8, 2, 0);
	assert.equal(router.s.automation.recording, true);
	assert.equal(router.s.automation.events.length, 1);
	assert.equal(router.s.automation.events[0].col, 8);
	assert.equal(router.s.automation.events[0].row, 2);

	harness.clearLog();
	router.playbackDispatching = true;
	router.dispatch(8, 2, 1);
	router.playbackDispatching = false;
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '3[box]rnd' && message[1] === 'int' && message[2] === 1), true);
	assert.equal(router.modRandomizeHoldTask.running, false);
});

test('mode changes synchronize legacy state before one complete atomic frame', () => {
	const harness = createHarness();
	const router = harness.context;
	harness.clearLog();

	router.setKmod(1);

	const broadcast = harness.timeline.findIndex((message) =>
		message[0] === 'messnamed' && message[1] === 'kmod' &&
		message[2] === 'int' && message[3] === 1);
	const replacement = harness.timeline.findIndex((message) =>
		message[0] === 'outlet' && message[1] === 1 && message[2] === 'replaceframe');
	assert.equal(broadcast >= 0, true);
	assert.equal(broadcast < replacement, true);
	assert.equal(harness.timeline.filter((message) =>
		message[0] === 'outlet' && message[1] === 1 &&
		message[2] === 'replaceframe').length, 1);
	assert.equal(harness.timeline.some((message) =>
		message[0] === 'outlet' && message[1] === 1 &&
		(message[2] === 'beginframe' || message[2] === 'endframe' ||
			message[2] === 'clear')), false);
	const frame = harness.outlets.find((message) =>
		message[0] === 1 && message[1] === 'replaceframe');
	assert.equal(frame[2], 16);
	assert.equal(frame[3], 16);
	assert.equal(frame.length, 4 + 16 * 16 * 2);
	assert.equal(harness.diagnosticLines.some((line) => {
		const event = JSON.parse(line);
		return event.event === 'kmod_change' && event.previous === 2 && event.next === 1;
	}), true);
});

test('hardware resync reasserts 256, restores a full frame, and directly rebuilds colors', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.autoPageColors = 1;
	router.s.edition = 128;
	router.s.gridWidth = 16;
	router.s.gridHeight = 8;
	harness.clearLog();

	router.hardwareResync();

	assert.equal(router.s.edition, 256);
	assert.equal(router.s.gridWidth, 16);
	assert.equal(router.s.gridHeight, 16);
	assert.equal(harness.outlets.filter((message) =>
		message[0] === 1 && message[1] === 'replaceframe').length, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'edition' && message[2] === 256), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'dual128' && message[2] === 0), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'mechatrellis' && message[2] === 0), true);
	assert.equal(router.pageColorQueue.filter((command) =>
		command[0] === 'colormap').length, 16);
	assert.equal(router.pageColorQueue.some((command) =>
		command[0] === 'colorpresetstore' || command[0] === 'colorpresetrecall'), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'togridmatrixanim' && message[1] === 'edition' && message[2] === 256), true);
	assert.equal(router.hardwareResyncVerifyTask.running, true);
	assert.equal(router.hardwareResyncVerifyTask.scheduledDelay, 250);

	router.hardwareResyncVerifyTask.running = false;
	router.hardwareResyncVerifyTask.callback.call(router.hardwareResyncVerifyTask.owner);
	assert.equal(harness.outlets.filter((message) =>
		message[0] === 1 && message[1] === 'replaceframe').length, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'togridmatrixio' && message[1] === 'flush'), true);
	assert.equal(harness.diagnosticLines.some((line) => {
		const event = JSON.parse(line);
		return event.event === 'hardware_resync_level_verify';
	}), true);
});

test('display recovery captures the bad state before rebuilding hardware and records an incident', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.autoPageColors = 1;
	router.s.mechaTrellisExtensions = 1;
	harness.clearLog();

	router.displayRecover();
	const request = harness.namedMessages.find((message) =>
		message[0] === 'togridmatrixio' && message[1] === 'diagnostic_snapshot');
	assert.ok(request);
	const incidentId = request[2];
	assert.match(incidentId, /-display-1$/);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'replaceframe'), true);
	assert.equal(router.displayRecoveryCompleteTask.running, true);
	assert.equal(router.displayRecoveryCompleteTask.scheduledDelay, 900);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'notice' && message[1] === 'warn'), true);

	router.displayDiagnosticSnapshot(incidentId, JSON.stringify({
		compositeHash: 123, colorHash: 456, packetStats: { presetRecallPackets: 3 }
	}));
	const incident = harness.diagnosticLines.map((line) => JSON.parse(line))
		.find((record) => record.incident === incidentId && record.phase === 'before');
	assert.ok(incident);
	assert.equal(incident.matrix.colorHash, 456);
	assert.equal(incident.router.firmwareStateReadable, 0);
	assert.equal(harness.diagnosticLines.some((line) => {
		const event = JSON.parse(line);
		return event.event === 'display_state_snapshot' && event.incident === incidentId;
	}), true);

	router.displayRecoveryCompleteTask.running = false;
	router.displayRecoveryCompleteTask.callback.call(router.displayRecoveryCompleteTask.owner);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'togridmatrixio' && message[1] === 'diagnostic_snapshot' &&
		message[2] === incidentId + ':after'), true);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'notice' && message[1] === 'info'), true);
});

test('bulk palette maps are serial-paced and page activation avoids firmware presets', () => {
	const harness = createHarness();
	const router = harness.context;
	const colors = new Array(48).fill(64);
	router.resetPageColorQueue();
	router.queueColorMapFrom(0, 0, colors);
	router.queueColorMapFrom(4, 0, colors);
	router.startPageColorQueue();
	assert.equal(router.pageColorQueueTask.scheduledDelay, 0);
	router.pageColorQueueTask.callback.call(router.pageColorQueueTask.owner);
	assert.equal(router.pageColorQueueTask.scheduledDelay, 8);

	router.resetPageColorQueue();
	router.pageColorPresetReady[0] = 1;
	router.activatePageColors(1);
	assert.equal(router.pageColorQueue.length, 16);
	assert.equal(router.pageColorQueue.every((command) => command[0] === 'colormap'), true);
	assert.equal(router.pageColorQueue.some((command) =>
		command[0] === 'colorpresetstore' || command[0] === 'colorpresetrecall'), false);
});

test('router loadbang normalizes stale persistent layout state to one logical 256', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.edition = 128;
	router.s.gridWidth = 16;
	router.s.gridHeight = 8;
	router.s.dual128Mode = 1;
	harness.clearLog();

	router.loadbang();

	assert.equal(router.s.edition, 256);
	assert.equal(router.s.gridWidth, 16);
	assert.equal(router.s.gridHeight, 16);
	assert.equal(router.s.dual128Mode, 0);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'edition' && message[2] === 256), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'dual128' && message[2] === 0), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'togridmatrixanim' && message[1] === 'edition' && message[2] === 256), true);
});

test('group mode key toggles directly with Main and retired mode 4 resolves to Main', () => {
	const harness = createHarness();
	const router = harness.context;
	router.setKmod(1);
	harness.clearLog();

	router.dispatch(14, 0, 1);
	assert.equal(router.s.kmod, 3);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'mode' && message[1] === 3), true);

	router.dispatch(14, 0, 1);
	assert.equal(router.s.kmod, 1);
	router.setKmod(4);
	assert.equal(router.s.kmod, 1);
	assert.equal(harness.outlets.some((message) => message[2] === 'clear'), false);
});

test('legacy clear requests rebuild the current page instead of blanking the matrix', () => {
	const harness = createHarness();
	const router = harness.context;
	harness.clearLog();

	router.clear();

	assert.equal(harness.outlets.filter((message) =>
		message[0] === 1 && message[1] === 'replaceframe').length, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'clear'), false);
});

test('button 14 opens the chooser only while held without recording or sending audio', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.automation.armed = true;

	router.dispatch(13, 0, 1);

	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.s.automation.recording, false);
	assert.deepEqual(Array.from(router.s.automation.events), []);
	assert.deepEqual(audioMessages(harness), []);
	assert.equal(hasLed(harness, 13, 0, 15), true);
	assert.equal(hasLed(harness, 0, 0, 3), true);
	assert.equal(hasLed(harness, 7, 0, 3), true);
	assert.equal(hasLed(harness, 15, 1, 3), true);
	assert.equal(hasLed(harness, 15, 15, 3), true);

	harness.clearLog();
	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.choosing, false);
	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.s.automation.recording, false);
	assert.deepEqual(audioMessages(harness), []);
});

test('group selection opens the protected lower editor shell', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	harness.clearLog();

	router.dispatch(3, 0, 1);

	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.editorWorkspace.active, true);
	assert.equal(router.s.editorWorkspace.targetType, 'group');
	assert.equal(router.s.editorWorkspace.targetId, 3);
	assert.equal(router.s.channels[3].muted, 0);
	assert.deepEqual(audioMessages(harness), []);
	assert.equal(hasLed(harness, 0, 8, 8), true);
	assert.equal(hasLed(harness, 0, 15, 15), true);
	assert.equal(hasLed(harness, 15, 15, 3), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_target' &&
		message[2] === 'group' && message[3] === 4), true);

	harness.clearLog();
	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.choosing, false);
	assert.equal(router.s.editorWorkspace.active, true);
	assert.equal(hasLed(harness, 15, 15, 6), true);
});

test('rightmost-column target buttons select tracks without toggling reverse', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	harness.clearLog();

	// 0-based row 6 is the sixth target button: physical row 7, track 6.
	router.dispatch(15, 6, 1);

	assert.equal(router.s.editorWorkspace.targetType, 'track');
	assert.equal(router.s.editorWorkspace.targetId, 5);
	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.tracks[5].reverse, 0);
	assert.deepEqual(audioMessages(harness), []);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_target' &&
		message[2] === 'track' && message[3] === 6), true);
});

test('active shell owns the lower half while upper legacy controls still work', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);
	harness.clearLog();

	router.dispatch(12, 8, 1);
	router.dispatch(1, 15, 1);

	assert.equal(router.s.tracks[7].randomOffset, 0);
	assert.equal(router.s.editorWorkspace.editorId, 'loop');
	assert.deepEqual(audioMessages(harness), []);

	router.dispatch(0, 3, 1);
	router.dispatch(15, 1, 1);
	assert.equal(router.s.channels[0].timestretch, 1);
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.deepEqual(audioMessages(harness), [
		['1[ch]timestretch', 'int', 1],
		['2[box]rev', 'int', 1]
	]);
});

test('button 14 momentarily reopens the chooser and leaving mode 2 clears the workspace', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(15, 6, 1);
	router.dispatch(13, 0, 0);
	harness.clearLog();

	router.dispatch(13, 0, 1);
	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.editorWorkspace.active, true);
	assert.equal(router.s.editorWorkspace.targetType, 'track');
	assert.equal(router.s.editorWorkspace.targetId, 5);
	assert.equal(hasLed(harness, 15, 6, 15), true);
	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.choosing, false);
	assert.equal(router.s.editorWorkspace.active, true);

	router.setKmod(1);
	assert.equal(router.s.editorWorkspace.choosing, false);
	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.s.editorWorkspace.targetType, 'none');
});

test('bottom-right exits and restores lower-half legacy routing', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);
	harness.clearLog();

	router.dispatch(15, 15, 1);
	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.s.editorWorkspace.targetType, 'none');
	assert.deepEqual(audioMessages(harness), []);

	harness.clearLog();
	router.dispatch(12, 8, 1);
	assert.equal(router.s.tracks[7].randomOffset, 1);
	assert.deepEqual(audioMessages(harness), [['9[box]rndOff', 'int', 1]]);
});

test('targets can change while held and pressing the current target cancels selection', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);

	router.dispatch(3, 0, 1);
	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.editorWorkspace.targetType, 'group');
	assert.equal(router.s.editorWorkspace.targetId, 3);

	router.dispatch(15, 6, 1);
	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.editorWorkspace.active, true);
	assert.equal(router.s.editorWorkspace.targetType, 'track');
	assert.equal(router.s.editorWorkspace.targetId, 5);

	harness.clearLog();
	router.dispatch(15, 6, 1);
	assert.equal(router.s.editorWorkspace.choosing, true);
	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.s.editorWorkspace.targetType, 'none');
	assert.equal(router.s.editorWorkspace.targetId, -1);
	assert.deepEqual(audioMessages(harness), []);
	assert.equal(hasLed(harness, 15, 6, 3), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_active' && message[2] === 0), true);

	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.choosing, false);
});

test('step page stores silent row-10 toggles for the current target', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);
	harness.clearLog();

	router.dispatch(4, 9, 1);
	assert.equal(router.s.editorWorkspace.stepPatterns['group:0'][4], 1);
	assert.deepEqual(audioMessages(harness), []);
	assert.equal(hasLed(harness, 4, 9, 15), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_step' &&
		message[2] === 'group' && message[3] === 1 &&
		message[4] === 5 && message[5] === 1), true);
	assert.deepEqual(harness.outlets.filter((message) => message[0] === 1), [
		[1, 'beginupdate'],
		[1, 'setcell', 4, 9, 15],
		[1, 'endupdate']
	]);

	harness.clearLog();
	assert.equal(router.applyEditorLevelDiff([[4, 9, 15]]), 0);
	assert.deepEqual(harness.outlets, []);

	router.dispatch(4, 9, 1);
	assert.equal(router.s.editorWorkspace.stepPatterns['group:0'][4], 0);
	assert.deepEqual(audioMessages(harness), []);
	assert.equal(hasLed(harness, 4, 9, 2), true);
});

test('step patterns remain isolated and recall across group and track targets', () => {
	const harness = createHarness();
	const router = harness.context;

	// Group 1, step 3.
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);
	router.dispatch(2, 9, 1);

	// Track 2, step 6.
	router.dispatch(13, 0, 1);
	router.dispatch(15, 2, 1);
	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.stepPatterns['track:1'][2], 0);
	router.dispatch(5, 9, 1);

	assert.equal(router.s.editorWorkspace.stepPatterns['group:0'][2], 1);
	assert.equal(router.s.editorWorkspace.stepPatterns['group:0'][5], 0);
	assert.equal(router.s.editorWorkspace.stepPatterns['track:1'][2], 0);
	assert.equal(router.s.editorWorkspace.stepPatterns['track:1'][5], 1);

	// Return to group 1 and verify its lane is redrawn, not the track lane.
	harness.clearLog();
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.targetType, 'group');
	assert.equal(router.s.editorWorkspace.targetId, 0);
	assert.equal(hasLed(harness, 2, 9, 15), true);
	assert.equal(hasLed(harness, 5, 9, 2), true);
	assert.deepEqual(audioMessages(harness), []);
});

test('silent playhead advances every two master-clock ticks with a two-cell diff', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);

	assert.equal(router.s.editorWorkspace.stepPlayhead, 0);
	harness.clearLog();
	router.clockTick();
	assert.equal(router.s.editorWorkspace.stepPlayhead, 0);
	assert.deepEqual(harness.outlets, []);
	assert.deepEqual(audioMessages(harness), []);

	router.clockTick();
	assert.equal(router.s.editorWorkspace.stepPlayhead, 1);
	assert.deepEqual(harness.outlets.filter((message) => message[0] === 1), [
		[1, 'beginupdate'],
		[1, 'setcell', 0, 8, 0],
		[1, 'setcell', 1, 8, 8],
		[1, 'endupdate']
	]);
	assert.deepEqual(audioMessages(harness), []);
});

test('playhead freezes while the target chooser is held and catches up on release', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);

	router.dispatch(13, 0, 1);
	harness.clearLog();
	router.clockTick();
	router.clockTick();
	assert.equal(router.s.editorWorkspace.stepPlayhead, 0);
	assert.equal(harness.outlets.some((message) => message[1] === 'beginupdate'), false);

	harness.clearLog();
	router.dispatch(13, 0, 0);
	assert.equal(router.s.editorWorkspace.stepPlayhead, 1);
	assert.equal(hasLed(harness, 1, 8, 8), true);
	assert.deepEqual(audioMessages(harness), []);
});

test('non-step editor pages do not receive clock playhead updates', () => {
	const harness = createHarness();
	const router = harness.context;
	router.dispatch(13, 0, 1);
	router.dispatch(0, 0, 1);
	router.dispatch(13, 0, 0);
	router.dispatch(1, 15, 1);

	assert.equal(router.s.editorWorkspace.editorId, 'loop');
	assert.equal(router.s.editorWorkspace.stepPlayhead, -1);
	harness.clearLog();
	router.clockTick();
	router.clockTick();
	assert.equal(harness.outlets.some((message) => message[1] === 'beginupdate'), false);
	assert.deepEqual(audioMessages(harness), []);
});

test('step sequencer requires Run and triggers the selected track at full probability', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);

	// Step 2 is armed, but target selection and gate editing remain silent.
	harness.clearLog();
	router.dispatch(1, 9, 1);
	assert.equal(audioMessages(harness).length, 0);
	router.clockTick();
	router.clockTick();
	assert.equal(audioMessages(harness).some((message) => message[0] === '2input'), false);

	// Run is physical row 11, column 1. Rewind the visual phase for this unit test.
	router.s.automation.tick = 0;
	router.s.editorWorkspace.lastSequencedStep = 0;
	router.dispatch(0, 10, 1);
	harness.clearLog();
	router.clockTick();
	router.clockTick();

	assert.equal(router.s.editorWorkspace.sequenceEnabled['track:0'], 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 1 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 1 && message[2] === 0), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_trigger' &&
		message[2] === 1 && message[3] === 2), true);
});

test('playback diagnostics capture trigger state before the player round trip', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[0].buffer = 23;
	router.s.tracks[0].length = 16;
	router.s.tracks[0].loopStart = 2;
	router.s.tracks[0].loopEnd = 12;
	router.s.tracks[0].loopActive = 1;
	selectTrack(harness, 0);

	router.triggerEditorTrack(0, 15);
	router.chRowPos(2, 15);
	router.diagnosticBufferLoad('/samples/one track.wav', 23, 1, 1250.5, 48000);

	const records = harness.diagnosticLines.map((line) => JSON.parse(line));
	const trigger = records.find((record) => record.event === 'sequence64_trigger');
	const loop = records.find((record) => record.event === 'loop_restore');
	const callback = records.find((record) => record.event === 'playback_position');
	const load = records.find((record) => record.event === 'buffer_load_request');

	assert.equal(trigger.track, 1);
	assert.equal(trigger.channel, 1);
	assert.equal(trigger.buffer, 23);
	assert.equal(trigger.slice, 16);
	assert.equal(trigger.loopStart, 2);
	assert.equal(trigger.loopEnd, 12);
	assert.equal(loop.sentLoopStart, 2);
	assert.equal(loop.sentLoopEnd, 12);
	assert.equal(callback.slice, 16);
	assert.equal(trigger.serial < callback.serial, true);
	assert.equal(load.path, '/samples/one track.wav');
	assert.equal(load.buffer, 23);
	assert.equal(load.channels, 1);
	assert.equal(load.durationMs, 1250.5);
	assert.equal(load.sampleRate, 48000);

	const beforeDisable = harness.diagnosticLines.length;
	router.diagnosticLogging(0);
	router.triggerEditorTrack(0, 4);
	assert.equal(harness.diagnosticLines.length, beforeDisable);
});

test('probability page can suppress an enabled step without changing its gate', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.dispatch(1, 9, 1);
	router.dispatch(0, 10, 1);

	// Probability page; bottom value row is zero probability.
	router.dispatch(4, 15, 1);
	router.dispatch(1, 14, 1);
	assert.equal(router.s.editorWorkspace.stepProbabilities['track:0'][1], 0);
	assert.equal(router.s.editorWorkspace.stepPatterns['track:0'][1], 1);

	harness.clearLog();
	router.clockTick();
	router.clockTick();
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);
	assert.equal(harness.outlets.some((message) => message[1] === 'beginframe'), false);
});

test('loop page edits range, division, latch, and reset through existing buses', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.dispatch(1, 15, 1);
	harness.clearLog();

	router.dispatch(4, 9, 1);
	assert.equal(router.s.tracks[0].loopStart, 4);
	assert.equal(router.s.tracks[0].loopEnd, 16);
	assert.equal(router.s.tracks[0].loopActive, 1);
	router.dispatch(7, 10, 1);
	assert.equal(router.s.tracks[0].loopEnd, 8);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[box]loop' && message[1] === 4 && message[2] === 8), true);

	router.dispatch(3, 12, 1);
	assert.equal(router.s.tracks[0].subLoopDiv, 12);
	router.dispatch(0, 13, 1);
	assert.equal(router.s.channels[0].gateLatch, 1);
	router.dispatch(0, 11, 1);
	assert.equal(router.s.tracks[0].loopActive, 0);
	router.dispatch(0, 11, 1);
	assert.equal(router.s.tracks[0].loopActive, 1);
	assert.equal(router.s.tracks[0].loopStart, 4);
	assert.equal(router.s.tracks[0].loopEnd, 8);
	router.dispatch(15, 11, 1);
	assert.equal(router.s.tracks[0].loopActive, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[box]loop' && message[1] === 0 && message[2] === 16), true);
	assert.equal(harness.outlets.some((message) => message[1] === 'beginframe'), false);
});

test('group sequence waits safely for a current track and then follows that track', () => {
	const harness = createHarness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(1, 9, 1);
	router.dispatch(0, 10, 1);
	harness.clearLog();
	router.clockTick();
	router.clockTick();
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_waiting_for_track'), true);

	router.s.tracks[0].channel = 1;
	router.s.channels[0].activeTrack = 0;
	router.s.automation.tick = 0;
	router.s.editorWorkspace.lastSequencedStep = 0;
	harness.clearLog();
	router.clockTick();
	router.clockTick();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 1 && message[2] === 1), true);
});

test('parameter page controls group, volume, octave, switches, stretch, and mute', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.dispatch(2, 15, 1);
	harness.clearLog();

	router.dispatch(2, 8, 1);
	assert.equal(router.s.tracks[0].channel, 3);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2chn[box]' && message[1] === 'int' && message[2] === 3), true);
	router.dispatch(15, 9, 1);
	assert.equal(router.s.channels[2].volume, 158);
	assert.equal(harness.namedMessages.some((message) => message[0] === '3vol_add'), true);

	router.dispatch(6, 10, 1);
	assert.equal(router.s.tracks[0].octave, 3);
	assert.equal(harness.namedMessages.filter((message) => message[0] === '2[box]upOct').length, 3);
	router.dispatch(0, 11, 1);
	router.dispatch(0, 12, 1);
	router.dispatch(0, 13, 1);
	router.dispatch(0, 14, 1);
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.equal(router.s.tracks[0].randomOffset, 1);
	assert.equal(router.s.channels[2].timestretch, 1);
	assert.equal(router.s.channels[2].muted, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]rev' && message[1] === 'int' && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]rndOff' && message[1] === 'int' && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '3[ch]timestretch' && message[1] === 'int' && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '3[box]mute' && message[1] === 'int' && message[2] === 1), true);
});

test('target automation records parameter state and replays it on its clock step', () => {
	const harness = createHarness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);

	// Arm target automation, then record reverse=on at step 1.
	router.dispatch(3, 15, 1);
	router.dispatch(0, 9, 1);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 11, 1);
	const automation = router.s.editorWorkspace.targetAutomation['track:0'];
	assert.equal(automation.events[0].some((event) =>
		event.type === 'reverse' && event.value === 1), true);

	// Enable playback, force the next tick to wrap to step 1, and verify replay.
	router.dispatch(3, 15, 1);
	router.dispatch(1, 9, 1);
	router.s.tracks[0].reverse = 0;
	router.s.automation.tick = 31;
	router.s.editorWorkspace.lastSequencedStep = 15;
	harness.clearLog();
	router.clockTick();
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]rev' && message[1] === 'int' && message[2] === 1), true);

	// The switch-category cell deletes only that category at step 1.
	router.dispatch(0, 13, 1);
	assert.equal(automation.events[0].length, 0);
});

test('FX page sequences gate level and restores unity when the editor exits', () => {
	const harness = createHarness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(5, 15, 1);

	// Physical row 11 selects the 8/15 level for step 2; row 15 col 1 runs FX.
	router.dispatch(1, 10, 1);
	assert.equal(router.s.editorWorkspace.gateFxLevels['group:0'][1], 8);
	assert.equal(router.s.editorWorkspace.gateFxEnabled['group:0'] || 0, 0);
	router.dispatch(0, 14, 1);
	assert.equal(router.s.editorWorkspace.gateFxEnabled['group:0'], 1);
	harness.clearLog();
	router.clockTick();
	router.clockTick();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 8 / 15 && message[2] === 8), true);

	harness.clearLog();
	router.dispatch(15, 15, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1 && message[2] === 8), true);
	assert.equal(router.s.editorWorkspace.fxAppliedChannel, -1);
});

test('reselecting a target leaves saved data intact but resets every editor transport', () => {
	const harness = createHarness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.dispatch(3, 9, 1);
	router.dispatch(0, 10, 1);
	router.s.editorWorkspace.gateFxEnabled['track:0'] = 1;
	const automation = router.s.editorWorkspace.targetAutomation['track:0'];
	automation.recording = 1;
	automation.playing = 1;

	// Switch away and back through the momentary chooser.
	router.dispatch(13, 0, 1);
	router.dispatch(15, 2, 1);
	router.dispatch(15, 1, 1);
	router.dispatch(13, 0, 0);

	assert.equal(router.s.editorWorkspace.stepPatterns['track:0'][3], 1);
	assert.equal(router.s.editorWorkspace.sequenceEnabled['track:0'], 0);
	assert.equal(router.s.editorWorkspace.gateFxEnabled['track:0'], 0);
	assert.equal(automation.recording, 0);
	assert.equal(automation.playing, 0);
});

test('autowatch reload restores FX unity and closes the editor while preserving data', () => {
	const firstHarness = createHarness();
	const firstRouter = firstHarness.context;
	selectGroup(firstHarness, 0);
	firstRouter.dispatch(5, 15, 1);
	firstRouter.dispatch(0, 10, 1);
	firstRouter.dispatch(0, 14, 1);
	assert.equal(firstRouter.s.editorWorkspace.fxAppliedChannel, 0);

	const reloadedHarness = createHarness(firstHarness.globalStores);
	const reloadedRouter = reloadedHarness.context;
	assert.equal(reloadedRouter.s.editorWorkspace.active, false);
	assert.equal(reloadedRouter.s.editorWorkspace.targetType, 'none');
	assert.equal(reloadedRouter.s.editorWorkspace.fxAppliedChannel, -1);
	assert.equal(reloadedRouter.s.editorWorkspace.gateFxLevels['group:0'][0], 8);
	assert.equal(reloadedHarness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1 && message[2] === 8), true);
});

test('optional editor colors accompany diffs without replacing monochrome levels', () => {
	const harness = createHarness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.editorBrightnessColors(1);
	harness.clearLog();
	router.dispatch(4, 9, 1);

	assert.equal(hasLed(harness, 4, 9, 15), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 4 && message[3] === 9), true);
	assert.equal(harness.outlets.some((message) => message[1] === 'level8cell'), false);
});

test('sequence64 semantic colors distinguish triggers, locks, gates, and transport roles', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].cut = { track: 0, slice: 1, gateLength: 1 };
	pattern.steps[2].locks.volume = { value: 7, behavior: 'set' };
	pattern.steps[3].cut = { track: 0, slice: 3, gateLength: 1 };
	pattern.steps[3].locks.reverse = { value: 1, behavior: 'set' };
	pattern.steps[4].cut = { track: 0, slice: 4, gateLength: 3 };
	const levels = router.buildEditorShellLevels();
	const colors = router.buildEditorShellColors(levels);
	const colorAt = (x, y) => Array.from(colors[router.editorShellLevelIndex(x, y)]);

	assert.deepEqual(colorAt(0, 8), [18, 46, 70]);
	assert.deepEqual(colorAt(1, 8), [0, 210, 255]);
	assert.deepEqual(colorAt(2, 8), [255, 180, 20]);
	assert.deepEqual(colorAt(3, 8), [210, 65, 255]);
	assert.deepEqual(colorAt(4, 8), [45, 230, 105]);
	assert.deepEqual(colorAt(5, 8), [70, 90, 225]);
	assert.deepEqual(colorAt(14, 12), [45, 230, 95]);
	assert.deepEqual(colorAt(15, 12), [255, 55, 45]);
	assert.deepEqual(colorAt(0, 13), [35, 235, 90]);
	assert.deepEqual(colorAt(1, 13), [255, 45, 110]);
	assert.deepEqual(colorAt(2, 13), [235, 235, 255]);
	assert.deepEqual(colorAt(0, 15), [0, 210, 255]);
	assert.deepEqual(colorAt(1, 15), [255, 175, 25]);
	assert.deepEqual(colorAt(15, 15), [255, 55, 45]);
});

test('sequence64 lock and Setup controls retain distinct semantic color families', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.sequence64HeldStep = 0;
	router.sequence64EditParameter = 'volume';
	let levels = router.buildEditorShellLevels();
	let colors = router.buildEditorShellColors(levels);
	let colorAt = (x, y) => Array.from(colors[router.editorShellLevelIndex(x, y)]);

	assert.deepEqual(colorAt(4, 12), [0, 210, 255]);
	assert.deepEqual(colorAt(5, 12), [245, 205, 30]);
	assert.deepEqual(colorAt(6, 12), [50, 225, 100]);
	assert.deepEqual(colorAt(8, 13), [50, 225, 100]);
	assert.deepEqual(colorAt(7, 14), [255, 125, 25]);
	assert.deepEqual(colorAt(9, 14), [45, 230, 105]);

	router.sequence64HeldStep = -1;
	router.s.editorWorkspace.view64 = 'setup';
	levels = router.buildEditorShellLevels();
	colors = router.buildEditorShellColors(levels);
	colorAt = (x, y) => Array.from(colors[router.editorShellLevelIndex(x, y)]);
	assert.deepEqual(colorAt(0, 8), [255, 65, 55]);
	assert.deepEqual(colorAt(7, 8), [235, 55, 190]);
	assert.deepEqual(colorAt(8, 9), [50, 225, 100]);
	assert.deepEqual(colorAt(0, 10), [85, 125, 255]);
	assert.deepEqual(colorAt(3, 10), [125, 95, 255]);
	assert.deepEqual(colorAt(0, 11), [255, 65, 40]);
	assert.deepEqual(colorAt(1, 11), [220, 55, 255]);
	assert.deepEqual(colorAt(2, 11), [20, 190, 220]);
	assert.deepEqual(colorAt(0, 12), [35, 220, 100]);
	assert.deepEqual(colorAt(0, 13), [255, 100, 35]);
	assert.deepEqual(colorAt(3, 14), [255, 45, 45]);
});

test('sequence64 emits semantic color-only diffs while levels remain authoritative', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.editorColors(1);
	harness.clearLog();

	router.dispatch(0, 8, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 0 && message[3] === 8 &&
		message[4] === 255 && message[5] === 105 && message[6] === 25), true);
	router.dispatch(0, 8, 0);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 0 && message[3] === 8 &&
		message[4] === 0 && message[5] === 210 && message[6] === 255), true);

	router.dispatch(0, 8, 1);
	router.openSequence64StepEditorAfterHold();
	router.dispatch(0, 8, 0);
	harness.clearLog();
	router.dispatch(5, 12, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 5 && message[3] === 13), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'setcell' &&
		message[2] === 5 && message[3] === 13), false);
	assert.equal(harness.outlets.some((message) => message[1] === 'level8cell'), false);
});

test('sequence64 clears trigger color while preserving amber for a real trigless lock', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.editorColors(1);

	router.dispatch(2, 8, 1);
	router.dispatch(2, 8, 0);
	harness.clearLog();
	router.dispatch(2, 8, 1);
	router.dispatch(2, 8, 0);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 2 && message[3] === 8 &&
		message[4] === 18 && message[5] === 46 && message[6] === 70), true);

	const step = router.s.editorWorkspace.patterns64['track:0'].steps[2];
	step.locks.volume = { value: 7, behavior: 'set' };
	const colors = router.buildEditorShellColors(router.buildEditorShellLevels());
	assert.deepEqual(
		Array.from(colors[router.editorShellLevelIndex(2, 8)]),
		[255, 180, 20]
	);
});

test('sequence64 semantic palette is rebuilt after leaving and returning to mode 2', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.s.editorWorkspace.patterns64['track:0'].steps[0].cut =
		{ track: 0, slice: 0, gateLength: 1 };
	router.editorColors(1);
	router.setKmod(1);
	router.setKmod(2);

	const queuedStepMaps = Array.from(router.pageColorQueue).filter((command) =>
		command[0] === 'colormap' && command[1] === 0 && command[2] === 8);
	assert.deepEqual(Array.from(queuedStepMaps.at(-1).slice(0, 6)),
		['colormap', 0, 8, 0, 210, 255]);
	assert.equal(queuedStepMaps.at(-1).length, 51);
});

test('leaving the editor restores the complete Mode-2 palette with no active target', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.editorColors(1);
	router.exitEditorWorkspace();
	router.setKmod(1);
	router.setKmod(2);

	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.s.editorWorkspace.targetType, 'none');
	const maps = Array.from(router.pageColorQueue).filter((command) =>
		command[0] === 'colormap');
	assert.equal(maps.length, 16);
	assert.deepEqual(Array.from(maps.map((command) => [command[1], command[2]])), [
		[0, 0], [4, 0], [8, 0], [12, 0],
		[0, 4], [4, 4], [8, 4], [12, 4],
		[0, 8], [4, 8], [8, 8], [12, 8],
		[0, 12], [4, 12], [8, 12], [12, 12]
	]);

	// With no editor owner, the lower half continues through ordinary Mod input.
	harness.clearLog();
	router.dispatch(15, 8, 1);
	assert.equal(router.s.tracks[7].reverse, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '9[box]rev' && message[1] === 'int' && message[2] === 1), true);
});

test('a complete 16x16 page palette queues exactly sixteen 4x4 maps', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.pageColorQueueTask.cancel();
	router.pageColorQueue = [];

	router.queueColorPaletteMaps(router.buildPageColorPalette(1));

	assert.equal(router.pageColorQueue.length, 16);
	assert.equal(router.pageColorQueue.every((command) =>
		command[0] === 'colormap' && command.length === 51), true);
	assert.deepEqual(Array.from(router.pageColorQueue.map((command) =>
		[command[1], command[2]])), [
		[0, 0], [4, 0], [8, 0], [12, 0],
		[0, 4], [4, 4], [8, 4], [12, 4],
		[0, 8], [4, 8], [8, 8], [12, 8],
		[0, 12], [4, 12], [8, 12], [12, 12]
	]);
});

test('queued editor maps cannot overwrite a newer single-cell color', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.editorColors(1);
	router.pageColorQueue = [[
		'colormap', 0, 8,
		...Array.from({ length: 48 }, () => 10)
	]];
	router.editorColorCache[router.editorLevelIndex(2, 9)] = '';
	harness.clearLog();

	router.emitEditorColor(2, 9, [20, 30, 40]);

	const queuedMap = router.pageColorQueue[0];
	const colorOffset = 3 + ((1 * 4 + 2) * 3);
	assert.deepEqual(Array.from(queuedMap.slice(colorOffset, colorOffset + 3)),
		[20, 30, 40]);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 2 && message[3] === 9 &&
		message[4] === 20 && message[5] === 30 && message[6] === 40), true);
});

test('editor entry is unavailable on a 16x8 grid or when disabled', () => {
	const shortGridHarness = createHarness();
	shortGridHarness.context.s.edition = 128;
	shortGridHarness.context.s.gridHeight = 8;
	shortGridHarness.context.dispatch(13, 0, 1);
	assert.equal(shortGridHarness.context.s.editorWorkspace.choosing, false);
	assert.deepEqual(audioMessages(shortGridHarness), []);

	const disabledHarness = createHarness();
	disabledHarness.context.extendedEditors(0);
	disabledHarness.clearLog();
	disabledHarness.context.dispatch(13, 0, 1);
	assert.equal(disabledHarness.context.s.editorWorkspace.choosing, false);
	assert.deepEqual(audioMessages(disabledHarness), []);
});

test('sequence64 track target creates a 16-step phrase without disturbing legacy data', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.editorWorkspace.stepPatterns['track:0'] = new Array(16).fill(0);
	router.s.editorWorkspace.stepPatterns['track:0'][3] = 1;
	router.s.editorWorkspace.stepProbabilities['track:0'] = new Array(16).fill(15);
	router.s.editorWorkspace.stepProbabilities['track:0'][3] = 8;

	selectTrack(harness, 0);

	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	assert.equal(router.s.editorWorkspace.layoutMode, 'sequence64');
	assert.equal(router.s.editorWorkspace.view64, 'sequence');
	assert.equal(pattern.steps.length, 64);
	assert.equal(pattern.length, 16);
	assert.equal(pattern.running, 0);
	assert.equal(pattern.steps[3].cut.track, 0);
	assert.equal(pattern.steps[3].cut.slice, 3);
	assert.equal(pattern.steps[3].probability, 8);
	assert.equal(router.s.editorWorkspace.stepPatterns['track:0'][3], 1);
	assert.equal(hasLed(harness, 0, 15, 15), true);
	assert.equal(hasLed(harness, 1, 15, 3), true);
});

test('sequence64 stays completely dormant until a target is selected', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.setKmod(1);
	harness.clearLog();
	router.dispatch(13, 0, 1);
	router.dispatch(13, 0, 0);
	router.dispatch(4, 1, 1);

	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(router.sequence64LiveRecordHeld, false);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'], undefined);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);
});

test('sequence64 uses four rows of steps and tap release toggles a cut', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[2].channel = 3;
	selectGroup(harness, 2);
	harness.clearLog();

	router.dispatch(4, 10, 1);
	assert.equal(router.s.editorWorkspace.patterns64['group:2'].steps[36].cut, null);
	router.dispatch(4, 10, 0);

	const cut = router.s.editorWorkspace.patterns64['group:2'].steps[36].cut;
	assert.equal(cut.track, -1);
	assert.equal(router.sequence64TargetTrackIndex('group', 2, cut), 2);
	assert.equal(cut.slice, 4);
	assert.equal(cut.gateLength, 1);
	assert.equal(hasLed(harness, 4, 10, 7), true);
});

test('sequence64 length buttons require a hold and cells outside the length are unavailable', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];

	router.dispatch(1, 12, 1);
	assert.equal(pattern.bars[0].length, 16);
	assert.equal(router.sequence64PendingLengthIndex, 1);
	router.dispatch(1, 12, 0);
	assert.equal(pattern.bars[0].length, 16);

	router.dispatch(1, 12, 1);
	router.commitSequence64LengthHold();
	router.dispatch(1, 12, 0);
	assert.equal(pattern.bars[0].length, 32);

	const levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(15, 9)], router.SEQUENCE64_EMPTY_STEP_LEVEL);
	assert.equal(levels[router.editorShellLevelIndex(0, 10)], 0);
	router.dispatch(0, 10, 1);
	router.dispatch(0, 10, 0);
	assert.equal(pattern.bars[0].steps[32].cut, null);
});

test('holding a step opens a persistent centered lock editor and clicking it again closes', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);

	// Create step 6, hold it to open, then release before editing.
	router.dispatch(5, 8, 1);
	router.dispatch(5, 8, 0);
	router.dispatch(5, 8, 1);
	router.openSequence64StepEditorAfterHold();
	router.dispatch(5, 8, 0);
	assert.equal(router.sequence64HeldStep, 5);

	// Parameters occupy centered columns 5–12; shapes occupy columns 6–11.
	router.dispatch(11, 13, 1);
	router.dispatch(6, 12, 1);
	router.dispatch(8, 13, 1);
	router.dispatch(7, 14, 1);
	router.dispatch(11, 12, 1);
	router.dispatch(3, 13, 1);

	const step = router.s.editorWorkspace.patterns64['track:0'].steps[5];
	assert.equal(step.cut.slice, 5);
	assert.equal(step.locks.slice.value, 11);
	assert.equal(router.sequence64LockValueColumn('slice', step), 11);
	assert.equal(step.cut.gateLength, 4);
	assert.equal(step.locks.volume.value, 8);
	assert.equal(step.locks.volume.behavior, 'pluck');
	assert.equal(router.sequence64HeldStep, 5);

	// With the popup open, an empty step is enabled and becomes the editor target.
	router.dispatch(6, 8, 1);
	router.dispatch(6, 8, 0);
	assert.notEqual(router.s.editorWorkspace.patterns64['track:0'].steps[6].cut, null);
	assert.equal(router.sequence64HeldStep, 6);
	assert.equal(router.sequence64EditParameter, 'gateLength');

	router.dispatch(6, 8, 1);
	router.dispatch(6, 8, 0);
	assert.equal(router.sequence64HeldStep, -1);
	assert.notEqual(step.cut, null);
});

test('sequence64 shows the selected target track playback position on row 15', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	router.s.channels[0].activeTrack = 0;

	router.boxled(6, 1, 15);
	let levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(6, 14)],
		router.SEQUENCE64_TRACK_POSITION_LEVEL);

	router.boxled(6, 1, 0);
	router.boxled(9, 1, 15);
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(6, 14)],
		router.SEQUENCE64_MIN_VISIBLE_LEVEL);
	assert.equal(levels[router.editorShellLevelIndex(9, 14)],
		router.SEQUENCE64_TRACK_POSITION_LEVEL);

	router.sequence64HeldStep = 0;
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(9, 14)], 0);

	router.sequence64HeldStep = -1;
	router.s.channels[0].activeTrack = -1;
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(9, 14)],
		router.SEQUENCE64_MIN_VISIBLE_LEVEL);
});

test('groove playback telemetry replaces a primed sequencer slice and clears sibling rows', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 1;
	selectGroup(harness, 0);
	router.setKmod(1);
	router.primeTrackPlaybackPosition(0, 0);
	router.primeTrackPlaybackPosition(1, 4);

	router.chRowPos(2, 5);

	assert.equal(router.playbackBg[router.bgIndex(0, 1)], 0);
	assert.equal(router.playbackBg[router.bgIndex(5, 1)], 15);
	assert.equal(router.playbackBg[router.bgIndex(4, 2)], 0);
	assert.equal(router.s.channels[0].activeTrack, 0);
});

test('sequence64 live-position lane plays slices and Record drops the cut at the playhead', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.setPlaybackBgCell(2, 1, 15);
	harness.clearLog();

	router.dispatch(6, 14, 1);
	router.dispatch(6, 14, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 0), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[mlr]pl-trig-now' && message[1] === 'bang'), true);
	assert.equal(router.playbackBg[router.bgIndex(2, 1)], 0);
	assert.equal(router.playbackBg[router.bgIndex(6, 1)], 15);
	const liveLevels = router.buildEditorShellLevels();
	assert.equal(liveLevels[router.editorShellLevelIndex(6, 14)],
		router.SEQUENCE64_TRACK_POSITION_LEVEL);

	router.sequence64ClockPosition = 9;
	router.dispatch(1, 13, 1);
	router.dispatch(11, 14, 1);
	router.dispatch(11, 14, 0);
	router.dispatch(1, 13, 0);
	assert.equal(router.sequence64LockRecordHeld, true);
	const cut = router.s.editorWorkspace.patterns64['track:0'].steps[9].cut;
	assert.equal(cut.track, 0);
	assert.equal(cut.slice, 11);
	assert.equal(cut.gateLength, 1);
	router.dispatch(1, 13, 1);
	router.dispatch(1, 13, 0);
	assert.equal(router.sequence64LockRecordHeld, false);
});

test('sequence64 gives every actionable dim control a firmware-visible level', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	let levels = router.buildEditorShellLevels();

	assert.equal(levels[router.editorShellLevelIndex(0, 8)] >= 3, true);
	assert.equal(levels[router.editorShellLevelIndex(15, 8)] >= 3, true);
	assert.equal(levels[router.editorShellLevelIndex(0, 9)], 0);

	router.sequence64HeldStep = 0;
	router.sequence64EditParameter = 'volume';
	levels = router.buildEditorShellLevels();
	for (let col = 4; col <= 11; col++) {
		assert.equal(levels[router.editorShellLevelIndex(col, 12)] >= 3, true);
	}
	for (let col = 0; col < 16; col++) {
		assert.equal(levels[router.editorShellLevelIndex(col, 13)] >= 3, true);
	}
	for (let col = 5; col <= 10; col++) {
		assert.equal(levels[router.editorShellLevelIndex(col, 14)] >= 3, true);
	}
});

test('sequence64 Run is opt-in and Stop halts the player owned by that target', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.dispatch(1, 8, 1);
	router.dispatch(1, 8, 0);

	router.clockTick();
	router.clockTick();
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);

	router.s.automation.tick = 0;
	router.sequence64ClockPosition = 0;
	router.s.editorWorkspace.lastSequencedStep = 0;
	router.dispatch(0, 13, 1);
	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 1 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[mlr]pl-trig-now' && message[1] === 'bang'), true);

	router.dispatch(0, 13, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].running, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[pl]stop' && message[1] === 'int' && message[2] === 1), true);
});

test('sequence64 Run stays latched after editor exit and playback continues', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].cut = { track: 0, slice: 8, gateLength: 1 };
	router.sequence64ClockPosition = 0;
	router.dispatch(0, 13, 1);
	router.dispatch(15, 15, 1);

	assert.equal(router.s.editorWorkspace.active, false);
	assert.equal(pattern.running, 1);
	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 8 && message[2] === 1), true);
});

test('mode-2 row 5 and column 12 independently toggle group and track Sequence64 Run', () => {
	const harness = createSequence64Harness();
	const router = harness.context;

	router.dispatch(3, 4, 1);
	router.dispatch(3, 4, 0);
	router.dispatch(11, 2, 1);
	router.dispatch(11, 2, 0);
	assert.equal(router.s.editorWorkspace.patterns64['group:3'].running, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:1'].running, 1);
	assert.equal(hasLed(harness, 3, 4, 15), true);
	assert.equal(hasLed(harness, 11, 2, 15), true);

	router.dispatch(3, 4, 1);
	router.dispatch(3, 4, 0);
	router.dispatch(11, 2, 1);
	router.dispatch(11, 2, 0);
	assert.equal(router.s.editorWorkspace.patterns64['group:3'].running, 0);
	assert.equal(router.s.editorWorkspace.patterns64['track:1'].running, 0);
	assert.equal(hasLed(harness, 3, 4, 3), true);
	assert.equal(hasLed(harness, 11, 2, 3), true);
});

test('holding a mode-2 Run shortcut opens its editor without toggling playback', () => {
	const groupHarness = createSequence64Harness();
	const groupRouter = groupHarness.context;
	groupRouter.dispatch(3, 4, 1);
	assert.equal(groupRouter.s.editorWorkspace.patterns64['group:3'].running, 0);
	groupRouter.openSequence64RunShortcutAfterHold();
	groupRouter.dispatch(3, 4, 0);
	assert.equal(groupRouter.s.editorWorkspace.targetType, 'group');
	assert.equal(groupRouter.s.editorWorkspace.targetId, 3);
	assert.equal(groupRouter.s.editorWorkspace.patterns64['group:3'].running, 0);
	assert.equal(groupRouter.sequence64PendingRunShortcut, null);

	// Opening a lower track editor moves the release into editor-owned rows; it
	// must still complete the original shortcut gesture without toggling Run.
	const trackHarness = createSequence64Harness();
	const trackRouter = trackHarness.context;
	trackRouter.dispatch(11, 10, 1);
	trackRouter.openSequence64RunShortcutAfterHold();
	trackRouter.dispatch(11, 10, 0);
	assert.equal(trackRouter.s.editorWorkspace.targetType, 'track');
	assert.equal(trackRouter.s.editorWorkspace.targetId, 9);
	assert.equal(trackRouter.s.editorWorkspace.patterns64['track:9'].running, 0);
	assert.equal(trackRouter.sequence64PendingRunShortcut, null);
});

test('mode-2 group and track Run shortcuts use the red palette family', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	const palette = router.buildPageColorPalette(2);

	assert.deepEqual(Array.from(palette[4 * 16 + 3]), [225, 45, 70]);
	assert.deepEqual(Array.from(palette[10 * 16 + 11]), [225, 45, 70]);
});

test('mode-2 group and phrase Run keys pulse on their audio triggers and restore latch levels', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase = router.ensureSequence64Pattern('track', 0);
	group.steps[0].cut = { track: 0, slice: 4, gateLength: 1 };
	group.running = 1;
	phrase.steps[0].locks.reverse = { value: 1, behavior: 'set' };
	harness.clearLog();

	router.runSequence64StepForTarget('group', 0, group, 0, 0);

	assert.equal(harness.outlets.some((message) =>
		message[0] === 3 && message[1] === 'kf' &&
		message[2] === 0 && message[3] === 4 &&
		message[4] === 6 && message[6] === 15), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 3 && message[1] === 'kf' &&
		message[2] === 11 && message[3] === 1 &&
		message[4] === 15 && message[6] === 3), true);
});

test('independent running Sequence64 targets are all serviced by the shared clock', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 2;
	const trackPattern = router.ensureSequence64Pattern('track', 0);
	const groupPattern = router.ensureSequence64Pattern('group', 1);
	trackPattern.steps[1].cut = { track: 0, slice: 4, gateLength: 1 };
	groupPattern.steps[1].cut = { track: 1, slice: 12, gateLength: 1 };
	router.sequence64ClockPosition = 0;
	router.setSequence64TargetRunning('track', 0, 1);
	router.setSequence64TargetRunning('group', 1, 1);
	harness.clearLog();

	router.sequence64SubPulse();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '3input' && message[1] === 12 && message[2] === 1), true);
});

test('ordinary main-page cuts remain on the legacy quantized trigger path', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 8;
	router.setKmod(1);
	harness.clearLog();

	router.dispatch(4, 1, 1);

	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '8[mlr]pl-trig-now'), false);
});

test('sequence64 emits one main-page playback ping even after its group was stopped', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.channels[0].activeTrack = 0;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[0].cut = { track: -1, slice: 7, gateLength: 1 };
	pattern.running = 1;
	router.setKmod(1);
	router.handleChannelOnArray(0, 0, 0, 0, 0, 0, 0, 0);
	assert.equal(router.s.channels[0].activeTrack, -1);
	assert.equal(router.s.channels[0].lastActiveTrack, 0);
	harness.clearLog();

	router.runSequence64Step(0, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 7 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[mlr]pl-trig-now' && message[1] === 'bang'), true);
	assert.equal(harness.outlets.filter((message) =>
		message[0] === 3 && message[1] === 'kf' &&
		message[2] === 7 && message[3] === 1).length, 1);

	// A healthy audio callback is still accepted, but does not duplicate the
	// proactive visual ping.
	router.chRowPos(2, 7);
	assert.equal(harness.outlets.filter((message) =>
		message[0] === 3 && message[1] === 'kf' &&
		message[2] === 7 && message[3] === 1).length, 1);
});

test('sequence64 advances exactly one step per audio-derived subpulse', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].cut = { track: 0, slice: 3, gateLength: 1 };
	pattern.steps[2].cut = { track: 0, slice: 7, gateLength: 1 };
	pattern.steps[3].cut = { track: 0, slice: 11, gateLength: 1 };
	pattern.steps[4].cut = { track: 0, slice: 15, gateLength: 1 };
	router.timeMsUpdate(600);
	router.dispatch(0, 13, 1);
	harness.clearLog();

	// The legacy tr_pulse still advances automation, but no longer subdivides
	// the sequence in JavaScript.
	router.clockTick();
	assert.equal(router.s.automation.tick, 1);
	assert.equal(router.sequence64ClockPosition, 0);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);
	assert.equal(router.sequence64ShapeRampMs(), 38);

	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), true);

	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 2);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 7 && message[2] === 1), true);

	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 3);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 11 && message[2] === 1), true);

	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 4);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 15 && message[2] === 1), true);
});

test('legacy tr_pulse cannot cluster or catch up sequence64 steps', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	for (let step = 1; step <= 5; step++) {
		pattern.steps[step].cut = { track: 0, slice: step, gateLength: 1 };
	}
	router.dispatch(0, 13, 1);
	harness.clearLog();

	router.sequence64SubPulse();
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 2);

	// Even several delayed legacy callbacks cannot inject missing sequence
	// subdivisions. Only the next audio-derived subpulse advances one step.
	harness.clearLog();
	router.clockTick();
	router.clockTick();
	router.clockTick();
	assert.equal(router.sequence64ClockPosition, 2);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);

	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 3);
	assert.equal(harness.namedMessages.filter((message) =>
		message[0] === '2input' && message[2] === 1).length, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), true);
});

test('sequence64 maps one complete bar across the four 16-cell rows', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);

	for (let step = 0; step < 64; step++) {
		router.sequence64SubPulse();
	}

	assert.equal(router.sequence64ClockPosition, 64);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.deepEqual(Array.from(router.sequence64StepCoords(0)), [0, 8]);
	assert.deepEqual(Array.from(router.sequence64StepCoords(16)), [0, 9]);
	assert.deepEqual(Array.from(router.sequence64StepCoords(32)), [0, 10]);
	assert.deepEqual(Array.from(router.sequence64StepCoords(48)), [0, 11]);
});

test('sequence64 preserves a saved single-bar pattern as bar 1', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	const savedSteps = Array.from({ length: 64 }, () => ({
		cut: null,
		locks: {},
		probability: 15
	}));
	savedSteps[20].cut = { track: 0, slice: 11, gateLength: 1 };
	savedSteps[4].locks.octave = { value: -1, behavior: 'set' };
	router.s.editorWorkspace.patterns64['track:0'] = {
		version: 1,
		length: 32,
		running: 0,
		legacyMigrated: 1,
		steps: savedSteps
	};

	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	assert.equal(pattern.version, 9);
	assert.equal(pattern.bars.length, 1);
	assert.equal(pattern.bars[0].length, 32);
	assert.equal(pattern.bars[0].steps[20].cut.slice, 11);
	assert.equal(pattern.bars[0].steps[4].locks.octave, undefined);
	assert.equal(pattern.bars[0].steps[4].locks.transpose.value, -12);
	assert.equal(pattern.bars[0].steps[4].locks.transpose.pitchOctave, -1);
	assert.equal(pattern.bars[0].steps[4].locks.transpose.pitchSemitone, 0);
	assert.equal(pattern.bars[0].steps[4].locks.transpose.behavior, 'set');
	assert.equal(pattern.bars[0].steps[4].condition, 0);
	assert.equal(pattern.steps, pattern.bars[0].steps);
	assert.equal(pattern.length, pattern.bars[0].length);
});

test('sequence64 bar navigation keeps each 64-step bar independent', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];

	// Bar 1, step 3.
	router.dispatch(2, 8, 1);
	router.dispatch(2, 8, 0);
	assert.equal(pattern.bars.length, 1);
	assert.notEqual(pattern.bars[0].steps[2].cut, null);

	// Row 13 column 15 adds and selects bar 2.
	router.dispatch(14, 12, 1);
	assert.equal(pattern.bars.length, 2);
	assert.equal(pattern.currentBar, 1);
	assert.equal(pattern.running, 0);
	assert.equal(pattern.bars[1].steps[2].cut, null);

	router.dispatch(6, 8, 1);
	router.dispatch(6, 8, 0);
	assert.notEqual(pattern.bars[1].steps[6].cut, null);
	assert.equal(pattern.bars[0].steps[6].cut, null);

	// Direct bar buttons begin at row 13 column 5.
	router.dispatch(4, 12, 1);
	router.dispatch(4, 12, 0);
	assert.equal(pattern.currentBar, 0);
	assert.equal(hasLed(harness, 4, 12, 15), true);
	router.dispatch(13, 12, 1);
	assert.equal(pattern.currentBar, 1);

	// Removing a bar is deliberately a double press on row 13 column 16.
	router.dispatch(15, 12, 1);
	assert.equal(pattern.bars.length, 2);
	router.dispatch(15, 12, 1);
	assert.equal(pattern.bars.length, 1);
	assert.equal(pattern.currentBar, 0);
	assert.notEqual(pattern.steps[2].cut, null);
});

test('holding bar buttons sets 1–8 active bars without erasing parked bar data', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];

	// Hold bar 4 to set a four-bar pattern and view its last bar.
	router.dispatch(7, 12, 1);
	assert.equal(pattern.bars.length, 1);
	router.commitSequence64BarHold();
	router.dispatch(7, 12, 0);
	assert.equal(pattern.bars.length, 4);
	assert.equal(pattern.currentBar, 3);
	pattern.bars[3].steps[9].cut = { track: 0, slice: 12, gateLength: 1 };

	// Hold bar 2 to shorten. Trailing material is parked rather than deleted.
	router.dispatch(5, 12, 1);
	router.commitSequence64BarHold();
	router.dispatch(5, 12, 0);
	assert.equal(pattern.bars.length, 2);
	assert.equal(pattern.parkedBars.length, 2);
	assert.equal(pattern.currentBar, 1);

	// Holding bar 4 again restores the original trailing bars and their data.
	router.dispatch(7, 12, 1);
	router.commitSequence64BarHold();
	router.dispatch(7, 12, 0);
	assert.equal(pattern.bars.length, 4);
	assert.equal(pattern.parkedBars.length, 0);
	assert.equal(pattern.bars[3].steps[9].cut.slice, 12);

	// A short tap still navigates without changing the bar count.
	router.dispatch(4, 12, 1);
	router.dispatch(4, 12, 0);
	assert.equal(pattern.currentBar, 0);
	assert.equal(pattern.bars.length, 4);
});

test('sequence64 playback crosses bar boundaries without resetting step phase', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	router.addSequence64Bar();
	pattern.bars[0].steps[63].cut = { track: 0, slice: 4, gateLength: 1 };
	pattern.bars[1].steps[0].cut = { track: 0, slice: 9, gateLength: 1 };
	router.sequence64ClockPosition = 62;
	router.s.editorWorkspace.lastSequencedBar = 0;
	router.s.editorWorkspace.lastSequencedStep = 62;
	router.setCurrentSequence64Running(1);
	harness.clearLog();

	router.advanceSequence64ClockSubstep();
	assert.equal(router.currentSequence64BarIndex(), 0);
	assert.equal(router.currentSequence64StepIndex(), 63);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);

	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(router.currentSequence64BarIndex(), 1);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 9 && message[2] === 1), true);
});

test('sequence64 Stop restores Set locks and cancels active Gate shapes without erasing programming', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[1].locks.volume = { value: 6, behavior: 'set' };
	router.dispatch(0, 13, 1);
	harness.clearLog();
	router.sequence64SubPulse();

	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 0.4 && message[2] === 0), true);
	assert.equal(router.s.editorWorkspace.parameterValues64['group:0'].volume, 6);
	harness.clearLog();
	router.dispatch(0, 13, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);
	assert.equal(pattern.steps[1].locks.volume.value, 6);
	assert.equal(pattern.steps[1].locks.volume.behavior, 'set');

	pattern.steps[2].locks.volume = { value: 2, behavior: 'gate' };
	pattern.steps[2].cut = { track: 0, slice: 2, gateLength: 4 };
	router.sequence64ClockPosition = 1;
	router.s.editorWorkspace.lastSequencedStep = 1;
	router.dispatch(0, 13, 1);
	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.some((shape) => shape.behavior === 'gate'), true);
	harness.clearLog();
	router.dispatch(0, 13, 1);
	assert.equal(router.sequence64ActiveShapes.some((shape) => shape.behavior === 'gate'), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);
});

test('Restore Start State is the explicit way to restore playback and persistent locks', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[0].playPos = 4;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].cut = { track: 0, slice: 9, gateLength: 1 };
	pattern.steps[1].locks.reverse = { value: 1, behavior: 'set' };
	pattern.steps[1].locks.volume = { value: 5, behavior: 'set' };
	router.dispatch(0, 13, 1);
	router.sequence64SubPulse();
	assert.equal(router.s.tracks[0].playPos, 13);
	assert.equal(router.s.tracks[0].reverse, 1);

	harness.clearLog();
	router.dispatch(1, 15, 1);
	router.dispatch(5, 14, 1);
	assert.equal(router.s.tracks[0].playPos, 4);
	assert.equal(router.s.tracks[0].reverse, 0);
	assert.equal(router.s.channels[0].sequence64Owner, null);
	assert.equal(router.s.editorWorkspace.parameterValues64['track:0'].volume, 15);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);
});

test('sequence64 Stop cancels one-shot tails and a newer event replaces the same parameter voice', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[1].locks.volume = { value: 3, behavior: 'swell' };
	pattern.steps[2].locks.volume = { value: 11, behavior: 'pluck' };
	router.dispatch(0, 13, 1);
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.length, 1);
	router.dispatch(0, 13, 1);
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.length, 0);

	// Restart on step 1, then fire step 2 while running: its pluck replaces swell.
	router.dispatch(0, 13, 1);
	router.sequence64ClockPosition = 0;
	router.s.editorWorkspace.lastSequencedStep = 0;
	pattern.lastSequencedFlat = 0;
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes[0].behavior, 'swell');
	router.sequence64ClockPosition = 1;
	router.s.editorWorkspace.lastSequencedStep = 1;
	pattern.lastSequencedFlat = 1;
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.length, 1);
	assert.equal(router.sequence64ActiveShapes[0].behavior, 'pluck');
});

test('main-page button 14 records the quantized chRowPos for the selected target only', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 2;
	selectGroup(harness, 0);
	router.setKmod(1);
	assert.equal(router.s.editorWorkspace.active, true);

	router.dispatch(13, 0, 1);
	router.dispatch(4, 1, 1);
	router.chRowPos(2, 6);
	const step = router.s.editorWorkspace.patterns64['group:0'].steps[0];
	assert.equal(step.cut.track, 0);
	assert.equal(step.cut.slice, 6);

	router.dispatch(5, 2, 1);
	router.chRowPos(3, 7);
	assert.equal(step.cut.track, 0);
	assert.equal(step.cut.slice, 6);
	router.dispatch(13, 0, 0);
	assert.equal(router.sequence64LiveRecordHeld, false);
});

test('a cut pressed while live record is held may commit after the button is released', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.setKmod(1);
	router.dispatch(13, 0, 1);
	router.dispatch(9, 1, 1);
	router.dispatch(13, 0, 0);
	router.chRowPos(2, 9);

	assert.equal(router.s.editorWorkspace.patterns64['track:0'].steps[0].cut.slice, 9);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].length, 16);
});

test('a live take rounds its release to the nearest 16-step beat', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.setKmod(1);
	router.sequence64ClockPosition = 0;
	router.dispatch(13, 0, 1);
	router.dispatch(4, 1, 1);
	router.chRowPos(2, 4);
	router.sequence64ClockPosition = 65;
	router.dispatch(13, 0, 0);

	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	assert.equal(pattern.bars.length, 1);
	assert.equal(pattern.bars[0].length, 64);
	assert.equal(pattern.bars[0].steps[0].cut.slice, 4);
});

test('a longer live take creates full bars and a partial final bar without early wrapping', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[5].cut = { track: 0, slice: 1, gateLength: 4 };
	pattern.steps[5].locks.slice = { value: 1, behavior: 'set' };
	pattern.steps[5].locks.volume = { value: 7, behavior: 'set' };
	pattern.steps[20].cut = { track: 0, slice: 12, gateLength: 1 };
	router.setKmod(1);

	router.sequence64ClockPosition = 5;
	router.dispatch(13, 0, 1);
	router.dispatch(3, 1, 1);
	router.chRowPos(2, 3);
	router.sequence64ClockPosition = 70;
	router.dispatch(8, 1, 1);
	router.chRowPos(2, 8);
	router.sequence64ClockPosition = 101;
	router.dispatch(13, 0, 0);

	assert.equal(pattern.bars.length, 2);
	assert.equal(pattern.bars[0].length, 64);
	assert.equal(pattern.bars[1].length, 32);
	assert.equal(pattern.bars[0].steps[5].cut.slice, 3);
	assert.equal(pattern.bars[0].steps[5].cut.gateLength, 4);
	assert.equal(pattern.bars[0].steps[5].locks.slice, undefined);
	assert.equal(pattern.bars[0].steps[5].locks.volume.value, 7);
	assert.equal(pattern.bars[0].steps[20].cut, null);
	assert.equal(pattern.bars[1].steps[6].cut.slice, 8);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_live_take' &&
		message[4] === 96 && message[5] === 2 && message[6] === 2), true);
});

test('an empty live-record gesture leaves the saved pattern unchanged', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[12].cut = { track: 0, slice: 6, gateLength: 1 };
	router.setKmod(1);
	router.dispatch(13, 0, 1);
	router.sequence64ClockPosition = 80;
	router.dispatch(13, 0, 0);

	assert.equal(pattern.bars.length, 1);
	assert.equal(pattern.length, 16);
	assert.equal(pattern.steps[12].cut.slice, 6);
});

test('live recording previews into the currently playing bar rather than the viewed bar', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	router.addSequence64Bar();
	router.selectSequence64Bar(0);
	router.sequence64ClockPosition = 64;
	router.setKmod(1);
	router.dispatch(13, 0, 1);
	router.dispatch(5, 1, 1);
	router.chRowPos(2, 5);

	assert.equal(pattern.currentBar, 0);
	assert.equal(pattern.bars[0].steps[0].cut, null);
	assert.equal(pattern.bars[1].steps[0].cut.slice, 5);
});

test('sequence64 Setup retains latched lock recording until Record is tapped again', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const baseVolume = router.s.channels[0].volume;

	// Latch Record, switch to Setup, then move volume and semitone pitch one-handed.
	router.dispatch(1, 13, 1);
	router.dispatch(1, 13, 0);
	assert.equal(router.sequence64LockRecordHeld, true);
	router.dispatch(1, 15, 1);
	router.dispatch(10, 9, 1);
	router.dispatch(13, 10, 1);
	const step = router.s.editorWorkspace.patterns64['track:0'].steps[0];
	assert.equal(router.s.editorWorkspace.view64, 'setup');
	assert.equal(step.locks.volume.value, 10);
	assert.equal(step.locks.volume.behavior, 'set');
	assert.equal(step.locks.transpose.value, 5);
	assert.equal(step.locks.transpose.pitchOctave, 0);
	assert.equal(step.locks.transpose.pitchSemitone, 5);
	assert.equal(router.s.tracks[0].transpose, 5);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]transpose' && message[1] === 'int' && message[2] === 5), true);
	assert.equal(router.s.channels[0].volume, baseVolume);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 10 / 15), true);
	assert.equal(router.sequence64LockRecordHeld, true);
	router.dispatch(0, 15, 1);
	router.dispatch(1, 13, 1);
	router.dispatch(1, 13, 0);
	assert.equal(router.sequence64LockRecordHeld, false);
});

test('pitch locks combine step-local octave and semitone components in either order', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[0].cut = { track: 0, slice: 0, gateLength: 1 };
	router.sequence64HeldStep = 0;
	router.sequence64EditParameter = 'transpose';

	router.dispatch(1, 13, 1);
	assert.equal(router.s.tracks[0].octave, 0);
	assert.equal(pattern.steps[0].locks.transpose.pitchOctave, 1);
	assert.equal(pattern.steps[0].locks.transpose.pitchSemitone, 0);
	assert.equal(pattern.steps[0].locks.transpose.value, 12);

	router.dispatch(14, 13, 1);
	assert.equal(pattern.steps[0].locks.transpose.pitchOctave, 1);
	assert.equal(pattern.steps[0].locks.transpose.pitchSemitone, 6);
	assert.equal(pattern.steps[0].locks.transpose.value, 18);
	assert.equal(router.sequence64LockValueColumn('transpose', pattern.steps[0]), 14);
	pattern.running = 1;
	router.runSequence64StepForTarget('track', 0, pattern, 0, 0);
	assert.equal(router.s.tracks[0].transpose, 18);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]transpose' && message[1] === 'int' && message[2] === 18), true);

	router.dispatch(0, 13, 1);
	assert.equal(pattern.steps[0].locks.transpose.pitchOctave, 0);
	assert.equal(pattern.steps[0].locks.transpose.pitchSemitone, 6);
	assert.equal(pattern.steps[0].locks.transpose.value, 6);

	router.stopSequence64Target('track', 0, 'test');
	assert.equal(router.s.tracks[0].transpose, 0);
});

test('sequence64 pattern clear requires a deliberate second press', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.dispatch(0, 8, 1);
	router.dispatch(0, 8, 0);
	router.dispatch(15, 13, 1);
	assert.notEqual(router.s.editorWorkspace.patterns64['track:0'].steps[0].cut, null);
	router.dispatch(15, 13, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].steps[0].cut, null);
});

test('fresh group patterns resolve active, last-active, first-assigned, then unavailable defaults', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[2].channel = 1;
	router.s.tracks[4].channel = 1;
	router.s.channels[0].activeTrack = 4;
	router.s.channels[0].lastActiveTrack = 2;

	let pattern = router.ensureSequence64Pattern('group', 0);
	assert.equal(pattern.defaultTrack, 4);
	assert.equal(pattern.steps.every((step) => step.cut === null), true);

	delete router.s.editorWorkspace.patterns64['group:0'];
	router.s.channels[0].activeTrack = -1;
	pattern = router.ensureSequence64Pattern('group', 0);
	assert.equal(pattern.defaultTrack, 2);

	delete router.s.editorWorkspace.patterns64['group:0'];
	router.s.channels[0].lastActiveTrack = -1;
	pattern = router.ensureSequence64Pattern('group', 0);
	assert.equal(pattern.defaultTrack, 2);

	router.s.tracks[2].channel = 2;
	router.s.tracks[4].channel = 2;
	delete router.s.editorWorkspace.patterns64['group:0'];
	pattern = router.ensureSequence64Pattern('group', 0);
	assert.equal(pattern.defaultTrack, -1);
	assert.equal(router.sequence64TargetTrackIndex('group', 0, null), -1);
});

test('a fresh group pattern and its live lane immediately use the resolved default track', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[3].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	assert.equal(pattern.defaultTrack, 3);

	router.dispatch(5, 8, 1);
	router.dispatch(5, 8, 0);
	assert.equal(pattern.steps[5].cut.track, -1);
	pattern.running = 1;
	harness.clearLog();
	router.runSequence64StepForTarget('group', 0, pattern, 0, 5);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '5input' && message[1] === 5 && message[2] === 1), true);

	harness.clearLog();
	router.dispatch(9, 14, 1);
	router.dispatch(9, 14, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '5input' && message[1] === 9 && message[2] === 1), true);
});

test('group cuts launch a one-shot track phrase whose first step merges with the group hit', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase = router.ensureSequence64Pattern('track', 0);
	group.steps[0].cut = { track: 0, slice: 4, gateLength: 1 };
	group.running = 1;
	phrase.steps[0].locks.reverse = { value: 1, behavior: 'set' };
	phrase.steps[1].cut = { track: 0, slice: 6, gateLength: 1 };
	phrase.steps[1].locks.slice = { value: 9, behavior: 'set' };

	router.runSequence64StepForTarget('group', 0, group, 0, 0);
	const instance = router.activeSequence64PhraseForTrack(0);
	assert.ok(instance);
	assert.equal(instance.parentTargetKey, 'group:0');
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);

	// groove~/ch.maxpat may report changing playback positions continuously;
	// this telemetry must not be mistaken for a new manual cut.
	router.sequence64PlaybackPingGuard = null;
	router.chRowPos(2, 5);
	assert.equal(router.activeSequence64PhraseForTrack(0), instance);
	assert.equal(router.s.channels[0].sequence64Owner, 'group:0');

	group.lastSequencedAbsolute = 0;
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 13 && message[2] === 1), true);

	for (let pulse = 2; pulse <= 16; pulse++) router.advanceSequence64ClockSubstep();
	assert.equal(router.activeSequence64PhraseForTrack(0), null);
	assert.equal(router.s.tracks[0].reverse, 0);
	assert.equal(group.steps[0].cut.slice, 4);
	assert.equal(phrase.steps[0].locks.reverse.value, 1);
});

test('opening the phrase editor cannot substitute its playhead for the group clock', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase = router.ensureSequence64Pattern('track', 0);
	group.steps[10].cut = { track: 0, slice: 3, gateLength: 1 };
	group.steps[11].cut = { track: 0, slice: 7, gateLength: 1 };
	phrase.steps[2].cut = { track: 0, slice: 12, gateLength: 1 };
	group.running = 1;
	group.phaseOrigin = 0;
	group.lastSequencedAbsolute = 9;
	router.sequence64ClockPosition = 10;
	router.runSequence64StepForTarget('group', 0, group, 0, 10);
	group.lastSequencedAbsolute = 10;

	selectTrack(harness, 0);
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(router.sequence64ClockPosition, 11);
	assert.equal(group.lastSequencedAbsolute, 11);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 7 && message[2] === 1), true);
});

test('saved rational rates service every crossed group step and scale phrases', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	group.steps[1].cut = { track: 0, slice: 4, gateLength: 1 };
	group.steps[2].cut = { track: 0, slice: 8, gateLength: 1 };
	group.running = 1;
	group.phaseOrigin = 0;
	group.lastSequencedAbsolute = 0;
	router.sequence64ClockPosition = 0;
	router.setSequence64PatternRate('group', 0, 2, 1);
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	const groupPresses = harness.namedMessages.filter((message) =>
		message[0] === '2input' && message[2] === 1);
	assert.deepEqual(groupPresses, [
		['2input', 4, 1],
		['2input', 8, 1]
	]);

	const phrase = router.ensureSequence64Pattern('track', 0);
	phrase.steps[1].cut = { track: 0, slice: 11, gateLength: 1 };
	router.setSequence64PatternRate('track', 0, 1, 2);
	router.sequence64ClockPosition = 20;
	router.launchSequence64TrackPhrase(0, 2, 'group:0', 'group:0', false);
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 13 && message[2] === 1), false);
	router.advanceSequence64ClockSubstep();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 13 && message[2] === 1), true);
});

test('Shift selects arbitrary bar endpoints and per-pattern rates without toggling cuts', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];

	// Physical row 16 column 12 is Shift. Step 23 becomes the exact endpoint.
	router.dispatch(11, 15, 1);
	router.dispatch(6, 9, 1);
	assert.equal(pattern.bars[0].length, 23);
	router.dispatch(6, 13, 1);
	assert.equal(pattern.rateNumerator, 2);
	assert.equal(pattern.rateDenominator, 1);
	assert.equal(router.buildEditorShellLevels()[
		router.editorShellLevelIndex(6, 13)], 15);

	// Releasing Shift before the length cell must not turn that cell into a cut.
	router.dispatch(11, 15, 0);
	router.dispatch(6, 9, 0);
	assert.equal(pattern.steps[22].cut, null);
	assert.equal(pattern.bars[0].length, 23);
	assert.equal(router.buildEditorShellLevels()[
		router.editorShellLevelIndex(11, 15)] >= 3, true);
});

test('an explicit first phrase cut offsets the group slice without double-triggering', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase = router.ensureSequence64Pattern('track', 0);
	group.steps[0].cut = { track: 0, slice: 3, gateLength: 1 };
	group.running = 1;
	phrase.steps[0].cut = { track: 0, slice: 12, gateLength: 1 };

	router.runSequence64StepForTarget('group', 0, group, 0, 0);
	const presses = harness.namedMessages.filter((message) =>
		message[0] === '2input' && message[2] === 1);
	assert.deepEqual(presses, [['2input', 15, 1]]);
});

test('same-group retriggers replace child phrases and manual cuts cancel the child', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase0 = router.ensureSequence64Pattern('track', 0);
	const phrase1 = router.ensureSequence64Pattern('track', 1);
	phrase0.steps[2].cut = { track: 0, slice: 7, gateLength: 1 };
	phrase1.steps[2].cut = { track: 1, slice: 8, gateLength: 1 };
	group.steps[0].cut = { track: 0, slice: 2, gateLength: 1 };
	group.steps[1].cut = { track: 1, slice: 5, gateLength: 1 };
	group.running = 1;

	router.runSequence64StepForTarget('group', 0, group, 0, 0);
	const firstOwner = router.activeSequence64PhraseForTrack(0).ownerKey;
	router.runSequence64StepForTarget('group', 0, group, 0, 1);
	assert.equal(router.activeSequence64PhraseForTrack(0), null);
	assert.notEqual(router.activeSequence64PhraseForTrack(1).ownerKey, firstOwner);

	router.setKmod(1);
	router.dispatch(6, 2, 1);
	assert.equal(router.activeSequence64PhraseForTrack(1), null);
	assert.equal(router.s.channels[0].sequence64Owner, null);
});

test('track Run previews its phrase once and returns to stopped', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[0].playPos = 6;
	selectTrack(harness, 0);
	const phrase = router.s.editorWorkspace.patterns64['track:0'];
	phrase.steps[1].cut = { track: 0, slice: 10, gateLength: 1 };

	router.setCurrentSequence64Running(1);
	assert.equal(phrase.running, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 1), true);
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 0 && message[2] === 1), true);
	for (let pulse = 2; pulse <= 16; pulse++) router.advanceSequence64ClockSubstep();
	assert.equal(phrase.running, 0);
	assert.equal(router.activeSequence64PhraseForTrack(0), null);
});

test('clearing a track phrase cancels its group-launched runtime without stopping group audio', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase = router.ensureSequence64Pattern('track', 0);
	group.steps[0].cut = { track: 0, slice: 4, gateLength: 1 };
	group.running = 1;
	phrase.steps[0].locks.reverse = { value: 1, behavior: 'set' };
	router.runSequence64StepForTarget('group', 0, group, 0, 0);
	assert.equal(router.s.tracks[0].reverse, 1);

	selectTrack(harness, 0);
	harness.clearLog();
	router.clearCurrentSequence64Pattern();
	assert.equal(router.activeSequence64PhraseForTrack(0), null);
	assert.equal(router.s.tracks[0].reverse, 0);
	assert.equal(phrase.steps[0].locks.reverse, undefined);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);
	assert.equal(router.s.channels[0].sequence64Owner, 'group:0');
});

test('row 14 column 4 is a deliberate Pattern Stop control', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[0].cut = { track: 0, slice: 4, gateLength: 1 };
	router.setCurrentSequence64Running(1);
	router.runSequence64StepForTarget('group', 0, pattern, 0, 0);
	assert.equal(pattern.running, 1);
	assert.equal(router.s.channels[0].sequence64Owner, 'group:0');

	harness.clearLog();
	router.dispatch(3, 13, 1);
	assert.equal(pattern.running, 0);
	assert.equal(router.s.channels[0].sequence64Owner, null);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), true);
	assert.equal(router.buildEditorShellLevels()[
		router.editorShellLevelIndex(3, 13)] >= 3, true);
});

test('bottom-row jump switches group to current or last track and track back to its group', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[2].channel = 1;
	router.s.tracks[4].channel = 1;
	router.s.channels[0].lastActiveTrack = 2;
	router.s.channels[0].activeTrack = 4;
	selectGroup(harness, 0);

	router.dispatch(13, 15, 1);
	assert.equal(router.s.editorWorkspace.targetType, 'track');
	assert.equal(router.s.editorWorkspace.targetId, 4);

	// The jump is available from Setup too and leaves playback state untouched.
	router.dispatch(1, 15, 1);
	router.dispatch(13, 15, 1);
	assert.equal(router.s.editorWorkspace.targetType, 'group');
	assert.equal(router.s.editorWorkspace.targetId, 0);
	assert.equal(router.buildEditorShellLevels()[
		router.editorShellLevelIndex(13, 15)] >= 3, true);
});

test('group lock editor exposes assigned tracks and stores or clears a per-step Track choice', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[2].channel = 1;
	router.s.tracks[4].channel = 1;
	router.s.tracks[1].channel = 2;
	router.s.channels[0].activeTrack = 2;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	router.sequence64HeldStep = 0;
	router.sequence64EditParameter = 'track';

	let levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(12, 12)], 15);
	assert.equal(levels[router.editorShellLevelIndex(2, 13)], 15);
	assert.equal(levels[router.editorShellLevelIndex(4, 13)] >= 2, true);
	assert.equal(levels[router.editorShellLevelIndex(1, 13)], 0);

	router.dispatch(1, 13, 1);
	assert.equal(pattern.steps[0].cut, null);
	router.dispatch(4, 13, 1);
	assert.equal(pattern.steps[0].cut.track, 4);
	assert.equal(router.sequence64TargetTrackIndex('group', 0, pattern.steps[0]), 4);

	router.dispatch(15, 14, 1);
	assert.equal(pattern.steps[0].cut.track, -1);
	assert.equal(router.sequence64TargetTrackIndex('group', 0, pattern.steps[0]), 2);

	selectTrack(harness, 2);
	router.sequence64HeldStep = 0;
	router.sequence64EditParameter = 'slice';
	assert.equal(router.sequence64VisibleParameters().length, 9);
	assert.equal(Array.from(router.sequence64VisibleParameters()).includes('track'), false);
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(12, 12)] >= 3, true);
	router.dispatch(12, 12, 1);
	assert.equal(router.sequence64EditParameter, 'condition');
});

test('conditional trigger editor exposes Every 2–9 and Skip 2–9 without moving Track', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[0].cut = { track: 0, slice: 3, gateLength: 1 };
	router.sequence64HeldStep = 0;

	let levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(12, 12)] >= 3, true);
	assert.equal(levels[router.editorShellLevelIndex(13, 12)] >= 3, true);
	router.dispatch(13, 12, 1);
	assert.equal(router.sequence64EditParameter, 'condition');

	router.dispatch(0, 13, 1);
	assert.equal(pattern.steps[0].condition, 2);
	assert.equal(router.sequence64LockValueColumn('condition', pattern.steps[0]), 0);
	router.dispatch(7, 13, 1);
	assert.equal(pattern.steps[0].condition, 9);
	router.dispatch(8, 13, 1);
	assert.equal(pattern.steps[0].condition, -2);
	router.dispatch(15, 13, 1);
	assert.equal(pattern.steps[0].condition, -9);
	assert.equal(router.sequence64LockValueColumn('condition', pattern.steps[0]), 15);
	router.dispatch(15, 14, 1);
	assert.equal(pattern.steps[0].condition, 0);

	selectTrack(harness, 0);
	router.sequence64HeldStep = 0;
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(12, 12)] >= 3, true);
	assert.equal(levels[router.editorShellLevelIndex(13, 12)], 0);
});

test('Every and Skip conditions gate group cuts before probability, locks, and audio', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const pattern = router.ensureSequence64Pattern('group', 0);
	const step = pattern.steps[0];
	step.cut = { track: 0, slice: 6, gateLength: 1 };
	step.locks.reverse = { value: 1, behavior: 'set' };
	pattern.running = 1;

	for (let every = 2; every <= 9; every++) {
		step.condition = every;
		assert.equal(router.sequence64ConditionPass(step, 1), false);
		assert.equal(router.sequence64ConditionPass(step, every), true);
		step.condition = -every;
		assert.equal(router.sequence64ConditionPass(step, 1), true);
		assert.equal(router.sequence64ConditionPass(step, every), false);
	}

	step.condition = 2;
	harness.clearLog();
	assert.equal(router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 0), 0);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2[box]rev'), false);
	assert.equal(router.s.tracks[0].reverse, 0);

	harness.clearLog();
	assert.equal(router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 64), 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 1), true);
	assert.equal(router.s.tracks[0].reverse, 1);

	step.condition = -2;
	harness.clearLog();
	assert.equal(router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 0), 1);
	harness.clearLog();
	assert.equal(router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 64), 0);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);
});

test('group-launched phrases inherit the parent occurrence for their conditional steps', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const phrase = router.ensureSequence64Pattern('track', 0);
	phrase.steps[1].cut = { track: 0, slice: 4, gateLength: 1 };
	phrase.steps[1].condition = 2;

	router.launchSequence64TrackPhrase(0, 3, 'group:0', 'group:0', false, 1);
	harness.clearLog();
	assert.equal(router.runSequence64PhraseStep(router.activeSequence64PhraseForTrack(0), 1), 0);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);

	router.launchSequence64TrackPhrase(0, 3, 'group:0', 'group:0', false, 2);
	harness.clearLog();
	assert.equal(router.runSequence64PhraseStep(router.activeSequence64PhraseForTrack(0), 1), 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 7 && message[2] === 1), true);
});

test('conditional and probability decisions flash four distinct semantic playhead colors', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	const step = pattern.steps[0];
	step.cut = { track: 0, slice: 6, gateLength: 1 };
	pattern.running = 1;
	pattern.phaseOrigin = 0;
	router.sequence64ClockPosition = 0;
	const playheadColor = () => Array.from(router.buildEditorShellColors(
		router.buildEditorShellLevels())[router.editorShellLevelIndex(0, 8)]);

	step.condition = 2;
	router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 0);
	assert.deepEqual(playheadColor(), [255, 45, 55]);
	router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 64);
	assert.deepEqual(playheadColor(), [255, 135, 25]);

	step.condition = 0;
	step.probability = 8;
	router.editorProbabilityPass = () => false;
	router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 0);
	assert.deepEqual(playheadColor(), [185, 70, 255]);
	router.editorProbabilityPass = () => true;
	router.runSequence64StepForTarget('group', 0, pattern, 0, 0, 0);
	assert.deepEqual(playheadColor(), [255, 225, 35]);

	const snapshot = router.hudPatternSnapshotObject('group', 0, pattern);
	assert.equal(snapshot.decisionOutcome, 'probabilityPlay');
});

test('a conditional first phrase step can skip or play its merged group hit', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	const phrase = router.ensureSequence64Pattern('track', 0);
	phrase.steps[0].condition = 2;

	harness.clearLog();
	router.launchSequence64TrackPhrase(0, 3, 'group:0', 'group:0', false, 1);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);

	harness.clearLog();
	router.launchSequence64TrackPhrase(0, 3, 'group:0', 'group:0', false, 2);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), true);
});

test('an explicit group track waits safely after reassignment while inherited cuts migrate with defaultTrack', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 1;
	const pattern = router.ensureSequence64Pattern('group', 0);
	pattern.steps[0].cut = { track: 0, slice: 3, gateLength: 1 };
	pattern.steps[1].cut = { track: -1, slice: 7, gateLength: 1 };
	pattern.running = 1;

	router.s.tracks[0].channel = 2;
	harness.clearLog();
	router.runSequence64StepForTarget('group', 0, pattern, 0, 0);
	assert.equal(pattern.steps[0].cut.track, 0);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2input'), false);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_waiting_for_track'), true);

	harness.clearLog();
	router.runSequence64StepForTarget('group', 0, pattern, 0, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '3input' && message[1] === 7 && message[2] === 1), true);
	assert.equal(pattern.defaultTrack, 1);
});

test('Sequence64 audio Stop follows the latest owner and manual cuts clear ownership', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 1;
	const older = router.ensureSequence64Pattern('group', 0);
	const newer = router.ensureSequence64Pattern('track', 1);
	older.steps[0].cut = { track: 0, slice: 2, gateLength: 1 };
	newer.steps[0].cut = { track: 1, slice: 6, gateLength: 1 };
	older.running = 1;
	newer.running = 1;
	router.runSequence64StepForTarget('group', 0, older, 0, 0);
	router.runSequence64StepForTarget('track', 1, newer, 0, 0);
	assert.equal(router.s.channels[0].sequence64Owner, 'track:1');

	harness.clearLog();
	router.stopSequence64Target('group', 0, 'test');
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);
	router.stopSequence64Target('track', 1, 'test');
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), true);

	newer.running = 1;
	router.runSequence64StepForTarget('track', 1, newer, 0, 0);
	router.sequence64PlaybackPingGuard = null;
	router.chRowPos(3, 8);
	assert.equal(router.s.channels[0].sequence64Owner, 'track:1');
	router.triggerEditorTrack(1, 8, null);
	assert.equal(router.s.channels[0].sequence64Owner, null);
	harness.clearLog();
	router.stopSequence64Target('track', 1, 'test_manual_override');
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);

	newer.running = 1;
	router.runSequence64StepForTarget('track', 1, newer, 0, 0);
	router.setKmod(1);
	router.dispatch(4, 1, 1);
	assert.equal(router.s.channels[0].sequence64Owner, null);
	harness.clearLog();
	router.stopSequence64Target('track', 1, 'test_manual_override');
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);
});

test('lock ownership stacks restore the preceding writer, then the original baseline', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 1;
	router.sequence64WriteOwnedProperty('track', 0, 'volume', 6, 0, 0, 0);
	router.sequence64WriteOwnedProperty('track', 1, 'volume', 11, 0, 1, 0);
	assert.equal(router.s.editorWorkspace.channelOutputs64['channel:0:volume'], 11);

	harness.clearLog();
	router.stopSequence64Target('track', 1, 'test_stack');
	assert.equal(router.s.editorWorkspace.channelOutputs64['channel:0:volume'], 6);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 0.4), true);
	router.stopSequence64Target('track', 0, 'test_stack');
	assert.equal(router.s.editorWorkspace.channelOutputs64['channel:0:volume'], 15);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);

	router.sequence64WriteOwnedProperty('track', 0, 'reverse', 1, 0, 0, 0);
	assert.equal(router.s.tracks[0].reverse, 1);
	router.setEditorReverse(0, 0, false);
	router.stopSequence64Target('track', 0, 'test_manual_baseline');
	assert.equal(router.s.tracks[0].reverse, 0);
	assert.equal(router.s.editorWorkspace.propertyStacks64['track:0:reverse'], undefined);
});

test('structural edits preserve Run, audio ownership, programmed data, and a valid playhead', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[10].cut = { track: 0, slice: 4, gateLength: 1 };
	pattern.steps[10].locks.volume = { value: 7, behavior: 'set' };
	router.sequence64ClockPosition = 10;
	pattern.running = 1;
	router.runSequence64StepForTarget('track', 0, pattern, 0, 10);
	harness.clearLog();

	router.addSequence64Bar();
	assert.equal(pattern.running, 1);
	assert.equal(router.currentSequence64BarIndex(), 0);
	assert.equal(router.currentSequence64StepIndex(), 10);
	assert.equal(router.s.channels[0].sequence64Owner, 'track:0');
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);
	assert.equal(pattern.steps[10].cut.slice, 4);
	assert.equal(pattern.steps[10].locks.volume.value, 7);

	router.selectSequence64Bar(0);
	router.setCurrentSequence64BarLength(16);
	assert.equal(pattern.running, 1);
	assert.equal(router.currentSequence64StepIndex(), 10);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);
});

test('shortening past the playhead and Restart return a running pattern to step 1 immediately', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[0].cut = { track: 0, slice: 3, gateLength: 1 };
	router.sequence64ClockPosition = 40;
	pattern.running = 1;
	pattern.lastSequencedFlat = 40;
	harness.clearLog();

	router.setCurrentSequence64BarLength(16);
	assert.equal(pattern.running, 1);
	assert.equal(router.currentSequence64BarIndex(), 0);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);

	router.sequence64ClockPosition = 49;
	harness.clearLog();
	router.dispatch(2, 13, 1);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), true);
	router.advanceSequence64ClockSubstep();
	assert.equal(router.currentSequence64StepIndex(), 1);
});

test('Restart starts a stopped phrase at step 1 and does not move other pattern phases', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 2;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	const other = router.ensureSequence64Pattern('track', 1);
	pattern.steps[0].cut = { track: 0, slice: 5, gateLength: 1 };
	router.sequence64ClockPosition = 27;
	other.phaseOrigin = 7;
	const otherBefore = router.sequence64PlaybackLocation(other).flat;

	router.dispatch(2, 13, 1);
	assert.equal(pattern.running, 1);
	assert.equal(pattern.restartArmed, 0);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.equal(router.sequence64PlaybackLocation(other).flat, otherBefore);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 5 && message[2] === 1), true);
});

test('Restart starts a stopped group at step 1 and latches Run', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[0].cut = { track: 0, slice: 9, gateLength: 1 };
	router.sequence64ClockPosition = 31;
	harness.clearLog();

	router.dispatch(2, 13, 1);

	assert.equal(pattern.running, 1);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 9 && message[2] === 1), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'editor_run' &&
		message[2] === 'group' && message[3] === 1 && message[4] === 1), true);
});

test('shortening the pattern past its playing bar restarts without stopping Run', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[0].cut = { track: 0, slice: 8, gateLength: 1 };
	router.setSequence64BarCount(3);
	router.sequence64ClockPosition = 150;
	pattern.phaseOrigin = 0;
	pattern.running = 1;
	assert.equal(router.currentSequence64BarIndex(), 2);
	harness.clearLog();

	router.setSequence64BarCount(1);
	assert.equal(pattern.running, 1);
	assert.equal(router.currentSequence64BarIndex(), 0);
	assert.equal(router.currentSequence64StepIndex(), 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 8 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);
	assert.equal(pattern.parkedBars.length, 2);
});

test('sequence64 autowatch reload closes the editor and safely restores its active output layer', () => {
	const firstHarness = createSequence64Harness();
	const router = firstHarness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(firstHarness, 0);
	router.s.editorWorkspace.parameterValues64['track:0'].volume = 5;
	router.s.editorWorkspace.parameterValues64['track:0'].volumeOutput = 5;
	router.s.editorWorkspace.parameterValues64['track:0'].filterOutput = 7;
	router.sequence64WriteOwnedProperty('track', 0, 'reverse', 1, 0, 0, 0);
	router.triggerEditorTrack(0, 3, 'track:0');

	const reloadedHarness = createSequence64Harness(firstHarness.globalStores);
	assert.equal(reloadedHarness.context.s.editorWorkspace.active, false);
	assert.equal(reloadedHarness.context.s.editorWorkspace.targetType, 'none');
	assert.equal(reloadedHarness.context.s.channels[0].sequence64Owner, null);
	assert.equal(reloadedHarness.context.s.channels[0].activeTrack, -1);
	assert.equal(reloadedHarness.context.s.tracks[0].reverse, 0);
	assert.equal(Object.keys(reloadedHarness.context.s.editorWorkspace.propertyStacks64).length, 0);
	assert.equal(reloadedHarness.context.s.editorWorkspace.parameterValues64['track:0'].volume, 5);
	assert.equal(reloadedHarness.context.s.editorWorkspace.parameterValues64['track:0'].volumeOutput, 15);
	assert.equal(reloadedHarness.namedMessages.some((message) =>
		message[0] === '1[pl]stop' && message[1] === 'int' && message[2] === 1), true);
	assert.equal(reloadedHarness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1 && message[2] === 8), true);
	assert.equal(reloadedHarness.namedMessages.some((message) =>
		message[0] === '1[filterfx]level' && message[1] === 1 && message[2] === 8), true);
});

test('HUD snapshot, target navigation, and transport reuse Sequence64 state', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.hudSnapshot();
	assert.equal(harness.hudMessages.some((message) => message[0] === 'mode'), true);
	assert.equal(harness.hudMessages.filter((message) => message[0] === 'track').length, 16);
	assert.equal(harness.hudMessages.filter((message) => message[0] === 'channel').length, 8);

	router.hudTarget('group', 2);
	assert.equal(router.s.editorWorkspace.targetType, 'group');
	assert.equal(router.s.editorWorkspace.targetId, 2);
	router.hudTransport('run');
	assert.equal(router.currentSequence64Pattern().running, 1);
	router.hudBar(0);
	router.hudTransport('stop');
	assert.equal(router.currentSequence64Pattern().running, 0);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'pattern_snapshot' && /\"targetId\":2/.test(message[1])), true);
});

test('HUD color lab edits and resets runtime roles without changing the protocol layer', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	const original = Array.from(router.SEQUENCE64_COLORS.trigger);
	router.hudSnapshot();
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'color_role' && message[1] === 'rta.trigger'), true);
	harness.clearLog();

	assert.equal(router.hudColorRole('rta.trigger', 12, 34, 56), true);
	assert.deepEqual(Array.from(router.SEQUENCE64_COLORS.trigger), [12, 34, 56]);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'color_role' && message[1] === 'rta.trigger' &&
		message[3] === 12 && message[5] === 56), true);
	assert.equal(Array.from(router.pageColorQueue).some((message) =>
		message[0] === 'colormap'), true);

	assert.equal(router.hudColorReset('rta.trigger'), true);
	assert.deepEqual(Array.from(router.SEQUENCE64_COLORS.trigger), original);
});

test('physical sample browser assigns samples to the selected track on the first press', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.sampleBrowserReset(3);
	router.sampleBrowserColor(0, 240, 50, 30);
	router.sampleBrowserColor(1, 230, 60, 35);
	router.sampleBrowserColor(2, 30, 170, 235);
	router.sampleBrowserAssignment(2, 1);
	harness.clearLog();

	assert.equal(router.sampleBrowserOpen(2, -1), true);
	assert.equal(router.sampleBrowserState.active, true);
	assert.equal(router.sampleBrowserState.selectedSample, -1);
	const openingFrame = harness.outlets.find((message) =>
		message[0] === 1 && message[1] === 'replaceframe');
	assert.ok(openingFrame);
	assert.equal(openingFrame[4 + 2], 15);
	assert.equal(openingFrame[4 + 1], 6);
	assert.equal(openingFrame[4 + 16], 4);
	assert.equal(openingFrame[4 + 16 + 1], 10);
	const palette = router.buildSampleBrowserPalette();
	assert.deepEqual(Array.from(palette[16]), [240, 50, 30]);
	assert.deepEqual(Array.from(palette[17]), [230, 60, 35]);

	harness.clearLog();
	router.playbackDispatching = true;
	router.dispatch(0, 1, 1);
	router.playbackDispatching = false;
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'assign'), false);

	router.dispatch(0, 1, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'assign' &&
		message[2] === 2 && message[3] === 0), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'preview'), false);
	assert.equal(router.sampleBrowserState.selectedSample, 0);
	assert.equal(router.sampleBrowserState.assignments[2], 0);

	harness.clearLog();
	router.dispatch(2, 1, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'assign' &&
		message[2] === 2 && message[3] === 2), true);
	assert.equal(router.sampleBrowserState.selectedSample, 2);
	assert.equal(router.sampleBrowserState.assignments[2], 2);

	harness.clearLog();
	router.dispatch(4, 0, 1);
	router.dispatch(4, 0, 0);
	assert.equal(router.sampleBrowserState.selectedTrack, 4);
	router.dispatch(4, 0, 1);
	assert.equal(router.sampleBrowserExitHoldTask.running, true);
	router.sampleBrowserExitHoldTask.callback.call(router.sampleBrowserExitHoldTask.owner);
	assert.equal(router.sampleBrowserState.active, false);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'sample_browser' && message[1] === 0), true);
});

test('sample browser pages 240 entries while preserving lower-half editor drawing and input', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.sampleBrowserReset(240);
	for (let sample = 0; sample < 240; sample++) {
		router.sampleBrowserColor(sample, sample % 255, 80, 180);
	}
	harness.clearLog();

	router.sampleBrowserOpen(0, 110);
	assert.equal(router.sampleBrowserState.page, 1);
	const openingFrame = harness.outlets.find((message) =>
		message[0] === 1 && message[1] === 'replaceframe');
	assert.ok(openingFrame);
	// Sample 110 is page-2 slot 14: logical row 2, column 15.
	assert.equal(openingFrame[4 + 16 + 14], 15);
	const editorLevels = router.buildEditorShellLevels();
	assert.equal(openingFrame[4 + 8 * 16],
		editorLevels[router.editorShellLevelIndex(0, 8)]);
	assert.equal(editorLevels[router.editorShellLevelIndex(12, 15)], 15);

	// Browser callbacks cannot paint through its top-half ownership.
	harness.clearLog();
	router.led(5, 2, 15);
	router.kfping(5, 2, 15, 8);
	assert.deepEqual(harness.outlets, []);

	// The same modal overlay deliberately yields rows 9–16 to ṛta.
	router.dispatch(3, 8, 1);
	router.dispatch(3, 8, 0);
	assert.ok(router.s.editorWorkspace.patterns64['track:0'].steps[3].cut);

	// Footer navigation changes the 96-sample page without touching the editor.
	router.dispatch(0, 7, 1);
	assert.equal(router.sampleBrowserState.page, 0);
	router.dispatch(6, 7, 1);
	assert.equal(router.sampleBrowserState.page, 2);

	// Physical row 16, column 13 is the persistent editor shortcut/toggle.
	router.dispatch(12, 15, 1);
	assert.equal(router.sampleBrowserState.active, false);
	harness.clearLog();
	router.dispatch(12, 15, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'browserOpen' &&
		message[2] === 0 && message[3] === -1), true);
});

test('mode changes close the sample-browser overlay and restore the requested page', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.sampleBrowserReset(1);
	router.sampleBrowserOpen(0, 0);
	harness.clearLog();

	router.setKmod(1);
	assert.equal(router.sampleBrowserState.active, false);
	assert.equal(router.s.kmod, 1);
	assert.equal(harness.outlets.filter((message) =>
		message[0] === 1 && message[1] === 'replaceframe').length, 1);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'sample_browser' && message[1] === 0), true);
});
