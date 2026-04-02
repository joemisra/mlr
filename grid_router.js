autowatch = 1;
inlets = 3;
outlets = 4;

/**
 * Central grid routing hub for mlr.
 *
 * Inlet 0: grid press events — list (col row state), 0-indexed monome coords.
 *          Receives from [r box/press] which carries raw serialosc (x y s).
 *          Also receives messages via [r gridrouter]:
 *            - boxled col row level          (playback head LED from [p chnls])
 *            - boxledrow row lev0 lev1 ...   (full row LED update)
 *            - volumeUpdate ch val           (sync from output.maxpat)
 *            - muteUpdate ch val             (sync from output.maxpat)
 *            - handleOldPatternOut ch col row (pattern replay LED)
 *            - edition 64|128|256            (grid size)
 *            - clear_automation              (reset automation state)
 * Inlet 1: kmod value — int from [r kmod]
 * Inlet 2: clock tick — bang from [r tr_pulse] for automation sync
 *
 * Outlet 0: raw grid triple (col, row, state) — same order as [r box/press] into
 *           [p box] unpack, so [s grid_router_playback] can replace the old receive.
 * Outlet 1: LED setcell commands for grid_matrix_io (setcell x y level)
 * Outlet 2: status / automation events
 * Outlet 3: keyframe commands for anim engine
 *
 * kmod values: 1 = normal (cut/pattern), 2 = mod page, 3 = groups page,
 *              4 = reserved (step sequencer)
 *
 * Normal mode (kmod 1): playback head LEDs from box/led are forwarded as setcell.
 *   This replaces the old [p switcher] path (r mlrpageled → constrain → setcell).
 *
 * Mod page (kmod 2), cols 0–7: row 0 mutes, rows 1–2 vol up/down (brightness = level),
 * rows 4–15 = insert-FX placeholders (no audio wiring yet).
 * Col 8: row 0 randomize all channels ([ch]randomfun); rows 1+ per-track (#[box]rnd).
 * Col 9: automation (play r1, loop r2, length r3–6, arm r7); recording anim col 8 r2–15;
 * playback progress col 9 r8–14.
 *
 * All sends use messnamed() to existing [r ...] buses so downstream patches
 * (pl, output, pattern, etc.) keep working without rewiring.
 */

// ─── State ──────────────────────────────────────────────────────────────

class Sequencer {
	constructor(channel) {
		this.channel = channel;
		this.on = 0;
		this.last = 0;
		this.phase = 0;
	}
}

class SamplePlayer {
	constructor(channel) {
		this.channel = channel;
		this.sampleIndex = 0;
		this.offset = 0;
		this.offset_state = 0;
	}
}

class mlrChannel {
	constructor(channel) {
		this.channel = channel;
		this.sampler = new SamplePlayer(channel);
		this.muted = 0;
		this.volume = 100;
		this.pattern = 0;
		this.quantize = 0;
		this.timestretch = 0;
		this.doubleTime = 0;
		this.halfTime = 0;
		this.on = 0;
	}
}

class mlrTrack {
	constructor(track) {
		this.track = track;
		this.channel = 8;
		this.randomOffset = 0;
		this.session = 0;
		this.buffer = 0;
		this.octave = 0;
		this.reverse = 0;
	}
}

var s = new Global("mlr");

if (!s.initialized) {
	s.dual128Mode = 0;
	s.gridports = [0, 0];
	s.prefix = "/box";
	s.kmod = 1;
	s.edition = 256;
	s.gridWidth = 16;
	s.gridHeight = 16;
	s.NUM_CHANNELS = 8;
	s.NUM_TRACKS = 15;
	s.MAX_SAMPLES = 128;
	s.sequencers = Array.from({ length: 8 }, (_, i) => new Sequencer(i));
	s.channels = Array.from({ length: 8 }, (_, i) => new mlrChannel(i));
	s.tracks = Array.from({ length: 15 }, (_, i) => new mlrTrack(i));
	s.automation = {
		armed: false,
		recording: false,
		playing: false,
		looping: false,
		events: [],
		tick: 0,
		startTick: 0,
		length: 128,
		playHead: 0
	};
	s.initialized = true;
}

/** Guard flag: true while automation playback is dispatching events. */
var playbackDispatching = false;

/** Insert FX placeholder: cols 0–7 × rows 4–15 (96 cells). */
var insert_fx = new Array(8 * 12).fill(0);

function insertFxIndex(col, row) {
	return col * 12 + (row - 4);
}

/** Local octave hint per track row (for LED on col 13/14); not synced from DSP. */
if (!s.octave_hint) s.octave_hint = new Array(16).fill(0);

/** Last mod-page picks for right-side columns (redraw after overlay clear). */
var modQuantizeRow = 0;
var modSessionRow = 0;
var modBufferRow = 0;

var animBrightness = 0;
var animTask = new Task(animateLeds, this);
animTask.interval = 80;

// ─── Helpers ────────────────────────────────────────────────────────────

function clamp(v, lo, hi) {
	return Math.min(hi, Math.max(lo, v));
}

function postln(msg) {
	post(msg + "\n");
}

function led(x, y, level) {
	outlet(1, "setcell", x, y, clamp(level | 0, 0, 15));
}

function led_bg(x, y, level) {
	outlet(1, "setcell_bg", x, y, clamp(level | 0, 0, 15));
}

function clear_bg() {
	outlet(1, "clear_bg");
}

function kfping(x, y, level) {
	outlet(3, "kf", x, y, level, 1, 0, 20);
}

function clear() {
	messnamed("togridmatrixio", "clear");
	messnamed("togridmatrixanim", "clear_anim");
}

function ledRow(y, level) {
	for (var x = 0; x < s.gridWidth; x++) {
		led(x, y, level);
	}
}

function ledCol(x, level) {
	for (var y = 0; y < s.gridHeight; y++) {
		led(x, y, level);
	}
}

function volToBrightness(vol) {
	return clamp(Math.round(vol * 15 / 158), 0, 15);
}

/** Row 1 vol-up: brighter; row 2 vol-down: dimmer readout of same level. */
function volBrightnessUp(col) {
	return volToBrightness(s.channels[col].volume);
}

function volBrightnessDown(col) {
	return clamp(Math.round(volBrightnessUp(col) * 0.45), 0, 15);
}

function setVolume(col, vol) {
	s.channels[col].volume = vol;
	updateVolumeDisplay(col);
}

// ─── Entry Points ───────────────────────────────────────────────────────

function loadbang() {
	post("[grid_router] ready — kmod=" + s.kmod + " edition=" + s.edition + "\n");
}

function msg_int(a) {
	post("[grid_router] msg_int " + a + "\n");
	if (inlet === 1) {
		setKmod(a);
	} else if (inlet === 2) {
		clockTick();
	}
}

function bang() {
	if (inlet === 2) {
		clockTick();
	}
}

function list() {
	if (inlet === 0) {
		var a = arrayfromargs(arguments);
		if (a.length >= 3) {
			dispatch(
				parseInt(a[0], 10),
				parseInt(a[1], 10),
				parseInt(a[2], 10)
			);
		}
	}
}

function key() {
	dispatch(
		parseInt(arguments[0], 10),
		parseInt(arguments[1], 10),
		parseInt(arguments[2], 10)
	);
}

// ─── kmod ───────────────────────────────────────────────────────────────

const sequpdate = function (idx, on) {
	messnamed(idx + "pp", on);
	led(idx + 8, 0, on ? 10 : 0);
};
s.sequpdate = sequpdate;

function setKmod(val) {
	if (val !== s.kmod) {
		var prev = s.kmod;
		s.kmod = val;
		onKmodChange(prev, s.kmod);
	}
}

function onKmodChange(prev, next) {
	post("[grid_router] kmod " + prev + " -> " + next + "\n");

	messnamed("togridmatrixio", "clear");
	messnamed("kmod", s.kmod);

	// Kmod page indicators: [col, brightness]
	var kmodIndicators = [
		[15, 0],   // kmod 1 - no indicator
		[15, 15],  // kmod 2 - mod overlay
		[14, 10],  // kmod 3 - group/channel assign overlay
		[14, 15]   // kmod 4 - step sequencer overlay
	];

	if (next >= 1 && next <= kmodIndicators.length) {
		led(kmodIndicators[next - 1][0], 0, kmodIndicators[next - 1][1]);
	}

	switch (next) {
		case 1: drawMainPage(); break;
		case 2: drawModPage(); break;
		case 3: drawGroupsPage(); break;
		case 4: break;
	}
}

// ─── Main Dispatch ──────────────────────────────────────────────────────

function dispatch(col, row, state) {
	if (isNaN(col) || isNaN(row) || isNaN(state)) return;
	col = clamp(col, 0, s.gridWidth - 1);
	row = clamp(row, 0, s.gridHeight - 1);
	state = state ? 1 : 0;

	if (s.automation.recording && state === 1 && !playbackDispatching) {
		recordEvent(col, row, state);
	}

	if (row === 0) {
		handleRow0(col, state);
		return;
	}

	switch (s.kmod) {
		case 1: handleNormalMode(col, row, state); break;
		case 2: handleModPage(col, row, state); break;
		case 3: handleGroupsPage(col, row, state); break;
		case 4: handleStepSeqPage(col, row, state); break;
	}
}

// ─── Row 0 (top row) ───────────────────────────────────────────────────

function handleRow0(col, state) {
	if (state !== 1) return;
	if (col < 8) {
		handleRow0Channel(col);
	} else if (col <= 11) {
		// Pattern recorders (cols 8–11): only active in normal mode.
		if (s.kmod === 1) handlePatternRecorder(col - 8);
		// In kmod 2, col 8 row 0 = randomize all (handled below).
		if (s.kmod === 2 && col === 8) {
			messnamed("[ch]randomfun", 1);
			kfping(8, 0, 6);
		}
	} else if (col === 14) {
		setKmod(s.kmod !== 3 ? 3 : 4); // groups page toggle
	} else if (col === 15) {
		setKmod(s.kmod !== 1 ? 1 : 2); // mod page toggle
	}
}

function handleRow0Channel(col) {
	var ch = col + 1;
	if (s.kmod === 1) {
		messnamed(ch + "[pl]stop", 1);
		outlet(0, col, 0, 1);
	} else if (s.kmod === 2) {
		handleModMute(col);
	}
}

function handlePatternRecorder(idx) {
	if (s.kmod !== 1) return;
	idx = idx | 0;
	if (s.sequencers[idx].on === 1) {
		s.sequencers[idx].on = 0;
		messnamed(idx + "pp", s.sequencers[idx].on);
		led(idx + 8, 0, 0);
		outlet(2, "pattern", idx, 0, "off");
	} else {
		s.sequencers[idx].on = 1;
		messnamed(idx + "pp", 1);
		led(idx + 8, 0, 10);
		outlet(2, "pattern", idx, 1, "on");
	}
}

// ─── Normal Mode (kmod 1) ──────────────────────────────────────────────

function handleNormalMode(col, row, state) {
	messnamed((row + 1) + "input", col, state);
}

// ─── Mod Page (kmod 2) ─────────────────────────────────────────────────

function handleTimestretchToggle(col) {
	if (s.kmod !== 2) return;
	var ch = col + 1;
	s.channels[col].timestretch = 1 - s.channels[col].timestretch;
	messnamed(ch + "[ch]timestretch", s.channels[col].timestretch ? 1 : 0);
	led(col, 3, s.channels[col].timestretch ? 15 : 0);
}

function handleModPage(col, row, state) {
	if (state !== 1) return;

	if (col < 8) {
		if (row === 0) {
			handleModMute(col);
		} else if (row === 1 || row === 2) {
			handleModVolume(col, row);
		} else if (row === 3) {
			handleTimestretchToggle(col);
		}
	} else if (col === 8) {
		handleModRandomize(row);
	} else if (col === 9) {
		handleAutomationControl(row);
	} else if (col === 10 && row >= 1 && row <= 5) {
		handleQuantize(row);
	} else if (col === 11 && row >= 1 && row <= 8) {
		handleSessionLoad(row);
	} else if (col === 12 && row >= 1) {
		handleModRandomOffset(row);
	} else if (col === 13 && row >= 1) {
		handleHalfTime(row);
	} else if (col === 14 && row >= 1) {
		handleDoubleTime(row);
	} else if (col === 15 && row >= 1) {
		handleReverse(row);
	}
}

/** Col 8 mod page: row 0 = randomize all channels; rows 1+ = per-track only. */
function handleModRandomize(row) {
	if (s.kmod !== 2) return;
	if (row === 0) {
		messnamed("[ch]randomfun", 1);
		kfping(8, 0, 6);
		return;
	}
	var trackId = row + 1;
	messnamed(trackId + "[box]rnd", 1);
	//led(8, row, 15);
	kfping(8, row, 6);
}

function handleInsertFxToggle(col, row) {
	if (s.kmod !== 2) return;
	var ix = insertFxIndex(col, row);
	insert_fx[ix] = 1 - insert_fx[ix];
	led(col, row, insert_fx[ix] ? 12 : 0);
	outlet(2, "insert_fx", col, row, insert_fx[ix]);
}

function handleModMute(col) {
	if (s.kmod !== 2) return;
	s.channels[col].muted = s.channels[col].muted ? 0 : 1;
	messnamed((col + 1) + "[box]mute", s.channels[col].muted);
	drawMuteRow();
}

function handleModVolume(col, row) {
	if (s.kmod !== 2) return;
	var delta = (row === 1) ? 4 : -4;
	messnamed((col + 1) + "vol_add", delta);
	s.channels[col].volume = clamp(s.channels[col].volume + delta, 0, 158);
	updateVolumeDisplay(col);
}

function handleQuantize(row) {
	if (s.kmod !== 2) return;
	var qValues = { 1: 32, 2: 16, 3: 8, 4: 4, 5: 2 };
	var qVal = qValues[row];
	if (qVal !== undefined) {
		messnamed("[mlr]q", qVal);
		modQuantizeRow = row;
		drawQuantizeColumn();
		post("[grid_router] quantize=" + qVal + "\n");
	}
}

function handleSessionLoad(row) {
	if (s.kmod !== 2) return;
	messnamed("loadSel", row);
	modSessionRow = row;
	drawSessionColumn();
}

function handleModRandomOffset(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	s.tracks[track].randomOffset = 1 - s.tracks[track].randomOffset;
	messnamed((row + 1) + "[box]rndOff", s.tracks[track].randomOffset);
	drawModPage();
}

function handleHalfTime(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	messnamed((row + 1) + "[box]dwnOct", 1);
	s.tracks[track].octave--;
	drawOctaveCell(row);
}

function handleDoubleTime(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	messnamed((row + 1) + "[box]upOct", 1);
	s.tracks[track].octave++;
	drawOctaveCell(row);
}

function handleReverse(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	s.tracks[track].reverse = 1 - s.tracks[track].reverse;
	messnamed((row + 1) + "[box]rev", s.tracks[track].reverse);
	drawModPage();
}

// ─── Groups Page (kmod 3) ──────────────────────────────────────────────

function handleGroupsPage(col, row, state) {
	if (state !== 1 || col > 7 || row < 1) return;
	var track = row - 1;
	var channelId = col + 1;
	messnamed((row + 1) + "chn", channelId);
	s.tracks[track].channel = channelId;
	drawGroupsPage();
}

// ─── Step Sequencer Page (kmod 4, reserved) ─────────────────────────────

function handleStepSeqPage(col, row, state) {
	outlet(2, "stepseq", col, row, state);
}

// ─── Draw Functions ─────────────────────────────────────────────────────

function drawModPage() {
	drawMuteRow();
	drawVolumeRows();
	drawInsertFxBlock();
	drawRandomizeColumn();
	drawAutomationColumn();
	drawQuantizeColumn();
	drawSessionColumn();
	drawRandomOffsetColumn();
	drawOctaveColumns();
	drawReverseColumn();
	drawTimestretchRow();
}

function drawTimestretchRow() {
	for (var x = 0; x < 8; x++) {
		led(x, 3, s.channels[x].timestretch ? 15 : 0);
	}
}

function drawMainPage() {
	drawChannelsPlaying();
	drawSequencers();
}

function drawSequencers() {
	if (s.kmod !== 1) return;
	for (var x = 0; x < 4; x++) {
		led(x + 8, 0, s.sequencers[x].on ? 10 : 0);
	}
}

function drawMuteRow() {
	if (s.kmod === 2) {
		for (var x = 0; x < 8; x++) {
			led(x, 0, s.channels[x].muted ? 0 : 15);
		}
	} else if (s.kmod === 1) {
		drawChannelsPlaying();
	}
}

function drawVolumeRows() {
	for (var x = 0; x < 8; x++) {
		led(x, 1, volBrightnessUp(x));
		led(x, 2, volBrightnessDown(x));
	}
}

function updateVolumeDisplay(col) {
	led(col, 1, volBrightnessUp(col));
	led(col, 2, volBrightnessDown(col));
}

function drawInsertFxBlock() {
	for (var x = 0; x < 8; x++) {
		for (var y = 4; y < s.gridHeight; y++) {
			led(x, y, insert_fx[insertFxIndex(x, y)] ? 12 : 0);
		}
	}
}

function drawRandomizeColumn() {
	led(8, 0, 6);
	for (var y = 1; y < s.gridHeight; y++) {
		led(8, y, 2);
	}
}

function drawGroupsPage() {
	for (var y = 1; y < s.gridHeight; y++) {
		led(8 + s.tracks[y - 1].channel, y, 15);
	}
}

function drawAutomationColumn() {
	led(9, 1, s.automation.playing ? 15 : 0);
	led(9, 2, s.automation.looping ? 15 : 0);
	var lenToRow = { 32: 3, 64: 4, 128: 5, 256: 6 };
	var selRow = lenToRow[s.automation.length] || 5;
	for (var y = 3; y <= 6; y++) {
		led(9, y, y === selRow ? 15 : 0);
	}
	if (s.automation.recording) {
		led(9, 7, 15);
	} else if (s.automation.armed) {
		led(9, 7, 8);
	} else {
		led(9, 7, s.automation.events.length > 0 ? 4 : 0);
	}
}

function drawQuantizeColumn() {
	for (var y = 1; y <= 5; y++) {
		led(10, y, y === modQuantizeRow ? 15 : 0);
	}
}

function drawSessionColumn() {
	for (var y = 1; y <= 8; y++) {
		led(11, y, y === modSessionRow ? 15 : 0);
	}
}

function drawRandomOffsetColumn() {
	for (var y = 1; y < s.gridHeight; y++) {
		led(12, y, s.tracks[y - 1].randomOffset ? 15 : 0);
	}
}

function drawOctaveColumns() {
	for (var y = 1; y < s.gridHeight; y++) {
		drawOctaveCell(y);
	}
}

function drawOctaveCell(row) {
	if (row < 1) return;
	var h = s.tracks[row - 1].octave;
	var dir = h > 0 ? 2 : -2;
	led(13, row, clamp(dir < 0 ? 4 - h : 4, 4, 15));
	led(14, row, clamp(dir > 0 ? 4 + h : 4, 4, 15));
}

function drawReverseColumn() {
	for (var y = 1; y < s.gridHeight; y++) {
		led(15, y, s.tracks[y - 1].reverse ? 15 : 0);
	}
}

// ─── LED Updates from Audio Engine ──────────────────────────────────────

/**
 * volumeUpdate ch val — receive actual volume from audio engine.
 * ch is 1-indexed. Send "volumeUpdate <ch 1-8> <val 0-158>" to inlet 0.
 */
function volumeUpdate() {
	var ch = parseInt(arguments[0], 10);
	var val = parseInt(arguments[1], 10);
	if (ch >= 1 && ch <= 8) {
		s.channels[ch - 1].volume = clamp(val, 0, 158);
		if (s.kmod === 2) updateVolumeDisplay(ch - 1);
	}
}

/**
 * muteUpdate ch val — sync muted[] from output patch / [box]mute.
 * val: 1 = muted, 0 = unmuted.
 */
function muteUpdate() {
	var ch = parseInt(arguments[0], 10);
	var val = parseInt(arguments[1], 10);
	if (ch >= 1 && ch <= 8) {
		s.channels[ch - 1].muted = val ? 1 : 0;
	}
	if (s.kmod === 2) drawMuteRow();
}

function handleOldPatternOut() {
	var col = parseInt(arguments[1], 10);
	var row = parseInt(arguments[2], 10) - 1;
	if (s.kmod !== 1) return;
	// Flash the played cell. Channel on/off row-0 LEDs are managed separately
	// by handleChannelOnArray — don't redraw the whole row on every pattern step.
	kfping(col, row, 10);
}

function drawChannelsPlaying() {
	if (s.kmod !== 1) return;
	for (var i = 0; i < 8; i++) {
		led(i, 0, s.channels[i].on ? 15 : 0);
	}
	// Sequencer buttons use brightness 10 — matches handlePatternRecorder and drawSequencers.
	for (var j = 0; j < 4; j++) {
		led(j + 8, 0, s.sequencers[j].on ? 10 : 0);
	}
}

s.drawChannelsPlaying = drawChannelsPlaying;

function handleChannelOnArray() {
	for (var i = 0; i < 8; i++) {
		s.channels[i].on = arguments[i];
	}
	drawChannelsPlaying();
}

function handleSeqOnArray() {
	// placeholder
}

// ─── Normal-mode LED bridge (replaces [p switcher]) ────────────────────

/**
 * boxled col row level — playback position LED from [s box/led].
 * Writes to the background plane so positions show as minimum brightness,
 * visible beneath foreground overlays and animations.
 */
function boxled() {
	var col = clamp(parseInt(arguments[0], 10), 0, s.gridWidth - 1);
	var row = clamp(parseInt(arguments[1], 10), 0, s.gridHeight - 1);
	var level = clamp(parseInt(arguments[2], 10), 0, 15);
	led_bg(col, row, level);
}

/**
 * boxledrow row col0_level col1_level ... — full row background update
 * from [s box/led_row]. Writes to background plane.
 */
function boxledrow() {
	var row = clamp(parseInt(arguments[0], 10), 0, s.gridHeight - 1);
	for (var x = 1; x < arguments.length && (x - 1) < s.gridWidth; x++) {
		led_bg(x - 1, row, clamp(parseInt(arguments[x], 10), 0, 15));
	}
}

/**
 * boxledcol col row0_level row1_level ... — full column background update
 * from [s box/led_col]. Writes to background plane.
 */
function boxledcol() {
	var col = clamp(parseInt(arguments[0], 10), 0, s.gridWidth - 1);
	for (var y = 1; y < arguments.length && (y - 1) < s.gridHeight; y++) {
		led_bg(col, y - 1, clamp(parseInt(arguments[y], 10), 0, 15));
	}
}

// ─── Automation Recording ───────────────────────────────────────────────

function handleAutomationArm(row) {
	if (row !== 7) return;
	if (s.automation.recording) {
		stopRecording();
		return;
	}
	s.automation.armed = !s.automation.armed;
	drawAutomationColumn();
	post("[grid_router] automation " + (s.automation.armed ? "armed" : "disarmed") + "\n");
}

/**
 * Col 9 automation rows: 1=play/stop, 2=loop toggle, 3–6=length, 7=arm/record.
 */
function handleAutomationControl(row) {
	if (row === 1) {
		if (s.automation.playing) {
			stopPlayback();
		} else if (s.automation.events.length > 0) {
			startPlayback();
		}
		drawAutomationColumn();
	} else if (row === 2) {
		s.automation.looping = !s.automation.looping;
		drawAutomationColumn();
		post("[grid_router] automation loop=" + s.automation.looping + "\n");
	} else if (row >= 3 && row <= 6) {
		var bars = { 3: 1, 4: 2, 5: 4, 6: 8 };
		s.automation.length = (bars[row] || 4) * 32;
		drawAutomationColumn();
		post("[grid_router] automation length=" + s.automation.length + " ticks\n");
	} else if (row === 7) {
		handleAutomationArm(row);
	}
}

function recordEvent(col, row, state) {
	if (!s.automation.recording && s.automation.armed) {
		s.automation.recording = true;
		s.automation.startTick = s.automation.tick;
		s.automation.events = [];
		post("[grid_router] automation recording started\n");
	}
	if (s.automation.recording) {
		var tickOffset = s.automation.tick - s.automation.startTick;
		if (tickOffset >= s.automation.length) {
			stopRecording();
			return;
		}
		s.automation.events.push({ tick: tickOffset, col: col, row: row, state: state });
	}
}

function stopRecording() {
	s.automation.recording = false;
	s.automation.armed = false;
	clearAnimRange(8, 2, 15);
	drawRandomizeColumn();
	drawAutomationColumn();
	post("[grid_router] recorded " + s.automation.events.length + " events\n");
	outlet(2, "automation_recorded", s.automation.events.length);
}

function startPlayback() {
	s.automation.playing = true;
	s.automation.playHead = 0;
	clearAnimRange(9, 8, 14);
	drawAutomationColumn();
	post("[grid_router] automation playback started\n");
}

function stopPlayback() {
	s.automation.playing = false;
	clearAnimRange(9, 8, 14);
	drawAutomationColumn();
	post("[grid_router] automation playback stopped\n");
}

function clearAnimRange(x, y0, y1) {
	for (var y = y0; y <= y1; y++) {
		led(x, y, 0);
	}
}

function clockTick() {
	if (!s.initialized) return;
	s.automation.tick++;
	if (!s.automation.playing || s.automation.events.length === 0) return;

	var tickInLoop = s.automation.playHead % s.automation.length;
	playbackDispatching = true;
	for (var i = 0; i < s.automation.events.length; i++) {
		var ev = s.automation.events[i];
		if (ev.tick === tickInLoop) dispatch(ev.col, ev.row, ev.state);
	}
	playbackDispatching = false;

	s.automation.playHead++;
	if (s.automation.playHead >= s.automation.length) {
		if (s.automation.looping) {
			s.automation.playHead = 0;
		} else {
			stopPlayback();
		}
	}
}

// ─── Recording LED Animation ───────────────────────────────────────────

function animateLeds() {
	animBrightness = (animBrightness >= 15) ? 5 : animBrightness + 1;

	if (s.automation.recording && s.kmod === 2) {
		for (var y = 2; y < s.gridHeight; y++) {
			led(8, y, animBrightness);
		}
	}

	if (s.automation.playing && s.kmod === 2) {
		var span = 7;
		var progress = Math.min(
			Math.floor((s.automation.playHead / s.automation.length) * span),
			span - 1
		);
		for (var yy = 8; yy <= 14; yy++) {
			led(9, yy, (yy - 8) <= progress ? 8 : 2);
		}
	}
}

// ─── Message Router ────────────────────────────────────────────────────

function clear_automation() {
	s.automation.events = [];
	s.automation.armed = false;
	s.automation.recording = false;
	s.automation.playing = false;
	clearAnimRange(8, 2, 15);
	clearAnimRange(9, 8, 14);
	if (s.kmod === 2) {
		drawRandomizeColumn();
		drawAutomationColumn();
	}
	post("[grid_router] automation cleared\n");
}

// Only messages without dedicated handlers reach anything():
// "edition" (no named function), "channelOnArray"/"seqOnArray" (name mismatch),
// and "/grid/key" (JS function names can't start with /).
function anything() {
	var args = arrayfromargs(arguments);
	switch (messagename) {
		case "edition":
			if (!args.length) break;
			var e = parseInt(args[0], 10);
			if (e === 64 || e === 128 || e === 256) {
				s.edition = e;
				var dims = { 64: [8, 8], 128: [16, 8], 256: [16, 16] };
				s.gridWidth = dims[e][0];
				s.gridHeight = dims[e][1];
				post("[grid_router] edition=" + s.edition + " grid=" + s.gridWidth + "x" + s.gridHeight + "\n");
			}
			break;
		case "channelOnArray":
			handleChannelOnArray.apply(this, args);
			break;
		case "seqOnArray":
			handleSeqOnArray.apply(this, args);
			break;
		case "/grid/key":
			if (args.length >= 3) dispatch(parseInt(args[0], 10), parseInt(args[1], 10), parseInt(args[2], 10));
			break;
	}
}
