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
 *            - outputMeter ch level          (VU level from output.maxpat)
 *            - handleOldPatternOut ch col row (pattern replay LED)
 *            - chUpdateCollEvent ch fi oct len spd rev spd2 grp rndOff
 *                                             (track param sync from ch.maxpat [pak])
 *            - chRowPos row pos              (playback pos from ch.maxpat)
 *            - chGroup ch grp                (group assignment from ch.maxpat)
 *            - edition 64|128|256            (grid size)
 *            - clear_automation              (reset automation state)
 *            - colorCell x y r g b            (persistent MechaTrellis color)
 *            - colorAll r g b                 (persistent color for all cells)
 *            - storeColorPreset/recallColorPreset slot
 *                                              (firmware color banks 0-7)
 *            - applyPageColors [1-4]          (apply an initial page palette)
 *            - initializePageColorPresets      (rebuild page slots after reset)
 *            - autoPageColors 0|1             (disable/enable palettes)
 *            - rgbCell/rgbAll, level8Cell/level8All, intensity8
 *                                              (direct private extension access)
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
 *              4 = reserved
 *
 * Normal mode (kmod 1): playback head LEDs from box/led are forwarded as setcell.
 *   This replaces the old [p switcher] path (r mlrpageled → constrain → setcell).
 *
 * Mod page (kmod 2), cols 0–7: row 0 mutes, rows 1–2 vol up/down (brightness = level),
 * row 3 timestretch, row 4 channel loop-latch toggle, rows 5+ insert-FX placeholders,
 * bottom 3 rows = VU meters from output.maxpat (outputMeter).
 * Col 8: row 0 randomize all channels ([ch]randomfun); rows 1+ per-track (#[box]rnd).
 * Col 9: automation (play r1, loop r2, length r3–6, arm r7); recording anim col 8 r2–15;
 * playback progress col 9 r8–14.
 * Cols 10–15 rows 1+: quantize, track sub-loop size, random offset, half/double time, reverse.
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
		this.gateLatch = 0;
		this.activeTrack = -1;
		this.lastCell = [0, 0]; // to clear on rowpos change
	}
}

class mlrTrack {
	constructor(track) {
		this.track = track;
		this.channel = 8;
		this.randomOffset = 0;
		this.length = 16;
		this.subLoopDiv = 8;
		this.loopStart = 0;
		this.loopEnd = 16;
		this.loopActive = 0;
		this.playPos = 0;
		this.subLoopAnchor = -1;
		this.buffer = 0;
		this.octave = 0;
		this.reverse = 0;
	}
}

var s = new Global("mlr");
s.dual128Mode = 0;
if (!s.initialized) {
	s.gridports = [0, 0];
	s.prefix = "/box";
	s.kmod = 1;
	s.edition = 256;
	s.gridWidth = 16;
	s.gridHeight = 16;

	s.NUM_SEQUENCERS = 8;
	s.NUM_CHANNELS = 8;
	s.NUM_TRACKS = 16;
	s.MAX_SAMPLES = 128;

	s.sequencers = Array.from({ length: 8 }, (_, i) => new Sequencer(i));
	s.channels = Array.from({ length: 8 }, (_, i) => new mlrChannel(i));
	s.tracks = Array.from({ length: 16 }, (_, i) => new mlrTrack(i));

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

function ensureChannelDefaults(channelIdx) {
	var channel = s.channels[channelIdx];
	if (!channel) {
		channel = new mlrChannel(channelIdx);
		s.channels[channelIdx] = channel;
	}
	if (channel.gateLatch === undefined) channel.gateLatch = 0;
	if (channel.activeTrack === undefined) channel.activeTrack = -1;
	return channel;
}

function ensureTrackDefaults(trackIdx) {
	var track = s.tracks[trackIdx];
	if (!track) {
		track = new mlrTrack(trackIdx);
		s.tracks[trackIdx] = track;
	}
	if (track.length === undefined) track.length = 16;
	if (track.subLoopDiv === undefined) track.subLoopDiv = 8;
	if (track.loopStart === undefined) track.loopStart = 0;
	if (track.loopEnd === undefined) track.loopEnd = 16;
	if (track.loopActive === undefined) track.loopActive = 0;
	if (track.playPos === undefined) track.playPos = 0;
	if (track.subLoopAnchor === undefined) track.subLoopAnchor = -1;
	return track;
}

for (var channelIdx = 0; channelIdx < s.NUM_CHANNELS; channelIdx++) {
	ensureChannelDefaults(channelIdx);
}

for (var trackIdx = 0; trackIdx < s.NUM_TRACKS; trackIdx++) {
	ensureTrackDefaults(trackIdx);
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
if (s.autoPageColors === undefined) s.autoPageColors = 1;

/** Last mod-page picks for right-side columns (redraw after overlay clear). */
var modQuantizeRow = 0;
var modBufferRow = 0;

var animBrightness = 0;
var SEQUENCER_PULSE_LEVEL = 15;
var LOOP_HIGHLIGHT_LEVEL = 3;
var TRACK_SUB_LOOP_OPTIONS = [4, 6, 8, 12, 16, 24, 32, 48];
var TRACK_SUB_LOOP_BRIGHTNESS = [2, 4, 6, 8, 10, 12, 14, 15];
var playbackBg = createPlaybackBg();
var trackHeldLoopCols = Array.from({ length: s.NUM_TRACKS }, function () { return {}; });
var channelSubLoopTasks = Array.from({ length: s.NUM_CHANNELS }, function () { return []; });

// Initial palettes for the four kmod pages. These are intentionally simple
// starting points: legacy LED levels still provide all state and animation.
var PAGE_COLORS = {
	mainBase: [18, 72, 180],
	mainChannels: [0, 180, 255],
	mainPatterns: [190, 45, 255],
	mainClock: [255, 135, 20],
	mainPage: [235, 235, 255],
	modBase: [28, 48, 90],
	mute: [255, 45, 40],
	volume: [25, 220, 90],
	timestretch: [0, 195, 255],
	latch: [255, 155, 20],
	insertFx: [155, 55, 255],
	meter: [35, 230, 95],
	randomize: [255, 105, 15],
	automation: [255, 35, 105],
	quantize: [15, 210, 180],
	subLoop: [30, 145, 255],
	randomOffset: [215, 55, 255],
	octave: [70, 120, 255],
	reverse: [255, 65, 35],
	groupsBase: [28, 42, 72],
	gateFxBase: [105, 35, 175]
};

var GROUP_COLORS = [
	[255, 65, 55], [255, 135, 20], [245, 205, 30], [40, 215, 90],
	[0, 195, 210], [35, 125, 255], [135, 75, 255], [235, 55, 190]
];

var initialPageColorTask = new Task(function () {
	if (s.autoPageColors) initializePageColorPresets();
}, this);

// libmonome writes extension packets directly to a nonblocking serial fd. A
// full page of color/set messages sent in one scheduler turn can fill that fd
// and starve the legacy level/map frames, so automatic palettes are paced.
var PAGE_COLOR_INTERVAL_MS = 6;
var pageColorQueue = [];
var pageColorQueueTask = new Task(drainPageColorQueue, this);
var pageColorPresetReady = new Array(8).fill(0);

// ─── Helpers ────────────────────────────────────────────────────────────

function clamp(v, lo, hi) {
	return Math.min(hi, Math.max(lo, v));
}

function createPlaybackBg() {
	return new Array(s.gridWidth * s.gridHeight).fill(0);
}

function resetPlaybackBg() {
	playbackBg = createPlaybackBg();
}

function bgIndex(x, y) {
	return y * s.gridWidth + x;
}

function getTrackStateByIndex(trackIdx) {
	if (trackIdx < 0 || trackIdx >= s.NUM_TRACKS) return null;
	return ensureTrackDefaults(trackIdx);
}

function getChannelStateByIndex(channelIdx) {
	if (channelIdx < 0 || channelIdx >= s.NUM_CHANNELS) return null;
	return ensureChannelDefaults(channelIdx);
}

function getTrackStateByRow(row) {
	return getTrackStateByIndex(row - 1);
}

function normalizeLoopPoint(point, fallback) {
	var parsed = parseFloat(point);
	return isFinite(parsed) ? clamp(parsed, 0, 16) : fallback;
}

function heldLoopCols(trackIdx) {
	var held = trackHeldLoopCols[trackIdx];
	var cols = [];
	for (var key in held) {
		if (held[key]) cols.push(parseInt(key, 10));
	}
	cols.sort(function (a, b) { return a - b; });
	return cols;
}

function resetHeldLoopCols() {
	for (var i = 0; i < trackHeldLoopCols.length; i++) {
		trackHeldLoopCols[i] = {};
	}
}

function loopCellIsSelected(trackState, x) {
	if (!trackState || !trackState.loopActive) return false;
	var start = clamp(Math.floor(trackState.loopStart), 0, s.gridWidth - 1);
	var end = clamp(Math.floor(trackState.loopEnd), start, 16);
	if (end >= s.gridWidth) end = s.gridWidth - 1;
	return x >= start && x <= end;
}

function loopHighlightLevel(x, y) {
	if (y < 1) return 0;
	var trackState = getTrackStateByRow(y);
	return loopCellIsSelected(trackState, x) ? LOOP_HIGHLIGHT_LEVEL : 0;
}

function compositeBgLevel(x, y) {
	return Math.max(playbackBg[bgIndex(x, y)] || 0, loopHighlightLevel(x, y));
}

function drawMainBackgroundCell(x, y) {
	led_bg(x, y, compositeBgLevel(x, y));
}

function redrawTrackBackground(trackIdx) {
	var y = trackIdx + 1;
	if (y < 1 || y >= s.gridHeight) return;
	for (var x = 0; x < s.gridWidth; x++) {
		drawMainBackgroundCell(x, y);
	}
}

function redrawMainBackground() {
	for (var y = 0; y < s.gridHeight; y++) {
		for (var x = 0; x < s.gridWidth; x++) {
			drawMainBackgroundCell(x, y);
		}
	}
}

function trackChannelIndex(trackIdx) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return -1;
	return clamp((parseInt(trackState.channel, 10) || 1) - 1, 0, s.NUM_CHANNELS - 1);
}

function channelLatchEnabledForTrack(trackIdx) {
	var channelState = getChannelStateByIndex(trackChannelIndex(trackIdx));
	return !!(channelState && channelState.gateLatch);
}

function applyLoopStateForTrackIndex(trackIdx, start, end, active, suppressLatchRefresh) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var loopStart = normalizeLoopPoint(start, 0);
	var loopEnd = normalizeLoopPoint(end, 16);
	if (loopEnd < loopStart) loopEnd = loopStart;
	trackState.loopStart = loopStart;
	trackState.loopEnd = loopEnd;
	trackState.loopActive = active === undefined ? ((loopStart > 0 || loopEnd < 16) ? 1 : 0) : (active ? 1 : 0);
	if (!suppressLatchRefresh && channelLatchEnabledForTrack(trackIdx)) reapplyTrackSubLoopAfterTrigger(trackIdx);
	if (s.kmod === 1) redrawTrackBackground(trackIdx);
}

function clearLoopVisualForTrackIndex(trackIdx, suppressLatchRefresh) {
	applyLoopStateForTrackIndex(trackIdx, 0, 16, false, suppressLatchRefresh);
}

function setPlaybackBgCell(x, y, level) {
	if (x < 0 || y < 0 || x >= s.gridWidth || y >= s.gridHeight) return;
	var parsed = parseInt(level, 10);
	playbackBg[bgIndex(x, y)] = isFinite(parsed) ? clamp(parsed, 0, 15) : 0;
	if (s.kmod === 1) drawMainBackgroundCell(x, y);
}

function updateLoopSelectionFromPress(col, row, state) {
	if (row < 1 || row >= s.gridHeight) return;
	var trackIdx = row - 1;
	var held = trackHeldLoopCols[trackIdx];
	var trackState = getTrackStateByIndex(trackIdx);
	if (!held || !trackState) return;

	if (state === 1) {
		if (!held[col]) {
			if (heldLoopCols(trackIdx).length === 0 && trackState.loopActive) {
				clearLoopVisualForTrackIndex(trackIdx, true);
			}
			held[col] = 1;
			var cols = heldLoopCols(trackIdx);
			if (cols.length === 2) {
				applyLoopStateForTrackIndex(trackIdx, cols[0], cols[1], true);
			}
		}
		return;
	}

	delete held[col];
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

function kfping(x, y, level, time = 20) {
	outlet(3, "kf", x, y, level, 1, 0, time);
}

function clear() {
	post("[grid_router] clear() called — kmod=" + s.kmod + "\n");
	outlet(1, "clear");
	messnamed("togridmatrixanim", "clear_anim");
}

// ─── MechaTrellis private color / 8-bit helpers ────────────────────────

function clamp8(value) {
	var parsed = parseInt(value, 10);
	return clamp(isFinite(parsed) ? parsed : 0, 0, 255);
}

/** Persistent color only: current legacy brightness/state is unchanged. */
function colorCell(x, y, r, g, b) {
	x = parseInt(x, 10);
	y = parseInt(y, 10);
	if (!isFinite(x) || !isFinite(y) || x < 0 || y < 0 || x >= s.gridWidth || y >= s.gridHeight) return;
	outlet(1, "colorcell", x, y, clamp8(r), clamp8(g), clamp8(b));
}

/** Persistent color for the whole grid; current legacy levels are unchanged. */
function colorAll(r, g, b) {
	outlet(1, "colorall", clamp8(r), clamp8(g), clamp8(b));
}

function colorPresetSlot(slot) {
	return clamp(parseInt(slot, 10) || 0, 0, 7);
}

function storeColorPreset(slot) {
	var target = colorPresetSlot(slot);
	outlet(1, "colorpresetstore", target);
	pageColorPresetReady[target] = 1;
}

function recallColorPreset(slot) {
	outlet(1, "colorpresetrecall", colorPresetSlot(slot));
}

function colorRow(y, r, g, b) {
	y = parseInt(y, 10);
	if (!isFinite(y) || y < 0 || y >= s.gridHeight) return;
	for (var x = 0; x < s.gridWidth; x++) colorCell(x, y, r, g, b);
}

function colorCol(x, r, g, b) {
	x = parseInt(x, 10);
	if (!isFinite(x) || x < 0 || x >= s.gridWidth) return;
	for (var y = 0; y < s.gridHeight; y++) colorCell(x, y, r, g, b);
}

/** Inclusive rectangle: colorRect x0 y0 x1 y1 r g b. */
function colorRect(x0, y0, x1, y1, r, g, b) {
	x0 = clamp(parseInt(x0, 10) || 0, 0, s.gridWidth - 1);
	y0 = clamp(parseInt(y0, 10) || 0, 0, s.gridHeight - 1);
	x1 = clamp(parseInt(x1, 10) || 0, 0, s.gridWidth - 1);
	y1 = clamp(parseInt(y1, 10) || 0, 0, s.gridHeight - 1);
	var left = Math.min(x0, x1);
	var right = Math.max(x0, x1);
	var top = Math.min(y0, y1);
	var bottom = Math.max(y0, y1);
	for (var y = top; y <= bottom; y++) {
		for (var x = left; x <= right; x++) colorCell(x, y, r, g, b);
	}
}

/** Direct RGB commands also set LED state; use colorCell for legacy pages. */
function rgbCell(x, y, r, g, b) {
	outlet(1, "rgbcell", parseInt(x, 10), parseInt(y, 10), clamp8(r), clamp8(g), clamp8(b));
}

function rgbAll(r, g, b) {
	outlet(1, "rgball", clamp8(r), clamp8(g), clamp8(b));
}

function level8Cell(x, y, level) {
	outlet(1, "level8cell", parseInt(x, 10), parseInt(y, 10), clamp8(level));
}

function level8All(level) {
	outlet(1, "level8all", clamp8(level));
}

function intensity8(level) {
	outlet(1, "intensity8", clamp8(level));
}

function queuePageColorCommand() {
	pageColorQueue.push(arrayfromargs(arguments));
}

function drainPageColorQueue() {
	if (!pageColorQueue.length) return;
	var command = pageColorQueue.shift();
	outlet.apply(this, [1].concat(command));
	if (command[0] === "colorpresetstore") {
		pageColorPresetReady[colorPresetSlot(command[1])] = 1;
	}
	if (pageColorQueue.length) pageColorQueueTask.schedule(PAGE_COLOR_INTERVAL_MS);
}

function resetPageColorQueue() {
	pageColorQueueTask.cancel();
	pageColorQueue = [];
}

function startPageColorQueue() {
	if (pageColorQueue.length) pageColorQueueTask.schedule(0);
}

function queueColorAllFrom(rgb) {
	queuePageColorCommand("colorall", clamp8(rgb[0]), clamp8(rgb[1]), clamp8(rgb[2]));
}

function queueColorCellFrom(x, y, rgb) {
	if (x < 0 || y < 0 || x >= s.gridWidth || y >= s.gridHeight) return;
	queuePageColorCommand("colorcell", x, y, clamp8(rgb[0]), clamp8(rgb[1]), clamp8(rgb[2]));
}

function queueColorRectFrom(x0, y0, x1, y1, rgb) {
	var left = clamp(Math.min(x0, x1), 0, s.gridWidth - 1);
	var right = clamp(Math.max(x0, x1), 0, s.gridWidth - 1);
	var top = clamp(Math.min(y0, y1), 0, s.gridHeight - 1);
	var bottom = clamp(Math.max(y0, y1), 0, s.gridHeight - 1);
	for (var y = top; y <= bottom; y++) {
		for (var x = left; x <= right; x++) queueColorCellFrom(x, y, rgb);
	}
}

function queueColorColFrom(x, rgb) {
	queueColorRectFrom(x, 0, x, s.gridHeight - 1, rgb);
}

function applyMainPageColors() {
	queueColorAllFrom(PAGE_COLORS.mainBase);
	queueColorRectFrom(0, 0, 7, 0, PAGE_COLORS.mainChannels);
	queueColorRectFrom(8, 0, 11, 0, PAGE_COLORS.mainPatterns);
	queueColorRectFrom(12, 0, 13, 0, PAGE_COLORS.mainClock);
	queueColorRectFrom(14, 0, 15, 0, PAGE_COLORS.mainPage);
}

function applyModPageColors() {
	queueColorAllFrom(PAGE_COLORS.modBase);
	queueColorRectFrom(0, 0, 7, 0, PAGE_COLORS.mute);
	queueColorRectFrom(0, 1, 7, 2, PAGE_COLORS.volume);
	queueColorRectFrom(0, 3, 7, 3, PAGE_COLORS.timestretch);
	queueColorRectFrom(0, 4, 7, 4, PAGE_COLORS.latch);
	var insertBottom = s.gridHeight - 4;
	if (insertBottom >= 5) queueColorRectFrom(0, 5, 7, insertBottom, PAGE_COLORS.insertFx);
	queueColorRectFrom(0, s.gridHeight - 3, 7, s.gridHeight - 1, PAGE_COLORS.meter);
	queueColorColFrom(8, PAGE_COLORS.randomize);
	queueColorColFrom(9, PAGE_COLORS.automation);
	queueColorColFrom(10, PAGE_COLORS.quantize);
	queueColorColFrom(11, PAGE_COLORS.subLoop);
	queueColorColFrom(12, PAGE_COLORS.randomOffset);
	queueColorColFrom(13, PAGE_COLORS.octave);
	queueColorColFrom(14, PAGE_COLORS.octave);
	queueColorColFrom(15, PAGE_COLORS.reverse);
}

function applyGroupsPageColors() {
	queueColorAllFrom(PAGE_COLORS.groupsBase);
	for (var group = 0; group < GROUP_COLORS.length && (group + 8) < s.gridWidth; group++) {
		queueColorRectFrom(group + 8, 1, group + 8, s.gridHeight - 1, GROUP_COLORS[group]);
	}
}

function applyGateFxPageColors() {
	queueColorAllFrom(PAGE_COLORS.gateFxBase);
	queueColorRectFrom(14, 0, 15, 0, PAGE_COLORS.mainClock);
}

function buildPageColorPalette(page) {
	switch (page) {
		case 1: applyMainPageColors(); break;
		case 2: applyModPageColors(); break;
		case 3: applyGroupsPageColors(); break;
		case 4: applyGateFxPageColors(); break;
	}
}

/** Rebuild and store one page palette in firmware slot page-1. */
function applyPageColors(page) {
	var requested = parseInt(page, 10);
	var target = isFinite(requested) ? clamp(requested, 1, 4) : s.kmod;
	resetPageColorQueue();
	pageColorPresetReady[target - 1] = 0;
	buildPageColorPalette(target);
	queuePageColorCommand("colorpresetstore", target - 1);
	startPageColorQueue();
}

/** Upload all four page palettes once, store slots 0-3, then recall this page. */
function initializePageColorPresets() {
	resetPageColorQueue();
	for (var slot = 0; slot < pageColorPresetReady.length; slot++) {
		pageColorPresetReady[slot] = 0;
	}
	for (var page = 1; page <= 4; page++) {
		buildPageColorPalette(page);
		queuePageColorCommand("colorpresetstore", page - 1);
	}
	queuePageColorCommand("colorpresetrecall", clamp(s.kmod, 1, 4) - 1);
	startPageColorQueue();
}

function activatePageColors(page) {
	var target = clamp(parseInt(page, 10) || s.kmod, 1, 4);
	// A page change during initial upload cancels the remaining stale colors.
	if (pageColorQueue.length) resetPageColorQueue();
	if (pageColorPresetReady[target - 1]) recallColorPreset(target - 1);
	else applyPageColors(target);
}

function autoPageColors(enabled) {
	s.autoPageColors = parseInt(enabled, 10) ? 1 : 0;
	if (s.autoPageColors) activatePageColors(s.kmod);
	else resetPageColorQueue();
	post("[grid_router] automatic page colors " + (s.autoPageColors ? "enabled" : "disabled") + "\n");
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

function sequencerBaseLevel(idx) {
	var seq = s.sequencers[idx];
	if (!seq || !seq.on) return 0;
	return seq.phase === 0 ? 15 : 5;
}

function sequencerDisplayLevel(idx) {
	var seq = s.sequencers[idx];
	if (!seq || !seq.on) return 0;
	return sequencerBaseLevel(idx);
}

function drawSequencerLed(idx) {
	if (idx < 0 || idx >= 4) return;
	led_bg(idx + 8, 0, sequencerDisplayLevel(idx));
}

function triggerSequencerPulse(idx) {
	var seq = s.sequencers[idx];
	if (!seq || !seq.on || s.kmod !== 1) return;
	kfping(idx + 8, 0, SEQUENCER_PULSE_LEVEL, 8);
}

function pulseModRandomizeCell(trackRow) {
	var gridRow = parseInt(trackRow, 10) - 1;
	if (isNaN(gridRow) || gridRow < 1 || gridRow >= s.gridHeight) return;
	kfping(8, gridRow, 15, 24);
}

function patternPulse(idx) {
	idx = parseInt(idx, 10);
	if (isNaN(idx)) return;
	triggerSequencerPulse(idx);
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

function trackInputBus(trackNum) {
	return trackNum + "input";
}

function trackLoopBus(trackNum) {
	return trackNum + "[box]loop";
}

function trackChannelBusNumber(trackIdx) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return 1;
	return clamp(parseInt(trackState.channel, 10) || 1, 1, s.NUM_CHANNELS);
}

function restoreTrackLoop(trackIdx) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var trackNum = trackChannelBusNumber(trackIdx);
	if (trackState.loopActive) {
		messnamed(trackLoopBus(trackNum), trackState.loopStart, trackState.loopEnd);
	} else {
		messnamed(trackLoopBus(trackNum), 0, 16);
	}
}

function currentTrackLoopEnd(trackState) {
	if (trackState.loopActive) return normalizeLoopPoint(trackState.loopEnd, 16);
	return 16;
}

function currentTrackLoopStart(trackState) {
	if (trackState.loopActive) return normalizeLoopPoint(trackState.loopStart, 0);
	return 0;
}

function currentTrackSubLoopDiv(trackIdx) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return TRACK_SUB_LOOP_OPTIONS[0];
	var div = parseInt(trackState.subLoopDiv, 10);
	return TRACK_SUB_LOOP_OPTIONS.indexOf(div) >= 0 ? div : 8;
}

function currentTrackSubLoopBrightness(trackIdx) {
	var idx = TRACK_SUB_LOOP_OPTIONS.indexOf(currentTrackSubLoopDiv(trackIdx));
	return TRACK_SUB_LOOP_BRIGHTNESS[idx >= 0 ? idx : 0];
}

function applyTrackSubLoop(trackIdx, anchorPos) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	if (!channelLatchEnabledForTrack(trackIdx)) {
		restoreTrackLoop(trackIdx);
		return;
	}

	var parsedAnchor = parseFloat(anchorPos);
	if (anchorPos !== undefined && isFinite(parsedAnchor)) {
		trackState.subLoopAnchor = parsedAnchor;
	}

	var baseStart = currentTrackLoopStart(trackState);
	var baseEnd = currentTrackLoopEnd(trackState);
	if (baseEnd <= baseStart) baseEnd = Math.min(16, baseStart + 1);
	var baseSpan = Math.max(1, baseEnd - baseStart);
	var targetSpan = clamp(baseSpan / currentTrackSubLoopDiv(trackIdx), 0.0625, baseSpan);
	var anchor = trackState.subLoopAnchor >= 0 ? trackState.subLoopAnchor : trackState.playPos;
	anchor = clamp(parseFloat(anchor) || 0, baseStart, Math.max(baseStart, baseEnd - 0.0625));
	var loopStart = clamp(anchor, baseStart, Math.max(baseStart, baseEnd - targetSpan));
	var loopEnd = clamp(loopStart + targetSpan, loopStart + 0.0625, baseEnd);

	messnamed(trackLoopBus(trackChannelBusNumber(trackIdx)), loopStart, loopEnd);
}

function removeChannelSubLoopTask(channelIdx, task) {
	var tasks = channelSubLoopTasks[channelIdx];
	if (!tasks) return;
	for (var i = tasks.length - 1; i >= 0; i--) {
		if (tasks[i] === task) tasks.splice(i, 1);
	}
}

function cancelTrackSubLoopTasks(trackIdx) {
	var channelIdx = trackChannelIndex(trackIdx);
	var tasks = channelSubLoopTasks[channelIdx];
	if (!tasks) return;
	for (var i = 0; i < tasks.length; i++) {
		if (tasks[i] && typeof tasks[i].cancel === "function") tasks[i].cancel();
	}
	channelSubLoopTasks[channelIdx] = [];
}

function applyChannelLatch(channelIdx) {
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState || channelState.activeTrack < 0) return;
	if (channelState.gateLatch) applyTrackSubLoop(channelState.activeTrack);
	else restoreTrackLoop(channelState.activeTrack);
}

function pressEnabledChannelLatch(channelIdx, anchorPos) {
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState || !channelState.gateLatch || channelState.activeTrack < 0) return;

	var trackState = getTrackStateByIndex(channelState.activeTrack);
	var parsedAnchor = parseFloat(anchorPos);
	if (trackState && anchorPos !== undefined && isFinite(parsedAnchor)) {
		trackState.playPos = clamp(parsedAnchor, 0, s.gridWidth - 1);
		trackState.subLoopAnchor = trackState.playPos;
	}

	// Reuse the same latch-on path as the mod-page latch control, without toggling it off.
	setChannelGateLatch(channelIdx, true);
}

function scheduleChannelSubLoopApply(channelIdx, anchorPos, delayMs) {
	var task = null;
	task = new Task(function () {
		removeChannelSubLoopTask(channelIdx, task);
		pressEnabledChannelLatch(channelIdx, anchorPos);
	}, this);
	task.schedule(delayMs);
	channelSubLoopTasks[channelIdx].push(task);
	return task;
}

function reapplyTrackSubLoopAfterTrigger(trackIdx, anchorPos) {
	var channelIdx = trackChannelIndex(trackIdx);
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState) return;
	channelState.activeTrack = trackIdx;

	var trackState = getTrackStateByIndex(trackIdx);
	var parsedAnchor = parseFloat(anchorPos);
	if (trackState && anchorPos !== undefined && isFinite(parsedAnchor)) {
		trackState.playPos = clamp(parsedAnchor, 0, s.gridWidth - 1);
		trackState.subLoopAnchor = trackState.playPos;
	}

	cancelTrackSubLoopTasks(trackIdx);
	pressEnabledChannelLatch(channelIdx, anchorPos);
	scheduleChannelSubLoopApply(channelIdx, anchorPos, 1);
	scheduleChannelSubLoopApply(channelIdx, anchorPos, 15);
	scheduleChannelSubLoopApply(channelIdx, anchorPos, 75);
	scheduleChannelSubLoopApply(channelIdx, anchorPos, 200);
}

function setChannelGateLatch(channelIdx, active) {
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState) return;
	channelState.gateLatch = active ? 1 : 0;
	applyChannelLatch(channelIdx);
	if (!channelState.gateLatch && channelState.activeTrack >= 0) {
		cancelTrackSubLoopTasks(channelState.activeTrack);
	}
	if (s.kmod === 2) drawChannelGateLatchRow();
}

function cycleTrackSubLoopDiv(trackIdx) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var currentIdx = TRACK_SUB_LOOP_OPTIONS.indexOf(currentTrackSubLoopDiv(trackIdx));
	var nextIdx = (currentIdx + 1) % TRACK_SUB_LOOP_OPTIONS.length;
	trackState.subLoopDiv = TRACK_SUB_LOOP_OPTIONS[nextIdx];
	if (channelLatchEnabledForTrack(trackIdx)) {
		var channelState = getChannelStateByIndex(trackChannelIndex(trackIdx));
		if (channelState && channelState.activeTrack === trackIdx) reapplyTrackSubLoopAfterTrigger(trackIdx);
	}
	if (s.kmod === 2) drawTrackSubLoopColumn();
}

function timeMsUpdate(ms) {
	var parsed = parseFloat(ms);
	if (!isFinite(parsed) || parsed <= 0) return;
	s.timeMs = parsed;
}

// ─── Entry Points ───────────────────────────────────────────────────────

function loadbang() {
	post("[grid_router] ready — kmod=" + s.kmod + " edition=" + s.edition + "\n");
	initialPageColorTask.schedule(750);
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
	s.sequencers[idx].on = on ? 1 : 0;
	if (!on) {
		s.sequencers[idx].phase = 0;
		led(idx + 8, 0, 0);
	}
	if (s.kmod === 1) drawSequencerLeds();
};
s.sequpdate = sequpdate;

function setKmod(val) {
	if (val !== s.kmod) {
		var prev = s.kmod;
		s.kmod = val;
		onKmodChange(prev, s.kmod);
	}
}

function drawPage(page) {
	switch (page) {
		case 1: drawMainPage(); break;
		case 2: drawModPage(); break;
		case 3: drawGroupsPage(); break;
		case 4: drawGateFxPage(); break;
	}
}

function onKmodChange(prev, next) {
	post("[grid_router] kmod " + prev + " -> " + next + " (tick=" + s.automation.tick + ")\n");
	resetHeldLoopCols();

	// 1. Broadcast kmod FIRST (synchronous via messnamed) so all downstream
	//    patches settle their gates/switches before we draw.
	messnamed("kmod", s.kmod);

	// 2. Clear animations (synchronous — empties anim queue immediately so
	//    no pending tick() can overwrite our draws).
	messnamed("togridmatrixanim", "clear_anim");

	// 3. Replace the page as one bridge transaction. The bridge suppresses its
	//    periodic flush until endframe, so no intermediate blank frame escapes.
	outlet(1, "beginframe");
	try {
		if (s.autoPageColors) activatePageColors(next);

		// Kmod page indicators: [col, brightness]
		var kmodIndicators = [
			[15, 0],   // kmod 1 - no indicator
			[15, 15],  // kmod 2 - mod overlay
			[14, 10],  // kmod 3 - group/channel assign overlay
			[14, 15]   // kmod 4 - reserved overlay
		];

		if (next >= 1 && next <= kmodIndicators.length) {
			led(kmodIndicators[next - 1][0], 0, kmodIndicators[next - 1][1]);
		}

		drawPage(next);
	} finally {
		outlet(1, "endframe");
	}
}

// ─── Main Dispatch ──────────────────────────────────────────────────────

function dispatch(col, row, state) {
	if (isNaN(col) || isNaN(row) || isNaN(state)) return;
	col = clamp(col, 0, s.gridWidth - 1);
	row = clamp(row, 0, s.gridHeight - 1);
	state = state ? 1 : 0;

	if (shouldRecordAutomationEvent(col, row, state)) {
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
		s.sequencers[idx].phase = 0;
		led(idx + 8, 0, 0);
		messnamed(idx + "pp", 0);
		drawSequencerLed(idx);
		outlet(2, "pattern", idx, 0, "off");
	} else {
		s.sequencers[idx].on = 1;
		s.sequencers[idx].phase = 0;
		messnamed(idx + "pp", 1);
		drawSequencerLed(idx);
		outlet(2, "pattern", idx, 1, "on");
	}
}

/**
 * chUpdateCollEvent — fired by ch.maxpat's [pak] whenever any track parameter
 * changes. Syncs s.tracks state and tells the corresponding [pl] to re-read
 * its coll so groove~ reacts immediately.
 *
 * Args: ch (track# from ch.maxpat, 2-indexed), fileindex, octave, length,
 *       speed, reverse, speed2, group, randomOffset
 */
function chUpdateCollEvent(ch, fileindex, oct, length, speed, reverse, speed2, group, randomOffset) {
	var trackIdx = ch - 2;
	if (trackIdx < 0 || trackIdx >= s.NUM_TRACKS || !s.tracks[trackIdx]) return;

	s.tracks[trackIdx].buffer = fileindex;
	s.tracks[trackIdx].octave = oct;
	s.tracks[trackIdx].length = clamp(parseInt(length, 10) || 16, 1, 16);
	s.tracks[trackIdx].reverse = reverse;
	s.tracks[trackIdx].channel = group;
	s.tracks[trackIdx].randomOffset = randomOffset;
	if (s.tracks[trackIdx].loopActive) {
		clearLoopVisualForTrackIndex(trackIdx, true);
	}

	messnamed(group + "[ch]update", 1);
	var channelState = getChannelStateByIndex(clamp((parseInt(group, 10) || 1) - 1, 0, s.NUM_CHANNELS - 1));
	if (channelState && channelState.gateLatch && channelState.activeTrack === trackIdx) {
		reapplyTrackSubLoopAfterTrigger(trackIdx);
	}

	if (s.kmod === 2) drawModPage();
	if (s.kmod === 3) drawGroupsPage();
}

function chGroup(ch, grp) {
	if (!s.tracks[ch - 2]) {
		post("bad track, ch: " + ch + " grp: " + grp + "\n");
		return;
	}
	s.tracks[ch - 2].channel = grp; // old ch send names start at 2
	if (s.kmod === 3) { // we would be in this function potentially from a change from the patch ui so check
		ledRow(ch - 1, 0);
		drawGroupsPage();
	}
}



function chRowPos(row, pos) {
	var trackIdx = row - 2;
	var gridRow = row - 1;
	var trackState = getTrackStateByIndex(trackIdx);
	if (trackState) {
		trackState.playPos = clamp(parseInt(pos, 10) || 0, 0, s.gridWidth - 1);
		getChannelStateByIndex(trackChannelIndex(trackIdx)).activeTrack = trackIdx;
	}

	if (s.kmod === 1) {
		//post("rowPos " + row + " " + pos);
		for (var i = 0; i < s.NUM_TRACKS && (i + 1) < s.gridHeight; i++) {
			if (!s.tracks[i]) {
				post("had no track, i: " + i + " row: " + row + "\n");
				continue;
			}
			else if (!s.tracks[trackIdx]) {
				post("no track, trackIdx: " + trackIdx + "\n");
				continue;
			}
			else if (s.tracks[i].channel === s.tracks[trackIdx].channel && i !== trackIdx) {
				ledRow(i + 1, 0);
			}
		}


		kfping(pos, gridRow, 15, 24);
	}
	else if (s.kmod === 2) {
		pulseModRandomizeCell(row);
	}
}

// ─── Normal Mode (kmod 1) ──────────────────────────────────────────────

function handleNormalMode(col, row, state) {
	var trackIdx = row - 1;
	updateLoopSelectionFromPress(col, row, state);
	if (state === 1) {
		var trackState = getTrackStateByIndex(trackIdx);
		if (trackState) {
			trackState.playPos = col;
			trackState.subLoopAnchor = col;
			getChannelStateByIndex(trackChannelIndex(trackIdx)).activeTrack = trackIdx;
		}
	}
	messnamed(trackInputBus(row + 1), col, state);
	if (state === 1) {
		var postTrackState = getTrackStateByIndex(trackIdx);
		if (postTrackState) {
			if (channelLatchEnabledForTrack(trackIdx)) {
				reapplyTrackSubLoopAfterTrigger(trackIdx, col);
			} else {
				cancelTrackSubLoopTasks(trackIdx);
				restoreTrackLoop(trackIdx);
			}
		}
	}
}

function setTrackLoop(track, start, end) {
	var trackNum = clamp(parseInt(track, 10) || 0, 1, s.NUM_TRACKS);
	var trackIdx = trackNum - 1;
	var trackBusNum = trackChannelBusNumber(trackIdx);
	var loopStart = normalizeLoopPoint(start, 0);
	var loopEnd = normalizeLoopPoint(end, 16);
	if (loopEnd < loopStart) loopEnd = loopStart;
	applyLoopStateForTrackIndex(trackIdx, loopStart, loopEnd);
	messnamed(trackLoopBus(trackBusNum), loopStart, loopEnd);
	post("[grid_router] track " + trackNum + " loop=" + loopStart + "-" + loopEnd + "\n");
}

function setTrackLoopStart(track, start) {
	var trackNum = clamp(parseInt(track, 10) || 0, 1, s.NUM_TRACKS);
	var trackState = getTrackStateByIndex(trackNum - 1);
	var loopEnd = trackState ? trackState.loopEnd : 16;
	setTrackLoop(trackNum, start, loopEnd);
}

function setTrackLoopEnd(track, end) {
	var trackNum = clamp(parseInt(track, 10) || 0, 1, s.NUM_TRACKS);
	var trackState = getTrackStateByIndex(trackNum - 1);
	var loopStart = trackState ? trackState.loopStart : 0;
	setTrackLoop(trackNum, loopStart, end);
}

function resetTrackLoop(track) {
	var trackNum = clamp(parseInt(track, 10) || 0, 1, s.NUM_TRACKS);
	var trackIdx = trackNum - 1;
	clearLoopVisualForTrackIndex(trackIdx);
	if (channelLatchEnabledForTrack(trackIdx)) reapplyTrackSubLoopAfterTrigger(trackIdx);
	else {
		cancelTrackSubLoopTasks(trackIdx);
		messnamed(trackLoopBus(trackChannelBusNumber(trackIdx)), 0, 16);
	}
	post("[grid_router] track " + trackNum + " loop reset\n");
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
		} else if (row === 4) {
			handleChannelGateLatchToggle(col);
		}
	} else if (col === 8) {
		handleModRandomize(row);
	} else if (col === 9) {
		handleAutomationControl(row);
	} else if (col === 10 && row >= 1 && row <= 5) {
		handleQuantize(row);
	} else if (col === 11 && row >= 1) {
		handleTrackSubLoopCycle(row);
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
		for (var i = 0; i < s.NUM_TRACKS; i++) {
			clearLoopVisualForTrackIndex(i, true);
		}
		kfping(8, 0, 6);
		return;
	}
	var trackId = row + 1;
	clearLoopVisualForTrackIndex(row - 1, true);
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

function handleChannelGateLatchToggle(col) {
	if (s.kmod !== 2) return;
	var channelState = getChannelStateByIndex(col);
	if (!channelState) return;
	setChannelGateLatch(col, !channelState.gateLatch);
	post("[grid_router] channel " + (col + 1) + " gateLatch=" + channelState.gateLatch + "\n");
}

function handleTrackSubLoopCycle(row) {
	if (s.kmod !== 2) return;
	var trackIdx = row - 1;
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	cycleTrackSubLoopDiv(trackIdx);
	post("[grid_router] track " + row + " subLoop=1/" + currentTrackSubLoopDiv(trackIdx) + "\n");
}

function handleModRandomOffset(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	clearLoopVisualForTrackIndex(track, true);
	s.tracks[track].randomOffset = 1 - s.tracks[track].randomOffset;
	messnamed((row + 1) + "[box]rndOff", s.tracks[track].randomOffset);
	drawModPage();
}

function handleHalfTime(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	clearLoopVisualForTrackIndex(track, true);
	messnamed((row + 1) + "[box]dwnOct", 1);
	s.tracks[track].octave--;
	drawOctaveCell(row);
}

function handleDoubleTime(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	clearLoopVisualForTrackIndex(track, true);
	messnamed((row + 1) + "[box]upOct", 1);
	s.tracks[track].octave++;
	drawOctaveCell(row);
}

function handleReverse(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	clearLoopVisualForTrackIndex(track, true);
	s.tracks[track].reverse = 1 - s.tracks[track].reverse;
	messnamed((row + 1) + "[box]rev", s.tracks[track].reverse);
	drawModPage();
}

// ─── Groups Page (kmod 3) ──────────────────────────────────────────────

function handleGroupsPage(col, row, state) {
	if (s.kmod !== 3) return;
	var track = row - 1;
	var channelId = col - 7;
	clearLoopVisualForTrackIndex(track, true);
	messnamed((row + 1) + "chn[box]", channelId);
	//s.tracks[track].channel = channelId;
	//drawGroupsPage();
}

// ─── Reserved Page (kmod 4) ─────────────────────────────────────────────

function handleStepSeqPage(col, row, state) {
	return;
}

// ─── Draw Functions ─────────────────────────────────────────────────────

function drawModPage() {
	drawMuteRow();
	drawVolumeRows();
	drawInsertFxBlock();
	drawRandomizeColumn();
	drawAutomationColumn();
	drawQuantizeColumn();
	drawTrackSubLoopColumn();
	drawRandomOffsetColumn();
	drawOctaveColumns();
	drawReverseColumn();
	drawTimestretchRow();
	drawChannelGateLatchRow();
}

function drawTimestretchRow() {
	for (var x = 0; x < 8; x++) {
		led(x, 3, s.channels[x].timestretch ? 15 : 0);
	}
}

function drawMainPage() {
	redrawMainBackground();
	drawChannelsPlaying();
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
	var vuTop = s.gridHeight - 3; // leave bottom 3 rows for VU meters
	for (var x = 0; x < 8; x++) {
		for (var y = 5; y < vuTop; y++) {
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
/**
 * outputMeter ch level — VU meter from output.maxpat.
 * Draws 3 rows at the bottom of the left 8 cols (cols 0–7) on the mod page.
 * ch is 1-indexed. level is 0–15 from snapshot~ * 16.
 * Bottom row = hottest, top row = coolest (offset brightness accordingly).
 */
function outputMeter(ch, level) {
	if (s.kmod !== 2) return;
	var col = ch - 1;
	var bot = s.gridHeight - 1; // bottom row
	led(col, bot, clamp(level + 7, 0, 15));
	led(col, bot - 1, clamp(level + 5, 0, 15));
	led(col, bot - 2, clamp(level + 2, 0, 15));
}

function drawGroupsPage() {
	for (var y = 1; y < s.gridHeight; y++) {
		led(8 + s.tracks[y - 1].channel - 1, y, 15);
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

function drawChannelGateLatchRow() {
	for (var x = 0; x < 8; x++) {
		led(x, 4, getChannelStateByIndex(x).gateLatch ? 15 : 2);
	}
}

function drawTrackSubLoopColumn() {
	for (var y = 1; y < s.gridHeight; y++) {
		led(11, y, currentTrackSubLoopBrightness(y - 1));
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

function drawGateFxOptionRow(row, options, selected) {
	ledRow(row, 0);
	for (var x = 0; x < options.length && x < s.gridWidth; x++) {
		led(x, row, options[x] === selected ? 15 : 4);
	}
}

function drawGateFxValueRow(row, value) {
	ledRow(row, 0);
	for (var x = 0; x < s.gridWidth; x++) {
		if (x === value) {
			led(x, row, 15);
		} else if (x < value) {
			led(x, row, 6);
		}
	}
}

function drawGateFxPage() {
	return;
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
	if (s.kmod !== 1) return;
	// Flash the played cell. Channel on/off row-0 LEDs are managed separately
	// by handleChannelOnArray — don't redraw the whole row on every pattern step.
	var col = parseInt(arguments[1], 10);
	var row = parseInt(arguments[2], 10) - 1;
	kfping(col, row, 15);

}

function drawChannelsPlaying() {
	if (s.kmod !== 1) return;
	for (var i = 0; i < 8; i++) {
		led(i, 0, s.channels[i].on ? 15 : 0);
	}
	drawSequencerLeds();
}

/** Draw sequencer row-0 LEDs at cols 8–11, respecting beat phase for pulsing. */
function drawSequencerLeds() {
	for (var j = 0; j < 4; j++) {
		drawSequencerLed(j);
	}
}

s.drawChannelsPlaying = drawChannelsPlaying;

function handleChannelOnArray() {
	for (var i = 0; i < 8; i++) {
		var channelState = getChannelStateByIndex(i);
		channelState.on = arguments[i];
		if (!channelState.on) channelState.activeTrack = -1;
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
 * Cached even off-page so main-page background redraws stay current.
 */
function boxled() {
	var col = clamp(parseInt(arguments[0], 10), 0, s.gridWidth - 1);
	var row = clamp(parseInt(arguments[1], 10), 0, s.gridHeight - 1);
	var level = clamp(parseInt(arguments[2], 10), 0, 15);
	setPlaybackBgCell(col, row, level);
}

/**
 * boxledrow row col0_level col1_level ... — full row background update
 * from [s box/led_row]. Cached even while overlay pages are active.
 */
function boxledrow() {
	var row = clamp(parseInt(arguments[0], 10), 0, s.gridHeight - 1);
	for (var x = 1; x < arguments.length && (x - 1) < s.gridWidth; x++) {
		setPlaybackBgCell(x - 1, row, arguments[x]);
	}
}

/**
 * boxledcol col row0_level row1_level ... — full column background update
 * from [s box/led_col]. Cached even while overlay pages are active.
 */
function boxledcol() {
	var col = clamp(parseInt(arguments[0], 10), 0, s.gridWidth - 1);
	for (var y = 1; y < arguments.length && (y - 1) < s.gridHeight; y++) {
		setPlaybackBgCell(col, y - 1, arguments[y]);
	}
}

// ─── Automation Recording ───────────────────────────────────────────────

function shouldRecordAutomationEvent(col, row, state) {
	if (state !== 1 || playbackDispatching) return false;
	if (!s.automation.armed && !s.automation.recording) return false;
	// Automation controls operate the recorder itself and must never become
	// playback events. In particular, recording the arm/stop pad would restart
	// or disarm the recorder when the sequence played back.
	if (s.kmod === 2 && col === 9) return false;
	return true;
}

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
	if (s.automation.recording &&
		(s.automation.tick - s.automation.startTick) >= s.automation.length) {
		stopRecording();
	}

	// Pulse active sequencer LEDs on beat (kmod 1 only)
	for (var si = 0; si < 4; si++) {
		if (s.sequencers[si] && s.sequencers[si].on) {
			s.sequencers[si].phase = (s.sequencers[si].phase + 1) % 4;
			if (s.kmod === 1) {
				drawSequencerLed(si);
			}
		}
	}

	if (!s.automation.playing || s.automation.events.length === 0) {
		if (s.kmod === 2 && s.automation.recording) animateLeds();
		return;
	}

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
	if (s.kmod === 2 && s.automation.playing) animateLeds();
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

// ─── Debug ──────────────────────────────────────────────────────────────

/** Send "dump" to gridrouter to dump matrix state + JS state to console. */
function dump() {
	post("[grid_router] kmod=" + s.kmod + " edition=" + s.edition +
		" grid=" + s.gridWidth + "x" + s.gridHeight + "\n");
	post("[grid_router] seq on: " + s.sequencers.map(function (sq) { return sq.on; }).join(",") + "\n");
	post("[grid_router] ch on: " + s.channels.map(function (ch) { return ch.on; }).join(",") + "\n");
	// Forward dump to the bridge so it prints fg/bg
	messnamed("togridmatrixio", "dump");
}

/** Send "redraw" to gridrouter to force-redraw the current page. */
function redraw() {
	post("[grid_router] redraw kmod=" + s.kmod + "\n");
	messnamed("togridmatrixanim", "clear_anim");
	outlet(1, "beginframe");
	try {
		if (s.autoPageColors) activatePageColors(s.kmod);
		drawPage(s.kmod);
	} finally {
		outlet(1, "endframe");
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
					resetPlaybackBg();
					// Forward to bridge + anim engine so all layers agree on dimensions
					outlet(1, "edition", e);
					messnamed("togridmatrixanim", "edition", e);
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
