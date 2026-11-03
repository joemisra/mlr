autowatch = 1;
inlets = 4;
outlets = 4;

var PhaseCut = require("phase_cut_model.js");
var Product = require("mlr_product.js");
var Modulation = Product.rta ? require("modulation_model.js") : {
	createState: function () { return { sources: {}, routes: [] }; },
	sanitizeState: function () { return { sources: {}, routes: [] }; }
};
var Scenes = Product.rta ? require("scene_model.js") : {
	clone: function (value) { return value === undefined ? undefined : JSON.parse(JSON.stringify(value)); }
};
// Physical engine bounds and default grid spans are separate in the instrument schema.
var Instruments = Product.rta ? require("instrument_model.js") : null;
var KnobController = require("knob_controller_model.js");
var SnareInstruments = Product.rta ? require("snare_instrument_model.js") : null;
var HatInstruments = Product.rta ? require("hat_instrument_model.js") : null;
var ClapInstruments = Product.rta ? require("clap_instrument_model.js") : null;
var TomInstruments = Product.rta ? require("tom_instrument_model.js") : null;
var RimInstruments = Product.rta ? require("rim_instrument_model.js") : null;
var BellInstruments = Product.rta ? require("bell_instrument_model.js") : null;
var BassInstruments = Product.rta ? require("bass_instrument_model.js") : null;
var INSTRUMENT_ENGINES = !Product.rta ? [] : [
	{id:"tom",name:"Tom",track:TomInstruments.TOM_TRACK,model:TomInstruments,locks:TomInstruments.TOM_LOCKS,pages:TomInstruments.TOM_PAGES,pageLabels:["BODY","SHLL","MIX"],ownedBus:"rnbo_tom_owned_param",rangeKey:"tomParameterRanges"},
	{id:"rim",name:"Rim",track:RimInstruments.RIM_TRACK,model:RimInstruments,locks:RimInstruments.RIM_LOCKS,pages:RimInstruments.RIM_PAGES,pageLabels:["SHLL","HIT","COLR"],ownedBus:"rnbo_rim_owned_param",rangeKey:"rimParameterRanges"},
	{id:"bell",name:"Bell",track:BellInstruments.BELL_TRACK,model:BellInstruments,locks:BellInstruments.BELL_LOCKS,pages:BellInstruments.BELL_PAGES,pageLabels:["BELL","MODE","HIT"],ownedBus:"rnbo_bell_owned_param",rangeKey:"bellParameterRanges"},
	{id:"bass",name:"FM Bass",track:BassInstruments.BASS_TRACK,model:BassInstruments,locks:BassInstruments.BASS_LOCKS,pages:BassInstruments.BASS_PAGES,pageLabels:["NOTE","FM","MIX"],ownedBus:"rnbo_bass_owned_param",rangeKey:"bassParameterRanges"},

	{
		id: "clap", name: "Clap", track: ClapInstruments.CLAP_TRACK,
		model: ClapInstruments, locks: ClapInstruments.CLAP_LOCKS,
		pages: ClapInstruments.CLAP_PAGES, pageLabels: ["CLAP", "TONE", "TAIL"],
		ownedBus: "rnbo_clap_owned_param", rangeKey: "clapParameterRanges"
	},
	{
		id: "hat", name: "Hat", track: HatInstruments.HAT_TRACK,
		model: HatInstruments, locks: HatInstruments.HAT_LOCKS,
		pages: HatInstruments.HAT_PAGES, pageLabels: ["METL", "SHAP", "FILT"],
		ownedBus: "rnbo_hat_owned_param", rangeKey: "hatParameterRanges"
	},
	{
		id: "snare", name: "Snare", track: SnareInstruments.SNARE_TRACK,
		model: SnareInstruments, locks: SnareInstruments.SNARE_LOCKS,
		pages: SnareInstruments.SNARE_PAGES, pageLabels: ["BODY", "NOIS", "MIX"],
		ownedBus: "rnbo_snare_owned_param", rangeKey: "snareParameterRanges"
	},
	{
		id: "kick", name: "Kick", track: Instruments.KICK_TRACK,
		model: Instruments, locks: Instruments.KICK_LOCKS,
		pages: Instruments.KICK_PAGES, pageLabels: ["BODY", "FMAT", "RES"],
		ownedBus: "rnbo_kick_owned_param", rangeKey: "kickParameterRanges"
	}
];

function instrumentDescriptorForTrack(trackIdx) {
	for (var i = 0; i < INSTRUMENT_ENGINES.length; i++) {
		if (INSTRUMENT_ENGINES[i].track === trackIdx) return INSTRUMENT_ENGINES[i];
	}
	return null;
}

function instrumentDescriptorForParameter(id) {
	for (var i = 0; i < INSTRUMENT_ENGINES.length; i++) {
		if (INSTRUMENT_ENGINES[i].model.definition(id)) return INSTRUMENT_ENGINES[i];
	}
	return null;
}

function instrumentDefinition(id) {
	var descriptor = instrumentDescriptorForParameter(id);
	return descriptor ? descriptor.model.definition(id) : null;
}

function instrumentSanitize(trackIdx, values) {
	var descriptor = instrumentDescriptorForTrack(trackIdx);
	return descriptor ? descriptor.model.sanitize(values) : null;
}

function instrumentClampValue(id, value) {
	var descriptor = instrumentDescriptorForParameter(id);
	return descriptor ? descriptor.model.clampValue(id, value) : null;
}

function instrumentFromNormalized(id, value, range) {
	var descriptor = instrumentDescriptorForParameter(id);
	return descriptor ? descriptor.model.fromNormalized(id, value, range) : null;
}

function instrumentToNormalized(id, value, range) {
	var descriptor = instrumentDescriptorForParameter(id);
	return descriptor ? descriptor.model.toNormalized(id, value, range) : 0;
}

function instrumentMappingRange(id, range) {
	var descriptor = instrumentDescriptorForParameter(id);
	return descriptor ? descriptor.model.mappingRange(id, range) : null;
}

var instrumentLocksCache = null;
function allInstrumentLocks() {
	if (instrumentLocksCache) return instrumentLocksCache;
	var result = [];
	INSTRUMENT_ENGINES.forEach(function (descriptor) { result = result.concat(descriptor.locks); });
	instrumentLocksCache = result;
	return result;
}

var sequence64InstrumentPage = false;
var sequence64InstrumentBank = 0;
var sequence64InstrumentBaseEdit = false;
var instrumentPresetSelection = {};

// Absolute MIDI knobs are input adapters, not musical/session state.
var knobPickup = new KnobController.Pickup();
var knobFocusSource = "grid", knobLabTrack = 14, knobLastContext = null;
var knobRanges = {};
var knobRuntime = new Global("mlr_knob_input_runtime");
var knobBatchContext = null, knobBatchActive = false, knobBatchStatus = "";
function knobInvalidateInput() { knobRuntime.epoch = (Number(knobRuntime.epoch) || 0) + 1; }
knobInvalidateInput(); // discard pending input from an older router after autowatch
knobRuntime.live = false;
function knobReset() { knobInvalidateInput(); knobRuntime.live = false; knobPickup.reset(); knobRanges = {}; knobLastContext = null; }
function knobStatus(message) {
	if (knobBatchActive) knobBatchStatus = message;
	else messnamed("mlr_knob_status", message);
}
function knobSource(source) {
	if (source !== "grid" && source !== "lab") return;
	knobFocusSource = source; knobReset();
}
function knobLabFocus(tab) {
	var tracks = [14, 13, 12, 11, 10, 9, 8, 7];
	var index = KnobController.midiInteger(tab, 0, 7);
	if (index === null) return;
	knobLabTrack = tracks[index];
	if (knobFocusSource === "lab") knobReset();
}
function knobContext() {
	if (!rtaEnabled()) return false;
	var w = ensureEditorWorkspaceDefaults();
	var grid = knobFocusSource === "grid";
	if (grid && (!w.active || w.choosing || !sequence64LayoutEnabled() || s.kmod !== 2)) return null;
	var held = grid && !w.collapsed && w.view64 === "sequence" && sequence64PressedStep >= 0;
	var live = grid && !held && (sequence64InspectorLiveWrite || sequence64LockRecordHeld);
	var pattern = grid ? currentSequence64Pattern() : null;
	var step = grid ? (live ? sequence64InstrumentEditStep() : currentSequence64EditStep()) : null;
	var engine = grid ? sequence64InstrumentTarget(step) : instrumentDescriptorForTrack(knobLabTrack);
	var mlr = grid && (!engine || !sequence64InstrumentPage);
	if (mlr) {
		if (w.collapsed || w.view64 !== "sequence") return null;
		var track = sequence64TargetTrackIndex(w.targetType, w.targetId, step);
		if (track < 0 || !pattern || !step) return null;
		engine = {id:"mlr",name:"MLR",track:track};
	}
	if (!engine) return null;
	return {engine:engine,mlr:mlr,pattern:pattern,step:mlr || held ? step : null,live:live,held:held,
		key:knobFocusSource + ':' + engine.id + ':' + engine.track + ':' + (w.performanceTrackSlotRef || '') + ':' +
			(grid ? w.targetType + ':' + w.targetId : '') + ':' +
			(held ? pattern.currentBar + ':' + currentSequence64EditStepIndex() : live ? 'live' : 'base')};
}
function knobRefreshContext() {
	if (knobBatchContext) return knobBatchContext;
	var c = knobContext(), previous = knobLastContext;
	if (!c || !previous || c.key !== previous.key || c.pattern !== previous.pattern || (!c.live && c.step !== previous.step)) {
		if (previous) knobInvalidateInput();
		knobPickup.reset(); knobRanges = {};
	}
	knobLastContext = c;
	knobRuntime.live = !!(c && c.live);
	if (c) {
		knobRuntime.track = c.engine.track;
		if (c.live) {
			var pos = currentSequence64PlaybackLocation(c.pattern);
			knobRuntime.bar = pos.bar; knobRuntime.step = pos.step;
		}
	}
	return c;
}
function knobBatch(epoch, payload) {
	if (Number(epoch) !== knobRuntime.epoch) return false;
	var values;
	try { values = JSON.parse(String(payload)); } catch (_) { return false; }
	if (!Array.isArray(values) || !values.length || values.length > 16) return false;
	var context = knobRefreshContext();
	if (!context || Number(epoch) !== knobRuntime.epoch) return false;
	var changed = false;
	knobBatchContext = context; knobBatchActive = true; knobBatchStatus = "";
	try {
		for (var i = 0; i < values.length; i++) {
			var v = values[i];
			if (!v || KnobController.midiInteger(v.knob, 1, 16) === null ||
				KnobController.midiInteger(v.first, 0, 127) === null || KnobController.midiInteger(v.last, 0, 127) === null) continue;
			var record = null;
			if (context.live) {
				if (KnobController.midiInteger(v.bar, 0, context.pattern.bars.length - 1) === null ||
					KnobController.midiInteger(v.step, 0, context.pattern.bars[v.bar].length - 1) === null) continue;
				record = {bar:v.bar,step:v.step};
			} else if (v.bar !== -1 || v.step !== -1) continue;
			if (v.first !== v.last) knobCC(v.knob, v.first, {observeOnly:true});
			changed = knobCC(v.knob, v.last, {record:record}) || changed;
		}
	} finally { knobBatchActive = false; knobBatchContext = null; }
	if (knobBatchStatus) messnamed("mlr_knob_status", knobBatchStatus);
	if (changed) redrawEditorShellDiff();
	return changed;
}
function knobMlrCC(c, index, raw, options) {
	var w = ensureEditorWorkspaceDefaults(), ids = sequence64VisibleParameters(), id = ids[index - 1];
	if (!id) { knobStatus("Knob " + index + " is reserved."); return false; }
	var step = c.step, track = c.engine.track, channel = trackChannelIndex(track);
	var stepProperty = ["slice", "probability", "gateLength", "track", "condition"].indexOf(id) >= 0;
	var value = sequence64CurrentPropertyValue(id, channel, track), choices = null, min = 0, max = 15;
	if ((c.held || stepProperty) && step.locks[id]) value = step.locks[id].value;
	if (id === "slice") value = step.locks.slice ? step.locks.slice.value : step.cut ? step.cut.slice : 0;
	if (id === "probability") value = step.probability;
	if (id === "gateLength") { min = 1; max = 16; value = step.cut ? step.cut.gateLength : 1; }
	if (id === "reverse") max = 1;
	if (id === "transpose") { min = -96; max = 96; }
	if (id === "loopDivision") choices = TRACK_SUB_LOOP_OPTIONS.slice();
	if (id === "condition") { choices = [0,2,3,4,5,6,7,8,9,-2,-3,-4,-5,-6,-7,-8,-9]; value = step.condition || 0; }
	if (id === "track") {
		choices = [];
		for (var t = 0; t < s.NUM_TRACKS; t++) if (sequence64TrackBelongsToGroup(t, w.targetId)) choices.push(t);
		value = sequence64TargetTrackIndex(w.targetType, w.targetId, step);
	}
	if (choices) { if (!choices.length) return false; min = 0; max = choices.length - 1; value = Math.max(0, choices.indexOf(value)); }
	var normalized = max === min ? 0 : clamp((value - min) / (max - min), 0, 1);
	var move = knobPickup.move(index, raw, normalized, c.key + ':' + id + ':' + (choices ? choices.join(',') : min + ':' + max));
	if (!move.accepted) { if (!move.caught) knobStatus("MLR · " + id + " · pickup: turn " + move.direction); return false; }
	if (options && options.observeOnly) return false;
	var mapped = Math.round(min + move.normalized * (max - min));
	value = choices ? choices[mapped] : mapped;
	var pos = c.live ? options && options.record || currentSequence64PlaybackLocation(c.pattern) :
		{bar:c.pattern.currentBar,step:currentSequence64EditStepIndex()};
	var destination = c.pattern.bars[pos.bar].steps[pos.step];
	var lockWrite = c.held || c.live || stepProperty;
	if (lockWrite) {
		if (id === "probability") destination.probability = value;
		else if (id === "condition") destination.condition = value;
		else if (id === "gateLength" || id === "track" || id === "slice") {
			if (!destination.cut) destination.cut = sequence64DefaultCutForStep(pos.step);
			if (id === "gateLength") destination.cut.gateLength = value;
			else if (id === "track") {
				destination.cut.track = value;
				rememberSequence64EditTrack(c.pattern, w.targetType, w.targetId, value);
			}
			else destination.locks.slice = {value:value,behavior:"set"};
		} else if (id === "transpose") destination.locks.transpose = normalizeSequence64TransposeLock({value:value,behavior:"set"});
		else if (destination.locks[id]) destination.locks[id].value = value;
		else destination.locks[id] = {value:value,behavior:"set"};
		sequence64HeldStepChanged = true;
		outlet(2, "editor_lock", w.targetType, w.targetId + 1, pos.step + 1, id, value);
	}
	if (!c.held && !stepProperty) {
		if (id === "volume" || id === "filter") {
			clearSequence64PropertyOwnership(sequence64ChannelPropertyKey(channel, id));
			sequence64TargetParameterValues(w.targetType,w.targetId)[id] = value;
			emitSequence64Parameter(w.targetType,w.targetId,id,value,channel,0);
		} else if (id === "reverse") setEditorReverse(track,value,false);
		else if (id === "transpose") setEditorTranspose(track,value,false);
		else if (id === "loopDivision") setEditorSubLoopDivision(track,value,false);
	}
	markSessionDirty("MLR knob " + id);
	knobPickup.commit(index, max === min ? 0 : (mapped - min) / (max - min));
	sequence64EditParameter = id; sequence64InstrumentPage = false; sequence64InspectorContext = "parameter";
	knobStatus("MLR · " + id + ": " + value + (c.live ? " · live locks" : c.held ? " · step lock" : stepProperty ? " · step" : " · current value"));
	if (!knobBatchActive) redrawEditorShellDiff();
	return true;
}

function knobCC(number, raw, options) {
	var index = KnobController.midiInteger(number, 1, 16);
	if (index === null || KnobController.midiInteger(raw, 0, 127) === null) return false;
	var c = knobRefreshContext();
	if (!c) { knobStatus("Focus an MLR or instrument parameter page, or choose Lab tab focus."); return false; }
	if (c.mlr) return knobMlrCC(c, index, raw, options);
	// Page order, not native hit-packet order: four controls per physical row.
	var ids = [];
	c.engine.pages.forEach(function(page) { ids = ids.concat(page.parameters); });
	var id = ids[index - 1];
	if (!id) { knobStatus("Knob " + index + " is reserved."); return false; }
	var baseline = instrumentSanitize(c.engine.track, getTrackStateByIndex(c.engine.track).instrumentParameters)[id];
	var value = c.held && c.step.locks[id] ? c.step.locks[id].value : baseline;
	var range = instrumentParameterRange(id);
	// Do not catch an out-of-range preset/lock at a clipped endpoint. Widen
	// this input span only, keeping the saved grid range and physical value intact.
	var span = knobRanges[index], rangeKey = range.min + ':' + range.max;
	if (!span || span.rangeKey !== rangeKey || Math.abs(span.lastValue - value) > 1e-9) {
		span = {rangeKey:rangeKey,lastValue:value,range:{min:Math.min(range.min,value), max:Math.max(range.max,value)}};
		knobRanges[index] = span;
	}
	range = span.range;
	var signature = c.key + ':' + id + ':' + range.min + ':' + range.max;
	var move = knobPickup.move(index, raw, instrumentToNormalized(id, value, range), signature);
	var def = instrumentDefinition(id);
	if (!move.accepted) {
		if (!move.caught) knobStatus(c.engine.name + " · " + def.name + " · pickup: turn " + move.direction);
		return false;
	}
	if (options && options.observeOnly) return false;
	value = instrumentClampValue(id, instrumentFromNormalized(id, move.normalized, range));
	if (c.held) storeSequence64InstrumentLock(c.engine, id, value, currentSequence64EditBar(c.pattern), currentSequence64EditStepIndex());
	else {
		instrumentManual(c.engine.track + 1, id, value, c.live && !(options && options.record), true);
		if (c.live && options && options.record) {
			var record = options.record;
			storeSequence64InstrumentLock(c.engine, id, value, c.pattern.bars[record.bar], record.step);
		}
	}
	knobPickup.commit(index, instrumentToNormalized(id, value, range));
	span.lastValue = value;
	if (knobFocusSource === "grid") {
		sequence64EditParameter = id;
		sequence64InstrumentPage = true;
		sequence64InstrumentBaseEdit = !c.held && !c.live;
		sequence64InspectorContext = "parameter";
		for (var bank = 0; bank < c.engine.pages.length; bank++) if (c.engine.pages[bank].parameters.indexOf(id) >= 0) sequence64InstrumentBank = bank;
	}
	knobStatus(c.engine.name + " · " + def.name + ": " + (Math.round(value * 100) / 100) + " " + def.unit +
		(c.held ? " · step lock" : c.live ? " · live locks" : " · sound"));
	if (!knobBatchActive) redrawEditorShellDiff();
	return true;
}

function sanitizeInstrumentPresets(source) {
	var result = {};
	INSTRUMENT_ENGINES.forEach(function (engine) {
		var slots = source && Array.isArray(source[engine.id]) ? source[engine.id] : [];
		result[engine.id] = [];
		for (var i = 0; i < 8; i++) {
			var sound = slots[i];
			result[engine.id].push(sound && typeof sound === "object" && !Array.isArray(sound) ?
				engine.model.sanitize(sound) : null);
		}
	});
	return result;
}

function instrumentPresetSlots(engine) {
	if (!s.instrumentPresets || !Array.isArray(s.instrumentPresets[engine.id])) {
		s.instrumentPresets = sanitizeInstrumentPresets(s.instrumentPresets);
	}
	return s.instrumentPresets[engine.id];
}

function instrumentPresetMatches(engine, sound) {
	if (!sound) return false;
	var baseline = engine.model.sanitize(getTrackStateByIndex(engine.track).instrumentParameters);
	return engine.locks.every(function (id) { return baseline[id] === sound[id]; });
}

function instrumentPresetAction(trackIdx, slot, storeSound) {
	var engine = instrumentDescriptorForTrack(trackIdx);
	if (!engine || slot < 0 || slot >= 8) return false;
	var slots = instrumentPresetSlots(engine), track = getTrackStateByIndex(trackIdx);
	if (storeSound) {
		slots[slot] = engine.model.sanitize(track.instrumentParameters);
	} else {
		if (!slots[slot]) {
			publishHud("notice", "info", engine.name + " P" + (slot + 1) + " empty · Shift + tap to store");
			return false;
		}
		// Apply the whole baseline once. Preset recall must not record locks,
		// even when Live Write is enabled.
		track.instrumentParameters = engine.model.sanitize(slots[slot]);
		knobReset();
		var stacks = ensureEditorWorkspaceDefaults().propertyStacks64;
		engine.locks.forEach(function (id) {
			var stack = stacks[sequence64TrackPropertyKey(trackIdx, id)];
			if (stack) stack.baseValue = track.instrumentParameters[id];
		});
		syncInstrument(trackIdx);
		writeThroughActiveTrackSlot(trackIdx, engine.id + " sound recall");
	}
	instrumentPresetSelection[engine.id] = slot;
	markSessionDirty(engine.id + (storeSound ? " sound store" : " sound recall"));
	publishHud("notice", "info", engine.name + " P" + (slot + 1) + (storeSound ? " stored" : " recalled"));
	messnamed("togridmatrixio", "parameterLabel", engine.id.charAt(0).toUpperCase() + "P" + (slot + 1));
	redrawEditorShellDiff();
	return true;
}

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
 *            - colorMap x y 16*(r g b)         (persistent 4x4 color block)
 *            - colorAll r g b                 (persistent color for all cells)
 *            - storeColorPreset/recallColorPreset slot
 *                                              (firmware color banks 0-7)
 *            - applyPageColors [1-3]          (apply an initial page palette)
 *            - initializePageColorPresets      (compat: resend visible palette)
 *            - autoPageColors 0|1             (disable/enable palettes)
 *            - editorColors 0|1               (optional semantic editor colors)
 *            - editorBrightnessColors 0|1     (backward-compatible alias)
 *            - clearEditorTargetData / clearEditorAllData
 *                                              (reset extended-editor data)
 *            - rgbCell/rgbAll, level8Cell/level8All, intensity8
 *                                              (direct private extension access)
 *            - extendedEditors 0|1             (disable/enable 16x16 editor entry)
 *            - editorLayout sequence64|legacy  (select default or checkpointed UI)
 * Inlet 1: kmod value — int from [r kmod]
 * Inlet 2: clock tick — bang from [r tr_pulse] for automation sync
 * Inlet 3: sequence64 step — bang from the audio-derived [r sequence64_pulse]
 *
 * Outlet 0: raw grid triple (col, row, state) — same order as [r box/press] into
 *           [p box] unpack, so [s grid_router_playback] can replace the old receive.
 * Outlet 1: LED setcell commands for grid_matrix_io (setcell x y level)
 * Outlet 2: status / automation events
 * Outlet 3: keyframe commands for anim engine
 *
 * kmod values: 1 = normal (cut/pattern), 2 = mod/editor page,
 *              3 = groups page
 *
 * Normal mode (kmod 1): playback head LEDs from box/led are forwarded as setcell.
 *   This replaces the old [p switcher] path (r mlrpageled → constrain → setcell).
 *
 * Mod page (kmod 2), cols 0–7: row 0 mutes, rows 1–2 vol up/down (brightness = level),
 * row 3 timestretch, row 4 per-group Sequence64 Run, row 5 Phase Cut, rows 6+ reserved.
 * The old bottom-row VU overlay is retired; row 15 cols 0–2 remain the persistent
 * Sequence / Setup / Scene workspace switcher whenever mode 2 is visible.
 * Col 8: row 0 randomizes all channels. Rows 1+ tap open that track in the
 * sample browser; a deliberate hold retains the legacy per-track #[box]rnd.
 * Col 9: one momentary audio-capture key per visible track row. Capture is
 * armed on press and requests a bar-quantized finish on release.
 * Cols 10–15 rows 1+: quantize, per-track Sequence64 Run, random offset,
 * half/double time, reverse.
 * On a 16x16 grid, holding mode-2 col 13 (physical button 14) opens a target chooser:
 * row 0 cols 0–7 select groups 1–8 and col 15 rows 1–15 select tracks 1–15.
 * After selection, rows 8–15 become a protected editor shell. The default Sequence
 * view uses rows 8–11 for 64 steps with per-step cut, probability, parameter-lock,
 * gate, and preset-shape data; Setup consolidates direct target controls. Run and
 * both live-record gestures are always explicit and momentary where appropriate.
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
		this.lastActiveTrack = -1;
		this.sequence64Owner = null;
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
		this.playbackLoop = 1;
		this.playPos = 0;
		this.subLoopAnchor = -1;
		this.buffer = 0;
		this.octave = 0;
		this.transpose = 0;
		this.speed = 0;
		this.speedMode = 0;
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
	s.editorWorkspace = {
		enabled: Product.rta ? 1 : 0,
		layoutMode: "sequence64",
		choosing: false,
		active: false,
		collapsed: false,
		targetType: "none",
		targetId: -1,
		view64: "sequence",
		editorId: "step",
		stepPlayhead: -1,
		lastSequencedStep: -1,
		lastSequencedBar: -1,
		patterns64: {},
		parameterValues64: {},
		startSnapshots64: {},
		propertyStacks64: {},
		channelOutputs64: {},
		phraseInstances64: {},
		phraseSerial64: 0,
		stepPatterns: {},
		sequenceEnabled: {},
		stepProbabilities: {},
		gateFxLevels: {},
		gateFxEnabled: {},
		targetAutomation: {},
		fxAppliedChannel: -1,
		modulation: Modulation.createState(),
		editCursors64: {},
		sceneState: null,
		performanceGroupPatternRefs: [],
		performanceTrackSlotRef: "",
		pendingSceneLaunch: null,
		sceneRuntimeReady: 0
	};
	s.initialized = true;
}

// Global survives V8 autowatch reloads. Sessions created before catalog-backed
// capture therefore have no recording list even though newer code expects one.
if (!Array.isArray(s.sessionRecordings)) s.sessionRecordings = [];

// Mode 4 was an abandoned full-grid page. Old saved Global state can survive
// a JS reload, so normalize it here before any display renderer sees it.
if (s.kmod < 1 || s.kmod > 3) s.kmod = 1;

function ensureEditorWorkspaceDefaults() {
	if (!s.editorWorkspace) s.editorWorkspace = {};
	var workspace = s.editorWorkspace;
	if (!Product.rta) workspace.enabled = 0;
	else if (workspace.enabled === undefined) workspace.enabled = 1;
	if (workspace.layoutMode !== "legacy" && workspace.layoutMode !== "sequence64") {
		workspace.layoutMode = "sequence64";
	}
	if (workspace.choosing === undefined) workspace.choosing = false;
	if (workspace.active === undefined) workspace.active = false;
	if (workspace.collapsed === undefined) workspace.collapsed = false;
	if (workspace.targetType === undefined) workspace.targetType = "none";
	if (workspace.targetId === undefined) workspace.targetId = -1;
	if (workspace.view64 !== "sequence" && workspace.view64 !== "setup" &&
		workspace.view64 !== "scene") workspace.view64 = "sequence";
	if (workspace.editorId === undefined) workspace.editorId = "step";
	if (workspace.stepPlayhead === undefined) workspace.stepPlayhead = -1;
	if (workspace.lastSequencedStep === undefined) workspace.lastSequencedStep = -1;
	if (workspace.lastSequencedBar === undefined) workspace.lastSequencedBar = -1;
	if (!workspace.patterns64) workspace.patterns64 = {};
	if (!workspace.parameterValues64) workspace.parameterValues64 = {};
	if (!workspace.startSnapshots64) workspace.startSnapshots64 = {};
	if (!workspace.propertyStacks64) workspace.propertyStacks64 = {};
	if (!workspace.channelOutputs64) workspace.channelOutputs64 = {};
	if (!workspace.phraseInstances64) workspace.phraseInstances64 = {};
	if (workspace.phraseSerial64 === undefined) workspace.phraseSerial64 = 0;
	if (!workspace.stepPatterns) workspace.stepPatterns = {};
	if (!workspace.sequenceEnabled) workspace.sequenceEnabled = {};
	if (!workspace.stepProbabilities) workspace.stepProbabilities = {};
	if (!workspace.gateFxLevels) workspace.gateFxLevels = {};
	if (!workspace.gateFxEnabled) workspace.gateFxEnabled = {};
	if (!workspace.targetAutomation) workspace.targetAutomation = {};
	if (workspace.fxAppliedChannel === undefined) workspace.fxAppliedChannel = -1;
	workspace.modulation = Modulation.sanitizeState(workspace.modulation);
	if (!workspace.editCursors64) workspace.editCursors64 = {};
	if (!workspace.performanceGroupPatternRefs) workspace.performanceGroupPatternRefs = [];
	if (workspace.performanceTrackSlotRef === undefined) {
		// Autowatch can preserve the pre-v2 Global while this script reloads.
		workspace.performanceTrackSlotRef = workspace.performanceTrackSetRef || "";
	}
	if (workspace.pendingSceneLaunch === undefined) workspace.pendingSceneLaunch = null;
	if (workspace.sceneRuntimeReady === undefined) workspace.sceneRuntimeReady = 0;
	return workspace;
}

function ensureChannelDefaults(channelIdx) {
	var channel = s.channels[channelIdx];
	if (!channel) {
		channel = new mlrChannel(channelIdx);
		s.channels[channelIdx] = channel;
	}
	if (channel.gateLatch === undefined) channel.gateLatch = 0;
	if (channel.activeTrack === undefined) channel.activeTrack = -1;
	if (channel.lastActiveTrack === undefined) channel.lastActiveTrack = -1;
	if (channel.sequence64Owner === undefined) channel.sequence64Owner = null;
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
	if (track.playbackLoop === undefined) track.playbackLoop = 1;
	if (track.playPos === undefined) track.playPos = 0;
	if (track.subLoopAnchor === undefined) track.subLoopAnchor = -1;
	if (track.transpose === undefined) track.transpose = 0;
	if (track.speed === undefined) track.speed = 0;
	if (track.speedMode === undefined) track.speedMode = 0;
	if (instrumentDescriptorForTrack(trackIdx)) {
		track.instrumentParameters = instrumentSanitize(trackIdx, track.instrumentParameters);
	}
	return track;
}

for (var channelIdx = 0; channelIdx < s.NUM_CHANNELS; channelIdx++) {
	ensureChannelDefaults(channelIdx);
}

for (var trackIdx = 0; trackIdx < s.NUM_TRACKS; trackIdx++) {
	ensureTrackDefaults(trackIdx);
}

// No active/held editor state may survive JS autowatch or patch reloads. Saved
// target data remains in Global, but audio-capable pages require a fresh target
// selection after reload.
var startupEditorWorkspace = ensureEditorWorkspaceDefaults();
restoreSequence64OutputsAfterReload(startupEditorWorkspace);
startupEditorWorkspace.pendingSceneLaunch = null;
startupEditorWorkspace.phraseInstances64 = {};
for (var startupPatternKey in startupEditorWorkspace.patterns64) {
	if (startupEditorWorkspace.patterns64[startupPatternKey]) {
		startupEditorWorkspace.patterns64[startupPatternKey].running = 0;
		startupEditorWorkspace.patterns64[startupPatternKey].phaseOrigin = 0;
		startupEditorWorkspace.patterns64[startupPatternKey].lastSequencedAbsolute = -1;
		startupEditorWorkspace.patterns64[startupPatternKey].restartArmed = 0;
	}
}
if (startupEditorWorkspace.fxAppliedChannel >= 0 && startupEditorWorkspace.fxAppliedChannel < s.NUM_CHANNELS) {
	messnamed((startupEditorWorkspace.fxAppliedChannel + 1) + "[gatefx]level", 1, 8);
}
startupEditorWorkspace.fxAppliedChannel = -1;
startupEditorWorkspace.choosing = false;
startupEditorWorkspace.active = false;
startupEditorWorkspace.collapsed = false;
startupEditorWorkspace.targetType = "none";
startupEditorWorkspace.targetId = -1;
startupEditorWorkspace.stepPlayhead = -1;
startupEditorWorkspace.lastSequencedStep = -1;
startupEditorWorkspace.lastSequencedBar = -1;

/** Guard flag: true while automation playback is dispatching events. */
var playbackDispatching = false;

/** Insert FX placeholder: cols 0–7 × rows 4–15 (96 cells). */
var insert_fx = new Array(8 * 12).fill(0);
function phaseCutState(group) {
 if (!s.phaseCuts) s.phaseCuts = [];
 s.phaseCuts[group] = PhaseCut.sanitize(s.phaseCuts[group]);
 return s.phaseCuts[group];
}
function phaseCutSnapshot() {
 for (var group = 0; group < 8; group++) publishPhaseCut(group);
}
function publishPhaseCut(group) {
 var cut = phaseCutState(group);
 Object.keys(PhaseCut.DEFAULTS).forEach(function(key) {
  messnamed((group + 1) + "[phasecut]", key, cut[key]);
 });
 publishHud("phase_cut", group, JSON.stringify(cut));
}
function phaseCutSet(group, key, value) {
 group = Number(group);
 if (!Number.isInteger(group) || group < 0 || group >= 8 ||
  !Object.prototype.hasOwnProperty.call(PhaseCut.DEFAULTS, key) || !isFinite(Number(value))) return false;
 var cut = phaseCutState(group); cut[key] = Number(value);
 s.phaseCuts[group] = PhaseCut.sanitize(cut);
 publishPhaseCut(group); markSessionDirty("phase cut");
 if (s.kmod === 2) renderCompletePage(2, false);
 return true;
}
function phaseCutToggle(group) {
 group = Number(group);
 if (!Number.isInteger(group) || group < 0 || group >= 8) return false;
 return phaseCutSet(group, "enabled", phaseCutState(group).enabled ? 0 : 1);
}
function phaseCutPreset(group, action, slot) {
 group = Number(group); slot = Number(slot);
 if (!Number.isInteger(group) || group < 0 || group >= 8 || !Number.isInteger(slot) || slot < 0 || slot >= 4) return false;
 var cut = phaseCutState(group), values;
 if (action === "store") cut.presets[slot] = PhaseCut.parameters(cut);
 else if (action === "factory") values = PhaseCut.FACTORIES[slot].values;
 else if (action === "recall") values = cut.presets[slot];
 else return false;
 if (action !== "store") {
  if (!values) return false;
  var enabled = cut.enabled;
  Object.keys(PhaseCut.DEFAULTS).forEach(function(key) { if (values[key] !== undefined) cut[key] = values[key]; });
  cut.enabled = enabled;
 }
 s.phaseCuts[group] = PhaseCut.sanitize(cut);
 publishPhaseCut(group); markSessionDirty("phase cut preset");
 if (s.kmod === 2) renderCompletePage(2, false);
 return true;
}
function insertFxIndex(col, row) {
	return col * 12 + (row - 4);
}

/** Local octave hint per track row (for LED on col 13/14); not synced from DSP. */
if (!s.octave_hint) s.octave_hint = new Array(16).fill(0);
if (s.autoPageColors === undefined) s.autoPageColors = 1;
if (s.editorBrightnessColors === undefined) s.editorBrightnessColors = 0;
if (s.mechaTrellisExtensions === undefined) s.mechaTrellisExtensions = 0;

/** Last mod-page picks for right-side columns (redraw after overlay clear). */
var modQuantizeRow = 0;
var modBufferRow = 0;
var TRACK_CAPTURE_COL = 9;        // physical column 10
var TRACK_CAPTURE_IDLE_LEVEL = 3;
var trackCaptureSource = "input";
var trackCaptureStates = Array.from({ length: 16 }, function () {
	return { state: "idle", bufferIndex: 0, recordingId: "", durationMs: 0 };
});

var animBrightness = 0;
var SEQUENCER_PULSE_LEVEL = 15;
var LOOP_HIGHLIGHT_LEVEL = 3;
var TRACK_SUB_LOOP_OPTIONS = [4, 6, 8, 12, 16, 24, 32, 48];
var TRACK_SUB_LOOP_BRIGHTNESS = [2, 4, 6, 8, 10, 12, 14, 15];
var SEQUENCE64_TRANSPOSE_FIRST_COL = 2;
var SEQUENCE64_TRANSPOSE_MIN = -6;
var SEQUENCE64_TRANSPOSE_MAX = 7;
var EDITOR_BUTTON_COL = 13;       // physical column 14
var EDITOR_TRACK_COL = 15;        // physical column 16
var EDITOR_FIRST_ROW = 8;         // physical row 9
var EDITOR_PLAYHEAD_ROW = EDITOR_FIRST_ROW;
var EDITOR_STEP_ROW = 9;          // physical row 10
var EDITOR_NAV_ROW = 15;          // physical row 16
var EDITOR_AVAILABLE_LEVEL = 3;
var EDITOR_PLAYHEAD_LEVEL = 8;
var EDITOR_SELECTED_LEVEL = 15;
var EDITOR_STEP_TICKS = 2;        // legacy six-page prototype only
var EDITOR_CONTENT_LAST_ROW = 14; // physical row 15; row 16 is navigation
var EDITOR_VALUE_LEVELS = [15, 12, 10, 8, 5, 2, 0];
var EDITOR_FX_LEVELS = [15, 12, 8, 5, 2, 0];
var EDITOR_GATE_FX_RAMP_MS = 8;
var EDITOR_IDS = ["step", "loop", "parameter", "automation", "probability", "fx"];
var SEQUENCE64_LENGTHS = [16, 32, 48, 64];
var SEQUENCE64_RATE_CHOICES = [
	{ numerator: 1, denominator: 4 },
	{ numerator: 1, denominator: 3 },
	{ numerator: 1, denominator: 2 },
	{ numerator: 2, denominator: 3 },
	{ numerator: 1, denominator: 1 },
	{ numerator: 3, denominator: 2 },
	{ numerator: 2, denominator: 1 },
	{ numerator: 3, denominator: 1 },
	{ numerator: 4, denominator: 1 }
];
var SEQUENCE64_STEP_FIRST_ROW = 8;
var SEQUENCE64_STEP_LAST_ROW = 11;
var SEQUENCE64_LENGTH_ROW = 12;
var SEQUENCE64_TRANSPORT_ROW = 13;
var SEQUENCE64_TOOLS_ROW = 14;
var SEQUENCE64_NAV_ROW = 15;
var SEQUENCE64_PARAMETERS = ["slice", "probability", "volume", "filter", "reverse", "transpose", "loopDivision", "gateLength", "track", "condition"];
var SEQUENCE64_BEHAVIORS = ["set", "glide", "pluck", "swell", "gate", "pulse"];
var MODULATION_RATE_CHOICES = [[1, 1], [1, 2], [1, 4], [1, 8], [1, 16],
	[3, 8], [3, 16], [1, 32]];
var SEQUENCE64_PARAMETER_FIRST_COL = 4;
var SEQUENCE64_BEHAVIOR_FIRST_COL = 5;
var SEQUENCE64_PATTERN_CONTEXT_COL = 14;
var SEQUENCE64_DELETE_COL = 14;
var SEQUENCE64_BAR_FIRST_COL = 3;
var SEQUENCE64_HOLD_MS = 350;
var SEQUENCE64_EMPTY_STEP_LEVEL = 0;
var SEQUENCE64_MIN_VISIBLE_LEVEL = 3;
var SEQUENCE64_TRACK_POSITION_LEVEL = 12;
var SEQUENCE64_STEPS_PER_PULSE = 4; // 8x faster than the prototype's 0.5 step/pulse
var SEQUENCE64_STEPS_PER_BEAT = 16;
var SEQUENCE64_MAX_BARS = 8;
var SEQUENCE64_SHAPE_STEPS = { set: 0, glide: 4, pluck: 4, swell: 8, gate: 0, pulse: 4 };
var SCENE_GROUP_FIRST_ROW = 1;
var SCENE_GROUP_LAST_ROW = 8;
var SCENE_PATTERN_FIRST_COL = 0;
var SCENE_PATTERN_LAST_COL = 11;
var SCENE_GROUP_RUN_COL = 12;
var SCENE_TRACK_SLOT_ROW = 9;
var SCENE_TRANSPORT_ROW = 10;
var SCENE_STEP_FIRST_ROW = 11;
var SCENE_STEP_LAST_ROW = 14;
var SCENE_NAV_ROW = 15;
var SCENE_GLOBAL_START_COL = 0;
var SCENE_GLOBAL_STOP_COL = 1;
var SCENE_GLOBAL_RESET_COL = 2;
var SCENE_SHIFT_COL = 11;
var SCENE_EXIT_COL = 15;
var SCENE_QUANTIZE_STEPS = 64;
var SCENE_PLAYING_PULSE_STEPS = 16;
var SCENE_PLAYING_PULSE_DIP_STEPS = 4;
var SCENE_PLAYING_PULSE_LEVEL = 8;
var SAMPLE_BANK_FIRST_BUFFER = 9;
var EDITOR_COLOR_RANGES = {
	step: [[12, 35, 75], [30, 220, 255]],
	sequence: [[8, 38, 58], [25, 225, 255]],
	setup: [[35, 28, 8], [255, 185, 35]],
	scene: [[18, 22, 55], [120, 180, 255]],
	loop: [[55, 25, 10], [255, 150, 25]],
	parameter: [[15, 55, 25], [65, 255, 120]],
	automation: [[60, 8, 30], [255, 45, 145]],
	probability: [[45, 35, 5], [255, 225, 40]],
	fx: [[35, 12, 65], [195, 70, 255]]
};
var editorOverlayDrawDepth = 0;
var sampleBrowserDrawDepth = 0;
var editorAutomationDispatching = false;
var sequence64HeldStep = -1;
var sequence64SelectedStep = -1;
var sequence64HeldStepChanged = false;
var sequence64PressedStep = -1;
var sequence64PressedStepWasEmpty = false;
var sequence64StepHoldOpened = false;
var sequence64PendingLengthIndex = -1;
var sequence64PendingBarIndex = -1;
var sequence64BarHoldCommitted = false;
var sequence64ShiftHeld = false;
var sequence64ShiftEditedSteps = new Array(64).fill(0);
var sequence64EditParameter = "slice";
var sequence64LiveRecordHeld = false;
var sequence64LockRecordHeld = false;
var sequence64ActiveShapes = [];
var sequence64DecisionFeedback = {};
var sequence64ClearArmedUntil = 0;
var sequence64RemoveBarArmedUntil = 0;
var sequence64PlaybackCaptureGuard = null;
var sequence64PlaybackPingGuard = null;
var sequence64PendingLiveCut = null;
var sequence64LiveLaneTracks = new Array(16).fill(-1);
var sequence64LiveRecordTake = null;
var sequence64LiveRecordTakeSerial = 0;
var sequence64PendingRunShortcut = null;
var sequence64ModMatrixActive = false;
var sequence64ModParameterPress = -1;
var sequence64ModSource = "lfo1";
var sequence64ModEditActive = false;
var sequence64InspectorContext = "parameter";
var sequence64InspectorLiveWrite = false;
var sequence64DeleteHeld = false;
var sequence64CopyGesture = null;
var sequence64CopyStepReleases = {};
var sequence64CopyHoldTask = new Task(function () {
 if (!sequence64CopyGesture) return;
 sequence64CopyGesture.used = true;
 publishHud("notice", "info", "Copy · tap a source step, then destinations");
 messnamed("togridmatrixio", "parameterLabel", "COPY");
 redrawEditorShellDiff();
}, this);
function cancelSequence64Copy() {
 sequence64CopyHoldTask.cancel();
 sequence64CopyGesture = null;
}
function handleSequence64CopyModifier(state) {
 var w = ensureEditorWorkspaceDefaults();
 if (state === 1 && (sequence64ShiftHeld || sequence64DeleteHeld)) return true;
 if (state === 1) {
  cancelSequence64Copy();
  sequence64StepHoldTask.cancel();
  sequence64PressedStep = -1;
  sequence64CopyGesture = {pattern:currentSequence64Pattern(), used:false, step:null};
  if (w.view64 === "sequence") sequence64CopyHoldTask.schedule(SEQUENCE64_HOLD_MS);
 } else if (sequence64CopyGesture) {
  var jump = !sequence64CopyGesture.used;
  cancelSequence64Copy();
  if (jump) jumpSequence64GroupTrackTarget();
 }
 redrawEditorShellDiff();
 return true;
}
function copySequence64Step(stepIndex) {
 var gesture = sequence64CopyGesture, w = ensureEditorWorkspaceDefaults();
 var pattern = currentSequence64Pattern(), bar = currentSequence64EditBar(pattern);
 if (!gesture || gesture.pattern !== pattern) { cancelSequence64Copy(); return true; }
 gesture.used = true;
 sequence64CopyHoldTask.cancel();
 if (!bar || stepIndex < 0 || stepIndex >= bar.length) return true;
 if (!gesture.step) {
  gesture.step = Scenes.clone(bar.steps[stepIndex]);
  publishHud("notice", "info", "Copied step " + (stepIndex + 1) + " · tap destinations");
  messnamed("togridmatrixio", "parameterLabel", "PASTE");
 } else {
  bar.steps[stepIndex] = Scenes.clone(gesture.step);
  clearSequence64Decision(w.targetType, w.targetId);
  markSessionDirty("ṛta step paste");
  publishHud("notice", "info", "Pasted step " + (stepIndex + 1));
  messnamed("togridmatrixio", "parameterLabel", "PASTE");
 }
 selectSequence64EditStep(stepIndex);
 redrawEditorShellDiff();
 return true;
}

var sceneShiftHeld = false;
var sequence64SliceAuditionTracks = new Array(16).fill(-1);
var sequence64ClockPosition = Math.max(0, (s.automation.tick || 0) * SEQUENCE64_STEPS_PER_PULSE);
// Display-only clock: selection breathes even with transport stopped.
var sequence64SelectionPulse = 1;
var sequence64SelectionPulsePending = false;
var sequence64SelectionPulseTask = new Task(function () {
 sequence64SelectionPulsePending = false;
 if (!sequence64SelectionPulseVisible()) return;
 sequence64SelectionPulse = (1 + Math.cos(Date.now() * Math.PI / 1000)) / 2;
 refreshSequence64SelectionCell();
 scheduleSequence64SelectionPulse();
}, this);
// The pulse touches one cell and never normalizes durable pattern data or
// rebuilds the inspector. Normal editor redraws handle moved/cleared selections.
function refreshSequence64SelectionCell() {
 var w = s.editorWorkspace;
 if (!w || !w.patterns64) return;
 var pattern = w.patterns64[editorTargetKey(w.targetType, w.targetId)];
 var bar = pattern && pattern.bars && pattern.bars[pattern.currentBar];
 if (!bar) return;
 var index = clamp(parseInt(sequence64SelectedStep, 10) || 0, 0, Math.max(0, bar.length - 1));
 var step = bar.steps[index];
 if (!step || !sequence64StepHasContent(step)) return;
 var locked = sequence64StepHasLocks(step);
 var rgb = locked ? SEQUENCE64_COLORS.lock : SEQUENCE64_OFF_COLOR;
 if (step.cut) rgb = locked ? SEQUENCE64_COLORS.triggerLock :
  step.cut.gateLength > 1 ? SEQUENCE64_COLORS.triggerGate : SEQUENCE64_COLORS.trigger;
 rgb = sequence64SelectionColor(rgb);
 var level = Math.round(11 + 4 * sequence64SelectionPulse);
 var playback = currentSequence64PlaybackLocation(pattern);
 if (sequence64TargetIsPlaying(w.targetType, w.targetId, pattern) &&
     playback.bar === pattern.currentBar && playback.step === index) {
  level = 15;
  rgb = sequence64DecisionColorAt(w.targetType, w.targetId, playback.bar, index) || SEQUENCE64_COLORS.playhead;
 }
 if (sequence64PressedStep === index) { level = 15; rgb = SEQUENCE64_COLORS.held; }
 var xy = sequence64StepCoords(index);
 applyEditorLevelDiff([[xy[0], xy[1], level, rgb]]);
}
function sequence64SelectionPulseVisible() {
 var w = ensureEditorWorkspaceDefaults();
 return editorWorkspaceAvailable() && sequence64LayoutEnabled() && w.active &&
  !w.collapsed && !w.choosing && w.view64 === "sequence" &&
  !sequence64ShiftHeld && !sequence64ModMatrixActive;
}
function scheduleSequence64SelectionPulse() {
 if (!sequence64SelectionPulsePending && sequence64SelectionPulseVisible()) {
  sequence64SelectionPulsePending = true;
  sequence64SelectionPulseTask.schedule(80);
 }
}
function sequence64SelectionColor(rgb) {
 var amount = 0.35 + 0.25 * sequence64SelectionPulse;
 var tint = [255, 155, 195];
 return rgb.map(function (v, i) { return Math.round(v * (1 - amount) + tint[i] * amount); });
}

var sequence64StepHoldTask = new Task(openSequence64StepEditorAfterHold, this);
var sequence64LengthHoldTask = new Task(commitSequence64LengthHold, this);
var sequence64BarHoldTask = new Task(commitSequence64BarHold, this);
var sequence64LiveRecordFinalizeTask = new Task(sequence64LiveRecordPendingTimeout, this);
var sequence64RunShortcutHoldTask = new Task(openSequence64RunShortcutAfterHold, this);
var sequence64ModMatrixHoldTask = new Task(openSequence64ModMatrixAfterHold, this);
var PLAYBACK_DISPLAY_INTERVAL_MS = 33;
var playbackDisplayPending = false;
var playbackDisplayEditorDirty = false;
var playbackDisplayTracks = {};
var playbackDisplayBackgroundTracks = {};
var playbackDisplayTask = new Task(flushPlaybackDisplay, this);
if (s.globalTransportRunning === undefined) s.globalTransportRunning = 0;
var sessionRecordingRestoreQueue = [];
var sessionRecordingRestoreTask = new Task(drainSessionRecordingRestores, this);
var SAMPLE_BROWSER_LIMIT = 240;
var SAMPLE_BROWSER_TOP_LAST_ROW = 7;
var SAMPLE_BROWSER_SAMPLE_FIRST_ROW = 1;
var SAMPLE_BROWSER_SAMPLE_LAST_ROW = 6;
var SAMPLE_BROWSER_FOOTER_ROW = 7;
var SAMPLE_BROWSER_PAGE_SIZE = 96;
var SAMPLE_BROWSER_FOLDER_FIRST_COL = 7;
var SAMPLE_BROWSER_FOLDER_LIMIT = 8;
var SAMPLE_BROWSER_EXIT_HOLD_MS = 650;
var MOD_RANDOMIZE_HOLD_MS = 450;
var sampleBrowserState = {
	active: false,
	count: 0,
	page: 0,
	folderCount: 1,
	folderIndex: 0,
	selectedTrack: 0,
	selectedSample: -1,
	sampleIndices: Array.from({ length: SAMPLE_BROWSER_LIMIT }, function (_, index) { return index; }),
	colors: new Array(SAMPLE_BROWSER_LIMIT).fill(null),
	assignments: new Array(16).fill(-1),
	sampleRefs: new Array(16).fill(null),
	exitTrack: -1
};
var sampleBrowserExitHoldTask = new Task(commitSampleBrowserExitHold, this);
var modRandomizePendingRow = -1;
var modRandomizeHoldCommitted = false;
var modRandomizeHoldTask = new Task(commitModRandomizeHold, this);
var editorLevelCache = new Array(16 * 16).fill(-1);
var editorColorCache = new Array(16 * 16).fill("");
var editorStateColorCache = new Array(16 * 16).fill("");
var editorMotionColorCache = new Array(16 * 16).fill("");
var editorScenePaletteVisible = false;
var playbackBg = createPlaybackBg();
var displayFrameActive = false;
var displayFrameForeground = null;
var displayFrameBackground = null;
var suppressDisplayWritesDepth = 0;
var trackHeldLoopCols = Array.from({ length: s.NUM_TRACKS }, function () { return {}; });
var channelSubLoopTasks = Array.from({ length: s.NUM_CHANNELS }, function () { return []; });

// Complete the reload safety boundary after all runtime collections exist.
// Pattern flags were cleared above; now stop any player still owned by a
// Sequence64 target and unwind every applied property stack to its base value.
for (var reloadChannelIdx = 0; reloadChannelIdx < s.NUM_CHANNELS; reloadChannelIdx++) {
	var reloadChannel = getChannelStateByIndex(reloadChannelIdx);
	if (!reloadChannel || !reloadChannel.sequence64Owner) continue;
	sendNamedInt((reloadChannelIdx + 1) + "[pl]stop", 1);
	reloadChannel.sequence64Owner = null;
	if (reloadChannel.activeTrack >= 0) reloadChannel.lastActiveTrack = reloadChannel.activeTrack;
	reloadChannel.activeTrack = -1;
}
restoreAllSequence64OwnedProperties();

// Crash-survivable playback diagnostics. Max's File API writes each JSON line
// immediately; keeping the file open avoids repeated open/close work while a
// sequence is running. The log is deliberately outside the project so it never
// enters a release archive or dirties the repository.
var DIAGNOSTIC_LOG_PATH = "/tmp/mlr-diagnostic.log";
var DIAGNOSTIC_LOG_MAX_BYTES = 8 * 1024 * 1024;
var diagnosticEnabled = true;
// Continuous playback tracing is opt-in: synchronous file writes share V8's
// low-priority queue with preparation of the next musical event.
var diagnosticPlaybackEnabled = false;
var diagnosticPlaybackEvents = {
	sequence64_trigger: 1, playback_position: 1, loop_restore: 1,
	subloop_apply: 1, sequence64_phrase_step: 1, sequence64_decision_skip: 1
};
var diagnosticFile = null;
var diagnosticSerial = 0;
var diagnosticWriteErrorReported = false;
var diagnosticSession = String(Date.now()) + "-" + String(Math.floor(Math.random() * 1000000));
var diagnosticHighRateLast = {};
var DIAGNOSTIC_HIGH_RATE_INTERVAL_MS = 100;
var DISPLAY_INCIDENT_LOG_PATH = "/tmp/mlr-display-incidents.jsonl";
var DISPLAY_INCIDENT_LOG_MAX_BYTES = 2 * 1024 * 1024;
var displayIncidentSerial = 0;
var pendingDisplayIncidents = {};
var pendingDisplayRecoveryId = "";

function writeDisplayIncident(record) {
	if (typeof File !== "function") return false;
	var file = null;
	try {
		file = new File(DISPLAY_INCIDENT_LOG_PATH, "readwrite");
		if (!file.isopen) file = new File(DISPLAY_INCIDENT_LOG_PATH, "write");
		if (!file.isopen) throw new Error("could not open display incident log");
		if (file.eof >= DISPLAY_INCIDENT_LOG_MAX_BYTES) {
			file.eof = 0;
			file.position = 0;
		} else file.position = file.eof;
		file.writeline(JSON.stringify(record));
		file.close();
		return true;
	} catch (error) {
		if (file && file.isopen) file.close();
		post("[grid_router] display incident write failed: " + error + "\n");
		return false;
	}
}

function openDiagnosticFile() {
	if (!diagnosticEnabled || typeof File !== "function") return null;
	if (diagnosticFile && diagnosticFile.isopen) return diagnosticFile;
	try {
		diagnosticFile = new File(DIAGNOSTIC_LOG_PATH, "readwrite");
		if (!diagnosticFile.isopen) diagnosticFile = new File(DIAGNOSTIC_LOG_PATH, "write");
		if (!diagnosticFile.isopen) throw new Error("could not open log");
		if (diagnosticFile.eof >= DIAGNOSTIC_LOG_MAX_BYTES) {
			diagnosticFile.eof = 0;
			diagnosticFile.position = 0;
		} else {
			diagnosticFile.position = diagnosticFile.eof;
		}
		return diagnosticFile;
	} catch (error) {
		diagnosticFile = null;
		if (!diagnosticWriteErrorReported) {
			diagnosticWriteErrorReported = true;
			post("[grid_router] diagnostic log unavailable: " + error + "\n");
		}
		return null;
	}
}

function diagnosticEvent(eventName, details) {
	if (!diagnosticEnabled ||
		(diagnosticPlaybackEvents[eventName] && !diagnosticPlaybackEnabled)) return false;
	var file = openDiagnosticFile();
	if (!file) return false;
	// Details may be a factory so disabled/suppressed events never build a
	// track snapshot or enter its workspace/playback lookup paths.
	if (typeof details === "function") details = details();
	var record = {
		time: new Date().toISOString(),
		session: diagnosticSession,
		serial: ++diagnosticSerial,
		event: String(eventName),
		tick: s.automation.tick || 0,
		sequenceClock: sequence64ClockPosition,
		kmod: s.kmod
	};
	if (details) {
		for (var key in details) {
			if (Object.prototype.hasOwnProperty.call(details, key)) record[key] = details[key];
		}
	}
	try {
		var line = JSON.stringify(record);
		if (file.eof + line.length + 1 >= DIAGNOSTIC_LOG_MAX_BYTES) {
			file.eof = 0;
			file.position = 0;
			file.writeline(JSON.stringify({
				time: new Date().toISOString(),
				session: diagnosticSession,
				serial: diagnosticSerial,
				event: "log_rotated",
				nextSerial: diagnosticSerial + 1
			}));
			record.serial = ++diagnosticSerial;
			line = JSON.stringify(record);
		}
		file.writeline(line);
		return true;
	} catch (error) {
		if (diagnosticFile && diagnosticFile.isopen) diagnosticFile.close();
		diagnosticFile = null;
		if (!diagnosticWriteErrorReported) {
			diagnosticWriteErrorReported = true;
			post("[grid_router] diagnostic write failed: " + error + "\n");
		}
		return false;
	}
}

// Playback position and phrase clock callbacks can arrive dozens of times per
// second. Preserve crash context without turning synchronous File writes into
// another source of low-priority queue pressure.
function diagnosticEventRateLimited(eventName, sourceKey, details) {
	if (!diagnosticEnabled ||
		(diagnosticPlaybackEvents[eventName] && !diagnosticPlaybackEnabled)) return false;
	var key = String(eventName) + ":" + String(sourceKey);
	var now = Date.now();
	if (diagnosticHighRateLast[key] !== undefined &&
		now - diagnosticHighRateLast[key] < DIAGNOSTIC_HIGH_RATE_INTERVAL_MS) return false;
	diagnosticHighRateLast[key] = now;
	return diagnosticEvent(eventName, details);
}

function diagnosticTrackSnapshot(trackIdx, slice) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return { track: trackIdx + 1, invalidTrack: 1 };
	var channelIdx = trackChannelIndex(trackIdx);
	var channelState = getChannelStateByIndex(channelIdx);
	var workspace = ensureEditorWorkspaceDefaults();
	var targetKey = editorTargetKey(workspace.targetType, workspace.targetId);
	var pattern = workspace.patterns64[targetKey];
	var playback = pattern ? sequence64PlaybackLocation(pattern) : null;
	return {
		track: trackIdx + 1,
		channel: channelIdx + 1,
		buffer: trackState.buffer,
		slice: slice === undefined ? trackState.playPos + 1 : slice + 1,
		trackSlices: trackState.length,
		playPosition: trackState.playPos + 1,
		octave: trackState.octave,
		transpose: trackState.transpose,
		speed: trackState.speed,
		speedMode: trackState.speedMode,
		reverse: trackState.reverse ? 1 : 0,
		loopActive: trackState.loopActive ? 1 : 0,
		playbackLoop: trackState.playbackLoop ? 1 : 0,
		loopStart: trackState.loopStart,
		loopEnd: trackState.loopEnd,
		subLoopDivision: currentTrackSubLoopDiv(trackIdx),
		latch: channelState && channelState.gateLatch ? 1 : 0,
		channelActiveTrack: channelState ? channelState.activeTrack + 1 : 0,
		targetType: workspace.targetType,
		target: workspace.targetId + 1,
		run: pattern && pattern.running ? 1 : 0,
		bar: playback ? playback.bar + 1 : 0,
		step: playback ? playback.step + 1 : 0,
		record: sequence64LockRecordHeld ? 1 : 0
	};
}

function diagnosticLogging(value) {
	diagnosticEnabled = parseInt(value, 10) ? true : false;
	diagnosticPlaybackEnabled = diagnosticEnabled;
	if (!diagnosticEnabled && diagnosticFile && diagnosticFile.isopen) diagnosticFile.close();
	diagnosticFile = null;
	diagnosticWriteErrorReported = false;
	diagnosticHighRateLast = {};
	if (diagnosticEnabled) diagnosticEvent("logging_enabled");
	post("[grid_router] diagnostic logging " + (diagnosticEnabled ? "on" : "off") +
		", playback tracing " + (diagnosticPlaybackEnabled ? "on" : "off") +
		" — " + DIAGNOSTIC_LOG_PATH + "\n");
}

function diagnosticMark() {
	var parts = arrayfromargs(arguments);
	diagnosticEvent("mark", { label: parts.join(" ") });
}

function diagnosticBufferLoad(path, fileIndex, channels, durationMs, sampleRate) {
	diagnosticEvent("buffer_load_request", {
		path: String(path),
		buffer: parseInt(fileIndex, 10) || 0,
		channels: parseInt(channels, 10) || 0,
		durationMs: parseFloat(durationMs) || 0,
		sampleRate: parseFloat(sampleRate) || 0
	});
	// The existing buffer loader is the authoritative source for media metadata.
	// Mirror that information to the sample-bank/HUD without touching audio.
	messnamed("sample_bank", "bufferMetadata", String(path),
		parseInt(fileIndex, 10) || 0, parseInt(channels, 10) || 0,
		parseFloat(durationMs) || 0, parseFloat(sampleRate) || 0);
}

function diagnosticStatus() {
	diagnosticEvent("status");
	post("[grid_router] diagnostic logging " + (diagnosticEnabled ? "on" : "off") +
		", playback tracing " + (diagnosticPlaybackEnabled ? "on" : "off") +
		" — " + DIAGNOSTIC_LOG_PATH + "\n");
}

// Initial palettes for the three active kmod pages. These are intentionally simple
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
	sequenceRun: [225, 45, 70],
	insertFx: [155, 55, 255],
	meter: [35, 230, 95],
	randomize: [255, 105, 15],
	automation: [255, 35, 105],
	quantize: [15, 210, 180],
	subLoop: [30, 145, 255],
	randomOffset: [215, 55, 255],
	octave: [70, 120, 255],
	reverse: [255, 65, 35],
	groupsBase: [28, 42, 72]
};

var GROUP_COLORS = [
	[255, 65, 55], [255, 135, 20], [245, 205, 30], [40, 215, 90],
	[0, 195, 210], [35, 125, 255], [135, 75, 255], [235, 55, 190]
];

var SEQUENCE64_COLORS = {
	neutral: [18, 46, 70],
	unavailable: [8, 12, 18],
	trigger: [0, 210, 255],
	triggerGate: [45, 230, 105],
	lock: [255, 180, 20],
	triggerLock: [210, 65, 255],
	gateTail: [70, 90, 225],
	playhead: [255, 255, 255],
	conditionPlay: [255, 135, 25],
	conditionSkip: [255, 45, 55],
	probabilityPlay: [255, 225, 35],
	probabilitySkip: [185, 70, 255],
	trackPosition: [175, 255, 35],
	held: [255, 105, 25],
	length: [45, 190, 255],
	bar: [90, 115, 255],
	add: [45, 230, 95],
	remove: [255, 55, 45],
	run: [35, 235, 90],
	record: [255, 45, 110],
	restart: [235, 235, 255],
	stop: [255, 75, 35],
	targetJump: [175, 255, 35],
	sampleBrowser: [190, 85, 255],
	shift: [190, 85, 255],
	rate: [255, 145, 25],
	motion: [255, 135, 25],
	restore: [45, 140, 255],
	sequence: [0, 210, 255],
	setup: [255, 175, 25],
	exit: [255, 55, 45],
	volume: [50, 225, 100],
	octave: [85, 125, 255],
	transpose: [125, 95, 255],
	reverse: [255, 65, 40],
	random: [220, 55, 255],
	division: [20, 190, 220],
	loopStart: [35, 220, 100],
	loopEnd: [255, 100, 35],
	latch: [255, 165, 25],
	stretch: [0, 205, 235],
	mute: [255, 45, 45],
	playbackLoop: [45, 230, 105]
};
var SEQUENCE64_OFF_COLOR = [0, 0, 0];

var SEQUENCE64_PARAMETER_COLORS = [
	[0, 210, 255], [245, 205, 30], [50, 225, 100], [255, 135, 25],
	[255, 65, 40], [125, 95, 255], [20, 190, 220], [235, 55, 190],
	[175, 255, 35], [255, 105, 25]
];

var SEQUENCE64_BEHAVIOR_COLORS = [
	[235, 235, 255], [0, 210, 255], [255, 125, 25],
	[155, 75, 255], [45, 230, 105], [235, 55, 190]
];

// Runtime color-lab roles. The HUD edits these arrays in place; defaults are
// captured once at script load so experimentation can always be reset. Names
// are protocol-stable while labels are derived in the portable HUD model.
var HUD_PAGE_COLOR_KEYS = [
	"mainBase", "mainChannels", "mainPatterns", "mainClock", "mainPage",
	"modBase", "mute", "volume", "timestretch", "sequenceRun", "insertFx",
	"meter", "randomize", "automation", "quantize", "randomOffset",
	"octave", "reverse", "groupsBase"
];
var HUD_RTA_COLOR_KEYS = [
	"neutral", "unavailable", "trigger", "triggerGate", "lock", "triggerLock",
	"gateTail", "playhead", "conditionPlay", "conditionSkip", "probabilityPlay",
	"probabilitySkip", "trackPosition", "held", "length", "bar", "add",
	"remove", "run", "record", "restart", "stop", "targetJump", "sampleBrowser", "shift",
	"rate", "motion", "restore", "sequence", "setup", "exit", "volume",
	"octave", "transpose", "reverse", "random", "division", "loopStart",
	"loopEnd", "latch", "stretch", "mute", "playbackLoop"
];
var hudColorDefaults = {};

function hudColorRoleEntries() {
	var entries = [];
	for (var pageIndex = 0; pageIndex < HUD_PAGE_COLOR_KEYS.length; pageIndex++) {
		var pageKey = HUD_PAGE_COLOR_KEYS[pageIndex];
		entries.push({ name: "page." + pageKey, category: "PAGE", value: PAGE_COLORS[pageKey] });
	}
	for (var groupIndex = 0; groupIndex < GROUP_COLORS.length; groupIndex++) {
		entries.push({ name: "group." + (groupIndex + 1), category: "GROUP", value: GROUP_COLORS[groupIndex] });
	}
	for (var rtaIndex = 0; rtaIndex < HUD_RTA_COLOR_KEYS.length; rtaIndex++) {
		var rtaKey = HUD_RTA_COLOR_KEYS[rtaIndex];
		entries.push({ name: "rta." + rtaKey, category: "RTA", value: SEQUENCE64_COLORS[rtaKey] });
	}
	return entries;
}

function captureHudColorDefaults() {
	var entries = hudColorRoleEntries();
	for (var index = 0; index < entries.length; index++) {
		var value = entries[index].value;
		hudColorDefaults[entries[index].name] = [value[0], value[1], value[2]];
	}
}

captureHudColorDefaults();

var initialPageColorTask = new Task(function () {
	if (s.autoPageColors) initializePageColorPresets();
}, this);

var initialDisplayFrameTask = new Task(function () {
	renderCompletePage(s.kmod, true);
}, this);

var hardwareResyncVerifyTask = new Task(function () {
	// Resend the already committed level frame without redrawing. A redraw here
	// can mutate the still-draining palette queue and leave firmware presets
	// half populated.
	messnamed("togridmatrixio", "flush");
	diagnosticEvent("hardware_resync_level_verify", { page: s.kmod });
}, this);

var displayRecoveryCompleteTask = new Task(function () {
	if (!pendingDisplayRecoveryId) return;
	var incidentId = pendingDisplayRecoveryId;
	pendingDisplayRecoveryId = "";
	messnamed("togridmatrixio", "diagnostic_snapshot", incidentId + ":after");
	diagnosticEvent("display_recover_complete", {
		incident: incidentId,
		page: s.kmod,
		colorQueueRemaining: pageColorQueue.length
	});
	publishHud("notice", "info", "Grid reinitialized · " + incidentId);
}, this);

// libmonome writes extension packets directly to a nonblocking serial fd.
// Palette maps are lightly paced so legacy level/map frames retain priority;
// sparse semantic changes continue to use immediate single-cell commands.
var PAGE_COLOR_INTERVAL_MS = 4;
var PAGE_COLOR_MAP_INTERVAL_MS = 8;
var pageColorQueue = [];
var pageColorQueueTask = new Task(drainPageColorQueue, this);
var pageColorPresetReady = new Array(8).fill(0);

// ─── Helpers ────────────────────────────────────────────────────────────

function clamp(v, lo, hi) {
	return Math.min(hi, Math.max(lo, v));
}

function sequence64EmptyStepLevel() {
	return SEQUENCE64_EMPTY_STEP_LEVEL;
}

function sendNamedInt(bus, value) {
	messnamed(bus, "int", parseInt(value, 10) || 0);
}

// V8 is always serviced on Max's low-priority thread. Sequence64 therefore
// prepares the cut here, but a native Max bridge releases it on the following
// audio-derived sequence64 pulse. Manual/live cuts intentionally retain their
// immediate path.
function sequence64InstrumentStepOverrides(trackIdx, step) {
	var instrument = instrumentDescriptorForTrack(trackIdx);
	if (!instrument || !step || !step.locks) return null;
	var overrides = {};
	var count = 0;
	instrument.locks.forEach(function (id) {
		if (!step.locks[id]) return;
		overrides[id] = instrumentClampValue(id, step.locks[id].value);
		count++;
	});
	return count ? overrides : null;
}

function mergeSequence64InstrumentOverrides(base, override) {
	var merged = {}, count = 0, id;
	base = base || {};
	override = override || {};
	for (id in base) { merged[id] = base[id]; count++; }
	for (id in override) {
		if (!Object.prototype.hasOwnProperty.call(merged, id)) count++;
		merged[id] = override[id];
	}
	return count ? merged : null;
}

function armSequence64AudioTrigger(channelIdx, trackIdx, position, instrumentOverrides) {
	if (!rtaEnabled()) return false;
	if (channelIdx < 0 || channelIdx >= s.NUM_CHANNELS ||
		trackIdx < 0 || trackIdx >= s.NUM_TRACKS) return false;
	applyTrackPlaybackLoop(trackIdx);
	var arm = ["sequence64_audio_arm", channelIdx + 1, trackIdx + 2,
		clamp(parseInt(position, 10) || 0, 0, 15)];
	var instrument = instrumentDescriptorForTrack(trackIdx);
	if (instrument) {
		var baseline = instrumentSanitize(trackIdx, getTrackStateByIndex(trackIdx).instrumentParameters);
		instrument.locks.forEach(function (id) {
			arm.push(instrumentOverrides && instrumentOverrides[id] !== undefined ?
				instrumentClampValue(id, instrumentOverrides[id]) : baseline[id]);
		});
	}
	messnamed.apply(this, arm);
	return true;
}

function cancelSequence64AudioForChannel(channelIdx) {
	if (channelIdx < 0 || channelIdx >= s.NUM_CHANNELS) return false;
	if (sequence64NativeGroups[channelIdx] || sequence64NativePending) releaseNativeSequence64("channel_cancel", true);
	sendNamedInt("sequence64_audio_cancel", channelIdx + 1);
	return true;
}

// Experimental, explicit opt-in only. This state is never stored in a session.
// The optional bridge must acknowledge the full cache before V8 yields groups.
var sequence64NativeGroups = {};
var sequence64NativePending = null;
var sequence64NativeRequest = 0;
var sequence64NativeGeneration = 0;
var sequence64NativeEpoch = 0;
// Autowatch reload must silence an old external before this new V8 instance
// resumes the ordinary sequencer path with empty local ownership metadata.
messnamed("sequence64_native_control", "stop");
if (Product.rta) messnamed("sequence64_native_control", "reset");
var sequence64NativeTimeout = new Task(function () {
	if (!sequence64NativePending) return;
	releaseNativeSequence64("bridge_timeout", true);
	publishHud("notice", "error", "Native cache bridge did not acknowledge; playback remains stopped");
}, this);

function nativeSequence64Control() {
	if (!Product.rta) return false;
	messnamed.apply(this, ["sequence64_native_control"].concat(arrayfromargs(arguments)));
}

function releaseNativeSequence64(reason, stopGroups) {
	var hadOwnership = false;
	for (var group in sequence64NativeGroups) hadOwnership = true;
	var hadPending = !!sequence64NativePending;
	sequence64NativePending = null;
	sequence64NativeTimeout.cancel();
	var previous = sequence64NativeGroups;
	sequence64NativeGroups = {}; // clear before cancellation feedback
	if (hadOwnership || hadPending || reason === "load" || reason === "session_stop") {
		nativeSequence64Control("stop");
		nativeSequence64Control("abort");
		nativeSequence64Control("reset");
	}
	for (var key in previous) {
		var channel = parseInt(key, 10);
		sendNamedInt("sequence64_audio_cancel", channel + 1);
		if (stopGroups) {
			var pattern = s.editorWorkspace.patterns64["group:" + channel];
			if (pattern) pattern.running = 0;
			var channelState = getChannelStateByIndex(channel);
			sendNamedInt((channel + 1) + "[pl]stop", 1);
			channelState.sequence64Owner = null;
			if (channelState.activeTrack >= 0) channelState.lastActiveTrack = channelState.activeTrack;
			channelState.activeTrack = -1;
		}
	}
	if (hadOwnership) {
		publishHud("notice", "info", "Native cache released: " + String(reason || "stop"));
		queuePlaybackDisplay(true);
		if (stopGroups) reconcileSequence64Transport("native_released");
	}
	return hadOwnership || hadPending;
}

function nativeSequence64Stop() {
	releaseNativeSequence64("explicit_stop", true);
	reconcileSequence64Transport("native_stop");
}

function nativeSequence64Groups() {
	if (!rtaEnabled()) return false;
	var groups = arrayfromargs(arguments).map(function (value) { return Number(value) - 1; });
	var workspace = ensureEditorWorkspaceDefaults();
	if (!sequence64LayoutEnabled() || s.globalTransportRunning || sequence64HasPlaybackActivity() ||
		workspace.pendingSceneLaunch || sequence64LiveRecordHeld || s.sequencers.some(function (sequencer) { return !!sequencer.on; })) {
		publishHud("notice", "error", "Stop all patterns and transport before starting the native cache experiment");
		return false;
	}
	var snapshot = {patterns: workspace.patterns64, tracks: [],
		modulation: workspace.modulation, automation: s.automation, targetAutomation: workspace.targetAutomation};
	for (var track = 0; track < s.NUM_TRACKS; track++) snapshot.tracks.push(sceneTrackSnapshot(track));
	var compiler;
	try {
		compiler = require("sequence64_native_compile.js");
		compiler.compile(snapshot, {epoch: 1, generation: 1, groupIds: groups});
	} catch (error) {
		publishHud("notice", "error", String(error.message || error));
		return false;
	}
	releaseNativeSequence64("new_request", true);
	sequence64NativePending = {nonce: ++sequence64NativeRequest, groups: groups,
		// Freeze preparation input; edits cancel this pending request.
		snapshot: JSON.parse(JSON.stringify(snapshot)), compiler: compiler, phase: "hello"};
	sequence64NativeTimeout.schedule(2000);
	nativeSequence64Control("hello", sequence64NativePending.nonce);
	return true;
}

function nativeSequence64Report(kind, epoch, generation) {
	if (!rtaEnabled()) return false;
	if (kind === "offline") { releaseNativeSequence64("bridge_closed", true); return; }
	if (kind === "frame") {
		var group = Number(generation) - 1;
		var track = Number(arguments[3]) - 2;
		var slice = Number(arguments[4]);
		if (epoch !== sequence64NativeEpoch || !sequence64NativeGroups[group] ||
			!Number.isInteger(track) || track < 0 || track >= s.NUM_TRACKS ||
			!Number.isInteger(slice) || slice < 0 || slice > 15 || trackChannelIndex(track) !== group) return;
		var channel = getChannelStateByIndex(group);
		var trackState = getTrackStateByIndex(track);
		channel.activeTrack = track;
		channel.sequence64Owner = "group:" + group;
		trackState.playPos = slice;
		trackState.subLoopAnchor = slice;
		var pattern = s.editorWorkspace.patterns64["group:" + group];
		if (pattern) { pattern.lastTriggeredTrack = track; pattern.lastTriggeredChannel = group; }
		clearChannelPlaybackPositions(group, track, true);
		primeTrackPlaybackPosition(track, slice, true);
		playbackDisplayTracks[track] = {position: slice, returnedEditorPing: false};
		queuePlaybackDisplay(false);
		pulseSequence64RunKey("group", group);
		return;
	}
	var pending = sequence64NativePending;
	if (!pending) return;
	if (kind === "rejected") {
		releaseNativeSequence64("upload_rejected", true);
		publishHud("notice", "error", "Native upload rejected; playback remains stopped");
		return;
	}
	if (kind === "hello" && pending.phase === "hello" && generation === pending.nonce) {
		if (arguments[3] !== 1) {
			releaseNativeSequence64("old_external", true);
			publishHud("notice", "error", "Restart Max to load the updated native external");
			return;
		}
		sequence64NativeEpoch = epoch;
		pending.generation = ++sequence64NativeGeneration;
		pending.phase = "commit";
		var plan = pending.compiler.compile(pending.snapshot,
			{epoch: epoch, generation: pending.generation, groupIds: pending.groups});
		plan.messages.forEach(function (message) { nativeSequence64Control.apply(this, message); });
		return;
	}
	if (kind !== "committed" || pending.phase !== "commit" ||
		epoch !== sequence64NativeEpoch || generation !== pending.generation) return;
	sequence64NativePending = null;
	sequence64NativeTimeout.cancel();
	var workspace = ensureEditorWorkspaceDefaults();
	pending.groups.forEach(function (group) {
		// Clear legacy one-shot registers before exclusive native start.
		sendNamedInt("sequence64_audio_cancel", group + 1);
		nativeSequence64Control("resume", epoch, group + 1);
		sequence64NativeGroups[group] = true;
		var pattern = workspace.patterns64["group:" + group];
		pattern.running = 1;
		pattern.phaseOrigin = sequence64ClockPosition + 1;
		pattern.lastSequencedFlat = -1;
		pattern.lastSequencedAbsolute = -1;
		pattern.restartArmed = 0;
		var channel = getChannelStateByIndex(group);
		channel.sequence64Owner = "group:" + group;
	});
	nativeSequence64Control("rewind");
	nativeSequence64Control("start", epoch);
	startSequence64Transport("native_cache");
	queuePlaybackDisplay(true);
	publishHud("notice", "info", "Native drum cache running (experimental)");
}

function publishHud() {
	var args = arrayfromargs(arguments);
	messnamed.apply(this, ["mlr_hud_state"].concat(args));
}

var sessionStateApplying = false;

function markSessionDirty(reason) {
	// This bounded experiment stops on edits; it never plays an obsolete cache
	// or silently drops unsupported semantics. The next ordinary Run uses V8.
	releaseNativeSequence64("edit", true);
	if (!sessionStateApplying) {
		messnamed("mlr_session_dirty", "dirty", String(reason || "router"));
	}
}

function publishHudColorEntry(entry) {
	if (!entry || !entry.value) return;
	publishHud("color_role", entry.name, entry.category,
		entry.value[0], entry.value[1], entry.value[2]);
}

function publishHudColorSnapshot() {
	var entries = hudColorRoleEntries();
	for (var index = 0; index < entries.length; index++) publishHudColorEntry(entries[index]);
}

function hudColorEntryNamed(name) {
	var requested = String(name || "");
	var entries = hudColorRoleEntries();
	for (var index = 0; index < entries.length; index++) {
		if (entries[index].name === requested) return entries[index];
	}
	return null;
}

function refreshRuntimeColors() {
	for (var slot = 0; slot < 3; slot++) pageColorPresetReady[slot] = 0;
	resetPageColorQueue();
	if (sampleBrowserState.active) applySampleBrowserColors();
	else applyPageColors(clamp(s.kmod, 1, 3));
}

function hudColorRole(name, red, green, blue) {
	var entry = hudColorEntryNamed(name);
	if (!entry) {
		publishHud("notice", "error", "Unknown color role " + String(name || ""));
		return false;
	}
	entry.value[0] = clamp8(red);
	entry.value[1] = clamp8(green);
	entry.value[2] = clamp8(blue);
	refreshRuntimeColors();
	publishHudColorEntry(entry);
	publishHud("notice", "info", "Color updated: " + entry.name);
	markSessionDirty("color");
	return true;
}

function hudColorReset(name) {
	var requested = String(name || "all");
	var entries = hudColorRoleEntries();
	var changed = 0;
	for (var index = 0; index < entries.length; index++) {
		var entry = entries[index];
		if (requested !== "all" && entry.name !== requested) continue;
		var original = hudColorDefaults[entry.name];
		if (!original) continue;
		entry.value[0] = original[0];
		entry.value[1] = original[1];
		entry.value[2] = original[2];
		publishHudColorEntry(entry);
		changed++;
	}
	if (!changed) {
		publishHud("notice", "error", "Unknown color role " + requested);
		return false;
	}
	refreshRuntimeColors();
	publishHud("notice", "info", requested === "all" ?
		"Runtime colors reset" : ("Color reset: " + requested));
	markSessionDirty("color reset");
	return true;
}

function publishHudTrackState(trackIdx) {
	var track = getTrackStateByIndex(trackIdx);
	if (!track) return;
	var buffer = parseInt(track.buffer, 10);
	if (!isFinite(buffer)) buffer = -1;
	publishHud("track", trackIdx, clamp((parseInt(track.channel, 10) || 1) - 1, 0, 7),
		buffer, track.length, track.playPos, track.octave, track.transpose,
		track.reverse ? 1 : 0, track.loopStart, track.loopEnd, track.subLoopDiv,
		track.loopActive ? 1 : 0,
		buffer >= SAMPLE_BANK_FIRST_BUFFER ? buffer - SAMPLE_BANK_FIRST_BUFFER : -1,
		track.playbackLoop ? 1 : 0);
}

function publishHudChannelState(channelIdx) {
	var channel = getChannelStateByIndex(channelIdx);
	if (!channel) return;
	publishHud("channel", channelIdx, channel.volume, channel.muted ? 1 : 0,
		channel.timestretch ? 1 : 0, channel.gateLatch ? 1 : 0,
		channel.activeTrack, channel.lastActiveTrack, channel.on ? 1 : 0);
}

function hudPatternSummaryValues(targetType, targetId, pattern) {
	var rate = sequence64PatternRate(pattern);
	var bars = pattern && pattern.bars && pattern.bars.length ? pattern.bars.length : 1;
	var currentBar = pattern ? clamp(parseInt(pattern.currentBar, 10) || 0, 0, bars - 1) : 0;
	var length = pattern && pattern.bars && pattern.bars[currentBar] ?
		pattern.bars[currentBar].length : (targetType === "track" ? 16 : 64);
	return [targetType, targetId, pattern && pattern.running ? 1 : 0, bars,
		currentBar, length, rate.numerator, rate.denominator,
		pattern && sequence64PatternHasContent(pattern) ? 1 : 0];
}

function publishHudPatternSummary(targetType, targetId, pattern) {
	publishHud.apply(this, ["pattern_summary"].concat(
		hudPatternSummaryValues(targetType, targetId, pattern)));
}

function hudPatternSnapshotObject(targetType, targetId, pattern) {
	if (!pattern) return null;
	var currentBar = clamp(parseInt(pattern.currentBar, 10) || 0, 0, pattern.bars.length - 1);
	var bar = pattern.bars[currentBar];
	var playback = sequence64TargetPlaybackLocation(targetType, targetId, pattern);
	var rate = sequence64PatternRate(pattern);
	var snapshot = {
		targetType: targetType,
		targetId: targetId,
		running: pattern.running ? 1 : 0,
		bars: pattern.bars.length,
		currentBar: currentBar,
		length: bar.length,
		rateNumerator: rate.numerator,
		rateDenominator: rate.denominator,
		defaultTrack: pattern.defaultTrack === undefined ? -1 : pattern.defaultTrack,
		playheadBar: playback.bar,
		playheadStep: playback.step,
		decisionOutcome: sequence64DecisionOutcomeAt(targetType, targetId,
			playback.bar, playback.step),
		steps: []
	};
	for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
		var step = bar.steps[stepIndex] || createSequence64Step();
		var cut = step.cut ? {
			track: parseInt(step.cut.track, 10),
			slice: parseInt(step.cut.slice, 10),
			gateLength: parseInt(step.cut.gateLength, 10) || 1
		} : null;
		var locks = {};
		for (var parameter in step.locks) {
			var lock = step.locks[parameter];
			if (!lock) continue;
			locks[parameter] = {
				value: lock.value,
				behavior: lock.behavior || "set"
			};
		}
		snapshot.steps.push({
			cut: cut,
			probability: step.probability,
			condition: step.condition || 0,
			locks: locks
		});
	}
	return snapshot;
}

function publishHudPatternSnapshot(targetType, targetId, pattern) {
	var snapshot = hudPatternSnapshotObject(targetType, targetId, pattern);
	if (!snapshot) return;
	publishHud("pattern_snapshot", JSON.stringify(snapshot));
	publishHudPatternSummary(targetType, targetId, pattern);
}

var lastParameterFocusSelection = "", lastParameterFocusPayload = "", pendingParameterPageLabel = false;
var PARAMETER_LABELS = {
 tomPitch:"PCH",tomDecay:"DEC",tomBend:"BND",tomBendDecay:"BDC",tomFM:"FM",tomRatio:"RAT",tomModeRatio:"MRAT",tomModeLevel:"MLV",tomNoise:"NOIS",tomNoiseDecay:"NDC",tomDrive:"DRV",tomLevel:"LVL",
 rimPitch:"PCH",rimDecay:"DEC",rimModeRatio:"MRAT",rimModeLevel:"MLV",rimClick:"CLK",rimNoiseDecay:"NDC",rimFilterHz:"FRQ",rimFilterQ:"Q",rimFM:"FM",rimRatio:"RAT",rimDrive:"DRV",rimLevel:"LVL",
 bellPitch:"PCH",bellDecay:"DEC",bellRatio:"RAT",bellFM:"FM",bellFMDecay:"FDC",bellInharmonicity:"INH",bellModeLevel:"MLV",bellModeDecay:"MDC",bellStrike:"HIT",bellBrightness:"BRT",bellDrive:"DRV",bellLevel:"LVL",
 bassNote:"NOTE",bassDecay:"DEC",bassFM:"FM",bassRatio:"RAT",bassFMDecay:"FDC",bassFeedback:"FDBK",bassSub:"SUB",bassBrightness:"BRT",bassAttack:"ATK",bassBend:"BND",bassDrive:"DRV",bassLevel:"LVL",
 kickPitch:"PCH",kickDecay:"DEC",kickSweep:"SWP",kickSweepDecay:"SWD",
 kickFM:"FM",kickFMRatio:"RAT",kickClick:"CLK",kickDrive:"DRV",
 kickResMix:"MIX",kickResHz:"FRQ",kickResQ:"RQ",kickLevel:"LVL",
 clapCount:"CNT",clapSpacing:"SPC",clapBurstDecay:"BDC",clapScatter:"SCTR",
 clapFilterHz:"FRQ",clapFilterQ:"Q",clapBrightness:"BRT",clapDrive:"DRV",
 clapTailDecay:"TDC",clapTailLevel:"TLV",clapBalance:"BAL",clapLevel:"LVL",
 hatPitch:"PIT",hatSpread:"SPRD",hatInharmonicity:"INH",hatMetalLevel:"MTL",
 hatDecay:"DEC",hatNoiseDecay:"NDC",hatAttack:"ATK",hatNoiseLevel:"NLV",
 hatFilterHz:"FRQ",hatFilterQ:"Q",hatDrive:"DRV",hatLevel:"LVL",
 snareBodyHz:"BHZ",snareBodyDecay:"BDC",snareBodyBend:"BND",snareBodyFM:"BFM",
 snareNoiseDecay:"NDC",snareNoiseHz:"NFQ",snareNoiseQ:"NQ",snareSnap:"SNAP",
 snareBodyLevel:"BLV",snareNoiseLevel:"NLV",snareDrive:"DRV",snareLevel:"LVL",
 slice:"SLC",probability:"PROB",volume:"VOL",filter:"FILT",reverse:"REV",
 transpose:"NOTE",loopDivision:"DIV",gateLength:"GATE",track:"TRK",condition:"COND"
};
function publishParameterFocus(force) {
 var w=ensureEditorWorkspaceDefaults(), id=sequence64EditParameter;
 var active=sequence64LayoutEnabled() && s.kmod===2 && w.active && !w.choosing && !w.collapsed &&
  w.view64==="sequence" && sequence64InspectorContext==="parameter";
 var def=instrumentDefinition(id), step=active ? sequence64InstrumentEditStep() : null;
 var targetInstrument=active ? sequence64InstrumentTarget(step) : null;
 if (def && (!sequence64InstrumentPage || !targetInstrument ||
  instrumentDescriptorForParameter(id)!==targetInstrument)) active=false;
 var payload={active:!!active};
 if (active && step) {
  var track=sequence64TargetTrackIndex(w.targetType,w.targetId,step), lock=step.locks[id];
  var names={slice:"Slice",probability:"Probability",volume:"Volume",filter:"Filter",reverse:"Reverse",transpose:"Transpose",loopDivision:"Loop division",gateLength:"Gate length",track:"Track",condition:"Condition"};
  var baseEdit=!!def && sequence64InstrumentBaseEdit && !sequence64InspectorLiveWrite;
  var value=lock && !baseEdit ? lock.value : sequence64CurrentPropertyValue(id,trackChannelIndex(track),track);
  var layer=baseEdit ? "Baseline" : lock ? (w.targetType==="group" ? "Group override" : "Track lock") : "No step lock · current value";
  if (def && baseEdit) value=instrumentSanitize(track,getTrackStateByIndex(track).instrumentParameters)[id];
  if(id==="slice") value=lock ? lock.value+1 : step.cut ? step.cut.slice+1 : "—";
  if(id==="probability") {value=Math.round(step.probability/15*100);layer="Step value";}
  if(id==="condition") {value=step.condition||"Always";layer="Step value";}
  if(id==="gateLength") {value=step.cut ? step.cut.gateLength : "—";layer="Step value";}
  if(id==="track") {value=track>=0 ? track+1 : "—";layer="Step assignment";}
  if(id==="reverse") value=value ? "On" : "Off";
  var pattern=currentSequence64Pattern(), pos=sequence64InspectorLiveWrite || sequence64LockRecordHeld ?
   currentSequence64PlaybackLocation(pattern) : {bar:pattern.currentBar,step:currentSequence64EditStepIndex()};
  payload={active:true,id:id,name:def ? def.name : names[id]||id,
   value:typeof value==="number" ? Math.round(value*1000)/1000 : value,
   unit:def ? def.unit : id==="probability" ? "%" : id==="transpose" ? "st" : "",
   track:track+1,group:w.targetType==="group" ? w.targetId+1 : 0,bar:pos.bar+1,step:pos.step+1,
   page:def ? targetInstrument.name + " " + (sequence64InstrumentBank+1) + "/3 · " + targetInstrument.pages[sequence64InstrumentBank].name : "",
   layer:layer,liveWrite:!!sequence64InspectorLiveWrite};
 }
 var selection=payload.active ? w.targetType+":"+w.targetId+":"+id+":"+(sequence64InstrumentPage?sequence64InstrumentBank:"sample") : "";
 if(pendingParameterPageLabel || selection!==lastParameterFocusSelection) {
  var label=pendingParameterPageLabel && targetInstrument ? targetInstrument.pageLabels[sequence64InstrumentBank] : PARAMETER_LABELS[id]||"PAR";
  if(selection) messnamed("togridmatrixio","parameterLabel",label);
  else messnamed("togridmatrixio","parameterLabelClear");
  lastParameterFocusSelection=selection;
 }
 pendingParameterPageLabel=false;
 var json=JSON.stringify(payload);
 if(force || json!==lastParameterFocusPayload) {publishHud("parameter_focus",json);lastParameterFocusPayload=json;}
}

function publishHudEditorState() {
	publishParameterFocus(true);
	var workspace = ensureEditorWorkspaceDefaults();
	publishHud("editor", workspace.active ? 1 : 0, workspace.choosing ? 1 : 0,
		workspace.targetType, workspace.targetId, sequence64LayoutEnabled() ?
		workspace.view64 : workspace.editorId, sequence64SelectedStep,
		sequence64EditParameter, sequence64LockRecordHeld ? 1 : 0,
		workspace.collapsed ? 1 : 0);
}

function publishHudModulationState() {
	var workspace = ensureEditorWorkspaceDefaults();
	publishHud("modulation_state", JSON.stringify(workspace.modulation));
}

function modulationRateHz(rate) {
	var value = Array.isArray(rate) ? rate : [1, 4];
	var numerator = Math.max(1, parseInt(value[0], 10) || 1);
	var denominator = Math.max(1, parseInt(value[1], 10) || 4);
	var bpm = s.timeMs > 0 ? 60000 / s.timeMs : 120;
	return clamp(bpm * denominator / (240 * numerator), 0.001, 100);
}

function modulationRouteAmount(state, scope, targetId, parameterId, sourceId) {
	for (var index = 0; index < state.routes.length; index++) {
		var route = state.routes[index];
		if (route.scope === scope && route.targetId === targetId &&
			route.parameterId === parameterId && route.sourceId === sourceId && route.enabled) {
			return route.amount;
		}
	}
	return 0;
}

function applyNativeModulationGroup(groupIndex, trackIndex) {
	if (!rtaEnabled()) return false;
	if (groupIndex < 0 || groupIndex >= s.NUM_CHANNELS) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = workspace.modulation;
	for (var sourceIndex = 0; sourceIndex < Modulation.SOURCE_IDS.length; sourceIndex++) {
		var sourceId = Modulation.SOURCE_IDS[sourceIndex];
		var groupSource = state.sources[Modulation.sourceKey("group", groupIndex, sourceId)];
		var trackSource = trackIndex >= 0 ?
			state.sources[Modulation.sourceKey("track", trackIndex, sourceId)] : null;
		var source = trackSource || groupSource ||
			Modulation.defaultSource(sourceId);
		var amount = modulationRouteAmount(state, "group", groupIndex, "filter", sourceId);
		if (trackIndex >= 0 && trackChannelIndex(trackIndex) === groupIndex) {
			amount += modulationRouteAmount(state, "track", trackIndex, "filter", sourceId);
		}
		messnamed((groupIndex + 1) + "[mod]" + sourceId + "-amount",
			clamp(amount, -1, 1));
		if (sourceId === "lfo1" || sourceId === "lfo2") {
			messnamed((groupIndex + 1) + "[mod]" + sourceId + "-rate",
				modulationRateHz(source.rate));
			messnamed((groupIndex + 1) + "[mod]" + sourceId + "-polarity",
				source.polarity === "unipolar" ? 1 : 0);
		} else if (sourceId === "adsr") {
			messnamed((groupIndex + 1) + "[mod]adsr-params", source.attack,
				source.decay, source.sustain, source.release);
		} else if (sourceId === "ar") {
			messnamed((groupIndex + 1) + "[mod]ar-params", source.attack, source.release);
		}
	}
	return true;
}

function applyNativeModulationAll() {
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var channel = getChannelStateByIndex(group);
		applyNativeModulationGroup(group, channel ? channel.activeTrack : -1);
	}
}

function applyNativeModulationTarget(scope, targetId) {
	var type = String(scope || "");
	var id = parseInt(targetId, 10);
	if (type === "track") return applyNativeModulationGroup(trackChannelIndex(id), id);
	if (type === "group") {
		var channel = getChannelStateByIndex(id);
		return applyNativeModulationGroup(id, channel ? channel.activeTrack : -1);
	}
	return false;
}

function modulationRoute(scope, targetId, parameterId, sourceId, amount, enabled) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	workspace.modulation = Modulation.setRoute(workspace.modulation, {
		scope: String(scope || ""), targetId: parseInt(targetId, 10),
		parameterId: String(parameterId || ""), sourceId: String(sourceId || ""),
		amount: parseFloat(amount), enabled: enabled === undefined ? true : !!parseInt(enabled, 10)
	});
	applyNativeModulationTarget(scope, targetId);
	publishHudModulationState();
	if (String(scope) === "track") writeThroughActiveTrackModulation("track modulation route");
	else markSessionDirty("modulation route");
	return true;
}

function modulationSource(scope, targetId, sourceId, payload) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var source;
	try { source = typeof payload === "string" ? JSON.parse(payload) : payload; }
	catch (error) {
		publishHud("notice", "error", "Could not parse modulation source settings");
		return false;
	}
	workspace.modulation = Modulation.setSource(workspace.modulation,
		String(scope || ""), parseInt(targetId, 10), String(sourceId || ""), source || {});
	applyNativeModulationTarget(scope, targetId);
	publishHudModulationState();
	if (String(scope) === "track") writeThroughActiveTrackModulation("track modulation source");
	else markSessionDirty("modulation source");
	return true;
}

function modulationClear(scope, targetId, parameterId, sourceId) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	workspace.modulation = Modulation.clearRoute(workspace.modulation,
		String(scope || ""), parseInt(targetId, 10), String(parameterId || ""),
		String(sourceId || ""));
	applyNativeModulationTarget(scope, targetId);
	publishHudModulationState();
	if (String(scope) === "track") writeThroughActiveTrackModulation("track modulation clear");
	else markSessionDirty("modulation route cleared");
	return true;
}

function modulationTrigger(scope, targetId, gate) {
	if (!rtaEnabled()) return false;
	var group = String(scope) === "track" ? trackChannelIndex(parseInt(targetId, 10)) :
		parseInt(targetId, 10);
	if (group < 0 || group >= s.NUM_CHANNELS) return false;
	messnamed((group + 1) + "[mod]trigger", parseInt(gate, 10) ? 1 : 0);
	return true;
}

function modulationStop() {
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		messnamed((group + 1) + "[mod]trigger", 0);
	}
	return true;
}

function publishHudCurrentPattern() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!sequence64LayoutEnabled() || !workspace.active) return;
	publishHudPatternSnapshot(workspace.targetType, workspace.targetId,
		ensureSequence64Pattern(workspace.targetType, workspace.targetId));
}

function publishHudPerformanceState() {
	for (var track = 0; track < s.NUM_TRACKS; track++) publishHudTrackState(track);
	for (var channel = 0; channel < s.NUM_CHANNELS; channel++) publishHudChannelState(channel);
}

function publishHudAfterGridAction(state, col, row) {
	if (!state) return;
	if (row > 0 && row <= s.NUM_TRACKS) {
		publishHudTrackState(row - 1);
		publishHudChannelState(trackChannelIndex(row - 1));
	} else if (row === 0) {
		for (var channel = 0; channel < s.NUM_CHANNELS; channel++) {
			publishHudChannelState(channel);
		}
	}
	publishHudEditorState();
	publishHudCurrentPattern();
}

function hudSnapshot() {
	for (var cutGroup = 0; cutGroup < 8; cutGroup++) publishPhaseCut(cutGroup);
	var workspace = ensureEditorWorkspaceDefaults();
	publishHud("mode", s.kmod);
	publishHud("hardware_colors", s.mechaTrellisExtensions ? 1 : 0);
	if (s.timeMs > 0) publishHud("clock", 60000 / s.timeMs, 16);
	publishHudColorSnapshot();
	publishSampleBrowserState();
	publishHudPerformanceState();
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		publishHudPatternSummary("group", group,
			workspace.patterns64[editorTargetKey("group", group)] || null);
	}
	for (var track = 0; track < s.NUM_TRACKS; track++) {
		publishHudPatternSummary("track", track,
			workspace.patterns64[editorTargetKey("track", track)] || null);
	}
	publishHudEditorState();
	publishHudModulationState();
	publishHudSceneState();
	publishHudCurrentPattern();
}

// Base mixer controls are available to both product front ends.
function hudGroupVolume(group, value) {
	var index = parseInt(group, 10), volume = Number(value);
	if (!isFinite(index) || index < 0 || index >= s.NUM_CHANNELS || !isFinite(volume)) return false;
	setEditorVolume(index, volume, false);
	markSessionDirty("group volume");
	publishHudChannelState(index);
	if (s.kmod === 2) renderCompletePage(2, false);
	return true;
}

function hudGroupMute(group, value) {
	var index = parseInt(group, 10);
	if (!isFinite(index) || index < 0 || index >= s.NUM_CHANNELS) return false;
	setEditorMute(index, parseInt(value, 10) ? 1 : 0, false);
	markSessionDirty("group mute");
	publishHudChannelState(index);
	if (s.kmod === 2) renderCompletePage(2, false);
	return true;
}

function hudTarget(targetType, targetId) {
	if (!rtaEnabled()) return false;
	var type = String(targetType || "");
	var id = parseInt(targetId, 10);
	if ((type !== "group" && type !== "track") || !isFinite(id)) return;
	var maximum = type === "group" ? s.NUM_CHANNELS : s.NUM_TRACKS;
	if (id < 0 || id >= maximum) return;
	if (s.kmod !== 2) setKmod(2);
	selectEditorTarget(type, id, true);
	publishHudEditorState();
	publishHudCurrentPattern();
}

function hudBar(barIndex) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (!sequence64LayoutEnabled() || !workspace.active) return;
	selectSequence64Bar(parseInt(barIndex, 10) || 0);
	publishHudCurrentPattern();
}

function hudTransport(action) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (!sequence64LayoutEnabled() || !workspace.active) return;
	var command = String(action || "").toLowerCase();
	if (command === "run") setSequence64TargetRunning(workspace.targetType, workspace.targetId, 1);
	else if (command === "stop") stopSequence64Target(workspace.targetType, workspace.targetId, "hud_stop");
	else if (command === "restart") restartSequence64Target(workspace.targetType, workspace.targetId, "hud_restart");
	publishHudCurrentPattern();
}

function rtaEnabled() {
	return Product.rta && !!ensureEditorWorkspaceDefaults().enabled;
}

function editorWorkspaceSupported() {
	if (!Product.rta) return false;
	return s.gridWidth === 16 && s.gridHeight === 16;
}

function editorWorkspaceAvailable() {
	return s.kmod === 2 && editorWorkspaceSupported() && !!ensureEditorWorkspaceDefaults().enabled;
}

function sequence64LayoutEnabled() {
	return Product.rta && ensureEditorWorkspaceDefaults().layoutMode === "sequence64";
}

function resetEditorWorkspaceState(clearTarget, stopRunning) {
	releaseNativeSequence64("workspace_reset", true);
	knobReset();
	var workspace = ensureEditorWorkspaceDefaults();
	if (sequence64LayoutEnabled() && stopRunning) {
		for (var patternKey in workspace.patterns64) {
			var parts = patternKey.split(":");
			if (parts.length === 2) {
				stopSequence64Target(parts[0], parseInt(parts[1], 10), "workspace_reset", true);
			}
		}
	}
	restoreEditorGateFx();
	stopCurrentEditorAutomationRecording();
	if (editorColorCache) invalidateEditorColorCache();
	workspace.choosing = false;
	workspace.active = false;
	workspace.collapsed = false;
	if (clearTarget !== false) {
		workspace.targetType = "none";
		workspace.targetId = -1;
	}
	workspace.editorId = "step";
	workspace.stepPlayhead = -1;
	workspace.lastSequencedStep = -1;
	workspace.lastSequencedBar = -1;
	sequence64HeldStep = -1;
	sequence64SelectedStep = -1;
	sequence64HeldStepChanged = false;
	sequence64PressedStep = -1;
	sequence64PressedStepWasEmpty = false;
	sequence64StepHoldOpened = false;
	sequence64PendingLengthIndex = -1;
	sequence64PendingBarIndex = -1;
	sequence64BarHoldCommitted = false;
	sequence64ShiftHeld = false;
	sequence64ShiftEditedSteps.fill(0);
	sequence64StepHoldTask.cancel();
	sequence64LengthHoldTask.cancel();
	sequence64BarHoldTask.cancel();
	sequence64RunShortcutHoldTask.cancel();
	sequence64ModMatrixHoldTask.cancel();
	sequence64PendingRunShortcut = null;
	sequence64ModMatrixActive = false;
	sequence64ModParameterPress = -1;
	sequence64ModEditActive = false;
	sequence64InspectorContext = "parameter";
	sequence64InspectorLiveWrite = false;
	sequence64DeleteHeld = false;
	cancelSequence64Copy();
	sequence64CopyStepReleases = {};
	stopAllSequence64Auditions();
	sequence64SliceAuditionTracks.fill(-1);
	sequence64LiveRecordHeld = false;
	sequence64LockRecordHeld = false;
	sequence64PendingLiveCut = null;
	sequence64LiveLaneTracks.fill(-1);
	sequence64PlaybackPingGuard = null;
	sequence64LiveRecordTake = null;
	sequence64LiveRecordFinalizeTask.cancel();
}

function editorOwnsLedCell(x, y) {
	if (!editorWorkspaceAvailable()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (x === EDITOR_BUTTON_COL && y === 0) return true;
	if (workspace.choosing) {
		if (y === 0 && x >= 0 && x < s.NUM_CHANNELS) return true;
		if (x === EDITOR_TRACK_COL && y >= 1 && y <= 15) return true;
	}
	if (sequence64LayoutEnabled() && y === SEQUENCE64_NAV_ROW && x >= 0 && x <= 2) return true;
	if (workspace.collapsed) return false;
	if (workspace.active && sequence64LayoutEnabled() && workspace.view64 === "scene") return true;
	return workspace.active && y >= EDITOR_FIRST_ROW;
}

function withEditorOverlayDraw(callback) {
	editorOverlayDrawDepth++;
	try {
		callback();
	} finally {
		editorOverlayDrawDepth--;
	}
}

function sampleBrowserOwnsLedCell(x, y) {
	return sampleBrowserState.active && x >= 0 && x < s.gridWidth &&
		y >= 0 && y <= SAMPLE_BROWSER_TOP_LAST_ROW;
}

function withSampleBrowserOverlayDraw(callback) {
	sampleBrowserDrawDepth++;
	try {
		callback();
	} finally {
		sampleBrowserDrawDepth--;
	}
}

function editorLevelIndex(x, y) {
	return y * 16 + x;
}

function invalidateEditorLevelCache() {
	for (var i = 0; i < editorLevelCache.length; i++) editorLevelCache[i] = -1;
}

function invalidateEditorColorCache() {
	for (var i = 0; i < editorColorCache.length; i++) {
		editorColorCache[i] = "";
		editorStateColorCache[i] = "";
		editorMotionColorCache[i] = "";
	}
}

function editorBrightnessRgb(level) {
	var workspace = ensureEditorWorkspaceDefaults();
	var colorId = sequence64LayoutEnabled() ? workspace.view64 : workspace.editorId;
	var range = EDITOR_COLOR_RANGES[colorId] || EDITOR_COLOR_RANGES.step;
	var amount = clamp(level, 0, 15) / 15;
	var rgb = [];
	for (var channel = 0; channel < 3; channel++) {
		rgb[channel] = clamp8(Math.round(range[0][channel] +
			(range[1][channel] - range[0][channel]) * amount));
	}
	return rgb;
}

function updateQueuedEditorColorCell(x, y, rgb) {
	for (var queued = pageColorQueue.length - 1; queued >= 0; queued--) {
		var command = pageColorQueue[queued];
		if (command[0] === "colorcell" && command[1] === x && command[2] === y) {
			pageColorQueue.splice(queued, 1);
		} else if (command[0] === "colormap" &&
			x >= command[1] && x < command[1] + 4 &&
			y >= command[2] && y < command[2] + 4) {
			var cell = (y - command[2]) * 4 + (x - command[1]);
			var offset = 3 + cell * 3;
			command[offset] = rgb[0];
			command[offset + 1] = rgb[1];
			command[offset + 2] = rgb[2];
		}
	}
}

function clearQueuedEditorShellColors() {
	for (var queued = pageColorQueue.length - 1; queued >= 0; queued--) {
		var command = pageColorQueue[queued];
		if (command[0] === "colorstatecell" || command[0] === "colormotioncell") {
			editorStateColorCache[editorLevelIndex(command[1], command[2])] = "";
			editorMotionColorCache[editorLevelIndex(command[1], command[2])] = "";
			pageColorQueue.splice(queued, 1);
		} else if (command[0] === "colorcell" && command[2] >= EDITOR_FIRST_ROW) {
			editorColorCache[editorLevelIndex(command[1], command[2])] = "";
			pageColorQueue.splice(queued, 1);
		} else if (command[0] === "colormap" &&
			command[2] + 4 > EDITOR_FIRST_ROW) {
			for (var mapY = 0; mapY < 4; mapY++) {
				for (var mapX = 0; mapX < 4; mapX++) {
					var cellY = command[2] + mapY;
					if (cellY >= EDITOR_FIRST_ROW) {
						editorColorCache[editorLevelIndex(command[1] + mapX, cellY)] = "";
					}
				}
			}
			pageColorQueue.splice(queued, 1);
		}
	}
}

function emitEditorColor(x, y, rgb) {
	var workspace = ensureEditorWorkspaceDefaults();
	var sceneOwnsFullGrid = workspace.active && !workspace.collapsed && !workspace.choosing &&
		sequence64LayoutEnabled() && workspace.view64 === "scene";
	if (!s.editorBrightnessColors || (y < EDITOR_FIRST_ROW && !sceneOwnsFullGrid) || !rgb) return;
	var normalized = [clamp8(rgb[0]), clamp8(rgb[1]), clamp8(rgb[2])];
	var cacheIndex = editorLevelIndex(x, y);
	var signature = normalized.join(",");
	if (editorColorCache[cacheIndex] === signature) return;
	editorColorCache[cacheIndex] = signature;
	updateQueuedEditorColorCell(x, y, normalized);
	outlet(1, "colorcell", x, y, normalized[0], normalized[1], normalized[2]);
}

function emitEditorBrightnessColor(x, y, level) {
	emitEditorColor(x, y, editorBrightnessRgb(level));
}

function editorLed(x, y, level, emitBrightnessColor, rgb) {
	var normalized = clamp(level | 0, 0, 15);
	editorLevelCache[editorLevelIndex(x, y)] = normalized;
	led(x, y, normalized);
	if (emitBrightnessColor) {
		if (rgb) emitEditorColor(x, y, rgb);
		else emitEditorBrightnessColor(x, y, normalized);
	}
}

function applyEditorLevelDiff(changes) {
	if (!editorWorkspaceAvailable()) return 0;
	var pending = [];
	for (var i = 0; i < changes.length; i++) {
		var change = changes[i];
		var x = change[0] | 0;
		var y = change[1] | 0;
		var level = clamp(change[2] | 0, 0, 15);
		if (x < 0 || x >= 16 || y < 0 || y >= 16) continue;
		var cacheIndex = editorLevelIndex(x, y);
		var levelChanged = editorLevelCache[cacheIndex] !== level;
		var rgb = null;
		var colorChanged = false;
		if (s.editorBrightnessColors) {
			rgb = change.length > 3 && change[3] ? change[3] : editorBrightnessRgb(level);
			colorChanged = editorColorCache[cacheIndex] !== rgb.join(",");
		}
		if (levelChanged || colorChanged) {
			pending.push([x, y, level, levelChanged, rgb, colorChanged]);
		}
	}
	if (!pending.length) return 0;

	var matrixUpdateOpened = beginMatrixUpdate();
	try {
		withEditorOverlayDraw(function () {
			for (var p = 0; p < pending.length; p++) {
				if (pending[p][3]) editorLed(pending[p][0], pending[p][1], pending[p][2], false);
				if (pending[p][5]) emitEditorColor(pending[p][0], pending[p][1], pending[p][4]);
			}
		});
	} finally {
		endMatrixUpdate(matrixUpdateOpened);
	}
	return pending.length;
}

function redrawEditorWorkspaceFrame() {
	if (s.kmod !== 2) return;
	invalidateEditorLevelCache();
	if (s.editorBrightnessColors) clearQueuedEditorShellColors();
	renderCompletePage(2, false);
	var workspace = ensureEditorWorkspaceDefaults();
	var wantsScenePalette = workspace.active && !workspace.collapsed && !workspace.choosing &&
		sequence64LayoutEnabled() && workspace.view64 === "scene";
	var wantsBasePalette = sequence64LayoutEnabled() &&
		(!workspace.active || workspace.collapsed);
	if (s.editorBrightnessColors && s.autoPageColors &&
		(wantsBasePalette || wantsScenePalette !== editorScenePaletteVisible)) applyPageColors(2);
}

function editorTargetKey(targetType, targetId) {
	if ((targetType !== "group" && targetType !== "track") || targetId < 0) return null;
	return targetType + ":" + targetId;
}

function currentEditorTargetKey() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) return null;
	return editorTargetKey(workspace.targetType, workspace.targetId);
}

function createSequence64Step() {
	return {
		cut: null,
		locks: {},
		probability: 15,
		condition: 0
	};
}

function restoreSequence64OutputsAfterReload(workspace) {
	if (!workspace || !workspace.parameterValues64) return;
	for (var key in workspace.parameterValues64) {
		var values = workspace.parameterValues64[key];
		if (!values) continue;
		var parts = key.split(":");
		var targetId = parseInt(parts[1], 10);
		var channelIdx = parts[0] === "group" ? targetId : trackChannelIndex(targetId);
		if (channelIdx < 0 || channelIdx >= s.NUM_CHANNELS) continue;
		if (values.volumeOutput !== undefined && values.volumeOutput < 15) {
			messnamed((channelIdx + 1) + "[gatefx]level", 1, 8);
			values.volumeOutput = 15;
		}
		if (values.filterOutput !== undefined && values.filterOutput < 15) {
			messnamed((channelIdx + 1) + "[filterfx]level", 1, 8);
			values.filterOutput = 15;
		}
	}
}

function createSequence64Pattern(targetType) {
	var steps = new Array(64);
	for (var i = 0; i < steps.length; i++) steps[i] = createSequence64Step();
	var initialLength = targetType === "track" ? 16 : 64;
	return {
		version: 9,
		length: initialLength,
		running: 0,
		lastSequencedFlat: -1,
		legacyMigrated: 0,
		defaultTrack: -1,
		lastUsedTrack: -1,
		phaseOrigin: 0,
		rateNumerator: 1,
		rateDenominator: 1,
		lastSequencedAbsolute: -1,
		restartArmed: 0,
		steps: steps,
		bars: [{ length: initialLength, steps: steps }],
		parkedBars: [],
		currentBar: 0
	};
}

var sceneRuntimeInitializing = false;
var sceneRecallApplying = false;
var sequence64TransportPausing = false;
var sequence64PhraseLaunching = false;

function sceneTrackSnapshot(trackIndex) {
	var track = getTrackStateByIndex(trackIndex);
	if (!track) return { id: trackIndex, group: trackIndex % s.NUM_CHANNELS, buffer: 0 };
	return {
		id: trackIndex,
		group: clamp((parseInt(track.channel, 10) || 1) - 1, 0, 7),
		buffer: parseInt(track.buffer, 10) || 0,
		sampleIndex: sampleBrowserState.assignments[trackIndex] === undefined ? -1 :
			sampleBrowserState.assignments[trackIndex],
		sampleRef: sampleBrowserState.sampleRefs[trackIndex] ?
			Scenes.clone(sampleBrowserState.sampleRefs[trackIndex]) : null,
		length: clamp(parseInt(track.length, 10) || 16, 1, 16),
		octave: clamp(parseInt(track.octave, 10) || 0, -8, 8),
		transpose: clamp(parseInt(track.transpose, 10) || 0, -96, 96),
		speed: parseFloat(track.speed) || 0,
		speedMode: parseInt(track.speedMode, 10) || 0,
		reverse: track.reverse ? 1 : 0,
		playbackLoop: track.playbackLoop ? 1 : 0,
		randomOffset: track.randomOffset ? 1 : 0,
		loopStart: track.loopStart,
		loopEnd: track.loopEnd,
		loopDivision: track.subLoopDiv,
		loopActive: track.loopActive ? 1 : 0,
		instrumentParameters: instrumentDescriptorForTrack(trackIndex) ?
			instrumentSanitize(trackIndex, track.instrumentParameters) : undefined
	};
}

function sceneTrackSnapshots() {
	var tracks = [];
	for (var index = 0; index < s.NUM_TRACKS; index++) tracks.push(sceneTrackSnapshot(index));
	return tracks;
}

function sceneIndexFromId(id) {
	var match = /^scene:(\d+)$/.exec(String(id || ""));
	return match ? clamp(parseInt(match[1], 10) || 0, 0, Scenes.MAX_SCENES - 1) : 0;
}

function scenePatternReference(targetType, targetId, workspace) {
	var targetWorkspace = workspace || ensureEditorWorkspaceDefaults();
	var state = targetWorkspace.sceneState;
	if (!state) return null;
	var activeIndex = sceneIndexFromId(state.activeSceneId);
	var scene = state.scenes[activeIndex];
	if (!scene) return null;
	if (targetType === "group") {
		return targetWorkspace.performanceGroupPatternRefs[targetId] ||
			scene.groupPatternRefs[targetId] || Scenes.groupPatternId(targetId, 0);
	}
	var trackSlot = state.trackSlots[scene.trackSlotRef];
	return trackSlot && trackSlot.trackPatternRefs[targetId] ?
		trackSlot.trackPatternRefs[targetId] : null;
}

function bindScenePatternAlias(targetType, targetId, pattern, workspace) {
	var targetWorkspace = workspace || ensureEditorWorkspaceDefaults();
	if (!targetWorkspace.sceneState || sceneRuntimeInitializing) return pattern;
	var reference = scenePatternReference(targetType, targetId, targetWorkspace);
	if (reference) targetWorkspace.sceneState.patternLibrary[reference] = pattern;
	return pattern;
}

function materializeSceneAliases(scene, applyTracks) {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = workspace.sceneState;
	if (!state || !scene) return false;
	var aliases = {};
	workspace.performanceGroupPatternRefs = scene.groupPatternRefs.slice();
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var groupRef = workspace.performanceGroupPatternRefs[group];
		var groupPattern = state.patternLibrary[groupRef];
		if (!groupPattern) {
			groupPattern = createSequence64Pattern("group");
			state.patternLibrary[groupRef] = groupPattern;
		}
		aliases[editorTargetKey("group", group)] = groupPattern;
	}
	var trackSlot = state.trackSlots[scene.trackSlotRef];
	if (!trackSlot) return false;
	workspace.performanceTrackSlotRef = scene.trackSlotRef;
	for (var track = 0; track < s.NUM_TRACKS; track++) {
		var trackRef = trackSlot.trackPatternRefs[track];
		var trackPattern = state.patternLibrary[trackRef];
		if (!trackPattern) {
			trackPattern = createSequence64Pattern("track");
			state.patternLibrary[trackRef] = trackPattern;
		}
		aliases[editorTargetKey("track", track)] = trackPattern;
		if (applyTracks) sessionApplyTrack(track, trackSlot.tracks[track]);
	}
	workspace.patterns64 = aliases;
	if (applyTracks) {
		workspace.modulation = Modulation.sanitizeState(
			Scenes.mergeTrackModulation(workspace.modulation, trackSlot.modulation));
		applyNativeModulationAll();
	}
	return true;
}

function activeSceneState() {
	var state = ensureSceneRuntime();
	return state && state.scenes ? state.scenes[sceneIndexFromId(state.activeSceneId)] : null;
}

function writeThroughActiveTrackSlot(trackIndex, reason, shouldMark) {
	if (!Product.rta) {
		if (shouldMark !== false && !sessionStateApplying) markSessionDirty(reason || "track edit");
		return true;
	}
	if (sceneRecallApplying || sceneRuntimeInitializing || sessionStateApplying ||
		editorAutomationDispatching) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.sceneRuntimeReady || !workspace.sceneState) ensureSceneRuntime();
	var slot = workspace.sceneState.trackSlots[workspace.performanceTrackSlotRef];
	if (!slot || trackIndex < 0 || trackIndex >= s.NUM_TRACKS) return false;
	var snapshot = sceneTrackSnapshot(trackIndex);
	if (durableTrackSignature(slot.tracks[trackIndex], trackIndex) ===
		durableTrackSignature(snapshot, trackIndex)) return false;
	slot.tracks[trackIndex] = snapshot;
	if (shouldMark !== false) markSessionDirty(reason || "track slot edit");
	return true;
}

function writeThroughActiveTrackModulation(reason) {
	if (!Product.rta) return false;
	if (sceneRecallApplying || sceneRuntimeInitializing || sessionStateApplying) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.sceneRuntimeReady || !workspace.sceneState) ensureSceneRuntime();
	var slot = workspace.sceneState.trackSlots[workspace.performanceTrackSlotRef];
	if (!slot) return false;
	var modulation = Scenes.splitTrackModulation(workspace.modulation);
	if (JSON.stringify(slot.modulation) === JSON.stringify(modulation)) return false;
	slot.modulation = modulation;
	markSessionDirty(reason || "track slot modulation");
	return true;
}

function writeThroughActiveSceneGroup(groupIndex, patternRef, running, reason) {
	if (!Product.rta) return false;
	if (sceneRecallApplying || sceneRuntimeInitializing || sessionStateApplying) return false;
	var scene = activeSceneState();
	if (!scene || groupIndex < 0 || groupIndex >= s.NUM_CHANNELS) return false;
	var changed = false;
	if (patternRef !== undefined && patternRef !== null) {
		var nextRef = String(patternRef);
		if (scene.groupPatternRefs[groupIndex] !== nextRef) {
			scene.groupPatternRefs[groupIndex] = nextRef;
			changed = true;
		}
	}
	if (running !== undefined && running !== null) {
		var nextRun = running ? 1 : 0;
		if (scene.groupLaunch[groupIndex] !== nextRun) {
			scene.groupLaunch[groupIndex] = nextRun;
			changed = true;
		}
	}
	if (!changed) return false;
	markSessionDirty(reason || "scene edit");
	return true;
}

function ensureSceneRuntime() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (workspace.sceneRuntimeReady && workspace.sceneState) return workspace.sceneState;
	if (sceneRuntimeInitializing) return workspace.sceneState;
	sceneRuntimeInitializing = true;
	try {
		workspace.sceneState = Scenes.sanitizeState(workspace.sceneState,
			sceneTrackSnapshots(), workspace.patterns64, workspace.modulation);
		var active = workspace.sceneState.scenes[
			sceneIndexFromId(workspace.sceneState.activeSceneId)] || workspace.sceneState.scenes[0];
		materializeSceneAliases(active, false);
		workspace.sceneRuntimeReady = 1;
	} finally {
		sceneRuntimeInitializing = false;
	}
	return workspace.sceneState;
}

function ensureSceneAt(sceneIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var target = clamp(parseInt(sceneIndex, 10) || 0, 0, Scenes.MAX_SCENES - 1);
	if (state.scenes[target]) return state.scenes[target];
	var activeScene = state.scenes[sceneIndexFromId(state.activeSceneId)] || state.scenes[0];
	var activeTrackSlot = state.trackSlots[activeScene.trackSlotRef];
	var trackSlotRef = workspace.performanceTrackSlotRef;
	var matchingTrackSlotRef = Scenes.trackSlotId(target);
	// Empty-Scene capture is independent by default. If the number-matching Slot
	// is free, Scenes.ensureScene creates it below. If it already exists, clone
	// the live Slot into the next free library position rather than silently
	// making the new Scene share the active Scene's Slot.
	if (state.trackSlots[matchingTrackSlotRef]) {
		for (var slotIndex = 0; slotIndex < Scenes.MAX_TRACK_SLOTS; slotIndex++) {
			var candidateRef = Scenes.trackSlotId(slotIndex);
			if (state.trackSlots[candidateRef]) continue;
			var candidate = Scenes.ensureTrackSlot(state, slotIndex, {
				sourceTrackSlotRef: workspace.performanceTrackSlotRef,
				tracks: sceneTrackSnapshots(),
				modulation: Scenes.splitTrackModulation(workspace.modulation),
				trackPatternRefs: activeTrackSlot ? activeTrackSlot.trackPatternRefs : []
			});
			if (candidate) trackSlotRef = candidate.id;
			break;
		}
	}
	var scene = Scenes.ensureScene(state, target, {
		scene: {
			groupPatternRefs: workspace.performanceGroupPatternRefs,
			groupLaunch: workspace.performanceGroupPatternRefs.map(function (reference, group) {
				var pattern = workspace.patterns64[editorTargetKey("group", group)];
				return pattern && pattern.running ? 1 : 0;
			})
		},
		trackSlotRef: trackSlotRef,
		sourceTrackSlotRef: workspace.performanceTrackSlotRef,
		tracks: sceneTrackSnapshots(),
		modulation: Scenes.splitTrackModulation(workspace.modulation),
		trackPatternRefs: activeTrackSlot ? activeTrackSlot.trackPatternRefs : []
	});
	return scene;
}

function sceneRunningGroups() {
	var workspace = ensureEditorWorkspaceDefaults();
	var result = [];
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var pattern = workspace.patterns64[editorTargetKey("group", group)];
		result.push(pattern && pattern.running ? 1 : 0);
	}
	return result;
}

function sceneAnyGroupRunning() {
	var running = sceneRunningGroups();
	for (var group = 0; group < running.length; group++) if (running[group]) return true;
	return false;
}

function sequence64HasPlaybackActivity() {
	if (sceneAnyGroupRunning()) return true;
	var workspace = ensureEditorWorkspaceDefaults();
	for (var key in workspace.phraseInstances64) {
		if (workspace.phraseInstances64[key]) return true;
	}
	return false;
}

function publishHudSceneState() {
	if (!Product.rta) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var activeIndex = sceneIndexFromId(state.activeSceneId);
	var activeScene = state.scenes[activeIndex];
	var summary = {
		activeScene: activeIndex,
		selectedScene: sceneIndexFromId(state.selectedSceneId),
		diverged: activeScene && !scenePerformanceMatches(activeScene) ? 1 : 0,
		pending: workspace.pendingSceneLaunch ? Scenes.clone(workspace.pendingSceneLaunch) : null,
		performanceGroupPatternRefs: workspace.performanceGroupPatternRefs.slice(),
		runningGroups: sceneRunningGroups(),
		scenes: state.scenes.map(function (scene) {
			if (!scene) return null;
			return {
				id: scene.id,
				name: scene.name,
				trackSlotRef: scene.trackSlotRef,
				groupPatternRefs: scene.groupPatternRefs.slice(),
				groupLaunch: scene.groupLaunch.slice()
			};
		})
	};
	publishHud("scene_state", JSON.stringify(summary));
}

function rejectEmptyScene(sceneIndex, action) {
	var number = clamp(parseInt(sceneIndex, 10) || 0, 0, Scenes.MAX_SCENES - 1) + 1;
	var requested = String(action || "use");
	outlet(2, "scene_empty", number, requested);
	diagnosticEvent("scene_empty", { scene: number, action: requested });
	publishHud("notice", "info", "Scene " + number + " is empty · tap it to capture");
	publishHudSceneState();
	return false;
}

function capturePerformanceToScene(sceneIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var target = clamp(parseInt(sceneIndex, 10) || 0, 0, Scenes.MAX_SCENES - 1);
	var wasEmpty = !state.scenes[target];
	var scene = ensureSceneAt(target);
	if (!scene) return false;
	scene.groupPatternRefs = workspace.performanceGroupPatternRefs.slice(0, s.NUM_CHANNELS);
	scene.groupLaunch = sceneRunningGroups();
	state.selectedSceneId = scene.id;
	if (wasEmpty) {
		// Capturing an empty slot adopts the sound that is already playing. Nothing
		// is stopped, restarted, or quantized; only its durable ownership changes.
		state.activeSceneId = scene.id;
		materializeSceneAliases(scene, false);
		workspace.pendingSceneLaunch = null;
	}
	markSessionDirty(wasEmpty ? "scene capture" : "scene update");
	outlet(2, wasEmpty ? "scene_capture" : "scene_update", target + 1);
	diagnosticEvent(wasEmpty ? "scene_capture" : "scene_update", {
		scene: target + 1,
		created: wasEmpty ? 1 : 0,
		trackSlot: scene.trackSlotRef
	});
	publishHudSceneState();
	return true;
}

function scenePerformanceMatches(scene) {
	if (!scene) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		if (scene.groupPatternRefs[group] !== workspace.performanceGroupPatternRefs[group]) {
			return false;
		}
		var pattern = workspace.patterns64[editorTargetKey("group", group)];
		if ((scene.groupLaunch[group] ? 1 : 0) !== (pattern && pattern.running ? 1 : 0)) {
			return false;
		}
	}
	return scene.trackSlotRef === workspace.performanceTrackSlotRef;
}

function sceneSelectOnly(sceneIndex) {
	var state = ensureSceneRuntime();
	var scene = state.scenes[sceneIndex];
	if (!scene) return rejectEmptyScene(sceneIndex, "select");
	state.selectedSceneId = scene.id;
	outlet(2, "scene_select", sceneIndex + 1);
	publishHudSceneState();
	return true;
}

function sceneLaunchBoundary() {
	var remainder = sequence64ClockPosition % SCENE_QUANTIZE_STEPS;
	return remainder === 0 ? sequence64ClockPosition :
		sequence64ClockPosition + SCENE_QUANTIZE_STEPS - remainder;
}

function queueSceneLaunchForNextStep(pending, targetType) {
	if (!pending) return false;
	pending.dueClock = sequence64ClockPosition + 1;
	pending.reason = "next_step";
	outlet(2, "scene_jump_queued", String(targetType || pending.type), pending.dueClock);
	diagnosticEvent("scene_jump_queued", {
		type: String(targetType || pending.type),
		dueClock: pending.dueClock
	});
	publishHud("notice", "info", "Queued launch will jump on the next step");
	publishHudSceneState();
	return true;
}

function cancelPendingSceneLaunch(reason) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pending = workspace.pendingSceneLaunch;
	if (!pending) return false;
	workspace.pendingSceneLaunch = null;
	outlet(2, "scene_queue_cancelled", pending.type, String(reason || "grid"));
	diagnosticEvent("scene_queue_cancelled", {
		type: pending.type,
		reason: String(reason || "grid")
	});
	publishHud("notice", "info", "Queued launch cancelled");
	publishHudSceneState();
	return true;
}

function cancelPendingScenePatternGroup(groupIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pending = workspace.pendingSceneLaunch;
	if (!pending || pending.type !== "patterns" || !pending.patternRefs ||
		pending.patternRefs[groupIndex] === undefined) return false;
	delete pending.patternRefs[groupIndex];
	var remaining = Object.keys(pending.patternRefs).length;
	if (!remaining) workspace.pendingSceneLaunch = null;
	outlet(2, "scene_pattern_queue_cancelled", groupIndex + 1, remaining);
	diagnosticEvent("scene_pattern_queue_cancelled", {
		group: groupIndex + 1,
		remaining: remaining
	});
	publishHud("notice", "info", remaining ?
		"Queued pattern cancelled for Group " + (groupIndex + 1) :
		"Queued launch cancelled");
	publishHudSceneState();
	return true;
}

function stageSceneLaunch(sceneIndex, reason) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var scene = state.scenes[sceneIndex];
	if (!scene) return rejectEmptyScene(sceneIndex, "launch");
	state.selectedSceneId = scene.id;
	if (workspace.pendingSceneLaunch &&
		sceneIndexFromId(state.activeSceneId) === sceneIndex) {
		return cancelPendingSceneLaunch("active_scene");
	}
	if (workspace.pendingSceneLaunch && workspace.pendingSceneLaunch.type === "scene" &&
		workspace.pendingSceneLaunch.sceneIndex === sceneIndex) {
		return queueSceneLaunchForNextStep(workspace.pendingSceneLaunch, "scene");
	}
	if (!s.globalTransportRunning || !sceneAnyGroupRunning() ||
		sequence64ClockPosition % SCENE_QUANTIZE_STEPS === 0) {
		return commitSceneLaunch(sceneIndex, reason || "launch");
	}
	workspace.pendingSceneLaunch = {
		type: "scene",
		sceneIndex: sceneIndex,
		dueClock: sceneLaunchBoundary(),
		reason: String(reason || "launch")
	};
	outlet(2, "scene_queued", sceneIndex + 1, workspace.pendingSceneLaunch.dueClock);
	diagnosticEvent("scene_launch_queued", {
		scene: sceneIndex + 1,
		dueClock: workspace.pendingSceneLaunch.dueClock
	});
	publishHudSceneState();
	return true;
}

function durableTrackSignature(source, trackIndex) {
	var track = source || {};
	return JSON.stringify([
		trackIndex,
		clamp(parseInt(track.group, 10) || 0, 0, 7),
		parseInt(track.buffer, 10) || 0,
		track.sampleIndex === undefined ? -1 : (parseInt(track.sampleIndex, 10) || 0),
		track.sampleRef ? JSON.stringify(track.sampleRef) : "",
		clamp(parseInt(track.length, 10) || 16, 1, 16),
		clamp(parseInt(track.octave, 10) || 0, -8, 8),
		clamp(parseInt(track.transpose, 10) || 0, -96, 96),
		parseFloat(track.speed) || 0,
		parseInt(track.speedMode, 10) || 0,
		track.reverse ? 1 : 0,
		track.playbackLoop === undefined ? 1 : (track.playbackLoop ? 1 : 0),
		track.randomOffset ? 1 : 0,
		clamp(parseInt(track.loopStart, 10) || 0, 0, 15),
		clamp(parseInt(track.loopEnd, 10) || 16, 1, 16),
		parseInt(track.loopDivision, 10) || 8,
		track.loopActive ? 1 : 0,
		instrumentDescriptorForTrack(trackIndex) ? instrumentSanitize(trackIndex, track.instrumentParameters) : null
	]);
}

function sceneLaunchPlan(scene) {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var slot = state.trackSlots[scene.trackSlotRef];
	var plan = {
		groups: [],
		trackSlotChanged: scene.trackSlotRef !== workspace.performanceTrackSlotRef,
		changedTracks: [],
		modulationChanged: false
	};
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var currentPattern = workspace.patterns64[editorTargetKey("group", group)];
		plan.groups.push({
			group: group,
			currentRef: workspace.performanceGroupPatternRefs[group],
			nextRef: scene.groupPatternRefs[group],
			currentRunning: currentPattern && currentPattern.running ? 1 : 0,
			nextRunning: scene.groupLaunch[group] ? 1 : 0
		});
	}
	if (plan.trackSlotChanged && slot) {
		for (var track = 0; track < s.NUM_TRACKS; track++) {
			if (durableTrackSignature(sceneTrackSnapshot(track), track) !==
				durableTrackSignature(slot.tracks[track], track)) plan.changedTracks.push(track);
		}
		plan.modulationChanged = JSON.stringify(Scenes.splitTrackModulation(workspace.modulation)) !==
			JSON.stringify(Scenes.splitTrackModulation(slot.modulation));
	}
	return plan;
}

function applyTrackSlotPlan(scene, plan) {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = workspace.sceneState;
	var slot = state.trackSlots[scene.trackSlotRef];
	if (!slot || !plan.trackSlotChanged) return;
	for (var track = 0; track < s.NUM_TRACKS; track++) {
		var oldPattern = workspace.patterns64[editorTargetKey("track", track)];
		if ((oldPattern && oldPattern.running) || activeSequence64PhraseForTrack(track)) {
			stopSequence64Target("track", track, "track_slot_change", true);
		}
	}
	for (var changed = 0; changed < plan.changedTracks.length; changed++) {
		var trackIndex = plan.changedTracks[changed];
		sessionApplyTrack(trackIndex, slot.tracks[trackIndex]);
	}
	if (plan.modulationChanged) {
		workspace.modulation = Modulation.sanitizeState(
			Scenes.mergeTrackModulation(workspace.modulation, slot.modulation));
		applyNativeModulationAll();
		publishHudModulationState();
	}
}

function commitSceneLaunch(sceneIndex, reason) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var scene = state.scenes[sceneIndex];
	if (!scene) return false;
	var launchStartedAt = Date.now();
	var plan = sceneLaunchPlan(scene);
	var trackSlotApplyMs = 0;
	sceneRecallApplying = true;
	try {
		for (var before = 0; before < plan.groups.length; before++) {
			var groupPlan = plan.groups[before];
			if (groupPlan.currentRunning &&
				(groupPlan.currentRef !== groupPlan.nextRef || !groupPlan.nextRunning)) {
				stopSequence64Target("group", groupPlan.group, "scene_change", true);
			}
		}
		var trackSlotStartedAt = Date.now();
		applyTrackSlotPlan(scene, plan);
		trackSlotApplyMs = Date.now() - trackSlotStartedAt;
		state.activeSceneId = scene.id;
		state.selectedSceneId = scene.id;
		workspace.pendingSceneLaunch = null;
		materializeSceneAliases(scene, false);
		for (var group = 0; group < s.NUM_CHANNELS; group++) {
			var nextPlan = plan.groups[group];
			var pattern = ensureSequence64Pattern("group", group);
			if (nextPlan.currentRef !== nextPlan.nextRef) {
				pattern.running = 0;
				pattern.phaseOrigin = sequence64ClockPosition;
				pattern.lastSequencedFlat = -1;
				pattern.lastSequencedAbsolute = -1;
			}
			if (nextPlan.nextRunning && !pattern.running) {
				restartSequence64Target("group", group, "scene_launch");
			}
		}
		if (plan.trackSlotChanged) {
			for (var track = 0; track < s.NUM_TRACKS; track++) {
				ensureSequence64Pattern("track", track).running = 0;
			}
		}
	} finally {
		sceneRecallApplying = false;
	}
	reconcileSequence64Transport("scene_launch");
	outlet(2, "scene_launch", sceneIndex + 1, scene.trackSlotRef);
	diagnosticEvent("scene_launch", {
		scene: sceneIndex + 1,
		trackSlot: scene.trackSlotRef,
		reason: reason || "launch",
		clock: sequence64ClockPosition,
		changedGroups: plan.groups.filter(function (groupPlan) {
			return groupPlan.currentRef !== groupPlan.nextRef ||
				groupPlan.currentRunning !== groupPlan.nextRunning;
		}).length,
		trackSlotChanged: plan.trackSlotChanged ? 1 : 0,
		changedTracks: plan.changedTracks.length,
		trackSlotApplyMs: trackSlotApplyMs,
		applyDurationMs: Date.now() - launchStartedAt
	});
	publishHudSceneState();
	if (s.kmod === 2) redrawEditorWorkspaceFrame();
	return true;
}

function stageScenePattern(groupIndex, slotIndex) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var patternRef = Scenes.groupPatternId(groupIndex, slotIndex);
	var currentRef = workspace.performanceGroupPatternRefs[groupIndex];
	var destination = state.patternLibrary[patternRef];
	// An empty slot is the fast variation path: fork the live group pattern.
	// Shift keeps the rarer blank-from-scratch action available without making
	// it the default song-building operation.
	if (patternRef !== currentRef &&
		(!destination || !sequence64PatternHasContent(destination))) {
		var currentPattern = workspace.patterns64[editorTargetKey("group", groupIndex)];
		state.patternLibrary[patternRef] = sceneShiftHeld || !currentPattern ?
			createSequence64Pattern("group") : Scenes.clone(currentPattern);
		state.patternLibrary[patternRef].running = 0;
		markSessionDirty(sceneShiftHeld ? "blank group pattern" : "fork group pattern");
	}
	// Scene performance and Sequence editing share one focus. Merely focusing a
	// touched group must not run the target-selection path, which intentionally
	// resets Run for explicit chooser selections.
	workspace.targetType = "group";
	workspace.targetId = groupIndex;
	publishHudEditorState();
	if (workspace.pendingSceneLaunch && workspace.pendingSceneLaunch.type === "patterns" &&
		workspace.pendingSceneLaunch.patternRefs &&
		workspace.pendingSceneLaunch.patternRefs[groupIndex] !== undefined &&
		workspace.pendingSceneLaunch.patternRefs[groupIndex] !== patternRef &&
		workspace.performanceGroupPatternRefs[groupIndex] === patternRef) {
		return cancelPendingScenePatternGroup(groupIndex);
	}
	if (workspace.pendingSceneLaunch && workspace.pendingSceneLaunch.type === "patterns" &&
		workspace.pendingSceneLaunch.patternRefs &&
		workspace.pendingSceneLaunch.patternRefs[groupIndex] === patternRef) {
		return queueSceneLaunchForNextStep(workspace.pendingSceneLaunch, "patterns");
	}
	if (!s.globalTransportRunning || !sceneAnyGroupRunning() ||
		sequence64ClockPosition % SCENE_QUANTIZE_STEPS === 0) {
		return commitScenePattern(groupIndex, patternRef);
	}
	var dueClock = sceneLaunchBoundary();
	if (!workspace.pendingSceneLaunch || workspace.pendingSceneLaunch.type !== "patterns" ||
		workspace.pendingSceneLaunch.dueClock !== dueClock) {
		workspace.pendingSceneLaunch = {
			type: "patterns",
			patternRefs: {},
			dueClock: dueClock
		};
	}
	workspace.pendingSceneLaunch.patternRefs[groupIndex] = patternRef;
	outlet(2, "scene_pattern_queued", groupIndex + 1, slotIndex + 1,
		workspace.pendingSceneLaunch.dueClock);
	publishHudSceneState();
	return true;
}

function commitScenePattern(groupIndex, patternRef) {
	if (!rtaEnabled()) return false;
	var refs = {};
	refs[groupIndex] = patternRef;
	return commitScenePatterns(refs);
}

function commitScenePatterns(patternRefs) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var changedGroups = [];
	var committedRefs = {};
	sceneRecallApplying = true;
	try {
		for (var groupKey in patternRefs) {
			var groupIndex = parseInt(groupKey, 10);
			if (groupIndex < 0 || groupIndex >= s.NUM_CHANNELS) continue;
			var patternRef = patternRefs[groupKey];
			stopSequence64Target("group", groupIndex, "pattern_change", true);
			workspace.performanceGroupPatternRefs[groupIndex] = patternRef;
			var pattern = state.patternLibrary[patternRef];
			if (!pattern) {
				pattern = createSequence64Pattern("group");
				state.patternLibrary[patternRef] = pattern;
			}
			workspace.patterns64[editorTargetKey("group", groupIndex)] = pattern;
			pattern.running = 0;
			pattern.phaseOrigin = sequence64ClockPosition;
			pattern.lastSequencedFlat = -1;
			pattern.lastSequencedAbsolute = -1;
			restartSequence64Target("group", groupIndex, "pattern_launch");
			committedRefs[groupIndex] = patternRef;
			changedGroups.push(groupIndex + 1);
			outlet(2, "scene_pattern", groupIndex + 1, patternRef);
		}
	} finally {
		sceneRecallApplying = false;
	}
	reconcileSequence64Transport("scene_patterns_launch");
	for (var committedGroup in committedRefs) {
		writeThroughActiveSceneGroup(parseInt(committedGroup, 10),
			committedRefs[committedGroup], 1, "scene pattern");
	}
	workspace.pendingSceneLaunch = null;
	diagnosticEvent("scene_patterns_launch", {
		groups: changedGroups,
		clock: sequence64ClockPosition
	});
	publishHudSceneState();
	if (s.kmod === 2) redrawEditorWorkspaceFrame();
	return changedGroups.length > 0;
}

function commitPendingSceneLaunch() {
	if (!rtaEnabled()) return false;
	if (s.editorWorkspace && s.editorWorkspace.pendingSceneLaunch)
		releaseNativeSequence64("scene_launch", true);
	var workspace = ensureEditorWorkspaceDefaults();
	var pending = workspace.pendingSceneLaunch;
	if (!pending || sequence64ClockPosition < pending.dueClock) return false;
	if (pending.type === "patterns") {
		return commitScenePatterns(pending.patternRefs || {});
	}
	if (pending.type === "track_slot") {
		return commitTrackSlotSwitch(pending.trackSlotIndex, pending.reason);
	}
	return commitSceneLaunch(pending.sceneIndex, pending.reason);
}

function commitTrackSlotSwitch(slotIndex, reason) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var index = clamp(parseInt(slotIndex, 10) || 0, 0, Scenes.MAX_TRACK_SLOTS - 1);
	var slotId = Scenes.trackSlotId(index);
	var sceneIndex = sceneIndexFromId(state.activeSceneId);
	var scene = state.scenes[sceneIndex];
	if (!scene || !state.trackSlots[slotId]) return false;
	var previousRef = scene.trackSlotRef;
	scene.trackSlotRef = slotId;
	if (!commitSceneLaunch(sceneIndex, reason || "track_slot")) {
		scene.trackSlotRef = previousRef;
		return false;
	}
	markSessionDirty("scene track slot");
	outlet(2, "track_slot", index + 1, slotId);
	diagnosticEvent("track_slot", {
		slot: index + 1,
		id: slotId,
		changed: previousRef === slotId ? 0 : 1
	});
	return true;
}

function stageTrackSlotSwitch(slotIndex, reason) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var index = clamp(parseInt(slotIndex, 10) || 0, 0, Scenes.MAX_TRACK_SLOTS - 1);
	var slotId = Scenes.trackSlotId(index);
	var activeIndex = sceneIndexFromId(state.activeSceneId);
	var scene = state.scenes[activeIndex];
	if (!scene) return false;
	if (!state.trackSlots[slotId]) {
		var sourceSlot = state.trackSlots[workspace.performanceTrackSlotRef];
		var created = Scenes.ensureTrackSlot(state, index, {
			sourceTrackSlotRef: workspace.performanceTrackSlotRef,
			trackPatternRefs: sourceSlot ? sourceSlot.trackPatternRefs : []
		});
		if (!created) return false;
		scene.trackSlotRef = slotId;
		state.selectedSceneId = scene.id;
		workspace.pendingSceneLaunch = null;
		materializeSceneAliases(scene, false);
		markSessionDirty("track slot create");
		outlet(2, "track_slot_create", index + 1, slotId);
		diagnosticEvent("track_slot_create", { slot: index + 1, id: slotId });
		publishHudSceneState();
		return true;
	}
	if (slotId === workspace.performanceTrackSlotRef) {
		if (workspace.pendingSceneLaunch) return cancelPendingSceneLaunch("active_track_slot");
		return true;
	}
	if (workspace.pendingSceneLaunch && workspace.pendingSceneLaunch.type === "track_slot" &&
		workspace.pendingSceneLaunch.trackSlotIndex === index) {
		return queueSceneLaunchForNextStep(workspace.pendingSceneLaunch, "track_slot");
	}
	if (!s.globalTransportRunning || !sceneAnyGroupRunning() ||
		sequence64ClockPosition % SCENE_QUANTIZE_STEPS === 0) {
		return commitTrackSlotSwitch(index, reason || "grid");
	}
	workspace.pendingSceneLaunch = {
		type: "track_slot",
		trackSlotIndex: index,
		dueClock: sceneLaunchBoundary(),
		reason: String(reason || "grid")
	};
	outlet(2, "track_slot_queued", index + 1, workspace.pendingSceneLaunch.dueClock);
	diagnosticEvent("track_slot_queued", {
		slot: index + 1,
		dueClock: workspace.pendingSceneLaunch.dueClock
	});
	publishHudSceneState();
	return true;
}

function sequence64TrackBelongsToGroup(trackIdx, groupIdx) {
	return trackIdx >= 0 && trackIdx < s.NUM_TRACKS &&
		groupIdx >= 0 && groupIdx < s.NUM_CHANNELS &&
		trackChannelIndex(trackIdx) === groupIdx;
}

function resolveSequence64GroupDefaultTrack(groupIdx, pattern) {
	if (groupIdx < 0 || groupIdx >= s.NUM_CHANNELS) return -1;
	var stored = pattern ? parseInt(pattern.defaultTrack, 10) : -1;
	if (sequence64TrackBelongsToGroup(stored, groupIdx)) return stored;
	var channelState = getChannelStateByIndex(groupIdx);
	var candidates = channelState ?
		[channelState.activeTrack, channelState.lastActiveTrack] : [];
	for (var candidateIndex = 0; candidateIndex < candidates.length; candidateIndex++) {
		var candidate = parseInt(candidates[candidateIndex], 10);
		if (sequence64TrackBelongsToGroup(candidate, groupIdx)) {
			if (pattern) pattern.defaultTrack = candidate;
			return candidate;
		}
	}
	for (var trackIdx = 0; trackIdx < s.NUM_TRACKS; trackIdx++) {
		if (!sequence64TrackBelongsToGroup(trackIdx, groupIdx)) continue;
		if (pattern) pattern.defaultTrack = trackIdx;
		return trackIdx;
	}
	if (pattern) pattern.defaultTrack = -1;
	return -1;
}

// This is the editor's insertion track, separate from the inherited playback
// default. Remember explicit edits/recording, never the sequencer playhead.
function rememberSequence64EditTrack(pattern, targetType, targetId, trackIdx) {
	if (!pattern || targetType !== "group" ||
		!sequence64TrackBelongsToGroup(trackIdx, targetId)) return false;
	if (pattern.lastUsedTrack === trackIdx) return false;
	pattern.lastUsedTrack = trackIdx;
	markSessionDirty("ṛta track choice");
	return true;
}

function normalizeSequence64TransposeLock(lock) {
	if (!lock || typeof lock !== "object") {
		lock = { value: 0, behavior: "set" };
	}
	var total = clamp(Math.round(parseFloat(lock.value) || 0), -96, 96);
	var pitchOctave = parseInt(lock.pitchOctave, 10);
	var pitchSemitone = parseInt(lock.pitchSemitone, 10);
	if (!isFinite(pitchOctave) || !isFinite(pitchSemitone)) {
		// Preserve the exact note choices from the new one-octave row. Older
		// larger totals are decomposed into the nearest octave plus semitone.
		if (total >= SEQUENCE64_TRANSPOSE_MIN && total <= SEQUENCE64_TRANSPOSE_MAX) {
			pitchOctave = 0;
			pitchSemitone = total;
		} else {
			pitchOctave = Math.round(total / 12);
			pitchSemitone = total - pitchOctave * 12;
		}
	}
	lock.pitchOctave = clamp(pitchOctave, -8, 8);
	lock.pitchSemitone = clamp(pitchSemitone,
		SEQUENCE64_TRANSPOSE_MIN, SEQUENCE64_TRANSPOSE_MAX);
	lock.value = clamp(lock.pitchOctave * 12 + lock.pitchSemitone, -96, 96);
	lock.behavior = "set";
	return lock;
}

function ensureSequence64TransposeLock(step) {
	if (!step.locks.transpose) {
		step.locks.transpose = {
			value: 0,
			pitchOctave: 0,
			pitchSemitone: 0,
			behavior: "set"
		};
	}
	step.locks.transpose = normalizeSequence64TransposeLock(step.locks.transpose);
	return step.locks.transpose;
}

function updateSequence64TransposeLock(lock) {
	lock.pitchOctave = clamp(parseInt(lock.pitchOctave, 10) || 0, -8, 8);
	lock.pitchSemitone = clamp(parseInt(lock.pitchSemitone, 10) || 0,
		SEQUENCE64_TRANSPOSE_MIN, SEQUENCE64_TRANSPOSE_MAX);
	lock.value = clamp(lock.pitchOctave * 12 + lock.pitchSemitone, -96, 96);
	lock.behavior = "set";
	return lock.value;
}

function normalizeSequence64Step(step) {
	if (!step || typeof step !== "object") step = createSequence64Step();
	if (!step.locks || typeof step.locks !== "object") step.locks = {};
	// Version 7 separated track-wide octave multiplication from note locks.
	// Preserve older programmed octave locks as the same pitch in semitones.
	if (step.locks.octave) {
		if (!step.locks.transpose) {
			step.locks.transpose = {
				value: clamp(Math.round((parseFloat(step.locks.octave.value) || 0) * 12), -96, 96),
				behavior: step.locks.octave.behavior || "set"
			};
		}
		delete step.locks.octave;
	}
	if (step.locks.transpose) {
		step.locks.transpose = normalizeSequence64TransposeLock(step.locks.transpose);
	}
	allInstrumentLocks().forEach(function (id) {
		if (step.locks[id]) step.locks[id] = {
			value: instrumentClampValue(id, step.locks[id].value), behavior: "set"
		};
	});
	if (step.probability === undefined) step.probability = 15;
	step.probability = clamp(parseInt(step.probability, 10) || 0, 0, 15);
	var condition = parseInt(step.condition, 10);
	if (!isFinite(condition) || Math.abs(condition) < 2) condition = 0;
	else condition = (condition < 0 ? -1 : 1) * clamp(Math.abs(condition), 2, 9);
	step.condition = condition;
	if (step.cut && typeof step.cut === "object") {
		step.cut.track = clamp(parseInt(step.cut.track, 10), -1, s.NUM_TRACKS - 1);
		if (!isFinite(step.cut.track)) step.cut.track = -1;
		step.cut.slice = clamp(parseInt(step.cut.slice, 10) || 0, 0, 15);
		step.cut.gateLength = clamp(parseInt(step.cut.gateLength, 10) || 1, 1, 64);
	} else {
		step.cut = null;
	}
	return step;
}

function migrateLegacyTargetToSequence64(pattern, targetType, targetId) {
	if (!pattern || pattern.legacyMigrated) return pattern;
	var workspace = ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	var legacySteps = workspace.stepPatterns[key];
	var legacyProbabilities = workspace.stepProbabilities[key];
	var legacyFx = workspace.gateFxLevels[key];
	for (var i = 0; i < 16; i++) {
		var step = pattern.steps[i];
		if (legacySteps && legacySteps[i]) {
			step.cut = {
				track: targetType === "track" ? targetId : -1,
				slice: i,
				gateLength: 1
			};
		}
		if (legacyProbabilities && legacyProbabilities[i] !== undefined) {
			step.probability = clamp(parseInt(legacyProbabilities[i], 10) || 0, 0, 15);
		}
		if (legacyFx && legacyFx[i] !== undefined && legacyFx[i] < 15) {
			step.locks.volume = { value: clamp(legacyFx[i], 0, 15), behavior: "set" };
		}
	}
	pattern.legacyMigrated = 1;
	return pattern;
}

function normalizeSequence64Bar(bar, fallbackSteps, fallbackLength) {
	if (!bar || typeof bar !== "object") bar = {};
	var previous = bar.steps || fallbackSteps || [];
	if (!bar.steps || bar.steps.length !== 64) {
		bar.steps = new Array(64);
		for (var i = 0; i < 64; i++) bar.steps[i] = normalizeSequence64Step(previous[i]);
	} else {
		for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
			bar.steps[stepIndex] = normalizeSequence64Step(bar.steps[stepIndex]);
		}
	}
	var length = parseInt(bar.length, 10);
	if (!isFinite(length)) length = parseInt(fallbackLength, 10);
	if (!isFinite(length)) length = 64;
	bar.length = clamp(length, 1, 64);
	return bar;
}

// Runtime-only references: never attach validation/cache state to session data.
// Editing still uses ensureSequence64Pattern; playback reads those same objects
// and validates a new identity once when an alias or imported pattern changes.
var sequence64PlaybackPatterns = {};
var sequence64PlaybackDisplayReading = false;

function sequence64PlaybackPattern(targetType, targetId) {
	var workspace = s.editorWorkspace || ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	if (!key) return null;
	var pattern = workspace.patterns64 && workspace.patterns64[key];
	if (pattern && sequence64PlaybackPatterns[key] === pattern) return pattern;
	return ensureSequence64Pattern(targetType, targetId);
}

function ensureSequence64Pattern(targetType, targetId) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!sceneRuntimeInitializing) ensureSceneRuntime();
	var key = editorTargetKey(targetType, targetId);
	if (!key) return null;
	var pattern = workspace.patterns64[key];
	if (!pattern || typeof pattern !== "object") {
		pattern = createSequence64Pattern(targetType);
		workspace.patterns64[key] = pattern;
	}
	pattern.version = 9;
	if (!isFinite(parseInt(pattern.length, 10))) pattern.length = 64;
	pattern.length = clamp(parseInt(pattern.length, 10), 1, 64);
	if (!pattern.bars || !pattern.bars.length) {
		pattern.bars = [normalizeSequence64Bar(null, pattern.steps, pattern.length)];
	} else {
		for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
			pattern.bars[barIndex] = normalizeSequence64Bar(pattern.bars[barIndex],
				barIndex === 0 ? pattern.steps : null,
				barIndex === 0 ? pattern.length : 64);
		}
	}
	if (pattern.bars.length > SEQUENCE64_MAX_BARS) pattern.bars.length = SEQUENCE64_MAX_BARS;
	if (!pattern.parkedBars || !Array.isArray(pattern.parkedBars)) pattern.parkedBars = [];
	for (var parkedIndex = 0; parkedIndex < pattern.parkedBars.length; parkedIndex++) {
		pattern.parkedBars[parkedIndex] =
			normalizeSequence64Bar(pattern.parkedBars[parkedIndex], null, 64);
	}
	var parkedLimit = SEQUENCE64_MAX_BARS - pattern.bars.length;
	if (pattern.parkedBars.length > parkedLimit) pattern.parkedBars.length = parkedLimit;
	pattern.steps = pattern.bars[0].steps;
	pattern.length = pattern.bars[0].length;
	pattern.currentBar = clamp(parseInt(pattern.currentBar, 10) || 0, 0, pattern.bars.length - 1);
	if (pattern.running === undefined) pattern.running = 0;
	if (pattern.lastSequencedFlat === undefined) pattern.lastSequencedFlat = -1;
	if (!isFinite(Number(pattern.phaseOrigin))) pattern.phaseOrigin = 0;
	else pattern.phaseOrigin = Number(pattern.phaseOrigin);
	pattern.rateNumerator = clamp(parseInt(pattern.rateNumerator, 10) || 1, 1, 16);
	pattern.rateDenominator = clamp(parseInt(pattern.rateDenominator, 10) || 1, 1, 16);
	if (!isFinite(parseInt(pattern.lastSequencedAbsolute, 10))) {
		pattern.lastSequencedAbsolute = -1;
	} else pattern.lastSequencedAbsolute = parseInt(pattern.lastSequencedAbsolute, 10);
	if (pattern.restartArmed === undefined) pattern.restartArmed = 0;
	var lastUsedTrack = parseInt(pattern.lastUsedTrack, 10);
	pattern.lastUsedTrack = isFinite(lastUsedTrack) && lastUsedTrack >= 0 &&
		lastUsedTrack < s.NUM_TRACKS ? lastUsedTrack : -1;
	if (targetType === "group") resolveSequence64GroupDefaultTrack(targetId, pattern);
	else pattern.defaultTrack = targetId;
	pattern = migrateLegacyTargetToSequence64(pattern, targetType, targetId);
	bindScenePatternAlias(targetType, targetId, pattern, workspace);
	sequence64PlaybackPatterns[key] = pattern;
	return pattern;
}

function currentSequence64Pattern() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!currentEditorTargetKey()) return null;
	if (sequence64PlaybackDisplayReading) {
		return sequence64PlaybackPattern(workspace.targetType, workspace.targetId);
	}
	return ensureSequence64Pattern(workspace.targetType, workspace.targetId);
}

function sequence64PatternTotalLength(pattern) {
	if (!pattern || !pattern.bars || !pattern.bars.length) return 64;
	var total = 0;
	for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
		total += pattern.bars[barIndex].length;
	}
	return Math.max(1, total);
}

function sequence64PatternLocationAtFlat(pattern, flatPosition) {
	if (!pattern) return { bar: 0, step: 0, flat: 0 };
	var total = sequence64PatternTotalLength(pattern);
	var flat = ((parseInt(flatPosition, 10) || 0) % total + total) % total;
	var remaining = flat;
	for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
		if (remaining < pattern.bars[barIndex].length) {
			return { bar: barIndex, step: remaining, flat: flat };
		}
		remaining -= pattern.bars[barIndex].length;
	}
	return { bar: 0, step: 0, flat: 0 };
}

function sequence64PatternRate(pattern) {
	return {
		numerator: pattern ? clamp(parseInt(pattern.rateNumerator, 10) || 1, 1, 16) : 1,
		denominator: pattern ? clamp(parseInt(pattern.rateDenominator, 10) || 1, 1, 16) : 1
	};
}

function sequence64ScaledStepAtClock(origin, numerator, denominator, clockPosition) {
	var elapsed = clockPosition - (isFinite(Number(origin)) ? Number(origin) : 0);
	return Math.floor((elapsed * numerator / denominator) + 0.000000001);
}

function sequence64PatternAbsoluteStep(pattern, clockPosition) {
	var rate = sequence64PatternRate(pattern);
	return sequence64ScaledStepAtClock(pattern ? pattern.phaseOrigin : 0,
		rate.numerator, rate.denominator,
		clockPosition === undefined ? sequence64ClockPosition : clockPosition);
}

function sequence64PlaybackLocation(pattern) {
	var absolute = sequence64PatternAbsoluteStep(pattern, sequence64ClockPosition);
	var location = sequence64PatternLocationAtFlat(pattern, absolute);
	location.absolute = absolute;
	return location;
}

function sequence64TargetPlaybackLocation(targetType, targetId, pattern) {
	if (targetType === "track") {
		var phrase = activeSequence64PhraseForTrack(targetId);
		if (phrase) {
			var phraseAbsolute = sequence64ScaledStepAtClock(phrase.startClock,
				phrase.rateNumerator, phrase.rateDenominator, sequence64ClockPosition);
			var phraseFlat = Math.max(0, Math.min(phrase.totalLength - 1, phraseAbsolute));
			var phraseLocation = sequence64PatternLocationAtFlat(pattern, phraseFlat);
			phraseLocation.absolute = phraseAbsolute;
			return phraseLocation;
		}
	}
	return sequence64PlaybackLocation(pattern);
}

function currentSequence64PlaybackLocation(pattern) {
	var workspace = ensureEditorWorkspaceDefaults();
	return sequence64TargetPlaybackLocation(workspace.targetType, workspace.targetId,
		pattern || currentSequence64Pattern());
}

function sequence64TargetIsPlaying(targetType, targetId, pattern) {
	if (targetType === "track") return !!activeSequence64PhraseForTrack(targetId);
	return !!(pattern && pattern.running);
}

function sequence64FlatForLocation(pattern, barIndex, stepIndex) {
	if (!pattern || !pattern.bars || !pattern.bars.length) return 0;
	var bar = clamp(parseInt(barIndex, 10) || 0, 0, pattern.bars.length - 1);
	var flat = 0;
	for (var index = 0; index < bar; index++) flat += pattern.bars[index].length;
	return flat + clamp(parseInt(stepIndex, 10) || 0, 0, pattern.bars[bar].length - 1);
}

function captureSequence64StructurePosition(pattern, targetType, targetId) {
	var phrase = targetType === "track" ? activeSequence64PhraseForTrack(targetId) : null;
	var rate = phrase ? { numerator: phrase.rateNumerator, denominator: phrase.rateDenominator } : sequence64PatternRate(pattern);
	var origin = phrase ? phrase.startClock : pattern.phaseOrigin;
	var progress = (sequence64ClockPosition - origin) * rate.numerator / rate.denominator;
	var playback = sequence64TargetPlaybackLocation(targetType, targetId, pattern);
	return {
		barRef: pattern && pattern.bars ? pattern.bars[playback.bar] : null,
		fractionalStep: progress - Math.floor(progress),
		step: playback.step,
		restartArmed: pattern && pattern.restartArmed ? 1 : 0
	};
}

function setSequence64PatternPosition(pattern, barIndex, stepIndex) {
	if (!pattern) return null;
	var flat = sequence64FlatForLocation(pattern, barIndex, stepIndex);
	var rate = sequence64PatternRate(pattern);
	pattern.phaseOrigin = sequence64ClockPosition - (flat * rate.denominator / rate.numerator);
	pattern.lastSequencedFlat = flat;
	pattern.lastSequencedAbsolute = flat;
	pattern.restartArmed = 0;
	return sequence64PatternLocationAtFlat(pattern, flat);
}

function currentSequence64StepIndex() {
	var pattern = currentSequence64Pattern();
	return currentSequence64PlaybackLocation(pattern).step;
}

function currentSequence64BarIndex() {
	return currentSequence64PlaybackLocation(currentSequence64Pattern()).bar;
}

function currentSequence64EditBar(pattern) {
	if (!pattern) return null;
	pattern.currentBar = clamp(parseInt(pattern.currentBar, 10) || 0, 0, pattern.bars.length - 1);
	return pattern.bars[pattern.currentBar];
}

function currentSequence64EditStepIndex() {
	var bar = currentSequence64EditBar(currentSequence64Pattern());
	return clamp(parseInt(sequence64SelectedStep, 10) || 0, 0,
		bar ? Math.max(0, bar.length - 1) : 63);
}

function selectSequence64EditStep(stepIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	var bar = currentSequence64EditBar(pattern);
	if (!bar) return false;
	var selected = clamp(parseInt(stepIndex, 10) || 0, 0, Math.max(0, bar.length - 1));
	sequence64SelectedStep = selected;
	if (bar.steps[selected].cut) rememberSequence64EditTrack(pattern, workspace.targetType,
		workspace.targetId, sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, bar.steps[selected]));
	sequence64HeldStep = -1;
	var key = editorTargetKey(workspace.targetType, workspace.targetId);
	if (key) workspace.editCursors64[key] = selected;
	if (sequence64InstrumentPage) {
		var selectedInstrument = sequence64InstrumentTarget();
		if (!selectedInstrument) {
			sequence64InstrumentPage = false;
			sequence64InstrumentBaseEdit = false;
			sequence64EditParameter = "slice";
		} else if (instrumentDescriptorForParameter(sequence64EditParameter) !== selectedInstrument) {
			sequence64InstrumentBaseEdit = false;
			sequence64EditParameter = selectedInstrument.pages[sequence64InstrumentBank].parameters[0];
		}
	}
	outlet(2, "editor_step_selected", selected + 1);
	publishHudEditorState();
	return true;
}

function currentSequence64EditStep() {
	var bar = currentSequence64EditBar(currentSequence64Pattern());
	return bar ? bar.steps[currentSequence64EditStepIndex()] : null;
}

function sequence64GridStep(col, row) {
	if (col < 0 || col >= 16 || row < SEQUENCE64_STEP_FIRST_ROW || row > SEQUENCE64_STEP_LAST_ROW) return -1;
	return (row - SEQUENCE64_STEP_FIRST_ROW) * 16 + col;
}

function sequence64StepCoords(step) {
	var normalized = clamp(parseInt(step, 10) || 0, 0, 63);
	return [normalized % 16, SEQUENCE64_STEP_FIRST_ROW + Math.floor(normalized / 16)];
}

function sequence64StepHasLocks(step) {
	if (!step) return false;
	if (step.locks) {
		for (var name in step.locks) {
			if (step.locks[name]) return true;
		}
	}
	return step.probability < 15 || !!step.condition;
}

function sequence64StepHasContent(step) {
	return !!(step && (step.cut || sequence64StepHasLocks(step)));
}

function sequence64PlayingTrackIndex() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) return -1;
	if (workspace.targetType === "track") {
		var targetTrack = workspace.targetId;
		var targetChannel = getChannelStateByIndex(trackChannelIndex(targetTrack));
		return targetChannel && targetChannel.activeTrack === targetTrack ? targetTrack : -1;
	}
	if (workspace.targetType === "group") {
		var channelState = getChannelStateByIndex(workspace.targetId);
		var activeTrack = channelState ? channelState.activeTrack : -1;
		if (activeTrack >= 0 && activeTrack < s.NUM_TRACKS &&
			trackChannelIndex(activeTrack) === workspace.targetId) return activeTrack;
	}
	return -1;
}

function sequence64TrackPositionColumn() {
	var trackIdx = sequence64PlayingTrackIndex();
	if (trackIdx < 0) return -1;
	var row = trackIdx + 1;
	var bestColumn = -1;
	var bestLevel = 0;
	for (var column = 0; column < 16; column++) {
		var level = playbackBg[bgIndex(column, row)] || 0;
		if (level > bestLevel) {
			bestLevel = level;
			bestColumn = column;
		}
	}
	if (bestColumn >= 0) return bestColumn;
	var trackState = getTrackStateByIndex(trackIdx);
	return trackState ? clamp(parseInt(trackState.playPos, 10) || 0, 0, 15) : -1;
}

function renderSequence64TrackPosition(levels) {
	var position = sequence64TrackPositionColumn();
	if (position < 0) return;
	var index = editorShellLevelIndex(position, SEQUENCE64_TOOLS_ROW);
	levels[index] = Math.max(levels[index], SEQUENCE64_TRACK_POSITION_LEVEL);
}

function sequence64TargetParameterValues(targetType, targetId) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	if (!key) return null;
	if (!workspace.parameterValues64[key]) {
		workspace.parameterValues64[key] = { volume: 15, filter: 15 };
	}
	var values = workspace.parameterValues64[key];
	if (values.volume === undefined) values.volume = 15;
	if (values.filter === undefined) values.filter = 15;
	return values;
}

function currentSequence64ParameterValues() {
	var workspace = ensureEditorWorkspaceDefaults();
	return sequence64TargetParameterValues(workspace.targetType, workspace.targetId);
}

function ensureEditorTargetArray(storeName, targetType, targetId, defaultValue) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	if (!key) return null;
	if (!workspace[storeName]) workspace[storeName] = {};
	var values = workspace[storeName][key];
	if (!values || values.length !== 16) {
		values = new Array(16);
		for (var i = 0; i < values.length; i++) {
			values[i] = typeof defaultValue === "function" ? defaultValue(i) : defaultValue;
		}
		workspace[storeName][key] = values;
	}
	return values;
}

function ensureEditorStepPattern(targetType, targetId) {
	return ensureEditorTargetArray("stepPatterns", targetType, targetId, 0);
}

function currentEditorStepPattern() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!currentEditorTargetKey()) return null;
	return ensureEditorStepPattern(workspace.targetType, workspace.targetId);
}

function currentEditorProbabilities() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!currentEditorTargetKey()) return null;
	return ensureEditorTargetArray("stepProbabilities", workspace.targetType, workspace.targetId, 15);
}

function currentEditorGateFxLevels() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!currentEditorTargetKey()) return null;
	return ensureEditorTargetArray("gateFxLevels", workspace.targetType, workspace.targetId, 15);
}

function currentEditorGateFxEnabled() {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = currentEditorTargetKey();
	return key && workspace.gateFxEnabled[key] ? 1 : 0;
}

function setCurrentEditorGateFxEnabled(enabled) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = currentEditorTargetKey();
	if (!key) return;
	workspace.gateFxEnabled[key] = enabled ? 1 : 0;
	if (!workspace.gateFxEnabled[key]) restoreEditorGateFx();
	outlet(2, "editor_fx_run", workspace.targetType, workspace.targetId + 1,
		workspace.gateFxEnabled[key]);
}

function editorSequenceEnabled(targetType, targetId) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	return key && workspace.sequenceEnabled[key] ? 1 : 0;
}

function currentEditorSequenceEnabled() {
	var workspace = ensureEditorWorkspaceDefaults();
	return editorSequenceEnabled(workspace.targetType, workspace.targetId);
}

function setCurrentEditorSequenceEnabled(enabled) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = currentEditorTargetKey();
	if (!key) return;
	workspace.sequenceEnabled[key] = enabled ? 1 : 0;
	workspace.lastSequencedStep = currentEditorClockStep();
	outlet(2, "editor_run", workspace.targetType, workspace.targetId + 1,
		workspace.sequenceEnabled[key]);
}

function ensureEditorAutomation(targetType, targetId) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	if (!key) return null;
	var automation = workspace.targetAutomation[key];
	if (!automation) {
		automation = { recording: 0, playing: 0, events: new Array(16) };
		workspace.targetAutomation[key] = automation;
	}
	if (!automation.events || automation.events.length !== 16) automation.events = new Array(16);
	for (var i = 0; i < 16; i++) {
		if (!automation.events[i]) automation.events[i] = [];
	}
	if (automation.recording === undefined) automation.recording = 0;
	if (automation.playing === undefined) automation.playing = 0;
	return automation;
}

function currentEditorAutomation() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!currentEditorTargetKey()) return null;
	return ensureEditorAutomation(workspace.targetType, workspace.targetId);
}

function stopCurrentEditorAutomationRecording() {
	var automation = currentEditorAutomation();
	if (automation) automation.recording = 0;
}

function editorAutomationEventCategory(type) {
	if (type === "loop" || type === "subLoopDiv" || type === "latch") return 0;
	if (type === "volume") return 1;
	if (type === "octave" || type === "transpose" || type === "group") return 2;
	if (type === "reverse" || type === "randomOffset" || type === "timestretch" || type === "mute") return 3;
	return 4;
}

function editorAutomationStepHasEvents(automation, step, category) {
	if (!automation || !automation.events[step]) return false;
	for (var i = 0; i < automation.events[step].length; i++) {
		if (category === undefined || editorAutomationEventCategory(automation.events[step][i].type) === category) {
			return true;
		}
	}
	return false;
}

function editorAutomationHasEvents(automation) {
	if (!automation) return false;
	for (var step = 0; step < 16; step++) {
		if (editorAutomationStepHasEvents(automation, step)) return true;
	}
	return false;
}

function recordEditorAutomationEvent(type, value) {
	if (editorAutomationDispatching) return;
	var workspace = ensureEditorWorkspaceDefaults();
	var automation = currentEditorAutomation();
	if (!automation || !automation.recording) return;
	var step = currentEditorClockStep();
	var events = automation.events[step];
	for (var i = events.length - 1; i >= 0; i--) {
		if (events[i].type === type) events.splice(i, 1);
	}
	events.push({ type: type, value: value });
	outlet(2, "editor_automation_event", workspace.targetType, workspace.targetId + 1, step + 1, type);
}

function currentEditorTrackIndex() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) return -1;
	return sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, null);
}

function sequence64TargetTrackIndex(targetType, targetId, step) {
	if (targetType === "track") {
		return targetId >= 0 && targetId < s.NUM_TRACKS ? targetId : -1;
	}
	if (step && step.cut && step.cut.track >= 0 && step.cut.track < s.NUM_TRACKS) {
		return sequence64TrackBelongsToGroup(step.cut.track, targetId) ? step.cut.track : -1;
	}
	if (targetType === "group" && targetId >= 0 && targetId < s.NUM_CHANNELS) {
		var workspace = ensureEditorWorkspaceDefaults();
		var pattern = workspace.patterns64[editorTargetKey(targetType, targetId)];
		return resolveSequence64GroupDefaultTrack(targetId, pattern);
	}
	return -1;
}

function sequence64KickTarget(step) {
	var workspace = ensureEditorWorkspaceDefaults();
	return sequence64TargetTrackIndex(workspace.targetType, workspace.targetId,
		step === undefined ? currentSequence64EditStep() : step) === Instruments.KICK_TRACK;
}

function sequence64InstrumentTarget(step) {
	var workspace = ensureEditorWorkspaceDefaults();
	var trackIdx = sequence64TargetTrackIndex(workspace.targetType, workspace.targetId,
		step === undefined ? currentSequence64EditStep() : step);
	return instrumentDescriptorForTrack(trackIdx);
}

function sequence64VisibleParameters() {
	var workspace = ensureEditorWorkspaceDefaults();
	var instrument = sequence64InstrumentTarget();
	if (sequence64InstrumentPage && instrument) return instrument.pages[sequence64InstrumentBank].parameters.slice();
	return workspace.targetType === "group" ?
		SEQUENCE64_PARAMETERS : SEQUENCE64_PARAMETERS.slice(0, 8).concat(["condition"]);
}

function sequence64ParameterColor(parameter) {
	if (instrumentDefinition(parameter)) return SEQUENCE64_COLORS.motion;
	var index = SEQUENCE64_PARAMETERS.indexOf(parameter);
	return index >= 0 ? SEQUENCE64_PARAMETER_COLORS[index] : SEQUENCE64_COLORS.neutral;
}

function currentEditorChannelIndex() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) return -1;
	return sequence64TargetChannelIndex(workspace.targetType, workspace.targetId);
}

function sequence64TargetChannelIndex(targetType, targetId) {
	if (targetType === "group") {
		return targetId >= 0 && targetId < s.NUM_CHANNELS ? targetId : -1;
	}
	var trackIdx = sequence64TargetTrackIndex(targetType, targetId, null);
	return trackIdx >= 0 ? trackChannelIndex(trackIdx) : -1;
}

function currentEditorClockStep() {
	return Math.floor((s.automation.tick || 0) / EDITOR_STEP_TICKS) % 16;
}

function editorProbabilityPass(level) {
	var normalized = clamp(parseInt(level, 10) || 0, 0, 15);
	if (normalized <= 0) return false;
	if (normalized >= 15) return true;
	return Math.random() < (normalized / 15);
}

/**
 * Step conditions count visits to the same pattern cycle position. Positive N
 * plays only visits N, 2N, 3N…; negative N plays every visit except those.
 * Visit numbers begin at one whenever the owning group pattern restarts.
 */
function sequence64ConditionPass(step, visitNumber) {
	var condition = step ? parseInt(step.condition, 10) : 0;
	if (!isFinite(condition) || Math.abs(condition) < 2) return true;
	var every = clamp(Math.abs(condition), 2, 9);
	var visit = Math.max(1, parseInt(visitNumber, 10) || 1);
	var isNth = visit % every === 0;
	return condition > 0 ? isNth : !isNth;
}

function sequence64ConditionVisit(pattern, absoluteStep) {
	var total = sequence64PatternTotalLength(pattern);
	var absolute = Math.max(0, parseInt(absoluteStep, 10) || 0);
	return Math.floor(absolute / total) + 1;
}

function recordSequence64Decision(targetType, targetId, barIndex, stepIndex, outcome) {
	var targetKey = editorTargetKey(targetType, targetId);
	if (!targetKey) return;
	sequence64DecisionFeedback[targetKey] = {
		bar: Math.max(0, parseInt(barIndex, 10) || 0),
		step: clamp(parseInt(stepIndex, 10) || 0, 0, 63),
		outcome: String(outcome || ""),
		clock: sequence64ClockPosition
	};
}

function clearSequence64Decision(targetType, targetId) {
	var targetKey = editorTargetKey(targetType, targetId);
	if (targetKey) delete sequence64DecisionFeedback[targetKey];
}

function sequence64DecisionOutcomeAt(targetType, targetId, barIndex, stepIndex) {
	var feedback = sequence64DecisionFeedback[editorTargetKey(targetType, targetId)];
	if (!feedback || feedback.clock !== sequence64ClockPosition ||
		feedback.bar !== barIndex || feedback.step !== stepIndex) return "";
	return feedback.outcome;
}

function sequence64DecisionColorAt(targetType, targetId, barIndex, stepIndex) {
	var outcome = sequence64DecisionOutcomeAt(targetType, targetId, barIndex, stepIndex);
	return outcome && SEQUENCE64_COLORS[outcome] ? SEQUENCE64_COLORS[outcome] : null;
}

function sequence64StepDecisionPass(targetType, targetId, barIndex, stepIndex, step, conditionVisit) {
	clearSequence64Decision(targetType, targetId);
	var condition = step ? parseInt(step.condition, 10) || 0 : 0;
	var hasCondition = Math.abs(condition) >= 2;
	var conditionPasses = sequence64ConditionPass(step, conditionVisit);
	if (!conditionPasses) {
		recordSequence64Decision(targetType, targetId, barIndex, stepIndex, "conditionSkip");
		return false;
	}
	var probability = step ? clamp(parseInt(step.probability, 10) || 0, 0, 15) : 0;
	var probabilityPasses = editorProbabilityPass(probability);
	if (probability < 15) {
		recordSequence64Decision(targetType, targetId, barIndex, stepIndex,
			probabilityPasses ? "probabilityPlay" : "probabilitySkip");
	} else if (hasCondition) {
		recordSequence64Decision(targetType, targetId, barIndex, stepIndex, "conditionPlay");
	}
	return probabilityPasses;
}

function emitSequence64PlaybackPing(trackIdx, position) {
	if (s.kmod !== 1) return false;
	var row = trackIdx + 1;
	if (row < 1 || row >= s.gridHeight) return false;
	sequence64PlaybackPingGuard = {
		track: trackIdx,
		position: position,
		expiresAt: Date.now() + 250
	};
	kfping(position, row, 15, 24);
	return true;
}

function consumeSequence64PlaybackPingGuard(trackIdx, position) {
	var guard = sequence64PlaybackPingGuard;
	if (!guard) return false;
	if (Date.now() > guard.expiresAt) {
		sequence64PlaybackPingGuard = null;
		return false;
	}
	if (guard.track !== trackIdx || guard.position !== position) return false;
	sequence64PlaybackPingGuard = null;
	return true;
}

function primeTrackPlaybackPosition(trackIdx, position, deferDisplay) {
	var row = trackIdx + 1;
	if (row < 1 || row >= s.gridHeight) return;
	for (var column = 0; column < s.gridWidth; column++) {
		playbackBg[bgIndex(column, row)] = column === position ? 15 : 0;
	}
	if (deferDisplay) playbackDisplayBackgroundTracks[trackIdx] = true;
	else if (s.kmod === 1) redrawTrackBackground(trackIdx);
}

function clearTrackPlaybackPosition(trackIdx, deferDisplay) {
	var row = trackIdx + 1;
	if (row < 1 || row >= s.gridHeight) return;
	for (var column = 0; column < s.gridWidth; column++) {
		playbackBg[bgIndex(column, row)] = 0;
	}
	if (deferDisplay) playbackDisplayBackgroundTracks[trackIdx] = true;
	else if (s.kmod === 1) redrawTrackBackground(trackIdx);
}

function clearChannelPlaybackPositions(channelIdx, exceptTrackIdx, deferDisplay) {
	for (var trackIdx = 0; trackIdx < s.NUM_TRACKS; trackIdx++) {
		if (trackIdx === exceptTrackIdx || trackChannelIndex(trackIdx) !== channelIdx) continue;
		clearTrackPlaybackPosition(trackIdx, deferDisplay);
	}
}

function triggerEditorTrack(trackIdx, slice, ownerKey, instrumentOverrides) {
	if (!rtaEnabled()) return false;
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return false;
	var position = clamp(parseInt(slice, 10) || 0, 0, 15);
	var channelIdx = trackChannelIndex(trackIdx);
	applyNativeModulationGroup(channelIdx, trackIdx);
	modulationTrigger("group", channelIdx, 0);
	modulationTrigger("group", channelIdx, 1);
	// A direct editor/live cut supersedes a child phrase on this shared player.
	// Phrase-owned triggers pass their owner key and have already performed the
	// channel retrigger arbitration in launchSequence64TrackPhrase().
	if (!ownerKey) {
		cancelSequence64PhraseForChannel(channelIdx, "manual_trigger", false);
		cancelSequence64AudioForChannel(channelIdx);
	}
	var channelState = getChannelStateByIndex(channelIdx);
	trackState.playPos = position;
	trackState.subLoopAnchor = position;
	channelState.activeTrack = trackIdx;
	channelState.sequence64Owner = ownerKey || null;
	primeTrackPlaybackPosition(trackIdx, position);
	diagnosticEvent("sequence64_trigger", function () {
		var triggerDetails = diagnosticTrackSnapshot(trackIdx, position);
		triggerDetails.nativeArmed = ownerKey ? 1 : 0;
		return triggerDetails;
	});
	// Do not depend on the stopped audio group reporting chRowPos back before
	// showing the main-page cut. The matching callback consumes the guard below
	// so a healthy audio round trip does not create a duplicate keyframe.
	emitSequence64PlaybackPing(trackIdx, position);
	if (ownerKey) {
		// The native bridge performs press → player trigger → release at the next
		// raw clock boundary, entirely outside the low-priority V8 callback.
		armSequence64AudioTrigger(channelIdx, trackIdx, position, instrumentOverrides);
	} else {
		sendTrackInput(trackIdx, position, 1);
		messnamed((channelIdx + 1) + "[mlr]pl-trig-now", "bang");
		sendTrackInput(trackIdx, position, 0);
	}
	if (channelLatchEnabledForTrack(trackIdx)) reapplyTrackSubLoopAfterTrigger(trackIdx, position);
	else restoreTrackLoop(trackIdx);
	outlet(2, "editor_trigger", trackIdx + 1, position + 1);
	return true;
}

function setEditorGateFxLevel(channelIdx, level) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (channelIdx < 0 || channelIdx >= s.NUM_CHANNELS) return;
	if (workspace.fxAppliedChannel >= 0 && workspace.fxAppliedChannel !== channelIdx) {
		messnamed((workspace.fxAppliedChannel + 1) + "[gatefx]level", 1, EDITOR_GATE_FX_RAMP_MS);
	}
	workspace.fxAppliedChannel = channelIdx;
	messnamed((channelIdx + 1) + "[gatefx]level", clamp(level, 0, 15) / 15,
		EDITOR_GATE_FX_RAMP_MS);
}

function restoreEditorGateFx() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (workspace.fxAppliedChannel >= 0 && workspace.fxAppliedChannel < s.NUM_CHANNELS) {
		messnamed((workspace.fxAppliedChannel + 1) + "[gatefx]level", 1, EDITOR_GATE_FX_RAMP_MS);
	}
	workspace.fxAppliedChannel = -1;
}

function editorGateFxLaneIsActive(levels) {
	if (!levels) return false;
	for (var i = 0; i < levels.length; i++) {
		if (levels[i] < 15) return true;
	}
	return false;
}

function applyEditorGateFxStep(step) {
	var levels = currentEditorGateFxLevels();
	if (!currentEditorGateFxEnabled() || !editorGateFxLaneIsActive(levels)) {
		restoreEditorGateFx();
		return;
	}
	setEditorGateFxLevel(currentEditorChannelIndex(), levels[step]);
}

function runEditorTriggerStep(step) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!currentEditorSequenceEnabled()) return;
	var pattern = currentEditorStepPattern();
	var probabilities = currentEditorProbabilities();
	if (!pattern || !pattern[step] || !editorProbabilityPass(probabilities[step])) return;
	var trackIdx = currentEditorTrackIndex();
	if (trackIdx < 0) {
		outlet(2, "editor_waiting_for_track", workspace.targetType, workspace.targetId + 1);
		return;
	}
	triggerEditorTrack(trackIdx, step);
}

function toggleEditorStep(col) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentEditorStepPattern();
	if (!pattern || col < 0 || col >= pattern.length) return;
	pattern[col] = pattern[col] ? 0 : 1;
	outlet(2, "editor_step", workspace.targetType, workspace.targetId + 1, col + 1, pattern[col]);
	post("[grid_router] editor step " + workspace.targetType + " " + (workspace.targetId + 1) +
		" step=" + (col + 1) + " state=" + pattern[col] + "\n");
	redrawEditorShellDiff();
}

function createEditorShellLevels() {
	return new Array(16 * 8).fill(0);
}

function editorShellLevelIndex(x, y) {
	return (y - EDITOR_FIRST_ROW) * 16 + x;
}

function setEditorShellLevel(levels, x, y, level) {
	if (x < 0 || x >= 16 || y < EDITOR_FIRST_ROW || y > EDITOR_NAV_ROW) return;
	levels[editorShellLevelIndex(x, y)] = clamp(level | 0, 0, 15);
}

function createEditorShellColors(defaultColor) {
	var colors = new Array(16 * 8);
	var fallback = defaultColor || SEQUENCE64_COLORS.neutral;
	for (var i = 0; i < colors.length; i++) colors[i] = fallback;
	return colors;
}

function setEditorShellColor(colors, x, y, rgb) {
	if (x < 0 || x >= 16 || y < EDITOR_FIRST_ROW || y > EDITOR_NAV_ROW || !rgb) return;
	colors[editorShellLevelIndex(x, y)] = rgb;
}

function sequence64GateTailMap(bar) {
	var tails = new Array(64).fill(0);
	if (!bar) return tails;
	for (var source = 0; source < bar.length; source++) {
		var step = bar.steps[source];
		if (!step.cut || step.cut.gateLength <= 1) continue;
		for (var tail = 1; tail < step.cut.gateLength && tail < bar.length; tail++) {
			tails[(source + tail) % bar.length] = 1;
		}
	}
	return tails;
}

function renderSequence64StepColors(colors, pattern, bar, playback) {
	var workspace = ensureEditorWorkspaceDefaults();
	var targetPlaying = sequence64TargetIsPlaying(workspace.targetType,
		workspace.targetId, pattern);
	var tails = sequence64GateTailMap(bar);
	var selectedStepIndex = clamp(parseInt(sequence64SelectedStep, 10) || 0, 0, Math.max(0, bar.length - 1));
	for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
		var coords = sequence64StepCoords(stepIndex);
		var step = bar.steps[stepIndex];
		var rgb = stepIndex < bar.length ? SEQUENCE64_OFF_COLOR : SEQUENCE64_COLORS.unavailable;
		if (tails[stepIndex]) rgb = SEQUENCE64_COLORS.gateTail;
		if (sequence64StepHasLocks(step)) rgb = SEQUENCE64_COLORS.lock;
		if (step.cut) {
			rgb = step.cut.gateLength > 1 ? SEQUENCE64_COLORS.triggerGate : SEQUENCE64_COLORS.trigger;
		}
		if (step.cut && sequence64StepHasLocks(step)) rgb = SEQUENCE64_COLORS.triggerLock;
		if (stepIndex === selectedStepIndex && stepIndex < bar.length && sequence64StepHasContent(step))
			rgb = sequence64SelectionColor(rgb);
		if (targetPlaying && playback.bar === pattern.currentBar && playback.step === stepIndex) {
			rgb = sequence64DecisionColorAt(workspace.targetType, workspace.targetId,
				playback.bar, stepIndex) || SEQUENCE64_COLORS.playhead;
		}
		if (sequence64PressedStep === stepIndex) {
			rgb = SEQUENCE64_COLORS.held;
		}
		setEditorShellColor(colors, coords[0], coords[1], rgb);
	}
}

function renderSequence64ControlColors(colors) {
	if (sequence64InstrumentTarget()) setEditorShellColor(colors, 15, SEQUENCE64_LENGTH_ROW, SEQUENCE64_COLORS.motion);
	if (sequence64InstrumentPage && sequence64InstrumentTarget() && sequence64InspectorContext === "parameter") {
		for (var instrumentTool = 2; instrumentTool <= 4; instrumentTool++) setEditorShellColor(colors, instrumentTool, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.motion);
	}
	if (sequence64ModMatrixActive) {
		for (var modSourceColor = 0; modSourceColor < Modulation.SOURCE_IDS.length; modSourceColor++) {
			setEditorShellColor(colors, modSourceColor, 8, SEQUENCE64_COLORS.motion);
		}
		for (var modAmountColor = 0; modAmountColor < 16; modAmountColor++) {
			setEditorShellColor(colors, modAmountColor, 9, sequence64ParameterColor("filter"));
		}
		for (var modRateColor = 0; modRateColor < MODULATION_RATE_CHOICES.length; modRateColor++) {
			setEditorShellColor(colors, modRateColor, 10, SEQUENCE64_COLORS.rate);
		}
		for (var modModeColor = 0; modModeColor < 4; modModeColor++) {
			setEditorShellColor(colors, modModeColor, 11, SEQUENCE64_COLORS.motion);
		}
		setEditorShellColor(colors, 15, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.exit);
		return;
	}
	for (var persistentLength = 0; persistentLength < SEQUENCE64_LENGTHS.length;
		persistentLength++) {
		setEditorShellColor(colors, persistentLength, SEQUENCE64_LENGTH_ROW,
			SEQUENCE64_COLORS.length);
	}
	for (var persistentBar = 0; persistentBar < SEQUENCE64_MAX_BARS; persistentBar++) {
		setEditorShellColor(colors, SEQUENCE64_BAR_FIRST_COL + persistentBar,
			SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.bar);
	}
	if (sequence64InspectorContext === "parameter") {
		var parameters = sequence64VisibleParameters();
		var parameterIndex = parameters.indexOf(sequence64EditParameter);
		if (parameterIndex < 0) parameterIndex = 0;
		for (var parameter = 0; parameter < parameters.length; parameter++) {
			setEditorShellColor(colors, SEQUENCE64_PARAMETER_FIRST_COL + parameter, SEQUENCE64_LENGTH_ROW,
				sequence64ParameterColor(parameters[parameter]));
		}
		setEditorShellColor(colors, SEQUENCE64_PATTERN_CONTEXT_COL, SEQUENCE64_LENGTH_ROW,
			SEQUENCE64_COLORS.bar);
		var maxValueColumn = sequence64EditParameter === "loopDivision" ? 7 : 15;
		for (var value = 0; value <= maxValueColumn; value++) {
			if (sequence64EditParameter === "track" &&
				!sequence64TrackBelongsToGroup(value, ensureEditorWorkspaceDefaults().targetId)) continue;
			setEditorShellColor(colors, value, SEQUENCE64_TRANSPORT_ROW,
				sequence64EditParameter === "transpose" && value < SEQUENCE64_TRANSPOSE_FIRST_COL ?
					SEQUENCE64_COLORS.octave : sequence64ParameterColor(sequence64EditParameter));
		}
		if (sequence64EditParameter === "slice" && !sequence64ModEditActive) {
			var slicePosition = sequence64TrackPositionColumn();
			if (slicePosition >= 0) {
				setEditorShellColor(colors, slicePosition, SEQUENCE64_TRANSPORT_ROW,
					SEQUENCE64_COLORS.trackPosition);
			}
		}
		setEditorShellColor(colors, 0, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.trigger);
		setEditorShellColor(colors, 1, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.record);
		if (sequence64EditParameter === "volume" || sequence64EditParameter === "filter") {
			for (var behavior = 0; behavior < SEQUENCE64_BEHAVIORS.length; behavior++) {
				setEditorShellColor(colors, SEQUENCE64_BEHAVIOR_FIRST_COL + behavior, SEQUENCE64_TOOLS_ROW,
					SEQUENCE64_BEHAVIOR_COLORS[behavior]);
			}
		}
		if (sequence64EditParameter === "filter") {
			for (var source = 0; source < Modulation.SOURCE_IDS.length; source++) {
				setEditorShellColor(colors, 11 + source, SEQUENCE64_TOOLS_ROW,
					SEQUENCE64_COLORS.motion);
			}
		}
		setEditorShellColor(colors, 15, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.remove);
		return;
	}

	setEditorShellColor(colors, 12, SEQUENCE64_TRANSPORT_ROW, SEQUENCE64_COLORS.bar);
	setEditorShellColor(colors, 13, SEQUENCE64_TRANSPORT_ROW, SEQUENCE64_COLORS.bar);
	setEditorShellColor(colors, 14, SEQUENCE64_TRANSPORT_ROW, SEQUENCE64_COLORS.add);
	setEditorShellColor(colors, 15, SEQUENCE64_TRANSPORT_ROW, SEQUENCE64_COLORS.remove);
	setEditorShellColor(colors, 0, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.run);
	setEditorShellColor(colors, 1, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.record);
	setEditorShellColor(colors, 2, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.restart);
	setEditorShellColor(colors, 3, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.stop);
	setEditorShellColor(colors, 15, SEQUENCE64_TOOLS_ROW, SEQUENCE64_COLORS.remove);
	var patternParameters = sequence64VisibleParameters();
	for (var patternParameter = 0; patternParameter < patternParameters.length; patternParameter++) {
		setEditorShellColor(colors, SEQUENCE64_PARAMETER_FIRST_COL + patternParameter,
			SEQUENCE64_LENGTH_ROW, sequence64ParameterColor(patternParameters[patternParameter]));
	}
	setEditorShellColor(colors, SEQUENCE64_PATTERN_CONTEXT_COL, SEQUENCE64_LENGTH_ROW,
		SEQUENCE64_COLORS.bar);
}

function sequence64ModulationRouteForSource(sourceId) {
	var workspace = ensureEditorWorkspaceDefaults();
	var routes = workspace.modulation.routes || [];
	for (var index = 0; index < routes.length; index++) {
		var route = routes[index];
		if (route.scope === workspace.targetType && route.targetId === workspace.targetId &&
			route.parameterId === sequence64EditParameter &&
			route.sourceId === sourceId) return route;
	}
	return null;
}

function currentSequence64ModulationRoute() {
	return sequence64ModulationRouteForSource(sequence64ModSource);
}

function modulationAmountColumn(amount) {
	var value = clamp(parseFloat(amount) || 0, -1, 1);
	if (value < 0) return clamp(Math.round(value * 8 + 8), 0, 7);
	if (value > 0) return clamp(Math.round(value * 8 + 7), 8, 15);
	return -1;
}

function modulationAmountAtColumn(column) {
	return column < 8 ? (column - 8) / 8 : (column - 7) / 8;
}

function renderSequence64ModMatrix(levels) {
	var workspace = ensureEditorWorkspaceDefaults();
	var route = currentSequence64ModulationRoute();
	for (var source = 0; source < Modulation.SOURCE_IDS.length; source++) {
		setEditorShellLevel(levels, source, 8,
			Modulation.SOURCE_IDS[source] === sequence64ModSource ? 15 : 5);
	}
	var amountColumn = route && route.enabled ? modulationAmountColumn(route.amount) : -1;
	for (var amount = 0; amount < 16; amount++) {
		setEditorShellLevel(levels, amount, 9, amount === amountColumn ? 15 : 3);
	}
	var sourceKey = Modulation.sourceKey(workspace.targetType, workspace.targetId,
		sequence64ModSource);
	var settings = workspace.modulation.sources[sourceKey] ||
		Modulation.defaultSource(sequence64ModSource);
	var rateIndex = -1;
	if (settings.rate) {
		for (var rate = 0; rate < MODULATION_RATE_CHOICES.length; rate++) {
			if (settings.rate[0] === MODULATION_RATE_CHOICES[rate][0] &&
				settings.rate[1] === MODULATION_RATE_CHOICES[rate][1]) rateIndex = rate;
		}
	}
	for (var rateCell = 0; rateCell < MODULATION_RATE_CHOICES.length; rateCell++) {
		setEditorShellLevel(levels, rateCell, 10, rateCell === rateIndex ? 15 : 3);
	}
	if (sequence64ModSource === "lfo1" || sequence64ModSource === "lfo2") {
		setEditorShellLevel(levels, 0, 11, settings.polarity !== "unipolar" ? 15 : 4);
		setEditorShellLevel(levels, 1, 11, settings.polarity === "unipolar" ? 15 : 4);
		setEditorShellLevel(levels, 2, 11, settings.reset !== "transport" ? 15 : 4);
		setEditorShellLevel(levels, 3, 11, settings.reset === "transport" ? 15 : 4);
	}
	setEditorShellLevel(levels, 15, SEQUENCE64_TOOLS_ROW, 8);
	setEditorShellLevel(levels, 0, SEQUENCE64_NAV_ROW, 15);
}

function renderSequence64NavigationColors(colors) {
	setEditorShellColor(colors, 0, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.sequence);
	setEditorShellColor(colors, 1, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.setup);
	setEditorShellColor(colors, 2, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.sequence);
	setEditorShellColor(colors, 11, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.shift);
	setEditorShellColor(colors, 12, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.sampleBrowser);
	setEditorShellColor(colors, 13, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.targetJump);
	setEditorShellColor(colors, SEQUENCE64_DELETE_COL, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.remove);
	setEditorShellColor(colors, 15, SEQUENCE64_NAV_ROW, SEQUENCE64_COLORS.exit);
}

function renderSequence64ShiftColors(colors, pattern, bar) {
	for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
		var coords = sequence64StepCoords(stepIndex);
		setEditorShellColor(colors, coords[0], coords[1],
			stepIndex === bar.length - 1 ? SEQUENCE64_COLORS.held : SEQUENCE64_COLORS.length);
	}
	for (var rateIndex = 0; rateIndex < SEQUENCE64_RATE_CHOICES.length; rateIndex++) {
		setEditorShellColor(colors, rateIndex, SEQUENCE64_TRANSPORT_ROW,
			SEQUENCE64_COLORS.rate);
	}
	renderSequence64NavigationColors(colors);
}

function renderSequence64SetupColors(colors) {
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		setEditorShellColor(colors, group, 8, GROUP_COLORS[group]);
	}
	for (var volume = 0; volume < 16; volume++) {
		setEditorShellColor(colors, volume, 9, SEQUENCE64_COLORS.volume);
	}
	for (var pitchCell = 0; pitchCell < 16; pitchCell++) {
		setEditorShellColor(colors, pitchCell, 10,
			pitchCell < SEQUENCE64_TRANSPOSE_FIRST_COL ?
				SEQUENCE64_COLORS.octave : SEQUENCE64_COLORS.transpose);
	}
	setEditorShellColor(colors, 0, 11, SEQUENCE64_COLORS.reverse);
	setEditorShellColor(colors, 1, 11, SEQUENCE64_COLORS.random);
	for (var division = 0; division < TRACK_SUB_LOOP_OPTIONS.length; division++) {
		setEditorShellColor(colors, division + 2, 11, SEQUENCE64_COLORS.division);
	}
	for (var loopCell = 0; loopCell < 16; loopCell++) {
		setEditorShellColor(colors, loopCell, 12, SEQUENCE64_COLORS.loopStart);
		setEditorShellColor(colors, loopCell, 13, SEQUENCE64_COLORS.loopEnd);
	}
	setEditorShellColor(colors, 0, 14, SEQUENCE64_COLORS.loopStart);
	setEditorShellColor(colors, 1, 14, SEQUENCE64_COLORS.latch);
	setEditorShellColor(colors, 2, 14, SEQUENCE64_COLORS.stretch);
	setEditorShellColor(colors, 3, 14, SEQUENCE64_COLORS.mute);
	setEditorShellColor(colors, 4, 14, SEQUENCE64_COLORS.motion);
	setEditorShellColor(colors, 5, 14, SEQUENCE64_COLORS.restore);
	setEditorShellColor(colors, 6, 14, SEQUENCE64_COLORS.playbackLoop);
	if (instrumentDescriptorForTrack(currentEditorTrackIndex())) {
		for (var slot = 0; slot < 8; slot++)
			setEditorShellColor(colors, 7 + slot, 14, SEQUENCE64_COLORS.motion);
	}
	renderSequence64NavigationColors(colors);
}

function buildEditorShellColors(levels) {
	var colors = createEditorShellColors();
	var workspace = ensureEditorWorkspaceDefaults();
	if (sequence64LayoutEnabled()) {
		if (workspace.view64 === "setup") {
			renderSequence64SetupColors(colors);
		} else {
			var pattern = currentSequence64Pattern();
			if (pattern) {
				var bar = currentSequence64EditBar(pattern);
				if (sequence64ModMatrixActive) {
					renderSequence64ControlColors(colors);
				} else if (sequence64ShiftHeld) {
					renderSequence64ShiftColors(colors, pattern, bar);
				} else {
					renderSequence64StepColors(colors, pattern, bar,
						currentSequence64PlaybackLocation(pattern));
					renderSequence64ControlColors(colors);
					renderSequence64NavigationColors(colors);
				}
			}
		}
		return colors;
	}

	for (var y = EDITOR_FIRST_ROW; y <= EDITOR_NAV_ROW; y++) {
		for (var x = 0; x < 16; x++) {
			var level = levels[editorShellLevelIndex(x, y)];
			setEditorShellColor(colors, x, y, editorBrightnessRgb(level));
		}
	}
	return colors;
}

function queueEditorShellColors(colors) {
	if (!s.editorBrightnessColors || !colors) return 0;
	var queuedCount = 0;
	var dirtyBlocks = new Array(8).fill(0);
	var dirtyCells = [];
	for (var y = EDITOR_FIRST_ROW; y <= EDITOR_NAV_ROW; y++) {
		for (var x = 0; x < 16; x++) {
			var rgb = colors[editorShellLevelIndex(x, y)];
			var signature = rgb.join(",");
			var cacheIndex = editorLevelIndex(x, y);
			if (editorColorCache[cacheIndex] === signature) continue;
			editorColorCache[cacheIndex] = signature;
			var blockIndex = Math.floor((y - EDITOR_FIRST_ROW) / 4) * 4 +
				Math.floor(x / 4);
			dirtyBlocks[blockIndex]++;
			dirtyCells.push([x, y, rgb, blockIndex]);
			queuedCount++;
		}
	}
	for (var block = 0; block < dirtyBlocks.length; block++) {
		if (dirtyBlocks[block] >= 4) {
			var blockX = (block % 4) * 4;
			var blockY = EDITOR_FIRST_ROW + Math.floor(block / 4) * 4;
			var mapColors = [];
			for (var mapY = 0; mapY < 4; mapY++) {
				for (var mapX = 0; mapX < 4; mapX++) {
					var mapRgb = colors[editorShellLevelIndex(blockX + mapX, blockY + mapY)];
					mapColors.push(clamp8(mapRgb[0]), clamp8(mapRgb[1]), clamp8(mapRgb[2]));
				}
			}
			queueColorMapFrom(blockX, blockY, mapColors);
		} else if (dirtyBlocks[block]) {
			for (var cell = 0; cell < dirtyCells.length; cell++) {
				if (dirtyCells[cell][3] !== block) continue;
				queueColorCellFrom(dirtyCells[cell][0], dirtyCells[cell][1],
					dirtyCells[cell][2]);
			}
		}
	}
	if (queuedCount) startPageColorQueue();
	return queuedCount;
}

function queueCurrentEditorShellColors(resetCache) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!s.editorBrightnessColors || s.kmod !== 2 || workspace.choosing) return 0;
	if (sequence64LayoutEnabled() && (!workspace.active || workspace.collapsed)) {
		if (resetCache) invalidateEditorColorCache();
		var navigationColors = [SEQUENCE64_COLORS.sequence, SEQUENCE64_COLORS.setup,
			SEQUENCE64_COLORS.sequence];
		for (var navigation = 0; navigation < navigationColors.length; navigation++) {
			queueColorCellFrom(navigation, SEQUENCE64_NAV_ROW, navigationColors[navigation]);
		}
		return navigationColors.length;
	}
	if (!workspace.active) return 0;
	if (sequence64LayoutEnabled() && workspace.view64 === "scene") {
		var queued = queueSceneColorPalette(resetCache);
		if (queued) startPageColorQueue();
		return queued;
	}
	if (resetCache) invalidateEditorColorCache();
	editorScenePaletteVisible = false;
	var levels = buildEditorShellLevels();
	return queueEditorShellColors(buildEditorShellColors(levels));
}

function renderEditorStepPage(levels) {
	var workspace = ensureEditorWorkspaceDefaults();
	workspace.stepPlayhead = currentEditorClockStep();
	setEditorShellLevel(levels, workspace.stepPlayhead, EDITOR_PLAYHEAD_ROW, EDITOR_PLAYHEAD_LEVEL);
	var pattern = currentEditorStepPattern();
	if (pattern) {
		for (var step = 0; step < 16; step++) {
			setEditorShellLevel(levels, step, EDITOR_STEP_ROW,
				pattern[step] ? EDITOR_SELECTED_LEVEL : 2);
		}
	}
	setEditorShellLevel(levels, 0, 10,
		currentEditorSequenceEnabled() ? EDITOR_SELECTED_LEVEL : 4);
	setEditorShellLevel(levels, 15, 10, 6);
}

function renderEditorLoopPage(levels) {
	var trackIdx = currentEditorTrackIndex();
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) {
		setEditorShellLevel(levels, 0, 8, 2);
		return;
	}
	var start = clamp(Math.floor(normalizeLoopPoint(trackState.loopStart, 0)), 0, 15);
	var end = clamp(Math.ceil(normalizeLoopPoint(trackState.loopEnd, 16)), 1, 16);
	if (end <= start) end = Math.min(16, start + 1);
	for (var x = 0; x < 16; x++) {
		if (trackState.loopActive && x >= start && x < end) setEditorShellLevel(levels, x, 8, 6);
		setEditorShellLevel(levels, x, 9, x === start ? 15 : 2);
		setEditorShellLevel(levels, x, 10, x === (end - 1) ? 15 : 2);
	}
	setEditorShellLevel(levels, clamp(Math.floor(trackState.playPos), 0, 15), 8, 15);
	setEditorShellLevel(levels, 0, 11, trackState.loopActive ? 15 : 3);
	setEditorShellLevel(levels, 15, 11, 6);
	var division = currentTrackSubLoopDiv(trackIdx);
	for (var div = 0; div < TRACK_SUB_LOOP_OPTIONS.length; div++) {
		setEditorShellLevel(levels, div, 12,
			TRACK_SUB_LOOP_OPTIONS[div] === division ? 15 : 3);
	}
	var channelIdx = trackChannelIndex(trackIdx);
	var channelState = getChannelStateByIndex(channelIdx);
	setEditorShellLevel(levels, channelIdx, 13, channelState.gateLatch ? 15 : 4);
	setEditorShellLevel(levels, trackIdx, 14, 8);
}

function renderEditorParameterPage(levels) {
	var workspace = ensureEditorWorkspaceDefaults();
	var trackIdx = currentEditorTrackIndex();
	var trackState = getTrackStateByIndex(trackIdx);
	var channelIdx = currentEditorChannelIndex();
	var channelState = getChannelStateByIndex(channelIdx);
	if (workspace.targetType === "track" && trackState) {
		for (var group = 0; group < 8; group++) {
			setEditorShellLevel(levels, group, 8,
				group === trackChannelIndex(trackIdx) ? 15 : 3);
		}
	} else if (workspace.targetType === "group" && channelIdx >= 0) {
		setEditorShellLevel(levels, channelIdx, 8, trackState ? 15 : 6);
	}
	if (channelState) {
		var volumeCell = clamp(Math.round(channelState.volume * 15 / 158), 0, 15);
		for (var volume = 0; volume <= volumeCell; volume++) {
			setEditorShellLevel(levels, volume, 9, volume === volumeCell ? 15 : 5);
		}
		setEditorShellLevel(levels, 0, 13, channelState.timestretch ? 15 : 3);
		setEditorShellLevel(levels, 0, 14, channelState.muted ? 15 : 3);
	}
	if (trackState) {
		var octaveCell = clamp(parseInt(trackState.octave, 10) || 0, -3, 3) + 3;
		for (var octave = 0; octave < 7; octave++) {
			setEditorShellLevel(levels, octave, 10, octave === octaveCell ? 15 : 3);
		}
		setEditorShellLevel(levels, 0, 11, trackState.reverse ? 15 : 3);
		setEditorShellLevel(levels, 0, 12, trackState.randomOffset ? 15 : 3);
	}
}

function renderEditorAutomationPage(levels) {
	var automation = currentEditorAutomation();
	var currentStep = currentEditorClockStep();
	for (var step = 0; step < 16; step++) {
		var hasEvents = editorAutomationStepHasEvents(automation, step);
		setEditorShellLevel(levels, step, 8,
			hasEvents ? 15 : (step === currentStep ? 8 : 2));
		for (var category = 0; category < 5; category++) {
			if (editorAutomationStepHasEvents(automation, step, category)) {
				setEditorShellLevel(levels, step, 10 + category, 12);
			}
		}
	}
	setEditorShellLevel(levels, 0, 9, automation && automation.recording ? 15 : 4);
	setEditorShellLevel(levels, 1, 9, automation && automation.playing ? 15 : 4);
	setEditorShellLevel(levels, 15, 9, 6);
}

function renderEditorValuePage(levels, values) {
	if (!values) return;
	for (var step = 0; step < 16; step++) {
		var valueIndex = EDITOR_VALUE_LEVELS.indexOf(values[step]);
		if (valueIndex < 0) valueIndex = 0;
		for (var rowOffset = 0; rowOffset < EDITOR_VALUE_LEVELS.length; rowOffset++) {
			setEditorShellLevel(levels, step, EDITOR_FIRST_ROW + rowOffset,
				rowOffset === valueIndex ? 15 : 1);
		}
	}
}

function renderEditorFxPage(levels) {
	var values = currentEditorGateFxLevels();
	if (!values) return;
	for (var step = 0; step < 16; step++) {
		var valueIndex = EDITOR_FX_LEVELS.indexOf(values[step]);
		if (valueIndex < 0) valueIndex = 0;
		for (var rowOffset = 0; rowOffset < EDITOR_FX_LEVELS.length; rowOffset++) {
			setEditorShellLevel(levels, step, EDITOR_FIRST_ROW + rowOffset,
				rowOffset === valueIndex ? 15 : 1);
		}
	}
	setEditorShellLevel(levels, 0, 14, currentEditorGateFxEnabled() ? 15 : 4);
	setEditorShellLevel(levels, 15, 14, 6);
}

function sequence64LockValueColumn(parameter, step) {
	if (!step) return -1;
	if (instrumentDefinition(parameter)) {
		var instrumentTrack = sequence64TargetTrackIndex(ensureEditorWorkspaceDefaults().targetType,
			ensureEditorWorkspaceDefaults().targetId, step);
		var instrumentLock = step.locks && step.locks[parameter];
		var instrumentValue = sequence64InstrumentBaseEdit ?
			instrumentSanitize(instrumentTrack,getTrackStateByIndex(instrumentTrack).instrumentParameters)[parameter] :
			(instrumentLock ? instrumentLock.value : null);
		return instrumentValue === null ? -1 : Math.round(15 * instrumentToNormalized(parameter, instrumentValue, instrumentParameterRange(parameter)));
	}
	if (parameter === "track") {
		var workspace = ensureEditorWorkspaceDefaults();
		return sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, step);
	}
	if (parameter === "slice") {
		if (step.locks && step.locks.slice) {
			return clamp(parseInt(step.locks.slice.value, 10) || 0, 0, 15);
		}
		return step.cut ? step.cut.slice : -1;
	}
	if (parameter === "probability") return clamp(step.probability, 0, 15);
	if (parameter === "condition") {
		var condition = parseInt(step.condition, 10) || 0;
		if (Math.abs(condition) < 2) return -1;
		return condition > 0 ? clamp(condition - 2, 0, 7) : clamp(Math.abs(condition) + 6, 8, 15);
	}
	if (parameter === "gateLength") return step.cut ? clamp(step.cut.gateLength - 1, 0, 15) : -1;
	var lock = step.locks ? step.locks[parameter] : null;
	if (!lock) return -1;
	if (parameter === "reverse") return lock.value ? 15 : 0;
	if (parameter === "transpose") {
		lock = normalizeSequence64TransposeLock(lock);
		return lock.pitchSemitone + 8;
	}
	if (parameter === "loopDivision") return TRACK_SUB_LOOP_OPTIONS.indexOf(lock.value);
	return clamp(parseInt(lock.value, 10) || 0, 0, 15);
}

function renderSequence64StepEditor(levels, step) {
	if (sequence64InstrumentPage && sequence64InstrumentTarget()) {
		setEditorShellLevel(levels, 2, SEQUENCE64_TOOLS_ROW, sequence64InstrumentBaseEdit ? 15 : 4);
		setEditorShellLevel(levels, 3, SEQUENCE64_TOOLS_ROW, 5);
		setEditorShellLevel(levels, 4, SEQUENCE64_TOOLS_ROW, 5);
	}
	var parameters = sequence64VisibleParameters();
	var parameterIndex = parameters.indexOf(sequence64EditParameter);
	if (parameterIndex < 0) parameterIndex = 0;
	for (var parameter = 0; parameter < parameters.length; parameter++) {
		setEditorShellLevel(levels, SEQUENCE64_PARAMETER_FIRST_COL + parameter, SEQUENCE64_LENGTH_ROW,
			parameter === parameterIndex ? 15 : 3);
	}
	setEditorShellLevel(levels, SEQUENCE64_PATTERN_CONTEXT_COL, SEQUENCE64_LENGTH_ROW, 3);

	var valueColumn = sequence64ModEditActive ?
		modulationAmountColumn((currentSequence64ModulationRoute() || {}).amount) :
		sequence64LockValueColumn(parameters[parameterIndex], step);
	var lock = step && step.locks ? step.locks[sequence64EditParameter] : null;
	var pitchOctave = 0;
	if (sequence64EditParameter === "transpose" && lock) {
		lock = normalizeSequence64TransposeLock(lock);
		pitchOctave = lock.pitchOctave;
	}
	var maxValueColumn = !sequence64ModEditActive &&
		sequence64EditParameter === "loopDivision" ? 7 : 15;
	for (var value = 0; value <= maxValueColumn; value++) {
		if (!sequence64ModEditActive && sequence64EditParameter === "track" &&
			!sequence64TrackBelongsToGroup(value, ensureEditorWorkspaceDefaults().targetId)) continue;
		var availableLevel = SEQUENCE64_MIN_VISIBLE_LEVEL;
		if (!sequence64ModEditActive && sequence64EditParameter === "transpose" &&
			value < SEQUENCE64_TRANSPOSE_FIRST_COL) {
			var octaveDirectionActive = (value === 0 && pitchOctave < 0) ||
				(value === 1 && pitchOctave > 0);
			availableLevel = octaveDirectionActive ?
				clamp(7 + Math.abs(pitchOctave), 8, 15) : 5;
		}
		setEditorShellLevel(levels, value, SEQUENCE64_TRANSPORT_ROW,
			value === valueColumn ? 15 : availableLevel);
	}
	if (!sequence64ModEditActive && sequence64EditParameter === "slice") {
		var slicePosition = sequence64TrackPositionColumn();
		if (slicePosition >= 0 && slicePosition !== valueColumn) {
			setEditorShellLevel(levels, slicePosition, SEQUENCE64_TRANSPORT_ROW,
				SEQUENCE64_TRACK_POSITION_LEVEL);
		}
	}

	setEditorShellLevel(levels, 0, SEQUENCE64_TOOLS_ROW, step && step.cut ? 15 : 4);
	setEditorShellLevel(levels, 1, SEQUENCE64_TOOLS_ROW,
		sequence64InspectorLiveWrite ? 15 : 4);
	if (sequence64EditParameter === "volume" || sequence64EditParameter === "filter") {
		for (var behavior = 0; behavior < SEQUENCE64_BEHAVIORS.length; behavior++) {
			setEditorShellLevel(levels, SEQUENCE64_BEHAVIOR_FIRST_COL + behavior, SEQUENCE64_TOOLS_ROW,
				lock && lock.behavior === SEQUENCE64_BEHAVIORS[behavior] ? 15 : 3);
		}
	}
	if (sequence64EditParameter === "filter") {
		for (var source = 0; source < Modulation.SOURCE_IDS.length; source++) {
			var sourceId = Modulation.SOURCE_IDS[source];
			var sourceRoute = sequence64ModulationRouteForSource(sourceId);
			var sourceLevel = sourceRoute && sourceRoute.enabled ? 8 : 3;
			if (sequence64ModEditActive && sourceId === sequence64ModSource) sourceLevel = 15;
			setEditorShellLevel(levels, 11 + source, SEQUENCE64_TOOLS_ROW, sourceLevel);
		}
	}
	setEditorShellLevel(levels, 15, SEQUENCE64_TOOLS_ROW, 6);
}

function renderSequence64PatternContext(levels, pattern, bar, playback, targetPlaying) {
	var parameters = sequence64VisibleParameters();
	for (var parameter = 0; parameter < parameters.length; parameter++) {
		setEditorShellLevel(levels, SEQUENCE64_PARAMETER_FIRST_COL + parameter,
			SEQUENCE64_LENGTH_ROW, 3);
	}
	setEditorShellLevel(levels, SEQUENCE64_PATTERN_CONTEXT_COL, SEQUENCE64_LENGTH_ROW, 15);
	setEditorShellLevel(levels, 12, SEQUENCE64_TRANSPORT_ROW, pattern.bars.length > 1 ? 6 : 2);
	setEditorShellLevel(levels, 13, SEQUENCE64_TRANSPORT_ROW, pattern.bars.length > 1 ? 6 : 2);
	setEditorShellLevel(levels, 14, SEQUENCE64_TRANSPORT_ROW,
		pattern.bars.length < SEQUENCE64_MAX_BARS ? 6 : 2);
	setEditorShellLevel(levels, 15, SEQUENCE64_TRANSPORT_ROW,
		sequence64RemoveBarArmedUntil > Date.now() ? 12 : (pattern.bars.length > 1 ? 5 : 2));
	setEditorShellLevel(levels, 0, SEQUENCE64_TOOLS_ROW, targetPlaying ? 15 : 4);
	setEditorShellLevel(levels, 1, SEQUENCE64_TOOLS_ROW, sequence64InspectorLiveWrite ? 15 : 4);
	setEditorShellLevel(levels, 2, SEQUENCE64_TOOLS_ROW, 5);
	setEditorShellLevel(levels, 3, SEQUENCE64_TOOLS_ROW, 5);
	setEditorShellLevel(levels, 15, SEQUENCE64_TOOLS_ROW,
		sequence64ClearArmedUntil > Date.now() ? 12 : 5);
}

function renderSequence64PersistentStructure(levels, pattern, bar, playback, targetPlaying) {
	var instrument = sequence64InstrumentTarget();
	if (instrument) setEditorShellLevel(levels, 15, SEQUENCE64_LENGTH_ROW, sequence64InstrumentPage ? 15 : 4);
	if (sequence64InstrumentPage && instrument) {
		for (var bank = 0; bank < instrument.pages.length; bank++)
			setEditorShellLevel(levels, 9 + bank, SEQUENCE64_LENGTH_ROW, bank === sequence64InstrumentBank ? 15 : 4);
	}
	for (var lengthIndex = 0; lengthIndex < SEQUENCE64_LENGTHS.length; lengthIndex++) {
		setEditorShellLevel(levels, lengthIndex, SEQUENCE64_LENGTH_ROW,
			bar.length === SEQUENCE64_LENGTHS[lengthIndex] ? 15 :
				(sequence64PendingLengthIndex === lengthIndex ? 10 : 3));
	}
	for (var barButton = 0; barButton < SEQUENCE64_MAX_BARS; barButton++) {
		var barLevel = SEQUENCE64_MIN_VISIBLE_LEVEL;
		if (barButton < pattern.bars.length) {
			barLevel = barButton === pattern.currentBar ? 15 :
				(barButton === playback.bar && targetPlaying ? 10 : 4);
		}
		if (sequence64PendingBarIndex === barButton) {
			barLevel = sequence64BarHoldCommitted ? 15 : 10;
		}
		setEditorShellLevel(levels, SEQUENCE64_BAR_FIRST_COL + barButton,
			SEQUENCE64_NAV_ROW, barLevel);
	}
}

function renderSequence64View(levels) {
	scheduleSequence64SelectionPulse();
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern) return;
	var bar = currentSequence64EditBar(pattern);
	if (!bar) return;
	var playback = currentSequence64PlaybackLocation(pattern);
	var targetPlaying = sequence64TargetIsPlaying(workspace.targetType,
		workspace.targetId, pattern);
	workspace.stepPlayhead = playback.step;
	if (sequence64ModMatrixActive) {
		renderSequence64ModMatrix(levels);
		return;
	}

	if (sequence64ShiftHeld) {
		for (var lengthStep = 0; lengthStep < 64; lengthStep++) {
			var lengthCoords = sequence64StepCoords(lengthStep);
			var lengthLevel = lengthStep < bar.length ? 5 : SEQUENCE64_MIN_VISIBLE_LEVEL;
			if (lengthStep === bar.length - 1) lengthLevel = 15;
			setEditorShellLevel(levels, lengthCoords[0], lengthCoords[1], lengthLevel);
		}
		var selectedRate = sequence64RateChoiceIndex(pattern);
		for (var rateIndex = 0; rateIndex < SEQUENCE64_RATE_CHOICES.length; rateIndex++) {
			setEditorShellLevel(levels, rateIndex, SEQUENCE64_TRANSPORT_ROW,
				rateIndex === selectedRate ? 15 : SEQUENCE64_MIN_VISIBLE_LEVEL);
		}
		setEditorShellLevel(levels, 0, SEQUENCE64_NAV_ROW, 3);
		setEditorShellLevel(levels, 1, SEQUENCE64_NAV_ROW, 3);
		setEditorShellLevel(levels, 2, SEQUENCE64_NAV_ROW, 3);
		setEditorShellLevel(levels, 11, SEQUENCE64_NAV_ROW, 15);
		setEditorShellLevel(levels, 12, SEQUENCE64_NAV_ROW, sampleBrowserState.active ? 15 : 5);
		setEditorShellLevel(levels, 13, SEQUENCE64_NAV_ROW, sequence64CopyGesture ? 15 : 5);
		setEditorShellLevel(levels, SEQUENCE64_DELETE_COL, SEQUENCE64_NAV_ROW,
			sequence64DeleteHeld ? 15 : 5);
		setEditorShellLevel(levels, 15, SEQUENCE64_NAV_ROW, 6);
		return;
	}

	for (var source = 0; source < bar.length; source++) {
		var sourceStep = bar.steps[source];
		if (!sourceStep.cut || sourceStep.cut.gateLength <= 1) continue;
		for (var tail = 1; tail < sourceStep.cut.gateLength && tail < bar.length; tail++) {
			var tailIndex = (source + tail) % bar.length;
			var tailCoords = sequence64StepCoords(tailIndex);
			setEditorShellLevel(levels, tailCoords[0], tailCoords[1], sequence64EmptyStepLevel());
		}
	}

	var selectedStepIndex = clamp(parseInt(sequence64SelectedStep, 10) || 0, 0, Math.max(0, bar.length - 1));
	for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
		var coords = sequence64StepCoords(stepIndex);
		var step = bar.steps[stepIndex];
		var level = stepIndex < bar.length ? sequence64EmptyStepLevel() : 0;
		if (sequence64StepHasLocks(step)) level = 5;
		if (step.cut) level = step.cut.gateLength > 1 ? 10 : 7;
		if (step.cut && sequence64StepHasLocks(step)) level = 12;
		if (stepIndex === selectedStepIndex && stepIndex < bar.length && sequence64StepHasContent(step))
			level = Math.round(11 + 4 * sequence64SelectionPulse);
		if (targetPlaying && playback.bar === pattern.currentBar &&
			stepIndex === workspace.stepPlayhead) level = 15;
		if (sequence64PressedStep === stepIndex) level = 15;
		setEditorShellLevel(levels, coords[0], coords[1], level);
	}

	if (sequence64InspectorContext === "parameter") {
		renderSequence64StepEditor(levels, bar.steps[currentSequence64EditStepIndex()]);
	} else {
		renderSequence64PatternContext(levels, pattern, bar, playback, targetPlaying);
	}
	renderSequence64PersistentStructure(levels, pattern, bar, playback, targetPlaying);

	setEditorShellLevel(levels, 0, SEQUENCE64_NAV_ROW, 15);
	setEditorShellLevel(levels, 1, SEQUENCE64_NAV_ROW, 3);
	setEditorShellLevel(levels, 2, SEQUENCE64_NAV_ROW, 3);
	setEditorShellLevel(levels, 11, SEQUENCE64_NAV_ROW, 5);
	setEditorShellLevel(levels, 12, SEQUENCE64_NAV_ROW, sampleBrowserState.active ? 15 : 5);
	setEditorShellLevel(levels, 13, SEQUENCE64_NAV_ROW, sequence64CopyGesture ? 15 : 5);
	setEditorShellLevel(levels, SEQUENCE64_DELETE_COL, SEQUENCE64_NAV_ROW,
		sequence64DeleteHeld ? 15 : 5);
	setEditorShellLevel(levels, 15, SEQUENCE64_NAV_ROW, 6);
}

function renderSequence64SetupView(levels) {
	var workspace = ensureEditorWorkspaceDefaults();
	var trackIdx = currentEditorTrackIndex();
	var trackState = getTrackStateByIndex(trackIdx);
	var channelIdx = currentEditorChannelIndex();
	var channelState = getChannelStateByIndex(channelIdx);

	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var selectedGroup = workspace.targetType === "track" && trackState ? trackChannelIndex(trackIdx) : channelIdx;
		setEditorShellLevel(levels, group, 8, group === selectedGroup ? 15 : 3);
	}
	if (channelState) {
		var volumeCell = clamp(Math.round(channelState.volume * 15 / 158), 0, 15);
		for (var volume = 0; volume < 16; volume++) {
			setEditorShellLevel(levels, volume, 9,
				volume <= volumeCell ? (volume === volumeCell ? 15 : 5) : SEQUENCE64_MIN_VISIBLE_LEVEL);
		}
	}
	if (trackState) {
		var octave = clamp(parseInt(trackState.octave, 10) || 0, -8, 8);
		setEditorShellLevel(levels, 0, 10, octave < 0 ? clamp(4 - octave, 4, 15) : 4);
		setEditorShellLevel(levels, 1, 10, octave > 0 ? clamp(4 + octave, 4, 15) : 4);
		var transposeCell = clamp(parseInt(trackState.transpose, 10) || 0,
			SEQUENCE64_TRANSPOSE_MIN, SEQUENCE64_TRANSPOSE_MAX) + 8;
		for (var pitchCell = SEQUENCE64_TRANSPOSE_FIRST_COL; pitchCell < 16; pitchCell++) {
			setEditorShellLevel(levels, pitchCell, 10,
				pitchCell === transposeCell ? 15 : SEQUENCE64_MIN_VISIBLE_LEVEL);
		}
		setEditorShellLevel(levels, 0, 11, trackState.reverse ? 15 : 3);
		setEditorShellLevel(levels, 1, 11, trackState.randomOffset ? 15 : 3);
		var division = currentTrackSubLoopDiv(trackIdx);
		for (var div = 0; div < TRACK_SUB_LOOP_OPTIONS.length; div++) {
			setEditorShellLevel(levels, div + 2, 11,
				TRACK_SUB_LOOP_OPTIONS[div] === division ? 15 : 3);
		}
		var loopStart = clamp(Math.floor(trackState.loopStart), 0, 15);
		var loopEnd = clamp(Math.ceil(trackState.loopEnd) - 1, 0, 15);
		for (var loopCell = 0; loopCell < 16; loopCell++) {
			setEditorShellLevel(levels, loopCell, 12,
				loopCell === loopStart ? 15 : SEQUENCE64_MIN_VISIBLE_LEVEL);
			setEditorShellLevel(levels, loopCell, 13,
				loopCell === loopEnd ? 15 : SEQUENCE64_MIN_VISIBLE_LEVEL);
		}
		setEditorShellLevel(levels, 0, 14, trackState.loopActive ? 15 : 3);
	}
	if (channelState) {
		setEditorShellLevel(levels, 1, 14, channelState.gateLatch ? 15 : 3);
		setEditorShellLevel(levels, 2, 14, channelState.timestretch ? 15 : 3);
		setEditorShellLevel(levels, 3, 14, channelState.muted ? 15 : 3);
	}
	setEditorShellLevel(levels, 4, 14, sequence64ActiveShapes.length ? 12 : 4);
	setEditorShellLevel(levels, 5, 14,
		workspace.startSnapshots64[currentEditorTargetKey()] ? 8 : 3);
	if (trackState) setEditorShellLevel(levels, 6, 14, trackState.playbackLoop ? 15 : 3);
	var engine = instrumentDescriptorForTrack(trackIdx);
	if (engine) {
		var slots = instrumentPresetSlots(engine);
		for (var slot = 0; slot < 8; slot++) {
			var selected = instrumentPresetSelection[engine.id] === slot &&
				instrumentPresetMatches(engine, slots[slot]);
			setEditorShellLevel(levels, 7 + slot, 14, selected ? 15 : slots[slot] ? 5 : 2);
		}
	}
	setEditorShellLevel(levels, 0, SEQUENCE64_NAV_ROW, 3);
	setEditorShellLevel(levels, 1, SEQUENCE64_NAV_ROW, 15);
	setEditorShellLevel(levels, 2, SEQUENCE64_NAV_ROW, 3);
	setEditorShellLevel(levels, 11, SEQUENCE64_NAV_ROW, sequence64ShiftHeld ? 15 : 5);
	setEditorShellLevel(levels, 12, SEQUENCE64_NAV_ROW, sampleBrowserState.active ? 15 : 5);
	setEditorShellLevel(levels, 13, SEQUENCE64_NAV_ROW, sequence64CopyGesture ? 15 : 5);
	setEditorShellLevel(levels, 15, SEQUENCE64_NAV_ROW, 6);
}

function buildEditorShellLevels() {
	var workspace = ensureEditorWorkspaceDefaults();
	var levels = createEditorShellLevels();
	if (sequence64LayoutEnabled()) {
		if (workspace.view64 === "setup") renderSequence64SetupView(levels);
		else renderSequence64View(levels);
		return levels;
	}
	workspace.stepPlayhead = workspace.editorId === "step" ? currentEditorClockStep() : -1;
	if (workspace.editorId === "step") renderEditorStepPage(levels);
	else if (workspace.editorId === "loop") renderEditorLoopPage(levels);
	else if (workspace.editorId === "parameter") renderEditorParameterPage(levels);
	else if (workspace.editorId === "automation") renderEditorAutomationPage(levels);
	else if (workspace.editorId === "probability") renderEditorValuePage(levels, currentEditorProbabilities());
	else if (workspace.editorId === "fx") renderEditorFxPage(levels);

	var automation = currentEditorAutomation();
	for (var nav = 0; nav < EDITOR_IDS.length; nav++) {
		var level = EDITOR_IDS[nav] === workspace.editorId ? EDITOR_SELECTED_LEVEL : EDITOR_AVAILABLE_LEVEL;
		if (nav === 3 && automation && automation.recording && workspace.editorId !== "automation") level = 12;
		setEditorShellLevel(levels, nav, EDITOR_NAV_ROW, level);
	}
	setEditorShellLevel(levels, EDITOR_TRACK_COL, EDITOR_NAV_ROW, 6);
	return levels;
}

function scenePatternSlot(reference, groupIndex) {
	var match = /^group-pattern:(\d+):(\d+)$/.exec(String(reference || ""));
	if (!match || parseInt(match[1], 10) !== groupIndex) return -1;
	return clamp(parseInt(match[2], 10) || 0, 0, Scenes.PATTERN_SLOTS - 1);
}

function scenePlayingPulseDipped() {
	if (!s.globalTransportRunning) return false;
	var phase = ((sequence64ClockPosition % SCENE_PLAYING_PULSE_STEPS) +
		SCENE_PLAYING_PULSE_STEPS) % SCENE_PLAYING_PULSE_STEPS;
	return phase < SCENE_PLAYING_PULSE_DIP_STEPS;
}

function scenePlayingLevel() {
	return scenePlayingPulseDipped() ? SCENE_PLAYING_PULSE_LEVEL : 15;
}

function scenePlayingMotion() {
	return scenePlayingPulseDipped() ?
		sceneColorModifier("mul", [128, 128, 128], 160) : null;
}

function sequence64HasRuntimeOwnership() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (sequence64ActiveShapes.length) return true;
	for (var phraseKey in workspace.phraseInstances64) {
		if (workspace.phraseInstances64[phraseKey]) return true;
	}
	for (var propertyKey in workspace.propertyStacks64) {
		if (workspace.propertyStacks64[propertyKey]) return true;
	}
	for (var channelIdx = 0; channelIdx < s.NUM_CHANNELS; channelIdx++) {
		var channel = getChannelStateByIndex(channelIdx);
		if (channel && channel.sequence64Owner) return true;
	}
	return false;
}

function pauseSequence64Transport(reason) {
	releaseNativeSequence64(reason || "transport_stop", false);
	if (sequence64TransportPausing) return false;
	sequence64TransportPausing = true;
	var workspace = ensureEditorWorkspaceDefaults();
	var phrases = [];
	var stoppedChannels = [];
	try {
		for (var phraseKey in workspace.phraseInstances64) {
			if (workspace.phraseInstances64[phraseKey]) {
				phrases.push(workspace.phraseInstances64[phraseKey]);
			}
		}
		for (var phrase = 0; phrase < phrases.length; phrase++) {
			finishSequence64Phrase(phrases[phrase], reason || "transport_stop", true);
		}
		for (var channelIdx = 0; channelIdx < s.NUM_CHANNELS; channelIdx++) {
			var channel = getChannelStateByIndex(channelIdx);
			if (!channel || !channel.sequence64Owner) continue;
			cancelSequence64AudioForChannel(channelIdx);
			sendNamedInt((channelIdx + 1) + "[pl]stop", 1);
			channel.sequence64Owner = null;
			if (channel.activeTrack >= 0) channel.lastActiveTrack = channel.activeTrack;
			channel.activeTrack = -1;
			stoppedChannels.push(channelIdx + 1);
		}
		restoreAllSequence64OwnedProperties();
		sequence64ActiveShapes = [];
	} finally {
		sequence64TransportPausing = false;
	}
	diagnosticEvent("sequence64_transport_pause", {
		reason: reason || "transport_stop",
		phrases: phrases.length,
		stoppedChannels: stoppedChannels,
		runningGroups: sceneRunningGroups()
	});
	return phrases.length > 0 || stoppedChannels.length > 0;
}

function setGlobalTransportRunning(running, reason) {
	var next = running ? 1 : 0;
	if (sequence64NativePending) releaseNativeSequence64("transport_change", false);
	if (!next && (s.globalTransportRunning || sequence64HasRuntimeOwnership())) {
		pauseSequence64Transport(reason || "transport_stop");
	}
	s.globalTransportRunning = next;
	if (s.kmod === 2 && ensureEditorWorkspaceDefaults().view64 === "scene") {
		redrawEditorShellDiff();
	}
	return s.globalTransportRunning;
}

function globalTransport(running) {
	return setGlobalTransportRunning(parseInt(running, 10) ? 1 : 0,
		"external_transport");
}

function startSequence64Transport(reason) {
	if (!rtaEnabled()) return false;
	if (s.globalTransportRunning) return false;
	messnamed("[mlr]start", "bang");
	setGlobalTransportRunning(1, reason || "sequence64_start");
	diagnosticEvent("sequence64_transport_start", {
		reason: reason || "sequence64_start"
	});
	return true;
}

function stopSequence64Transport(reason) {
	if (!rtaEnabled()) return false;
	if (!s.globalTransportRunning) return false;
	messnamed("[mlr]stop", "bang");
	setGlobalTransportRunning(0, reason || "sequence64_stop");
	diagnosticEvent("sequence64_transport_stop", {
		reason: reason || "sequence64_stop"
	});
	return true;
}

function reconcileSequence64Transport(reason) {
	if (sequence64HasPlaybackActivity()) {
		return startSequence64Transport(reason || "sequence64_activity");
	}
	return stopSequence64Transport(reason || "sequence64_idle");
}

function sceneGlobalTransport(command) {
	var action = String(command || "").toLowerCase();
	if (action === "start") {
		messnamed("[mlr]start", "bang");
		setGlobalTransportRunning(1, "scene_transport_start");
	} else if (action === "stop") {
		messnamed("[mlr]stop", "bang");
		setGlobalTransportRunning(0, "scene_transport_stop");
	} else if (action === "reset") {
		messnamed("[mlr]reset", "bang");
	} else return false;
	outlet(2, "global_transport", action);
	publishHud("notice", "info", "Global transport " + action);
	diagnosticEvent("global_transport", { action: action });
	return true;
}

function sceneSequence64GridStep(col, row) {
	if (col < 0 || col >= 16 || row < SCENE_STEP_FIRST_ROW ||
		row > SCENE_STEP_LAST_ROW) return -1;
	return (row - SCENE_STEP_FIRST_ROW) * 16 + col;
}

function renderSceneSequence64Steps(levels) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern) return;
	var bar = currentSequence64EditBar(pattern);
	if (!bar) return;
	var playback = currentSequence64PlaybackLocation(pattern);
	var targetPlaying = sequence64TargetIsPlaying(workspace.targetType,
		workspace.targetId, pattern);
	workspace.stepPlayhead = playback.step;
	var selectedStepIndex = clamp(parseInt(sequence64SelectedStep, 10) || 0, 0, Math.max(0, bar.length - 1));
	for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
		var step = bar.steps[stepIndex];
		var level = stepIndex < bar.length ? sequence64EmptyStepLevel() : 0;
		if (sequence64StepHasLocks(step)) level = 5;
		if (step.cut) level = step.cut.gateLength > 1 ? 10 : 7;
		if (step.cut && sequence64StepHasLocks(step)) level = 12;
		if (stepIndex === selectedStepIndex && stepIndex < bar.length && sequence64StepHasContent(step))
			level = Math.round(11 + 4 * sequence64SelectionPulse);
		if (targetPlaying && playback.bar === pattern.currentBar &&
			stepIndex === workspace.stepPlayhead) level = 15;
		if (sequence64PressedStep === stepIndex) level = 15;
		var row = SCENE_STEP_FIRST_ROW + Math.floor(stepIndex / 16);
		levels[row * 16 + (stepIndex % 16)] = level;
	}
}

function buildSceneLevels() {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var levels = new Array(16 * 16).fill(0);
	var activeIndex = sceneIndexFromId(state.activeSceneId);
	var selectedIndex = sceneIndexFromId(state.selectedSceneId);
	var pending = workspace.pendingSceneLaunch;
	var queuedLevel = Math.floor(sequence64ClockPosition / 4) % 2 ? 15 : 3;
	for (var sceneIndex = 0; sceneIndex < Scenes.MAX_SCENES; sceneIndex++) {
		var sceneLevel = state.scenes[sceneIndex] ? 4 : 2;
		if (sceneIndex === selectedIndex) sceneLevel = 10;
		if (sceneIndex === activeIndex) {
			var activeMatches = scenePerformanceMatches(state.scenes[sceneIndex]);
			sceneLevel = activeMatches && sceneAnyGroupRunning() ?
				scenePlayingLevel() : (activeMatches ? 15 : 12);
		}
		if (pending && pending.type === "scene" && pending.sceneIndex === sceneIndex) sceneLevel = queuedLevel;
		levels[sceneIndex] = sceneLevel;
	}
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var selectedRef = workspace.performanceGroupPatternRefs[group];
		var selectedSlot = scenePatternSlot(selectedRef, group);
		var running = workspace.patterns64[editorTargetKey("group", group)];
		var groupRow = SCENE_GROUP_FIRST_ROW + group;
		for (var slot = 0; slot < Scenes.PATTERN_SLOTS; slot++) {
			var reference = Scenes.groupPatternId(group, slot);
			var pattern = state.patternLibrary[reference];
			var level = pattern && sequence64PatternHasContent(pattern) ? 6 : 2;
			if (slot === selectedSlot) level = running && running.running ?
				scenePlayingLevel() : 10;
			if (pending && pending.type === "patterns" && pending.patternRefs &&
				pending.patternRefs[group] === reference) level = queuedLevel;
			levels[groupRow * 16 + slot] = level;
		}
		levels[groupRow * 16 + SCENE_GROUP_RUN_COL] =
			running && running.running ? 15 : 4;
	}
	levels[SCENE_TRANSPORT_ROW * 16 + SCENE_GLOBAL_START_COL] =
		s.globalTransportRunning ? 15 : 5;
	levels[SCENE_TRANSPORT_ROW * 16 + SCENE_GLOBAL_STOP_COL] =
		s.globalTransportRunning ? 5 : 15;
	levels[SCENE_TRANSPORT_ROW * 16 + SCENE_GLOBAL_RESET_COL] = 6;
	for (var trackSlotIndex = 0; trackSlotIndex < Scenes.MAX_TRACK_SLOTS; trackSlotIndex++) {
		var trackSlotRef = Scenes.trackSlotId(trackSlotIndex);
		var trackSlot = state.trackSlots[trackSlotRef];
		var trackSlotLevel = trackSlot ?
			(Scenes.trackSlotSceneCount(state, trackSlotRef) > 1 ? 8 : 4) : 2;
		if (workspace.performanceTrackSlotRef === trackSlotRef) trackSlotLevel = 15;
		if (pending && pending.type === "track_slot" &&
			pending.trackSlotIndex === trackSlotIndex) trackSlotLevel = queuedLevel;
		levels[SCENE_TRACK_SLOT_ROW * 16 + trackSlotIndex] = trackSlotLevel;
	}
	renderSceneSequence64Steps(levels);
	levels[SCENE_NAV_ROW * 16] = 3;
	levels[SCENE_NAV_ROW * 16 + 1] = 3;
	levels[SCENE_NAV_ROW * 16 + 2] = 15;
	levels[SCENE_NAV_ROW * 16 + SCENE_SHIFT_COL] = sceneShiftHeld ? 15 : 5;
	levels[SCENE_NAV_ROW * 16 + SCENE_EXIT_COL] = 6;
	return levels;
}

// Scene owns the whole surface. This palette supplies stable Role colors; the
// separate layer builder below adds durable State and transient Motion without
// changing the canonical 0-15 level representation.
function buildSceneColorPalette() {
	var palette = createColorPalette(SEQUENCE64_COLORS.unavailable);
	paintColorPaletteRect(palette, 0, 0, 15, 0, SEQUENCE64_COLORS.sequence);
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var groupRow = SCENE_GROUP_FIRST_ROW + group;
		paintColorPaletteRect(palette, SCENE_PATTERN_FIRST_COL, groupRow,
			SCENE_GROUP_RUN_COL, groupRow, GROUP_COLORS[group]);
	}
	paintColorPaletteRect(palette, 0, SCENE_TRACK_SLOT_ROW, 15, SCENE_TRACK_SLOT_ROW,
		SEQUENCE64_COLORS.restore);
	palette[SCENE_TRANSPORT_ROW * 16 + SCENE_GLOBAL_START_COL] = SEQUENCE64_COLORS.run;
	palette[SCENE_TRANSPORT_ROW * 16 + SCENE_GLOBAL_STOP_COL] = SEQUENCE64_COLORS.stop;
	palette[SCENE_TRANSPORT_ROW * 16 + SCENE_GLOBAL_RESET_COL] = SEQUENCE64_COLORS.restart;
	paintColorPaletteRect(palette, 0, SCENE_STEP_FIRST_ROW, 15, SCENE_STEP_LAST_ROW,
		SEQUENCE64_OFF_COLOR);
	var pattern = currentSequence64Pattern();
	var bar = pattern ? currentSequence64EditBar(pattern) : null;
	var tails = sequence64GateTailMap(bar);
	if (bar) {
		for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
			var step = bar.steps[stepIndex];
			var stepRole = stepIndex < bar.length ?
				SEQUENCE64_OFF_COLOR : SEQUENCE64_COLORS.unavailable;
			if (tails[stepIndex]) stepRole = SEQUENCE64_COLORS.gateTail;
			if (step.cut) stepRole = step.cut.gateLength > 1 ?
				SEQUENCE64_COLORS.triggerGate : SEQUENCE64_COLORS.trigger;
			var stepRow = SCENE_STEP_FIRST_ROW + Math.floor(stepIndex / 16);
			palette[stepRow * 16 + (stepIndex % 16)] = stepRole;
		}
	}
	palette[SCENE_NAV_ROW * 16] = SEQUENCE64_COLORS.sequence;
	palette[SCENE_NAV_ROW * 16 + 1] = SEQUENCE64_COLORS.setup;
	palette[SCENE_NAV_ROW * 16 + 2] = SEQUENCE64_COLORS.sequence;
	palette[SCENE_NAV_ROW * 16 + SCENE_SHIFT_COL] = SEQUENCE64_COLORS.shift;
	palette[SCENE_NAV_ROW * 16 + SCENE_EXIT_COL] = SEQUENCE64_COLORS.exit;
	return palette;
}

function sceneColorModifier(op, rgb, amount) {
	return { op: op, rgb: rgb, amount: clamp8(amount) };
}

function colorModifierSignature(modifier) {
	if (!modifier) return "none";
	return [modifier.op, modifier.rgb[0], modifier.rgb[1], modifier.rgb[2],
		modifier.amount].join(",");
}

function buildSceneColorLayers() {
	var workspace = ensureEditorWorkspaceDefaults();
	var state = ensureSceneRuntime();
	var roles = buildSceneColorPalette();
	var states = new Array(16 * 16).fill(null);
	var motions = new Array(16 * 16).fill(null);
	var selected = sceneIndexFromId(state.selectedSceneId);
	var active = sceneIndexFromId(state.activeSceneId);
	states[selected] = sceneColorModifier("half_add", [255, 255, 255], 96);
	states[active] = sceneColorModifier("half_add", [255, 255, 255], 160);
	var playbackPulse = scenePlayingMotion();
	if (playbackPulse && sceneAnyGroupRunning() &&
		scenePerformanceMatches(state.scenes[active])) motions[active] = playbackPulse;
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		var groupRow = SCENE_GROUP_FIRST_ROW + group;
		var selectedSlot = scenePatternSlot(workspace.performanceGroupPatternRefs[group], group);
		if (selectedSlot >= 0) {
			states[groupRow * 16 + selectedSlot] =
				sceneColorModifier("half_add", [255, 255, 255], 112);
		}
		var runningPattern = workspace.patterns64[editorTargetKey("group", group)];
		if (runningPattern && runningPattern.running) {
			states[groupRow * 16 + SCENE_GROUP_RUN_COL] =
				sceneColorModifier("half_add", [255, 255, 255], 120);
			if (selectedSlot >= 0 && playbackPulse) {
				motions[groupRow * 16 + selectedSlot] = playbackPulse;
			}
		}
	}
	for (var trackSlotIndex = 0; trackSlotIndex < Scenes.MAX_TRACK_SLOTS; trackSlotIndex++) {
		var trackSlotRef = Scenes.trackSlotId(trackSlotIndex);
		if (Scenes.trackSlotSceneCount(state, trackSlotRef) > 1) {
			states[SCENE_TRACK_SLOT_ROW * 16 + trackSlotIndex] =
				sceneColorModifier("add", [90, 45, 130], 112);
		}
		if (workspace.performanceTrackSlotRef === trackSlotRef) {
			states[SCENE_TRACK_SLOT_ROW * 16 + trackSlotIndex] =
				sceneColorModifier("half_add", [255, 255, 255], 144);
		}
	}
	states[SCENE_TRANSPORT_ROW * 16 + (s.globalTransportRunning ?
		SCENE_GLOBAL_START_COL : SCENE_GLOBAL_STOP_COL)] =
		sceneColorModifier("half_add", [255, 255, 255], 120);

	var pattern = currentSequence64Pattern();
	var bar = pattern ? currentSequence64EditBar(pattern) : null;
	var playback = pattern ? currentSequence64PlaybackLocation(pattern) : null;
	if (bar) {
		for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
			var step = bar.steps[stepIndex];
			var index = (SCENE_STEP_FIRST_ROW + Math.floor(stepIndex / 16)) * 16 +
				(stepIndex % 16);
			if (sequence64StepHasLocks(step)) {
				states[index] = sceneColorModifier("add",
					step.cut ? [105, 20, 145] : [155, 105, 10], step.cut ? 160 : 176);
			}
			if (sequence64SelectedStep === stepIndex && sequence64StepHasContent(step)) {
				states[index] = sceneColorModifier("half_add", [255, 255, 255], 112);
			}
		}
		if (sequence64TargetIsPlaying(workspace.targetType, workspace.targetId, pattern) &&
			playback.bar === pattern.currentBar) {
			var playheadIndex = (SCENE_STEP_FIRST_ROW + Math.floor(playback.step / 16)) * 16 +
				(playback.step % 16);
			var decisionColor = sequence64DecisionColorAt(workspace.targetType,
				workspace.targetId, playback.bar, playback.step);
			motions[playheadIndex] = decisionColor ?
				sceneColorModifier("replace", decisionColor, 255) :
				sceneColorModifier("half_add", [255, 255, 255], 224);
		}
		if (sequence64PressedStep >= 0) {
			var pressedIndex = (SCENE_STEP_FIRST_ROW +
				Math.floor(sequence64PressedStep / 16)) * 16 + (sequence64PressedStep % 16);
			motions[pressedIndex] = sceneColorModifier("replace", SEQUENCE64_COLORS.held, 224);
		}
	}

	var pending = workspace.pendingSceneLaunch;
	if (pending) {
		var pendingAmount = Math.floor(sequence64ClockPosition / 4) % 2 ? 208 : 72;
		var queued = sceneColorModifier("add", [255, 145, 20], pendingAmount);
		if (pending.type === "scene") motions[pending.sceneIndex] = queued;
		else if (pending.type === "track_slot") {
			motions[SCENE_TRACK_SLOT_ROW * 16 + pending.trackSlotIndex] = queued;
		} else if (pending.type === "patterns" && pending.patternRefs) {
			for (var pendingGroup in pending.patternRefs) {
				var pendingGroupIndex = parseInt(pendingGroup, 10);
				var pendingSlot = scenePatternSlot(pending.patternRefs[pendingGroup], pendingGroupIndex);
				if (pendingSlot >= 0) {
					motions[(SCENE_GROUP_FIRST_ROW + pendingGroupIndex) * 16 + pendingSlot] = queued;
				}
			}
		}
	}
	return { roles: roles, states: states, motions: motions };
}

function cacheEditorColorPalette(palette) {
	if (!palette || palette.length !== 16 * 16) return;
	for (var index = 0; index < palette.length; index++) {
		editorColorCache[index] = palette[index].join(",");
	}
}

function queueColorModifierCellFrom(layer, x, y, modifier) {
	var command = layer === "motion" ? "colormotioncell" : "colorstatecell";
	if (!modifier) {
		queuePageColorCommand(command, x, y, "none", 0, 0, 0, 0);
		return;
	}
	queuePageColorCommand(command, x, y, modifier.op,
		clamp8(modifier.rgb[0]), clamp8(modifier.rgb[1]), clamp8(modifier.rgb[2]),
		clamp8(modifier.amount));
}

function updateQueuedColorModifierCell(layer, x, y) {
	var commandName = layer === "motion" ? "colormotioncell" : "colorstatecell";
	for (var queued = pageColorQueue.length - 1; queued >= 0; queued--) {
		var command = pageColorQueue[queued];
		if (command[0] === commandName && command[1] === x && command[2] === y) {
			pageColorQueue.splice(queued, 1);
		}
	}
}

function emitColorModifier(layer, x, y, modifier) {
	var command = layer === "motion" ? "colormotioncell" : "colorstatecell";
	var cache = layer === "motion" ? editorMotionColorCache : editorStateColorCache;
	var index = editorLevelIndex(x, y);
	var signature = colorModifierSignature(modifier);
	if (cache[index] === signature) return;
	cache[index] = signature;
	updateQueuedColorModifierCell(layer, x, y);
	if (!modifier) outlet(1, command, x, y, "none", 0, 0, 0, 0);
	else outlet(1, command, x, y, modifier.op,
		clamp8(modifier.rgb[0]), clamp8(modifier.rgb[1]), clamp8(modifier.rgb[2]),
		clamp8(modifier.amount));
}

function queueSceneColorPalette(resetCache) {
	if (!s.editorBrightnessColors) return 0;
	if (resetCache) invalidateEditorColorCache();
	var layers = buildSceneColorLayers();
	// Reset bridge-side modifiers immediately; the complete Role palette and all
	// non-empty modifiers that follow establish one authoritative Scene state.
	outlet(1, "colorlayersclear");
	queueColorPaletteMaps(layers.roles);
	cacheEditorColorPalette(layers.roles);
	for (var index = 0; index < layers.roles.length; index++) {
		var x = index % 16;
		var y = Math.floor(index / 16);
		editorStateColorCache[index] = colorModifierSignature(layers.states[index]);
		editorMotionColorCache[index] = colorModifierSignature(layers.motions[index]);
		if (layers.states[index]) queueColorModifierCellFrom("state", x, y, layers.states[index]);
		if (layers.motions[index]) queueColorModifierCellFrom("motion", x, y, layers.motions[index]);
	}
	editorScenePaletteVisible = true;
	return layers.roles.length;
}

function drawSceneView() {
	var levels = buildSceneLevels();
	for (var y = 0; y < 16; y++) {
		for (var x = 0; x < 16; x++) editorLed(x, y, levels[y * 16 + x]);
	}
}

function redrawSceneDiff() {
	var levels = buildSceneLevels();
	var layers = s.editorBrightnessColors ? buildSceneColorLayers() : null;
	var changes = [];
	for (var y = 0; y < 16; y++) {
		for (var x = 0; x < 16; x++) {
			var index = y * 16 + x;
			var levelChanged = editorLevelCache[index] !== levels[index];
			var roleChanged = layers &&
				editorColorCache[index] !== layers.roles[index].join(",");
			var stateChanged = layers && editorStateColorCache[index] !==
				colorModifierSignature(layers.states[index]);
			var motionChanged = layers && editorMotionColorCache[index] !==
				colorModifierSignature(layers.motions[index]);
			if (levelChanged || roleChanged || stateChanged || motionChanged) {
				changes.push([x, y, levels[index], levelChanged, roleChanged,
					stateChanged, motionChanged, layers ? layers.roles[index] : null,
					layers ? layers.states[index] : null, layers ? layers.motions[index] : null]);
			}
		}
	}
	if (!changes.length) return 0;
	var matrixUpdateOpened = beginMatrixUpdate();
	try {
		withEditorOverlayDraw(function () {
			for (var change = 0; change < changes.length; change++) {
				var item = changes[change];
				if (item[3]) editorLed(item[0], item[1], item[2], false);
				if (item[4]) emitEditorColor(item[0], item[1], item[7]);
				if (item[5]) emitColorModifier("state", item[0], item[1], item[8]);
				if (item[6]) emitColorModifier("motion", item[0], item[1], item[9]);
			}
		});
	} finally {
		endMatrixUpdate(matrixUpdateOpened);
	}
	return changes.length;
}

function drawEditorShell() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (workspace.collapsed) return;
	if (sequence64LayoutEnabled() && workspace.view64 === "scene") {
		drawSceneView();
		return;
	}
	var levels = buildEditorShellLevels();
	var colors = s.editorBrightnessColors ? buildEditorShellColors(levels) : null;
	for (var y = EDITOR_FIRST_ROW; y <= EDITOR_NAV_ROW; y++) {
		for (var x = 0; x < 16; x++) {
			editorLed(x, y, levels[editorShellLevelIndex(x, y)]);
		}
	}
	if (colors) queueEditorShellColors(colors);
}

function redrawEditorShellDiff(displayOnly) {
	if (!displayOnly) { if (knobLastContext) knobRefreshContext(); publishParameterFocus(false); }
	var workspace = ensureEditorWorkspaceDefaults();
	if (!editorWorkspaceAvailable() || !workspace.active || workspace.collapsed || workspace.choosing) return 0;
	if (sequence64LayoutEnabled() && workspace.view64 === "scene") return redrawSceneDiff();
	var levels = buildEditorShellLevels();
	var colors = s.editorBrightnessColors ? buildEditorShellColors(levels) : null;
	var changes = [];
	for (var y = EDITOR_FIRST_ROW; y <= EDITOR_NAV_ROW; y++) {
		for (var x = 0; x < 16; x++) {
			var shellIndex = editorShellLevelIndex(x, y);
			changes.push([x, y, levels[shellIndex], colors ? colors[shellIndex] : null]);
		}
	}
	return applyEditorLevelDiff(changes);
}

function refreshActiveEditorShell() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!editorAutomationDispatching && s.kmod === 2 && workspace.active &&
		!workspace.collapsed && !workspace.choosing) {
		redrawEditorShellDiff();
	}
}

function sequence64ViewForNavigationColumn(col) {
	return col === 0 ? "sequence" : (col === 1 ? "setup" : (col === 2 ? "scene" : ""));
}

function drawSequence64PersistentNavigation() {
	var workspace = ensureEditorWorkspaceDefaults();
	for (var col = 0; col <= 2; col++) {
		var view = sequence64ViewForNavigationColumn(col);
		var level = workspace.active ? 3 : 2;
		if (workspace.active && workspace.view64 === view) level = workspace.collapsed ? 8 : 15;
		var color = col === 1 ? SEQUENCE64_COLORS.setup : SEQUENCE64_COLORS.sequence;
		editorLed(col, SEQUENCE64_NAV_ROW, level, s.editorBrightnessColors, color);
	}
}

function drawEditorTargetChooser() {
	var workspace = ensureEditorWorkspaceDefaults();
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		editorLed(group, 0,
			workspace.targetType === "group" && workspace.targetId === group ?
				EDITOR_SELECTED_LEVEL : EDITOR_AVAILABLE_LEVEL);
	}
	for (var row = 1; row <= 15; row++) {
		var trackIdx = row - 1;
		editorLed(EDITOR_TRACK_COL, row,
			workspace.targetType === "track" && workspace.targetId === trackIdx ?
				EDITOR_SELECTED_LEVEL : EDITOR_AVAILABLE_LEVEL);
	}
}

function drawEditorWorkspaceOverlay() {
	if (s.kmod !== 2 || !editorWorkspaceSupported()) return;
	var workspace = ensureEditorWorkspaceDefaults();
	withEditorOverlayDraw(function () {
		if (!workspace.enabled) {
			editorLed(EDITOR_BUTTON_COL, 0, 0);
			return;
		}
		if (workspace.active && !workspace.collapsed) drawEditorShell();
		if (workspace.active && !workspace.collapsed && sequence64LayoutEnabled() &&
			workspace.view64 === "scene") return;
		if (workspace.choosing) drawEditorTargetChooser();
		if (sequence64LayoutEnabled()) drawSequence64PersistentNavigation();
		editorLed(EDITOR_BUTTON_COL, 0,
			workspace.choosing ? EDITOR_SELECTED_LEVEL :
				(workspace.active ? (workspace.collapsed ? 5 : 8) : 0));
	});
}

function clearEditorStepPattern() {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentEditorStepPattern();
	if (!pattern) return;
	for (var i = 0; i < 16; i++) pattern[i] = 0;
	outlet(2, "editor_steps_cleared", workspace.targetType, workspace.targetId + 1);
	redrawEditorShellDiff();
}

function setEditorLoopState(trackIdx, start, end, active, shouldRecord) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var loopStart = clamp(parseInt(start, 10) || 0, 0, 15);
	var loopEnd = clamp(parseInt(end, 10) || 16, 1, 16);
	if (loopEnd <= loopStart) loopEnd = Math.min(16, loopStart + 1);
	applyLoopStateForTrackIndex(trackIdx, loopStart, loopEnd, active);
	if (active) messnamed(trackLoopBus(trackChannelBusNumber(trackIdx)), loopStart, loopEnd);
	else messnamed(trackLoopBus(trackChannelBusNumber(trackIdx)), 0, 16);
	if (shouldRecord !== false) {
		recordEditorAutomationEvent("loop", { start: loopStart, end: loopEnd, active: active ? 1 : 0 });
	}
	writeThroughActiveTrackSlot(trackIdx, "track loop");
}

function setEditorPlaybackLoop(trackIdx, active) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	trackState.playbackLoop = active ? 1 : 0;
	var channelState = getChannelStateByIndex(trackChannelIndex(trackIdx));
	if (channelState && channelState.activeTrack === trackIdx) applyTrackPlaybackLoop(trackIdx);
	writeThroughActiveTrackSlot(trackIdx, "track playback loop");
	publishHudTrackState(trackIdx);
}

function setEditorSubLoopDivision(trackIdx, division, shouldRecord, sequenceOwned) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState || TRACK_SUB_LOOP_OPTIONS.indexOf(division) < 0) return;
	if (!sequenceOwned) {
		clearSequence64PropertyOwnership(sequence64TrackPropertyKey(trackIdx, "loopDivision"));
	}
	trackState.subLoopDiv = division;
	if (channelLatchEnabledForTrack(trackIdx)) reapplyTrackSubLoopAfterTrigger(trackIdx);
	if (shouldRecord !== false) recordEditorAutomationEvent("subLoopDiv", division);
	if (!sequenceOwned) writeThroughActiveTrackSlot(trackIdx, "track loop division");
}

function setEditorChannelLatch(channelIdx, active, shouldRecord) {
	setChannelGateLatch(channelIdx, active);
	if (shouldRecord !== false) recordEditorAutomationEvent("latch", active ? 1 : 0);
}

function setEditorTrackGroup(trackIdx, channelIdx, shouldRecord) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState || channelIdx < 0 || channelIdx >= s.NUM_CHANNELS) return;
	restoreEditorGateFx();
	clearLoopVisualForTrackIndex(trackIdx, true);
	trackState.channel = channelIdx + 1;
	sendNamedInt((trackIdx + 2) + "chn[box]", channelIdx + 1);
	if (shouldRecord !== false) recordEditorAutomationEvent("group", channelIdx);
	writeThroughActiveTrackSlot(trackIdx, "track group");
}

function setEditorVolume(channelIdx, volume, shouldRecord) {
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState) return;
	var nextVolume = clamp(parseInt(volume, 10) || 0, 0, 158);
	var delta = nextVolume - channelState.volume;
	channelState.volume = nextVolume;
	if (delta) sendNamedInt((channelIdx + 1) + "vol_add", delta);
	if (shouldRecord !== false) recordEditorAutomationEvent("volume", nextVolume);
}

function setEditorOctave(trackIdx, octave, shouldRecord, sequenceOwned) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var nextOctave = clamp(parseInt(octave, 10) || 0, -8, 8);
	if (!sequenceOwned) clearSequence64PropertyOwnership(sequence64TrackPropertyKey(trackIdx, "octave"));
	var delta = nextOctave - (parseInt(trackState.octave, 10) || 0);
	if (delta) clearLoopVisualForTrackIndex(trackIdx, true);
	var bus = (trackIdx + 2) + "[box]";
	for (var i = 0; i < Math.abs(delta); i++) {
		sendNamedInt(bus + (delta > 0 ? "upOct" : "dwnOct"), 1);
	}
	trackState.octave = nextOctave;
	if (shouldRecord !== false) recordEditorAutomationEvent("octave", nextOctave);
	if (!sequenceOwned) writeThroughActiveTrackSlot(trackIdx, "track octave");
}

function setEditorTranspose(trackIdx, semitones, shouldRecord, sequenceOwned) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var nextTranspose = clamp(Math.round(parseFloat(semitones) || 0), -96, 96);
	if (!sequenceOwned) {
		clearSequence64PropertyOwnership(sequence64TrackPropertyKey(trackIdx, "transpose"));
	}
	trackState.transpose = nextTranspose;
	// messnamed's second argument is a Max message selector, not the payload.
	// Send a real int message so the per-track receive outputs the semitone
	// value into ch.maxpat's floating-point rate calculation.
	sendNamedInt((trackIdx + 2) + "[box]transpose", nextTranspose);
	if (shouldRecord !== false) recordEditorAutomationEvent("transpose", nextTranspose);
	if (!sequenceOwned) writeThroughActiveTrackSlot(trackIdx, "track transpose");
}

function setEditorReverse(trackIdx, active, shouldRecord, sequenceOwned) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	if (!sequenceOwned) clearSequence64PropertyOwnership(sequence64TrackPropertyKey(trackIdx, "reverse"));
	clearLoopVisualForTrackIndex(trackIdx, true);
	trackState.reverse = active ? 1 : 0;
	sendNamedInt((trackIdx + 2) + "[box]rev", trackState.reverse);
	if (shouldRecord !== false) recordEditorAutomationEvent("reverse", trackState.reverse);
	if (!sequenceOwned) writeThroughActiveTrackSlot(trackIdx, "track reverse");
}

function restoreEditorReverse(trackIdx, active) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	clearSequence64PropertyOwnership(sequence64TrackPropertyKey(trackIdx, "reverse"));
	clearLoopVisualForTrackIndex(trackIdx, true);
	trackState.reverse = active ? 1 : 0;
	// [box]rev is normally a toggle command. During recall, set its UI state
	// without output; the following [mlr]ch store message restores DSP state
	// absolutely through ch.maxpat's preset inlet.
	messnamed((trackIdx + 2) + "[box]rev", "set", trackState.reverse);
}

function setEditorRandomOffset(trackIdx, active, shouldRecord) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	clearLoopVisualForTrackIndex(trackIdx, true);
	trackState.randomOffset = active ? 1 : 0;
	sendNamedInt((trackIdx + 2) + "[box]rndOff", trackState.randomOffset);
	if (shouldRecord !== false) recordEditorAutomationEvent("randomOffset", trackState.randomOffset);
	writeThroughActiveTrackSlot(trackIdx, "track random offset");
}

function setEditorTimestretch(channelIdx, active, shouldRecord) {
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState) return;
	channelState.timestretch = active ? 1 : 0;
	sendNamedInt((channelIdx + 1) + "[ch]timestretch", channelState.timestretch);
	if (shouldRecord !== false) recordEditorAutomationEvent("timestretch", channelState.timestretch);
}

function setEditorMute(channelIdx, active, shouldRecord) {
	var channelState = getChannelStateByIndex(channelIdx);
	if (!channelState) return;
	channelState.muted = active ? 1 : 0;
	sendNamedInt((channelIdx + 1) + "[box]mute", channelState.muted);
	if (shouldRecord !== false) recordEditorAutomationEvent("mute", channelState.muted);
}

function applyEditorAutomationEvent(event) {
	var trackIdx = currentEditorTrackIndex();
	var channelIdx = currentEditorChannelIndex();
	if (!event) return;
	if (event.type === "loop" && trackIdx >= 0) {
		setEditorLoopState(trackIdx, event.value.start, event.value.end, event.value.active, false);
	} else if (event.type === "subLoopDiv" && trackIdx >= 0) {
		setEditorSubLoopDivision(trackIdx, event.value, false);
	} else if (event.type === "latch" && channelIdx >= 0) {
		setEditorChannelLatch(channelIdx, event.value, false);
	} else if (event.type === "group" && trackIdx >= 0) {
		setEditorTrackGroup(trackIdx, event.value, false);
	} else if (event.type === "volume" && channelIdx >= 0) {
		setEditorVolume(channelIdx, event.value, false);
	} else if (event.type === "octave" && trackIdx >= 0) {
		setEditorOctave(trackIdx, event.value, false);
	} else if (event.type === "transpose" && trackIdx >= 0) {
		setEditorTranspose(trackIdx, event.value, false);
	} else if (event.type === "reverse" && trackIdx >= 0) {
		setEditorReverse(trackIdx, event.value, false);
	} else if (event.type === "randomOffset" && trackIdx >= 0) {
		setEditorRandomOffset(trackIdx, event.value, false);
	} else if (event.type === "timestretch" && channelIdx >= 0) {
		setEditorTimestretch(channelIdx, event.value, false);
	} else if (event.type === "mute" && channelIdx >= 0) {
		setEditorMute(channelIdx, event.value, false);
	}
}

function runEditorAutomationStep(step) {
	var automation = currentEditorAutomation();
	if (!automation || !automation.playing || !automation.events[step]) return 0;
	var eventCount = automation.events[step].length;
	editorAutomationDispatching = true;
	try {
		for (var i = 0; i < automation.events[step].length; i++) {
			applyEditorAutomationEvent(automation.events[step][i]);
		}
	} finally {
		editorAutomationDispatching = false;
	}
	return eventCount;
}

function sequence64ShapeKey(targetKey, parameter) {
	return targetKey + ":" + parameter;
}

function sequence64ShapeRampMs() {
	var quarterNoteMs = parseFloat(s.timeMs);
	if (!isFinite(quarterNoteMs) || quarterNoteMs <= 0) quarterNoteMs = 600;
	return clamp(Math.round(quarterNoteMs / 16), 8, 250);
}

function sequence64ChannelPropertyKey(channelIdx, parameter) {
	return "channel:" + channelIdx + ":" + parameter;
}

function sequence64TrackPropertyKey(trackIdx, parameter) {
	return "track:" + trackIdx + ":" + parameter;
}

function sequence64PropertyKey(parameter, channelIdx, trackIdx) {
	if (parameter === "volume" || parameter === "filter") {
		return sequence64ChannelPropertyKey(channelIdx, parameter);
	}
	return sequence64TrackPropertyKey(trackIdx, parameter);
}

function emitSequence64ParameterRaw(parameter, value, channelIdx, rampMs) {
	var normalized = clamp(parseFloat(value) || 0, 0, 15);
	if (channelIdx < 0 || channelIdx >= s.NUM_CHANNELS) return false;
	var ramp = rampMs === undefined ? sequence64ShapeRampMs() : Math.max(0, parseFloat(rampMs) || 0);
	if (parameter === "volume") {
		messnamed((channelIdx + 1) + "[gatefx]level", normalized / 15, ramp);
	} else if (parameter === "filter") {
		messnamed((channelIdx + 1) + "[filterfx]level", normalized / 15, ramp);
	} else {
		return false;
	}
	var workspace = ensureEditorWorkspaceDefaults();
	workspace.channelOutputs64[sequence64ChannelPropertyKey(channelIdx, parameter)] = normalized;
	return true;
}

function emitSequence64Parameter(targetType, targetId, parameter, value, channelIdx, rampMs) {
	var normalized = clamp(parseFloat(value) || 0, 0, 15);
	var channel = channelIdx;
	if (channel < 0 || channel >= s.NUM_CHANNELS) {
		if (targetType === "group") channel = targetId;
		else channel = trackChannelIndex(targetId);
	}
	if (channel < 0 || channel >= s.NUM_CHANNELS) return false;
	var ramp = rampMs === undefined ? sequence64ShapeRampMs() : Math.max(0, parseFloat(rampMs) || 0);
	if (!emitSequence64ParameterRaw(parameter, normalized, channel, ramp)) return false;
	var values = sequence64TargetParameterValues(targetType, targetId);
	if (values) values[parameter + "Output"] = normalized;
	outlet(2, "editor_shape_value", targetType, targetId + 1, parameter, normalized, ramp);
	return true;
}

function sequence64CurrentPropertyValue(parameter, channelIdx, trackIdx) {
	if (parameter === "volume" || parameter === "filter") {
		var workspace = ensureEditorWorkspaceDefaults();
		var outputKey = sequence64ChannelPropertyKey(channelIdx, parameter);
		var value = workspace.channelOutputs64[outputKey];
		return value === undefined ? 15 : clamp(parseFloat(value) || 0, 0, 15);
	}
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return 0;
	var instrument = instrumentDescriptorForTrack(trackIdx);
	if (instrumentDefinition(parameter) && instrument && instrumentDescriptorForParameter(parameter) === instrument) {
		var instrumentStack = ensureEditorWorkspaceDefaults().propertyStacks64[sequence64TrackPropertyKey(trackIdx, parameter)];
		return instrumentStack && instrumentStack.frames.length ?
			instrumentStack.frames[instrumentStack.frames.length - 1].value :
			instrumentSanitize(trackIdx,trackState.instrumentParameters)[parameter];
	}
	if (parameter === "reverse") return trackState.reverse ? 1 : 0;
	if (parameter === "octave") return clamp(parseInt(trackState.octave, 10) || 0, -8, 8);
	if (parameter === "transpose") return clamp(parseInt(trackState.transpose, 10) || 0, -96, 96);
	if (parameter === "loopDivision") return currentTrackSubLoopDiv(trackIdx);
	return 0;
}

function sequence64ApplyPropertyFrame(propertyKey, frame, fallbackValue, rampMs) {
	var parts = propertyKey.split(":");
	if (parts[0] === "channel") {
		var channelIdx = parseInt(parts[1], 10);
		var parameter = parts[2];
		if (frame) {
			emitSequence64Parameter(frame.targetType, frame.targetId, parameter,
				frame.value, channelIdx, rampMs);
		} else {
			emitSequence64ParameterRaw(parameter, fallbackValue, channelIdx, rampMs);
		}
		return;
	}
	var trackIdx = parseInt(parts[1], 10);
	var trackParameter = parts[2];
	var value = frame ? frame.value : fallbackValue;
	var instrument = instrumentDescriptorForTrack(trackIdx);
	if (instrumentDefinition(trackParameter) && instrument && instrumentDescriptorForParameter(trackParameter) === instrument) {
		messnamed(instrument.ownedBus, instrumentDefinition(trackParameter).rnbo,
			instrumentClampValue(trackParameter, value));
	}
	else if (trackParameter === "reverse") setEditorReverse(trackIdx, value ? 1 : 0, false, true);
	else if (trackParameter === "octave") setEditorOctave(trackIdx, value, false, true);
	else if (trackParameter === "transpose") setEditorTranspose(trackIdx, value, false, true);
	else if (trackParameter === "loopDivision") setEditorSubLoopDivision(trackIdx, value, false, true);
}

function sequence64WriteOwnedProperty(targetType, targetId, parameter, value, channelIdx, trackIdx, rampMs, ownerKey, momentary) {
	var targetKey = ownerKey || editorTargetKey(targetType, targetId);
	var propertyKey = sequence64PropertyKey(parameter, channelIdx, trackIdx);
	if (!targetKey || propertyKey.indexOf(":-1:") >= 0) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var stack = workspace.propertyStacks64[propertyKey];
	if (!stack) {
		stack = {
			baseValue: sequence64CurrentPropertyValue(parameter, channelIdx, trackIdx),
			frames: []
		};
		workspace.propertyStacks64[propertyKey] = stack;
	}
	for (var i = stack.frames.length - 1; i >= 0; i--) {
		if (stack.frames[i].owner === targetKey) stack.frames.splice(i, 1);
	}
	var frame = {
		owner: targetKey,
		targetType: targetType,
		targetId: targetId,
		parameter: parameter,
		channelIdx: channelIdx,
		trackIdx: trackIdx,
		value: value,
		momentary: momentary ? 1 : 0
	};
	// Explicit instrument ownership keeps group priority independent of write order.
	var insertAt = stack.frames.length;
	if (instrumentDefinition(parameter) && targetType === "track") {
		for (var f = 0; f < stack.frames.length; f++) {
			if (stack.frames[f].targetType === "group") { insertAt = f; break; }
		}
	}
	stack.frames.splice(insertAt, 0, frame);
	sequence64ApplyPropertyFrame(propertyKey, stack.frames[stack.frames.length - 1], stack.baseValue, rampMs);
	return true;
}

function releaseSequence64MomentaryProperties(targetKey, rampMs) {
	if (!targetKey) return 0;
	var workspace = ensureEditorWorkspaceDefaults();
	var released = 0;
	for (var propertyKey in workspace.propertyStacks64) {
		var stack = workspace.propertyStacks64[propertyKey];
		if (!stack || !stack.frames) continue;
		var wasTop = stack.frames.length &&
			stack.frames[stack.frames.length - 1].owner === targetKey &&
			stack.frames[stack.frames.length - 1].momentary;
		for (var i = stack.frames.length - 1; i >= 0; i--) {
			if (stack.frames[i].owner === targetKey && stack.frames[i].momentary) {
				stack.frames.splice(i, 1);
				released++;
			}
		}
		if (!wasTop) {
			if (!stack.frames.length) delete workspace.propertyStacks64[propertyKey];
			continue;
		}
		var nextFrame = stack.frames.length ? stack.frames[stack.frames.length - 1] : null;
		sequence64ApplyPropertyFrame(propertyKey, nextFrame, stack.baseValue, rampMs);
		if (!stack.frames.length) delete workspace.propertyStacks64[propertyKey];
	}
	return released;
}

function clearSequence64PropertyOwnership(propertyKey) {
	var workspace = ensureEditorWorkspaceDefaults();
	delete workspace.propertyStacks64[propertyKey];
}

function releaseSequence64OwnedProperties(targetKey, rampMs) {
	if (!targetKey) return 0;
	var workspace = ensureEditorWorkspaceDefaults();
	var released = 0;
	for (var propertyKey in workspace.propertyStacks64) {
		var stack = workspace.propertyStacks64[propertyKey];
		if (!stack || !stack.frames) continue;
		var wasTop = stack.frames.length && stack.frames[stack.frames.length - 1].owner === targetKey;
		for (var i = stack.frames.length - 1; i >= 0; i--) {
			if (stack.frames[i].owner === targetKey) {
				stack.frames.splice(i, 1);
				released++;
			}
		}
		if (!wasTop) {
			if (!stack.frames.length) delete workspace.propertyStacks64[propertyKey];
			continue;
		}
		var nextFrame = stack.frames.length ? stack.frames[stack.frames.length - 1] : null;
		sequence64ApplyPropertyFrame(propertyKey, nextFrame, stack.baseValue, rampMs);
		if (!stack.frames.length) delete workspace.propertyStacks64[propertyKey];
	}
	return released;
}

function restoreAllSequence64OwnedProperties() {
	var workspace = ensureEditorWorkspaceDefaults();
	for (var propertyKey in workspace.propertyStacks64) {
		var stack = workspace.propertyStacks64[propertyKey];
		if (stack) sequence64ApplyPropertyFrame(propertyKey, null, stack.baseValue, 8);
	}
	workspace.propertyStacks64 = {};
}

function cancelSequence64Shape(targetKey, parameter) {
	var key = sequence64ShapeKey(targetKey, parameter);
	for (var i = sequence64ActiveShapes.length - 1; i >= 0; i--) {
		if (sequence64ActiveShapes[i].key === key) sequence64ActiveShapes.splice(i, 1);
	}
}

function sequence64RateForOwner(targetType, targetId, ownerKey) {
	var workspace = ensureEditorWorkspaceDefaults();
	for (var key in workspace.phraseInstances64) {
		var instance = workspace.phraseInstances64[key];
		if (instance && instance.ownerKey === ownerKey) {
			return {
				numerator: instance.rateNumerator,
				denominator: instance.rateDenominator
			};
		}
	}
	return sequence64PatternRate(sequence64PlaybackPattern(targetType, targetId));
}

function rebaseSequence64ShapeRates(ownerKey, numerator, denominator) {
	for (var index = 0; index < sequence64ActiveShapes.length; index++) {
		var shape = sequence64ActiveShapes[index];
		if (shape.targetKey !== ownerKey) continue;
		var elapsedSteps = (sequence64ClockPosition - shape.startStep) *
			shape.rateNumerator / shape.rateDenominator;
		shape.rateNumerator = numerator;
		shape.rateDenominator = denominator;
		shape.startStep = sequence64ClockPosition -
			(elapsedSteps * denominator / numerator);
	}
}

function startSequence64ShapeForTarget(targetType, targetId, parameter, lock, gateLength, trackIdx, ownerKey) {
	if (!rtaEnabled()) return false;
	var targetKey = ownerKey || editorTargetKey(targetType, targetId);
	var values = sequence64TargetParameterValues(targetType, targetId);
	if (!targetKey || !values || (parameter !== "volume" && parameter !== "filter")) return;
	var behavior = SEQUENCE64_BEHAVIORS.indexOf(lock.behavior) >= 0 ? lock.behavior : "set";
	var channelIdx = targetType === "group" ? targetId : trackChannelIndex(trackIdx);
	var startValue = sequence64CurrentPropertyValue(parameter, channelIdx, trackIdx);
	var targetValue = clamp(parseInt(lock.value, 10) || 0, 0, 15);
	cancelSequence64Shape(targetKey, parameter);

	if (behavior === "set") {
		values[parameter] = targetValue;
		sequence64WriteOwnedProperty(targetType, targetId, parameter,
			targetValue, channelIdx, trackIdx, 0, targetKey, true);
		return;
	}

	if (behavior === "glide") values[parameter] = targetValue;
	var duration = behavior === "gate" ? Math.max(1, gateLength || 1) : SEQUENCE64_SHAPE_STEPS[behavior];
	var rate = sequence64RateForOwner(targetType, targetId, targetKey);
	sequence64ActiveShapes.push({
		key: sequence64ShapeKey(targetKey, parameter),
		targetKey: targetKey,
		targetType: targetType,
		targetId: targetId,
		parameter: parameter,
		behavior: behavior,
		startValue: startValue,
		targetValue: targetValue,
		startStep: sequence64ClockPosition,
		rateNumerator: rate.numerator,
		rateDenominator: rate.denominator,
		durationSteps: Math.max(1, duration || 1),
		channelIdx: channelIdx,
		trackIdx: trackIdx
	});
	advanceSequence64Shapes();
}

function startSequence64Shape(parameter, lock, gateLength, trackIdx) {
	var workspace = ensureEditorWorkspaceDefaults();
	return startSequence64ShapeForTarget(workspace.targetType, workspace.targetId,
		parameter, lock, gateLength, trackIdx);
}

function sequence64ShapeValue(shape, progress) {
	var p = clamp(progress, 0, 1);
	if (shape.behavior === "glide") {
		return shape.startValue + (shape.targetValue - shape.startValue) * p;
	}
	if (shape.behavior === "pluck") {
		var pluckPhase = p < 0.25 ? p / 0.25 : (1 - p) / 0.75;
		return shape.startValue + (shape.targetValue - shape.startValue) * clamp(pluckPhase, 0, 1);
	}
	if (shape.behavior === "swell") {
		var swellPhase = p < 0.5 ? p * 2 : (1 - p) * 2;
		return shape.startValue + (shape.targetValue - shape.startValue) * clamp(swellPhase, 0, 1);
	}
	if (shape.behavior === "gate") {
		if (p <= 0.2) return shape.startValue + (shape.targetValue - shape.startValue) * (p / 0.2);
		if (p < 0.8) return shape.targetValue;
		return shape.targetValue + (shape.startValue - shape.targetValue) * ((p - 0.8) / 0.2);
	}
	if (shape.behavior === "pulse") {
		if (p >= 1) return shape.startValue;
		return Math.floor(p * 8) % 2 ? shape.startValue : shape.targetValue;
	}
	return shape.targetValue;
}

function advanceSequence64Shapes() {
	var now = sequence64ClockPosition;
	for (var i = sequence64ActiveShapes.length - 1; i >= 0; i--) {
		var shape = sequence64ActiveShapes[i];
		var progress = ((now - shape.startStep) * shape.rateNumerator /
			shape.rateDenominator) / shape.durationSteps;
		var value = sequence64ShapeValue(shape, progress);
		sequence64WriteOwnedProperty(shape.targetType, shape.targetId, shape.parameter,
			value, shape.channelIdx, shape.trackIdx, sequence64ShapeRampMs(), shape.targetKey);
		if (progress >= 1) sequence64ActiveShapes.splice(i, 1);
	}
}

function clearSequence64Motion() {
	var workspace = ensureEditorWorkspaceDefaults();
	var targetKey = currentEditorTargetKey();
	var values = currentSequence64ParameterValues();
	for (var i = sequence64ActiveShapes.length - 1; i >= 0; i--) {
		var shape = sequence64ActiveShapes[i];
		if (shape.targetKey !== targetKey) continue;
		var latchValue = values && values[shape.parameter] !== undefined ? values[shape.parameter] : shape.startValue;
		sequence64WriteOwnedProperty(shape.targetType, shape.targetId, shape.parameter,
			latchValue, shape.channelIdx, shape.trackIdx, sequence64ShapeRampMs(), shape.targetKey);
		sequence64ActiveShapes.splice(i, 1);
	}
	outlet(2, "editor_motion_cleared", workspace.targetType, workspace.targetId + 1);
	redrawEditorShellDiff();
}

function captureSequence64StartSnapshotForTarget(targetType, targetId) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = editorTargetKey(targetType, targetId);
	if (!key) return null;
	var trackIdx = sequence64TargetTrackIndex(targetType, targetId, null);
	var trackState = getTrackStateByIndex(trackIdx);
	var channelIdx = sequence64TargetChannelIndex(targetType, targetId);
	var channelState = getChannelStateByIndex(channelIdx);
	var values = sequence64TargetParameterValues(targetType, targetId);
	var snapshot = {
		trackIdx: trackIdx,
		channelIdx: channelIdx,
		parameters: { volume: values ? values.volume : 15, filter: values ? values.filter : 15 },
		track: trackState ? {
			playPos: trackState.playPos,
			octave: trackState.octave,
			transpose: trackState.transpose,
			reverse: trackState.reverse,
			playbackLoop: trackState.playbackLoop,
			randomOffset: trackState.randomOffset,
			subLoopDiv: trackState.subLoopDiv,
			loopStart: trackState.loopStart,
			loopEnd: trackState.loopEnd,
			loopActive: trackState.loopActive
		} : null,
		channel: channelState ? {
			volume: channelState.volume,
			timestretch: channelState.timestretch,
			muted: channelState.muted,
			gateLatch: channelState.gateLatch
		} : null
	};
	workspace.startSnapshots64[key] = snapshot;
	return snapshot;
}

function captureSequence64StartSnapshot() {
	var workspace = ensureEditorWorkspaceDefaults();
	return captureSequence64StartSnapshotForTarget(workspace.targetType, workspace.targetId);
}

function restoreSequence64StartSnapshot() {
	var workspace = ensureEditorWorkspaceDefaults();
	var snapshot = workspace.startSnapshots64[currentEditorTargetKey()];
	if (!snapshot) return false;
	clearSequence64Motion();
	releaseSequence64OwnedProperties(currentEditorTargetKey(), sequence64ShapeRampMs());
	if (snapshot.track && snapshot.trackIdx >= 0) {
		if (snapshot.track.playPos !== undefined) {
			var restorePosition = clamp(parseInt(snapshot.track.playPos, 10) || 0, 0, 15);
			var restoredTrack = getTrackStateByIndex(snapshot.trackIdx);
			restoredTrack.playPos = restorePosition;
			var restoredChannel = getChannelStateByIndex(trackChannelIndex(snapshot.trackIdx));
			cancelSequence64AudioForChannel(trackChannelIndex(snapshot.trackIdx));
			restoredChannel.activeTrack = snapshot.trackIdx;
			restoredChannel.sequence64Owner = null;
			sendTrackInput(snapshot.trackIdx, restorePosition, 1);
			sendTrackInput(snapshot.trackIdx, restorePosition, 0);
		}
		setEditorOctave(snapshot.trackIdx, snapshot.track.octave, false);
		setEditorTranspose(snapshot.trackIdx, snapshot.track.transpose, false);
		setEditorReverse(snapshot.trackIdx, snapshot.track.reverse, false);
		setEditorPlaybackLoop(snapshot.trackIdx,
			snapshot.track.playbackLoop === undefined ? 1 : snapshot.track.playbackLoop);
		setEditorRandomOffset(snapshot.trackIdx, snapshot.track.randomOffset, false);
		setEditorSubLoopDivision(snapshot.trackIdx, snapshot.track.subLoopDiv, false);
		setEditorLoopState(snapshot.trackIdx, snapshot.track.loopStart, snapshot.track.loopEnd,
			snapshot.track.loopActive, false);
	}
	if (snapshot.channel && snapshot.channelIdx >= 0) {
		setEditorVolume(snapshot.channelIdx, snapshot.channel.volume, false);
		setEditorTimestretch(snapshot.channelIdx, snapshot.channel.timestretch, false);
		setEditorMute(snapshot.channelIdx, snapshot.channel.muted, false);
		setEditorChannelLatch(snapshot.channelIdx, snapshot.channel.gateLatch, false);
	}
	var values = currentSequence64ParameterValues();
	values.volume = snapshot.parameters.volume;
	values.filter = snapshot.parameters.filter;
	clearSequence64PropertyOwnership(sequence64ChannelPropertyKey(snapshot.channelIdx, "volume"));
	clearSequence64PropertyOwnership(sequence64ChannelPropertyKey(snapshot.channelIdx, "filter"));
	emitSequence64Parameter(workspace.targetType, workspace.targetId, "volume", values.volume, snapshot.channelIdx);
	emitSequence64Parameter(workspace.targetType, workspace.targetId, "filter", values.filter, snapshot.channelIdx);
	outlet(2, "editor_start_restored", workspace.targetType, workspace.targetId + 1);
	redrawEditorShellDiff();
	return true;
}

function cancelSequence64ShapesForTarget(targetKey) {
	for (var i = sequence64ActiveShapes.length - 1; i >= 0; i--) {
		if (!targetKey || sequence64ActiveShapes[i].targetKey === targetKey) {
			sequence64ActiveShapes.splice(i, 1);
		}
	}
}

function updateSequence64RunDisplay(targetType, targetId, running) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (workspace.active && workspace.targetType === targetType && workspace.targetId === targetId) {
		redrawEditorShellDiff();
	}
	if (s.kmod !== 2) return;
	if (targetType === "group" && targetId >= 0 && targetId < s.NUM_CHANNELS) {
		led(targetId, 4, running ? 15 : 3);
	} else if (targetType === "track") {
		var runRow = targetId + 1;
		if (runRow > 0 && runRow < s.gridHeight && !editorOwnsLedCell(11, runRow)) {
			led(11, runRow, running ? 15 : 3);
		}
	}
}

function pulseSequence64RunKey(targetType, targetId) {
	if (s.kmod !== 2 || !sequence64LayoutEnabled()) return false;
	var x = -1;
	var y = -1;
	if (targetType === "group" && targetId >= 0 && targetId < s.NUM_CHANNELS) {
		x = targetId;
		y = 4;
	} else if (targetType === "track" && targetId >= 0 && targetId < s.NUM_TRACKS) {
		x = 11;
		y = targetId + 1;
	}
	if (x < 0 || y < 0 || x >= s.gridWidth || y >= s.gridHeight ||
		editorOwnsLedCell(x, y)) return false;
	var pattern = sequence64PlaybackPattern(targetType, targetId);
	var baseLevel = pattern && pattern.running ? 15 : 3;
	if (baseLevel === 15) {
		// A full-bright Run latch needs an inverse blink to remain visible.
		outlet(3, "kf", x, y, 6, 1, baseLevel, 8);
	} else {
		outlet(3, "kf", x, y, 15, 1, baseLevel, 8);
	}
	return true;
}

function stopSequence64Target(targetType, targetId, reason, suppressStatus) {
	if (targetType === "group" && sequence64NativeGroups[targetId])
		releaseNativeSequence64(reason || "group_stop", false);
	var workspace = ensureEditorWorkspaceDefaults();
	var targetKey = editorTargetKey(targetType, targetId);
	if (!targetKey) return false;
	var pattern = workspace.patterns64[targetKey];
	var wasRunning = !!(pattern && pattern.running);
	clearSequence64Decision(targetType, targetId);
	if (pattern) {
		pattern.running = 0;
		var playback = sequence64PlaybackLocation(pattern);
		pattern.lastSequencedFlat = playback.flat;
		pattern.lastSequencedAbsolute = playback.absolute;
	}
	cancelSequence64PhrasesForParent(targetKey, reason || "stop", false);
	// A track phrase may currently be a child of a running group rather than a
	// preview owned by track:N. Track clear/reset/stop still has to remove that
	// phrase's runtime modulation before its programmed data changes.
	if (targetType === "track") {
		var activeTrackPhrase = activeSequence64PhraseForTrack(targetId);
		if (activeTrackPhrase) {
			finishSequence64Phrase(activeTrackPhrase, reason || "track_stop", false);
		}
	}
	cancelSequence64ShapesForTarget(targetKey);
	var releasedProperties = releaseSequence64OwnedProperties(targetKey, sequence64ShapeRampMs());
	var stoppedChannels = [];
	for (var channelIdx = 0; channelIdx < s.NUM_CHANNELS; channelIdx++) {
		var channelState = getChannelStateByIndex(channelIdx);
		if (!channelState || channelState.sequence64Owner !== targetKey) continue;
		cancelSequence64AudioForChannel(channelIdx);
		sendNamedInt((channelIdx + 1) + "[pl]stop", 1);
		channelState.sequence64Owner = null;
		if (channelState.activeTrack >= 0) channelState.lastActiveTrack = channelState.activeTrack;
		channelState.activeTrack = -1;
		stoppedChannels.push(channelIdx + 1);
	}
	var targetChannel = sequence64TargetChannelIndex(targetType, targetId);
	var values = sequence64TargetParameterValues(targetType, targetId);
	if (values && targetChannel >= 0) {
		var volumeKey = sequence64ChannelPropertyKey(targetChannel, "volume");
		var filterKey = sequence64ChannelPropertyKey(targetChannel, "filter");
		if (workspace.channelOutputs64[volumeKey] !== undefined) {
			values.volume = workspace.channelOutputs64[volumeKey];
			values.volumeOutput = values.volume;
		}
		if (workspace.channelOutputs64[filterKey] !== undefined) {
			values.filter = workspace.channelOutputs64[filterKey];
			values.filterOutput = values.filter;
		}
	}
	updateSequence64RunDisplay(targetType, targetId, false);
	diagnosticEvent("sequence64_stop", {
		targetType: targetType,
		target: targetId + 1,
		reason: reason || "stop",
		wasRunning: wasRunning ? 1 : 0,
		stoppedChannels: stoppedChannels,
		releasedProperties: releasedProperties
	});
	if (!suppressStatus) outlet(2, "editor_run", targetType, targetId + 1, 0);
	publishHudPatternSummary(targetType, targetId, pattern || null);
	if (workspace.active && workspace.targetType === targetType &&
		workspace.targetId === targetId) publishHudCurrentPattern();
	if (targetType === "group") {
		writeThroughActiveSceneGroup(targetId,
			workspace.performanceGroupPatternRefs[targetId], 0, "scene group stop");
	}
	if (!sceneRecallApplying) reconcileSequence64Transport(reason || "target_stop");
	return wasRunning || stoppedChannels.length > 0 || releasedProperties > 0;
}

function startSequence64TrackPreview(trackIdx, reason) {
	if (!rtaEnabled()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = ensureSequence64Pattern("track", trackIdx);
	if (!pattern) return false;
	startSequence64Transport(reason || "track_preview");
	pattern.running = 1;
	pattern.restartArmed = 0;
	captureSequence64StartSnapshotForTarget("track", trackIdx);
	var trackState = getTrackStateByIndex(trackIdx);
	var targetKey = editorTargetKey("track", trackIdx);
	launchSequence64TrackPhrase(trackIdx, trackState ? trackState.playPos : 0,
		targetKey, targetKey, true);
	updateSequence64RunDisplay("track", trackIdx, true);
	diagnosticEvent("sequence64_phrase_preview", {
		track: trackIdx + 1,
		reason: reason || "preview"
	});
	outlet(2, "editor_run", "track", trackIdx + 1, 1);
	publishHudPatternSummary("track", trackIdx, pattern);
	return true;
}

function restartSequence64Target(targetType, targetId, reason) {
	if (!rtaEnabled()) return false;
	releaseNativeSequence64("restart", false);
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = ensureSequence64Pattern(targetType, targetId);
	if (!pattern) return false;
	var wasRunning = !!pattern.running;
	clearSequence64Decision(targetType, targetId);
	pattern.phaseOrigin = sequence64ClockPosition;
	pattern.lastSequencedFlat = -1;
	pattern.lastSequencedAbsolute = -1;
	pattern.restartArmed = 0;
	var fired = 0;
	if (targetType === "track") {
		startSequence64TrackPreview(targetId, reason || "restart");
		fired = 1;
	} else {
		startSequence64Transport(reason || "group_restart");
		if (!wasRunning) {
			pattern.running = 1;
			captureSequence64StartSnapshotForTarget(targetType, targetId);
			updateSequence64RunDisplay(targetType, targetId, true);
			outlet(2, "editor_run", targetType, targetId + 1, 1);
		}
		fired = runSequence64StepForTarget(targetType, targetId, pattern, 0, 0);
		pattern.lastSequencedFlat = 0;
		pattern.lastSequencedAbsolute = 0;
	}
	if (workspace.active && workspace.targetType === targetType && workspace.targetId === targetId) {
		workspace.lastSequencedBar = 0;
		workspace.lastSequencedStep = 0;
		redrawEditorShellDiff();
	}
	diagnosticEvent("sequence64_restart", {
		targetType: targetType,
		target: targetId + 1,
		reason: reason || "restart",
		running: pattern.running ? 1 : 0,
		fired: fired
	});
	outlet(2, "editor_restart", targetType, targetId + 1, pattern.running ? 1 : 0);
	publishHudPatternSummary(targetType, targetId, pattern);
	if (workspace.active && workspace.targetType === targetType &&
		workspace.targetId === targetId) publishHudCurrentPattern();
	if (targetType === "group") {
		writeThroughActiveSceneGroup(targetId,
			workspace.performanceGroupPatternRefs[targetId], 1, "scene group run");
	}
	return true;
}

function restartCurrentSequence64Pattern() {
	var workspace = ensureEditorWorkspaceDefaults();
	return restartSequence64Target(workspace.targetType, workspace.targetId, "button");
}

function sequence64RateChoiceIndex(pattern) {
	var rate = sequence64PatternRate(pattern);
	for (var index = 0; index < SEQUENCE64_RATE_CHOICES.length; index++) {
		var choice = SEQUENCE64_RATE_CHOICES[index];
		if (choice.numerator === rate.numerator &&
			choice.denominator === rate.denominator) return index;
	}
	return -1;
}

function setSequence64PatternRate(targetType, targetId, numerator, denominator) {
	var pattern = ensureSequence64Pattern(targetType, targetId);
	if (!pattern) return false;
	var nextNumerator = clamp(parseInt(numerator, 10) || 1, 1, 16);
	var nextDenominator = clamp(parseInt(denominator, 10) || 1, 1, 16);
	var playback = sequence64TargetPlaybackLocation(targetType, targetId, pattern);
	var absolute = playback.absolute === undefined ? playback.flat : playback.absolute;
	pattern.rateNumerator = nextNumerator;
	pattern.rateDenominator = nextDenominator;
	pattern.phaseOrigin = sequence64ClockPosition -
		(absolute * nextDenominator / nextNumerator);
	pattern.lastSequencedAbsolute = absolute;
	pattern.lastSequencedFlat = playback.flat;
	rebaseSequence64ShapeRates(editorTargetKey(targetType, targetId),
		nextNumerator, nextDenominator);

	if (targetType === "track") {
		var phrase = activeSequence64PhraseForTrack(targetId);
		if (phrase) {
			var phraseAbsolute = Math.max(0, playback.absolute === undefined ?
				playback.flat : playback.absolute);
			phrase.rateNumerator = nextNumerator;
			phrase.rateDenominator = nextDenominator;
			phrase.startClock = sequence64ClockPosition -
				(phraseAbsolute * nextDenominator / nextNumerator);
			phrase.lastFlat = Math.min(phrase.totalLength - 1, phraseAbsolute);
			rebaseSequence64ShapeRates(phrase.ownerKey,
				nextNumerator, nextDenominator);
		}
	}
	diagnosticEvent("sequence64_rate", {
		targetType: targetType,
		target: targetId + 1,
		numerator: nextNumerator,
		denominator: nextDenominator,
		bar: playback.bar + 1,
		step: playback.step + 1
	});
	outlet(2, "editor_rate", targetType, targetId + 1,
		nextNumerator, nextDenominator);
	markSessionDirty("ṛta rate");
	redrawEditorShellDiff();
	return true;
}

function setCurrentSequence64RateChoice(choiceIndex) {
	if (choiceIndex < 0 || choiceIndex >= SEQUENCE64_RATE_CHOICES.length) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var choice = SEQUENCE64_RATE_CHOICES[choiceIndex];
	return setSequence64PatternRate(workspace.targetType, workspace.targetId,
		choice.numerator, choice.denominator);
}

function reconcileSequence64StructurePosition(targetType, targetId, pattern, previous, reason) {
	if (!pattern || !previous) return false;
	var phrase = targetType === "track" ? activeSequence64PhraseForTrack(targetId) : null;
	var barIndex = pattern.bars.indexOf(previous.barRef);
	if (reason === "bar_length" && barIndex >= 0) {
		// Wrap shortened steps without moving the owning pattern off its beat grid.
		previous.step %= pattern.bars[barIndex].length;
	}
	if (barIndex < 0 || previous.step >= pattern.bars[barIndex].length) {
		if (phrase) {
			launchSequence64TrackPhrase(targetId, phrase.seedSlice,
				phrase.parentTargetKey, phrase.audioOwnerKey, phrase.preview,
				phrase.conditionVisit, phrase.seedInstrumentOverrides);
		} else restartSequence64Target(targetType, targetId, reason || "structure_restart");
		return false;
	}
	var playback;
	if (phrase) {
		var phraseFlat = sequence64FlatForLocation(pattern, barIndex, previous.step);
		phrase.startClock = sequence64ClockPosition -
			(phraseFlat * phrase.rateDenominator / phrase.rateNumerator);
		phrase.lastFlat = phraseFlat;
		phrase.totalLength = sequence64PatternTotalLength(pattern);
		playback = sequence64PatternLocationAtFlat(pattern, phraseFlat);
	} else playback = setSequence64PatternPosition(pattern, barIndex, previous.step);
	if (reason === "bar_length" && previous.fractionalStep) {
		var rate = phrase ? { numerator: phrase.rateNumerator, denominator: phrase.rateDenominator } : sequence64PatternRate(pattern);
		var remainder = previous.fractionalStep * rate.denominator / rate.numerator;
		if (phrase) phrase.startClock -= remainder;
		else pattern.phaseOrigin -= remainder;
	}
	if (!pattern.running && previous.restartArmed) pattern.restartArmed = 1;
	var workspace = ensureEditorWorkspaceDefaults();
	if (workspace.active && workspace.targetType === targetType && workspace.targetId === targetId) {
		workspace.lastSequencedBar = playback.bar;
		workspace.lastSequencedStep = playback.step;
	}
	diagnosticEvent("sequence64_structure_rebased", {
		targetType: targetType,
		target: targetId + 1,
		reason: reason || "structure",
		bar: playback.bar + 1,
		step: playback.step + 1,
		running: pattern.running ? 1 : 0
	});
	return true;
}

function setSequence64TargetRunning(targetType, targetId, enabled) {
	if (!rtaEnabled()) return false;
	releaseNativeSequence64("run_change", false);
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = ensureSequence64Pattern(targetType, targetId);
	if (!pattern) return;
	var next = enabled ? 1 : 0;
	if (targetType === "track" && next) {
		startSequence64TrackPreview(targetId, "run");
		return;
	}
	if (!next) {
		stopSequence64Target(targetType, targetId, "run_stop");
		return;
	}
	if (pattern.running === next) return;
	startSequence64Transport("group_run");
	pattern.running = next;
	captureSequence64StartSnapshotForTarget(targetType, targetId);
	var playback = sequence64TargetPlaybackLocation(targetType, targetId, pattern);
	if (pattern.restartArmed) {
		pattern.restartArmed = 0;
		runSequence64StepForTarget(targetType, targetId, pattern,
			playback.bar, playback.step, playback.absolute);
		pattern.lastSequencedFlat = playback.flat;
	} else {
		pattern.lastSequencedFlat = playback.flat;
	}
	pattern.lastSequencedAbsolute = playback.absolute === undefined ?
		sequence64PatternAbsoluteStep(pattern, sequence64ClockPosition) : playback.absolute;
	if (workspace.active && workspace.targetType === targetType && workspace.targetId === targetId) {
		workspace.lastSequencedStep = playback.step;
		workspace.lastSequencedBar = playback.bar;
	}
	updateSequence64RunDisplay(targetType, targetId, true);
	diagnosticEvent("sequence64_run", {
		targetType: targetType,
		target: targetId + 1,
		run: next,
		bar: playback.bar + 1,
		step: playback.step + 1
	});
	outlet(2, "editor_run", targetType, targetId + 1, next);
	publishHudPatternSummary(targetType, targetId, pattern);
	if (workspace.active && workspace.targetType === targetType &&
		workspace.targetId === targetId) publishHudCurrentPattern();
	if (targetType === "group") {
		writeThroughActiveSceneGroup(targetId,
			workspace.performanceGroupPatternRefs[targetId], next, "scene group run");
	}
}

function setCurrentSequence64Running(enabled) {
	var workspace = ensureEditorWorkspaceDefaults();
	setSequence64TargetRunning(workspace.targetType, workspace.targetId, enabled);
}

function sequence64StepTrack(step) {
	var workspace = ensureEditorWorkspaceDefaults();
	return sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, step);
}

function applySequence64StepLockForTarget(targetType, targetId, parameter, lock, step, trackIdx, ownerKey) {
	if (!lock) return;
	// Instrument locks are folded into the queued hit packet instead of taking
	// runtime ownership. This makes them per-hit and leaves an existing tail alone.
	if (instrumentDefinition(parameter)) return;
	if (parameter === "volume" || parameter === "filter") {
		startSequence64ShapeForTarget(targetType, targetId, parameter, lock,
			step.cut ? step.cut.gateLength : 1, trackIdx, ownerKey);
	} else if (parameter === "reverse" && trackIdx >= 0) {
		sequence64WriteOwnedProperty(targetType, targetId, parameter,
			lock.value ? 1 : 0, trackChannelIndex(trackIdx), trackIdx, 0, ownerKey, true);
	} else if (parameter === "transpose" && trackIdx >= 0) {
		sequence64WriteOwnedProperty(targetType, targetId, parameter,
			lock.value, trackChannelIndex(trackIdx), trackIdx, 0, ownerKey, true);
	} else if (parameter === "loopDivision" && trackIdx >= 0) {
		sequence64WriteOwnedProperty(targetType, targetId, parameter,
			lock.value, trackChannelIndex(trackIdx), trackIdx, 0, ownerKey, true);
	}
}

function sequence64PatternHasContent(pattern) {
	if (!pattern || !pattern.bars) return false;
	for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
		var bar = pattern.bars[barIndex];
		for (var stepIndex = 0; stepIndex < bar.length; stepIndex++) {
			var step = bar.steps[stepIndex];
			if (sequence64StepHasContent(step)) return true;
		}
	}
	return false;
}

function sequence64PhraseInstanceKey(channelIdx) {
	return "channel:" + channelIdx;
}

function activeSequence64PhraseForTrack(trackIdx) {
	var workspace = ensureEditorWorkspaceDefaults();
	for (var key in workspace.phraseInstances64) {
		var instance = workspace.phraseInstances64[key];
		if (instance && instance.trackIdx === trackIdx) return instance;
	}
	return null;
}

function finishSequence64Phrase(instance, reason, stopAudio) {
	if (!instance) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	cancelSequence64ShapesForTarget(instance.ownerKey);
	releaseSequence64OwnedProperties(instance.ownerKey, sequence64ShapeRampMs());
	var stored = workspace.phraseInstances64[instance.instanceKey];
	if (stored === instance) delete workspace.phraseInstances64[instance.instanceKey];
	var pattern = workspace.patterns64[editorTargetKey("track", instance.trackIdx)];
	if (instance.preview && pattern) {
		pattern.running = 0;
		updateSequence64RunDisplay("track", instance.trackIdx, false);
	}
	var channelState = getChannelStateByIndex(instance.channelIdx);
	if (stopAudio && channelState && channelState.sequence64Owner === instance.audioOwnerKey) {
		cancelSequence64AudioForChannel(instance.channelIdx);
		sendNamedInt((instance.channelIdx + 1) + "[pl]stop", 1);
		channelState.sequence64Owner = null;
		if (channelState.activeTrack >= 0) channelState.lastActiveTrack = channelState.activeTrack;
		channelState.activeTrack = -1;
	}
	diagnosticEvent("sequence64_phrase_end", {
		track: instance.trackIdx + 1,
		channel: instance.channelIdx + 1,
		parent: instance.parentTargetKey,
		owner: instance.ownerKey,
		reason: reason || "complete",
		stopAudio: stopAudio ? 1 : 0
	});
	if (!sceneRecallApplying && !sequence64TransportPausing &&
		!sequence64PhraseLaunching &&
		!sequence64HasPlaybackActivity()) {
		stopSequence64Transport(reason || "phrase_complete");
	}
	return true;
}

function cancelSequence64PhraseForChannel(channelIdx, reason, stopAudio) {
	var workspace = ensureEditorWorkspaceDefaults();
	var instance = workspace.phraseInstances64[sequence64PhraseInstanceKey(channelIdx)];
	return finishSequence64Phrase(instance, reason || "channel_cancel", stopAudio);
}

function cancelSequence64PhrasesForParent(parentTargetKey, reason, stopAudio) {
	var workspace = ensureEditorWorkspaceDefaults();
	var instances = [];
	for (var key in workspace.phraseInstances64) {
		var instance = workspace.phraseInstances64[key];
		if (instance && instance.parentTargetKey === parentTargetKey) instances.push(instance);
	}
	for (var index = 0; index < instances.length; index++) {
		finishSequence64Phrase(instances[index], reason || "parent_cancel", stopAudio);
	}
	return instances.length;
}

function triggerSequence64PhraseAudio(instance, slice, instrumentOverrides) {
	var position = clamp(parseInt(slice, 10) || 0, 0, 15);
	sequence64PlaybackCaptureGuard = {
		track: instance.trackIdx,
		slice: position,
		expiresTick: (s.automation.tick || 0) + 1
	};
	triggerEditorTrack(instance.trackIdx, position, instance.audioOwnerKey, instrumentOverrides);
}

function runSequence64PhraseStep(instance, flatStep) {
	if (!rtaEnabled()) return false;
	if (!instance || flatStep < 0 || flatStep >= instance.totalLength) return 0;
	releaseSequence64MomentaryProperties(instance.ownerKey, sequence64ShapeRampMs());
	var pattern = sequence64PlaybackPattern("track", instance.trackIdx);
	var location = sequence64PatternLocationAtFlat(pattern, flatStep);
	var step = pattern.bars[location.bar].steps[location.step];
	var conditionPasses = step && sequence64ConditionPass(step, instance.conditionVisit);
	var passes = sequence64StepDecisionPass("track", instance.trackIdx,
		location.bar, location.step, step, instance.conditionVisit);
	if (passes) {
		for (var parameter in step.locks) {
			applySequence64StepLockForTarget("track", instance.trackIdx, parameter,
				step.locks[parameter], step, instance.trackIdx, instance.ownerKey);
		}
	}
	var shouldTrigger = passes && (flatStep === 0 || (step && step.cut));
	if (shouldTrigger) {
		var sliceOffset = 0;
		if (passes && step && step.cut) sliceOffset = step.cut.slice;
		if (passes && step && step.locks.slice) sliceOffset = step.locks.slice.value;
		// Track phrases describe reusable motion around their parent cut. Their
		// Slice value is therefore an offset, while group-pattern slices remain
		// absolute. Preview uses the track's current slice as the same root.
		var slice = (instance.seedSlice +
			clamp(parseInt(sliceOffset, 10) || 0, 0, 15)) % 16;
		var instrumentOverrides = sequence64InstrumentStepOverrides(instance.trackIdx, step);
		if (flatStep === 0) {
			// The parent group step and phrase step 1 describe the same hit. The
			// group is the outer layer, so its explicit locks win on that hit only.
			instrumentOverrides = mergeSequence64InstrumentOverrides(
				instrumentOverrides, instance.seedInstrumentOverrides);
		}
		pulseSequence64RunKey("track", instance.trackIdx);
		triggerSequence64PhraseAudio(instance, slice, instrumentOverrides);
	}
	instance.lastFlat = flatStep;
	diagnosticEventRateLimited("sequence64_phrase_step", instance.ownerKey, function () { return {
		track: instance.trackIdx + 1,
		channel: instance.channelIdx + 1,
		parent: instance.parentTargetKey,
		owner: instance.ownerKey,
		step: flatStep + 1,
		condition: step ? step.condition : 0,
		conditionVisit: instance.conditionVisit,
		conditionPassed: conditionPasses ? 1 : 0,
		passed: passes ? 1 : 0,
		triggered: shouldTrigger ? 1 : 0
	}; });
	return passes || shouldTrigger ? 1 : 0;
}

function launchSequence64TrackPhrase(trackIdx, seedSlice, parentTargetKey, audioOwnerKey, preview, conditionVisit, instrumentOverrides) {
	var pattern = sequence64PlaybackPattern("track", trackIdx);
	var rate = sequence64PatternRate(pattern);
	var channelIdx = trackChannelIndex(trackIdx);
	var previousLaunchState = sequence64PhraseLaunching;
	sequence64PhraseLaunching = true;
	try {
		cancelSequence64PhraseForChannel(channelIdx, "retrigger", false);
	} finally {
		sequence64PhraseLaunching = previousLaunchState;
	}
	if (preview) pattern.running = 1;
	var workspace = ensureEditorWorkspaceDefaults();
	var instanceKey = sequence64PhraseInstanceKey(channelIdx);
	var instance = {
		instanceKey: instanceKey,
		ownerKey: "phrase:" + (++workspace.phraseSerial64),
		parentTargetKey: parentTargetKey,
		audioOwnerKey: audioOwnerKey,
		trackIdx: trackIdx,
		channelIdx: channelIdx,
		seedSlice: clamp(parseInt(seedSlice, 10) || 0, 0, 15),
		seedInstrumentOverrides: instrumentOverrides || null,
		conditionVisit: Math.max(1, parseInt(conditionVisit, 10) || 1),
		startClock: sequence64ClockPosition,
		lastFlat: -1,
		totalLength: sequence64PatternTotalLength(pattern),
		rateNumerator: rate.numerator,
		rateDenominator: rate.denominator,
		preview: preview ? 1 : 0
	};
	workspace.phraseInstances64[instanceKey] = instance;
	diagnosticEvent("sequence64_phrase_launch", {
		track: trackIdx + 1,
		channel: channelIdx + 1,
		parent: parentTargetKey,
		owner: instance.ownerKey,
		length: instance.totalLength,
		rateNumerator: instance.rateNumerator,
		rateDenominator: instance.rateDenominator,
		preview: instance.preview
	});
	runSequence64PhraseStep(instance, 0);
	return instance;
}

function advanceSequence64PhraseInstances(instances) {
	for (var index = 0; index < instances.length; index++) {
		var instance = instances[index];
		var workspace = ensureEditorWorkspaceDefaults();
		if (workspace.phraseInstances64[instance.instanceKey] !== instance) continue;
		var absoluteStep = sequence64ScaledStepAtClock(instance.startClock,
			instance.rateNumerator, instance.rateDenominator, sequence64ClockPosition);
		var finalStep = Math.min(absoluteStep, instance.totalLength - 1);
		for (var flatStep = instance.lastFlat + 1; flatStep <= finalStep; flatStep++) {
			runSequence64PhraseStep(instance, flatStep);
		}
		if (absoluteStep >= instance.totalLength) {
			finishSequence64Phrase(instance, "complete", false);
		}
	}
}

function runSequence64StepForTarget(targetType, targetId, pattern, barIndex, stepIndex, absoluteStep) {
	if (!rtaEnabled()) return false;
	if (!pattern || !pattern.running) return 0;
	if (targetType === "group" && sequence64NativeGroups[targetId]) return 0;
	var targetKey = editorTargetKey(targetType, targetId);
	releaseSequence64MomentaryProperties(targetKey, sequence64ShapeRampMs());
	var bar = pattern.bars[barIndex];
	var step = bar ? bar.steps[stepIndex] : null;
	// Capture the incoming knob's destination without moving musical trigger
	// timing into the adapter's low-priority 33ms batching task.
	var knobWorkspace = s.editorWorkspace;
	if (knobFocusSource === "grid" && sequence64InspectorLiveWrite && sequence64PressedStep < 0 && knobWorkspace &&
		knobWorkspace.active && knobWorkspace.targetType === targetType && knobWorkspace.targetId === targetId) {
		var knobTrack = sequence64TargetTrackIndex(targetType, targetId, step);
		if (knobRuntime.track !== knobTrack) knobInvalidateInput();
		knobRuntime.track = knobTrack;
		knobRuntime.live = true; knobRuntime.bar = barIndex; knobRuntime.step = stepIndex;
	}
	var flat = sequence64FlatForLocation(pattern, barIndex, stepIndex);
	var logicalStep = isFinite(parseInt(absoluteStep, 10)) ? parseInt(absoluteStep, 10) : flat;
	var conditionVisit = sequence64ConditionVisit(pattern, logicalStep);
	if (!step || (!step.cut && !sequence64StepHasLocks(step))) return 0;
	if (!sequence64StepDecisionPass(targetType, targetId, barIndex, stepIndex,
		step, conditionVisit)) {
		var decisionOutcome = sequence64DecisionOutcomeAt(targetType, targetId,
			barIndex, stepIndex);
		diagnosticEventRateLimited("sequence64_decision_skip",
			editorTargetKey(targetType, targetId) + ":" + flat, function () { return {
				targetType: targetType,
				target: targetId + 1,
				step: flat + 1,
				condition: step.condition,
				visit: conditionVisit,
				outcome: decisionOutcome
			}; });
		return 0;
	}
	var trackIdx = sequence64TargetTrackIndex(targetType, targetId, step);
	for (var parameter in step.locks) {
		applySequence64StepLockForTarget(targetType, targetId, parameter,
			step.locks[parameter], step, trackIdx);
	}
	if (step.cut) {
		if (trackIdx < 0) {
			outlet(2, "editor_waiting_for_track", targetType, targetId + 1);
		} else {
			var slice = step.locks.slice ? step.locks.slice.value : step.cut.slice;
			var instrumentOverrides = sequence64InstrumentStepOverrides(trackIdx, step);
			pattern.lastTriggeredTrack = trackIdx;
			pattern.lastTriggeredChannel = trackChannelIndex(trackIdx);
			pulseSequence64RunKey(targetType, targetId);
			if (targetType === "group" &&
				sequence64PatternHasContent(sequence64PlaybackPattern("track", trackIdx))) {
				launchSequence64TrackPhrase(trackIdx, slice, targetKey, targetKey, false,
					conditionVisit, instrumentOverrides);
			} else {
				sequence64PlaybackCaptureGuard = {
					track: trackIdx,
					slice: slice,
					expiresTick: (s.automation.tick || 0) + 1
				};
				triggerEditorTrack(trackIdx, slice, targetKey, instrumentOverrides);
			}
		}
	}
	return 1;
}

function runSequence64Step(barIndex, stepIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	return runSequence64StepForTarget(workspace.targetType, workspace.targetId,
		currentSequence64Pattern(), barIndex, stepIndex);
}

function advanceSequence64ClockSubstep() {
	if (!rtaEnabled()) return false;
	if (!s.globalTransportRunning) return 0;
	sequence64ClockPosition++;
	commitPendingSceneLaunch();
	var workspace = ensureEditorWorkspaceDefaults();
	advanceSequence64Shapes();
	var existingPhraseInstances = [];
	for (var phraseKey in workspace.phraseInstances64) {
		if (workspace.phraseInstances64[phraseKey]) {
			existingPhraseInstances.push(workspace.phraseInstances64[phraseKey]);
		}
	}
	var fired = 0;
	for (var key in workspace.patterns64) {
		var pattern = workspace.patterns64[key];
		if (!pattern || !pattern.running || key.indexOf("group:") !== 0) continue;
		var parts = key.split(":");
		if (parts.length !== 2) continue;
		var targetType = parts[0];
		var targetId = parseInt(parts[1], 10);
		pattern = sequence64PlaybackPattern(targetType, targetId);
		var absoluteStep = sequence64PatternAbsoluteStep(pattern, sequence64ClockPosition);
		var lastAbsolute = parseInt(pattern.lastSequencedAbsolute, 10);
		if (!isFinite(lastAbsolute) || lastAbsolute < -1) lastAbsolute = absoluteStep - 1;
		if (lastAbsolute === absoluteStep) continue;
		if (absoluteStep < lastAbsolute) lastAbsolute = absoluteStep - 1;
		var playback = null;
		for (var logicalStep = lastAbsolute + 1; logicalStep <= absoluteStep; logicalStep++) {
			playback = sequence64PatternLocationAtFlat(pattern, logicalStep);
			fired += runSequence64StepForTarget(targetType, targetId, pattern,
				playback.bar, playback.step, logicalStep);
		}
		pattern.lastSequencedAbsolute = absoluteStep;
		if (!playback) playback = sequence64PatternLocationAtFlat(pattern, absoluteStep);
		pattern.lastSequencedFlat = playback.flat;
		if (workspace.active && workspace.targetType === targetType &&
			workspace.targetId === targetId) {
			workspace.lastSequencedStep = playback.step;
			workspace.lastSequencedBar = playback.bar;
		}
	}
	advanceSequence64PhraseInstances(existingPhraseInstances);
	if (!sequence64HasPlaybackActivity()) {
		stopSequence64Transport("sequence64_idle");
	}
	if (workspace.active) queuePlaybackDisplay(true);
	return fired;
}

function sequence64SubPulse() {
	if (!sequence64LayoutEnabled()) return 0;
	return advanceSequence64ClockSubstep();
}

function updateEditorClock() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (sequence64LayoutEnabled()) return 0;
	if (!editorWorkspaceAvailable() || !workspace.active || workspace.choosing) return 0;
	var nextStep = currentEditorClockStep();
	if (workspace.lastSequencedStep === nextStep) return 0;
	workspace.lastSequencedStep = nextStep;
	var automationEventCount = runEditorAutomationStep(nextStep);
	applyEditorGateFxStep(nextStep);
	runEditorTriggerStep(nextStep);
	if (automationEventCount || workspace.editorId === "step" || workspace.editorId === "automation") {
		return redrawEditorShellDiff();
	}
	return 0;
}

function handleEditorStepPageKey(col, row) {
	if (row === EDITOR_STEP_ROW) toggleEditorStep(col);
	else if (row === 10 && col === 0) {
		setCurrentEditorSequenceEnabled(!currentEditorSequenceEnabled());
		redrawEditorShellDiff();
	} else if (row === 10 && col === 15) clearEditorStepPattern();
}

function handleEditorLoopPageKey(col, row) {
	var trackIdx = currentEditorTrackIndex();
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	var start = clamp(Math.floor(normalizeLoopPoint(trackState.loopStart, 0)), 0, 15);
	var end = clamp(Math.ceil(normalizeLoopPoint(trackState.loopEnd, 16)), 1, 16);
	if (end <= start) end = Math.min(16, start + 1);
	if (row === 9) {
		start = Math.min(col, end - 1);
		setEditorLoopState(trackIdx, start, end, true);
	} else if (row === 10) {
		end = Math.max(col + 1, start + 1);
		setEditorLoopState(trackIdx, start, end, true);
	} else if (row === 11 && col === 0) {
		setEditorLoopState(trackIdx, start, end, !trackState.loopActive);
	} else if (row === 11 && col === 15) {
		setEditorLoopState(trackIdx, 0, 16, false);
	} else if (row === 12 && col < TRACK_SUB_LOOP_OPTIONS.length) {
		setEditorSubLoopDivision(trackIdx, TRACK_SUB_LOOP_OPTIONS[col]);
	} else if (row === 13 && col === trackChannelIndex(trackIdx)) {
		var channelIdx = trackChannelIndex(trackIdx);
		setEditorChannelLatch(channelIdx, !getChannelStateByIndex(channelIdx).gateLatch);
	}
	redrawEditorShellDiff();
}

function handleEditorParameterPageKey(col, row) {
	var workspace = ensureEditorWorkspaceDefaults();
	var trackIdx = currentEditorTrackIndex();
	var trackState = getTrackStateByIndex(trackIdx);
	var channelIdx = currentEditorChannelIndex();
	var channelState = getChannelStateByIndex(channelIdx);
	if (row === 8 && workspace.targetType === "track" && trackState && col < 8) {
		setEditorTrackGroup(trackIdx, col);
	} else if (row === 9 && channelState) {
		setEditorVolume(channelIdx, Math.round(col * 158 / 15));
	} else if (row === 10 && trackState && col < 7) {
		setEditorOctave(trackIdx, col - 3);
	} else if (row === 11 && col === 0 && trackState) {
		setEditorReverse(trackIdx, !trackState.reverse);
	} else if (row === 12 && col === 0 && trackState) {
		setEditorRandomOffset(trackIdx, !trackState.randomOffset);
	} else if (row === 13 && col === 0 && channelState) {
		setEditorTimestretch(channelIdx, !channelState.timestretch);
	} else if (row === 14 && col === 0 && channelState) {
		setEditorMute(channelIdx, !channelState.muted);
	}
	redrawEditorShellDiff();
}

function deleteEditorAutomationCategory(step, category) {
	var automation = currentEditorAutomation();
	if (!automation || !automation.events[step]) return;
	if (category === undefined) automation.events[step] = [];
	else {
		for (var i = automation.events[step].length - 1; i >= 0; i--) {
			if (editorAutomationEventCategory(automation.events[step][i].type) === category) {
				automation.events[step].splice(i, 1);
			}
		}
	}
}

function clearCurrentEditorAutomation() {
	var automation = currentEditorAutomation();
	if (!automation) return;
	for (var step = 0; step < 16; step++) automation.events[step] = [];
	automation.recording = 0;
	automation.playing = 0;
	outlet(2, "editor_automation_cleared");
}

function handleEditorAutomationPageKey(col, row) {
	var automation = currentEditorAutomation();
	if (!automation) return;
	if (row === 8) deleteEditorAutomationCategory(col);
	else if (row === 9 && col === 0) automation.recording = automation.recording ? 0 : 1;
	else if (row === 9 && col === 1) automation.playing = editorAutomationHasEvents(automation) && !automation.playing ? 1 : 0;
	else if (row === 9 && col === 15) clearCurrentEditorAutomation();
	else if (row >= 10 && row <= 14) deleteEditorAutomationCategory(col, row - 10);
	outlet(2, "editor_automation", automation.recording, automation.playing);
	redrawEditorShellDiff();
}

function handleEditorValuePageKey(row, col, values, statusName) {
	if (!values || row < EDITOR_FIRST_ROW || row > EDITOR_CONTENT_LAST_ROW) return;
	values[col] = EDITOR_VALUE_LEVELS[row - EDITOR_FIRST_ROW];
	var workspace = ensureEditorWorkspaceDefaults();
	outlet(2, statusName, workspace.targetType, workspace.targetId + 1, col + 1, values[col]);
	redrawEditorShellDiff();
}

function handleEditorFxPageKey(col, row) {
	var levels = currentEditorGateFxLevels();
	if (!levels) return;
	if (row >= EDITOR_FIRST_ROW && row < 14) {
		levels[col] = EDITOR_FX_LEVELS[row - EDITOR_FIRST_ROW];
		var workspace = ensureEditorWorkspaceDefaults();
		outlet(2, "editor_fx", workspace.targetType, workspace.targetId + 1,
			col + 1, levels[col]);
	} else if (row === 14 && col === 0) {
		setCurrentEditorGateFxEnabled(!currentEditorGateFxEnabled());
	} else if (row === 14 && col === 15) {
		for (var step = 0; step < 16; step++) levels[step] = 15;
		setCurrentEditorGateFxEnabled(false);
		outlet(2, "editor_fx_cleared");
	}
	applyEditorGateFxStep(currentEditorClockStep());
	redrawEditorShellDiff();
}

function sequence64DefaultCutForStep(stepIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	var remembered = pattern ? pattern.lastUsedTrack : -1;
	return {
		track: workspace.targetType === "track" ? workspace.targetId :
			sequence64TrackBelongsToGroup(remembered, workspace.targetId) ? remembered : -1,
		// A manually added trigger should be immediately useful in the compact
		// Scene editor, where the Slice lane is not visible. Live-recorded and
		// explicitly locked cuts still retain their captured/chosen slice.
		slice: 0,
		gateLength: 1
	};
}

function toggleSequence64Step(stepIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern || stepIndex < 0 || stepIndex >= 64) return;
	var step = currentSequence64EditBar(pattern).steps[stepIndex];
	if (step.cut) step.cut = null;
	else step.cut = sequence64DefaultCutForStep(stepIndex);
	outlet(2, "editor_step", workspace.targetType, workspace.targetId + 1,
		stepIndex + 1, step.cut ? 1 : 0);
	markSessionDirty("ṛta step");
	redrawEditorShellDiff();
}

function clearSequence64Step(stepIndex) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	var bar = currentSequence64EditBar(pattern);
	if (!bar || stepIndex < 0 || stepIndex >= bar.length) return false;
	bar.steps[stepIndex] = createSequence64Step();
	sequence64PressedStep = -1;
	sequence64PressedStepWasEmpty = false;
	sequence64SelectedStep = stepIndex;
	workspace.editCursors64[editorTargetKey(workspace.targetType, workspace.targetId)] = stepIndex;
	clearSequence64Decision(workspace.targetType, workspace.targetId);
	outlet(2, "editor_step_deleted", workspace.targetType, workspace.targetId + 1,
		stepIndex + 1);
	markSessionDirty("ṛta step delete");
	redrawEditorShellDiff();
	return true;
}

function toggleSelectedSequence64Trigger() {
	var workspace = ensureEditorWorkspaceDefaults();
	var stepIndex = currentSequence64EditStepIndex();
	var step = currentSequence64EditStep();
	if (!step) return false;
	if (step.cut) step.cut = null;
	else step.cut = sequence64DefaultCutForStep(stepIndex);
	outlet(2, "editor_trigger", workspace.targetType, workspace.targetId + 1,
		stepIndex + 1, step.cut ? 1 : 0);
	markSessionDirty("ṛta trigger");
	redrawEditorShellDiff();
	return true;
}

function closeSequence64StepEditor() {
	sequence64StepHoldTask.cancel();
	sequence64ModMatrixHoldTask.cancel();
	sequence64ModMatrixActive = false;
	sequence64ModParameterPress = -1;
	sequence64PressedStep = -1;
	sequence64StepHoldOpened = false;
	sequence64HeldStep = -1;
	sequence64HeldStepChanged = false;
	outlet(2, "editor_step_editor", 0);
	redrawEditorShellDiff();
}

function openSequence64ModMatrixAfterHold() {
	if (sequence64HeldStep < 0 || sequence64EditParameter !== "filter" ||
		sequence64ModParameterPress < 0) return false;
	sequence64ModMatrixActive = true;
	sequence64ModParameterPress = -1;
	outlet(2, "editor_modulation_matrix", 1, "filter");
	publishHud("notice", "info", "Filter modulation matrix");
	redrawEditorShellDiff();
	return true;
}

function closeSequence64ModMatrix() {
	sequence64ModMatrixHoldTask.cancel();
	sequence64ModMatrixActive = false;
	sequence64ModParameterPress = -1;
	outlet(2, "editor_modulation_matrix", 0, "filter");
	redrawEditorShellDiff();
}

function setCurrentModulationSourceSettings(changes) {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = Modulation.sourceKey(workspace.targetType, workspace.targetId,
		sequence64ModSource);
	var settings = workspace.modulation.sources[key] || Modulation.defaultSource(sequence64ModSource);
	var updated = JSON.parse(JSON.stringify(settings));
	for (var name in changes) updated[name] = changes[name];
	workspace.modulation = Modulation.setSource(workspace.modulation,
		workspace.targetType, workspace.targetId, sequence64ModSource, updated);
	applyNativeModulationTarget(workspace.targetType, workspace.targetId);
	publishHudModulationState();
	markSessionDirty("modulation source");
}

function handleSequence64ModMatrixKey(col, row, state) {
	if (state !== 1) return true;
	var workspace = ensureEditorWorkspaceDefaults();
	if (row === 8 && col < Modulation.SOURCE_IDS.length) {
		sequence64ModSource = Modulation.SOURCE_IDS[col];
	} else if (row === 9) {
		var route = currentSequence64ModulationRoute();
		var amount = modulationAmountAtColumn(col);
		if (route && route.enabled && Math.abs(route.amount - amount) < 0.0001) {
			modulationClear(workspace.targetType, workspace.targetId, "filter", sequence64ModSource);
		} else {
			modulationRoute(workspace.targetType, workspace.targetId, "filter",
				sequence64ModSource, amount, 1);
		}
	} else if (row === 10 && col < MODULATION_RATE_CHOICES.length &&
		(sequence64ModSource === "lfo1" || sequence64ModSource === "lfo2")) {
		setCurrentModulationSourceSettings({ rate: MODULATION_RATE_CHOICES[col].slice() });
	} else if (row === 11 && col < 4 &&
		(sequence64ModSource === "lfo1" || sequence64ModSource === "lfo2")) {
		if (col < 2) setCurrentModulationSourceSettings({
			polarity: col === 0 ? "bipolar" : "unipolar"
		});
		else setCurrentModulationSourceSettings({ reset: col === 2 ? "free" : "transport" });
	} else if ((row === SEQUENCE64_TOOLS_ROW || row === SEQUENCE64_NAV_ROW) && col === 15) {
		closeSequence64ModMatrix();
		return true;
	}
	redrawEditorShellDiff();
	return true;
}

function openSequence64StepEditorAfterHold() {
	if (sequence64PressedStep < 0) return false;
	selectSequence64EditStep(sequence64PressedStep);
	sequence64StepHoldOpened = true;
	sequence64HeldStepChanged = false;
	outlet(2, "editor_step_editor", 1, sequence64SelectedStep + 1);
	redrawEditorShellDiff();
	publishHudEditorState();
	publishHudCurrentPattern();
	return true;
}

function handleSequence64StepKey(stepIndex, state) {
	var pattern = currentSequence64Pattern();
	var bar = currentSequence64EditBar(pattern);
	if (!bar || stepIndex < 0 || stepIndex >= bar.length) return true;
	if (knobFocusSource === "grid") knobInvalidateInput();

	if (state === 1) {
		if (sequence64DeleteHeld) return clearSequence64Step(stepIndex);
		sequence64StepHoldTask.cancel();
		sequence64PressedStep = stepIndex;
		sequence64PressedStepWasEmpty = !bar.steps[stepIndex].cut;
		sequence64StepHoldOpened = false;
		selectSequence64EditStep(stepIndex);
		redrawEditorShellDiff();
		return true;
	}

	if (sequence64PressedStep !== stepIndex) return true;
	sequence64StepHoldTask.cancel();
	sequence64PressedStep = -1;
	sequence64StepHoldOpened = false;
	if (sequence64PressedStepWasEmpty) toggleSequence64Step(stepIndex);
	else redrawEditorShellDiff();
	sequence64PressedStepWasEmpty = false;
	return true;
}

function instrumentParameterRange(id) {
	var descriptor = instrumentDescriptorForParameter(id);
	return descriptor ? instrumentMappingRange(id, (s[descriptor.rangeKey] || {})[id]) : null;
}

// Lab mapping only: does not rescale stored physical locks or change the sound.
function instrumentRange(id, minimum, maximum) {
	var descriptor = instrumentDescriptorForParameter(id);
	if (!descriptor) return false;
	var lo = Number(minimum), hi = Number(maximum);
	var def = instrumentDefinition(id);
	if (!isFinite(lo) || !isFinite(hi) || lo < def.min || hi > def.max || lo >= hi) return false;
	if (!s[descriptor.rangeKey]) s[descriptor.rangeKey] = {};
	s[descriptor.rangeKey][id] = {min:lo,max:hi};
	redrawEditorShellDiff();
	return true;
}

function kickParameterRange(id) { return instrumentParameterRange(id); }
function kickRange(id, minimum, maximum) { return instrumentRange(id, minimum, maximum); }
function tomParameterRange(id) { return instrumentParameterRange(id); }
function tomRange(id, lo, hi) { return instrumentRange(id, lo, hi); }
function tomSync() { syncInstrument(TomInstruments.TOM_TRACK); }
function tomManual(name, value) { var id=TomInstruments.idForRNBO(String(name)); if(id) instrumentManual(11, id, value); }
function rimParameterRange(id) { return instrumentParameterRange(id); }
function rimRange(id, lo, hi) { return instrumentRange(id, lo, hi); }
function rimSync() { syncInstrument(RimInstruments.RIM_TRACK); }
function rimManual(name, value) { var id=RimInstruments.idForRNBO(String(name)); if(id) instrumentManual(10, id, value); }
function bellParameterRange(id) { return instrumentParameterRange(id); }
function bellRange(id, lo, hi) { return instrumentRange(id, lo, hi); }
function bellSync() { syncInstrument(BellInstruments.BELL_TRACK); }
function bellManual(name, value) { var id=BellInstruments.idForRNBO(String(name)); if(id) instrumentManual(9, id, value); }
function bassParameterRange(id) { return instrumentParameterRange(id); }
function bassRange(id, lo, hi) { return instrumentRange(id, lo, hi); }
function bassSync() { syncInstrument(BassInstruments.BASS_TRACK); }
function bassManual(name, value) { var id=BassInstruments.idForRNBO(String(name)); if(id) instrumentManual(8, id, value); }

function clapParameterRange(id) { return instrumentParameterRange(id); }
function clapRange(id, minimum, maximum) { return instrumentRange(id, minimum, maximum); }
function clapSync() { syncInstrument(ClapInstruments.CLAP_TRACK); }
function clapManual(name, value) {
	var id = ClapInstruments.idForRNBO(String(name));
	if (id) instrumentManual(12, id, value);
}

function hatParameterRange(id) { return instrumentParameterRange(id); }
function hatRange(id, minimum, maximum) { return instrumentRange(id, minimum, maximum); }
function hatSync() { syncInstrument(HatInstruments.HAT_TRACK); }
function hatManual(name, value) {
	var id = HatInstruments.idForRNBO(String(name));
	if (id) instrumentManual(13, id, value);
}

function snareParameterRange(id) { return instrumentParameterRange(id); }
function snareRange(id, minimum, maximum) { return instrumentRange(id, minimum, maximum); }

function sequence64InstrumentEditStep() {
	var pattern = currentSequence64Pattern();
	if (sequence64InspectorLiveWrite || sequence64LockRecordHeld) {
		var pos = currentSequence64PlaybackLocation(pattern);
		return pattern.bars[pos.bar].steps[pos.step];
	}
	return currentSequence64EditStep();
}

function syncInstrument(trackIdx) {
	var descriptor = instrumentDescriptorForTrack(trackIdx);
	if (!descriptor) return;
	descriptor.locks.forEach(function (id) {
		messnamed(descriptor.ownedBus, instrumentDefinition(id).rnbo,
			sequence64CurrentPropertyValue(id, trackChannelIndex(trackIdx), trackIdx));
	});
}

function kickSync() {
	if (!Product.rta) return false; syncInstrument(Instruments.KICK_TRACK); }
function snareSync() {
	if (!Product.rta) return false; syncInstrument(SnareInstruments.SNARE_TRACK); }

function kickManual(name, value) {
	if (!Product.rta) return false;
	var id = Instruments.idForRNBO(String(name));
	if (id) instrumentManual(15, id, value);
}

function snareManual(name, value) {
	if (!Product.rta) return false;
	var id = SnareInstruments.idForRNBO(String(name));
	if (id) instrumentManual(14, id, value);
}

// Human track number and physical units; future controller adapters use this too.
function instrumentManual(trackNumber, id, value, allowLockRecording, controllerEdit) {
	var trackIdx = parseInt(trackNumber, 10) - 1;
	var descriptor = instrumentDescriptorForTrack(trackIdx);
	if (!descriptor || instrumentDescriptorForParameter(id) !== descriptor) return false;
	var track = getTrackStateByIndex(trackIdx);
	track.instrumentParameters = instrumentSanitize(trackIdx, track.instrumentParameters);
	value = instrumentClampValue(id, value);
	track.instrumentParameters[id] = value;
	var stack = ensureEditorWorkspaceDefaults().propertyStacks64[sequence64TrackPropertyKey(trackIdx, id)];
	if (stack) stack.baseValue = value;
	if (allowLockRecording !== false && sequence64InstrumentTarget(sequence64InstrumentEditStep()) === descriptor &&
		(sequence64InspectorLiveWrite || sequence64LockRecordHeld)) {
		if (sequence64LockRecordHeld) recordSequence64SetupLock(id, value);
		else sequence64SetInstrumentValue(id, value);
	}
	if (controllerEdit) messnamed(descriptor.ownedBus, instrumentDefinition(id).rnbo,
		sequence64CurrentPropertyValue(id, trackChannelIndex(trackIdx), trackIdx));
	else syncInstrument(trackIdx);
	writeThroughActiveTrackSlot(trackIdx, descriptor.id + " baseline", controllerEdit ? false : undefined);
	markSessionDirty(descriptor.id + " baseline");
	if (!controllerEdit) redrawEditorShellDiff();
	return true;
}

function sequence64SetInstrumentValue(id, value) {
	var descriptor = sequence64InstrumentTarget(sequence64InstrumentEditStep());
	if (!descriptor || instrumentDescriptorForParameter(id) !== descriptor) return;
	value = instrumentClampValue(id, value);
	if (sequence64InstrumentBaseEdit && !sequence64InspectorLiveWrite) {
		instrumentManual(descriptor.track + 1, id, value);
	} else {
		var pattern = currentSequence64Pattern();
		if (!pattern) return;
		var bar = currentSequence64EditBar(pattern);
		var index = currentSequence64EditStepIndex();
		if (sequence64InspectorLiveWrite) {
			var playback = currentSequence64PlaybackLocation(pattern);
			bar = pattern.bars[playback.bar]; index = playback.step;
		}
		storeSequence64InstrumentLock(descriptor, id, value, bar, index);
	}
	var def = instrumentDefinition(id);
	publishHud("notice", "info", descriptor.name + " " + def.name + ": " + (Math.round(value * 100) / 100) + " " + def.unit +
		(sequence64InstrumentBaseEdit ? " · baseline" : " · step lock"));
	redrawEditorShellDiff();
}

function storeSequence64InstrumentLock(descriptor, id, value, bar, index) {
	bar.steps[index].locks[id] = { value: value, behavior: "set" };
	markSessionDirty(descriptor.id + " lock");
	sequence64HeldStepChanged = true;
	var workspace = ensureEditorWorkspaceDefaults();
	outlet(2, "editor_lock", workspace.targetType, workspace.targetId + 1, index + 1, id, value);
}

function sequence64InstrumentFine(delta) {
	var id = sequence64EditParameter;
	var def = instrumentDefinition(id);
	if (!def) return;
	var step = currentSequence64EditStep();
	if (sequence64InspectorLiveWrite) {
		var pattern = currentSequence64Pattern();
		var playback = currentSequence64PlaybackLocation(pattern);
		step = pattern.bars[playback.bar].steps[playback.step];
	}
	var lock = step && step.locks[id];
	var descriptor = sequence64InstrumentTarget(step);
	if (!descriptor || instrumentDescriptorForParameter(id) !== descriptor) return;
	var value = !sequence64InstrumentBaseEdit && lock ? lock.value :
		instrumentSanitize(descriptor.track,getTrackStateByIndex(descriptor.track).instrumentParameters)[id];
	var range = instrumentParameterRange(id);
	sequence64SetInstrumentValue(id, clamp(value + delta * def.fine, range.min, range.max));
}

function sequence64SetLockValue(parameter, column) {
	if (instrumentDefinition(parameter)) {
		sequence64SetInstrumentValue(parameter, instrumentFromNormalized(parameter, column / 15, instrumentParameterRange(parameter)));
		return;
	}
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern || sequence64SelectedStep < 0) return;
	var editStepIndex = currentSequence64EditStepIndex();
	var editBar = currentSequence64EditBar(pattern);
	if (sequence64InspectorLiveWrite) {
		var playback = currentSequence64PlaybackLocation(pattern);
		editBar = pattern.bars[playback.bar];
		editStepIndex = playback.step;
	}
	var step = editBar.steps[editStepIndex];
	if (parameter === "transpose") {
		var pitchLock = ensureSequence64TransposeLock(step);
		if (column < SEQUENCE64_TRANSPOSE_FIRST_COL) {
			pitchLock.pitchOctave = clamp(pitchLock.pitchOctave +
				(column === 0 ? -1 : 1), -8, 8);
		} else {
			pitchLock.pitchSemitone = clamp(column - 8,
				SEQUENCE64_TRANSPOSE_MIN, SEQUENCE64_TRANSPOSE_MAX);
		}
		updateSequence64TransposeLock(pitchLock);
		sequence64HeldStepChanged = true;
		outlet(2, "editor_lock", workspace.targetType, workspace.targetId + 1,
			editStepIndex + 1, parameter, sequence64LockValueColumn(parameter, step) + 1,
			pitchLock.pitchOctave, pitchLock.pitchSemitone, pitchLock.value);
		markSessionDirty("ṛta lock");
		redrawEditorShellDiff();
		return;
	}
	sequence64HeldStepChanged = true;
	if (parameter === "probability") {
		step.probability = clamp(column, 0, 15);
	} else if (parameter === "condition") {
		step.condition = column < 8 ? column + 2 : -(column - 6);
	} else if (parameter === "gateLength") {
		if (!step.cut) step.cut = sequence64DefaultCutForStep(editStepIndex);
		step.cut.gateLength = clamp(column + 1, 1, 16);
	} else if (parameter === "track") {
		if (workspace.targetType !== "group" ||
			!sequence64TrackBelongsToGroup(column, workspace.targetId)) return;
		if (!step.cut) step.cut = sequence64DefaultCutForStep(editStepIndex);
		step.cut.track = column;
		rememberSequence64EditTrack(pattern, workspace.targetType, workspace.targetId, column);
	} else {
		var value = column;
		if (parameter === "slice" && !step.cut) {
			step.cut = sequence64DefaultCutForStep(editStepIndex);
		}
		if (parameter === "reverse") value = column >= 8 ? 1 : 0;
		else if (parameter === "loopDivision") value = TRACK_SUB_LOOP_OPTIONS[clamp(column, 0, 7)];
		if (!step.locks[parameter]) step.locks[parameter] = { value: value, behavior: "set" };
		else step.locks[parameter].value = value;
	}
	outlet(2, "editor_lock", workspace.targetType, workspace.targetId + 1,
		editStepIndex + 1, parameter, sequence64LockValueColumn(parameter, step) + 1);
	markSessionDirty("ṛta lock");
	redrawEditorShellDiff();
}

function sequence64ClearSelectedLock() {
	var pattern = currentSequence64Pattern();
	if (!pattern || sequence64SelectedStep < 0) return;
	var editStepIndex = currentSequence64EditStepIndex();
	var step = currentSequence64EditBar(pattern).steps[editStepIndex];
	if (sequence64EditParameter === "probability") step.probability = 15;
	else if (sequence64EditParameter === "condition") step.condition = 0;
	else if (sequence64EditParameter === "gateLength") {
		if (step.cut) step.cut.gateLength = 1;
	} else if (sequence64EditParameter === "track") {
		if (step.cut) step.cut.track = -1;
	} else delete step.locks[sequence64EditParameter];
	sequence64HeldStepChanged = true;
	outlet(2, "editor_lock_cleared", editStepIndex + 1, sequence64EditParameter);
	markSessionDirty("ṛta lock");
	redrawEditorShellDiff();
}

function sequence64SetBehavior(column) {
	if (column < 0 || column >= SEQUENCE64_BEHAVIORS.length) return;
	if (sequence64EditParameter !== "volume" && sequence64EditParameter !== "filter") return;
	var pattern = currentSequence64Pattern();
	if (!pattern || sequence64SelectedStep < 0) return;
	var editStepIndex = currentSequence64EditStepIndex();
	var step = currentSequence64EditBar(pattern).steps[editStepIndex];
	var values = currentSequence64ParameterValues();
	if (!step.locks[sequence64EditParameter]) {
		step.locks[sequence64EditParameter] = {
			value: values ? values[sequence64EditParameter] : 15,
			behavior: SEQUENCE64_BEHAVIORS[column]
		};
	} else step.locks[sequence64EditParameter].behavior = SEQUENCE64_BEHAVIORS[column];
	sequence64HeldStepChanged = true;
	outlet(2, "editor_shape", editStepIndex + 1,
		sequence64EditParameter, SEQUENCE64_BEHAVIORS[column]);
	markSessionDirty("ṛta shape");
	redrawEditorShellDiff();
}

function clearCurrentSequence64Pattern() {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern) return;
	stopSequence64Target(workspace.targetType, workspace.targetId, "pattern_clear");
	var bar = currentSequence64EditBar(pattern);
	for (var i = 0; i < 64; i++) bar.steps[i] = createSequence64Step();
	sequence64ClearArmedUntil = 0;
	outlet(2, "editor_steps_cleared", workspace.targetType, workspace.targetId + 1,
		pattern.currentBar + 1);
	markSessionDirty("ṛta pattern clear");
	redrawEditorShellDiff();
}

function armOrClearSequence64Pattern() {
	var now = Date.now();
	if (sequence64ClearArmedUntil > now) clearCurrentSequence64Pattern();
	else {
		sequence64ClearArmedUntil = now + 1200;
		outlet(2, "editor_clear_armed");
		redrawEditorShellDiff();
	}
}

function selectSequence64Bar(barIndex) {
	var pattern = currentSequence64Pattern();
	if (!pattern) return;
	pattern.currentBar = clamp(parseInt(barIndex, 10) || 0, 0, pattern.bars.length - 1);
	sequence64HeldStep = -1;
	selectSequence64EditStep(sequence64SelectedStep < 0 ? 0 : sequence64SelectedStep);
	sequence64HeldStepChanged = false;
	sequence64PressedStep = -1;
	sequence64StepHoldOpened = false;
	sequence64PendingLengthIndex = -1;
	sequence64PendingBarIndex = -1;
	sequence64BarHoldCommitted = false;
	sequence64StepHoldTask.cancel();
	sequence64LengthHoldTask.cancel();
	sequence64BarHoldTask.cancel();
	sequence64RemoveBarArmedUntil = 0;
	outlet(2, "editor_bar", pattern.currentBar + 1, pattern.bars.length);
	redrawEditorShellDiff();
}

function addSequence64Bar() {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern || pattern.bars.length >= SEQUENCE64_MAX_BARS) return false;
	var previous = captureSequence64StructurePosition(pattern,
		workspace.targetType, workspace.targetId);
	var restoredBar = pattern.parkedBars && pattern.parkedBars.length ?
		pattern.parkedBars.shift() : null;
	pattern.bars.push(normalizeSequence64Bar(restoredBar, null, 64));
	pattern.currentBar = pattern.bars.length - 1;
	reconcileSequence64StructurePosition(workspace.targetType, workspace.targetId,
		pattern, previous, "bar_add");
	sequence64RemoveBarArmedUntil = 0;
	outlet(2, "editor_bar_added", pattern.currentBar + 1, pattern.bars.length);
	markSessionDirty("ṛta bars");
	redrawEditorShellDiff();
	return true;
}

function setSequence64BarCount(barCount) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern) return false;
	var requested = clamp(parseInt(barCount, 10) || 1, 1, SEQUENCE64_MAX_BARS);
	if (!pattern.parkedBars || !Array.isArray(pattern.parkedBars)) pattern.parkedBars = [];
	var changed = requested !== pattern.bars.length;
	var previous = changed ? captureSequence64StructurePosition(pattern,
		workspace.targetType, workspace.targetId) : null;

	if (requested < pattern.bars.length) {
		var parked = pattern.bars.splice(requested);
		pattern.parkedBars = parked.concat(pattern.parkedBars);
	} else {
		while (pattern.bars.length < requested) {
			var restored = pattern.parkedBars.length ? pattern.parkedBars.shift() : null;
			pattern.bars.push(normalizeSequence64Bar(restored, null, 64));
		}
	}

	pattern.currentBar = requested - 1;
	pattern.steps = pattern.bars[0].steps;
	pattern.length = pattern.bars[0].length;
	if (changed) {
		reconcileSequence64StructurePosition(workspace.targetType, workspace.targetId,
			pattern, previous, "bar_count");
		markSessionDirty("ṛta bars");
	}
	sequence64RemoveBarArmedUntil = 0;
	outlet(2, "editor_bar_count", requested);
	outlet(2, "editor_bar", pattern.currentBar + 1, requested);
	redrawEditorShellDiff();
	return changed;
}

function commitSequence64BarHold() {
	if (sequence64PendingBarIndex < 0 ||
		sequence64PendingBarIndex >= SEQUENCE64_MAX_BARS) return false;
	sequence64BarHoldCommitted = true;
	setSequence64BarCount(sequence64PendingBarIndex + 1);
	return true;
}

function tapSequence64Bar(barIndex) {
	var pattern = currentSequence64Pattern();
	if (!pattern) return false;
	if (barIndex < pattern.bars.length) {
		selectSequence64Bar(barIndex);
		return true;
	}
	if (barIndex === pattern.bars.length) return addSequence64Bar();
	return false;
}

function handleSequence64BarKey(barIndex, state) {
	if (barIndex < 0 || barIndex >= SEQUENCE64_MAX_BARS) return true;
	if (state === 1) {
		sequence64BarHoldTask.cancel();
		sequence64PendingBarIndex = barIndex;
		sequence64BarHoldCommitted = false;
		sequence64BarHoldTask.schedule(SEQUENCE64_HOLD_MS);
		redrawEditorShellDiff();
		return true;
	}
	if (sequence64PendingBarIndex !== barIndex) return true;
	sequence64BarHoldTask.cancel();
	var committed = sequence64BarHoldCommitted;
	sequence64PendingBarIndex = -1;
	sequence64BarHoldCommitted = false;
	if (!committed) tapSequence64Bar(barIndex);
	else redrawEditorShellDiff();
	return true;
}

function removeCurrentSequence64Bar() {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern || pattern.bars.length <= 1) return false;
	var previous = captureSequence64StructurePosition(pattern,
		workspace.targetType, workspace.targetId);
	var removed = pattern.currentBar;
	pattern.bars.splice(removed, 1);
	pattern.currentBar = clamp(removed, 0, pattern.bars.length - 1);
	pattern.steps = pattern.bars[0].steps;
	pattern.length = pattern.bars[0].length;
	reconcileSequence64StructurePosition(workspace.targetType, workspace.targetId,
		pattern, previous, "bar_remove");
	sequence64RemoveBarArmedUntil = 0;
	outlet(2, "editor_bar_removed", removed + 1, pattern.bars.length);
	markSessionDirty("ṛta bars");
	redrawEditorShellDiff();
	return true;
}

function armOrRemoveSequence64Bar() {
	var pattern = currentSequence64Pattern();
	if (!pattern || pattern.bars.length <= 1) return;
	var now = Date.now();
	if (sequence64RemoveBarArmedUntil > now) removeCurrentSequence64Bar();
	else {
		sequence64RemoveBarArmedUntil = now + 1200;
		outlet(2, "editor_bar_remove_armed", pattern.currentBar + 1);
		redrawEditorShellDiff();
	}
}

function setCurrentSequence64BarLength(length) {
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern) return;
	var requestedLength = clamp(parseInt(length, 10) || 1, 1, 64);
	var bar = currentSequence64EditBar(pattern);
	var changed = bar.length !== requestedLength;
	var previous = changed ? captureSequence64StructurePosition(pattern,
		workspace.targetType, workspace.targetId) : null;
	bar.length = requestedLength;
	if (pattern.currentBar === 0) pattern.length = requestedLength;
	if (changed) {
		reconcileSequence64StructurePosition(workspace.targetType, workspace.targetId,
			pattern, previous, "bar_length");
		markSessionDirty("ṛta length");
	}
	outlet(2, "editor_length", pattern.currentBar + 1, requestedLength);
	redrawEditorShellDiff();
}

function commitSequence64LengthHold() {
	if (sequence64PendingLengthIndex < 0 ||
		sequence64PendingLengthIndex >= SEQUENCE64_LENGTHS.length) return false;
	var lengthIndex = sequence64PendingLengthIndex;
	sequence64PendingLengthIndex = -1;
	setCurrentSequence64BarLength(SEQUENCE64_LENGTHS[lengthIndex]);
	return true;
}

function handleSequence64LengthKey(lengthIndex, state) {
	if (lengthIndex < 0 || lengthIndex >= SEQUENCE64_LENGTHS.length) return true;
	if (state === 1) {
		sequence64LengthHoldTask.cancel();
		sequence64PendingLengthIndex = lengthIndex;
		sequence64LengthHoldTask.schedule(SEQUENCE64_HOLD_MS);
		redrawEditorShellDiff();
		return true;
	}
	if (sequence64PendingLengthIndex === lengthIndex) {
		sequence64LengthHoldTask.cancel();
		sequence64PendingLengthIndex = -1;
		redrawEditorShellDiff();
	}
	return true;
}

function recordSequence64SetupLock(parameter, value) {
	if (!sequence64LockRecordHeld) return value;
	var pattern = currentSequence64Pattern();
	if (!pattern) return value;
	var playback = currentSequence64PlaybackLocation(pattern);
	var stepIndex = playback.step;
	var step = pattern.bars[playback.bar].steps[stepIndex];
	if (parameter === "probability") step.probability = clamp(value, 0, 15);
	else if (parameter === "transpose") {
		var pitchLock = ensureSequence64TransposeLock(step);
		pitchLock.pitchSemitone = clamp(parseInt(value, 10) || 0,
			SEQUENCE64_TRANSPOSE_MIN, SEQUENCE64_TRANSPOSE_MAX);
		value = updateSequence64TransposeLock(pitchLock);
	} else step.locks[parameter] = { value: value, behavior: "set" };
	outlet(2, "editor_lock_recorded", stepIndex + 1, parameter, value);
	markSessionDirty("ṛta lock record");
	return value;
}

function recordSequence64SetupPitchOctave(delta) {
	if (!sequence64LockRecordHeld) return null;
	var pattern = currentSequence64Pattern();
	if (!pattern) return null;
	var playback = currentSequence64PlaybackLocation(pattern);
	var step = pattern.bars[playback.bar].steps[playback.step];
	var pitchLock = ensureSequence64TransposeLock(step);
	pitchLock.pitchOctave = clamp(pitchLock.pitchOctave + delta, -8, 8);
	var value = updateSequence64TransposeLock(pitchLock);
	outlet(2, "editor_lock_recorded", playback.step + 1, "transpose", value);
	markSessionDirty("ṛta lock record");
	return value;
}

function recordSequence64LiveLaneCut(trackIdx, slice) {
	if (!sequence64LockRecordHeld && !sequence64InspectorLiveWrite) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var pattern = currentSequence64Pattern();
	if (!pattern) return false;
	var playback = currentSequence64PlaybackLocation(pattern);
	var step = pattern.bars[playback.bar].steps[playback.step];
	var gateLength = step.cut ? step.cut.gateLength : 1;
	delete step.locks.slice;
	step.cut = {
		track: workspace.targetType === "track" ? workspace.targetId : trackIdx,
		slice: slice,
		gateLength: gateLength
	};
	outlet(2, "editor_live_cut", workspace.targetType, workspace.targetId + 1,
		playback.bar + 1, playback.step + 1, trackIdx + 1, slice + 1);
	markSessionDirty("ṛta live cut");
	redrawEditorShellDiff();
	return true;
}

function startSequence64Audition(trackIdx, slice, heldTracks, eventName) {
	if (!rtaEnabled()) return false;
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return false;
	var position = clamp(parseInt(slice, 10) || 0, 0, 15);
	var channelIdx = trackChannelIndex(trackIdx);
	if (heldTracks[position] >= 0) {
		stopSequence64Audition(position, heldTracks, eventName);
	}
	applyNativeModulationGroup(channelIdx, trackIdx);
	modulationTrigger("group", channelIdx, 0);
	modulationTrigger("group", channelIdx, 1);
	cancelSequence64PhraseForChannel(channelIdx, "manual_trigger", false);
	cancelSequence64AudioForChannel(channelIdx);
	var channelState = getChannelStateByIndex(channelIdx);
	trackState.playPos = position;
	trackState.subLoopAnchor = position;
	channelState.activeTrack = trackIdx;
	channelState.sequence64Owner = null;
	primeTrackPlaybackPosition(trackIdx, position);
	emitSequence64PlaybackPing(trackIdx, position);
	heldTracks[position] = trackIdx;
	sendTrackInput(trackIdx, position, 1);
	messnamed((channelIdx + 1) + "[mlr]pl-trig-now", "bang");
	if (channelLatchEnabledForTrack(trackIdx)) reapplyTrackSubLoopAfterTrigger(trackIdx, position);
	else restoreTrackLoop(trackIdx);
	diagnosticEvent(eventName || "slice_audition", function () {
		return diagnosticTrackSnapshot(trackIdx, position);
	});
	outlet(2, "editor_audition", trackIdx + 1, position + 1, 1);
	return true;
}

function stopSequence64Audition(slice, heldTracks, eventName) {
	var position = clamp(parseInt(slice, 10) || 0, 0, 15);
	var trackIdx = heldTracks[position];
	heldTracks[position] = -1;
	if (trackIdx < 0) return false;
	var channelIdx = trackChannelIndex(trackIdx);
	sendTrackInput(trackIdx, position, 0);
	modulationTrigger("group", channelIdx, 0);
	diagnosticEvent((eventName || "slice_audition") + "_release",
		function () { return diagnosticTrackSnapshot(trackIdx, position); });
	outlet(2, "editor_audition", trackIdx + 1, position + 1, 0);
	return true;
}

function stopAllSequence64Auditions() {
	for (var slice = 0; slice < 16; slice++) {
		stopSequence64Audition(slice, sequence64SliceAuditionTracks, "slice_audition");
		stopSequence64Audition(slice, sequence64LiveLaneTracks, "live_lane");
	}
}

function handleSequence64SliceValueKey(col, state) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (state === 0) {
		stopSequence64Audition(col, sequence64SliceAuditionTracks, "slice_audition");
		return true;
	}
	var pattern = currentSequence64Pattern();
	var step = currentSequence64EditStep();
	var trackIdx = -1;
	if (sequence64InspectorLiveWrite && pattern) {
		var playback = currentSequence64PlaybackLocation(pattern);
		step = pattern.bars[playback.bar].steps[playback.step];
		trackIdx = sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, step);
		if (trackIdx >= 0) recordSequence64LiveLaneCut(trackIdx, col);
	} else {
		sequence64SetLockValue("slice", col);
		step = currentSequence64EditStep();
		trackIdx = sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, step);
	}
	if (trackIdx < 0) {
		outlet(2, "editor_waiting_for_track", workspace.targetType, workspace.targetId + 1);
		return true;
	}
	startSequence64Audition(trackIdx, col, sequence64SliceAuditionTracks, "slice_audition");
	redrawEditorShellDiff();
	return true;
}

function handleSequence64LiveLaneKey(col, state) {
	var workspace = ensureEditorWorkspaceDefaults();
	var trackIdx = state === 1 ?
		sequence64TargetTrackIndex(workspace.targetType, workspace.targetId, null) :
		sequence64LiveLaneTracks[col];
	if (state === 1) sequence64LiveLaneTracks[col] = trackIdx;
	else sequence64LiveLaneTracks[col] = -1;
	if (trackIdx < 0) {
		if (state === 1) {
			outlet(2, "editor_waiting_for_track", workspace.targetType, workspace.targetId + 1);
		}
		return true;
	}
	if (state === 1) {
		recordSequence64LiveLaneCut(trackIdx, col);
		startSequence64Audition(trackIdx, col, sequence64LiveLaneTracks, "live_lane");
		redrawEditorShellDiff();
	} else {
		stopSequence64Audition(col, sequence64LiveLaneTracks, "live_lane");
	}
	return true;
}

function handleSequence64SetupKey(col, row, state) {
	if (state !== 1) return true;
	var workspace = ensureEditorWorkspaceDefaults();
	var trackIdx = currentEditorTrackIndex();
	var trackState = getTrackStateByIndex(trackIdx);
	var channelIdx = currentEditorChannelIndex();
	var channelState = getChannelStateByIndex(channelIdx);
	if (row === 8 && workspace.targetType === "track" && trackState && col < 8) {
		setEditorTrackGroup(trackIdx, col, false);
	} else if (row === 9 && channelState) {
		if (sequence64LockRecordHeld) {
			recordSequence64SetupLock("volume", col);
			var values = currentSequence64ParameterValues();
			values.volume = col;
			clearSequence64PropertyOwnership(sequence64ChannelPropertyKey(channelIdx, "volume"));
			emitSequence64Parameter(workspace.targetType, workspace.targetId,
				"volume", col, channelIdx, 0);
		} else setEditorVolume(channelIdx, Math.round(col * 158 / 15), false);
	} else if (row === 10 && trackState && col < SEQUENCE64_TRANSPOSE_FIRST_COL) {
		var octaveDelta = col === 0 ? -1 : 1;
		var recordedPitch = recordSequence64SetupPitchOctave(octaveDelta);
		if (recordedPitch === null) {
			setEditorOctave(trackIdx,
				(parseInt(trackState.octave, 10) || 0) + octaveDelta, false);
		} else setEditorTranspose(trackIdx, recordedPitch, false);
	} else if (row === 10 && trackState) {
		var transpose = clamp(col - 8, SEQUENCE64_TRANSPOSE_MIN, SEQUENCE64_TRANSPOSE_MAX);
		transpose = recordSequence64SetupLock("transpose", transpose);
		setEditorTranspose(trackIdx, transpose, false);
	} else if (row === 11 && col === 0 && trackState) {
		setEditorReverse(trackIdx, !trackState.reverse, false);
		recordSequence64SetupLock("reverse", trackState.reverse);
	} else if (row === 11 && col === 1 && trackState) {
		setEditorRandomOffset(trackIdx, !trackState.randomOffset, false);
	} else if (row === 11 && col >= 2 && col < 10 && trackState) {
		setEditorSubLoopDivision(trackIdx, TRACK_SUB_LOOP_OPTIONS[col - 2], false);
		recordSequence64SetupLock("loopDivision", TRACK_SUB_LOOP_OPTIONS[col - 2]);
	} else if (row === 12 && trackState) {
		setEditorLoopState(trackIdx, Math.min(col, Math.max(0, trackState.loopEnd - 1)),
			trackState.loopEnd, true, false);
	} else if (row === 13 && trackState) {
		setEditorLoopState(trackIdx, trackState.loopStart,
			Math.max(col + 1, trackState.loopStart + 1), true, false);
	} else if (row === 14 && col === 0 && trackState) {
		setEditorLoopState(trackIdx, trackState.loopStart, trackState.loopEnd, !trackState.loopActive, false);
	} else if (row === 14 && col === 1 && channelState) {
		setEditorChannelLatch(channelIdx, !channelState.gateLatch, false);
	} else if (row === 14 && col === 2 && channelState) {
		setEditorTimestretch(channelIdx, !channelState.timestretch, false);
	} else if (row === 14 && col === 3 && channelState) {
		setEditorMute(channelIdx, !channelState.muted, false);
	} else if (row === 14 && col === 4) {
		clearSequence64Motion();
	} else if (row === 14 && col === 5) {
		restoreSequence64StartSnapshot();
	} else if (row === 14 && col === 6 && trackState) {
		setEditorPlaybackLoop(trackIdx, !trackState.playbackLoop);
	} else if (row === 14 && col >= 7 && col <= 14) {
		instrumentPresetAction(trackIdx, col - 7, sequence64ShiftHeld);
	}
	redrawEditorShellDiff();
	return true;
}

function sequence64CurrentOrLastTrackForGroup(groupIdx) {
	var channelState = getChannelStateByIndex(groupIdx);
	var candidates = channelState ?
		[channelState.activeTrack, channelState.lastActiveTrack] : [];
	for (var index = 0; index < candidates.length; index++) {
		var trackIdx = parseInt(candidates[index], 10);
		if (sequence64TrackBelongsToGroup(trackIdx, groupIdx)) return trackIdx;
	}
	var pattern = ensureSequence64Pattern("group", groupIdx);
	return resolveSequence64GroupDefaultTrack(groupIdx, pattern);
}

function jumpSequence64GroupTrackTarget() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) return false;
	var fromType = workspace.targetType;
	var fromId = workspace.targetId;
	var targetType;
	var targetId;
	if (fromType === "group") {
		targetType = "track";
		targetId = sequence64CurrentOrLastTrackForGroup(fromId);
		if (targetId < 0) {
			outlet(2, "editor_waiting_for_track", "group", fromId + 1);
			return false;
		}
	} else {
		targetType = "group";
		targetId = trackChannelIndex(fromId);
		if (targetId < 0 || targetId >= s.NUM_CHANNELS) return false;
	}
	selectEditorTarget(targetType, targetId);
	diagnosticEvent("sequence64_target_jump", {
		fromType: fromType,
		fromTarget: fromId + 1,
		targetType: targetType,
		target: targetId + 1
	});
	outlet(2, "editor_target_jump", targetType, targetId + 1);
	return true;
}

function toggleSequence64SampleBrowser() {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) return false;
	if (sampleBrowserState.active) return sampleBrowserClose();
	var trackIdx = currentEditorTrackIndex();
	if (trackIdx < 0) {
		outlet(2, "editor_waiting_for_track", workspace.targetType, workspace.targetId + 1);
		publishHud("notice", "warn", "Assign or play a track in this group first");
		return false;
	}
	messnamed("sample_bank", "browserOpen", trackIdx, -1);
	return true;
}

function setSequence64InspectorLiveWrite(enabled) {
	if (knobFocusSource === "grid") knobReset();
	var workspace = ensureEditorWorkspaceDefaults();
	sequence64InspectorLiveWrite = enabled ? true : false;
	sequence64LockRecordHeld = sequence64InspectorLiveWrite;
	diagnosticEvent("record_latch", {
		targetType: workspace.targetType,
		target: workspace.targetId + 1,
		record: sequence64InspectorLiveWrite ? 1 : 0
	});
	outlet(2, "editor_live_write", sequence64InspectorLiveWrite ? 1 : 0);
	outlet(2, "editor_lock_record", sequence64LockRecordHeld ? 1 : 0);
	publishHudEditorState();
	redrawEditorShellDiff();
	knobRefreshContext();
	return true;
}

function handleSequence64InlineModAmount(col) {
	if (sequence64EditParameter !== "filter") return false;
	var workspace = ensureEditorWorkspaceDefaults();
	var route = currentSequence64ModulationRoute();
	var amount = modulationAmountAtColumn(col);
	if (route && route.enabled && Math.abs(route.amount - amount) < 0.0001) {
		modulationClear(workspace.targetType, workspace.targetId,
			sequence64EditParameter, sequence64ModSource);
	} else {
		modulationRoute(workspace.targetType, workspace.targetId,
			sequence64EditParameter, sequence64ModSource, amount, 1);
	}
	redrawEditorShellDiff();
	return true;
}

function switchSequence64View(view) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (view !== "sequence" && view !== "setup" && view !== "scene") return false;
	// The browser deliberately owns the upper half while open. Dismiss that
	// ownership before drawing a different workspace view so its first complete
	// frame cannot inherit a blank or stale browser region.
	if (sampleBrowserState.active) {
		sampleBrowserExitHoldTask.cancel();
		sampleBrowserState.active = false;
		sampleBrowserState.exitTrack = -1;
		publishSampleBrowserState();
	}
	cancelSequence64Copy();
	workspace.view64 = view;
	sequence64ShiftHeld = false;
	workspace.collapsed = false;
	workspace.choosing = false;
	stopAllSequence64Auditions();
	sequence64PressedStep = -1;
	sequence64StepHoldOpened = false;
	sequence64PendingLengthIndex = -1;
	sequence64PendingBarIndex = -1;
	sequence64BarHoldCommitted = false;
	sequence64StepHoldTask.cancel();
	sequence64LengthHoldTask.cancel();
	sequence64BarHoldTask.cancel();
	sceneShiftHeld = false;
	outlet(2, "editor_page", workspace.view64);
	redrawEditorWorkspaceFrame();
	publishHudEditorState();
	if (view === "scene") publishHudSceneState();
	return true;
}

function handleSequence64Navigation(col) {
	var view = sequence64ViewForNavigationColumn(col);
	if (!view) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (!workspace.active) {
		workspace.view64 = view;
		outlet(2, "editor_waiting_for_target", view);
		publishHud("notice", "info", "Choose a group or track to open " + view);
		redrawEditorWorkspaceFrame();
		publishHudEditorState();
		return true;
	}
	if (!workspace.collapsed && workspace.view64 === view) {
		workspace.collapsed = true;
		stopAllSequence64Auditions();
		sequence64PressedStep = -1;
		sequence64StepHoldOpened = false;
		sequence64StepHoldTask.cancel();
		sceneShiftHeld = false;
		outlet(2, "editor_collapsed", 1, view);
		redrawEditorWorkspaceFrame();
		publishHudEditorState();
		return true;
	}
	return switchSequence64View(view);
}

function handleSceneWorkspaceKey(col, row, state) {
	var workspace = ensureEditorWorkspaceDefaults();
	var sceneState = ensureSceneRuntime();
	if (row === SCENE_NAV_ROW) {
		if (col === SCENE_SHIFT_COL) sceneShiftHeld = state === 1;
		else if (state === 1 && col >= 0 && col <= 2) {
			return handleSequence64Navigation(col);
		} else if (state === 1 && col === SCENE_EXIT_COL) exitEditorWorkspace();
		redrawEditorShellDiff();
		return true;
	}
	if (row === 0) {
		if (state !== 1) return true;
		if (sceneShiftHeld) sceneSelectOnly(col);
		else if (!sceneState.scenes[col]) capturePerformanceToScene(col);
		else stageSceneLaunch(col, "grid");
		redrawEditorShellDiff();
		return true;
	}
	if (row >= SCENE_GROUP_FIRST_ROW && row <= SCENE_GROUP_LAST_ROW) {
		var group = row - SCENE_GROUP_FIRST_ROW;
		if (col >= SCENE_PATTERN_FIRST_COL && col <= SCENE_PATTERN_LAST_COL) {
			if (state === 1) {
				stageScenePattern(group, col);
				redrawEditorShellDiff();
			}
			return true;
		}
		if (col === SCENE_GROUP_RUN_COL) {
			if (state === 1) {
				var pattern = ensureSequence64Pattern("group", group);
				setSequence64TargetRunning("group", group, !(pattern && pattern.running));
				publishHudSceneState();
				redrawEditorShellDiff();
			}
			return true;
		}
		return true;
	}
	if (row === SCENE_TRACK_SLOT_ROW) {
		if (state === 1) stageTrackSlotSwitch(col, "grid");
		redrawEditorShellDiff();
		return true;
	}
	if (row === SCENE_TRANSPORT_ROW && state === 1) {
		if (col === SCENE_GLOBAL_START_COL) return sceneGlobalTransport("start");
		if (col === SCENE_GLOBAL_STOP_COL) return sceneGlobalTransport("stop");
		if (col === SCENE_GLOBAL_RESET_COL) return sceneGlobalTransport("reset");
		return true;
	}
	var sceneStep = sceneSequence64GridStep(col, row);
	if (sceneStep >= 0) {
		return handleSequence64StepKey(sceneStep, state);
	}
	return true;
}

function handleSequence64WorkspaceKey(col, row, state) {
	var workspace = ensureEditorWorkspaceDefaults();
 var copyStep = sequence64GridStep(col, row);
 if (state === 0 && copyStep >= 0 && sequence64CopyStepReleases[copyStep]) {
  delete sequence64CopyStepReleases[copyStep];
  return true;
 }
 if (row === SEQUENCE64_NAV_ROW && col === 13 && !sequence64ModMatrixActive)
  return handleSequence64CopyModifier(state);
 if (sequence64CopyGesture && workspace.view64 === "sequence") {
  if (copyStep >= 0) {
   if (state === 1) {
    sequence64CopyStepReleases[copyStep] = true;
    return copySequence64Step(copyStep);
   }
   return true;
  }
  // Permit bar changes while copying; other controls cannot edit by accident.
  if (state === 1 && row === SEQUENCE64_NAV_ROW &&
      col >= SEQUENCE64_BAR_FIRST_COL && col < SEQUENCE64_BAR_FIRST_COL + SEQUENCE64_MAX_BARS) {
   sequence64CopyGesture.used = true;
   selectSequence64Bar(col - SEQUENCE64_BAR_FIRST_COL);
  }
  return true;
 }

	if (sequence64ModMatrixActive) return handleSequence64ModMatrixKey(col, row, state);
	if (row === SEQUENCE64_NAV_ROW && col === SEQUENCE64_DELETE_COL) {
		sequence64DeleteHeld = state === 1;
		redrawEditorShellDiff();
		return true;
	}
	if (row === SEQUENCE64_NAV_ROW && col === 12) {
		if (state === 1) toggleSequence64SampleBrowser();
		return true;
	}
	if (row === SEQUENCE64_NAV_ROW && col === 11) {
		if (workspace.view64 === "sequence" || workspace.view64 === "setup") {
			sequence64ShiftHeld = state === 1;
			if (sequence64ShiftHeld) {
				sequence64PressedStep = -1;
				sequence64StepHoldOpened = false;
				sequence64StepHoldTask.cancel();
			}
			redrawEditorShellDiff();
		}
		return true;
	}

	var shiftedStepIndex = sequence64GridStep(col, row);
	if (shiftedStepIndex >= 0 && state === 0 &&
		sequence64ShiftEditedSteps[shiftedStepIndex]) {
		sequence64ShiftEditedSteps[shiftedStepIndex] = 0;
		return true;
	}
	if (sequence64ShiftHeld && workspace.view64 === "sequence") {
		if (shiftedStepIndex >= 0) {
			if (state === 1) {
				sequence64ShiftEditedSteps[shiftedStepIndex] = 1;
				setCurrentSequence64BarLength(shiftedStepIndex + 1);
			}
			return true;
		}
		if (row === SEQUENCE64_TRANSPORT_ROW) {
			if (state === 1 && col < SEQUENCE64_RATE_CHOICES.length) {
				setCurrentSequence64RateChoice(col);
			}
			return true;
		}
		return true;
	}
	if (workspace.view64 === "sequence" && row === SEQUENCE64_NAV_ROW &&
		col >= SEQUENCE64_BAR_FIRST_COL &&
		col < SEQUENCE64_BAR_FIRST_COL + SEQUENCE64_MAX_BARS) {
		var persistentBarIndex = col - SEQUENCE64_BAR_FIRST_COL;
		if (sequence64DeleteHeld) {
			if (state === 1) {
				var persistentPattern = currentSequence64Pattern();
				if (persistentBarIndex < persistentPattern.bars.length) {
					if (persistentPattern.currentBar !== persistentBarIndex) {
						selectSequence64Bar(persistentBarIndex);
					}
					armOrRemoveSequence64Bar();
				}
			}
			return true;
		}
		return handleSequence64BarKey(persistentBarIndex, state);
	}

	if (row === SEQUENCE64_NAV_ROW && state === 1) {
		if (col === 0 || col === 1 || col === 2) {
			return handleSequence64Navigation(col);
		}
		if (col === EDITOR_TRACK_COL) {
			exitEditorWorkspace();
			return true;
		}
	}

	if (workspace.view64 === "setup") return handleSequence64SetupKey(col, row, state);

	var stepIndex = sequence64GridStep(col, row);
	if (stepIndex >= 0) {
		return handleSequence64StepKey(stepIndex, state);
	}

	if (row === SEQUENCE64_LENGTH_ROW) {
		var instrument = sequence64InstrumentTarget();
		if (col < SEQUENCE64_LENGTHS.length) {
			return handleSequence64LengthKey(col, state);
		}
		if (col === 15 && instrument) {
			if (state !== 1) return true;
			sequence64InstrumentPage = !sequence64InstrumentPage;
			sequence64InstrumentBaseEdit = false;
			sequence64InspectorContext = "parameter";
			sequence64EditParameter = sequence64InstrumentPage ? instrument.pages[sequence64InstrumentBank].parameters[0] : "slice";
			sequence64ModEditActive = false;
			publishHud("notice", "info", sequence64InstrumentPage ? instrument.name + " " + instrument.pages[sequence64InstrumentBank].name + " · row 13 cols 10–12: pages" : "Sample parameters");
			redrawEditorShellDiff();
			return true;
		}
		if (sequence64InstrumentPage && instrument && col >= 9 && col <= 11) {
			if (state !== 1) return true;
			sequence64InstrumentBank = col - 9;
			pendingParameterPageLabel = true;
			sequence64EditParameter = instrument.pages[sequence64InstrumentBank].parameters[0];
			sequence64InspectorContext = "parameter";
			sequence64ModEditActive = false;
			publishHud("notice", "info", instrument.name + " " + instrument.pages[sequence64InstrumentBank].name +
				" · " + sequence64VisibleParameters().map(function(id) { return instrumentDefinition(id).name; }).join(" / "));
			redrawEditorShellDiff();
			return true;
		}
		var matrixParameters = sequence64VisibleParameters();
		var matrixParameterIndex = col - SEQUENCE64_PARAMETER_FIRST_COL;
		if (matrixParameterIndex >= 0 && matrixParameterIndex < matrixParameters.length) {
			if (state === 0) return true;
			var requestedParameter = matrixParameters[matrixParameterIndex];
			sequence64ModMatrixHoldTask.cancel();
			sequence64ModParameterPress = -1;
			sequence64InspectorContext = "parameter";
			sequence64EditParameter = requestedParameter;
			sequence64ModEditActive = false;
			sequence64HeldStepChanged = true;
			outlet(2, "editor_parameter", sequence64EditParameter);
			redrawEditorShellDiff();
			return true;
		}
		if (col === SEQUENCE64_PATTERN_CONTEXT_COL) {
			if (state === 1) {
				sequence64InspectorContext = "pattern";
				sequence64ModEditActive = false;
				outlet(2, "editor_context", "pattern");
				redrawEditorShellDiff();
			}
			return true;
		}
		return true;
	}

	if (sequence64InspectorContext === "pattern") {
		if (row === SEQUENCE64_TRANSPORT_ROW) {
			if (state !== 1) return true;
			if (col === 12) {
				var previousPattern = currentSequence64Pattern();
				selectSequence64Bar((previousPattern.currentBar - 1 + previousPattern.bars.length) %
					previousPattern.bars.length);
			} else if (col === 13) {
				var nextPattern = currentSequence64Pattern();
				selectSequence64Bar((nextPattern.currentBar + 1) % nextPattern.bars.length);
			} else if (col === 14) addSequence64Bar();
			else if (col === 15) armOrRemoveSequence64Bar();
			return true;
		}
		if (row === SEQUENCE64_TOOLS_ROW) {
			if (state !== 1) return true;
			if (col === 0) setCurrentSequence64Running(!currentSequence64Pattern().running);
			else if (col === 1) setSequence64InspectorLiveWrite(!sequence64InspectorLiveWrite);
			else if (col === 2) restartCurrentSequence64Pattern();
			else if (col === 3) stopSequence64Target(workspace.targetType, workspace.targetId, "button_stop");
			else if (col === 15) armOrClearSequence64Pattern();
			return true;
		}
		return true;
	}

	if (row === SEQUENCE64_TRANSPORT_ROW) {
		if (sequence64DeleteHeld) {
			if (state === 1) sequence64ClearSelectedLock();
			return true;
		}
		if (sequence64EditParameter === "slice" && !sequence64ModEditActive) {
			return handleSequence64SliceValueKey(col, state);
		}
		if (state !== 1) return true;
		if (sequence64ModEditActive) return handleSequence64InlineModAmount(col);
		sequence64SetLockValue(sequence64EditParameter, col);
		return true;
	}

	if (row === SEQUENCE64_TOOLS_ROW) {
		if (state !== 1) return true;
		if (sequence64InstrumentPage && sequence64InstrumentTarget()) {
			if (col === 2) {
				sequence64InstrumentBaseEdit = !sequence64InstrumentBaseEdit;
				if (sequence64InstrumentBaseEdit) setSequence64InspectorLiveWrite(false);
				redrawEditorShellDiff(); return true;
			}
			if (col === 3 || col === 4) { sequence64InstrumentFine(col === 3 ? -1 : 1); return true; }
			if (col === 1) sequence64InstrumentBaseEdit = false;
		}
		if (col === 0) return toggleSelectedSequence64Trigger();
		if (col === 1) return setSequence64InspectorLiveWrite(!sequence64InspectorLiveWrite);
		if (col === 15) {
			sequence64ClearSelectedLock();
			return true;
		}
		if (col >= SEQUENCE64_BEHAVIOR_FIRST_COL &&
			col < SEQUENCE64_BEHAVIOR_FIRST_COL + SEQUENCE64_BEHAVIORS.length) {
			sequence64SetBehavior(col - SEQUENCE64_BEHAVIOR_FIRST_COL);
			return true;
		}
		if (sequence64EditParameter === "filter" && col >= 11 && col < 15) {
			var sourceId = Modulation.SOURCE_IDS[col - 11];
			if (sequence64DeleteHeld) {
				modulationClear(workspace.targetType, workspace.targetId,
					sequence64EditParameter, sourceId);
				if (sequence64ModSource === sourceId) sequence64ModEditActive = false;
				redrawEditorShellDiff();
				return true;
			}
			if (sequence64ModEditActive && sequence64ModSource === sourceId) {
				sequence64ModEditActive = false;
			} else {
				sequence64ModSource = sourceId;
				sequence64ModEditActive = true;
			}
			outlet(2, "editor_modulation_source", sourceId,
				sequence64ModEditActive ? 1 : 0);
			redrawEditorShellDiff();
			return true;
		}
	}
	return true;
}

function selectEditorTarget(targetType, targetId, forceOpen) {
	if (!rtaEnabled()) return false;
	if (knobFocusSource === "grid") knobReset();
	var workspace = ensureEditorWorkspaceDefaults();
	if (!forceOpen && workspace.active && workspace.targetType === targetType && workspace.targetId === targetId) {
		clearEditorTarget(true);
		return;
	}
	restoreEditorGateFx();
	stopCurrentEditorAutomationRecording();
	stopAllSequence64Auditions();
	workspace.targetType = targetType;
	workspace.targetId = targetId;
	sequence64InstrumentPage = false;
	sequence64InstrumentBaseEdit = false;
	workspace.active = true;
	workspace.collapsed = false;
	sequence64HeldStep = -1;
	var editCursorKey = editorTargetKey(targetType, targetId);
	sequence64SelectedStep = clamp(parseInt(workspace.editCursors64[editCursorKey], 10) || 0, 0, 63);
	workspace.editCursors64[editCursorKey] = sequence64SelectedStep;
	sequence64HeldStepChanged = false;
	sequence64PressedStep = -1;
	sequence64StepHoldOpened = false;
	sequence64PendingLengthIndex = -1;
	sequence64PendingBarIndex = -1;
	sequence64BarHoldCommitted = false;
	sequence64StepHoldTask.cancel();
	sequence64LengthHoldTask.cancel();
	sequence64BarHoldTask.cancel();
	sequence64InspectorContext = "parameter";
	sequence64EditParameter = "slice";
	sequence64ModEditActive = false;
	sequence64InspectorLiveWrite = false;
	sequence64DeleteHeld = false;
	if (sequence64LayoutEnabled()) {
		var selectedPattern = currentSequence64Pattern();
		var selectedPlayback = sequence64TargetPlaybackLocation(targetType,
			targetId, selectedPattern);
		workspace.lastSequencedStep = selectedPlayback.step;
		workspace.lastSequencedBar = selectedPlayback.bar;
		if (selectedPattern.lastSequencedFlat < 0) {
			selectedPattern.lastSequencedFlat = selectedPlayback.flat;
		}
	} else workspace.lastSequencedStep = currentEditorClockStep();
	if (EDITOR_IDS.indexOf(workspace.editorId) < 0) workspace.editorId = "step";
	workspace.view64 = "sequence";
	var pattern64 = ensureSequence64Pattern(targetType, targetId);
	sequence64TargetParameterValues(targetType, targetId);
	ensureEditorStepPattern(targetType, targetId);
	ensureEditorTargetArray("stepProbabilities", targetType, targetId, 15);
	ensureEditorTargetArray("gateFxLevels", targetType, targetId, 15);
	var targetKey = editorTargetKey(targetType, targetId);
	workspace.sequenceEnabled[targetKey] = 0;
	workspace.gateFxEnabled[targetKey] = 0;
	var targetAutomation = ensureEditorAutomation(targetType, targetId);
	targetAutomation.recording = 0;
	targetAutomation.playing = 0;
	outlet(2, "editor_target", targetType, targetId + 1);
	outlet(2, "editor_active", 1);
	post("[grid_router] editor target " + targetType + " " + (targetId + 1) + "\n");
	redrawEditorWorkspaceFrame();
	publishHudEditorState();
	publishHudCurrentPattern();
}

function clearEditorTarget(keepChooserOpen) {
	var workspace = ensureEditorWorkspaceDefaults();
	var chooserWasOpen = workspace.choosing;
	resetEditorWorkspaceState(true, false);
	if (keepChooserOpen) workspace.choosing = chooserWasOpen;
	outlet(2, "editor_target", "none", 0);
	outlet(2, "editor_active", 0);
	post("[grid_router] editor target cleared\n");
	redrawEditorWorkspaceFrame();
	publishHudEditorState();
}

function exitEditorWorkspace() {
	clearEditorTarget(false);
}

function handleEditorWorkspaceKey(col, row, state) {
	if (!editorWorkspaceAvailable()) return false;
	var workspace = ensureEditorWorkspaceDefaults();
	if (sequence64LayoutEnabled() && row === SEQUENCE64_NAV_ROW && col >= 0 && col <= 2) {
		if (state === 1 && !playbackDispatching) handleSequence64Navigation(col);
		return true;
	}
	if (workspace.active && !workspace.collapsed && sequence64LayoutEnabled() &&
		workspace.view64 === "scene") {
		if (playbackDispatching) return true;
		return handleSceneWorkspaceKey(col, row, state);
	}

	// Physical button 14 is a momentary chooser modifier. Consume both press and
	// release so these UI actions never enter the legacy automation recorder.
	if (col === EDITOR_BUTTON_COL && row === 0) {
		if (!playbackDispatching && workspace.choosing !== (state === 1)) {
			workspace.choosing = state === 1;
			if (workspace.choosing) restoreEditorGateFx();
			if (!workspace.choosing) workspace.lastSequencedStep = currentEditorClockStep();
			outlet(2, "editor_chooser", workspace.choosing ? 1 : 0);
			redrawEditorWorkspaceFrame();
		}
		return true;
	}

	if (workspace.choosing) {
		if (row === 0 && col >= 0 && col < s.NUM_CHANNELS) {
			if (state === 1 && !playbackDispatching) selectEditorTarget("group", col);
			return true;
		}
		if (col === EDITOR_TRACK_COL && row >= 1 && row <= 15) {
			if (state === 1 && !playbackDispatching) selectEditorTarget("track", row - 1);
			return true;
		}
	}
	if (workspace.collapsed) return false;

	if (!workspace.active || row < EDITOR_FIRST_ROW) return false;
	if (playbackDispatching) return true;
	if (sequence64LayoutEnabled()) return handleSequence64WorkspaceKey(col, row, state);
	if (state !== 1) return true;

	if (row === EDITOR_NAV_ROW && col === EDITOR_TRACK_COL) {
		exitEditorWorkspace();
	} else if (row === EDITOR_NAV_ROW && col >= 0 && col < EDITOR_IDS.length) {
		workspace.editorId = EDITOR_IDS[col];
		outlet(2, "editor_page", workspace.editorId);
		post("[grid_router] editor page " + workspace.editorId + "\n");
		redrawEditorWorkspaceFrame();
	} else if (workspace.editorId === "step") handleEditorStepPageKey(col, row);
	else if (workspace.editorId === "loop") handleEditorLoopPageKey(col, row);
	else if (workspace.editorId === "parameter") handleEditorParameterPageKey(col, row);
	else if (workspace.editorId === "automation") handleEditorAutomationPageKey(col, row);
	else if (workspace.editorId === "probability") {
		handleEditorValuePageKey(row, col, currentEditorProbabilities(), "editor_probability");
	} else if (workspace.editorId === "fx") {
		handleEditorFxPageKey(col, row);
	}
	return true;
}

function extendedEditors(enabled) {
	var workspace = ensureEditorWorkspaceDefaults();
	workspace.enabled = Product.rta && parseInt(enabled, 10) ? 1 : 0;
	if (!workspace.enabled) {
		cancelPendingSceneLaunch("editors_disabled");
		pauseSequence64Transport("editors_disabled");
		resetEditorWorkspaceState(true, true);
		workspace.phraseInstances64 = {};
		sequence64ActiveShapes = [];
		modulationStop();
		for (var group = 1; group <= s.NUM_CHANNELS; group++) {
			["lfo1", "lfo2", "adsr", "ar"].forEach(function (source) {
				messnamed(group + "[mod]" + source + "-amount", 0);
			});
		}
	}
	publishHudEditorState();
	post("[grid_router] extended editors " + (workspace.enabled ? "enabled" : "disabled") + "\n");
	if (s.kmod === 2) redrawEditorWorkspaceFrame();
}

function editorLayout(mode) {
	var workspace = ensureEditorWorkspaceDefaults();
	var normalized = String(mode || "").toLowerCase();
	if (normalized === "64" || normalized === "sequence" || normalized === "sequence64") normalized = "sequence64";
	else if (normalized === "legacy" || normalized === "six" || normalized === "6") normalized = "legacy";
	else return;
	if (workspace.layoutMode === normalized) return;
	resetEditorWorkspaceState(true, true);
	workspace.layoutMode = normalized;
	workspace.view64 = "sequence";
	post("[grid_router] editor layout " + normalized + "\n");
	if (s.kmod === 2) redrawEditorWorkspaceFrame();
}

function editorBrightnessColors(enabled) {
	s.editorBrightnessColors = parseInt(enabled, 10) ? 1 : 0;
	invalidateEditorColorCache();
	if (!s.editorBrightnessColors) {
		resetPageColorQueue();
		if (s.kmod === 2 && s.autoPageColors) applyPageColors(2);
	}
	if (s.kmod === 2 && ensureEditorWorkspaceDefaults().active) redrawEditorWorkspaceFrame();
	post("[grid_router] editor semantic colors " +
		(s.editorBrightnessColors ? "enabled" : "disabled") + "\n");
}

function editorColors(enabled) {
	editorBrightnessColors(enabled);
}

/**
 * Explicit hardware safety switch. The bridge defaults private OSC off, so a
 * normal monome receives only standard level messages unless this is enabled.
 */
function mechatrellis(enabled) {
	var requested = parseInt(enabled, 10);
	var protocol = isFinite(requested) ? clamp(requested, 0, 2) : 0;
	var active = protocol ? 1 : 0;
	// Firmware retains its last RGB palette after private output is disabled.
	// Neutralize it while the extension is still enabled, preserving levels.
	if (!active && s.mechaTrellisExtensions) {
		resetPageColorQueue();
		outlet(1, "colorlayersclear");
		outlet(1, "colorall", 255, 255, 255);
	}
	s.mechaTrellisExtensions = protocol;
	outlet(1, "mechatrellis", protocol);
	editorBrightnessColors(active);
	if (protocol === 2 && s.autoPageColors) renderCompletePage(s.kmod, false);
	else if (active && s.autoPageColors) initializePageColorPresets();
	else if (!active) resetPageColorQueue();
	if (!active) renderCompletePage(s.kmod, false, true);
	publishHud("hardware_colors", active);
	diagnosticEvent("mechatrellis_mode", {
		enabled: active,
		protocol: protocol,
		editorColors: s.editorBrightnessColors ? 1 : 0
	});
	post("[grid_router] MechaTrellis hardware mode " +
		(active ? "v" + protocol : "disabled") + "\n");
}

function clearEditorTargetData() {
	var workspace = ensureEditorWorkspaceDefaults();
	var key = currentEditorTargetKey();
	if (!key) return;
	if (sequence64LayoutEnabled()) {
		stopSequence64Target(workspace.targetType, workspace.targetId, "target_data_clear");
	}
	restoreEditorGateFx();
	delete workspace.stepPatterns[key];
	delete workspace.sequenceEnabled[key];
	delete workspace.stepProbabilities[key];
	delete workspace.gateFxLevels[key];
	delete workspace.gateFxEnabled[key];
	delete workspace.targetAutomation[key];
	delete workspace.patterns64[key];
	delete workspace.parameterValues64[key];
	delete workspace.startSnapshots64[key];
	ensureEditorStepPattern(workspace.targetType, workspace.targetId);
	ensureEditorTargetArray("stepProbabilities", workspace.targetType, workspace.targetId, 15);
	ensureEditorTargetArray("gateFxLevels", workspace.targetType, workspace.targetId, 15);
	ensureEditorAutomation(workspace.targetType, workspace.targetId);
	workspace.lastSequencedStep = currentEditorClockStep();
	outlet(2, "editor_target_data_cleared", workspace.targetType, workspace.targetId + 1);
	redrawEditorShellDiff();
}

function clearEditorAllData() {
	var workspace = ensureEditorWorkspaceDefaults();
	for (var key in workspace.patterns64) {
		var parts = key.split(":");
		if (parts.length === 2) {
			stopSequence64Target(parts[0], parseInt(parts[1], 10), "all_data_clear", true);
		}
	}
	restoreEditorGateFx();
	workspace.stepPatterns = {};
	workspace.sequenceEnabled = {};
	workspace.stepProbabilities = {};
	workspace.gateFxLevels = {};
	workspace.gateFxEnabled = {};
	workspace.targetAutomation = {};
	workspace.patterns64 = {};
	workspace.parameterValues64 = {};
	workspace.startSnapshots64 = {};
	workspace.propertyStacks64 = {};
	if (workspace.active) clearEditorTargetData();
	outlet(2, "editor_all_data_cleared");
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

function refreshSequence64TrackPositionForRow(row) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (s.kmod !== 2 || !sequence64LayoutEnabled() || !workspace.active ||
		workspace.choosing || workspace.view64 !== "sequence" || sequence64HeldStep >= 0) return;
	var trackIdx = sequence64PlayingTrackIndex();
	if (trackIdx >= 0 && row === trackIdx + 1) redrawEditorShellDiff();
}

function updateLoopSelectionFromPress(col, row, state) {
	if (row < 1 || row >= s.gridHeight) return;
	var trackIdx = row - 1;
	var held = trackHeldLoopCols[trackIdx];
	var trackState = getTrackStateByIndex(trackIdx);
	if (!held || !trackState) return;

	if (state === 1) {
		if (!held[col]) {
			var loopChanged = false;
			if (heldLoopCols(trackIdx).length === 0 && trackState.loopActive) {
				clearLoopVisualForTrackIndex(trackIdx, true);
				loopChanged = true;
			}
			held[col] = 1;
			var cols = heldLoopCols(trackIdx);
			if (cols.length === 2) {
				applyLoopStateForTrackIndex(trackIdx, cols[0], cols[1], true);
				loopChanged = true;
			}
			if (loopChanged) writeThroughActiveTrackSlot(trackIdx, "track loop");
		}
		return;
	}

	delete held[col];
}

function postln(msg) {
	post(msg + "\n");
}

function displayFrameCellIndex(x, y) {
	return y * s.gridWidth + x;
}

/**
 * Build a complete logical page away from the live Jitter matrix. The bridge
 * receives the finished foreground/background pair in one replaceframe
 * message, so neither hardware nor the HUD can observe a cleared half-frame.
 */
function beginDisplayFrame() {
	if (displayFrameActive) {
		post("[grid_router] nested display frame ignored\n");
		return false;
	}
	displayFrameActive = true;
	displayFrameForeground = new Array(s.gridWidth * s.gridHeight).fill(0);
	displayFrameBackground = new Array(s.gridWidth * s.gridHeight).fill(0);
	return true;
}

function finishDisplayFrame(commit) {
	if (!displayFrameActive) return false;
	var foreground = displayFrameForeground;
	var background = displayFrameBackground;
	displayFrameActive = false;
	displayFrameForeground = null;
	displayFrameBackground = null;
	if (!commit) return false;
	var message = [1, "replaceframe", s.gridWidth, s.gridHeight]
		.concat(foreground, background);
	outlet.apply(this, message);
	return true;
}

function withSuppressedDisplayWrites(callback) {
	suppressDisplayWritesDepth++;
	try {
		callback();
	} finally {
		suppressDisplayWritesDepth--;
	}
}

function beginMatrixUpdate() {
	if (displayFrameActive || suppressDisplayWritesDepth > 0) return false;
	outlet(1, "beginupdate");
	return true;
}

function endMatrixUpdate(opened) {
	if (opened) outlet(1, "endupdate");
}

function led(x, y, level) {
	if (sampleBrowserDrawDepth === 0 && sampleBrowserOwnsLedCell(x, y)) return;
	if (editorOverlayDrawDepth === 0 && editorOwnsLedCell(x, y)) return;
	if (suppressDisplayWritesDepth > 0) return;
	var normalized = clamp(level | 0, 0, 15);
	if (displayFrameActive) {
		if (x >= 0 && y >= 0 && x < s.gridWidth && y < s.gridHeight) {
			displayFrameForeground[displayFrameCellIndex(x, y)] = normalized;
		}
		return;
	}
	outlet(1, "setcell", x, y, normalized);
}

function led_bg(x, y, level) {
	if (sampleBrowserDrawDepth === 0 && sampleBrowserOwnsLedCell(x, y)) return;
	if (suppressDisplayWritesDepth > 0) return;
	var normalized = clamp(level | 0, 0, 15);
	if (displayFrameActive) {
		if (x >= 0 && y >= 0 && x < s.gridWidth && y < s.gridHeight) {
			displayFrameBackground[displayFrameCellIndex(x, y)] = normalized;
		}
		return;
	}
	outlet(1, "setcell_bg", x, y, normalized);
}

function clear_bg() {
	if (suppressDisplayWritesDepth > 0) return;
	if (displayFrameActive) {
		displayFrameBackground.fill(0);
		return;
	}
	outlet(1, "clear_bg");
}

function kfping(x, y, level, time = 20) {
	if (sampleBrowserDrawDepth === 0 && sampleBrowserOwnsLedCell(x, y)) return;
	if (editorOverlayDrawDepth === 0 && editorOwnsLedCell(x, y)) return;
	if (displayFrameActive || suppressDisplayWritesDepth > 0) return;
	outlet(3, "kf", x, y, level, 1, 0, time);
}

function clear() {
	post("[grid_router] legacy clear request converted to full redraw — kmod=" + s.kmod + "\n");
	redraw();
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

/** Persistent 4x4 colors, row-major as 16 RGB triples. */
function colorMap() {
	var args = arrayfromargs(arguments);
	if (args.length !== 50) return;
	var command = ["colormap", parseInt(args[0], 10), parseInt(args[1], 10)];
	for (var i = 2; i < args.length; i++) command.push(clamp8(args[i]));
	outlet.apply(this, [1].concat(command));
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
	if (pageColorQueue.length) {
		pageColorQueueTask.schedule(pageColorQueue[0][0] === "colormap" ?
			PAGE_COLOR_MAP_INTERVAL_MS : PAGE_COLOR_INTERVAL_MS);
	}
}

function drainPageColorQueueNow() {
	pageColorQueueTask.cancel();
	while (pageColorQueue.length) {
		var command = pageColorQueue.shift();
		outlet.apply(this, [1].concat(command));
		if (command[0] === "colorpresetstore") {
			pageColorPresetReady[colorPresetSlot(command[1])] = 1;
		}
	}
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

function queueColorMapFrom(x, y, colors) {
	if (x < 0 || y < 0 || x + 4 > s.gridWidth || y + 4 > s.gridHeight ||
		!colors || colors.length !== 48) return;
	var command = ["colormap", x, y];
	for (var i = 0; i < colors.length; i++) command.push(clamp8(colors[i]));
	pageColorQueue.push(command);
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

function createColorPalette(rgb) {
	var palette = new Array(s.gridWidth * s.gridHeight);
	for (var i = 0; i < palette.length; i++) {
		palette[i] = [clamp8(rgb[0]), clamp8(rgb[1]), clamp8(rgb[2])];
	}
	return palette;
}

function paintColorPaletteRect(palette, x0, y0, x1, y1, rgb) {
	var left = clamp(Math.min(x0, x1), 0, s.gridWidth - 1);
	var right = clamp(Math.max(x0, x1), 0, s.gridWidth - 1);
	var top = clamp(Math.min(y0, y1), 0, s.gridHeight - 1);
	var bottom = clamp(Math.max(y0, y1), 0, s.gridHeight - 1);
	for (var y = top; y <= bottom; y++) {
		for (var x = left; x <= right; x++) {
			palette[y * s.gridWidth + x] =
				[clamp8(rgb[0]), clamp8(rgb[1]), clamp8(rgb[2])];
		}
	}
}

function queueColorPaletteMaps(palette) {
	if (!palette || palette.length !== s.gridWidth * s.gridHeight) return;
	for (var blockY = 0; blockY < s.gridHeight; blockY += 4) {
		for (var blockX = 0; blockX < s.gridWidth; blockX += 4) {
			var colors = [];
			for (var y = 0; y < 4; y++) {
				for (var x = 0; x < 4; x++) {
					var rgb = palette[(blockY + y) * s.gridWidth + blockX + x];
					colors.push(rgb[0], rgb[1], rgb[2]);
				}
			}
			queueColorMapFrom(blockX, blockY, colors);
		}
	}
}

function applyMainPageColors(palette) {
	paintColorPaletteRect(palette, 0, 0, 7, 0, PAGE_COLORS.mainChannels);
	paintColorPaletteRect(palette, 8, 0, 11, 0, PAGE_COLORS.mainPatterns);
	paintColorPaletteRect(palette, 12, 0, 13, 0, PAGE_COLORS.mainClock);
	paintColorPaletteRect(palette, 14, 0, 15, 0, PAGE_COLORS.mainPage);
}

function applyModPageColors(palette) {
	paintColorPaletteRect(palette, 0, 0, 7, 0, PAGE_COLORS.mute);
	paintColorPaletteRect(palette, 0, 1, 7, 2, PAGE_COLORS.volume);
	paintColorPaletteRect(palette, 0, 3, 7, 3, PAGE_COLORS.timestretch);
	paintColorPaletteRect(palette, 0, 4, 7, 4, PAGE_COLORS.sequenceRun);
	var insertBottom = s.gridHeight - 4;
	if (insertBottom >= 5) {
		paintColorPaletteRect(palette, 0, 5, 7, insertBottom, PAGE_COLORS.insertFx);
	}
	paintColorPaletteRect(palette, 0, s.gridHeight - 3, 7, s.gridHeight - 1,
		PAGE_COLORS.meter);
	paintColorPaletteRect(palette, 8, 0, 8, s.gridHeight - 1, PAGE_COLORS.randomize);
	paintColorPaletteRect(palette, TRACK_CAPTURE_COL, 0, TRACK_CAPTURE_COL,
		s.gridHeight - 1, PAGE_COLORS.automation);
	paintColorPaletteRect(palette, 10, 0, 10, s.gridHeight - 1, PAGE_COLORS.quantize);
	paintColorPaletteRect(palette, 11, 0, 11, s.gridHeight - 1, PAGE_COLORS.sequenceRun);
	paintColorPaletteRect(palette, 12, 0, 12, s.gridHeight - 1, PAGE_COLORS.randomOffset);
	paintColorPaletteRect(palette, 13, 0, 14, s.gridHeight - 1, PAGE_COLORS.octave);
	paintColorPaletteRect(palette, 15, 0, 15, s.gridHeight - 1, PAGE_COLORS.reverse);
}

function applyGroupsPageColors(palette) {
	for (var group = 0; group < GROUP_COLORS.length && (group + 8) < s.gridWidth; group++) {
		paintColorPaletteRect(palette, group + 8, 1, group + 8,
			s.gridHeight - 1, GROUP_COLORS[group]);
	}
}

function buildPageColorPalette(page) {
	var base = PAGE_COLORS.mainBase;
	if (page === 2) base = PAGE_COLORS.modBase;
	else if (page === 3) base = PAGE_COLORS.groupsBase;
	var palette = createColorPalette(base);
	switch (page) {
		case 1: applyMainPageColors(palette); break;
		case 2: applyModPageColors(palette); break;
		case 3: applyGroupsPageColors(palette); break;
	}
	return palette;
}

/** Directly upload one complete page palette; no volatile firmware slot involved. */
function applyPageColors(page) {
	var requested = parseInt(page, 10);
	var target = isFinite(requested) ? clamp(requested, 1, 3) : s.kmod;
	resetPageColorQueue();
	var workspace = ensureEditorWorkspaceDefaults();
	var sceneVisible = target === 2 && s.kmod === 2 && workspace.active && !workspace.collapsed &&
		!workspace.choosing && sequence64LayoutEnabled() && workspace.view64 === "scene";
	if (sceneVisible && s.editorBrightnessColors) queueSceneColorPalette(true);
	else {
		editorScenePaletteVisible = false;
		outlet(1, "colorlayersclear");
		queueColorPaletteMaps(buildPageColorPalette(target));
		if (target === 2 && s.kmod === 2) queueCurrentEditorShellColors(true);
	}
	startPageColorQueue();
}

/**
 * Compatibility entry point retained for old patches. Automatic color state is
 * now stateless: invalidate any remembered firmware slots and send only the
 * currently visible page (or sample-browser overlay) as paced 4x4 maps.
 */
function initializePageColorPresets() {
	resetPageColorQueue();
	for (var slot = 0; slot < pageColorPresetReady.length; slot++) {
		pageColorPresetReady[slot] = 0;
	}
	if (sampleBrowserState.active) queueSampleBrowserColors();
	else {
		var workspace = ensureEditorWorkspaceDefaults();
		var sceneVisible = s.kmod === 2 && workspace.active && !workspace.collapsed && !workspace.choosing &&
			sequence64LayoutEnabled() && workspace.view64 === "scene";
		if (sceneVisible && s.editorBrightnessColors) queueSceneColorPalette(true);
		else {
			editorScenePaletteVisible = false;
			outlet(1, "colorlayersclear");
			queueColorPaletteMaps(buildPageColorPalette(clamp(s.kmod, 1, 3)));
			if (s.kmod === 2) queueCurrentEditorShellColors(true);
		}
	}
	startPageColorQueue();
}

function activatePageColors(page) {
	var target = clamp(parseInt(page, 10) || s.kmod, 1, 3);
	applyPageColors(target);
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

function trackPlaybackLoopBus(channelNum) {
	return channelNum + "[mlr]pl-playback-loop";
}

function applyTrackPlaybackLoop(trackIdx) {
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return false;
	messnamed(trackPlaybackLoopBus(trackChannelBusNumber(trackIdx)), "loop",
		trackState.playbackLoop ? 1 : 0);
	return true;
}

function sendTrackInput(trackIdx, position, state) {
	if (state) applyTrackPlaybackLoop(trackIdx);
	messnamed(trackInputBus(trackIdx + 2), position, state);
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
	diagnosticEvent("loop_restore", function () {
		var loopDetails = diagnosticTrackSnapshot(trackIdx);
		loopDetails.sentLoopStart = trackState.loopActive ? trackState.loopStart : 0;
		loopDetails.sentLoopEnd = trackState.loopActive ? trackState.loopEnd : 16;
		return loopDetails;
	});
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

	diagnosticEvent("subloop_apply", function () {
		var loopDetails = diagnosticTrackSnapshot(trackIdx);
		loopDetails.sentLoopStart = loopStart;
		loopDetails.sentLoopEnd = loopEnd;
		return loopDetails;
	});
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
	refreshActiveEditorShell();
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
	writeThroughActiveTrackSlot(trackIdx, "track loop division");
	refreshActiveEditorShell();
}

function timeMsUpdate(ms) {
	var parsed = parseFloat(ms);
	if (!isFinite(parsed) || parsed <= 0) return;
	s.timeMs = parsed;
}

function sessionColorObject() {
	var result = {};
	var entries = hudColorRoleEntries();
	for (var index = 0; index < entries.length; index++) {
		result[entries[index].name] = entries[index].value.slice();
	}
	return result;
}

function sessionRecordingSnapshot(tracks) {
	var used = {};
	var existing = s.sessionRecordings || [];
	var knownRecordingBuffers = {};
	for (var savedIndex = 0; savedIndex < existing.length; savedIndex++) {
		var savedBuffer = parseInt(existing[savedIndex].bufferIndex, 10) || 0;
		if (!savedBuffer) {
			var savedMatch = /^(\d+)file$/.exec(String(existing[savedIndex].bufferName || ""));
			savedBuffer = savedMatch ? parseInt(savedMatch[1], 10) : 0;
		}
		if (savedBuffer >= 1 && savedBuffer <= 250) knownRecordingBuffers[savedBuffer] = 1;
	}

	function noteTrackList(trackList) {
		if (!Array.isArray(trackList)) return;
		for (var index = 0; index < trackList.length; index++) {
			var bufferIndex = parseInt((trackList[index] || {}).buffer, 10) || 0;
			// Buffers 1–7 are the legacy recorder pool. Modern captures can use any
			// explicitly registered file buffer, including bank-range numbers.
			if ((bufferIndex < 1 || bufferIndex > 7) && !knownRecordingBuffers[bufferIndex]) continue;
			if (!used[bufferIndex]) used[bufferIndex] = [];
			if (used[bufferIndex].indexOf(index) < 0) used[bufferIndex].push(index);
		}
	}

	noteTrackList(tracks);
	var workspace = ensureEditorWorkspaceDefaults();
	var sceneState = workspace.sceneState;
	if (sceneState && sceneState.trackSlots) {
		for (var slotId in sceneState.trackSlots) {
			noteTrackList((sceneState.trackSlots[slotId] || {}).tracks);
		}
	}

	var result = [];
	var bufferIds = Object.keys(used).map(function (value) { return parseInt(value, 10); });
	bufferIds.sort(function (left, right) { return left - right; });
	for (var bufferOffset = 0; bufferOffset < bufferIds.length; bufferOffset++) {
		var buffer = bufferIds[bufferOffset];
		var descriptor = null;
		for (var saved = 0; saved < existing.length; saved++) {
			if (String(existing[saved].bufferName || "") === buffer + "file" ||
				parseInt(existing[saved].bufferIndex, 10) === buffer) {
				descriptor = JSON.parse(JSON.stringify(existing[saved]));
				break;
			}
		}
		if (!descriptor) descriptor = {};
		descriptor.source = descriptor.source || "live-recording";
		descriptor.bufferIndex = buffer;
		descriptor.bufferName = buffer + "file";
		descriptor.tracks = used[buffer].slice();
		result.push(descriptor);
	}
	return result;
}

function sessionRouterSnapshotObject() {
	var workspace = ensureEditorWorkspaceDefaults();
	var sceneState = Product.rta ? ensureSceneRuntime() : null;
	var activeTrackSlot = sceneState && sceneState.trackSlots[workspace.performanceTrackSlotRef];
	var tracks = [];
	var groups = [];
	for (var trackIndex = 0; trackIndex < s.NUM_TRACKS; trackIndex++) {
		tracks.push(activeTrackSlot && activeTrackSlot.tracks[trackIndex] ?
			Scenes.clone(activeTrackSlot.tracks[trackIndex]) : sceneTrackSnapshot(trackIndex));
	}
	for (var groupIndex = 0; groupIndex < s.NUM_CHANNELS; groupIndex++) {
		var channel = getChannelStateByIndex(groupIndex);
		groups.push({ id: groupIndex, volume: channel.volume,
			muted: channel.muted ? 1 : 0, timestretch: channel.timestretch ? 1 : 0,
			gateLatch: channel.gateLatch ? 1 : 0, phaseCut: phaseCutState(groupIndex) });
	}
	return {
		tracks: tracks,
		groups: groups,
		patterns: JSON.parse(JSON.stringify(workspace.patterns64 || {})),
		sceneState: Scenes.clone(workspace.sceneState),
		targetAutomation: JSON.parse(JSON.stringify(workspace.targetAutomation || {})),
		modulation: Modulation.sanitizeState(workspace.modulation),
		automation: JSON.parse(JSON.stringify(s.automation || {})),
		colors: sessionColorObject(),
		recordings: sessionRecordingSnapshot(tracks),
		instrumentPresets: sanitizeInstrumentPresets(s.instrumentPresets)
	};
}

function sessionSnapshot(requestId) {
	var dictName = "mlr_session_router_fragment";
	var dict = new Dict(dictName);
	dict.parse(JSON.stringify(sessionRouterSnapshotObject()));
	messnamed("mlr_session_fragment", "router_dict", String(requestId || ""), dictName);
}

function sessionApplyDict(dictName) {
	try {
		var dict = new Dict(String(dictName || ""));
		return sessionApply(dict.stringify());
	} catch (error) {
		publishHud("notice", "error", "Could not read session router dictionary");
		return false;
	}
}

function sessionStopAndReset() {
	releaseNativeSequence64("session_stop", true);
	resetPlaybackDisplay();
	var workspace = ensureEditorWorkspaceDefaults();
	sessionRecordingRestoreTask.cancel();
	sessionRecordingRestoreQueue = [];
	for (var key in workspace.patterns64) {
		var parts = key.split(":");
		if (parts.length === 2) {
			stopSequence64Target(parts[0], parseInt(parts[1], 10), "session_stop", true);
		}
	}
	restoreAllSequence64OwnedProperties();
	modulationStop();
	workspace.phraseInstances64 = {};
	workspace.propertyStacks64 = {};
	for (var automationKey in workspace.targetAutomation) {
		if (!workspace.targetAutomation[automationKey]) continue;
		workspace.targetAutomation[automationKey].playing = 0;
		workspace.targetAutomation[automationKey].recording = 0;
	}
	s.automation.armed = false;
	s.automation.recording = false;
	s.automation.playing = false;
	for (var sequencer = 0; sequencer < s.sequencers.length; sequencer++) {
		s.sequencers[sequencer].on = 0;
		s.sequencers[sequencer].phase = 0;
		sendNamedInt(sequencer + "pp", 0);
	}
	for (var channelIndex = 0; channelIndex < s.NUM_CHANNELS; channelIndex++) {
		cancelSequence64PhraseForChannel(channelIndex, "session_stop", false);
		cancelSequence64AudioForChannel(channelIndex);
		var channel = getChannelStateByIndex(channelIndex);
		channel.sequence64Owner = null;
		channel.activeTrack = -1;
		channel.lastActiveTrack = -1;
		channel.on = 0;
		clearChannelPlaybackPositions(channelIndex, -1);
		sendNamedInt((channelIndex + 1) + "[pl]stop", 1);
	}
	resetEditorWorkspaceState(true, false);
	s.globalTransportRunning = 0;
	restoreEditorGateFx();
	publishHudEditorState();
	return true;
}

function drainSessionRecordingRestores() {
	if (!sessionRecordingRestoreQueue.length) return;
	var recording = sessionRecordingRestoreQueue.shift();
	messnamed(recording.buffer + "load", "replace", recording.path);
	if (sessionRecordingRestoreQueue.length) sessionRecordingRestoreTask.schedule(35);
}

function scheduleSessionRecordingRestores(recordings) {
	sessionRecordingRestoreTask.cancel();
	sessionRecordingRestoreQueue = [];
	for (var recordingIndex = 0; recordingIndex < recordings.length; recordingIndex++) {
		var recording = recordings[recordingIndex] || {};
		// Catalog-backed captures are restored in-order by sample_bank so their
		// menu index and numeric file buffer remain the same object. This queue is
		// retained only for legacy 1file–7file recordings.
		if (recording.catalogSample) continue;
		var recordingBuffer = clamp(parseInt(recording.bufferIndex, 10) || 0, 0, 250);
		if (recordingBuffer && recording.resolvedPath) {
			sessionRecordingRestoreQueue.push({
				buffer: recordingBuffer,
				path: String(recording.resolvedPath)
			});
		}
	}
	// The stop messages above reach groove~ before any backing buffer changes.
	// Several audio vectors then elapse before the first replace; subsequent
	// recording buffers are paced rather than mutated in one scheduler burst.
	if (sessionRecordingRestoreQueue.length) sessionRecordingRestoreTask.schedule(75);
}

function sessionApplyTrack(trackIndex, source) {
	var track = getTrackStateByIndex(trackIndex);
	if (!track || !source) return;
	var group = clamp(parseInt(source.group, 10) || 0, 0, 7);
	setEditorTrackGroup(trackIndex, group, false);
	setEditorOctave(trackIndex, source.octave, false);
	setEditorTranspose(trackIndex, source.transpose, false);
	restoreEditorReverse(trackIndex, source.reverse);
	setEditorRandomOffset(trackIndex, source.randomOffset, false);
	track.buffer = parseInt(source.buffer, 10) || 0;
	sampleBrowserState.assignments[trackIndex] = source.sampleIndex === undefined ? -1 :
		parseInt(source.sampleIndex, 10);
	sampleBrowserState.sampleRefs[trackIndex] = source.sampleRef ?
		Scenes.clone(source.sampleRef) : null;
	track.length = clamp(parseInt(source.length, 10) || 16, 1, 16);
	track.speed = parseFloat(source.speed) || 0;
	track.speedMode = parseInt(source.speedMode, 10) || 0;
	track.playbackLoop = source.playbackLoop === undefined ? 1 : (source.playbackLoop ? 1 : 0);
	track.channel = group + 1;
	track.loopStart = clamp(parseInt(source.loopStart, 10) || 0, 0, 15);
	track.loopEnd = clamp(parseInt(source.loopEnd, 10) || 16, 1, 16);
	track.subLoopDiv = parseInt(source.loopDivision, 10) || 8;
	track.loopActive = source.loopActive ? 1 : 0;
	if (instrumentDescriptorForTrack(trackIndex)) {
		track.instrumentParameters = instrumentSanitize(trackIndex, source.instrumentParameters);
		syncInstrument(trackIndex);
	}
	var trackNumber = trackIndex + 2;
	// Track buffers are one-based file numbers; [umenu] selection is zero-based.
	// Drive the existing menu path so ch.maxpat updates its local [pak] as well as
	// the visible selection. A silent `set` left that [pak] holding the previous
	// buffer, so its next parameter callback could restore the old sample over a
	// correctly planned Scene recall. sceneRecallApplying/sessionStateApplying
	// suppress write-through while this authoritative feedback is in flight.
	messnamed(trackNumber + "[sample]select", track.buffer > 0 ? track.buffer - 1 : -1);
	sendNamedInt(trackNumber + "[box]len", track.length);
	messnamed("[mlr]ch", trackNumber, track.buffer, track.octave,
		track.length, track.speed, track.reverse ? 1 : 0, track.speedMode,
		track.channel, track.randomOffset ? 1 : 0);
	messnamed("sample_bank", "syncTrackBuffer", trackIndex, track.buffer);
	sendNamedInt(track.channel + "[ch]update", 1);
	setEditorLoopState(trackIndex, track.loopStart, track.loopEnd, track.loopActive, false);
	setEditorSubLoopDivision(trackIndex, track.subLoopDiv, false);
	publishHudTrackState(trackIndex);
}

function sessionApply(payload) {
	var source;
	try { source = JSON.parse(String(payload || "{}")); }
	catch (error) {
		publishHud("notice", "error", "Could not parse session state");
		return false;
	}
	if (!Product.rta && (source.format === "mlr-session" || source.rta)) {
		publishHud("notice", "error", "Open this sequencer session in rta; MLR state was not changed");
		return false;
	}
	sessionStateApplying = true;
	try {
		sessionStopAndReset();
		s.instrumentPresets = sanitizeInstrumentPresets(source.instrumentPresets);
		instrumentPresetSelection = {};
		var recordings = source.recordings || [];
		scheduleSessionRecordingRestores(recordings);
		var groups = source.groups || [];
		for (var group = 0; group < s.NUM_CHANNELS; group++) {
			var savedGroup = groups[group] || {};
			setEditorVolume(group, savedGroup.volume === undefined ? 100 : savedGroup.volume, false);
			setEditorMute(group, savedGroup.muted, false);
			setEditorTimestretch(group, savedGroup.timestretch, false);
			setEditorChannelLatch(group, savedGroup.gateLatch, false);
			s.phaseCuts = s.phaseCuts || [];
			s.phaseCuts[group] = PhaseCut.sanitize(savedGroup.phaseCut);
			publishPhaseCut(group);
		}
		var tracks = source.tracks || [];
		for (var track = 0; track < s.NUM_TRACKS; track++) sessionApplyTrack(track, tracks[track] || {});
		var workspace = ensureEditorWorkspaceDefaults();
		var rta = Product.rta ? (source.rta || source) : {};
		workspace.patterns64 = JSON.parse(JSON.stringify(rta.patterns || (Product.rta && source.patterns) || {}));
		workspace.targetAutomation = JSON.parse(JSON.stringify(rta.targetAutomation || (Product.rta && source.targetAutomation) || {}));
		workspace.modulation = Modulation.sanitizeState(source.modulation);
		workspace.sceneState = rta.sceneState ? Scenes.clone(rta.sceneState) : null;
		workspace.sceneRuntimeReady = 0;
		workspace.performanceGroupPatternRefs = [];
		workspace.performanceTrackSlotRef = "";
		workspace.pendingSceneLaunch = null;
		if (Product.rta) ensureSceneRuntime();
		workspace.parameterValues64 = {};
		workspace.startSnapshots64 = {};
		workspace.propertyStacks64 = {};
		workspace.phraseInstances64 = {};
		for (var patternKey in workspace.patterns64) {
			if (!workspace.patterns64[patternKey]) continue;
			workspace.patterns64[patternKey].running = 0;
			workspace.patterns64[patternKey].phaseOrigin = 0;
			workspace.patterns64[patternKey].lastSequencedFlat = -1;
			workspace.patterns64[patternKey].lastSequencedAbsolute = -1;
			workspace.patterns64[patternKey].restartArmed = 0;
		}
		s.automation = JSON.parse(JSON.stringify(source.automation || {}));
		s.automation.armed = false;
		s.automation.recording = false;
		s.automation.playing = false;
		s.automation.tick = 0;
		s.automation.startTick = 0;
		s.automation.playHead = 0;
		var colors = source.colors || {};
		for (var colorName in colors) {
			var rgb = colors[colorName];
			if (rgb && rgb.length >= 3) hudColorRole(colorName, rgb[0], rgb[1], rgb[2]);
		}
		s.sessionRecordings = source.recordings || [];
		applyNativeModulationAll();
	} finally {
		sessionStateApplying = false;
	}
	renderCompletePage(s.kmod, true);
	hudSnapshot();
	return true;
}

function sessionNew() {
	var tracks = [];
	var groups = [];
	for (var track = 0; track < s.NUM_TRACKS; track++) {
		tracks.push({ group: 7, buffer: 0, length: 16, octave: 0, transpose: 0,
			speed: 0, speedMode: 0, reverse: 0, randomOffset: 0,
			loopStart: 0, loopEnd: 16, loopDivision: 8, loopActive: 0,
			playbackLoop: 1 });
	}
	for (var group = 0; group < s.NUM_CHANNELS; group++) {
		groups.push({ volume: 100, muted: 0, timestretch: 0, gateLatch: 0 });
	}
	sessionApply(JSON.stringify({ tracks: tracks, groups: groups,
		rta: Product.rta ? { patterns: {}, targetAutomation: {} } : undefined,
		modulation: Modulation.createState(),
		automation: { events: [], length: 128, looping: false } }));
	sessionStateApplying = true;
	hudColorReset("all");
	sessionStateApplying = false;
	return true;
}

// ─── Entry Points ───────────────────────────────────────────────────────

function loadbang() {
	for (var cutGroup = 0; cutGroup < 8; cutGroup++) publishPhaseCut(cutGroup);
	releaseNativeSequence64("load", true);
	// This project is one logical 16x16 surface. It may be backed by one physical
	// 256 or split by grid_composite_2x128, but the router/matrix/HUD must never
	// inherit a stale 16x8 edition from Max's persistent Global state.
	s.edition = 256;
	s.gridWidth = 16;
	s.gridHeight = 16;
	s.dual128Mode = 0;
	outlet(1, "edition", 256);
	outlet(1, "dual128", 0);
	messnamed("togridmatrixanim", "edition", 256);
	applyNativeModulationAll();
	post("[grid_router] ready — kmod=" + s.kmod + " edition=" + s.edition + "\n");
	diagnosticEvent("router_loaded", {
		edition: s.edition,
		gridWidth: s.gridWidth,
		gridHeight: s.gridHeight,
		layout: ensureEditorWorkspaceDefaults().layoutMode
	});
	post("[grid_router] diagnostic logging on — " + DIAGNOSTIC_LOG_PATH + "\n");
	initialDisplayFrameTask.schedule(150);
	initialPageColorTask.schedule(750);
}

function msg_int(a) {
	post("[grid_router] msg_int " + a + "\n");
	if (inlet === 1) {
		setKmod(a);
	} else if (inlet === 2) {
		clockTick();
	} else if (inlet === 3) {
		sequence64SubPulse();
	}
}

function bang() {
	if (inlet === 2) {
		clockTick();
	} else if (inlet === 3) {
		sequence64SubPulse();
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
	sendNamedInt(idx + "pp", on);
	s.sequencers[idx].on = on ? 1 : 0;
	if (!on) {
		s.sequencers[idx].phase = 0;
		led(idx + 8, 0, 0);
	}
	if (s.kmod === 1) drawSequencerLeds();
};
s.sequpdate = sequpdate;

function setKmod(val) {
	var normalized = parseInt(val, 10);
	if (!isFinite(normalized)) return;
	// Retired mode 4 is mapped to Main so old presets cannot open a blank page.
	if (normalized === 4) normalized = 1;
	if (normalized < 1 || normalized > 3) return;
	if (normalized !== s.kmod) {
		var prev = s.kmod;
		s.kmod = normalized;
		onKmodChange(prev, s.kmod);
	}
}

function drawPage(page) {
	switch (page) {
		case 1: drawMainPage(); break;
		case 2: drawModPage(); break;
		case 3: drawGroupsPage(); break;
	}
}

function drawModeIndicator(page) {
	if (page === 2) led(15, 0, 15);
	else if (page === 3) led(14, 0, 10);
}

function publishSampleBrowserState() {
	publishHud("sample_browser", sampleBrowserState.active ? 1 : 0,
		sampleBrowserState.selectedTrack, sampleBrowserState.selectedSample,
		sampleBrowserState.page);
}

function sampleBrowserPageCount() {
	return Math.max(1, Math.ceil(sampleBrowserState.count / SAMPLE_BROWSER_PAGE_SIZE));
}

function setSampleBrowserPage(page) {
	var next = clamp(parseInt(page, 10) || 0, 0, sampleBrowserPageCount() - 1);
	if (next === sampleBrowserState.page) return false;
	sampleBrowserState.page = next;
	applySampleBrowserColors();
	renderSampleBrowserFrame(false);
	publishSampleBrowserState();
	return true;
}

function sampleBrowserReset(count, folderCount, folderIndex) {
	sampleBrowserExitHoldTask.cancel();
	sampleBrowserState.active = false;
	sampleBrowserState.count = clamp(parseInt(count, 10) || 0, 0, SAMPLE_BROWSER_LIMIT);
	sampleBrowserState.page = 0;
	sampleBrowserState.folderCount = clamp(parseInt(folderCount, 10) || 1,
		1, SAMPLE_BROWSER_FOLDER_LIMIT);
	sampleBrowserState.folderIndex = clamp(parseInt(folderIndex, 10) || 0,
		0, sampleBrowserState.folderCount - 1);
	sampleBrowserState.colors = new Array(SAMPLE_BROWSER_LIMIT).fill(null);
	sampleBrowserState.sampleIndices = Array.from({ length: SAMPLE_BROWSER_LIMIT },
		function (_, index) { return index; });
	sampleBrowserState.assignments = new Array(16).fill(-1);
	if (!sampleBrowserState.sampleRefs) sampleBrowserState.sampleRefs = new Array(16).fill(null);
	sampleBrowserState.exitTrack = -1;
}

function sampleBrowserColor(index, red, green, blue, globalIndex) {
	var sample = parseInt(index, 10);
	if (!isFinite(sample) || sample < 0 || sample >= SAMPLE_BROWSER_LIMIT) return;
	sampleBrowserState.colors[sample] = [clamp8(red), clamp8(green), clamp8(blue)];
	var globalSample = parseInt(globalIndex, 10);
	sampleBrowserState.sampleIndices[sample] = isFinite(globalSample) && globalSample >= 0 ?
		globalSample : sample;
}

function sampleBrowserAssignment(track, sample) {
	var trackIdx = parseInt(track, 10);
	var sampleIdx = parseInt(sample, 10);
	if (!isFinite(trackIdx) || trackIdx < 0 || trackIdx >= 16) return;
	sampleBrowserState.assignments[trackIdx] = isFinite(sampleIdx) && sampleIdx >= 0 ? sampleIdx : -1;
	if (sampleBrowserState.active) renderSampleBrowserFrame(false);
}

function sampleBrowserReference(track, sample, folderId, path, writeThrough) {
	var trackIdx = parseInt(track, 10);
	var sampleIdx = parseInt(sample, 10);
	if (!isFinite(trackIdx) || trackIdx < 0 || trackIdx >= 16) return;
	if (!isFinite(sampleIdx) || sampleIdx < 0 || !folderId || !path) {
		sampleBrowserState.sampleRefs[trackIdx] = null;
	} else {
		sampleBrowserState.sampleRefs[trackIdx] = {
			folderId: String(folderId),
			path: String(path)
		};
		// A sample-bank snapshot can replay this stable reference after a V8
		// reload. Use it to reconstruct the session registry if a completed take
		// was assigned just before older router code threw during registration.
		if (String(folderId) === "recording") {
			var recordingId = String(path);
			var safeRecordingId = recordingId.replace(/[^A-Za-z0-9_-]/g, "-");
			recordingRegistered(recordingId, SAMPLE_BANK_FIRST_BUFFER + sampleIdx,
				"capture", "/tmp/mlr-" + safeRecordingId + ".wav");
		}
	}
	if (parseInt(writeThrough, 10)) {
		writeThroughActiveTrackSlot(trackIdx, "track sample reference", false);
	}
}

function buildSampleBrowserPalette() {
	// Preserve the real page/editor palette below the split while replacing only
	// the top eight rows with browser semantics.
	var palette = buildPageColorPalette(clamp(s.kmod, 1, 3));
	for (var clearY = 0; clearY <= SAMPLE_BROWSER_TOP_LAST_ROW; clearY++) {
		paintColorPaletteRect(palette, 0, clearY, 15, clearY, SEQUENCE64_COLORS.unavailable);
	}
	for (var track = 0; track < 16; track++) {
		palette[track] = GROUP_COLORS[clamp(trackChannelIndex(track), 0, GROUP_COLORS.length - 1)];
	}
	var firstSample = sampleBrowserState.page * SAMPLE_BROWSER_PAGE_SIZE;
	for (var slot = 0; slot < SAMPLE_BROWSER_PAGE_SIZE; slot++) {
		var sample = firstSample + slot;
		if (sample >= sampleBrowserState.count) break;
		palette[(Math.floor(slot / 16) + SAMPLE_BROWSER_SAMPLE_FIRST_ROW) * 16 + (slot % 16)] =
			sampleBrowserState.colors[sample] || SEQUENCE64_COLORS.unavailable;
	}
	palette[SAMPLE_BROWSER_FOOTER_ROW * 16] = SEQUENCE64_COLORS.sequence;
	palette[SAMPLE_BROWSER_FOOTER_ROW * 16 + 1] = SEQUENCE64_COLORS.sequence;
	for (var page = 0; page < sampleBrowserPageCount(); page++) {
		palette[SAMPLE_BROWSER_FOOTER_ROW * 16 + 4 + page] = SEQUENCE64_COLORS.sampleBrowser;
	}
	for (var folder = 0; folder < sampleBrowserState.folderCount; folder++) {
		palette[SAMPLE_BROWSER_FOOTER_ROW * 16 + SAMPLE_BROWSER_FOLDER_FIRST_COL + folder] =
			SEQUENCE64_COLORS.sampleBrowser;
	}
	palette[SAMPLE_BROWSER_FOOTER_ROW * 16 + 15] = SEQUENCE64_COLORS.exit;
	return palette;
}

function queueSampleBrowserColors() {
	outlet(1, "colorlayersclear");
	queueColorPaletteMaps(buildSampleBrowserPalette());
	queueCurrentEditorShellColors(true);
}

function applySampleBrowserColors() {
	if (!s.autoPageColors) return;
	resetPageColorQueue();
	queueSampleBrowserColors();
	startPageColorQueue();
}

function renderSampleBrowserFrame(refreshColors) {
	if (!sampleBrowserState.active) return false;
	messnamed("togridmatrixanim", "clear_anim");
	var v2UpdateOpened = s.mechaTrellisExtensions === 2;
	if (v2UpdateOpened) outlet(1, "beginupdate");
	try {
		if (refreshColors) applySampleBrowserColors();
		if (v2UpdateOpened) drainPageColorQueueNow();
		if (!beginDisplayFrame()) return false;
		var complete = false;
		try {
			// The ordinary page renderer owns the lower half. Browser ownership blocks
			// its top-half writes, preventing clock/playback callbacks from painting
			// through the sample overlay after this frame commits.
			drawModeIndicator(s.kmod);
			drawPage(s.kmod);
			withSampleBrowserOverlayDraw(function () {
				for (var track = 0; track < 16; track++) {
					led(track, 0, track === sampleBrowserState.selectedTrack ? 15 : 6);
				}
				var assigned = sampleBrowserState.assignments[sampleBrowserState.selectedTrack];
				var firstSample = sampleBrowserState.page * SAMPLE_BROWSER_PAGE_SIZE;
				for (var slot = 0; slot < SAMPLE_BROWSER_PAGE_SIZE; slot++) {
					var sample = firstSample + slot;
					if (sample >= sampleBrowserState.count) break;
					var globalSample = sampleBrowserState.sampleIndices[sample];
					var level = globalSample === assigned ? 10 : 4;
					if (globalSample === sampleBrowserState.selectedSample) level = 15;
					led(slot % 16, Math.floor(slot / 16) + SAMPLE_BROWSER_SAMPLE_FIRST_ROW, level);
				}
				var pageCount = sampleBrowserPageCount();
				led(0, SAMPLE_BROWSER_FOOTER_ROW, sampleBrowserState.page > 0 ? 7 : 2);
				led(1, SAMPLE_BROWSER_FOOTER_ROW,
					sampleBrowserState.page < pageCount - 1 ? 7 : 2);
				for (var page = 0; page < pageCount; page++) {
					led(4 + page, SAMPLE_BROWSER_FOOTER_ROW,
						page === sampleBrowserState.page ? 15 : 4);
				}
				for (var folder = 0; folder < sampleBrowserState.folderCount; folder++) {
					led(SAMPLE_BROWSER_FOLDER_FIRST_COL + folder, SAMPLE_BROWSER_FOOTER_ROW,
						folder === sampleBrowserState.folderIndex ? 15 : 4);
				}
				led(15, SAMPLE_BROWSER_FOOTER_ROW, 6);
			});
			complete = true;
		} finally {
			finishDisplayFrame(complete);
		}
		return complete;
	} finally {
		if (v2UpdateOpened) outlet(1, "endupdate");
	}
}

function sampleBrowserOpen(track, sample) {
	if (!sampleBrowserState.count) {
		publishHud("notice", "warn", "Load or scan a sample bank first");
		return false;
	}
	sampleBrowserState.selectedTrack = clamp(parseInt(track, 10) || 0, 0, 15);
	var requestedSample = parseInt(sample, 10);
	sampleBrowserState.selectedSample = isFinite(requestedSample) && requestedSample >= 0 ?
		clamp(requestedSample, 0, sampleBrowserState.count - 1) : -1;
	var localSample = sampleBrowserState.selectedSample >= 0 ?
		sampleBrowserState.sampleIndices.indexOf(sampleBrowserState.selectedSample) : -1;
	if (localSample >= sampleBrowserState.count) localSample = -1;
	sampleBrowserState.page = localSample >= 0 ?
		Math.floor(localSample / SAMPLE_BROWSER_PAGE_SIZE) : 0;
	resetModRandomizeGesture();
	sampleBrowserState.active = true;
	sampleBrowserState.exitTrack = -1;
	applySampleBrowserColors();
	renderSampleBrowserFrame(false);
	publishSampleBrowserState();
	publishHud("notice", "info", "Sample grid above, ṛta below: tap to assign immediately");
	return true;
}

function sampleBrowserClose() {
	if (!sampleBrowserState.active) return false;
	sampleBrowserExitHoldTask.cancel();
	sampleBrowserState.active = false;
	sampleBrowserState.exitTrack = -1;
	renderCompletePage(s.kmod, false);
	publishSampleBrowserState();
	publishHud("notice", "info", "Sample grid closed");
	return true;
}

function commitSampleBrowserExitHold() {
	if (sampleBrowserState.active &&
		sampleBrowserState.exitTrack === sampleBrowserState.selectedTrack) sampleBrowserClose();
}

function dispatchSampleBrowser(col, row, state) {
	if (!sampleBrowserState.active) return false;
	if (row > SAMPLE_BROWSER_TOP_LAST_ROW) return false;
	if (row === 0) {
		if (state) {
			if (col === sampleBrowserState.selectedTrack) {
				sampleBrowserState.exitTrack = col;
				sampleBrowserExitHoldTask.cancel();
				sampleBrowserExitHoldTask.schedule(SAMPLE_BROWSER_EXIT_HOLD_MS);
			} else {
				sampleBrowserExitHoldTask.cancel();
				sampleBrowserState.exitTrack = -1;
				sampleBrowserState.selectedTrack = col;
				publishHud("browser_selection", col, -1);
				renderSampleBrowserFrame(false);
				publishSampleBrowserState();
			}
		} else if (sampleBrowserState.exitTrack === col) {
			sampleBrowserExitHoldTask.cancel();
			sampleBrowserState.exitTrack = -1;
		}
		return true;
	}
	if (row === SAMPLE_BROWSER_FOOTER_ROW) {
		if (!state) return true;
		if (col === 0) setSampleBrowserPage(sampleBrowserState.page - 1);
		else if (col === 1) setSampleBrowserPage(sampleBrowserState.page + 1);
		else if (col >= 4 && col < 4 + sampleBrowserPageCount()) {
			setSampleBrowserPage(col - 4);
		} else if (col >= SAMPLE_BROWSER_FOLDER_FIRST_COL &&
			col < SAMPLE_BROWSER_FOLDER_FIRST_COL + sampleBrowserState.folderCount) {
			messnamed("sample_bank", "selectFolder",
				col - SAMPLE_BROWSER_FOLDER_FIRST_COL, sampleBrowserState.selectedTrack);
		} else if (col === 15) sampleBrowserClose();
		return true;
	}
	if (!state) return true;
	var localIndex = sampleBrowserState.page * SAMPLE_BROWSER_PAGE_SIZE +
		(row - SAMPLE_BROWSER_SAMPLE_FIRST_ROW) * 16 + col;
	if (localIndex < 0 || localIndex >= sampleBrowserState.count) return true;
	var sample = sampleBrowserState.sampleIndices[localIndex];
	if (!isFinite(sample) || sample < 0) return true;
	sampleBrowserState.selectedSample = sample;
	sampleBrowserState.assignments[sampleBrowserState.selectedTrack] = sample;
	messnamed("sample_bank", "assign", sampleBrowserState.selectedTrack, sample);
	renderSampleBrowserFrame(false);
	publishSampleBrowserState();
	return true;
}

/**
 * Synchronize legacy control state, render a complete router-owned page into
 * scratch arrays, then atomically swap it into the matrix bridge. Legacy Max
 * patchers still receive kmod, but their callback-time LED writes are ignored;
 * the renderer below is the only display authority for the committed frame.
 */
function renderCompletePage(page, synchronizeLegacyState, skipColorRefresh) {
	var target = clamp(parseInt(page, 10) || 1, 1, 3);
	if (sampleBrowserState.active) return renderSampleBrowserFrame(false);
	messnamed("togridmatrixanim", "clear_anim");
	if (synchronizeLegacyState) {
		withSuppressedDisplayWrites(function () {
			messnamed("kmod", "int", target);
		});
	}
	// Retire stale editor-overlay commands before the complete page palette is
	// queued. Doing this afterward also removed the new lower-half base maps,
	// leaving old ṛta colors visible when no editor target was active.
	if (s.editorBrightnessColors) {
		clearQueuedEditorShellColors();
		invalidateEditorColorCache();
	}
	var v2UpdateOpened = s.mechaTrellisExtensions === 2;
	if (v2UpdateOpened) outlet(1, "beginupdate");
	try {
		if (s.autoPageColors && !skipColorRefresh) activatePageColors(target);
		if (v2UpdateOpened) drainPageColorQueueNow();
		if (!beginDisplayFrame()) return false;
		var complete = false;
		try {
			drawModeIndicator(target);
			drawPage(target);
			complete = true;
		} finally {
			finishDisplayFrame(complete);
		}
		if (complete) {
			diagnosticEvent("display_frame_commit", {
				page: target,
				width: s.gridWidth,
				height: s.gridHeight,
				legacySync: synchronizeLegacyState ? 1 : 0
			});
		}
		return complete;
	} finally {
		if (v2UpdateOpened) outlet(1, "endupdate");
	}
}

function onKmodChange(prev, next) {
	post("[grid_router] kmod " + prev + " -> " + next + " (tick=" + s.automation.tick + ")\n");
	diagnosticEvent("kmod_change", { previous: prev, next: next });
	if (sampleBrowserState.active) {
		sampleBrowserExitHoldTask.cancel();
		sampleBrowserState.active = false;
		sampleBrowserState.exitTrack = -1;
		publishSampleBrowserState();
	}
	resetModRandomizeGesture();
	resetHeldLoopCols();
	if (sequence64LayoutEnabled()) {
		var workspace = ensureEditorWorkspaceDefaults();
		workspace.choosing = false;
		sequence64HeldStep = -1;
		sequence64HeldStepChanged = false;
		sequence64PressedStep = -1;
		sequence64StepHoldOpened = false;
		sequence64PendingLengthIndex = -1;
		sequence64PendingBarIndex = -1;
		sequence64BarHoldCommitted = false;
		sequence64StepHoldTask.cancel();
		sequence64LengthHoldTask.cancel();
		sequence64BarHoldTask.cancel();
		sequence64RunShortcutHoldTask.cancel();
		sequence64PendingRunShortcut = null;
		if (sequence64LiveRecordHeld || sequence64LiveRecordTake) {
			releaseSequence64LiveRecording(true);
		}
		sequence64LockRecordHeld = false;
	} else if (next !== 2) resetEditorWorkspaceState(true);

	renderCompletePage(next, true);
	publishHud("mode", s.kmod);
	publishHudEditorState();
	publishHudCurrentPattern();
}

// ─── Main Dispatch ──────────────────────────────────────────────────────

function dispatch(col, row, state) {
	if (isNaN(col) || isNaN(row) || isNaN(state)) return;
	col = clamp(col, 0, s.gridWidth - 1);
	row = clamp(row, 0, s.gridHeight - 1);
	state = state ? 1 : 0;
	// The browser is a modal performance overlay. Legacy grid automation was
	// recorded against Main/Mod controls and must not be reinterpreted as sample
	// audition or assignment gestures while the overlay is visible.
	if (sampleBrowserState.active && playbackDispatching &&
		row <= SAMPLE_BROWSER_TOP_LAST_ROW) return;
	if (dispatchSampleBrowser(col, row, state)) return;

	if (s.kmod === 1 && row > 0 && state === 1) {
		diagnosticEvent("main_grid_trigger", function () {
			var manualDetails = diagnosticTrackSnapshot(row - 1, col);
			manualDetails.playbackDispatch = playbackDispatching ? 1 : 0;
			return manualDetails;
		});
	}

	if (sequence64LayoutEnabled() && s.kmod === 1 && col === EDITOR_BUTTON_COL && row === 0 &&
		ensureEditorWorkspaceDefaults().active) {
		if (state === 1) beginSequence64LiveRecording();
		else releaseSequence64LiveRecording(false);
		led(EDITOR_BUTTON_COL, 0, sequence64LiveRecordHeld ? 15 : 6);
		outlet(2, "editor_live_record", sequence64LiveRecordHeld ? 1 : 0);
		publishHudEditorState();
		return;
	}

	// A hold may open the lower-half editor over a track shortcut before that
	// button is released. Finish the gesture before editor ownership can consume
	// the release, otherwise tracks 8-15 would leave a stale pending hold.
	if (state === 0 && s.kmod === 2 && sequence64PendingRunShortcut) {
		var pendingRunCoordinates = sequence64RunShortcutCoordinates(
			sequence64PendingRunShortcut.targetType,
			sequence64PendingRunShortcut.targetId);
		if (pendingRunCoordinates && pendingRunCoordinates.x === col &&
			pendingRunCoordinates.y === row) {
			handleSequence64RunShortcutKey(
				sequence64PendingRunShortcut.targetType,
				sequence64PendingRunShortcut.targetId, state);
			return;
		}
	}

	if (handleEditorWorkspaceKey(col, row, state)) {
		publishHudAfterGridAction(state, col, row);
		return;
	}

	if (shouldRecordAutomationEvent(col, row, state)) {
		recordEvent(col, row, state);
	}

	if (row === 0) {
		handleRow0(col, state);
		publishHudAfterGridAction(state, col, row);
		return;
	}

	switch (s.kmod) {
		case 1: handleNormalMode(col, row, state); break;
		case 2: handleModPage(col, row, state); break;
		case 3: handleGroupsPage(col, row, state); break;
	}
	publishHudAfterGridAction(state, col, row);
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
			sendNamedInt("[ch]randomfun", 1);
			kfping(8, 0, 6);
		}
		// Page 2 keeps the capture source control in the same column as the
		// per-track capture buttons. Row 0 is routed here before handleModPage.
		if (s.kmod === 2 && col === TRACK_CAPTURE_COL) {
			messnamed("sample_bank", "toggleCaptureSource");
		}
	} else if (col === 14) {
		setKmod(s.kmod === 3 ? 1 : 3); // groups page toggles directly with Main
	} else if (col === 15) {
		setKmod(s.kmod !== 1 ? 1 : 2); // mod page toggle
	}
}

function handleRow0Channel(col) {
	var ch = col + 1;
	if (s.kmod === 1) {
		diagnosticEvent("channel_stop", { channel: ch });
		cancelSequence64PhraseForChannel(col, "manual_stop", false);
		cancelSequence64AudioForChannel(col);
		getChannelStateByIndex(col).sequence64Owner = null;
		clearChannelPlaybackPositions(col, -1);
		modulationTrigger("group", col, 0);
		sendNamedInt(ch + "[pl]stop", 1);
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
		sendNamedInt(idx + "pp", 0);
		drawSequencerLed(idx);
		outlet(2, "pattern", idx, 0, "off");
	} else {
		s.sequencers[idx].on = 1;
		s.sequencers[idx].phase = 0;
		sendNamedInt(idx + "pp", 1);
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
	s.tracks[trackIdx].octave = clamp(parseInt(oct, 10) || 0, -8, 8);
	s.tracks[trackIdx].length = clamp(parseInt(length, 10) || 16, 1, 16);
	s.tracks[trackIdx].speed = parseFloat(speed) || 0;
	s.tracks[trackIdx].speedMode = parseInt(speed2, 10) || 0;
	s.tracks[trackIdx].reverse = reverse;
	s.tracks[trackIdx].channel = group;
	s.tracks[trackIdx].randomOffset = randomOffset;
	diagnosticEvent("track_state_update", function () {
		var updateDetails = diagnosticTrackSnapshot(trackIdx);
		updateDetails.fileIndex = fileindex;
		updateDetails.speed = speed;
		updateDetails.speed2 = speed2;
		updateDetails.randomOffset = randomOffset;
		return updateDetails;
	});
	if (s.tracks[trackIdx].loopActive) {
		clearLoopVisualForTrackIndex(trackIdx, true);
	}

	sendNamedInt(group + "[ch]update", 1);
	var channelState = getChannelStateByIndex(clamp((parseInt(group, 10) || 1) - 1, 0, s.NUM_CHANNELS - 1));
	if (channelState && channelState.gateLatch && channelState.activeTrack === trackIdx) {
		reapplyTrackSubLoopAfterTrigger(trackIdx);
	}

	if (s.kmod === 2) {
		drawRandomOffsetColumn();
		drawOctaveColumns();
		drawReverseColumn();
		refreshActiveEditorShell();
	}
	if (s.kmod === 3) drawGroupsPage();
	publishHudTrackState(trackIdx);
	publishHudChannelState(clamp((parseInt(group, 10) || 1) - 1,
		0, s.NUM_CHANNELS - 1));
	writeThroughActiveTrackSlot(trackIdx, "track edit");
}

function chGroup(ch, grp) {
	if (!s.tracks[ch - 2]) {
		post("bad track, ch: " + ch + " grp: " + grp + "\n");
		return;
	}
	s.tracks[ch - 2].channel = grp; // old ch send names start at 2
	diagnosticEvent("track_group_update", function () {
		return diagnosticTrackSnapshot(ch - 2);
	});
	if (s.kmod === 3) { // we would be in this function potentially from a change from the patch ui so check
		ledRow(ch - 1, 0);
		drawGroupsPage();
	}
	refreshActiveEditorShell();
	publishHudTrackState(ch - 2);
	publishHudChannelState(clamp((parseInt(grp, 10) || 1) - 1,
		0, s.NUM_CHANNELS - 1));
	writeThroughActiveTrackSlot(ch - 2, "track group");
}

function captureSequence64RowPosition(trackIdx, pos) {
	var workspace = ensureEditorWorkspaceDefaults();
	if (!sequence64LayoutEnabled() || !workspace.active || s.kmod !== 1) return false;
	var position = clamp(parseInt(pos, 10) || 0, 0, 15);
	if (!sequence64PendingLiveCut || sequence64PendingLiveCut.track !== trackIdx ||
		(s.automation.tick || 0) > sequence64PendingLiveCut.expiresTick) return false;
	if (sequence64PlaybackCaptureGuard &&
		sequence64PlaybackCaptureGuard.track === trackIdx &&
		sequence64PlaybackCaptureGuard.slice === position &&
		(s.automation.tick || 0) <= sequence64PlaybackCaptureGuard.expiresTick) {
		sequence64PlaybackCaptureGuard = null;
		return false;
	}
	if (workspace.targetType === "track" && workspace.targetId !== trackIdx) return false;
	if (workspace.targetType === "group" && trackChannelIndex(trackIdx) !== workspace.targetId) return false;
	var pattern = currentSequence64Pattern();
	if (!pattern) return false;
	var take = sequence64LiveRecordTake;
	var eventClock = sequence64ClockPosition;
	if (take && sequence64PendingLiveCut.takeId === take.id &&
		take.targetKey === currentEditorTargetKey()) {
		if (take.startClock === null) take.startClock = eventClock;
		take.events.push({ clock: eventClock, track: trackIdx, slice: position });
	}
	var playback = currentSequence64PlaybackLocation(pattern);
	var stepIndex = playback.step;
	var step = pattern.bars[playback.bar].steps[stepIndex];
	var existingGateLength = step.cut ? step.cut.gateLength : 1;
	delete step.locks.slice;
	step.cut = { track: trackIdx, slice: position, gateLength: existingGateLength };
	rememberSequence64EditTrack(pattern, workspace.targetType, workspace.targetId, trackIdx);
	sequence64PendingLiveCut = null;
	outlet(2, "editor_live_cut", workspace.targetType, workspace.targetId + 1,
		playback.bar + 1, stepIndex + 1, trackIdx + 1, position + 1);
	if (take && take.releaseClock !== null) finishSequence64LiveRecording();
	return true;
}



function queuePlaybackDisplay(editorDirty) {
	if (editorDirty) playbackDisplayEditorDirty = true;
	if (playbackDisplayPending) return;
	playbackDisplayPending = true;
	playbackDisplayTask.schedule(PLAYBACK_DISPLAY_INTERVAL_MS);
}

function resetPlaybackDisplay() {
	playbackDisplayTask.cancel();
	playbackDisplayPending = false;
	playbackDisplayEditorDirty = false;
	playbackDisplayTracks = {};
	playbackDisplayBackgroundTracks = {};
}

function flushPlaybackDisplay() {
	var tracks = playbackDisplayTracks;
	var backgrounds = playbackDisplayBackgroundTracks;
	var editorDirty = playbackDisplayEditorDirty;
	playbackDisplayPending = false;
	playbackDisplayEditorDirty = false;
	playbackDisplayTracks = {};
	playbackDisplayBackgroundTracks = {};
	var channels = {};
	var workspace = ensureEditorWorkspaceDefaults();
	if (s.kmod === 1) {
		for (var backgroundTrack in backgrounds) redrawTrackBackground(parseInt(backgroundTrack, 10));
	}
	for (var key in tracks) {
		var trackIdx = parseInt(key, 10);
		var entry = tracks[key];
		var channelIdx = trackChannelIndex(trackIdx);
		var channel = getChannelStateByIndex(channelIdx);
		// A newer cut/stop/group edit can supersede telemetry before this task.
		// Use current ownership and position, never replay a captured playhead.
		if (channel && channel.activeTrack === trackIdx) {
			if (s.kmod === 1) {
				for (var sibling = 0; sibling < s.NUM_TRACKS && sibling + 1 < s.gridHeight; sibling++) {
					if (sibling !== trackIdx && trackChannelIndex(sibling) === channelIdx) ledRow(sibling + 1, 0);
				}
				if (!entry.returnedEditorPing && entry.position === s.tracks[trackIdx].playPos) {
					kfping(entry.position, trackIdx + 1, 15, 24);
				}
			} else if (s.kmod === 2) {
				pulseModRandomizeCell(trackIdx + 2);
				if ((sequence64LayoutEnabled() && workspace.active && workspace.view64 === "sequence") ||
					(!sequence64LayoutEnabled() && workspace.editorId === "loop")) editorDirty = true;
			}
		}
		publishHudTrackState(trackIdx);
		channels[channelIdx] = true;
	}
	for (var channelKey in channels) publishHudChannelState(parseInt(channelKey, 10));
	if (editorDirty) {
		if (workspace.active && sequence64LayoutEnabled()) {
			var pattern = sequence64PlaybackPattern(workspace.targetType, workspace.targetId);
			var playback = sequence64TargetPlaybackLocation(workspace.targetType, workspace.targetId, pattern);
			publishHud("pattern_playhead", workspace.targetType, workspace.targetId,
				playback.bar, playback.step, sequence64DecisionOutcomeAt(workspace.targetType,
					workspace.targetId, playback.bar, playback.step));
		}
		if (s.kmod === 2 && !workspace.choosing &&
			(!sequence64LayoutEnabled() || workspace.view64 === "sequence" || workspace.view64 === "scene")) {
			var previousReadMode = sequence64PlaybackDisplayReading;
			sequence64PlaybackDisplayReading = true;
			try { redrawEditorShellDiff(); }
			finally { sequence64PlaybackDisplayReading = previousReadMode; }
		}
	}
}

function chRowPos(row, pos) {
	var trackIdx = row - 2;
	var normalizedPosition = clamp(parseInt(pos, 10) || 0, 0, s.gridWidth - 1);
	var returnedEditorPing = consumeSequence64PlaybackPingGuard(trackIdx, normalizedPosition);
	var trackState = getTrackStateByIndex(trackIdx);
	if (trackState) {
		trackState.playPos = normalizedPosition;
		var positionChannelIdx = trackChannelIndex(trackIdx);
		var positionChannel = getChannelStateByIndex(positionChannelIdx);
		positionChannel.activeTrack = trackIdx;
		// Playback telemetry is the authoritative persistent playhead. Sequencer
		// and live-lane trigger flashes are foreground hints only; without this
		// update their primed slice can remain visible while groove~ moves on.
		clearChannelPlaybackPositions(positionChannelIdx, trackIdx, true);
		primeTrackPlaybackPosition(trackIdx, normalizedPosition, true);
		// chRowPos is playback telemetry and may arrive continuously while a
		// sample plays. It cannot by itself distinguish a manual cut from normal
		// motion, so it must never cancel the phrase that produced it. Explicit
		// manual grid/live-lane trigger paths perform that cancellation directly.
		diagnosticEventRateLimited("playback_position", trackIdx,
			function () { return diagnosticTrackSnapshot(trackIdx, normalizedPosition); });
	}
	captureSequence64RowPosition(trackIdx, pos);
	if (trackState) {
		playbackDisplayTracks[trackIdx] = {
			position: normalizedPosition, returnedEditorPing: returnedEditorPing
		};
		queuePlaybackDisplay(false);
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
			var channelState = getChannelStateByIndex(trackChannelIndex(trackIdx));
			cancelSequence64PhraseForChannel(trackChannelIndex(trackIdx),
				"manual_cut", false);
			cancelSequence64AudioForChannel(trackChannelIndex(trackIdx));
			channelState.activeTrack = trackIdx;
			channelState.sequence64Owner = null;
			applyNativeModulationGroup(trackChannelIndex(trackIdx), trackIdx);
			modulationTrigger("group", trackChannelIndex(trackIdx), 0);
			modulationTrigger("group", trackChannelIndex(trackIdx), 1);
		}
		var workspace = ensureEditorWorkspaceDefaults();
		if (sequence64LayoutEnabled() && sequence64LiveRecordHeld && workspace.active &&
			((workspace.targetType === "track" && workspace.targetId === trackIdx) ||
			(workspace.targetType === "group" && trackChannelIndex(trackIdx) === workspace.targetId))) {
			sequence64PendingLiveCut = {
				track: trackIdx,
				rawSlice: col,
				takeId: sequence64LiveRecordTake ? sequence64LiveRecordTake.id : -1,
				expiresTick: (s.automation.tick || 0) + 2
			};
		}
	}
	if (state === 0) modulationTrigger("track", trackIdx, 0);
	sendTrackInput(trackIdx, col, state);
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
	sendNamedInt(ch + "[ch]timestretch", s.channels[col].timestretch ? 1 : 0);
	led(col, 3, s.channels[col].timestretch ? 15 : 0);
	refreshActiveEditorShell();
}

function handleModPage(col, row, state) {
	if (col < 8 && row === 5) {
		if (state === 1) phaseCutToggle(col);
		return;
	}
	if (!Product.rta && row === 4 && col < 8) {
		if (state === 1) { handleChannelGateLatchToggle(col); drawSequence64GroupRunRow(); }
		return;
	}
	if (!Product.rta && col === 11 && row >= 1) {
		if (state === 1) { handleTrackSubLoopCycle(row); drawSequence64TrackRunColumn(); }
		return;
	}
	if (rtaEnabled() && col < 8 && row === 4) {
		handleSequence64RunShortcutKey("group", col, state);
		return;
	}
	if (rtaEnabled() && col === 11 && row >= 1) {
		handleSequence64RunShortcutKey("track", row - 1, state);
		return;
	}
	if (col === 8 && row >= 1) {
		handleModRandomizeGesture(row, state);
		return;
	}
	if (col === TRACK_CAPTURE_COL) {
		if (row === 0) {
			if (state) messnamed("sample_bank", "toggleCaptureSource");
		} else handleTrackCapture(row, state);
		return;
	}
	if (state !== 1) return;

	if (col < 8) {
		if (row === 0) {
			handleModMute(col);
		} else if (row === 1 || row === 2) {
			handleModVolume(col, row);
		} else if (row === 3) {
			handleTimestretchToggle(col);
		}
	} else if (col === 10 && row >= 1 && row <= 5) {
		handleQuantize(row);
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

function captureLevelForState(state) {
	if (state === "armed") return 8;
	if (state === "recording") return 15;
	if (state === "finishing") return 12;
	if (state === "complete") return 6;
	return TRACK_CAPTURE_IDLE_LEVEL;
}

function drawTrackCaptureCell(trackIndex) {
	var row = trackIndex + 1;
	if (row < 1 || row >= s.gridHeight || editorOwnsLedCell(TRACK_CAPTURE_COL, row)) return;
	var capture = trackCaptureStates[trackIndex] || { state: "idle" };
	led(TRACK_CAPTURE_COL, row, captureLevelForState(capture.state));
}

function drawTrackCaptureColumn() {
	led(TRACK_CAPTURE_COL, 0, trackCaptureSource === "mix" ? 15 : 6);
	for (var track = 0; track < s.NUM_TRACKS && track + 1 < s.gridHeight; track++) {
		drawTrackCaptureCell(track);
	}
}

function captureSourceState(source) {
	trackCaptureSource = String(source || "").toLowerCase() === "mix" ? "mix" : "input";
	if (s.kmod === 2 && !editorOwnsLedCell(TRACK_CAPTURE_COL, 0)) {
		led(TRACK_CAPTURE_COL, 0, trackCaptureSource === "mix" ? 15 : 6);
	}
	publishHud("capture_source", trackCaptureSource);
}

function handleTrackCapture(row, state) {
	var trackIndex = row - 1;
	if (trackIndex < 0 || trackIndex >= s.NUM_TRACKS) return false;
	if (state) {
		trackCaptureStates[trackIndex] = {
			state: "armed", bufferIndex: 0, recordingId: "", durationMs: 0
		};
		drawTrackCaptureCell(trackIndex);
		messnamed("sample_bank", "capturePress", trackIndex);
	} else {
		messnamed("sample_bank", "captureRelease", trackIndex);
	}
	return true;
}

// State feedback from the native capture engine arrives through sample_bank,
// which owns buffer allocation and registers the completed recording asset.
function trackCaptureState(track, state, bufferIndex, durationMs, recordingId) {
	var trackIndex = parseInt(track, 10);
	if (!isFinite(trackIndex) || trackIndex < 0 || trackIndex >= s.NUM_TRACKS) return false;
	trackCaptureStates[trackIndex] = {
		state: String(state || "idle"),
		bufferIndex: parseInt(bufferIndex, 10) || 0,
		recordingId: String(recordingId || ""),
		durationMs: parseFloat(durationMs) || 0
	};
	drawTrackCaptureCell(trackIndex);
	publishHud("track_capture", trackIndex, trackCaptureStates[trackIndex].state,
		trackCaptureStates[trackIndex].bufferIndex, trackCaptureStates[trackIndex].durationMs,
		trackCaptureStates[trackIndex].recordingId);
	return true;
}

function recordingRegistered(recordingId, bufferIndex, source, temporaryPath) {
	var id = String(recordingId || "");
	var buffer = clamp(parseInt(bufferIndex, 10) || 0, 0, 250);
	if (!id || !buffer) return false;
	if (!Array.isArray(s.sessionRecordings)) s.sessionRecordings = [];
	var descriptor = null;
	for (var index = 0; index < s.sessionRecordings.length; index++) {
		if (String(s.sessionRecordings[index].id || "") === id) {
			descriptor = s.sessionRecordings[index];
			break;
		}
	}
	if (!descriptor) {
		descriptor = {};
		s.sessionRecordings.push(descriptor);
	}
	descriptor.id = id;
	descriptor.source = String(source || "input");
	descriptor.bufferIndex = buffer;
	descriptor.bufferName = buffer + "file";
	descriptor.temporaryPath = String(temporaryPath || "");
	descriptor.catalogSample = 1;
	return true;
}

function resetModRandomizeGesture() {
	modRandomizeHoldTask.cancel();
	modRandomizePendingRow = -1;
	modRandomizeHoldCommitted = false;
}

function commitModRandomizeHold() {
	if (s.kmod !== 2 || modRandomizePendingRow < 1) return;
	modRandomizeHoldCommitted = true;
	// Record the resolved long-press action, not the initial touch. Playback of
	// that stored event takes the immediate path below and never waits for a
	// release event that the legacy automation recorder does not store.
	if (!playbackDispatching && (s.automation.armed || s.automation.recording)) {
		recordEvent(8, modRandomizePendingRow, 1);
	}
	handleModRandomize(modRandomizePendingRow);
}

function handleModRandomizeGesture(row, state) {
	if (s.kmod !== 2 || row < 1 || row >= s.gridHeight) return;
	if (playbackDispatching) {
		if (state) handleModRandomize(row);
		return;
	}
	if (state) {
		modRandomizeHoldTask.cancel();
		modRandomizePendingRow = row;
		modRandomizeHoldCommitted = false;
		modRandomizeHoldTask.schedule(MOD_RANDOMIZE_HOLD_MS);
		return;
	}
	if (modRandomizePendingRow !== row) return;
	modRandomizeHoldTask.cancel();
	if (!modRandomizeHoldCommitted) {
		messnamed("sample_bank", "browserOpen", row - 1, -1);
	}
	modRandomizePendingRow = -1;
	modRandomizeHoldCommitted = false;
}

/** Col 8 mod page: row 0 = randomize all channels; rows 1+ = per-track only. */
function handleModRandomize(row) {
	if (s.kmod !== 2) return;
	if (row === 0) {
		sendNamedInt("[ch]randomfun", 1);
		for (var i = 0; i < s.NUM_TRACKS; i++) {
			clearLoopVisualForTrackIndex(i, true);
		}
		kfping(8, 0, 6);
		return;
	}
	var trackId = row + 1;
	clearLoopVisualForTrackIndex(row - 1, true);
	sendNamedInt(trackId + "[box]rnd", 1);
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
	sendNamedInt((col + 1) + "[box]mute", s.channels[col].muted);
	drawMuteRow();
	refreshActiveEditorShell();
}

function handleModVolume(col, row) {
	if (s.kmod !== 2) return;
	var delta = (row === 1) ? 4 : -4;
	sendNamedInt((col + 1) + "vol_add", delta);
	s.channels[col].volume = clamp(s.channels[col].volume + delta, 0, 158);
	updateVolumeDisplay(col);
	refreshActiveEditorShell();
}

function handleQuantize(row) {
	if (s.kmod !== 2) return;
	var qValues = { 1: 32, 2: 16, 3: 8, 4: 4, 5: 2 };
	var qVal = qValues[row];
	if (qVal !== undefined) {
		sendNamedInt("[mlr]q", qVal);
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
	refreshActiveEditorShell();
}

function handleTrackSubLoopCycle(row) {
	if (s.kmod !== 2) return;
	var trackIdx = row - 1;
	var trackState = getTrackStateByIndex(trackIdx);
	if (!trackState) return;
	cycleTrackSubLoopDiv(trackIdx);
	post("[grid_router] track " + row + " subLoop=1/" + currentTrackSubLoopDiv(trackIdx) + "\n");
	refreshActiveEditorShell();
}

function sequence64RunShortcutCoordinates(targetType, targetId) {
	if (targetType === "group" && targetId >= 0 && targetId < s.NUM_CHANNELS) {
		return { x: targetId, y: 4 };
	}
	if (targetType === "track" && targetId >= 0 && targetId < s.NUM_TRACKS) {
		return { x: 11, y: targetId + 1 };
	}
	return null;
}

function drawSequence64RunShortcut(targetType, targetId) {
	if (!rtaEnabled()) return;
	var coordinates = sequence64RunShortcutCoordinates(targetType, targetId);
	if (!coordinates || editorOwnsLedCell(coordinates.x, coordinates.y)) return;
	var pattern = ensureSequence64Pattern(targetType, targetId);
	led(coordinates.x, coordinates.y, pattern && pattern.running ? 15 : 3);
}

function toggleSequence64RunShortcut(targetType, targetId) {
	if (!rtaEnabled()) return false;
	var pattern = ensureSequence64Pattern(targetType, targetId);
	if (!pattern) return false;
	setSequence64TargetRunning(targetType, targetId, !pattern.running);
	drawSequence64RunShortcut(targetType, targetId);
	return true;
}

function openSequence64RunShortcutAfterHold() {
	if (!rtaEnabled()) return false;
	var pending = sequence64PendingRunShortcut;
	if (!pending || s.kmod !== 2 || !sequence64LayoutEnabled()) return false;
	pending.holdOpened = true;
	selectEditorTarget(pending.targetType, pending.targetId, true);
	diagnosticEvent("sequence64_run_shortcut_hold", {
		targetType: pending.targetType,
		target: pending.targetId + 1
	});
	outlet(2, "editor_shortcut", pending.targetType, pending.targetId + 1);
	return true;
}

function handleSequence64RunShortcutKey(targetType, targetId, state) {
	if (!rtaEnabled()) return false;
	if (s.kmod !== 2 || !sequence64LayoutEnabled()) return;
	var coordinates = sequence64RunShortcutCoordinates(targetType, targetId);
	if (!coordinates) return;
	if (state === 1) {
		sequence64RunShortcutHoldTask.cancel();
		sequence64PendingRunShortcut = {
			targetType: targetType,
			targetId: targetId,
			holdOpened: false
		};
		var pattern = ensureSequence64Pattern(targetType, targetId);
		led(coordinates.x, coordinates.y, pattern && pattern.running ? 10 : 8);
		sequence64RunShortcutHoldTask.schedule(SEQUENCE64_HOLD_MS);
		return;
	}

	var pending = sequence64PendingRunShortcut;
	if (!pending || pending.targetType !== targetType || pending.targetId !== targetId) return;
	sequence64RunShortcutHoldTask.cancel();
	sequence64PendingRunShortcut = null;
	if (!pending.holdOpened) toggleSequence64RunShortcut(targetType, targetId);
	else drawSequence64RunShortcut(targetType, targetId);
}

function handleModRandomOffset(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	setEditorRandomOffset(track, !s.tracks[track].randomOffset, false);
	drawRandomOffsetColumn();
	refreshActiveEditorShell();
}

function handleHalfTime(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	setEditorOctave(track, (parseInt(s.tracks[track].octave, 10) || 0) - 1, false);
	drawOctaveCell(row);
	refreshActiveEditorShell();
}

function handleDoubleTime(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	setEditorOctave(track, (parseInt(s.tracks[track].octave, 10) || 0) + 1, false);
	drawOctaveCell(row);
	refreshActiveEditorShell();
}

function handleReverse(row) {
	if (s.kmod !== 2) return;
	var track = row - 1;
	setEditorReverse(track, !s.tracks[track].reverse, false);
	drawReverseColumn();
	refreshActiveEditorShell();
}

// ─── Groups Page (kmod 3) ──────────────────────────────────────────────

function handleGroupsPage(col, row, state) {
	if (s.kmod !== 3) return;
	var track = row - 1;
	var channelId = col - 7;
	clearLoopVisualForTrackIndex(track, true);
	sendNamedInt((row + 1) + "chn[box]", channelId);
	//s.tracks[track].channel = channelId;
	//drawGroupsPage();
}

// ─── Draw Functions ─────────────────────────────────────────────────────

function drawModPage() {
	drawMuteRow();
	drawVolumeRows();
	drawInsertFxBlock();
	drawRandomizeColumn();
	drawTrackCaptureColumn();
	drawQuantizeColumn();
	drawSequence64TrackRunColumn();
	drawRandomOffsetColumn();
	drawOctaveColumns();
	drawReverseColumn();
	drawTimestretchRow();
	drawSequence64GroupRunRow();
	drawEditorWorkspaceOverlay();
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
	var vuTop = s.gridHeight - 3; // Retain the established sparse insert-FX area.
	for (var x = 0; x < 8; x++) {
		for (var y = 5; y < vuTop; y++) {
			led(x, y, insert_fx[insertFxIndex(x, y)] ? 12 : 0);
		}
		led(x, 5, phaseCutState(x).enabled ? 15 : 3);
	}
}

function drawRandomizeColumn() {
	led(8, 0, 6);
	for (var y = 1; y < s.gridHeight; y++) {
		led(8, y, 2);
	}
}
/** Legacy output-meter receiver retained for patch compatibility. */
function outputMeter(ch, level) {
	// The grid VU overlay obscured track controls and is intentionally disabled.
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

function drawSequence64GroupRunRow() {
	if (!Product.rta) {
		for (var group = 0; group < 8; group++) led(group, 4, getChannelStateByIndex(group).gateLatch ? 15 : 3);
		return;
	}
	if (!rtaEnabled()) return;
	var workspace = ensureEditorWorkspaceDefaults();
	for (var x = 0; x < 8; x++) {
		var pattern = workspace.patterns64[editorTargetKey("group", x)];
		led(x, 4, pattern && pattern.running ? 15 : 3);
	}
}

function drawSequence64TrackRunColumn() {
	if (!Product.rta) {
		for (var row = 1; row < s.gridHeight; row++) led(11, row, TRACK_SUB_LOOP_BRIGHTNESS[TRACK_SUB_LOOP_OPTIONS.indexOf(currentTrackSubLoopDiv(row - 1))]);
		return;
	}
	if (!rtaEnabled()) return;
	var workspace = ensureEditorWorkspaceDefaults();
	for (var y = 1; y < s.gridHeight; y++) {
		var pattern = workspace.patterns64[editorTargetKey("track", y - 1)];
		led(11, y, pattern && pattern.running ? 15 : 3);
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
	refreshActiveEditorShell();
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
	refreshActiveEditorShell();
}

function handleOldPatternOut() {
	if (s.kmod !== 1) return;
	// Flash the played cell. Channel on/off row-0 LEDs are managed separately
	// by handleChannelOnArray — don't redraw the whole row on every pattern step.
	var col = parseInt(arguments[1], 10);
	var row = parseInt(arguments[2], 10) - 1;
	kfping(col, row, 15);

}

function beginSequence64LiveRecording() {
	if (!rtaEnabled()) return false;
	releaseNativeSequence64("live_record", true);
	if (sequence64LiveRecordHeld) return;
	if (sequence64LiveRecordTake) {
		sequence64LiveRecordTake.releaseClock = sequence64ClockPosition;
		sequence64PendingLiveCut = null;
		finishSequence64LiveRecording();
	}
	sequence64LiveRecordFinalizeTask.cancel();
	sequence64PendingLiveCut = null;
	var workspace = ensureEditorWorkspaceDefaults();
	sequence64LiveRecordTake = {
		id: ++sequence64LiveRecordTakeSerial,
		targetKey: currentEditorTargetKey(),
		targetType: workspace.targetType,
		targetId: workspace.targetId,
		startClock: null,
		releaseClock: null,
		events: []
	};
	sequence64LiveRecordHeld = true;
	outlet(2, "editor_live_take_armed", workspace.targetType, workspace.targetId + 1);
}

function releaseSequence64LiveRecording(finalizeImmediately) {
	sequence64LiveRecordHeld = false;
	var take = sequence64LiveRecordTake;
	if (!take) {
		sequence64PendingLiveCut = null;
		return false;
	}
	if (take.releaseClock === null) take.releaseClock = sequence64ClockPosition;
	var pendingForTake = sequence64PendingLiveCut &&
		sequence64PendingLiveCut.takeId === take.id;
	if (finalizeImmediately || !pendingForTake) {
		if (finalizeImmediately) sequence64PendingLiveCut = null;
		return finishSequence64LiveRecording();
	}
	var finalizeDelay = Math.max(75, sequence64ShapeRampMs() * 12);
	sequence64LiveRecordFinalizeTask.schedule(finalizeDelay);
	return false;
}

function sequence64LiveRecordPendingTimeout() {
	var take = sequence64LiveRecordTake;
	if (!take || take.releaseClock === null) return false;
	if (sequence64PendingLiveCut && sequence64PendingLiveCut.takeId === take.id) {
		sequence64PendingLiveCut = null;
	}
	return finishSequence64LiveRecording();
}

function sequence64LiveTakeLength(take) {
	if (!take || take.startClock === null || !take.events.length) return 0;
	var endClock = take.releaseClock === null ? sequence64ClockPosition : take.releaseClock;
	var lastEventClock = take.events[take.events.length - 1].clock;
	endClock = Math.max(endClock, lastEventClock + 1);
	var elapsedSteps = Math.max(1, endClock - take.startClock);
	var beatCount = Math.round(elapsedSteps / SEQUENCE64_STEPS_PER_BEAT);
	beatCount = clamp(beatCount, 1,
		(SEQUENCE64_MAX_BARS * 64) / SEQUENCE64_STEPS_PER_BEAT);
	return beatCount * SEQUENCE64_STEPS_PER_BEAT;
}

function sequence64GateLengthsByFlatStep(pattern) {
	var gateLengths = {};
	var flat = 0;
	if (!pattern || !pattern.bars) return gateLengths;
	for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
		var bar = pattern.bars[barIndex];
		for (var stepIndex = 0; stepIndex < bar.length; stepIndex++) {
			var step = bar.steps[stepIndex];
			if (step && step.cut) gateLengths[flat] = step.cut.gateLength;
			flat++;
		}
	}
	return gateLengths;
}

function resizeSequence64PatternForTake(pattern, totalSteps) {
	var clampedTotal = clamp(parseInt(totalSteps, 10) || SEQUENCE64_STEPS_PER_BEAT,
		SEQUENCE64_STEPS_PER_BEAT, SEQUENCE64_MAX_BARS * 64);
	var barCount = Math.ceil(clampedTotal / 64);
	var finalBarLength = clampedTotal - ((barCount - 1) * 64);
	// A completed live take defines a new full pattern length, so old manually
	// parked trailing bars do not reappear if the take is later extended.
	pattern.parkedBars = [];
	while (pattern.bars.length < barCount) {
		pattern.bars.push(normalizeSequence64Bar(null, null, 64));
	}
	if (pattern.bars.length > barCount) pattern.bars.length = barCount;
	for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
		pattern.bars[barIndex].length =
			barIndex === pattern.bars.length - 1 ? finalBarLength : 64;
	}
	pattern.currentBar = clamp(pattern.currentBar, 0, pattern.bars.length - 1);
	pattern.steps = pattern.bars[0].steps;
	pattern.length = pattern.bars[0].length;
	return clampedTotal;
}

function finishSequence64LiveRecording() {
	var take = sequence64LiveRecordTake;
	if (!take) return false;
	sequence64LiveRecordFinalizeTask.cancel();
	if (sequence64PendingLiveCut && sequence64PendingLiveCut.takeId === take.id) {
		sequence64PendingLiveCut = null;
	}
	sequence64LiveRecordTake = null;
	if (!take.events.length || take.startClock === null) {
		outlet(2, "editor_live_take_empty", take.targetType, take.targetId + 1);
		return false;
	}

	var pattern = ensureSequence64Pattern(take.targetType, take.targetId);
	if (!pattern) return false;
	var gateLengths = sequence64GateLengthsByFlatStep(pattern);
	var totalSteps = resizeSequence64PatternForTake(pattern, sequence64LiveTakeLength(take));

	// A new performance replaces cut triggers like the original MLR recorder,
	// while parameter locks, probabilities, and gate-length programming survive.
	for (var barIndex = 0; barIndex < pattern.bars.length; barIndex++) {
		for (var stepIndex = 0; stepIndex < 64; stepIndex++) {
			pattern.bars[barIndex].steps[stepIndex].cut = null;
		}
	}
	for (var eventIndex = 0; eventIndex < take.events.length; eventIndex++) {
		var event = take.events[eventIndex];
		var flatStep = ((event.clock % totalSteps) + totalSteps) % totalSteps;
		var location = sequence64PatternLocationAtFlat(pattern, flatStep);
		var step = pattern.bars[location.bar].steps[location.step];
		delete step.locks.slice;
		rememberSequence64EditTrack(pattern, take.targetType, take.targetId, event.track);
		step.cut = {
			track: event.track,
			slice: event.slice,
			gateLength: gateLengths[flatStep] || 1
		};
	}

	var workspace = ensureEditorWorkspaceDefaults();
	if (currentEditorTargetKey() === take.targetKey) {
		var playback = currentSequence64PlaybackLocation(pattern);
		workspace.lastSequencedBar = playback.bar;
		workspace.lastSequencedStep = playback.step;
	}
	outlet(2, "editor_live_take", take.targetType, take.targetId + 1,
		totalSteps, pattern.bars.length, take.events.length);
	markSessionDirty("ṛta live take");
	post("[grid_router] live take " + take.targetKey + " length=" + totalSteps +
		" steps bars=" + pattern.bars.length + " events=" + take.events.length + "\n");
	if (editorWorkspaceAvailable() && workspace.active) redrawEditorShellDiff();
	publishHudPatternSnapshot(take.targetType, take.targetId, pattern);
	return true;
}

function drawChannelsPlaying() {
	if (s.kmod !== 1) return;
	for (var i = 0; i < 8; i++) {
		led(i, 0, s.channels[i].on ? 15 : 0);
	}
	drawSequencerLeds();
	if (sequence64LayoutEnabled() && ensureEditorWorkspaceDefaults().active) {
		led(EDITOR_BUTTON_COL, 0, sequence64LiveRecordHeld ? 15 : 6);
	}
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
		if (!channelState.on) {
			cancelSequence64PhraseForChannel(i, "channel_off", false);
			cancelSequence64AudioForChannel(i);
			if (channelState.activeTrack >= 0) channelState.lastActiveTrack = channelState.activeTrack;
			channelState.activeTrack = -1;
			channelState.sequence64Owner = null;
		}
		publishHudChannelState(i);
	}
	drawChannelsPlaying();
	refreshActiveEditorShell();
}

function handleSeqOnArray() {
	// placeholder
}

// ─── Normal-mode LED bridge (replaces [p switcher]) ────────────────────

/**
 * boxled col row level — playback position LED from [s box/led].
 * Writes to the background plane so positions show as minimum brightness,
 * visible beneath the stable foreground and restored after transient animation.
 * Cached even off-page so main-page background redraws stay current.
 */
function boxled() {
	var col = clamp(parseInt(arguments[0], 10), 0, s.gridWidth - 1);
	var row = clamp(parseInt(arguments[1], 10), 0, s.gridHeight - 1);
	var level = clamp(parseInt(arguments[2], 10), 0, 15);
	setPlaybackBgCell(col, row, level);
	refreshSequence64TrackPositionForRow(row);
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
	refreshSequence64TrackPositionForRow(row);
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
	var trackIdx = sequence64PlayingTrackIndex();
	if (trackIdx >= 0) refreshSequence64TrackPositionForRow(trackIdx + 1);
}

// ─── Automation Recording ───────────────────────────────────────────────

function shouldRecordAutomationEvent(col, row, state) {
	if (state !== 1 || playbackDispatching) return false;
	if (!s.automation.armed && !s.automation.recording) return false;
	// Automation controls operate the recorder itself and must never become
	// playback events. In particular, recording the arm/stop pad would restart
	// or disarm the recorder when the sequence played back.
	if (s.kmod === 2 && col === 9) return false;
	// Per-track randomize is now a tap/hold gesture. Only its resolved hold
	// action is recorded by commitModRandomizeHold().
	if (s.kmod === 2 && col === 8 && row >= 1) return false;
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

	// Advance the opt-in extended editor. With Run off this only updates the
	// Step/Automation playhead; target selection by itself never triggers audio.
	updateEditorClock();

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
	var workspace = ensureEditorWorkspaceDefaults();
	post("[grid_router] kmod=" + s.kmod + " edition=" + s.edition +
		" grid=" + s.gridWidth + "x" + s.gridHeight + "\n");
	post("[grid_router] seq on: " + s.sequencers.map(function (sq) { return sq.on; }).join(",") + "\n");
	post("[grid_router] ch on: " + s.channels.map(function (ch) { return ch.on; }).join(",") + "\n");
	post("[grid_router] editor enabled=" + workspace.enabled + " choosing=" + workspace.choosing +
		" active=" + workspace.active + " target=" + workspace.targetType + ":" +
		(workspace.targetId + 1) + " layout=" + workspace.layoutMode + " page=" +
		(sequence64LayoutEnabled() ? workspace.view64 : workspace.editorId) + "\n");
	// Forward dump to the bridge so it prints fg/bg
	messnamed("togridmatrixio", "dump");
}

function flattenDisplayPalette(palette) {
	var flattened = [];
	if (!palette) return flattened;
	for (var cell = 0; cell < palette.length; cell++) {
		var rgb = palette[cell] || [0, 0, 0];
		flattened.push(clamp8(rgb[0]), clamp8(rgb[1]), clamp8(rgb[2]));
	}
	return flattened;
}

function displayRouterDiagnosticState() {
	var workspace = ensureEditorWorkspaceDefaults();
	var queued = [];
	for (var index = 0; index < pageColorQueue.length; index++) {
		queued.push(pageColorQueue[index].slice());
	}
	return {
		page: s.kmod,
		edition: s.edition,
		width: s.gridWidth,
		height: s.gridHeight,
		mechaTrellisExtensions: s.mechaTrellisExtensions,
		autoPageColors: s.autoPageColors ? 1 : 0,
		editorBrightnessColors: s.editorBrightnessColors ? 1 : 0,
		editorActive: workspace.active ? 1 : 0,
		editorChoosing: workspace.choosing ? 1 : 0,
		editorTargetType: workspace.targetType,
		editorTargetId: workspace.targetId,
		editorView: sequence64LayoutEnabled() ? workspace.view64 : workspace.editorId,
		sampleBrowserActive: sampleBrowserState.active ? 1 : 0,
		pageColorPresetReady: pageColorPresetReady.slice(),
		pageColorQueue: queued,
		editorLevelCache: editorLevelCache.slice(),
		editorColorCache: editorColorCache.slice(),
		playbackBackground: playbackBg.slice(),
		expectedBasePalette: flattenDisplayPalette(buildPageColorPalette(s.kmod)),
		firmwareStateReadable: 0,
		firmwareVerification: "private color packets have no reply"
	};
}

function displayDiagnosticSnapshot(incidentId, payload) {
	var requested = String(incidentId || "unknown");
	var afterSuffix = ":after";
	var isAfter = requested.length > afterSuffix.length &&
		requested.substring(requested.length - afterSuffix.length) === afterSuffix;
	var rootId = isAfter ? requested.substring(0, requested.length - afterSuffix.length) : requested;
	var matrixState = null;
	try {
		matrixState = JSON.parse(String(payload || "{}"));
	} catch (error) {
		matrixState = { parseError: String(error), raw: String(payload || "") };
	}
	var record = {
		time: new Date().toISOString(),
		incident: rootId,
		phase: isAfter ? "after" : "before",
		diagnosticSession: diagnosticSession,
		diagnosticSerial: diagnosticSerial,
		router: isAfter || !pendingDisplayIncidents[rootId] ?
			displayRouterDiagnosticState() : pendingDisplayIncidents[rootId],
		matrix: matrixState
	};
	writeDisplayIncident(record);
	diagnosticEvent("display_state_snapshot", {
		incident: rootId,
		phase: record.phase,
		path: DISPLAY_INCIDENT_LOG_PATH,
		levelHash: matrixState.compositeHash || 0,
		colorHash: matrixState.colorHash || 0,
		queueRemaining: pageColorQueue.length
	});
	if (isAfter) delete pendingDisplayIncidents[rootId];
}

/** Preserve diagnostics, then rebuild the logical layout, levels, and colors. */
function displayRecover() {
	var incidentId = diagnosticSession + "-display-" + (++displayIncidentSerial);
	displayRecoveryCompleteTask.cancel();
	pendingDisplayRecoveryId = incidentId;
	pendingDisplayIncidents[incidentId] = displayRouterDiagnosticState();
	diagnosticEvent("display_recover_requested", {
		incident: incidentId,
		page: s.kmod,
		path: DISPLAY_INCIDENT_LOG_PATH,
		colorQueueLength: pageColorQueue.length
	});
	messnamed("togridmatrixio", "diagnostic_snapshot", incidentId);
	publishHud("notice", "warn", "Grid state captured · reinitializing");
	hardwareResync();
	// One 16-map palette plus the current semantic overlay can still take several
	// hundred milliseconds at the safe pace. Capture only after it has settled.
	displayRecoveryCompleteTask.schedule(900);
}

/** Send "redraw" to gridrouter to force-redraw the current page. */
function redraw() {
	post("[grid_router] redraw kmod=" + s.kmod + "\n");
	renderCompletePage(s.kmod, false);
}

/**
 * Restore device-local state after a serialosc hot-plug/restart. The Max-side
 * frame remains authoritative, but the hardware has forgotten its levels and
 * semantic colors.
 */
function hardwareResync() {
	post("[grid_router] hardware resync kmod=" + s.kmod + "\n");
	diagnosticEvent("hardware_resync", {
		page: s.kmod,
		mechaTrellisExtensions: s.mechaTrellisExtensions,
		editorColors: s.editorBrightnessColors ? 1 : 0
	});
	hardwareResyncVerifyTask.cancel();
	resetPageColorQueue();
	invalidateEditorLevelCache();
	invalidateEditorColorCache();
	// One logical 16x16 is authoritative. grid_composite_2x128 performs any
	// physical split downstream; the matrix bridge itself remains single-256.
	s.edition = 256;
	s.gridWidth = 16;
	s.gridHeight = 16;
	s.dual128Mode = 0;
	outlet(1, "edition", 256);
	outlet(1, "dual128", 0);
	messnamed("togridmatrixanim", "edition", 256);
	// grid_matrix_bridge.js owns separate runtime flags and may itself have
	// recompiled or reconnected, so reassert the extension mode too.
	outlet(1, "mechatrellis", s.mechaTrellisExtensions);

	// Commit the complete level frame, then directly upload only the visible
	// palette. No automatic device-local store/recall state is involved.
	renderCompletePage(s.kmod, false, s.mechaTrellisExtensions !== 2);
	if (s.autoPageColors && s.mechaTrellisExtensions !== 2) initializePageColorPresets();
	hardwareResyncVerifyTask.schedule(250);
	outlet(2, "hardware_resync", s.kmod);
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
	markSessionDirty("automation");
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
					resetEditorWorkspaceState(true, true);
					resetPlaybackBg();
					// Forward to bridge + anim engine so all layers agree on dimensions
					outlet(1, "edition", e);
					messnamed("togridmatrixanim", "edition", e);
					renderCompletePage(s.kmod, false);
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
