autowatch = 1;
inlets = 3;
outlets = 3;

/**
 * Central grid routing hub for mlr.
 *
 * Inlet 0: grid press events — list (col row state), 0-indexed monome coords
 *          Receives from [r box/press] which carries raw serialosc (x y s).
 * Inlet 1: kmod value — int from [r kmod]
 * Inlet 2: clock tick — bang from [r tr_pulse] for automation sync
 *
 * Outlet 0: raw grid triple (col, row, state) — same order as [r box/press] into
 *          [p box] unpack, so [s grid_router_playback] can replace the old receive.
 * Outlet 1: LED setcell commands for grid_matrix_io (setcell x y level)
 * Outlet 2: status / automation events
 *
 * kmod values: 1 = normal (cut/pattern), 2 = mod page, 3 = groups page,
 *              4 = reserved (step sequencer)
 *
 * Mod page (kmod 2), cols 0–7: row 0 mutes, rows 1–2 vol up/down (brightness = level),
 * rows 4–15 = insert-FX placeholders (no audio wiring yet).
 * Col 8: row1 randomize all channels ([mlr]randomfun); rows 2–15 per-track (#[box]rnd).
 * Col 9: automation (play r1, loop r2, length r3–6, arm r7); recording anim col 8 r2–15;
 * playback progress col 9 r8–14.
 *
 * All sends use messnamed() to existing [r ...] buses so downstream patches
 * (pl, output, pattern, etc.) keep working without rewiring.
 */

// ─── State ──────────────────────────────────────────────────────────────

var kmod = 1;
var edition = 256;

var NUM_CHANNELS = 8;
var NUM_TRACKS = 15; // rows 1-15


var muted = [0, 0, 0, 0, 0, 0, 0, 0];
var volumes = [100, 100, 100, 100, 100, 100, 100, 100]; // 0-158
var reverse_toggles = new Array(16).fill(0);
var pattern_states = [0, 0, 0, 0]; // 4 pattern recorders on cols 8-11

/** Insert FX placeholder: cols 0–7 × rows 4–15 (96 cells). */
var insert_fx = new Array(8 * 12).fill(0);

function insertFxIndex(col, row) {
	return col * 12 + (row - 4);
}

/** Local octave hint per track row (for LED on col 13/14); not synced from DSP. */
var octave_hint = new Array(16).fill(0);

/** Last mod-page picks for right-side columns (redraw after overlay clear). */
var modQuantizeRow = 0;
var modSessionRow = 0;
var modBufferRow = 0;

// Automation recorder
var automation = {
	armed: false,
	recording: false,
	playing: false,
	looping: false,
	events: [],
	tick: 0,
	startTick: 0,
	length: 128, // clock ticks (default ~4 bars at 32 ticks/bar)
	playHead: 0
};

var animBrightness = 0;
var animTask = new Task(animateLeds, this);
animTask.interval = 80;

// ─── Helpers ────────────────────────────────────────────────────────────

function clamp(v, lo, hi) {
	return Math.min(hi, Math.max(lo, v));
}

function led(x, y, level) {
	// this output connects to [s gridmatrixio] which goes to 1st inlet of [p grid_matrix_io]
	outlet(1, "setcell", x, y, clamp(level | 0, 0, 15));
}

function ledRow(y, level) {
	for (var x = 0; x < 16; x++) {
		led(x, y, level);
	}
}

function ledCol(x, level) {
	for (var y = 0; y < 16; y++) {
		led(x, y, level);
	}
}

function volToBrightness(vol) {
	return clamp(Math.round(vol * 15 / 158), 0, 15);
}

/** Row2 vol-up: brighter; row3 vol-down: dimmer readout of same level. */
function volBrightnessUp(col) {
	return volToBrightness(volumes[col]);
}

function volBrightnessDown(col) {
	return clamp(Math.round(volBrightnessUp(col) * 0.45), 0, 15);
}
function setVolume(col, vol) {
	volumes[col] = vol;
	updateVolumeDisplay(col);
}

// ─── Entry Points ───────────────────────────────────────────────────────

function loadbang() {
	post("[grid_router] ready — kmod=" + kmod + " edition=" + edition + "\n");
}

function msg_int(a) {
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

function setKmod(val) {
	var prev = kmod;
	kmod = val;
	if (prev !== kmod) {
		onKmodChange(prev, kmod);
	}
}

function onKmodChange(prev, next) {
	// Log kmod state change
	post("[grid_router] kmod " + prev + " -> " + next + " (" + kmod + ")\n");

	// Always clear the grid when changing modes
	messnamed("togridmatrixio", "clear");
	messnamed("togridmatrixio", "flush");

	// Kmod page indicators: [col, brightness]
	var kmodIndicators = [
		[15, 0],   // kmod 1 - no indicator
		[15, 15],  // kmod 2 - mod overlay indicator
		[14, 10],  // kmod 3 - group/channel assign overlay
		[14, 15]   // kmod 4 - step sequencer overlay
	];

	// Show indicator for the current kmod (if next is valid)
	if (next >= 1 && next <= kmodIndicators.length) {
		var idx = next - 1;
		led(kmodIndicators[idx][0], 0, kmodIndicators[idx][1]);
	}

	// Kmod-specific setup/teardown
	switch (next) {
		case 1:
			// Return to normal mode: clear overlay indicators, stop anim
			led(14, 0, 0);
			led(15, 0, 0);
			animTask.cancel();
			break;
		case 2:
			// Enter Mod Page overlay: draw UI, start anim
			drawModPage();
			animTask.repeat();
			break;
		case 3:
			// Enter Groups/Channel Assign overlay:
			// UI is handled elsewhere
			break;
		case 4:
			// Enter Step Sequencer overlay:
			// UI is handled elsewhere
			break;
	}
}

// ─── Main Dispatch ──────────────────────────────────────────────────────

function dispatch(col, row, state) {
	if (isNaN(col) || isNaN(row) || isNaN(state)) return;
	col = clamp(col, 0, 15);
	row = clamp(row, 0, 15);
	state = state ? 1 : 0;

	if (automation.recording && state === 1) {
		recordEvent(col, row, state);
	}

	if (row === 0) {
		handleRow0(col, state);
		return;
	}

	switch (kmod) {
		case 1: handleNormalMode(col, row, state); break;
		case 2: handleModPage(col, row, state); break;
		case 3: handleGroupsPage(col, row, state); break;
		case 4: handleStepSeqPage(col, row, state); break;
	}
}

// ─── Row 0 (top row) ───────────────────────────────────────────────────

function handleRow0(col, state) {
	if (col < 8) {
		if (state !== 1) return;
		handleRow0Channel(col);
	} else if (col >= 8 && col <= 11) {
		if (state !== 1) return;
		handlePatternRecorder(col - 8);
	} else if (col === 12) {
		if (state !== 1) return;
		messnamed("prevPreset", 1);
	} else if (col === 13) {
		if (state !== 1) return;
		messnamed("nextPreset", 1);
	} else if (col === 14) {
		// Groups page — momentary (hold = kmod 3, release = kmod 1)
		/*
		if (state === 1) {
			messnamed("kmod", 3);
		} else {
			messnamed("kmod", 1);
		}
		*/
		if (state === 1) {
			messnamed("kmod", kmod === 3 ? 1 : 3);
		}
	} else if (col === 15) {
		// Mod page — toggle between 1 and 2
		if (state === 1) {
			messnamed("kmod", kmod === 2 ? 1 : 2);
		}
	}
}

function handleRow0Channel(col) {
	var ch = col + 1;
	if (kmod === 1) {
		messnamed(ch + "[pl]stop", 1);
		outlet(0, col, 0, 1);
	} else if (kmod === 2) {
		handleModMute(col);
		// kmod 2: mutes on mod page row 1 (Phase 2)
		post("[grid_router] handleRow0Channel " + col + " " + kmod + "\n");
	}
}

function handlePatternRecorder(idx) {
	pattern_states[idx] = 1 - pattern_states[idx];
	messnamed(idx + "pp", pattern_states[idx]);
	led(idx + 8, 0, pattern_states[idx] ? 15 : 0);
	outlet(2, "pattern", idx, pattern_states[idx]);
}

// ─── Normal Mode (kmod 1) ──────────────────────────────────────────────

function handleNormalMode(col, row, state) {
	outlet(0, col, row, state);
}

// ─── Mod Page (kmod 2) ─────────────────────────────────────────────────

function handleModPage(col, row, state) {
	if (state !== 1) return;

	if (col < 8) {
		if (row === 0) {
			handleModMute(col);
			return;
		}
		if (row === 1 || row === 2) {
			handleModVolume(col, row);
			return;
		}
		if (row >= 3) {
			handleInsertFxToggle(col, row);
			return;
		}
	} else if (col === 8) {
		handleModRandomize(row);
	} else if (col === 9) {
		handleAutomationControl(row);
	} else if (col === 10 && row >= 1 && row <= 5) {
		handleQuantize(row);
	} else if (col === 11 && row >= 1 && row <= 8) {
		handleSessionLoad(row);
	} else if (col === 12 && row >= 1 && row <= 8) {
		handleBufferSelect(row);
	} else if (col === 13 && row >= 1) {
		handleHalfTime(row);
	} else if (col === 14 && row >= 1) {
		handleDoubleTime(row);
	} else if (col === 15 && row >= 1) {
		handleReverse(row);
	}
}

/** Col 8 mod page: row 1 = all channels; rows 2–15 = track (row+1) only. */
function handleModRandomize(row) {
	var randRow = 0
	if (row === randRow) {
		messnamed("[mlr]randomfun", "bang");
		led(8, 1, 15);
		var t = new Task(function () { led(8, 1, 6); }, this);
		t.schedule(120);
		return;
	}
	if (row >= randRow + 1) {
		var trackId = row + 1;
		messnamed(trackId + "[box]rnd", 1);
		led(8, row, 15);
		var t2 = new Task(
			(function (rr) {
				return function () { led(8, rr, 2); };
			})(row),
			this
		);
		t2.schedule(120);
	}
}

function handleInsertFxToggle(col, row) {
	var ix = insertFxIndex(col, row);
	insert_fx[ix] = 1 - insert_fx[ix];
	led(col, row, insert_fx[ix] ? 12 : 0);
	outlet(2, "insert_fx", col, row, insert_fx[ix]);
}

function handleModMute(col) {
	var ch = col + 1;
	muted[col] = muted[col] ? 0 : 1;
	messnamed(ch + "[box]mute", muted[col]);
	if (kmod === 2) {
		drawMuteRow();
	}
}

function handleModVolume(col, row) {
	var volRow = 1;
	var ch = col + 1;
	if (row === volRow) {
		messnamed(ch + "vol_add", 4);
		volumes[col] = clamp(volumes[col] + 4, 0, 158);
		updateVolumeDisplay(col);
	} else if (row === volRow + 1) {
		messnamed(ch + "vol_add", -4);
		volumes[col] = clamp(volumes[col] - 4, 0, 158);
		updateVolumeDisplay(col);
	}
}

function handleQuantize(row) {
	var qValues = { 1: 32, 2: 16, 3: 8, 4: 4, 5: 2 };
	var qVal = qValues[row];
	if (qVal !== undefined) {
		messnamed("[mlr]q", qVal);
		modQuantizeRow = row;
		drawQuantizeColumn();
		post("[grid_router] quantize set to " + qVal + "\n");
	}
}

function handleSessionLoad(row) {
	// TODO: temp
	messnamed("loadSel", row);
	modSessionRow = row;
	drawSessionColumn();
}

function handleBufferSelect(row) {
	// TODO: temp
	messnamed("buffSel", row);
	modBufferRow = row;
	drawBufferColumn();
}

function handleHalfTime(row) {
	var trackId = row + 1;
	messnamed(trackId + "[box]dwnOct", 1);
	octave_hint[row]--;
	drawOctaveCell(row);
}

function handleDoubleTime(row) {
	var trackId = row + 1;
	messnamed(trackId + "[box]upOct", 1);
	octave_hint[row]++;
	drawOctaveCell(row);
}

function handleReverse(row) {
	var trackId = row + 1;
	reverse_toggles[row] = 1 - reverse_toggles[row];
	messnamed(trackId + "[box]rev", reverse_toggles[row]);
	led(15, row, reverse_toggles[row] ? 15 : 0);
}

// ─── Groups Page (kmod 3) ──────────────────────────────────────────────

function handleGroupsPage(col, row, state) {
	if (state !== 1 || col > 7 || row < 1) return;
	var trackId = row + 1;
	var channelId = col + 1;
	messnamed(trackId + "chn", channelId);
	// LED feedback: highlight selected channel on the right half
	for (var x = 0; x < 8; x++) {
		led(x + 8, row, x === col ? 15 : 0);
	}
}

// ─── Step Sequencer Page (kmod 4, reserved) ─────────────────────────────

function handleStepSeqPage(col, row, state) {
	outlet(2, "stepseq", col, row, state);
}

// ─── Varibright Volume Display (Phase 2) ────────────────────────────────

function drawModPage() {
	drawMuteRow();
	drawVolumeRows();
	drawInsertFxBlock();
	drawRandomizeColumn();
	drawAutomationColumn();
	drawQuantizeColumn();
	drawSessionColumn();
	drawBufferColumn();
	drawOctaveColumns();
	drawReverseColumn();
}

function drawMuteRow() {
	for (var x = 0; x < 8; x++) {
		led(x, 0, muted[x] ? 0 : 15);
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
	var x;
	var y;
	for (x = 0; x < 8; x++) {
		for (y = 4; y < 16; y++) {
			led(x, y, insert_fx[insertFxIndex(x, y)] ? 12 : 0);
		}
	}
}

function drawRandomizeColumn() {
	var y;
	led(8, 0, 6);
	for (y = 1; y < 16; y++) {
		led(8, y, 2);
	}
}

function drawAutomationColumn() {
	led(9, 1, automation.playing ? 15 : 0);
	led(9, 2, automation.looping ? 15 : 0);
	var lenToRow = { 32: 3, 64: 4, 128: 5, 256: 6 };
	var selRow = lenToRow[automation.length] || 5;
	var yy;
	for (yy = 3; yy <= 6; yy++) {
		led(9, yy, yy === selRow ? 15 : 0);
	}
	if (automation.recording) {
		led(9, 7, 15);
	} else if (automation.armed) {
		led(9, 7, 8);
	} else {
		led(9, 7, automation.events.length > 0 ? 4 : 0);
	}
}

function drawQuantizeColumn() {
	var y;
	for (y = 1; y <= 5; y++) {
		led(10, y, y === modQuantizeRow ? 15 : 0);
	}
}

function drawSessionColumn() {
	var y;
	for (y = 1; y <= 8; y++) {
		led(11, y, y === modSessionRow ? 15 : 0);
	}
}

function drawBufferColumn() {
	var y;
	for (y = 1; y <= 8; y++) {
		led(12, y, y === modBufferRow ? 15 : 0);
	}
}

function drawOctaveColumns() {
	var y;
	for (y = 1; y < 16; y++) {
		drawOctaveCell(y);
	}
}

function drawOctaveCell(row) {
	if (row < 1) {
		return;
	}
	var h = octave_hint[row];
	var downBright = h < 0 ? 15 : 4;
	var upBright = h > 0 ? 15 : 4;
	led(13, row, downBright);
	led(14, row, upBright);
}

function drawReverseColumn() {
	for (var y = 1; y < 16; y++) {
		led(15, y, reverse_toggles[y] ? 15 : 0);
	}
}

/**
 * Receive actual volume values from the audio engine.
 * Send "volumeUpdate <ch 1-8> <val 0-158>" to inlet 0.
 */
function volumeUpdate() {
	var ch = parseInt(arguments[0], 10);
	var val = parseInt(arguments[1], 10);
	if (ch >= 1 && ch <= 8) {
		volumes[ch - 1] = clamp(val, 0, 158);
		if (kmod === 2) {
			updateVolumeDisplay(ch - 1);
		}
	}
}

/**
 * Sync muted[] from the output patch mute button / [box]mute.
 * val matches pl: 1 = muted, 0 = unmuted (LED bright = unmuted).
 */
function muteUpdate() {
	var ch = parseInt(arguments[0], 10);
	var val = parseInt(arguments[1], 10);
	if (ch >= 1 && ch <= 8) {
		muted[ch - 1] = val ? 1 : 0;
	}
	if (kmod === 2) {
		drawMuteRow();
	}
}

function handleOldPatternOut() {
	var ch = parseInt(arguments[0], 10) - 1;
	var col = parseInt(arguments[1], 10);
	var row = parseInt(arguments[2], 10) - 1;

	post("handleOldPatternOut: channel " + (ch + 1) + " row " + row + " col " + col + "\n");
	if (kmod !== 1) return;

	ledRow(row, 0); // clear the row for this looper
	led(col, row, 15); // light up the button played
	led(ch, 0, 15); // highlight the active
	// flush
}
// ─── Automation Recording (Phase 3) ────────────────────────────────────

function handleAutomationArm(row) {
	if (row !== 7) return;
	if (automation.recording) {
		stopRecording();
		return;
	}
	automation.armed = !automation.armed;
	drawAutomationColumn();
	if (automation.armed) {
		post("[grid_router] automation armed\n");
	} else {
		post("[grid_router] automation disarmed\n");
	}
}

function handleAutomationControl(row) {
	var automationRow = 0;
	if (row === automationRow) {
		if (automation.playing) {
			stopPlayback();
		} else if (automation.events.length > 0) {
			startPlayback();
		}
		drawAutomationColumn();
	} else if (row === automationRow + 1) {
		automation.looping = !automation.looping;
		drawAutomationColumn();
		post("[grid_router] automation loop=" + automation.looping + "\n");
	} else if (row >= automationRow + 2 && row <= automationRow + 5) {
		var bars = { 3: 1, 4: 2, 5: 4, 6: 8 };
		automation.length = (bars[row] || 4) * 32;
		drawAutomationColumn();
		post("[grid_router] automation length=" + automation.length + " ticks\n");
	} else if (row === 7) {
		handleAutomationArm(row);
	}
}

function recordEvent(col, row, state) {
	if (!automation.recording && automation.armed) {
		automation.recording = true;
		automation.startTick = automation.tick;
		automation.events = [];
		post("[grid_router] automation recording started\n");
	}

	if (automation.recording) {
		var tickOffset = automation.tick - automation.startTick;
		if (tickOffset >= automation.length) {
			stopRecording();
			return;
		}
		automation.events.push({
			tick: tickOffset,
			col: col,
			row: row,
			state: state
		});
	}
}

function stopRecording() {
	automation.recording = false;
	automation.armed = false;
	clearAnimRange(8, 2, 15);
	drawRandomizeColumn();
	drawAutomationColumn();
	post("[grid_router] recorded " + automation.events.length + " events\n");
	outlet(2, "automation_recorded", automation.events.length);
}

function startPlayback() {
	automation.playing = true;
	automation.playHead = 0;
	clearAnimRange(9, 8, 14);
	drawAutomationColumn();
	post("[grid_router] automation playback started\n");
}

function stopPlayback() {
	automation.playing = false;
	clearAnimRange(9, 8, 14);
	drawAutomationColumn();
	post("[grid_router] automation playback stopped\n");
}

function clearAnimRange(x, y0, y1) {
	var y;
	for (y = y0; y <= y1; y++) {
		led(x, y, 0);
	}
}

function clockTick() {
	automation.tick++;

	if (!automation.playing || automation.events.length === 0) return;

	var tickInLoop = automation.playHead % automation.length;
	for (var i = 0; i < automation.events.length; i++) {
		var ev = automation.events[i];
		if (ev.tick === tickInLoop) {
			dispatch(ev.col, ev.row, ev.state);
		}
	}

	automation.playHead++;
	if (automation.playHead >= automation.length) {
		if (automation.looping) {
			automation.playHead = 0;
		} else {
			stopPlayback();
		}
	}
}

// ─── Recording LED Animation ───────────────────────────────────────────

function animateLeds() {
	animBrightness = (animBrightness >= 15) ? 5 : animBrightness + 1;

	if (automation.recording && kmod === 2) {
		for (var y = 2; y < 16; y++) {
			led(8, y, animBrightness);
		}
	}

	if (automation.playing && kmod === 2) {
		var span = 7;
		var progress = Math.floor((automation.playHead / automation.length) * span);
		if (progress > span - 1) {
			progress = span - 1;
		}
		for (var yy = 8; yy <= 14; yy++) {
			led(9, yy, (yy - 8) <= progress ? 8 : 2);
		}
	}
}

// ─── Message Router ────────────────────────────────────────────────────

function anything() {
	var name = messagename;
	var args = arrayfromargs(arguments);

	if (name === "edition" && args.length) {
		edition = parseInt(args[0], 10) || 256;
	} else if (name === "volumeUpdate" && args.length >= 2) {
		volumeUpdate.apply(this, args);
	} else if (name === "muteUpdate" && args.length >= 2) {
		muteUpdate.apply(this, args);
	}
	else if (name === "handleOldPatternOut" && args.length >= 3) {
		handleOldPatternOut.apply(this, args);

	}
	else if (name === "/grid/key" && args.length >= 3) {
		dispatch(parseInt(args[0], 10), parseInt(args[1], 10), parseInt(args[2], 10));
	} else if (name === "key" && args.length >= 3) {
		dispatch(parseInt(args[0], 10), parseInt(args[1], 10), parseInt(args[2], 10));
	} else if (name === "clear_automation") {
		automation.events = [];
		automation.armed = false;
		automation.recording = false;
		automation.playing = false;
		clearAnimRange(8, 2, 15);
		clearAnimRange(9, 8, 14);
		if (kmod === 2) {
			drawRandomizeColumn();
			drawAutomationColumn();
		}
		post("[grid_router] automation cleared\n");
	}
}
