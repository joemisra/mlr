const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const ROUTER_PATH = path.join(__dirname, '..', 'grid_router.js');
const ROUTER_SOURCE = fs.readFileSync(ROUTER_PATH, 'utf8');

function createHarness(sharedGlobalStores) {
	const outlets = [];
	const namedMessages = [];
	const posts = [];
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
	}
	Task.prototype.schedule = function () {};
	Task.prototype.cancel = function () { this.running = false; };
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

	return {
		context,
		globalStores,
		namedMessages,
		outlets,
		posts,
		clearLog() {
			namedMessages.length = 0;
			outlets.length = 0;
			posts.length = 0;
		}
	};
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

test('optional brightness colors accompany diffs without replacing monochrome levels', () => {
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
