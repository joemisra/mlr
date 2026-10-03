const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const ROUTER_PATH = path.join(__dirname, '..', 'grid_router.js');
const ROUTER_SOURCE = fs.readFileSync(ROUTER_PATH, 'utf8');

function createHarness(sharedGlobalStores, layoutMode = 'legacy', edition = 'rta', sourceRoot) {
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
		require(name) {
			if (sourceRoot) return require(path.join(sourceRoot, name));
			if (name === 'mlr_product.js') return { id: edition, rta: edition === 'rta' };
			if (edition === 'mlr' && /instrument|scene_model|modulation_model|sequence64_native/.test(name)) throw new Error('MLR loaded rta dependency: ' + name);
			if (name === 'sequence64_native_compile.js') return require('../sequence64_native_compile.js');
			if (name === 'modulation_model.js') return require('../modulation_model.js');
			if (name === 'scene_model.js') return require('../scene_model.js');
			if (name === 'instrument_model.js') return require('../instrument_model.js');
			if (name === 'knob_controller_model.js') return require('../knob_controller_model.js');
			if (name === 'clap_instrument_model.js') return require('../clap_instrument_model.js');
			if (name === 'tom_instrument_model.js') return require('../tom_instrument_model.js');
			if (name === 'rim_instrument_model.js') return require('../rim_instrument_model.js');
			if (name === 'bell_instrument_model.js') return require('../bell_instrument_model.js');
			if (name === 'bass_instrument_model.js') return require('../bass_instrument_model.js');
			if (name === 'hat_instrument_model.js') return require('../hat_instrument_model.js');
			if (name === 'snare_instrument_model.js') return require('../snare_instrument_model.js');
			throw new Error(`Unexpected router dependency ${name}`);
		},
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

	vm.runInContext(sourceRoot ? fs.readFileSync(path.join(sourceRoot, "grid_router.js"), "utf8") : ROUTER_SOURCE, context, { filename: ROUTER_PATH });
	const startupMessages = namedMessages.slice();
	// Keep FX/runtime restoration visible to reload tests; separate only the
	// unconditional native safety controls from later gesture assertions.
	for (let index=namedMessages.length-1;index>=0;index--)
		if (namedMessages[index][0]==='sequence64_native_control') namedMessages.splice(index,1);
	for (let index=timeline.length-1;index>=0;index--)
		if (timeline[index][0]==='messnamed'&&timeline[index][1]==='sequence64_native_control') timeline.splice(index,1);
	context.s.kmod = 2;
	context.s.edition = 256;
	context.s.gridWidth = 16;
	context.s.gridHeight = 16;
	context.resetEditorWorkspaceState(true);
	context.editorLayout(layoutMode);

	return {
		context,
		startupMessages,
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

test('knobs use all eight Drum Lab page orders, write-through baselines, and no accidental step locks', () => {
 const h=createSequence64Harness(),r=h.context;
 for(const e of r.INSTRUMENT_ENGINES){
  selectTrack(h,e.track);r.sequence64InstrumentPage=true;
  const ids=Array.from(e.pages).flatMap(p=>Array.from(p.parameters));
  for(let i=0;i<ids.length;i++){
   const id=ids[i], initial=r.instrumentSanitize(e.track,r.s.tracks[e.track].instrumentParameters)[id];
   const at=Math.round(r.instrumentToNormalized(id,initial,r.instrumentParameterRange(id))*127);
   r.knobCC(i+1,at);assert.equal(r.knobCC(i+1,127),at!==127);
   assert.equal(r.s.tracks[e.track].instrumentParameters[id],r.instrumentParameterRange(id).max);
   const w=r.s.editorWorkspace;
   assert.equal(w.sceneState.trackSlots[w.performanceTrackSlotRef].tracks[e.track].instrumentParameters[id],r.instrumentParameterRange(id).max);
   assert.equal(r.currentSequence64EditStep().locks[id],undefined);
  }
  assert.equal(r.knobCC(13,64),false);assert.equal(r.knobCC(16,64),false);
 }
 const snapshot=JSON.stringify(r.sessionRouterSnapshotObject());
 assert.equal(/knobPickup|knobRanges|knobFocusSource/.test(snapshot),false);
});
test('holding a step writes a lock without touching the baseline; release returns to sound editing', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.sequence64InstrumentPage=true;
 const baseline=r.instrumentSanitize(14,r.s.tracks[14].instrumentParameters).kickPitch;
 r.dispatch(3,8,1);
 const pickup=Math.round(r.instrumentToNormalized('kickPitch',baseline,r.kickParameterRange('kickPitch'))*127);
 r.knobCC(1,pickup);r.knobCC(1,127);
 assert.equal(r.currentSequence64Pattern().steps[3].locks.kickPitch.value,120);
 assert.equal(r.s.tracks[14].instrumentParameters.kickPitch,baseline);
 r.dispatch(3,8,0);
 assert.equal(r.currentSequence64Pattern().steps[3].cut.track,14);
 assert.equal(r.knobCC(1,126),false); // pickup rearms at the unchanged baseline
 r.knobCC(1,pickup);r.knobCC(1,0);
 assert.equal(r.s.tracks[14].instrumentParameters.kickPitch,20);
 assert.equal(r.currentSequence64Pattern().steps[3].locks.kickPitch.value,120);
});
test('focus changes, presets, external edits and out-of-grid-range sounds rearm knob pickup', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.sequence64InstrumentPage=true;
 r.knobCC(1,0);r.knobCC(1,127);
 assert.equal(r.knobCC(1,126),true);
 selectTrack(h,13);selectTrack(h,14);r.sequence64InstrumentPage=true;assert.equal(r.knobCC(1,80),false);
 r.instrumentManual(15,'kickPitch',1500);r.knobCC(1,0);assert.equal(r.knobCC(1,127),true);
 assert.equal(r.s.tracks[14].instrumentParameters.kickPitch,1500);
 assert.equal(r.knobCC(1,100),true); // widened span stays stable after pickup
 r.instrumentPresetAction(14,0,true);r.instrumentPresetAction(14,0,false);
 assert.equal(r.knobCC(1,1),false);
 r.knobSource('lab');r.knobLabFocus(0);r.knobCC(1,0);r.knobCC(1,127);
 const snare=r.instrumentSanitize(13,r.s.tracks[13].instrumentParameters).snareBodyHz;
 r.knobLabFocus(1);assert.equal(r.knobCC(1,126),false);
 assert.equal(r.s.tracks[13].instrumentParameters.snareBodyHz,snare);
});
test('Live Write records current-step locks but does not rearm at every playback step', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.sequence64InstrumentPage=true;
 const p=r.currentSequence64Pattern();p.running=1;r.setSequence64InspectorLiveWrite(true);
 r.knobCC(1,0);r.knobCC(1,127);
 const first=r.currentSequence64StepIndex();assert.equal(p.steps[first].locks.kickPitch.value,120);
 r.runSequence64StepForTarget('track',14,p,0,(first+1)%64);
 assert.equal(r.knobCC(1,100),true);
 assert.equal(p.steps[r.currentSequence64StepIndex()].locks.kickPitch.value,r.s.tracks[14].instrumentParameters.kickPitch);
 r.knobSource('lab');r.knobLabFocus(0);const step=p.steps[r.currentSequence64StepIndex()];
 const lock=step.locks.kickPitch.value;r.knobCC(1,0);r.knobCC(1,127);
 assert.equal(step.locks.kickPitch.value,lock); // lab focus is sound-only even with a grid live-write latch
});

test('a knob batch preserves pickup crossings with one synth message per changed parameter and one redraw', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.sequence64InstrumentPage=true;
 let redraws=0;const draw=r.redrawEditorShellDiff;
 r.redrawEditorShellDiff=function(...args){redraws++;return draw(...args);};
 r.syncInstrument=()=>{throw Error('knob must not resend the entire sound');};
 h.clearLog();
 const entries=Array.from({length:4},(_,i)=>({knob:i+1,first:0,last:127,bar:-1,step:-1}));
 assert.equal(r.knobBatch(r.knobRuntime.epoch,JSON.stringify(entries)),true);
 assert.equal(redraws,1);
 const params=h.namedMessages.filter(m=>m[0]==='rnbo_kick_owned_param');
 assert.equal(params.length,4);
 for(const id of r.Instruments.KICK_PAGES[0].parameters)assert.equal(r.s.tracks[14].instrumentParameters[id],r.instrumentParameterRange(id).max);
 assert.equal(h.namedMessages.filter(m=>m[0]==='mlr_knob_status').length,1);
 assert.equal(r.knobBatch(r.knobRuntime.epoch,'not JSON'),false);
 assert.equal(r.knobBatch(r.knobRuntime.epoch,JSON.stringify(Array(17).fill(entries[0]))),false);
});

test('queued knob batches cannot write after focus, held-step release or sound recall', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.sequence64InstrumentPage=true;
 const frame=JSON.stringify([{knob:1,first:0,last:127,bar:-1,step:-1}]);
 let epoch=r.knobRuntime.epoch;selectTrack(h,13);assert.equal(r.knobBatch(epoch,frame),false);
 selectTrack(h,14);r.sequence64InstrumentPage=true;r.dispatch(2,8,1);epoch=r.knobRuntime.epoch;r.dispatch(2,8,0);
 assert.equal(r.knobBatch(epoch,frame),false);assert.equal(r.currentSequence64Pattern().steps[2].locks.kickPitch,undefined);
 r.instrumentPresetAction(14,0,true);epoch=r.knobRuntime.epoch;r.instrumentPresetAction(14,0,false);
 assert.equal(r.knobBatch(epoch,frame),false);
});

test('batched Live Write uses the incoming MIDI step, not the later flush step', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.sequence64InstrumentPage=true;
 const p=r.currentSequence64Pattern();p.running=1;p.phaseOrigin=0;
 r.setSequence64InspectorLiveWrite(true);
 r.sequence64ClockPosition=2;r.runSequence64StepForTarget('track',14,p,0,2);
 const epoch=r.knobRuntime.epoch;
 const frame=JSON.stringify([{knob:1,first:0,last:127,bar:0,step:2}]);
 r.sequence64ClockPosition=3;r.runSequence64StepForTarget('track',14,p,0,3);
 assert.equal(r.knobBatch(epoch,frame),true);
 assert.equal(p.steps[2].locks.kickPitch.value,120);
 assert.equal(p.steps[3].locks.kickPitch,undefined);
 r.dispatch(5,8,1);
 assert.equal(r.knobRuntime.live,false); // holding takes precedence over Live Write
});

test('MLR knobs follow sample controls, hold locks without changing runtime, and rearm across pages', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,0);
 const p=r.currentSequence64Pattern();
 r.knobCC(3,127);r.knobCC(3,0);
 assert.equal(r.sequence64CurrentPropertyValue('volume',r.trackChannelIndex(0),0),0);
 assert.equal(p.steps[0].locks.volume,undefined);
 r.dispatch(3,8,1);
 r.knobCC(3,0);r.knobCC(3,127);
 assert.equal(p.steps[3].locks.volume.value,15);
 assert.equal(r.sequence64CurrentPropertyValue('volume',r.trackChannelIndex(0),0),0);
 r.knobCC(5,0);r.knobCC(5,127);
 assert.equal(p.steps[3].locks.reverse.value,1);
 assert.equal(r.s.tracks[0].reverse,0);
 r.knobCC(6,0);r.knobCC(6,127);
 assert.equal(p.steps[3].locks.transpose.value,96);
 r.knobCC(7,0);r.knobCC(7,127);
 assert.equal(p.steps[3].locks.loopDivision.value,r.TRACK_SUB_LOOP_OPTIONS.at(-1));
 r.dispatch(3,8,0);
 assert.equal(r.knobCC(3,126),false);
 selectTrack(h,14);r.sequence64InstrumentPage=false;r.sequence64InspectorContext='parameter';
 r.knobRefreshContext();const epoch=r.knobRuntime.epoch;
 r.sequence64InstrumentPage=true;
 assert.equal(r.knobBatch(epoch,JSON.stringify([{knob:3,first:0,last:127,bar:-1,step:-1}])),false);
});

test('MLR step controls use valid discrete values and group assignment stays in its group', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,0);
 r.knobCC(1,0);r.knobCC(1,127);
 const step=r.currentSequence64EditStep();assert.equal(step.locks.slice.value,15);
 r.knobCC(2,127);r.knobCC(2,0);assert.equal(step.probability,0);
 r.knobCC(8,0);r.knobCC(8,127);assert.equal(step.cut.gateLength,16);
 r.knobCC(9,0);r.knobCC(9,127);assert.equal(step.condition,-9);
 assert.equal(r.knobCC(10,127),false);
 r.s.tracks[0].channel=1;r.s.tracks[1].channel=1;
 selectGroup(h,0);r.sequence64InstrumentPage=false;
 r.knobCC(9,0);r.knobCC(9,127);
 const groupStep=r.currentSequence64EditStep();
 assert.equal(r.sequence64TrackBelongsToGroup(groupStep.cut.track,0),true);
 r.knobCC(10,0);r.knobCC(10,127);assert.equal(groupStep.condition,-9);
});

test('MLR live knob batches record the incoming step and hold takes precedence', () => {
 const h=createSequence64Harness(),r=h.context;selectTrack(h,0);
 const p=r.currentSequence64Pattern();p.running=1;p.phaseOrigin=0;
 r.setSequence64InspectorLiveWrite(true);
 r.sequence64ClockPosition=2;r.runSequence64StepForTarget('track',0,p,0,2);
 r.knobRefreshContext();const epoch=r.knobRuntime.epoch;
 r.sequence64ClockPosition=3;r.runSequence64StepForTarget('track',0,p,0,3);
 assert.equal(r.knobBatch(epoch,JSON.stringify([{knob:4,first:127,last:0,bar:0,step:2}])),true);
 assert.equal(p.steps[2].locks.filter.value,0);
 assert.equal(p.steps[3].locks.filter,undefined);
 assert.equal(r.knobCC(4,40),true);
 r.dispatch(5,8,1);assert.equal(r.knobRuntime.live,false);
 r.knobCC(4,0);r.knobCC(4,127);
 assert.equal(p.steps[5].locks.filter.value,15);
 r.dispatch(5,8,0);r.resetEditorWorkspaceState();
 assert.equal(r.knobBatch(epoch,JSON.stringify([{knob:4,first:0,last:127,bar:0,step:2}])),false);
});

function audioMessages(harness) {
	return harness.namedMessages.filter((message) =>
		message[0] !== 'togridmatrixanim' && message[0] !== 'togridmatrixio' &&
		message[0] !== 'mlr_session_dirty');
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

function selectPatternContext(harness) {
	harness.context.dispatch(14, 12, 1);
	harness.context.dispatch(14, 12, 0);
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

test('mode-2 column 10 arms and releases audio capture for the addressed track', () => {
	const harness = createHarness();
	const router = harness.context;
	harness.clearLog();
	router.dispatch(9, 0, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'toggleCaptureSource'), true);
	harness.clearLog();

	router.dispatch(9, 3, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'capturePress' &&
		message[2] === 2), true);
	assert.equal(hasLed(harness, 9, 3, 8), true);

	router.dispatch(9, 3, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'captureRelease' &&
		message[2] === 2), true);

	router.trackCaptureState(2, 'recording', 19, 0, 'capture-test');
	assert.equal(hasLed(harness, 9, 3, 15), true);
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'track_capture' && message[1] === 2 &&
		message[2] === 'recording'), true);
});

test('capture registration repairs a pre-capture persistent Global after V8 reload', () => {
	const globalStores = Object.create(null);
	createHarness(globalStores);
	delete globalStores.mlr.sessionRecordings;
	const reloaded = createHarness(globalStores);

	assert.equal(Array.isArray(reloaded.context.s.sessionRecordings), true);
	assert.doesNotThrow(() => reloaded.context.recordingRegistered(
		'capture-after-reload', 19, 'input', '/tmp/capture-after-reload.wav'));
	assert.equal(reloaded.context.s.sessionRecordings.length, 1);
	assert.equal(reloaded.context.s.sessionRecordings[0].bufferName, '19file');
});

test('a replayed recording sample reference repairs a missed capture registration', () => {
	const harness = createHarness();
	harness.context.s.sessionRecordings = [];
	harness.context.sampleBrowserReference(2, 10, 'recording',
		'capture-recovered', 1);

	assert.equal(harness.context.s.sessionRecordings.length, 1);
	assert.deepEqual(JSON.parse(JSON.stringify(
		harness.context.s.sessionRecordings[0])), {
		id: 'capture-recovered',
		source: 'capture',
		bufferIndex: 19,
		bufferName: '19file',
		temporaryPath: '/tmp/mlr-capture-recovered.wav',
		catalogSample: 1
	});
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

test('v2 page renders deliver colors and levels inside one bridge transaction', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.mechaTrellisExtensions = 2;
	router.s.autoPageColors = 1;
	harness.clearLog();

	router.renderCompletePage(1, false);

	const bridgeMessages = harness.outlets.filter((message) => message[0] === 1);
	const begin = bridgeMessages.findIndex((message) => message[1] === 'beginupdate');
	const firstColor = bridgeMessages.findIndex((message) => message[1] === 'colormap');
	const replacement = bridgeMessages.findIndex((message) => message[1] === 'replaceframe');
	const end = bridgeMessages.findIndex((message) => message[1] === 'endupdate');
	assert.equal(begin >= 0, true);
	assert.equal(begin < firstColor && firstColor < replacement && replacement < end, true);
	assert.equal(bridgeMessages.filter((message) => message[1] === 'colormap').length, 16);
	assert.equal(router.pageColorQueue.length, 0);
	assert.equal(router.pageColorQueueTask.running, false);
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
	router.diagnosticLogging(1);
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

test('playback diagnostics default to silent without suppressing native arms or explicit marks', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	let snapshots = 0;
	const snapshot = router.diagnosticTrackSnapshot;
	router.diagnosticTrackSnapshot = (...args) => { snapshots++; return snapshot(...args); };
	const before = harness.diagnosticLines.length;
	router.triggerEditorTrack(0, 3, 'group:0');
	router.chRowPos(2, 3);
	assert.equal(snapshots, 0);
	assert.equal(harness.diagnosticLines.length, before);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sequence64_audio_arm' && message[3] === 3), true);
	router.diagnosticMark('timing-stage-one');
	assert.equal(JSON.parse(harness.diagnosticLines.at(-1)).label, 'timing-stage-one');
});

test('disabled and rate-limited diagnostics skip detail factories and file writes', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.diagnosticLogging(1);
	let snapshots = 0;
	const snapshot = router.diagnosticTrackSnapshot;
	router.diagnosticTrackSnapshot = (...args) => { snapshots++; return snapshot(...args); };
	router.chRowPos(2, 3);
	assert.equal(snapshots, 1);
	router.diagnosticHighRateLast['playback_position:0'] = Infinity;
	const beforeSuppressed = harness.diagnosticLines.length;
	router.chRowPos(2, 4);
	assert.equal(snapshots, 1);
	assert.equal(harness.diagnosticLines.length, beforeSuppressed);
	assert.equal(router.s.tracks[0].playPos, 4);
	router.diagnosticLogging(0);
	const beforeDisabled = harness.diagnosticLines.length;
	router.triggerEditorTrack(0, 5);
	router.chRowPos(2, 5);
	let factories = 0;
	router.diagnosticEvent('test', () => { factories++; return {}; });
	router.diagnosticEventRateLimited('test', 'disabled', () => { factories++; return {}; });
	assert.equal(factories, 0);
	assert.equal(snapshots, 1);
	assert.equal(harness.diagnosticLines.length, beforeDisabled);
});

test('playback telemetry coalesces globally while keeping runtime playheads immediate', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.s.tracks[0].channel = 1;
	router.s.tracks[1].channel = 1;
	router.setKmod(1);
	router.resetPlaybackDisplay();
	harness.clearLog();
	let schedules = 0;
	const schedule = router.playbackDisplayTask.schedule;
	router.playbackDisplayTask.schedule = function (delay) {
		schedules++; schedule.call(this, delay);
	};
	for (let position = 0; position < 16; position++) router.chRowPos(2, position);
	router.chRowPos(3, 6);
	assert.equal(schedules, 1);
	assert.equal(router.playbackDisplayTask.scheduledDelay, 33);
	assert.equal(Object.keys(router.playbackDisplayTracks).length, 2);
	assert.equal(router.s.tracks[0].playPos, 15);
	assert.equal(router.s.tracks[1].playPos, 6);
	assert.equal(router.s.channels[0].activeTrack, 1);
	assert.equal(harness.hudMessages.length, 0);
	assert.equal(harness.outlets.length, 0);
	router.flushPlaybackDisplay();
	assert.equal(harness.hudMessages.filter((message) => message[0] === 'track').length, 2);
	assert.equal(harness.hudMessages.filter((message) => message[0] === 'channel').length, 1);
	const pings = harness.outlets.filter((message) => message[0] === 3 && message[1] === 'kf');
	assert.equal(pings.length, 1);
	assert.deepEqual(pings[0].slice(2, 4), [6, 2]);
	assert.equal(router.playbackDisplayPending, false);
	assert.equal(Object.keys(router.playbackDisplayTracks).length, 0);
	router.chRowPos(3, 7);
	assert.equal(schedules, 2);
});

test('clock pulses prepare phrase hits without normalizing validated or stopped patterns', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.s.tracks[0].channel = 1;
	const group = router.ensureSequence64Pattern('group', 0);
	const phrase = router.ensureSequence64Pattern('track', 0);
	group.steps[1].cut = { track: 0, slice: 4, gateLength: 1 };
	group.running = 1; group.phaseOrigin = 0; group.lastSequencedAbsolute = 0;
	phrase.steps[1].cut = { track: 0, slice: 3, gateLength: 1 };
	// Stopped data must not be visited by the playback clock.
	router.s.editorWorkspace.patterns64['track:15'] = { running: 0, bars: null };
	router.sequence64ClockPosition = 0;
	router.globalTransport(1);
	router.ensureSequence64Pattern = () => { throw Error('clock must not normalize validated patterns'); };
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	router.advanceSequence64ClockSubstep();
	const arms = harness.namedMessages.filter((message) => message[0] === 'sequence64_audio_arm');
	assert.deepEqual(arms.map((message) => message[3]), [4, 7]);
	assert.equal(harness.hudMessages.some((message) => message[0] === 'pattern_playhead'), false);
	assert.equal(router.playbackDisplayPending, true);
	router.flushPlaybackDisplay();
	const playheads = harness.hudMessages.filter((message) => message[0] === 'pattern_playhead');
	assert.equal(playheads.length, 1);
	assert.deepEqual(playheads[0].slice(1, 5), ['group', 0, 0, 2]);
	assert.equal(router.sequence64PlaybackDisplayReading, false);
});

test('replacement playback patterns normalize once and in-place edits stay visible', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.s.tracks[0].channel = 1;
	const old = router.ensureSequence64Pattern('group', 0);
	const replacement = JSON.parse(JSON.stringify(old));
	replacement.running = 1; replacement.phaseOrigin = 0; replacement.lastSequencedAbsolute = 0;
	replacement.bars[0].steps[1].cut = { track: 0, slice: 99, gateLength: 0 };
	replacement.bars[0].steps[1].probability = 99;
	router.s.editorWorkspace.patterns64['group:0'] = replacement;
	// Empty sample phrase is validated at the editing boundary.
	router.ensureSequence64Pattern('track', 0);
	router.globalTransport(1); router.sequence64ClockPosition = 0;
	let normalizations = 0;
	const ensure = router.ensureSequence64Pattern;
	router.ensureSequence64Pattern = (...args) => { normalizations++; return ensure(...args); };
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(normalizations, 1);
	assert.equal(replacement.bars[0].steps[1].cut.slice, 15);
	assert.equal(replacement.bars[0].steps[1].cut.gateLength, 1);
	replacement.bars[0].steps[2].cut = { track: 0, slice: 5, gateLength: 1 };
	router.advanceSequence64ClockSubstep();
	assert.equal(normalizations, 1);
	assert.deepEqual(harness.namedMessages.filter((message) =>
		message[0] === 'sequence64_audio_arm').map((message) => message[3]), [15, 5]);
});

test('playback display flush observes current focus and reset discards old telemetry', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.queuePlaybackDisplay(true);
	selectTrack(harness, 1);
	harness.clearLog();
	router.flushPlaybackDisplay();
	const playheads = harness.hudMessages.filter((message) => message[0] === 'pattern_playhead');
	assert.equal(playheads.length, 1);
	assert.deepEqual(playheads[0].slice(1, 3), ['track', 1]);
	router.chRowPos(2, 7);
	router.sessionStopAndReset();
	assert.equal(router.playbackDisplayPending, false);
	assert.equal(router.playbackDisplayTask.running, false);
	harness.clearLog();
	router.flushPlaybackDisplay();
	assert.equal(harness.hudMessages.length, 0);
	assert.equal(harness.outlets.length, 0);
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
	selectPatternContext(harness);
	const levels = router.buildEditorShellLevels();
	const colors = router.buildEditorShellColors(levels);
	const colorAt = (x, y) => Array.from(colors[router.editorShellLevelIndex(x, y)]);

	assert.deepEqual(colorAt(0, 8), [0, 0, 0]);
	assert.deepEqual(colorAt(1, 8), [0, 210, 255]);
	assert.deepEqual(colorAt(2, 8), [255, 180, 20]);
	assert.deepEqual(colorAt(3, 8), [210, 65, 255]);
	assert.deepEqual(colorAt(4, 8), [45, 230, 105]);
	assert.deepEqual(colorAt(5, 8), [70, 90, 225]);
	assert.deepEqual(colorAt(14, 13), [45, 230, 95]);
	assert.deepEqual(colorAt(15, 13), [255, 55, 45]);
	assert.deepEqual(colorAt(0, 14), [35, 235, 90]);
	assert.deepEqual(colorAt(1, 14), [255, 45, 110]);
	assert.deepEqual(colorAt(2, 14), [235, 235, 255]);
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

test('Setup stores true playback loop per Track Slot and restores it before every cut', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.dispatch(1, 15, 1); // Setup.
	router.dispatch(6, 14, 1); // Playback Loop -> one-shot.

	assert.equal(router.s.tracks[0].playbackLoop, 0);
	assert.equal(router.s.editorWorkspace.sceneState.trackSlots[
		'trackslot:0'].tracks[0].playbackLoop, 0);

	harness.clearLog();
	router.triggerEditorTrack(0, 5);
	const loopIndex = harness.timeline.findIndex((message) =>
		message[0] === 'messnamed' && message[1] === '1[mlr]pl-playback-loop' &&
		message[2] === 'loop' && message[3] === 0);
	const pressIndex = harness.timeline.findIndex((message) =>
		message[0] === 'messnamed' && message[1] === '2input' &&
		message[2] === 5 && message[3] === 1);
	assert.equal(loopIndex >= 0, true);
	assert.equal(pressIndex > loopIndex, true);

	// A different track can share that group player without inheriting one-shot.
	router.s.tracks[1].channel = 1;
	router.s.tracks[1].playbackLoop = 1;
	harness.clearLog();
	router.triggerEditorTrack(1, 2);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[mlr]pl-playback-loop' && message[1] === 'loop' &&
		message[2] === 1), true);
});

test('mode-2 view keys collapse the editor and expose lower track controls', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.renderCompletePage(2, true);
	assert.equal(hasLed(harness, 0, 15, 2), true);
	assert.equal(hasLed(harness, 1, 15, 2), true);
	assert.equal(hasLed(harness, 2, 15, 2), true);

	selectTrack(harness, 0);
	router.dispatch(0, 15, 1); // Tap the current Sequence view to collapse.
	assert.equal(router.s.editorWorkspace.collapsed, true);
	assert.equal(router.editorOwnsLedCell(13, 14), false);
	router.dispatch(13, 14, 1); // Lower-track octave-down control.
	assert.equal(router.s.tracks[13].octave, -1);
	assert.equal(router.s.editorWorkspace.active, true);

	router.dispatch(1, 15, 1); // Setup both switches view and reopens.
	assert.equal(router.s.editorWorkspace.view64, 'setup');
	assert.equal(router.s.editorWorkspace.collapsed, false);
	assert.equal(router.editorOwnsLedCell(13, 14), true);

	harness.clearLog();
	router.outputMeter(1, 15);
	assert.deepEqual(harness.outlets, []);
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
		message[4] === 153 && message[5] === 177 && message[6] === 219), true);

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
	router.dispatch(0, 14, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 2 && message[3] === 8 &&
		message[4] === 0 && message[5] === 0 && message[6] === 0), true);

	const step = router.s.editorWorkspace.patterns64['track:0'].steps[2];
	step.locks.volume = { value: 7, behavior: 'set' };
	const colors = router.buildEditorShellColors(router.buildEditorShellLevels());
	assert.deepEqual(
		Array.from(colors[router.editorShellLevelIndex(2, 8)]),
		Array.from(router.sequence64SelectionColor(router.SEQUENCE64_COLORS.lock))
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
		['colormap', 0, 8, ...Array.from(router.sequence64SelectionColor(router.SEQUENCE64_COLORS.trigger))]);
	assert.equal(queuedStepMaps.at(-1).length, 51);
});

test('Scene separates stable Roles from State and Motion modifiers', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.editorColors(1);
	router.dispatch(2, 15, 1);
	const palette = router.buildSceneColorPalette();
	const layers = router.buildSceneColorLayers();
	const colorAt = (x, y) => Array.from(palette[y * 16 + x]);

	assert.deepEqual(colorAt(0, 0), [0, 210, 255]);
	assert.deepEqual(colorAt(0, 1), [255, 65, 55]);
	assert.deepEqual(colorAt(12, 8), [235, 55, 190]);
	assert.deepEqual(colorAt(13, 1), [8, 12, 18]);
	assert.deepEqual(colorAt(0, 10), [35, 235, 90]);
	assert.deepEqual(colorAt(1, 10), [255, 75, 35]);
	assert.deepEqual(colorAt(2, 10), [235, 235, 255]);
	assert.deepEqual(colorAt(9, 9), [45, 140, 255]);
	assert.deepEqual(colorAt(9, 11), [0, 0, 0]);
	assert.deepEqual(colorAt(11, 15), [190, 85, 255]);
	assert.deepEqual(colorAt(12, 15), [8, 12, 18]);
	assert.equal(layers.states[0].op, 'half_add');
	assert.equal(layers.states[1 * 16].op, 'half_add');
	assert.equal(layers.states[9 * 16].op, 'half_add');

	const maps = Array.from(router.pageColorQueue).filter((command) =>
		command[0] === 'colormap');
	assert.equal(maps.length, 16);
	assert.equal(maps.every((command) => command.length === 51), true);

	harness.clearLog();
	router.dispatch(12, 1, 1);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'setcell' &&
		message[2] === 12 && message[3] === 1), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell'), false);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorstatecell' &&
		message[2] === 12 && message[3] === 1), true);
});

test('active Scene and running pattern buttons pulse on the shared musical beat', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.editorColors(1);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 1, 1); // Run Group 1's selected pattern.
	router.globalTransport(1);

	router.sequence64ClockPosition = 0;
	let levels = router.buildSceneLevels();
	let layers = router.buildSceneColorLayers();
	assert.equal(levels[0], 8);
	assert.equal(levels[1 * 16], 8);
	assert.equal(levels[1 * 16 + 12], 15);
	assert.equal(layers.motions[0].op, 'mul');
	assert.equal(layers.motions[1 * 16].op, 'mul');

	router.sequence64ClockPosition = 4;
	levels = router.buildSceneLevels();
	layers = router.buildSceneColorLayers();
	assert.equal(levels[0], 15);
	assert.equal(levels[1 * 16], 15);
	assert.equal(layers.motions[0], null);
	assert.equal(layers.motions[1 * 16], null);

	// Stopping the master transport leaves the patterns armed but removes the
	// playing pulse instead of freezing them in the dim phase.
	router.sequence64ClockPosition = 0;
	router.globalTransport(0);
	levels = router.buildSceneLevels();
	layers = router.buildSceneColorLayers();
	assert.equal(levels[0], 15);
	assert.equal(levels[1 * 16], 15);
	assert.equal(layers.motions[0], null);
	assert.equal(layers.motions[1 * 16], null);
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

test('sequence64 uses four rows of steps and taps select without deleting existing cuts', () => {
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
	assert.equal(cut.slice, 0);
	assert.equal(cut.gateLength, 1);
	assert.equal(hasLed(harness, 4, 10, 15), true);
	assert.equal(router.sequence64SelectedStep, 36);
	router.dispatch(4, 10, 1);
	router.dispatch(4, 10, 0);
	assert.notEqual(router.s.editorWorkspace.patterns64['group:2'].steps[36].cut, null);
});

test('persistent sequence64 length buttons require a hold and do not replace parameter values', () => {
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
	assert.equal(levels[router.editorShellLevelIndex(15, 9)], 0);
	assert.equal(levels[router.editorShellLevelIndex(0, 10)], 0);
	router.editorBrightnessColors(1);
	const colorLevels = router.buildEditorShellLevels();
	assert.equal(colorLevels[router.editorShellLevelIndex(15, 9)], 0);
	router.dispatch(0, 10, 1);
	router.dispatch(0, 10, 0);
	assert.equal(pattern.bars[0].steps[32].cut, null);
});

test('persistent inspector edits the selected step while Trigger and Delete stay explicit', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);

	// Create and select step 6. Slice is the default parameter.
	router.dispatch(5, 8, 1);
	router.dispatch(5, 8, 0);
	assert.equal(router.sequence64SelectedStep, 5);
	assert.equal(router.sequence64EditParameter, 'slice');

	router.dispatch(11, 13, 1);
	router.dispatch(11, 13, 0);
	router.dispatch(6, 12, 1);
	router.dispatch(8, 13, 1);
	router.dispatch(7, 14, 1);
	router.dispatch(11, 12, 1);
	router.dispatch(3, 13, 1);

	const step = router.s.editorWorkspace.patterns64['track:0'].steps[5];
	assert.equal(step.cut.slice, 0);
	assert.equal(step.locks.slice.value, 11);
	assert.equal(router.sequence64LockValueColumn('slice', step), 11);
	assert.equal(step.cut.gateLength, 4);
	assert.equal(step.locks.volume.value, 8);
	assert.equal(step.locks.volume.behavior, 'pluck');
	assert.equal(router.sequence64SelectedStep, 5);

	// Selecting another step does not make a second tap destructive.
	router.dispatch(6, 8, 1);
	router.dispatch(6, 8, 0);
	assert.notEqual(router.s.editorWorkspace.patterns64['track:0'].steps[6].cut, null);
	assert.equal(router.sequence64SelectedStep, 6);
	assert.equal(router.sequence64EditParameter, 'gateLength');
	router.dispatch(6, 8, 1);
	router.dispatch(6, 8, 0);
	assert.notEqual(router.s.editorWorkspace.patterns64['track:0'].steps[6].cut, null);

	// Trigger removes only the cut. Delete + step clears the complete step.
	router.dispatch(6, 12, 1);
	router.dispatch(9, 13, 1);
	router.dispatch(0, 14, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].steps[6].cut, null);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].steps[6].locks.volume.value, 9);
	router.dispatch(14, 15, 1);
	harness.clearLog();
	router.dispatch(6, 8, 1);
	router.dispatch(14, 15, 0);
	assert.equal(Object.keys(router.s.editorWorkspace.patterns64['track:0'].steps[6].locks).length, 0);
	assert.equal(router.buildEditorShellLevels()[router.editorShellLevelIndex(6, 8)], 0);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'setcell' &&
		message[2] === 6 && message[3] === 8 && message[4] === 0), true);
	assert.notEqual(step.cut, null);
});

test('Delete plus a step turns an otherwise empty cell fully off without losing its cursor', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.editorColors(1);
	router.dispatch(10, 8, 1);
	router.dispatch(10, 8, 0);

	router.dispatch(14, 15, 1);
	harness.clearLog();
	router.dispatch(10, 8, 1);
	router.dispatch(14, 15, 0);

	const step = router.s.editorWorkspace.patterns64['track:0'].steps[10];
	assert.equal(step.cut, null);
	assert.equal(Object.keys(step.locks).length, 0);
	assert.equal(router.sequence64SelectedStep, 10);
	assert.equal(router.buildEditorShellLevels()[router.editorShellLevelIndex(10, 8)], 0);
	assert.deepEqual(Array.from(router.buildEditorShellColors(
		router.buildEditorShellLevels())[router.editorShellLevelIndex(10, 8)]), [0, 0, 0]);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'setcell' &&
		message[2] === 10 && message[3] === 8 && message[4] === 0), true);
	assert.equal(harness.outlets.some((message) =>
		message[0] === 1 && message[1] === 'colorcell' &&
		message[2] === 10 && message[3] === 8 &&
		message[4] === 0 && message[5] === 0 && message[6] === 0), true);
});

test('edit cursors follow targets and Delete clears pointed values and confirmed bars', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.dispatch(5, 8, 1);
	router.dispatch(5, 8, 0);
	selectTrack(harness, 1);
	assert.equal(router.sequence64SelectedStep, 0);
	selectTrack(harness, 0);
	assert.equal(router.sequence64SelectedStep, 5);

	// Delete + value clears the selected parameter without touching the cut.
	router.dispatch(6, 12, 1);
	router.dispatch(9, 13, 1);
	const step = router.s.editorWorkspace.patterns64['track:0'].steps[5];
	assert.equal(step.locks.volume.value, 9);
	router.dispatch(14, 15, 1);
	router.dispatch(9, 13, 1);
	router.dispatch(14, 15, 0);
	assert.equal(step.locks.volume, undefined);
	assert.notEqual(step.cut, null);

	// Delete + bar retains the two-press safety confirmation.
	router.addSequence64Bar();
	selectPatternContext(harness);
	router.dispatch(14, 15, 1);
	router.dispatch(4, 15, 1);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].bars.length, 2);
	router.dispatch(4, 15, 1);
	router.dispatch(14, 15, 0);
	assert.equal(router.s.editorWorkspace.patterns64['track:0'].bars.length, 1);
});

test('Filter exposes inline modulation source and signed amount controls', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);

	// Select Filter, LFO 2, then +50% on the contextual value row.
	router.dispatch(7, 12, 1);
	router.dispatch(7, 12, 0);
	assert.equal(router.sequence64EditParameter, 'filter');
	router.dispatch(12, 14, 1);
	router.dispatch(11, 13, 1);
	const modulation = router.s.editorWorkspace.modulation;
	assert.equal(modulation.routes.length, 1);
	assert.deepEqual(JSON.parse(JSON.stringify(modulation.routes[0])), {
		scope: 'track', targetId: 0, parameterId: 'filter', sourceId: 'lfo2',
		amount: 0.5, enabled: true
	});
	assert.equal(harness.hudMessages.some((message) => message[0] === 'modulation_state'), true);
	assert.equal(harness.namedMessages.some((message) =>
		/^\d\[mod\]lfo2-amount$/.test(message[0]) && message[1] === 0.5), true);
	const levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(12, 14)], 15);
	assert.equal(levels[router.editorShellLevelIndex(11, 13)], 15);

	// Pressing the currently lit amount clears the route without touching the step lock.
	router.dispatch(11, 13, 1);
	assert.equal(modulation.routes.length, 1, 'old immutable snapshot remains unchanged');
	assert.equal(router.s.editorWorkspace.modulation.routes.length, 0);
	// Delete + source is the other explicit route-clear gesture.
	router.dispatch(11, 13, 1);
	assert.equal(router.s.editorWorkspace.modulation.routes.length, 1);
	router.dispatch(14, 15, 1);
	router.dispatch(12, 14, 1);
	router.dispatch(14, 15, 0);
	assert.equal(router.s.editorWorkspace.modulation.routes.length, 0);
	assert.equal(router.sequence64ModEditActive, false);
});

test('sequence64 shows the selected target track playback position in the Slice value lane', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	router.s.channels[0].activeTrack = 0;

	router.boxled(6, 1, 15);
	let levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(6, 13)],
		router.SEQUENCE64_TRACK_POSITION_LEVEL);

	router.boxled(6, 1, 0);
	router.boxled(9, 1, 15);
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(6, 13)],
		router.SEQUENCE64_MIN_VISIBLE_LEVEL);
	assert.equal(levels[router.editorShellLevelIndex(9, 13)],
		router.SEQUENCE64_TRACK_POSITION_LEVEL);

	router.s.channels[0].activeTrack = -1;
	levels = router.buildEditorShellLevels();
	assert.equal(levels[router.editorShellLevelIndex(9, 13)],
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

test('Slice audition is held, and Live Write drops the value at the playhead', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectTrack(harness, 0);
	router.setPlaybackBgCell(2, 1, 15);
	harness.clearLog();

	router.dispatch(6, 13, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 0), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[mlr]pl-trig-now' && message[1] === 'bang'), true);
	assert.equal(router.playbackBg[router.bgIndex(2, 1)], 0);
	assert.equal(router.playbackBg[router.bgIndex(6, 1)], 15);
	router.dispatch(6, 13, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 6 && message[2] === 0), true);
	const liveLevels = router.buildEditorShellLevels();
	assert.equal(liveLevels[router.editorShellLevelIndex(6, 13)], 15);

	router.sequence64ClockPosition = 9;
	router.dispatch(1, 14, 1);
	router.dispatch(11, 13, 1);
	router.dispatch(11, 13, 0);
	assert.equal(router.sequence64LockRecordHeld, true);
	const cut = router.s.editorWorkspace.patterns64['track:0'].steps[9].cut;
	assert.equal(cut.track, 0);
	assert.equal(cut.slice, 11);
	assert.equal(cut.gateLength, 1);
	router.dispatch(1, 14, 1);
	assert.equal(router.sequence64LockRecordHeld, false);
});

test('sequence64 leaves empty monochrome steps dark while shell controls stay visible', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	let levels = router.buildEditorShellLevels();

	assert.equal(levels[router.editorShellLevelIndex(1, 8)], 0);
	assert.equal(levels[router.editorShellLevelIndex(15, 8)], 0);
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
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 0 && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[mlr]pl-trig-now' && message[1] === 'bang'), true);

	router.dispatch(0, 14, 1);
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
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
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
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
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
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
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
	const clockOwner = router.ensureSequence64Pattern('group', 0);
	clockOwner.running = 1;
	router.globalTransport(1);

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
	selectPatternContext(harness);
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
	selectPatternContext(harness);

	// Bar 1, step 3.
	router.dispatch(2, 8, 1);
	router.dispatch(2, 8, 0);
	assert.equal(pattern.bars.length, 1);
	assert.notEqual(pattern.bars[0].steps[2].cut, null);

	// Pattern-context row 14 column 15 adds and selects bar 2.
	router.dispatch(14, 13, 1);
	assert.equal(pattern.bars.length, 2);
	assert.equal(pattern.currentBar, 1);
	assert.equal(pattern.running, 0);
	assert.equal(pattern.bars[1].steps[2].cut, null);

	router.dispatch(6, 8, 1);
	router.dispatch(6, 8, 0);
	assert.notEqual(pattern.bars[1].steps[6].cut, null);
	assert.equal(pattern.bars[0].steps[6].cut, null);

	// Persistent bar buttons begin at row 16 column 4.
	router.dispatch(3, 15, 1);
	router.dispatch(3, 15, 0);
	assert.equal(pattern.currentBar, 0);
	assert.equal(hasLed(harness, 3, 15, 15), true);
	router.dispatch(4, 15, 1);
	router.dispatch(4, 15, 0);
	assert.equal(pattern.currentBar, 1);

	// Removing a bar is deliberately a double press on row 14 column 16.
	router.dispatch(15, 13, 1);
	assert.equal(pattern.bars.length, 2);
	router.dispatch(15, 13, 1);
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
	router.dispatch(6, 15, 1);
	assert.equal(pattern.bars.length, 1);
	router.commitSequence64BarHold();
	router.dispatch(6, 15, 0);
	assert.equal(pattern.bars.length, 4);
	assert.equal(pattern.currentBar, 3);
	pattern.bars[3].steps[9].cut = { track: 0, slice: 12, gateLength: 1 };

	// Hold bar 2 to shorten. Trailing material is parked rather than deleted.
	router.dispatch(4, 15, 1);
	router.commitSequence64BarHold();
	router.dispatch(4, 15, 0);
	assert.equal(pattern.bars.length, 2);
	assert.equal(pattern.parkedBars.length, 2);
	assert.equal(pattern.currentBar, 1);

	// Holding bar 4 again restores the original trailing bars and their data.
	router.dispatch(6, 15, 1);
	router.commitSequence64BarHold();
	router.dispatch(6, 15, 0);
	assert.equal(pattern.bars.length, 4);
	assert.equal(pattern.parkedBars.length, 0);
	assert.equal(pattern.bars[3].steps[9].cut.slice, 12);

	// A short tap still navigates without changing the bar count.
	router.dispatch(3, 15, 1);
	router.dispatch(3, 15, 0);
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

test('sequence64 Stop restores an active Set step and cancels Gate shapes without erasing programming', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['group:0'];
	pattern.steps[1].locks.volume = { value: 6, behavior: 'set' };
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
	harness.clearLog();
	router.sequence64SubPulse();

	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 0.4 && message[2] === 0), true);
	assert.equal(router.s.editorWorkspace.parameterValues64['group:0'].volume, 6);
	harness.clearLog();
	router.dispatch(0, 14, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);
	assert.equal(pattern.steps[1].locks.volume.value, 6);
	assert.equal(pattern.steps[1].locks.volume.behavior, 'set');

	pattern.steps[2].locks.volume = { value: 2, behavior: 'gate' };
	pattern.steps[2].cut = { track: 0, slice: 2, gateLength: 4 };
	router.sequence64ClockPosition = 1;
	router.s.editorWorkspace.lastSequencedStep = 1;
	router.dispatch(0, 14, 1);
	harness.clearLog();
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.some((shape) => shape.behavior === 'gate'), true);
	harness.clearLog();
	router.dispatch(0, 14, 1);
	assert.equal(router.sequence64ActiveShapes.some((shape) => shape.behavior === 'gate'), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[gatefx]level' && message[1] === 1), true);
});

test('ordinary Set locks return to the prior value on the following sequencer step',()=>{
 const h=createSequence64Harness(),r=h.context;
 r.s.tracks[0].channel=1;
 const loopBaseline=r.sequence64CurrentPropertyValue('loopDivision',0,0);
 const loopLock=loopBaseline===4?6:4;
 const p=r.ensureSequence64Pattern('track',0);
 p.steps[0].cut={track:0,slice:0,gateLength:1};
 p.steps[0].locks.transpose={value:7,behavior:'set'};
 p.steps[0].locks.volume={value:6,behavior:'set'};
 p.steps[0].locks.reverse={value:1,behavior:'set'};
 p.steps[0].locks.loopDivision={value:loopLock,behavior:'set'};
 p.running=1;h.clearLog();
 r.runSequence64StepForTarget('track',0,p,0,0);
 assert.equal(r.sequence64CurrentPropertyValue('transpose',0,0),7);
 assert.equal(r.sequence64CurrentPropertyValue('volume',0,0),6);
 assert.equal(r.sequence64CurrentPropertyValue('reverse',0,0),1);
 assert.equal(r.sequence64CurrentPropertyValue('loopDivision',0,0),loopLock);
 h.clearLog();
 r.runSequence64StepForTarget('track',0,p,0,1);
 assert.equal(r.sequence64CurrentPropertyValue('transpose',0,0),0);
 assert.equal(r.sequence64CurrentPropertyValue('volume',0,0),15);
 assert.equal(r.sequence64CurrentPropertyValue('reverse',0,0),0);
 assert.equal(r.sequence64CurrentPropertyValue('loopDivision',0,0),loopBaseline);
 assert.ok(h.namedMessages.some(m=>m[0]==='1[gatefx]level'&&m[1]===1));
});

test('Restore Start State restores playback and any currently active lock frames', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	router.s.tracks[0].playPos = 4;
	selectTrack(harness, 0);
	const pattern = router.s.editorWorkspace.patterns64['track:0'];
	pattern.steps[1].cut = { track: 0, slice: 9, gateLength: 1 };
	pattern.steps[1].locks.reverse = { value: 1, behavior: 'set' };
	pattern.steps[1].locks.volume = { value: 5, behavior: 'set' };
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
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
	selectPatternContext(harness);
	router.dispatch(0, 14, 1);
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.length, 1);
	router.dispatch(0, 14, 1);
	router.sequence64SubPulse();
	assert.equal(router.sequence64ActiveShapes.length, 0);

	// Restart on step 1, then fire step 2 while running: its pluck replaces swell.
	router.sequence64ClockPosition = 0;
	router.s.editorWorkspace.lastSequencedStep = 0;
	pattern.lastSequencedFlat = 0;
	pattern.lastSequencedAbsolute = 0;
	router.dispatch(0, 14, 1);
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
	router.dispatch(1, 14, 1);
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
	router.dispatch(1, 14, 1);
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
	selectPatternContext(harness);
	router.dispatch(15, 14, 1);
	assert.notEqual(router.s.editorWorkspace.patterns64['track:0'].steps[0].cut, null);
	router.dispatch(15, 14, 1);
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
		message[0] === '5input' && message[1] === 0 && message[2] === 1), true);

	harness.clearLog();
	router.dispatch(9, 13, 1);
	router.dispatch(9, 13, 0);
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
	router.globalTransport(1);
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
	router.globalTransport(1);
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
	router.globalTransport(1);
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
	const firstPreview = router.activeSequence64PhraseForTrack(0);
	harness.clearLog();
	router.setCurrentSequence64Running(1);
	assert.notEqual(router.activeSequence64PhraseForTrack(0), firstPreview,
		'retrigger replaces the preview without an idle transport transition');
	assert.equal(phrase.running, 1);
	assert.equal(router.s.globalTransportRunning, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]stop'), false);
	harness.clearLog();
	router.advanceSequence64ClockSubstep();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 0 && message[2] === 1), true);
	for (let pulse = 2; pulse <= 16; pulse++) router.advanceSequence64ClockSubstep();
	assert.equal(phrase.running, 0);
	assert.equal(router.activeSequence64PhraseForTrack(0), null);
	assert.equal(router.s.globalTransportRunning, 0);
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
	selectPatternContext(harness);
	router.dispatch(3, 14, 1);
	assert.equal(pattern.running, 0);
	assert.equal(router.s.channels[0].sequence64Owner, null);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), true);
	assert.equal(router.buildEditorShellLevels()[
		router.editorShellLevelIndex(3, 14)] >= 3, true);
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
	router.dispatch(13, 15, 0);
	assert.equal(router.s.editorWorkspace.targetType, 'track');
	assert.equal(router.s.editorWorkspace.targetId, 4);

	// The jump is available from Setup too and leaves playback state untouched.
	router.dispatch(1, 15, 1);
	router.dispatch(13, 15, 1);
	router.dispatch(13, 15, 0);
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

test('shortening wraps the playhead while explicit Restart returns to step 1 immediately', () => {
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
	assert.equal(router.currentSequence64StepIndex(), 8);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 3 && message[2] === 1), false);
	assert.equal(harness.namedMessages.some((message) => message[0] === '1[pl]stop'), false);

	router.sequence64ClockPosition = 49;
	harness.clearLog();
	selectPatternContext(harness);
	router.dispatch(2, 14, 1);
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

	selectPatternContext(harness);
	router.dispatch(2, 14, 1);
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

	selectPatternContext(harness);
	router.dispatch(2, 14, 1);

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

test('sample browser maps folder-local cells to stable global sample indices', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.sampleBrowserReset(2, 2, 1);
	router.sampleBrowserColor(0, 240, 50, 30, 100);
	router.sampleBrowserColor(1, 30, 170, 235, 101);
	router.sampleBrowserAssignment(2, 100);
	router.sampleBrowserOpen(2, 100);

	router.dispatch(1, 1, 1);
	assert.equal(router.sampleBrowserState.selectedSample, 101);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'assign' &&
		message[2] === 2 && message[3] === 101), true);

	router.dispatch(7, 7, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'selectFolder' &&
		message[2] === 0 && message[3] === 2), true);
});

test('switching from the sample browser to Scene closes the overlay before the composite frame', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.sampleBrowserReset(1);
	router.sampleBrowserOpen(0, 0);
	harness.clearLog();

	router.dispatch(2, 15, 1);
	assert.equal(router.sampleBrowserState.active, false);
	assert.equal(router.s.editorWorkspace.view64, 'scene');
	const frames = harness.outlets.filter((message) =>
		message[0] === 1 && message[1] === 'replaceframe');
	assert.equal(frames.length, 1);
	for (let groupRow = 1; groupRow <= 8; groupRow++) {
		assert.equal(frames[0][4 + groupRow * 16] > 0, true,
			`group row ${groupRow + 1} is present in the first Scene frame`);
	}
	assert.equal(harness.hudMessages.some((message) =>
		message[0] === 'sample_browser' && message[1] === 0), true);
});

test('Scene view combines song rows with embedded steps and suppresses legacy side effects', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	harness.clearLog();

	// Bottom row: Sequence, Setup, Scene.
	router.dispatch(2, 15, 1);
	assert.equal(router.s.editorWorkspace.view64, 'scene');
	assert.equal(hasLed(harness, 0, 0, 15), true);
	assert.equal(hasLed(harness, 2, 15, 15), true);

	harness.clearLog();
	router.dispatch(1, 1, 1); // Group 1, pattern slot 2.
	assert.equal(router.s.editorWorkspace.performanceGroupPatternRefs[0],
		'group-pattern:0:1');
	assert.equal(router.s.editorWorkspace.patterns64['group:0'].running, 1);
	assert.equal(router.s.channels[0].timestretch, 0,
		'full-grid Scene ownership must suppress the old row-3 control');
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'scene_pattern' &&
		message[2] === 1 && message[3] === 'group-pattern:0:1'), true);

	// Rows 12–15 remain a directly editable 64-step grid for the touched group.
	router.dispatch(3, 11, 1);
	router.dispatch(3, 11, 0);
	assert.ok(router.s.editorWorkspace.patterns64['group:0'].steps[3].cut);
});

test('Scene view exposes explicit global Start, Stop, and Reset controls', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);

	let levels = router.buildSceneLevels();
	assert.equal(levels[10 * 16], 5);
	assert.equal(levels[10 * 16 + 1], 15);
	assert.equal(levels[10 * 16 + 2], 6);

	harness.clearLog();
	router.dispatch(0, 10, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]start' && message[1] === 'bang'), true);
	levels = router.buildSceneLevels();
	assert.equal(levels[10 * 16], 15);
	assert.equal(levels[10 * 16 + 1], 5);

	router.dispatch(2, 10, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]reset' && message[1] === 'bang'), true);
	router.dispatch(1, 10, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]stop' && message[1] === 'bang'), true);
	assert.equal(router.s.globalTransportRunning, 0);

	// Start/Stop can originate outside Scene view; the shared receives mirror
	// that state through globalTransport without emitting another bus command.
	harness.clearLog();
	assert.equal(router.globalTransport(1), 1);
	levels = router.buildSceneLevels();
	assert.equal(levels[10 * 16], 15);
	assert.equal(levels[10 * 16 + 1], 5);
	assert.deepEqual(harness.namedMessages, []);
	assert.equal(router.globalTransport(0), 0);
});

test('Sequence64 launch owns transport while global Stop preserves Run for resume', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	router.s.tracks[0].channel = 1;
	selectGroup(harness, 0);
	const pattern = router.ensureSequence64Pattern('group', 0);
	pattern.steps[1].cut = { track: 0, slice: 5, gateLength: 1 };

	harness.clearLog();
	router.setSequence64TargetRunning('group', 0, true);
	assert.equal(router.s.globalTransportRunning, 1);
	assert.equal(pattern.running, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]start' && message[1] === 'bang'), true);

	router.triggerEditorTrack(0, 3, 'group:0');
	assert.equal(router.s.channels[0].sequence64Owner, 'group:0');
	const pausedClock = router.sequence64ClockPosition;
	harness.clearLog();
	router.sceneGlobalTransport('stop');
	assert.equal(router.s.globalTransportRunning, 0);
	assert.equal(pattern.running, 1, 'global Stop is a pause, not a pattern edit');
	assert.equal(router.s.channels[0].sequence64Owner, null);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1[pl]stop'), true);
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, pausedClock);

	harness.clearLog();
	router.sceneGlobalTransport('start');
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, pausedClock + 1);
	assert.equal(pattern.running, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2input' && message[1] === 5 && message[2] === 1), true);

	harness.clearLog();
	router.stopSequence64Target('group', 0, 'last_pattern');
	assert.equal(router.s.globalTransportRunning, 0,
		'removing the final continuous pattern stops transport');
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]stop' && message[1] === 'bang'), true);
});

test('Scene pattern choices accumulate atomically and a repeated queued tap advances them', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 1, 1); // Start group 1 immediately at clock zero.
	router.sequence64ClockPosition = 5;

	router.dispatch(2, 1, 1); // Group 1, slot 3.
	router.dispatch(3, 2, 1); // Group 2, slot 4, same pending combination.
	const pending = router.s.editorWorkspace.pendingSceneLaunch;
	assert.equal(pending.type, 'patterns');
	assert.equal(pending.dueClock, 64);
	assert.equal(pending.patternRefs[0], 'group-pattern:0:2');
	assert.equal(pending.patternRefs[1], 'group-pattern:1:3');
	assert.equal(router.s.editorWorkspace.performanceGroupPatternRefs[0],
		'group-pattern:0:0');
	assert.equal(router.buildSceneLevels()[1 * 16 + 2], 15,
		'queued pattern is in the bright half of its flash at clock 5');
	router.sequence64ClockPosition = 8;
	assert.equal(router.buildSceneLevels()[1 * 16 + 2], 3,
		'queued pattern enters the dim half of its flash at clock 8');

	router.sequence64ClockPosition = 5;
	router.dispatch(2, 1, 1); // Re-tap a flashing cell: commit the combination next step.
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch.dueClock, 6);
	router.sequence64SubPulse();
	assert.equal(router.sequence64ClockPosition, 6);
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch, null);
	assert.equal(router.s.editorWorkspace.performanceGroupPatternRefs[0],
		'group-pattern:0:2');
	assert.equal(router.s.editorWorkspace.performanceGroupPatternRefs[1],
		'group-pattern:1:3');
	assert.equal(router.s.editorWorkspace.patterns64['group:0'].running, 1);
	assert.equal(router.s.editorWorkspace.patterns64['group:1'].running, 1);
});

test('tapping each live group pattern removes its pending replacement', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 1, 1); // Start Group 1 on its current slot.
	router.sequence64ClockPosition = 5;
	router.dispatch(2, 1, 1); // Queue Group 1 slot 3.
	router.dispatch(3, 2, 1); // Queue Group 2 slot 4.

	router.dispatch(0, 1, 1); // Tap Group 1's live slot to cancel its replacement.
	let pending = router.s.editorWorkspace.pendingSceneLaunch;
	assert.equal(pending.type, 'patterns');
	assert.equal(pending.patternRefs[0], undefined);
	assert.equal(pending.patternRefs[1], 'group-pattern:1:3');
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'scene_pattern_queue_cancelled' &&
		message[2] === 1 && message[3] === 1), true);

	router.dispatch(0, 2, 1); // Cancel the final queued group.
	pending = router.s.editorWorkspace.pendingSceneLaunch;
	assert.equal(pending, null);
});

test('queued scene cells flash and a second tap launches on the next step', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 1, 1); // A running pattern makes scene launches quantized.
	router.dispatch(12, 15, 1);
	router.dispatch(1, 0, 1); // Store Scene 2.
	router.dispatch(12, 15, 0);
	router.sequence64ClockPosition = 5;

	router.dispatch(0, 0, 1);
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch.dueClock, 64);
	assert.equal(router.buildSceneLevels()[0], 15);
	router.sequence64ClockPosition = 8;
	assert.equal(router.buildSceneLevels()[0], 3);

	router.sequence64ClockPosition = 5;
	router.dispatch(0, 0, 1);
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch.dueClock, 6);
	router.sequence64SubPulse();
	assert.equal(router.s.editorWorkspace.sceneState.activeSceneId, 'scene:0');
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch, null);
});

test('tapping the active scene cancels a different queued scene launch', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 1, 1); // Keep launches quantized.
	router.dispatch(12, 15, 1);
	router.dispatch(1, 0, 1); // Store Scene 2.
	router.dispatch(12, 15, 0);
	router.sequence64ClockPosition = 5;
	router.dispatch(0, 0, 1); // Queue Scene 1; captured Scene 2 is active.

	assert.equal(router.s.editorWorkspace.pendingSceneLaunch.sceneIndex, 0);
	router.dispatch(1, 0, 1); // Tap active Scene 2 to cancel it.
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch, null);
	assert.equal(router.s.editorWorkspace.sceneState.activeSceneId, 'scene:1');
	assert.equal(router.s.editorWorkspace.sceneState.selectedSceneId, 'scene:1');
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'scene_queue_cancelled' &&
		message[2] === 'scene'), true);
});

test('capturing an empty scene adopts it without restarting and Shift selects stored scenes', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.chUpdateCollEvent(2, 42, 0, 16, 1, 0, 0, 1, 0);
	router.dispatch(1, 1, 1);

	router.dispatch(1, 0, 1);   // Plain empty tap captures Scene 2.
	const state = router.s.editorWorkspace.sceneState;
	assert.equal(state.scenes.length, 2);
	assert.equal(state.scenes[1].groupPatternRefs[0], 'group-pattern:0:1');
	assert.equal(state.scenes[1].trackSlotRef, 'trackslot:1');
	assert.equal(state.trackSlots['trackslot:1'].tracks[0].buffer, 42);
	assert.equal(state.activeSceneId, 'scene:1');
	assert.equal(state.selectedSceneId, 'scene:1');
	assert.equal(harness.outlets.some((message) =>
		message[0] === 2 && message[1] === 'scene_capture' && message[2] === 2), true);

	router.dispatch(11, 15, 1); // Shift held.
	router.dispatch(0, 0, 1);
	router.dispatch(11, 15, 0);
	assert.equal(state.selectedSceneId, 'scene:0');
	assert.equal(state.activeSceneId, 'scene:1');
});

test('pattern and Run changes write through to the active Scene without Store', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(1, 0, 1); // Capture/adopt Scene 2.

	router.dispatch(1, 1, 1); // Switch Group 1 to another pattern slot.
	assert.equal([8, 15].includes(router.buildSceneLevels()[1 * 16 + 1]), true,
		'the running pattern may be in either half of its transport pulse');
	assert.equal(router.s.editorWorkspace.sceneState.scenes[1].groupPatternRefs[0],
		'group-pattern:0:1');

	router.dispatch(12, 1, 1); // Stop Group 1 and persist its launch state.
	assert.equal(router.s.editorWorkspace.sceneState.scenes[1].groupLaunch[0], 0);
	router.dispatch(12, 1, 1);
	assert.equal(router.s.editorWorkspace.sceneState.scenes[1].groupLaunch[0], 1);
});

test('empty pattern slots fork the live pattern, Shift starts blank, and touch sets edit focus', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	const source = router.s.editorWorkspace.patterns64['group:0'];
	source.bars[0].steps[0].cut = { track: -1, slice: 5, gateLength: 1 };

	router.dispatch(1, 1, 1); // Group 1 slot 2 forks slot 1 and launches it.
	const forked = router.s.editorWorkspace.sceneState.patternLibrary['group-pattern:0:1'];
	assert.notEqual(forked, source);
	assert.equal(forked.bars[0].steps[0].cut.slice, 5);
	assert.equal(router.s.editorWorkspace.targetType, 'group');
	assert.equal(router.s.editorWorkspace.targetId, 0);

	router.dispatch(11, 15, 1);
	router.dispatch(2, 1, 1); // Shift + empty Group 1 slot 3 starts blank.
	router.dispatch(11, 15, 0);
	const blank = router.s.editorWorkspace.sceneState.patternLibrary['group-pattern:0:2'];
	assert.equal(router.sequence64PatternHasContent(blank), false);
});

test('plain empty taps capture Scenes and clone independent empty Track Slots sparsely', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	const state = router.s.editorWorkspace.sceneState;

	router.dispatch(5, 0, 1); // Plain empty Scene 6 captures and becomes active.
	router.dispatch(11, 15, 1);
	router.dispatch(6, 0, 1); // Shift-select empty Scene 7.
	router.dispatch(11, 15, 0);
	router.dispatch(7, 9, 1); // Empty Track Slot 8 clones the current Slot directly.
	assert.equal(state.scenes.length, 6);
	assert.equal(state.scenes[5].id, 'scene:5');
	assert.equal(harness.outlets.filter((message) =>
		message[0] === 2 && message[1] === 'scene_empty').length, 1);
	assert.equal(state.scenes[5].trackSlotRef, 'trackslot:7');
	assert.ok(state.trackSlots['trackslot:7']);

	router.dispatch(15, 0, 1); // Capture directly into Scene 16.
	assert.equal(state.scenes.length, 16);
	assert.equal(state.scenes[1], null);
	assert.equal(state.scenes[14], null);
	assert.equal(state.scenes[15].id, 'scene:15');
	assert.equal(state.trackSlots['trackslot:1'], undefined);
	assert.ok(state.trackSlots['trackslot:15']);
	assert.equal(router.buildSceneLevels()[1], 2);
	assert.equal(router.buildSceneLevels()[15], 15);
});

test('Track Slot row switches independent slots and track edits write through immediately', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.chUpdateCollEvent(2, 17, 0, 16, 1, 0, 0, 1, 0);
	router.dispatch(1, 0, 1); // Scene 2 creates matching Track Slot 2.

	// Row 10 directly chooses Track Slot 1, independent of Scene numbering.
	router.dispatch(0, 9, 1);
	const state = router.s.editorWorkspace.sceneState;
	assert.equal(state.scenes[1].trackSlotRef, 'trackslot:0');
	router.chUpdateCollEvent(2, 33, 0, 16, 1, 0, 0, 1, 0);
	assert.equal(state.trackSlots['trackslot:0'].tracks[0].buffer, 33);
	router.sampleBrowserReference(0, 4, 'folder:1', 'drums/kick.wav', 1);
	assert.deepEqual(state.trackSlots['trackslot:0'].tracks[0].sampleRef,
		{ folderId: 'folder:1', path: 'drums/kick.wav' });

	router.dispatch(1, 9, 1);
	assert.equal(state.scenes[1].trackSlotRef, 'trackslot:1');
	assert.equal(router.s.tracks[0].buffer, 17);
	router.dispatch(2, 9, 1); // Empty Track Slot 3 clones Slot 2 and selects it.
	assert.equal(state.scenes[1].trackSlotRef, 'trackslot:2');
	assert.equal(state.trackSlots['trackslot:2'].tracks[0].buffer, 17);
	state.trackSlots['trackslot:1'].tracks[0].buffer = 99;
	assert.equal(state.trackSlots['trackslot:2'].tracks[0].buffer, 17);
});

test('capturing an empty Scene forks a Slot when its matching Slot is already in use', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.chUpdateCollEvent(2, 11, 0, 16, 1, 0, 0, 1, 0);

	// Put Scene 1 on Track Slot 3, then capture Scene 3. The old behavior made
	// both Scenes reference Slot 3 because the matching Slot already existed.
	router.dispatch(2, 9, 1);
	router.dispatch(2, 0, 1);
	const state = router.s.editorWorkspace.sceneState;
	assert.equal(state.scenes[0].trackSlotRef, 'trackslot:2');
	assert.notEqual(state.scenes[2].trackSlotRef, 'trackslot:2');
	assert.equal(state.trackSlots[state.scenes[2].trackSlotRef].tracks[0].buffer, 11);

	// Model the sample randomizer callback while Scene 3 is active. Each Scene
	// must recall its own value with no Store gesture.
	router.chUpdateCollEvent(2, 22, 0, 16, 1, 0, 0, 1, 0);
	assert.equal(state.trackSlots[state.scenes[2].trackSlotRef].tracks[0].buffer, 22);
	assert.equal(state.trackSlots['trackslot:2'].tracks[0].buffer, 11);
	router.dispatch(0, 0, 1);
	assert.equal(router.s.tracks[0].buffer, 11);
	router.dispatch(2, 0, 1);
	assert.equal(router.s.tracks[0].buffer, 22);
});

test('quantized Scene launch applies only changed tracks and preserves unchanged group phase', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(0, 1, 1); // Running group makes later launch quantized.

	router.chUpdateCollEvent(2, 11, 0, 16, 1, 0, 0, 1, 0);
	router.dispatch(1, 0, 1); // Scene 2 creates Track Slot 2 from the live state.
	router.chUpdateCollEvent(2, 22, 0, 16, 1, 0, 0, 1, 0);
	router.dispatch(0, 0, 1); // Return to Scene 1 immediately at the boundary.
	assert.equal(router.s.tracks[0].buffer, 11);
	const phaseBefore = router.s.editorWorkspace.patterns64['group:0'].phaseOrigin;
	router.sequence64ClockPosition = 5;
	harness.clearLog();

	router.dispatch(1, 0, 1);
	assert.equal(router.s.editorWorkspace.pendingSceneLaunch.dueClock, 64);
	assert.equal(router.s.tracks[0].buffer, 11);
	for (let pulse = 0; pulse < 59; pulse++) router.sequence64SubPulse();
	assert.equal(router.s.editorWorkspace.sceneState.activeSceneId, 'scene:1');
	assert.equal(router.s.tracks[0].buffer, 22);
	assert.equal(router.s.editorWorkspace.patterns64['group:0'].running, 1);
	assert.equal(router.s.editorWorkspace.patterns64['group:0'].phaseOrigin, phaseBefore);
	const firstTrackApply = harness.timeline.findIndex((message) =>
		message[0] === 'messnamed' && message[1] === '2[sample]select' &&
		message[2] === 21);
	const sceneAnnouncement = harness.timeline.findIndex((message) =>
		message[0] === 'outlet' && message[1] === 2 && message[2] === 'scene_launch');
	assert.equal(firstTrackApply >= 0, true);
	assert.equal(sceneAnnouncement > firstTrackApply, true);
	assert.equal(harness.namedMessages.filter((message) =>
		/\[sample\]select$/.test(message[0])).length, 1);
	assert.equal(harness.namedMessages.some((message) => /\[pl\]stop$/.test(message[0])), false);
});

test('same-Track-Slot Scene switches send zero track recalls', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(1, 9, 1); // Create Slot 2.
	router.dispatch(0, 9, 1); // Return Scene 1 to Slot 1.
	router.dispatch(1, 0, 1);  // Empty Scene capture starts with an independent Slot.
	router.dispatch(0, 9, 1); // Deliberately share Slot 1 through the direct row.
	const state = router.s.editorWorkspace.sceneState;
	assert.equal(state.scenes[0].trackSlotRef, 'trackslot:0');
	assert.equal(state.scenes[1].trackSlotRef, 'trackslot:0');
	harness.clearLog();
	router.dispatch(0, 0, 1);
	assert.equal(harness.namedMessages.some((message) =>
		/\[sample\]select$/.test(message[0])), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'syncTrackBuffer'), false);
});

test('scene state survives router snapshot/apply while playback remains stopped', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectGroup(harness, 0);
	router.dispatch(2, 15, 1);
	router.dispatch(1, 1, 1);
	router.dispatch(12, 15, 1);
	router.dispatch(1, 0, 1);
	router.dispatch(12, 15, 0);
	const snapshot = router.sessionRouterSnapshotObject();

	assert.equal(snapshot.sceneState.scenes.length, 2);
	assert.equal(router.sessionApply(JSON.stringify(snapshot)), true);
	assert.equal(router.s.editorWorkspace.sceneState.scenes.length, 2);
	assert.equal(router.s.editorWorkspace.sceneState.scenes[1].groupPatternRefs[0],
		'group-pattern:0:1');
	assert.equal(router.s.editorWorkspace.patterns64['group:0'].running, 0);
	assert.equal(router.s.automation.playing, false);
});

test('session snapshots use durable Track Slot values instead of transient sequencer ownership', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	selectTrack(harness, 0);
	router.dispatch(2, 15, 1);
	router.chUpdateCollEvent(2, 9, 0, 16, 1, 0, 0, 1, 0);
	assert.equal(router.s.editorWorkspace.sceneState.trackSlots[
		'trackslot:0'].tracks[0].octave, 0);

	router.setEditorOctave(0, 2, false, true); // Runtime-owned pitch frame.
	assert.equal(router.s.tracks[0].octave, 2);
	const snapshot = router.sessionRouterSnapshotObject();
	assert.equal(snapshot.tracks[0].octave, 0);
	assert.equal(snapshot.sceneState.trackSlots['trackslot:0'].tracks[0].octave, 0);
});

test('session track recall sets reverse absolutely without issuing a toggle command', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	const recalled = {
		group: 0,
		octave: 0,
		transpose: 0,
		reverse: 1,
		randomOffset: 0,
		buffer: 2,
		length: 16,
		speed: 1,
		speedMode: 0,
		loopStart: 0,
		loopEnd: 16,
		loopDivision: 8,
		loopActive: 0
	};
	harness.clearLog();
	router.sessionApplyTrack(0, recalled);
	assert.equal(router.s.tracks[0].reverse, 1);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]rev' && message[1] === 'set' && message[2] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]rev' && message[1] === 'int'), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[sample]select' && message[1] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]ch' && message[1] === 2 && message[2] === 2 &&
		message[6] === 1), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]ch' && message[1] === 'store'), false);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'syncTrackBuffer' &&
		message[2] === 0 && message[3] === 2), true);

	harness.clearLog();
	recalled.reverse = 0;
	router.sessionApplyTrack(0, recalled);
	assert.equal(router.s.tracks[0].reverse, 0);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '2[box]rev' && message[1] === 'set' && message[2] === 0), true);
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '[mlr]ch' && message[1] === 2 && message[2] === 2 &&
		message[6] === 0), true);
});

test('session recording buffers wait after player stop before replacement', () => {
	const harness = createSequence64Harness();
	const router = harness.context;
	harness.clearLog();
	router.scheduleSessionRecordingRestores([
		{ bufferIndex: 1, resolvedPath: '/session/recordings/a.wav' },
		{ bufferIndex: 2, resolvedPath: '/session/recordings/b.wav' }
	]);
	assert.equal(router.sessionRecordingRestoreTask.scheduledDelay, 75);
	assert.equal(harness.namedMessages.some((message) => /load$/.test(message[0])), false);

	router.drainSessionRecordingRestores();
	assert.equal(harness.namedMessages.some((message) =>
		message[0] === '1load' && message[1] === 'replace'), true);
	assert.equal(router.sessionRecordingRestoreTask.scheduledDelay, 35);
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

test('kick grid page edits physical locks and manual baselines without creating hits', () => {
 const h = createSequence64Harness(), r = h.context;
 selectTrack(h, 14);
 r.dispatch(15, 12, 1);
 assert.equal(r.sequence64InstrumentPage, true);
 assert.deepEqual(Array.from(r.sequence64VisibleParameters()), ['kickPitch','kickDecay','kickSweep','kickSweepDecay']);
 r.dispatch(15, 13, 1);
 let step = r.currentSequence64EditStep();
 assert.equal(step.locks.kickPitch.value, 120);
 assert.equal(step.cut, null);
 r.dispatch(3, 14, 1);
 assert.equal(step.locks.kickPitch.value, 119.5);
 r.dispatch(2, 14, 1);
 r.dispatch(0, 13, 1);
 assert.equal(r.s.tracks[14].instrumentParameters.kickPitch, 20);
 assert.equal(step.locks.kickPitch.value, 119.5);
 r.dispatch(1, 14, 1);
 assert.equal(r.sequence64InstrumentBaseEdit, false);
 r.kickManual('fmIndex', 1.25);
 const pos = r.currentSequence64PlaybackLocation(r.currentSequence64Pattern());
 assert.equal(r.currentSequence64Pattern().bars[pos.bar].steps[pos.step].locks.kickFM.value, 1.25);
 selectTrack(h, 0);
 assert.equal(r.sequence64InstrumentPage, false);
 assert.equal(r.sequence64VisibleParameters()[0], 'slice');
});

test('kick ownership restores previous writer and edited baseline; snapshots exclude effective locks', () => {
 const h = createSequence64Harness(), r = h.context;
 r.s.tracks[14].channel = 1;
 r.instrumentManual(15, 'kickPitch', 50);
 r.sequence64WriteOwnedProperty('group', 0, 'kickPitch', 70, 0, 14, 0);
 r.sequence64WriteOwnedProperty('track', 14, 'kickPitch', 90, 0, 14, 0);
 r.instrumentManual(15, 'kickPitch', 55);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch', 0, 14), 70);
 assert.equal(r.sceneTrackSnapshot(14).instrumentParameters.kickPitch, 55);
 r.releaseSequence64OwnedProperties('track:14', 0);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch', 0, 14), 70);
 r.releaseSequence64OwnedProperties('group:0', 0);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch', 0, 14), 55);
 const saved = JSON.parse(JSON.stringify(r.sceneTrackSnapshot(14)));
 r.instrumentManual(15, 'kickPitch', 30);
 r.sessionApplyTrack(14, saved);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch', 0, 14), 55);
 delete saved.instrumentParameters;
 r.sessionApplyTrack(14, saved);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch', 0, 14), 48);
});

test('kick audio arm captures the full effective sound with the hit', () => {
 const h = createSequence64Harness(), r = h.context;
 r.s.tracks[14].channel = 1;
 const p = r.ensureSequence64Pattern('track', 14);
 p.steps[0].cut = {track:14,slice:3,gateLength:1};
 p.steps[0].locks.kickPitch = {value:75,behavior:'set'};
 p.steps[0].locks.kickDecay = {value:1200,behavior:'set'};
 p.steps[0].locks.kickFM = {value:2.5,behavior:'set'};
 p.running = 1;
 h.clearLog();
 r.runSequence64StepForTarget('track', 14, p, 0, 0);
 const arm = h.namedMessages.find(m => m[0] === 'sequence64_audio_arm');
 assert.deepEqual(arm, ['sequence64_audio_arm',1,16,3,75,1200,2.5,150,32,1.5,.08,1.8,.22,58,8,.5]);
 r.instrumentManual(15, 'kickPitch', 30);
 assert.equal(arm[4], 75);
});

test('kick baselines and physical step locks survive the complete session snapshot/apply path', () => {
 const h = createSequence64Harness(), r = h.context;
 selectTrack(h,14);
 r.instrumentManual(15,'kickDecay',950);
 r.sequence64SetInstrumentValue('kickPitch',83.5);
 const snapshot = JSON.parse(JSON.stringify(r.sessionRouterSnapshotObject()));
 assert.equal(snapshot.tracks[14].instrumentParameters.kickDecay,950);
 r.instrumentManual(15,'kickDecay',100);
 assert.equal(r.sessionApply(JSON.stringify(snapshot)),true);
 assert.equal(r.s.tracks[14].instrumentParameters.kickDecay,950);
 const p = r.ensureSequence64Pattern('track',14);
 assert.equal(p.steps[0].locks.kickPitch.value,83.5);
 assert.equal(p.running,0);
});

test('group instrument page follows selected step and edits the group lock without changing the track pattern', () => {
 const h = createSequence64Harness(), r = h.context;
 r.s.tracks[14].channel=1; r.s.tracks[0].channel=1;
 selectGroup(h,0);
 const p=r.currentSequence64Pattern();
 p.steps[0].cut={track:14,slice:0,gateLength:1};
 p.steps[1].cut={track:0,slice:0,gateLength:1};
 r.selectSequence64EditStep(0);
 r.dispatch(15,12,1);
 assert.equal(r.sequence64InstrumentPage,true);
 r.dispatch(15,13,1);
 assert.equal(p.steps[0].locks.kickPitch.value,120);
 assert.equal(r.ensureSequence64Pattern('track',14).steps[0].locks.kickPitch,undefined);
 r.selectSequence64EditStep(1);
 assert.equal(r.sequence64KickTarget(),false);
 assert.equal(r.sequence64InstrumentPage,false);
 r.sequence64SetInstrumentValue('kickPitch',60);
 assert.equal(p.steps[1].locks.kickPitch,undefined);
 r.selectSequence64EditStep(0);
 r.dispatch(15,12,1);
 assert.equal(r.sequence64InstrumentPage,true);
});

test('group instrument override affects only its merged hit, then child hits use their own locks', () => {
 const h=createSequence64Harness(),r=h.context;
 r.s.tracks[14].channel=1;
 const track=r.ensureSequence64Pattern('track',14);
 track.steps[0].locks.kickPitch={value:40,behavior:'set'};
 track.steps[1].locks.kickPitch={value:45,behavior:'set'};
 track.steps[1].cut={track:14,slice:1,gateLength:1};
 const group=r.ensureSequence64Pattern('group',0);
 group.steps[0].cut={track:14,slice:0,gateLength:1};
 group.steps[0].locks.kickPitch={value:80,behavior:'set'};
 group.running=1;
 h.clearLog();r.runSequence64StepForTarget('group',0,group,0,0);
 let arms=h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm');
 assert.equal(arms.at(-1)[4],80);
 const instance=Object.values(r.s.editorWorkspace.phraseInstances64)[0];
 r.runSequence64PhraseStep(instance,1);
 arms=h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm');
 assert.equal(arms.at(-1)[4],45);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch',0,14),48);
 assert.equal(track.steps[0].locks.kickPitch.value,40);
 assert.equal(group.steps[0].locks.kickPitch.value,80);
});

test('kick and snare locks affect one hit and the next unlocked hit uses its baseline',()=>{
 const h=createSequence64Harness(),r=h.context;
 const cases=[
  {track:14,id:'kickPitch',locked:84,baseline:48,packet:4},
  {track:13,id:'snareBodyHz',locked:260,baseline:180,packet:4}
 ];
 for(const item of cases){
  r.s.tracks[item.track].channel=1;
  const p=r.ensureSequence64Pattern('track',item.track);
  p.steps[0].cut={track:item.track,slice:0,gateLength:1};
  p.steps[0].locks[item.id]={value:item.locked,behavior:'set'};
  p.steps[1].cut={track:item.track,slice:1,gateLength:1};
  p.running=1;h.clearLog();
  r.runSequence64StepForTarget('track',item.track,p,0,0);
  r.runSequence64StepForTarget('track',item.track,p,0,1);
  const arms=h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm');
  assert.equal(arms[0][item.packet],item.locked);
  assert.equal(arms[1][item.packet],item.baseline);
  assert.equal(h.namedMessages.some(m=>m[0]==='rnbo_kick_owned_param'||m[0]==='rnbo_snare_owned_param'),false);
 }
});

test('lab mapping ranges affect grid edits but never rewrite stored locks or baselines', () => {
 const h=createSequence64Harness(),r=h.context;
 selectTrack(h,14);r.dispatch(15,12,1);
 r.sequence64SetInstrumentValue('kickPitch',100);
 assert.equal(r.kickRange('kickPitch',40,60),true);
 assert.equal(r.currentSequence64EditStep().locks.kickPitch.value,100);
 assert.equal(r.sequence64CurrentPropertyValue('kickPitch',0,14),48);
 r.dispatch(0,13,1);
 assert.equal(r.currentSequence64EditStep().locks.kickPitch.value,40);
 r.sequence64InstrumentFine(-1);
 assert.equal(r.currentSequence64EditStep().locks.kickPitch.value,40);
 r.dispatch(15,13,1);
 assert.equal(r.currentSequence64EditStep().locks.kickPitch.value,60);
 assert.equal(r.kickRange('kickPitch',80,30),false);
 assert.equal(r.kickRange('kickPitch',0,500),false);
 assert.equal(r.kickParameterRange('kickPitch').max,60);
});

test('all kick banks edit their own four parameters and persist complete baselines and locks',()=>{
 const h=createSequence64Harness(),r=h.context,model=require('../instrument_model');
 selectTrack(h,14);r.dispatch(15,12,1);
 for(let bank=0;bank<3;bank++){
  r.dispatch(9+bank,12,1);
  const ids=model.KICK_PAGES[bank].parameters;
  assert.deepEqual(Array.from(r.sequence64VisibleParameters()),ids);
  for(let col=0;col<4;col++){
   r.dispatch(4+col,12,1);r.dispatch(15,13,1);
   assert.equal(r.currentSequence64EditStep().locks[ids[col]].value,model.definition(ids[col]).gridMax);
   r.instrumentManual(15,ids[col],model.definition(ids[col]).min);
  }
 }
 const snapshot=JSON.parse(JSON.stringify(r.sessionRouterSnapshotObject()));
 assert.equal(Object.keys(snapshot.tracks[14].instrumentParameters).length,12);
 assert.equal(r.sessionApply(JSON.stringify(snapshot)),true);
 const p=r.ensureSequence64Pattern('track',14);
 for(const id of model.KICK_LOCKS){
  assert.equal(r.s.tracks[14].instrumentParameters[id],model.definition(id).min);
  assert.equal(p.steps[0].locks[id].value,model.definition(id).gridMax);
 }
});

test('legacy three-parameter sessions gain remaining defaults without changing their old values',()=>{
 const h=createSequence64Harness(),r=h.context;
 r.sessionApplyTrack(14,{instrumentParameters:{kickPitch:80,kickDecay:900,kickFM:2}});
 assert.equal(r.s.tracks[14].instrumentParameters.kickPitch,80);
 assert.equal(r.s.tracks[14].instrumentParameters.kickDrive,1.8);
 assert.equal(r.s.tracks[14].instrumentParameters.kickLevel,.5);
});

test('parameter focus updates HUD values and context without retriggering grid labels on edits',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);h.clearLog();
 r.dispatch(15,12,1);
 let labels=()=>h.namedMessages.filter(m=>m[0]==='togridmatrixio'&&m[1]==='parameterLabel');
 assert.equal(labels().at(-1)[2],'PCH');
 h.clearLog();r.dispatch(15,13,1);
 const focus=()=>JSON.parse(h.hudMessages.filter(m=>m[0]==='parameter_focus').at(-1)[1]);
 assert.equal(focus().name,'Pitch');assert.equal(focus().value,120);assert.equal(focus().layer,'Track lock');
 assert.equal(labels().length,0);
 r.dispatch(2,14,1);assert.equal(focus().layer,'Baseline');assert.equal(labels().length,0);
 r.dispatch(10,12,1);assert.equal(labels().at(-1)[2],'FMAT');
 r.dispatch(7,12,1);assert.equal(focus().name,'Drive');assert.equal(labels().at(-1)[2],'DRV');
 r.dispatch(14,12,1);assert.equal(focus().active,false);
 assert.ok(h.namedMessages.some(m=>m[1]==='parameterLabelClear'));
});

test('group parameter focus describes selected step override and stays out of session state',()=>{
 const h=createSequence64Harness(),r=h.context;r.s.tracks[14].channel=1;selectGroup(h,0);
 const p=r.currentSequence64Pattern();p.steps[8].cut={track:14,slice:0,gateLength:1};
 r.selectSequence64EditStep(8);r.dispatch(15,12,1);r.sequence64SetInstrumentValue('kickPitch',77);
 const f=JSON.parse(h.hudMessages.filter(m=>m[0]==='parameter_focus').at(-1)[1]);
 assert.equal(f.track,15);assert.equal(f.step,9);assert.equal(f.layer,'Group override');
 const saved=JSON.stringify(r.sessionRouterSnapshotObject());assert.equal(saved.includes('parameterFocus'),false);
});


test('kick page buttons always announce the selected bank, including repeated presses',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);r.dispatch(15,12,1);
 for(const bank of [0,1,2,0,0,2,1]) {
  h.clearLog();r.dispatch(9+bank,12,1);r.dispatch(9+bank,12,0);
  const labels=h.namedMessages.filter(m=>m[0]==='togridmatrixio'&&m[1]==='parameterLabel');
  assert.deepEqual(labels.map(m=>m[2]),[['BODY','FMAT','RES'][bank]]);
  const f=JSON.parse(h.hudMessages.filter(m=>m[0]==='parameter_focus').at(-1)[1]);
  assert.equal(f.page,['Kick 1/3 · Body','Kick 2/3 · FM / attack','Kick 3/3 · Resonator / output'][bank]);
  assert.equal(f.id,['kickPitch','kickFM','kickResMix'][bank]);
  h.clearLog();r.dispatch(8,13,1);
  assert.equal(h.namedMessages.filter(m=>m[1]==='parameterLabel').length,0);
 }
});

test('snare grid pages expose all twelve controls and keep baseline edits separate from step locks',()=>{
 const h=createSequence64Harness(),r=h.context,model=require('../snare_instrument_model');
 selectTrack(h,13);r.dispatch(15,12,1);
 assert.equal(r.sequence64InstrumentPage,true);
 for(let bank=0;bank<3;bank++){
  r.dispatch(9+bank,12,1);
  const ids=model.SNARE_PAGES[bank].parameters;
  assert.deepEqual(Array.from(r.sequence64VisibleParameters()),ids);
  for(let col=0;col<4;col++){
   r.dispatch(4+col,12,1);r.dispatch(15,13,1);
   assert.equal(r.currentSequence64EditStep().locks[ids[col]].value,model.definition(ids[col]).gridMax);
  }
 }
 const locked=r.currentSequence64EditStep().locks.snareLevel.value;
 r.dispatch(2,14,1);r.dispatch(0,13,1);
 assert.equal(r.s.tracks[13].instrumentParameters.snareLevel,model.definition('snareLevel').gridMin);
 assert.equal(r.currentSequence64EditStep().locks.snareLevel.value,locked);
 const snapshot=JSON.parse(JSON.stringify(r.sessionRouterSnapshotObject()));
 assert.equal(Object.keys(snapshot.tracks[13].instrumentParameters).length,12);
 assert.equal(r.sessionApply(JSON.stringify(snapshot)),true);
 for(const id of model.SNARE_LOCKS) assert.ok(Object.hasOwn(r.ensureSequence64Pattern('track',13).steps[0].locks,id));
});

test('snare audio arm captures the full effective sound with each Track 14 hit',()=>{
 const h=createSequence64Harness(),r=h.context;
 r.s.tracks[13].channel=1;
 const p=r.ensureSequence64Pattern('track',13);
 p.steps[0].cut={track:13,slice:2,gateLength:1};
 p.steps[0].locks.snareBodyHz={value:240,behavior:'set'};
 p.steps[0].locks.snareNoiseDecay={value:700,behavior:'set'};
 p.steps[0].locks.snareSnap={value:.9,behavior:'set'};
 p.running=1;h.clearLog();
 r.runSequence64StepForTarget('track',13,p,0,0);
 const arm=h.namedMessages.find(m=>m[0]==='sequence64_audio_arm');
 assert.deepEqual(arm,['sequence64_audio_arm',1,15,2,240,180,.35,90,700,3500,.9,1.7,.65,.72,1.1,.45]);
 r.instrumentManual(14,'snareBodyHz',110);
 assert.equal(arm[4],240);
});

test('snare ranges, ownership, and legacy sessions use the same durable instrument path as kick',()=>{
 const h=createSequence64Harness(),r=h.context;
 r.s.tracks[13].channel=1;
 r.instrumentManual(14,'snareBodyHz',150);
 r.sequence64WriteOwnedProperty('group',0,'snareBodyHz',280,0,13,0);
 r.sequence64WriteOwnedProperty('track',13,'snareBodyHz',210,0,13,0);
 assert.equal(r.sequence64CurrentPropertyValue('snareBodyHz',0,13),280);
 r.releaseSequence64OwnedProperties('group:0',0);
 assert.equal(r.sequence64CurrentPropertyValue('snareBodyHz',0,13),210);
 r.releaseSequence64OwnedProperties('track:13',0);
 assert.equal(r.sequence64CurrentPropertyValue('snareBodyHz',0,13),150);
 assert.equal(r.snareRange('snareBodyHz',120,260),true);
 assert.deepEqual(JSON.parse(JSON.stringify(r.snareParameterRange('snareBodyHz'))),{min:120,max:260});
 r.sessionApplyTrack(13,{instrumentParameters:{snareBodyHz:190,snareSnap:.8}});
 assert.equal(r.s.tracks[13].instrumentParameters.snareBodyHz,190);
 assert.equal(r.s.tracks[13].instrumentParameters.snareSnap,.8);
 assert.equal(r.s.tracks[13].instrumentParameters.snareDrive,1.7);
});

test('group inspector follows snare and kick steps without retaining the previous engine parameter',()=>{
 const h=createSequence64Harness(),r=h.context;
 r.s.tracks[13].channel=1;r.s.tracks[14].channel=1;selectGroup(h,0);
 const p=r.currentSequence64Pattern();
 p.steps[0].cut={track:13,slice:0,gateLength:1};
 p.steps[1].cut={track:14,slice:0,gateLength:1};
 r.selectSequence64EditStep(0);r.dispatch(15,12,1);
 assert.equal(r.sequence64VisibleParameters()[0],'snareBodyHz');
 r.sequence64SetInstrumentValue('snareBodyHz',230);
 r.selectSequence64EditStep(1);
 assert.equal(r.sequence64InstrumentPage,true);
 assert.equal(r.sequence64VisibleParameters()[0],'kickPitch');
 r.sequence64SetInstrumentValue('kickPitch',72);
 assert.equal(p.steps[0].locks.snareBodyHz.value,230);
 assert.equal(p.steps[1].locks.kickPitch.value,72);
 assert.equal(p.steps[1].locks.snareBodyHz,undefined);
});

test('Setup sound slots store and recall engine baselines without recording locks',()=>{
 const h=createSequence64Harness(),r=h.context;
 for(const [track,id,value,label] of [[14,'kickPitch',71,'KP3'],[13,'snareBodyHz',251,'SP3']]){
  selectTrack(h,track);r.switchSequence64View('setup');
  r.instrumentManual(track+1,id,value);
  r.dispatch(11,15,1);r.dispatch(9,14,1);r.dispatch(9,14,0);r.dispatch(11,15,0);
  assert.equal(r.buildEditorShellLevels()[6*16+9],15);
  assert.ok(h.namedMessages.some(m=>m[1]==='parameterLabel'&&m[2]===label));
  r.instrumentManual(track+1,id,value+10);
  assert.equal(r.buildEditorShellLevels()[6*16+9],5);
  const locks=JSON.stringify(r.currentSequence64Pattern().bars);
  r.sequence64InspectorLiveWrite=true;
  r.dispatch(9,14,1);r.dispatch(9,14,0);
  assert.equal(r.s.tracks[track].instrumentParameters[id],value);
  assert.equal(JSON.stringify(r.currentSequence64Pattern().bars),locks);
  assert.equal(r.buildEditorShellLevels()[6*16+9],15);
  r.sequence64InspectorLiveWrite=false;
 }
 assert.equal(r.s.instrumentPresets.kick[2].kickPitch,71);
 assert.equal(r.s.instrumentPresets.snare[2].snareBodyHz,251);
 const before=JSON.stringify(r.s.tracks[13].instrumentParameters);
 r.dispatch(7,14,1);
 assert.equal(JSON.stringify(r.s.tracks[13].instrumentParameters),before);
 selectTrack(h,0);r.switchSequence64View('setup');r.dispatch(11,15,1);r.dispatch(7,14,1);
 assert.equal(r.buildEditorShellLevels()[6*16+7],0);
});

test('sound banks survive the session document path and clear for old or new sessions',()=>{
 const h=createSequence64Harness(),r=h.context,core=require('../mlr_session_core');
 r.instrumentManual(15,'kickPitch',64);r.instrumentPresetAction(14,7,true);
 r.instrumentManual(14,'snareSnap',.8);r.instrumentPresetAction(13,0,true);
 const snapshot=JSON.parse(JSON.stringify(r.sessionRouterSnapshotObject()));
 const doc=core.buildDocument({router:snapshot});
 assert.equal(doc.instrumentPresets.kick[7].kickPitch,64);
 assert.equal(Object.keys(doc.instrumentPresets.kick[7]).length,12);
 assert.equal(JSON.stringify(doc).includes('instrumentPresetSelection'),false);
 r.sessionNew();
 assert.equal(r.s.instrumentPresets.kick[7],null);
 assert.equal(r.sessionApply(JSON.stringify(doc)),true);
 assert.equal(r.s.instrumentPresets.snare[0].snareSnap,.8);
 r.instrumentManual(15,'kickPitch',30);r.instrumentPresetAction(14,7,false);
 assert.equal(r.sceneTrackSnapshot(14).instrumentParameters.kickPitch,64);
 assert.equal(r.sessionRouterSnapshotObject().tracks[14].instrumentParameters.kickPitch,64);
 r.sessionApply(JSON.stringify({}));
 assert.equal(r.s.instrumentPresets.snare[0],null);
 const malformed=r.sanitizeInstrumentPresets({kick:[null,5,[],{kickPitch:1e9,repeat:1}]});
 assert.equal(malformed.kick.length,8);
 assert.equal(malformed.kick[1],null);
 assert.equal(malformed.kick[2],null);
 assert.equal(malformed.kick[3].kickPitch,2000);
 assert.equal(malformed.kick[3].repeat,undefined);
});

test('snare page buttons announce their bank and focused parameter',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,13);r.dispatch(15,12,1);
 for(const bank of [0,1,2,1]){
  h.clearLog();r.dispatch(9+bank,12,1);r.dispatch(9+bank,12,0);
  const labels=h.namedMessages.filter(m=>m[0]==='togridmatrixio'&&m[1]==='parameterLabel');
  assert.deepEqual(labels.map(m=>m[2]),[['BODY','NOIS','MIX'][bank]]);
  const f=JSON.parse(h.hudMessages.filter(m=>m[0]==='parameter_focus').at(-1)[1]);
  assert.equal(f.page,['Snare 1/3 · Body','Snare 2/3 · Noise','Snare 3/3 · Mix / output'][bank]);
  assert.equal(f.id,['snareBodyHz','snareNoiseDecay','snareBodyLevel'][bank]);
 }
});

test('hat grid pages expose all twelve controls and keep baseline edits separate from step locks',()=>{
 const h=createSequence64Harness(),r=h.context,model=require('../hat_instrument_model');
 selectTrack(h,12);r.dispatch(15,12,1);
 assert.equal(r.sequence64InstrumentPage,true);
 for(let bank=0;bank<3;bank++){
  r.dispatch(9+bank,12,1);
  const ids=model.HAT_PAGES[bank].parameters;
  assert.deepEqual(Array.from(r.sequence64VisibleParameters()),ids);
  for(let col=0;col<4;col++){
   r.dispatch(4+col,12,1);r.dispatch(15,13,1);
   assert.equal(r.currentSequence64EditStep().locks[ids[col]].value,model.definition(ids[col]).gridMax);
  }
 }
 const locked=r.currentSequence64EditStep().locks.hatLevel.value;
 r.dispatch(2,14,1);r.dispatch(0,13,1);
 assert.equal(r.s.tracks[12].instrumentParameters.hatLevel,model.definition('hatLevel').gridMin);
 assert.equal(r.currentSequence64EditStep().locks.hatLevel.value,locked);
 const snapshot=JSON.parse(JSON.stringify(r.sessionRouterSnapshotObject()));
 assert.equal(Object.keys(snapshot.tracks[12].instrumentParameters).length,12);
 assert.equal(r.sessionApply(JSON.stringify(snapshot)),true);
 for(const id of model.HAT_LOCKS) assert.ok(Object.hasOwn(r.ensureSequence64Pattern('track',12).steps[0].locks,id));
});


test('hat queued hits return to baseline and its sound bank survives session restore',()=>{
 const h=createSequence64Harness(),r=h.context,model=require('../hat_instrument_model');
 r.s.tracks[12].channel=1;
 const p=r.ensureSequence64Pattern('track',12);
 p.steps[0].cut={track:12,slice:0,gateLength:1};
 p.steps[1].cut={track:12,slice:1,gateLength:1};
 p.steps[0].locks.hatDecay={value:1400,behavior:'set'};
 p.steps[0].locks.hatFilterHz={value:8500,behavior:'set'};
 p.running=1;h.clearLog();
 r.runSequence64StepForTarget('track',12,p,0,0);
 r.runSequence64StepForTarget('track',12,p,0,1);
 const arms=h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm');
 const base=model.HAT_LOCKS.map(id=>model.definition(id).initial);
 const locked=base.slice();locked[1]=1400;locked[5]=8500;
 assert.deepEqual(arms[0],['sequence64_audio_arm',1,14,0,...locked]);
 assert.deepEqual(arms[1],['sequence64_audio_arm',1,14,1,...base]);
 r.hatManual('metalHz',920);r.instrumentPresetAction(12,0,true);
 const doc=r.sessionRouterSnapshotObject();
 r.hatManual('metalHz',400);r.sessionApply(JSON.stringify(doc));
 r.instrumentPresetAction(12,0,false);
 assert.equal(r.s.tracks[12].instrumentParameters.hatPitch,920);
 assert.ok(h.namedMessages.some(m=>m[1]==='parameterLabel'&&m[2]==='HP1'));
 assert.equal(r.s.instrumentPresets.kick[0],null);
 assert.equal(r.s.instrumentPresets.snare[0],null);
});

test('hat page announcements identify all three banks',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,12);r.dispatch(15,12,1);
 for(const [bank,label,id] of [[0,'METL','hatPitch'],[1,'SHAP','hatDecay'],[2,'FILT','hatFilterHz']]){
  h.clearLog();r.dispatch(9+bank,12,1);
  assert.ok(h.namedMessages.some(m=>m[1]==='parameterLabel'&&m[2]===label));
  const focus=JSON.parse(h.hudMessages.filter(m=>m[0]==='parameter_focus').at(-1)[1]);
  assert.equal(focus.id,id);
 }
});

test('clap grid pages expose all twelve controls and keep baseline edits separate from step locks',()=>{
 const h=createSequence64Harness(),r=h.context,model=require('../clap_instrument_model');
 selectTrack(h,11);r.dispatch(15,12,1);
 assert.equal(r.sequence64InstrumentPage,true);
 for(let bank=0;bank<3;bank++){
  r.dispatch(9+bank,12,1);
  const ids=model.CLAP_PAGES[bank].parameters;
  assert.deepEqual(Array.from(r.sequence64VisibleParameters()),ids);
  for(let col=0;col<4;col++){
   r.dispatch(4+col,12,1);r.dispatch(15,13,1);
   assert.equal(r.currentSequence64EditStep().locks[ids[col]].value,model.definition(ids[col]).gridMax);
  }
 }
 const locked=r.currentSequence64EditStep().locks.clapLevel.value;
 r.dispatch(2,14,1);r.dispatch(0,13,1);
 assert.equal(r.s.tracks[11].instrumentParameters.clapLevel,model.definition('clapLevel').gridMin);
 assert.equal(r.currentSequence64EditStep().locks.clapLevel.value,locked);
 const snapshot=JSON.parse(JSON.stringify(r.sessionRouterSnapshotObject()));
 assert.equal(Object.keys(snapshot.tracks[11].instrumentParameters).length,12);
 assert.equal(r.sessionApply(JSON.stringify(snapshot)),true);
 for(const id of model.CLAP_LOCKS) assert.ok(Object.hasOwn(r.ensureSequence64Pattern('track',11).steps[0].locks,id));
});



test('clap locks restore baseline on the next hit and presets round-trip independently',()=>{
 const h=createSequence64Harness(),r=h.context,m=require('../clap_instrument_model');
 r.s.tracks[11].channel=1;
 const p=r.ensureSequence64Pattern('track',11);
 p.steps[0].cut={track:11,slice:0,gateLength:1};p.steps[1].cut={track:11,slice:1,gateLength:1};
 p.steps[0].locks.clapCount={value:6,behavior:'set'};
 p.steps[0].locks.clapTailDecay={value:1200,behavior:'set'};
 p.running=1;h.clearLog();
 r.runSequence64StepForTarget('track',11,p,0,0);r.runSequence64StepForTarget('track',11,p,0,1);
 const arms=h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm');
 const base=m.CLAP_LOCKS.map(id=>m.definition(id).initial),locked=base.slice();locked[0]=6;locked[4]=1200;
 assert.deepEqual(arms[0],['sequence64_audio_arm',1,13,0,...locked]);
 assert.deepEqual(arms[1],['sequence64_audio_arm',1,13,1,...base]);
 r.clapManual('count',4.7);r.instrumentPresetAction(11,0,true);
 const core=require('../mlr_session_core');
 const doc=core.buildDocument({router:r.sessionRouterSnapshotObject()});
 r.clapManual('count',2);r.sessionApply(JSON.stringify(doc));r.instrumentPresetAction(11,0,false);
 assert.equal(r.s.tracks[11].instrumentParameters.clapCount,5);
 assert.ok(h.namedMessages.some(m=>m[1]==='parameterLabel'&&m[2]==='CP1'));
 for(const name of ['kick','snare','hat'])assert.equal(r.s.instrumentPresets[name][0],null);
});
test('clap page announcements and group inspector follow Track 12',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,11);r.dispatch(15,12,1);
 for(const [bank,label,id] of [[0,'CLAP','clapCount'],[1,'TONE','clapFilterHz'],[2,'TAIL','clapTailDecay']]){
  h.clearLog();r.dispatch(9+bank,12,1);
  assert.ok(h.namedMessages.some(m=>m[1]==='parameterLabel'&&m[2]===label));
  const f=JSON.parse(h.hudMessages.filter(m=>m[0]==='parameter_focus').at(-1)[1]);assert.equal(f.id,id);
 }
 r.s.tracks[11].channel=1;selectGroup(h,0);const p=r.currentSequence64Pattern();p.steps[0].cut={track:11,slice:0,gateLength:1};r.selectSequence64EditStep(0);
 r.sequence64InstrumentPage=true;r.sequence64InstrumentBank=0;
 assert.equal(r.sequence64VisibleParameters()[0],'clapCount');
 r.sequence64SetInstrumentValue('clapCount',5);assert.equal(p.steps[0].locks.clapCount.value,5);
});

test('selected step breathes in brightness and color without touching pattern data',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);
 r.selectSequence64EditStep(3);
 const pattern=r.currentSequence64Pattern();pattern.steps[3].cut={track:14,slice:3,gateLength:1};
 const before=JSON.stringify(pattern);
 const index=r.editorShellLevelIndex(3,8);
 r.sequence64SelectionPulse=0;
 const low=r.buildEditorShellLevels(),lowColor=Array.from(r.buildEditorShellColors(low)[index]);
 r.sequence64SelectionPulse=1;
 const high=r.buildEditorShellLevels(),highColor=Array.from(r.buildEditorShellColors(high)[index]);
 assert.equal(low[index],11);assert.equal(high[index],15);
 assert.notDeepEqual(lowColor,highColor);
 assert.equal(JSON.stringify(pattern),before);
 r.selectSequence64EditStep(4);
 assert.equal(r.buildEditorShellLevels()[index],7);
 assert.equal(r.sequence64SelectionPulseVisible(),true);
 r.sequence64ShiftHeld=true;assert.equal(r.sequence64SelectionPulseVisible(),false);
 r.sequence64ShiftHeld=false;r.ensureEditorWorkspaceDefaults().view64='setup';
 assert.equal(r.sequence64SelectionPulseVisible(),false);
 r.sequence64SelectionPulseTask.callback();assert.equal(r.sequence64SelectionPulsePending,false);
});

test('playhead stays full-bright over the selection pulse',()=>{
 const h=createSequence64Harness(),r=h.context;selectGroup(h,0);
 const p=r.currentSequence64Pattern();p.running=1;p.steps[0].cut={track:0,slice:0,gateLength:1};
 const location=r.currentSequence64PlaybackLocation(p);r.selectSequence64EditStep(location.step);
 r.sequence64SelectionPulse=0;
 const xy=r.sequence64StepCoords(location.step),index=r.editorShellLevelIndex(xy[0],xy[1]);
 const levels=r.buildEditorShellLevels();assert.equal(levels[index],15);
 assert.deepEqual(Array.from(r.buildEditorShellColors(levels)[index]),Array.from(r.SEQUENCE64_COLORS.playhead));
});

test('Target Jump copies a snapshot to multiple steps without triggering or jumping',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);
 const p=r.currentSequence64Pattern();
 p.steps[2]={cut:{track:14,slice:4,gateLength:2},locks:{kickPitch:{value:80,behavior:'set'}},probability:9,condition:2};
 const saved=JSON.parse(JSON.stringify(p.steps[2]));h.clearLog();
 r.dispatch(13,15,1);r.dispatch(2,8,1);r.dispatch(2,8,0);
 p.steps[2].locks.kickPitch.value=40;
 r.dispatch(5,8,1);r.dispatch(5,8,0);r.dispatch(6,8,1);
 // Release Copy before the destination pad: its release must not create a cut.
 r.dispatch(13,15,0);r.dispatch(6,8,0);
 assert.deepEqual(JSON.parse(JSON.stringify(p.steps[5])),saved);
 assert.deepEqual(JSON.parse(JSON.stringify(p.steps[6])),saved);
 p.steps[5].locks.kickPitch.value=55;assert.equal(p.steps[6].locks.kickPitch.value,80);
 assert.equal(r.s.editorWorkspace.targetType,'track');assert.equal(r.s.editorWorkspace.targetId,14);
 assert.equal(r.sequence64CopyGesture,null);assert.equal(r.sequence64PressedStep,-1);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_audio_arm'),false);
 assert.ok(h.namedMessages.some(m=>m[0]==='mlr_session_dirty'&&m[2]==='ṛta step paste'));
 assert.equal(JSON.stringify(r.sessionRouterSnapshotObject()).includes('CopyGesture'),false);
});
test('copying a triggerless step preserves it, works across bars, and cancels on view change',()=>{
 const h=createSequence64Harness(),r=h.context;selectGroup(h,0);
 const p=r.currentSequence64Pattern();r.addSequence64Bar();r.selectSequence64Bar(0);
 p.bars[0].steps[1].locks.volume={value:6,behavior:'set'};
 r.dispatch(13,15,1);r.dispatch(1,8,1);r.dispatch(1,8,0);
 r.dispatch(r.SEQUENCE64_BAR_FIRST_COL+1,15,1);r.dispatch(r.SEQUENCE64_BAR_FIRST_COL+1,15,0);
 r.dispatch(4,8,1);r.dispatch(13,15,0);r.dispatch(4,8,0);
 assert.equal(p.bars[1].steps[4].cut,null);assert.equal(p.bars[1].steps[4].locks.volume.value,6);
 assert.equal(p.bars[1].length,64);
 r.dispatch(13,15,1);r.sequence64CopyHoldTask.callback();
 r.dispatch(13,15,0);assert.equal(r.s.editorWorkspace.targetType,'group');
 r.dispatch(13,15,1);r.switchSequence64View('setup');r.dispatch(13,15,0);
 assert.equal(r.sequence64CopyGesture,null);assert.equal(r.s.editorWorkspace.targetType,'group');
});
test('copy source selection leaves an empty step empty',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);const p=r.currentSequence64Pattern();
 r.dispatch(13,15,1);r.dispatch(3,8,1);r.dispatch(13,15,0);r.dispatch(3,8,0);
 assert.equal(p.steps[3].cut,null);assert.equal(r.s.editorWorkspace.targetId,14);
});

test('Shift and Delete cannot leave Copy or their own modifiers latched',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);
 for(const col of [11,14]){
  r.dispatch(col,15,1);r.dispatch(13,15,1);
  assert.equal(r.sequence64CopyGesture,null);
  r.dispatch(col,15,0);r.dispatch(13,15,0);
  assert.equal(r.sequence64ShiftHeld,false);assert.equal(r.sequence64DeleteHeld,false);
  assert.equal(r.s.editorWorkspace.targetId,14);
 }
});

test('selection rendering does not normalize the full pattern once per pad',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);
 const p=r.currentSequence64Pattern();p.steps[0].cut={track:14,slice:0,gateLength:1};
 let calls=0;const original=r.ensureSequence64Pattern;
 r.ensureSequence64Pattern=function(...args){calls++;return original(...args);};
 const levels=r.buildEditorShellLevels();r.buildEditorShellColors(levels);
 assert.ok(calls<30,`full-pattern lookups for one frame: ${calls}`);
});

test('selection pulse refresh updates one pad without rebuilding or normalizing the pattern',()=>{
 const h=createSequence64Harness(),r=h.context;selectTrack(h,14);
 const p=r.currentSequence64Pattern();p.steps[0].cut={track:14,slice:0,gateLength:1};
 r.ensureSequence64Pattern=()=>{throw Error('pulse must not normalize a pattern');};
 r.buildEditorShellLevels=()=>{throw Error('pulse must not rebuild the editor');};
 let changes;r.applyEditorLevelDiff=value=>{changes=value;};
 r.sequence64SelectionPulse=0;r.refreshSequence64SelectionCell();
 assert.equal(changes.length,1);assert.deepEqual(Array.from(changes[0].slice(0,3)),[0,8,11]);
});

for(const e of require('../synth_engine_catalog').engines){
 test(e.name+' grid pages, non-latching hit packets and session preset recall',()=>{
  const h=createSequence64Harness(),r=h.context,m=require('../'+e.id+'_instrument_model');selectTrack(h,e.track);r.dispatch(15,12,1);
  for(let bank=0;bank<3;bank++){
   r.dispatch(9+bank,12,1);const ids=m[e.id.toUpperCase()+'_PAGES'][bank].parameters;
   assert.deepEqual(Array.from(r.sequence64VisibleParameters()),ids);
   for(let col=0;col<4;col++){r.dispatch(4+col,12,1);r.dispatch(15,13,1);assert.equal(r.currentSequence64EditStep().locks[ids[col]].value,m.definition(ids[col]).gridMax);}
  }
  const p=r.ensureSequence64Pattern('track',e.track);r.s.tracks[e.track].channel=1;
  p.steps[0].cut={track:e.track,slice:0,gateLength:1};p.steps[1].cut={track:e.track,slice:1,gateLength:1};p.running=1;h.clearLog();
  r.runSequence64StepForTarget('track',e.track,p,0,0);r.runSequence64StepForTarget('track',e.track,p,0,1);
  const arms=h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm');
  assert.deepEqual(arms[0],['sequence64_audio_arm',1,e.track+2,0,...e.parameters.map(p=>p.gridMax)]);
  assert.deepEqual(arms[1],['sequence64_audio_arm',1,e.track+2,1,...e.parameters.map(p=>p.initial)]);
  const d=e.parameters[0];r[e.id+'Manual'](d.rnbo,d.gridMax);r.instrumentPresetAction(e.track,0,true);
  const doc=require('../mlr_session_core').buildDocument({router:r.sessionRouterSnapshotObject()});
  r[e.id+'Manual'](d.rnbo,d.gridMin);r.sessionApply(JSON.stringify(doc));r.instrumentPresetAction(e.track,0,false);
  assert.equal(r.s.tracks[e.track].instrumentParameters[d.id],d.gridMax);
 });
}


test('64 to 16 to 64 length edits retain beat alignment and fractional rate progress', () => {
 const h=createSequence64Harness(),r=h.context;
 selectGroup(h,2);
 const p=r.ensureSequence64Pattern('group',2);
 p.running=1;p.phaseOrigin=0;p.rateNumerator=1;p.rateDenominator=2;
 r.sequence64ClockPosition=69;
 r.setCurrentSequence64BarLength(16);
 assert.equal(r.currentSequence64StepIndex(),2);
 assert.equal(p.phaseOrigin%32,0);
 r.sequence64ClockPosition=75;
 r.setCurrentSequence64BarLength(64);
 assert.equal(p.phaseOrigin%32,0);
 const other=r.ensureSequence64Pattern('group',0);other.rateDenominator=2;other.phaseOrigin=0;
 for(let i=0;i<128;i++){
  r.sequence64ClockPosition=76+i;
  assert.equal(r.sequence64PatternAbsoluteStep(p,r.sequence64ClockPosition)%16,
   r.sequence64PatternAbsoluteStep(other,r.sequence64ClockPosition)%16);
 }
});

function nativeCacheHarness() {
 const h=createSequence64Harness(),r=h.context;
 r.globalTransport(0);
 const p=r.ensureSequence64Pattern('group',0);
 p.running=0;p.bars[0].length=16;
 p.bars[0].steps[0].cut={track:14,slice:0,gateLength:1};
 r.s.tracks[14].channel=1;r.s.tracks[14].buffer=0;
 h.clearLog();return h;
}
test('router initialization silences and invalidates an external left running across autowatch reload',()=>{
 const h=nativeCacheHarness();
 assert.deepEqual(h.startupMessages.filter(m=>m[0]==='sequence64_native_control'),
  [['sequence64_native_control','stop'],['sequence64_native_control','reset']]);
});
function acknowledgeNativeCache(h) {
 const r=h.context;
 assert.equal(r.nativeSequence64Groups(1),true);
 const nonce=r.sequence64NativePending.nonce;
 r.nativeSequence64Report('hello',7,nonce,1);
 const generation=r.sequence64NativePending.generation;
 r.nativeSequence64Report('committed',7,generation);
 return generation;
}
test('native cache waits for whole-cache acknowledgement and suppresses V8 duplicate arms',()=>{
 const h=nativeCacheHarness(),r=h.context;
 assert.equal(r.nativeSequence64Groups(1),true);
 assert.equal(r.s.globalTransportRunning,0);
 assert.equal(r.sequence64NativeGroups[0],undefined);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_native_control'&&m[1]==='start'),false);
 r.nativeSequence64Report('hello',7,r.sequence64NativePending.nonce,1);
 const generation=r.sequence64NativePending.generation;
 assert.ok(h.namedMessages.some(m=>m[0]==='sequence64_native_control'&&m[1]==='commit'));
 r.nativeSequence64Report('committed',7,generation-1);
 assert.equal(r.sequence64NativeGroups[0],undefined);
 r.nativeSequence64Report('committed',7,generation);
 assert.equal(r.sequence64NativeGroups[0],true);
 assert.equal(r.s.globalTransportRunning,1);
 const timeline=h.namedMessages;
 const clear=timeline.findIndex(m=>m[0]==='sequence64_audio_cancel');
 const resume=timeline.findIndex(m=>m[0]==='sequence64_native_control'&&m[1]==='resume');
 const start=timeline.findIndex(m=>m[0]==='sequence64_native_control'&&m[1]==='start');
 assert.ok(clear>=0&&clear<resume&&resume<start);
 h.clearLog();for(let i=0;i<40;i++)r.sequence64SubPulse();
 assert.equal(h.namedMessages.filter(m=>m[0]==='sequence64_audio_arm').length,0);
 assert.equal(r.ensureSequence64Pattern('group',0).lastSequencedAbsolute,39);
 assert.equal(/sequence64Native|nativeEpoch|nativeGeneration/.test(JSON.stringify(r.sessionRouterSnapshotObject())),false);
});
test('native cache edits, manual cuts and session stop release ownership; late acknowledgements cannot restart',()=>{
 for(const action of ['edit','manual','session']){
  const h=nativeCacheHarness(),r=h.context;acknowledgeNativeCache(h);h.clearLog();
  if(action==='edit')r.markSessionDirty('step');
  if(action==='manual')r.triggerEditorTrack(14,3);
  if(action==='session')r.sessionStopAndReset();
  assert.equal(Object.keys(r.sequence64NativeGroups).length,0);
  assert.equal(r.ensureSequence64Pattern('group',0).running,0);
  assert.ok(h.namedMessages.some(m=>m[0]==='sequence64_native_control'&&m[1]==='stop'));
  assert.ok(h.namedMessages.some(m=>m[0]==='sequence64_native_control'&&m[1]==='reset'));
 }
 const h=nativeCacheHarness(),r=h.context;
 r.nativeSequence64Groups(1);const nonce=r.sequence64NativePending.nonce;
 r.nativeSequence64Report('hello',7,nonce,1);const generation=r.sequence64NativePending.generation;
 r.globalTransport(0);h.clearLog();r.nativeSequence64Report('committed',7,generation);
 assert.equal(r.s.globalTransportRunning,0);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_native_control'&&m[1]==='start'),false);
});
test('native cache missing bridge, unsupported patterns and rejected uploads remain stopped',()=>{
 const h=nativeCacheHarness(),r=h.context;
 r.ensureSequence64Pattern('group',0).bars[0].steps[0].probability=8;
 assert.equal(r.nativeSequence64Groups(1),false);
 assert.equal(r.sequence64NativePending,null);
 r.ensureSequence64Pattern('group',0).bars[0].steps[0].probability=15;
 assert.equal(r.nativeSequence64Groups(1),true);
 r.sequence64NativeTimeout.callback();
 assert.equal(r.sequence64NativePending,null);assert.equal(r.s.globalTransportRunning,0);
 r.nativeSequence64Groups(1);r.nativeSequence64Report('rejected','begin');
 assert.equal(r.sequence64NativePending,null);assert.equal(r.s.globalTransportRunning,0);
 r.s.sequencers[0].on=1;assert.equal(r.nativeSequence64Groups(1),false);
 r.s.sequencers[0].on=0;r.nativeSequence64Groups(1);
 r.nativeSequence64Report('hello',7,r.sequence64NativePending.nonce,1);
 const generation=r.sequence64NativePending.generation;
 r.globalTransport(1);h.clearLog();r.nativeSequence64Report('committed',7,generation);
 assert.equal(Object.keys(r.sequence64NativeGroups).length,0);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_native_control'&&m[1]==='start'),false);
 r.globalTransport(0);r.nativeSequence64Groups(1);
 r.nativeSequence64Report('hello',7,r.sequence64NativePending.nonce);
 assert.equal(r.sequence64NativePending,null);
 assert.equal(r.s.globalTransportRunning,0,'older loaded binaries fail closed with a restart notice');
});
test('native telemetry updates display ownership without arming audio; stale epochs are ignored',()=>{
 const h=nativeCacheHarness(),r=h.context;acknowledgeNativeCache(h);h.clearLog();
 r.nativeSequence64Report('frame',6,1,16,8);
 assert.notEqual(r.s.tracks[14].playPos,8);
 r.nativeSequence64Report('frame',7,1,16,8);
 assert.equal(r.s.tracks[14].playPos,8);assert.equal(r.s.channels[0].activeTrack,14);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_audio_arm'||m[0]==='16input'),false);
 r.markSessionDirty('edit');h.clearLog();r.nativeSequence64Report('frame',7,1,16,9);
 assert.equal(r.s.tracks[14].playPos,8);
 assert.equal(r.s.globalTransportRunning,0);
});

test('base MLR cannot enable rta via HUD, grid shortcuts, clocks, native replies or session state', () => {
 const h=createHarness(undefined,'sequence64','mlr'),r=h.context;
 r.loadbang();
 r.extendedEditors(1);
 r.hudTarget('group',0); r.hudTransport('run');
 r.setSequence64TargetRunning('group',0,1);
 r.stageSceneLaunch(0,'test'); r.stageScenePattern(0,0); r.stageTrackSlotSwitch(0);
 r.nativeSequence64Groups(0); r.nativeSequence64Report('ready',1,1);
 r.handleSequence64RunShortcutKey('group',0,1);
 r.handleSequence64RunShortcutKey('group',0,0);
 r.globalTransport(1); // base transport remains usable
 const clock=r.sequence64ClockPosition;
 r.sequence64SubPulse();
 assert.equal(r.sequence64ClockPosition,clock);
 assert.equal(r.s.globalTransportRunning,1);
 assert.equal(r.s.editorWorkspace.enabled,0);
 assert.equal(r.s.editorWorkspace.active,false);
 assert.equal(r.s.editorWorkspace.pendingSceneLaunch,null);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_audio_arm'),false);
 for(const page of [1,2,3]) r.setKmod(page);
 const before=JSON.stringify(r.sessionRouterSnapshotObject());
 assert.equal(r.sessionApply(JSON.stringify({format:'mlr-session',rta:{patterns:{}}})),false);
 assert.equal(JSON.stringify(r.sessionRouterSnapshotObject()),before);
 assert.equal(r.sessionNew(),true);
 assert.equal(r.s.globalTransportRunning,0);
 assert.equal(r.s.editorWorkspace.sceneRuntimeReady,0);
});

test('disabling rta cancels queued launches and previews without stopping base transport or recorders', () => {
 const h=createSequence64Harness(),r=h.context;
 selectGroup(h,0);
 const p=r.currentSequence64Pattern();p.steps[0].cut={track:0,slice:2,gateLength:1};
 r.setSequence64TargetRunning('group',0,1);
 r.s.editorWorkspace.pendingSceneLaunch={type:'patterns',dueClock:1,patternRefs:{0:'group-pattern:0:0'}};
 r.s.sequencers[0].on=1;
 r.extendedEditors(0);
 assert.equal(p.running,0);
 assert.equal(r.s.editorWorkspace.pendingSceneLaunch,null);
 assert.equal(Object.keys(r.s.editorWorkspace.phraseInstances64).length,0);
 assert.equal(Object.keys(r.s.editorWorkspace.propertyStacks64).length,0);
 assert.equal(r.s.sequencers[0].on,1);
 assert.equal(r.s.globalTransportRunning,1);
 h.clearLog();
 r.hudTarget('group',0);r.hudTransport('run');r.sequence64SubPulse();
 assert.equal(r.s.editorWorkspace.active,false);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_audio_arm'),false);
 const reload=createSequence64Harness(h.globalStores);
 assert.equal(reload.context.s.editorWorkspace.enabled,0);
 assert.equal(reload.context.s.editorWorkspace.pendingSceneLaunch,null);
});

test('built MLR runs without optional source modules and retains base cuts, latches, loop divisions and mixer control', () => {
 const os=require('node:os');
 const {build}=require('../scripts/build_editions');
 const temp=fs.mkdtempSync(path.join(os.tmpdir(),'mlr-router-product-'));
 try {
  const dest=path.join(temp,'mlr');build('mlr',dest);
  const h=createHarness(undefined,'sequence64','mlr',dest),r=h.context;
  r.loadbang();r.sessionNew();r.setKmod(2);
  const before=r.getChannelStateByIndex(0).gateLatch;
  r.dispatch(0,4,1);r.dispatch(0,4,0);
  assert.equal(r.getChannelStateByIndex(0).gateLatch,before?0:1);
  const division=r.currentTrackSubLoopDiv(0);
  r.dispatch(11,1,1);r.dispatch(11,1,0);
  assert.notEqual(r.currentTrackSubLoopDiv(0),division);
  r.hudGroupVolume(0,115);r.hudGroupMute(0,1);
  assert.equal(r.getChannelStateByIndex(0).volume,115);
  assert.equal(r.getChannelStateByIndex(0).muted,1);
  assert.equal(r.hudGroupVolume(100,99),false);
  r.setKmod(1);h.clearLog();r.dispatch(3,1,1);r.dispatch(3,1,0);
  assert.ok(h.namedMessages.some(m=>m[0]==='2input'&&m[1]===3&&m[2]===1),'base cut goes to native MLR input');
  assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_audio_arm'),false);
 } finally {fs.rmSync(temp,{recursive:true,force:true});}
});

test('base MLR routes every grid cell on Main, Mod and Groups without creating scene runtime', () => {
 const h=createHarness(undefined,'sequence64','mlr'),r=h.context;
 r.loadbang();
 for(const page of [1,2,3]) {
  for(let y=0;y<16;y++)for(let x=0;x<16;x++) {
   r.setKmod(page);r.dispatch(x,y,1);r.dispatch(x,y,0);
  }
 }
 assert.equal(r.s.editorWorkspace.enabled,0);
 assert.equal(r.s.editorWorkspace.active,false);
 assert.equal(r.s.editorWorkspace.sceneRuntimeReady,0);
 assert.equal(h.namedMessages.some(m=>m[0]==='sequence64_audio_arm'),false);
});
