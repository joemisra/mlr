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
	const posts = [];
	const tasks = [];
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

	const context = vm.createContext({
		Global,
		Task,
		arrayfromargs(args) {
			return Array.prototype.slice.call(args);
		},
		inlet: 0,
		messagename: '',
		messnamed(...args) {
			namedMessages.push(args);
		},
		outlet(...args) {
			outlets.push(args);
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
		outlets,
		posts,
		tasks,
		clearLog() {
			namedMessages.length = 0;
			outlets.length = 0;
			posts.length = 0;
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
		message[0] === 1 && message[1] === 'setcell' &&
		message[2] === x && message[3] === y && message[4] === level);
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
		['1[ch]timestretch', 1],
		['2[box]rev', 1],
		['9[box]rndOff', 1]
	]);
	assert.equal(router.s.channels[0].timestretch, 1);
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.equal(router.s.tracks[7].randomOffset, 1);
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
		['1[ch]timestretch', 1],
		['2[box]rev', 1]
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
	assert.deepEqual(audioMessages(harness), [['9[box]rndOff', 1]]);
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
		message[0] === '2chn[box]' && message[1] === 3), true);
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
	assert.equal(harness.namedMessages.some((message) => message[0] === '2[box]rev' && message[1] === 1), true);
	assert.equal(harness.namedMessages.some((message) => message[0] === '2[box]rndOff' && message[1] === 1), true);
	assert.equal(harness.namedMessages.some((message) => message[0] === '3[ch]timestretch' && message[1] === 1), true);
	assert.equal(harness.namedMessages.some((message) => message[0] === '3[box]mute' && message[1] === 1), true);
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
		message[0] === '2[box]rev' && message[1] === 1), true);

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

	assert.deepEqual(colorAt(0, 12), [0, 210, 255]);
	assert.deepEqual(colorAt(1, 12), [245, 205, 30]);
	assert.deepEqual(colorAt(2, 12), [50, 225, 100]);
	assert.deepEqual(colorAt(8, 13), [50, 225, 100]);
	assert.deepEqual(colorAt(2, 14), [255, 125, 25]);
	assert.deepEqual(colorAt(4, 14), [45, 230, 105]);

	router.sequence64HeldStep = -1;
	router.s.editorWorkspace.view64 = 'setup';
	levels = router.buildEditorShellLevels();
	colors = router.buildEditorShellColors(levels);
	colorAt = (x, y) => Array.from(colors[router.editorShellLevelIndex(x, y)]);
	assert.deepEqual(colorAt(0, 8), [255, 65, 55]);
	assert.deepEqual(colorAt(7, 8), [235, 55, 190]);
	assert.deepEqual(colorAt(8, 9), [50, 225, 100]);
	assert.deepEqual(colorAt(3, 10), [85, 125, 255]);
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
	harness.clearLog();
	router.dispatch(1, 12, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 5 && message[3] === 13), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'setcell' &&
		message[2] === 5 && message[3] === 13), false);
	assert.equal(harness.outlets.some((message) => message[1] === 'level8cell'), false);
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

	const queuedStepColors = Array.from(router.pageColorQueue).filter((command) =>
		command[0] === 'colorcell' && command[1] === 0 && command[2] === 8);
	assert.deepEqual(Array.from(queuedStepColors.at(-1)), ['colorcell', 0, 8, 0, 210, 255]);
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

test('sequence64 target creates a 64-step two-view workspace without disturbing legacy data', () => {
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
	assert.equal(pattern.length, 64);
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
	selectTrack(harness, 2);
	harness.clearLog();

	router.dispatch(4, 10, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:2'].steps[36].cut, null);
	router.dispatch(4, 10, 0);

	const cut = router.s.editorWorkspace.patterns64['track:2'].steps[36].cut;
	assert.equal(cut.track, 2);
	assert.equal(cut.slice, 4);
	assert.equal(cut.gateLength, 1);
	assert.equal(hasLed(harness, 4, 10, 7), true);
});

test('holding a step edits locks, predefined shapes, and trigger gate length without toggling it', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);

	// Create step 6, then hold it while editing volume and its shape.
	router.dispatch(5, 8, 1);
	router.dispatch(5, 8, 0);
	router.dispatch(5, 8, 1);
	router.dispatch(2, 12, 1);
	router.dispatch(8, 13, 1);
	router.dispatch(2, 14, 1);
	router.dispatch(7, 12, 1);
	router.dispatch(3, 13, 1);
	router.dispatch(5, 8, 0);

	const step = router.s.editorWorkspace.patterns64['track:0'].steps[5];
	assert.equal(step.cut.slice, 5);
	assert.equal(step.cut.gateLength, 4);
	assert.equal(step.locks.volume.value, 8);
	assert.equal(step.locks.volume.behavior, 'pluck');
	assert.equal(router.sequence64HeldStep, -1);
});

test('sequence64 Run is opt-in and leaves a triggered MLR cut latched after Stop', () => {
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
	router.clockTick();
	router.clockTick();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 1 && message[2] === 1), true);

	router.dispatch(0, 13, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].running, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 0), false);
});

test('sequence64 advances four evenly spaced steps per tr_pulse', () => {
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

	router.clockTick();
	assert.equal(router.sequence64ClockPosition, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), true);
	assert.equal(router.sequence64QuarterPulseTask.scheduledDelay, 37.5);
	assert.equal(router.sequence64HalfPulseTask.scheduledDelay, 75);
	assert.equal(router.sequence64ThreeQuarterPulseTask.scheduledDelay, 112.5);

	harness.clearLog();
	router.sequence64QuarterPulse();
	assert.equal(router.sequence64ClockPosition, 2);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 7 && message[2] === 1), true);

	harness.clearLog();
	router.sequence64HalfPulse();
	assert.equal(router.sequence64ClockPosition, 3);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 11 && message[2] === 1), true);

	harness.clearLog();
	router.sequence64ThreeQuarterPulse();
	assert.equal(router.sequence64ClockPosition, 4);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 15 && message[2] === 1), true);
});

test('sequence64 catches up late scheduled subdivisions without accumulating phase error', () => {
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

	router.clockTick();
	router.sequence64QuarterPulse();
	assert.equal(router.sequence64ClockPosition, 2);

	// Simulate Max delivering the next tr_pulse before the half- and
	// three-quarter-pulse Tasks. The new pulse must account for steps 3–4
	// before beginning step 5, rather than dropping two subdivisions.
	harness.clearLog();
	router.clockTick();
	assert.equal(router.sequence64ClockPosition, 5);
	for (const slice of [3, 4, 5]) {
		assert.equal(harness.namedMessages.some((message) =>
			message[0] === '2input' && message[1] === slice && message[2] === 1), true);
	}
});

test('sequence64 maps one complete bar across the four 16-cell rows', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);

	for (let pulse = 0; pulse < 16; pulse++) {
		router.clockTick();
		router.sequence64QuarterPulse();
		router.sequence64HalfPulse();
		router.sequence64ThreeQuarterPulse();
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
	router.s.editorWorkspace.patterns64['track:0'] = {
		version: 1,
		length: 32,
		running: 0,
		legacyMigrated: 1,
		steps: savedSteps
	};

	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	assert.equal(pattern.version, 2);
	assert.equal(pattern.bars.length, 1);
	assert.equal(pattern.bars[0].length, 32);
	assert.equal(pattern.bars[0].steps[20].cut.slice, 11);
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

test('sequence64 playback crosses bar boundaries without resetting step phase', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
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

test('sequence64 parameter Set locks latch and Stop releases only active Gate shapes', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].locks.volume = { value: 6, behavior: 'set' };
	router.dispatch(0, 13, 1);
	harness.clearLog();
	router.clockTick();
	router.clockTick();

	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 0.4 && message[2] === 0), true);
	assert.equal(router.s.editorWorkspace.parameterValues64['track:0'].volume, 6);
	harness.clearLog();
	router.dispatch(0, 13, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), false);

	pattern.steps[2].locks.volume = { value: 2, behavior: 'gate' };
	pattern.steps[2].cut = { track: 0, slice: 2, gateLength: 4 };
	router.sequence64ClockPosition = 1;
	router.s.editorWorkspace.lastSequencedStep = 1;
	router.dispatch(0, 13, 1);
	harness.clearLog();
	router.clockTick();
	assert.equal(router.sequence64ActiveShapes.some((shape) => shape.behavior === 'gate'), true);
	harness.clearLog();
	router.dispatch(0, 13, 1);
	assert.equal(router.sequence64ActiveShapes.some((shape) => shape.behavior === 'gate'), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 0.4), true);
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
	router.clockTick();
	router.clockTick();
	assert.equal(router.s.tracks[0].playPos, 9);
	assert.equal(router.s.tracks[0].reverse, 1);

	harness.clearLog();
	router.dispatch(1, 14, 1);
	assert.equal(router.s.tracks[0].playPos, 4);
	assert.equal(router.s.tracks[0].reverse, 0);
	assert.equal(router.s.editorWorkspace.parameterValues64['track:0'].volume, 15);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 4 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);
});

test('one-shot shape tails continue after sequence Stop and last event replaces the same parameter voice', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].locks.volume = { value: 3, behavior: 'swell' };
	pattern.steps[2].locks.volume = { value: 11, behavior: 'pluck' };
	router.dispatch(0, 13, 1);
	router.clockTick();
	assert.equal(router.sequence64ActiveShapes.length, 1);
	router.dispatch(0, 13, 1);
	router.sequence64QuarterPulse();
	assert.equal(router.sequence64ActiveShapes.length, 1);
	assert.equal(router.sequence64ActiveShapes[0].behavior, 'swell');

	// Restart at step 2: its pluck replaces the still-running swell voice.
	router.dispatch(0, 13, 1);
	router.sequence64ClockPosition = 1;
	router.s.editorWorkspace.lastSequencedStep = 1;
	router.sequence64HalfPulse();
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
	assert.equal(pattern.length, 64);
	assert.equal(pattern.steps[12].cut.slice, 6);
});

test('live recording previews into the currently playing bar rather than the viewed bar', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
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

test('sequence64 Setup consolidates target controls and momentary lock recording writes the current step', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	const baseVolume = router.s.channels[0].volume;

	// Hold record, switch to Setup, then move volume and octave.
	router.dispatch(1, 13, 1);
	router.dispatch(1, 15, 1);
	router.dispatch(10, 9, 1);
	router.dispatch(5, 10, 1);
	const step = router.s.editorWorkspace.patterns64['track:0'].steps[0];
	assert.equal(router.s.editorWorkspace.view64, 'setup');
	assert.equal(step.locks.volume.value, 10);
	assert.equal(step.locks.volume.behavior, 'set');
	assert.equal(step.locks.octave.value, 2);
	assert.equal(router.s.channels[0].volume, baseVolume);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 10 / 15), true);
	router.dispatch(1, 13, 0);
	assert.equal(router.sequence64LockRecordHeld, false);
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

test('sequence64 autowatch reload closes the editor and safely restores its active output layer', () => {
	const firstHarness = createSequence64Harness();
	const router = firstHarness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(firstHarness, 0);
	router.s.editorWorkspace.parameterValues64['track:0'].volume = 5;
	router.s.editorWorkspace.parameterValues64['track:0'].volumeOutput = 5;
	router.s.editorWorkspace.parameterValues64['track:0'].filterOutput = 7;

	const reloadedHarness = createSequence64Harness(firstHarness.globalStores);
	assert.equal(reloadedHarness.context.s.editorWorkspace.active, false);
	assert.equal(reloadedHarness.context.s.editorWorkspace.targetType, 'none');
	assert.equal(reloadedHarness.context.s.editorWorkspace.parameterValues64['track:0'].volume, 5);
	assert.equal(reloadedHarness.context.s.editorWorkspace.parameterValues64['track:0'].volumeOutput, 15);
	assert.equal(reloadedHarness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1 && message[2] === 8), true);
	assert.equal(reloadedHarness.namedMessages.some((message) =>
		message[0] === '1[filterfx]level' && message[1] === 1 && message[2] === 8), true);
});
