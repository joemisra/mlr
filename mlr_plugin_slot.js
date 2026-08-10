/* Stereo vst~ slot controller. Kept ES5-compatible for Max's [js] object. */

autowatch = 1;
inlets = 2;
outlets = 3;

var groupNumber = parseInt(jsarguments[1], 10) || 1;
var slotNumber = parseInt(jsarguments[2], 10) || 1;
var FADE_MS = 15;
var QUERY_INTERVAL_MS = 250;
var LOAD_TIMEOUT_MS = 10000;
var state = emptyState();
var queryValues = {};
var pendingSnapshot = "";
var pendingBypass = 0;
var pendingLoad = null;

function debugStage(stage, detail) {
	if (typeof post !== "function") return;
	post("[mlr rack slot " + groupNumber + "/" + slotNumber + "] " + stage +
		(detail ? ": " + String(detail) : "") + "\n");
}

function emptyState() {
	return {
		format: "", uri: "", name: "Empty", loaded: 0, bypassed: 0,
		latencySamples: 0, hasEditor: 0, status: "empty", error: "", snapshot: ""
	};
}

function report() {
	messnamed("mlr_rack_status", "slot_status", groupNumber - 1, slotNumber - 1,
		JSON.stringify(state));
}

function reportParameter() {
	messnamed("mlr_rack_status", "slot_parameter", groupNumber - 1, slotNumber - 1);
}

function wetDry(wet) {
	outlet(1, wet ? 0. : 1., FADE_MS);
	outlet(2, wet ? 1. : 0., FADE_MS);
}

function pluginIdentifier(format, uri) {
	var value = String(uri || "");
	var prefix = String(format || "").toLowerCase() === "au" ? "C74_AU:/" : "C74_VST3:/";
	return value.indexOf(prefix) === 0 ? value.substring(prefix.length) : value;
}

var disableTask = new Task(function () {
	if (!state.loaded || state.bypassed) outlet(0, "disable", 1);
}, this);

var clearTask = new Task(function () {
	outlet(0, "drop");
	state = emptyState();
	pendingSnapshot = "";
	pendingBypass = 0;
	pendingLoad = null;
	report();
}, this);

var queryTask = new Task(function () {
	if (!pendingLoad || state.status !== "loading") {
		queryTask.cancel();
		return;
	}
	debugStage("query", pendingLoad.id);
	outlet(0, "get", -1);
	outlet(0, "get", -6);
	outlet(0, "get", -7);
	outlet(0, "get", -10);
}, this);

var finalizeTask = new Task(function () {
	if (!pendingLoad || state.status !== "loading" || queryValues.inputs === undefined) return;
	queryTask.cancel();
	loadTimeoutTask.cancel();
	debugStage("metadata", "inputs=" + queryValues.inputs + " synth=" +
		(queryValues.synth ? 1 : 0) + " latency=" + (queryValues.latency || 0));
	if (queryValues.inputs <= 0 || queryValues.synth) {
		wetDry(false);
		outlet(0, "drop");
		state.loaded = 0;
		state.status = "unsupported";
		state.error = queryValues.synth ? "Instrument plugins are not supported in effect slots" :
			"Plugin has no audio input";
		pendingLoad = null;
		report();
		return;
	}
	state.loaded = 1;
	state.latencySamples = Math.max(0, parseInt(queryValues.latency, 10) || 0);
	state.hasEditor = queryValues.editor ? 1 : 0;
	state.status = "ready";
	state.error = "";
	pendingLoad = null;
	debugStage("ready", state.name);
	outlet(0, "disable", 0);
	if (pendingSnapshot) {
		outlet(0, "importsnapshot", 0, pendingSnapshot);
		outlet(0, "restore", 0);
		state.snapshot = pendingSnapshot;
	}
	state.bypassed = pendingBypass ? 1 : 0;
	wetDry(!state.bypassed);
	if (state.bypassed) disableTask.schedule(FADE_MS + 2);
	report();
}, this);

var loadTimeoutTask = new Task(function () {
	if (!pendingLoad || state.status !== "loading") return;
	queryTask.cancel();
	finalizeTask.cancel();
	wetDry(false);
	outlet(0, "drop");
	state.loaded = 0;
	state.status = "missing";
	state.error = "Plugin did not answer within " + (LOAD_TIMEOUT_MS / 1000) + " seconds";
	debugStage("timeout", state.name);
	pendingLoad = null;
	report();
}, this);

var loadTask = new Task(function () {
	if (!pendingLoad || state.status !== "loading") return;
	// Give the dry crossfade and HUD status one scheduler turn before vst~ does
	// potentially expensive third-party construction on Max's main thread. Keep
	// the host disabled until metadata validation succeeds so the audio thread
	// cannot race plugin construction while DSP is already running.
	debugStage("construct", pendingLoad.format + " " + pendingLoad.id);
	// Use vst~'s format-specific messages with the cache identifier. This avoids
	// sending a typed URI back through the generic plug resolver, which can leave
	// some VST3/AU builds waiting indefinitely during construction.
	outlet(0, pendingLoad.format === "au" ? "plug_au" : "plug_vst3",
		pendingLoad.id);
	debugStage("construct returned", pendingLoad.id);
	queryTask.interval = QUERY_INTERVAL_MS;
	queryTask.repeat();
	loadTimeoutTask.schedule(LOAD_TIMEOUT_MS);
}, this);

function beginLoad(format, uri, name) {
	var normalized = String(format || "").toLowerCase();
	if (normalized !== "vst3" && normalized !== "au") return;
	clearTask.cancel();
	disableTask.cancel();
	loadTask.cancel();
	queryTask.cancel();
	finalizeTask.cancel();
	loadTimeoutTask.cancel();
	queryValues = {};
	state.format = normalized;
	state.uri = String(uri || "");
	state.name = String(name || state.uri || "Plugin");
	state.loaded = 0;
	state.latencySamples = 0;
	state.status = "loading";
	state.error = "";
	if (pendingSnapshot) state.snapshot = pendingSnapshot;
	pendingLoad = {
		format: normalized,
		uri: state.uri,
		id: pluginIdentifier(normalized, state.uri)
	};
	debugStage("begin", normalized + " " + pendingLoad.id);
	wetDry(false);
	report();
	loadTask.schedule(FADE_MS + 2);
}

function load_vst3() {
	var args = arrayfromargs(arguments);
	pendingSnapshot = "";
	pendingBypass = 0;
	beginLoad("vst3", args[0], args.slice(1).join(" ") || args[0]);
}

function load_au() {
	var args = arrayfromargs(arguments);
	pendingSnapshot = "";
	pendingBypass = 0;
	beginLoad("au", args[0], args.slice(1).join(" ") || args[0]);
}

function slot_command(groupIndex, slotIndex, selector) {
	var group = parseInt(groupIndex, 10);
	var slot = parseInt(slotIndex, 10);
	if (group !== groupNumber - 1 || slot !== slotNumber - 1) return;
	var action = String(selector || "");
	var args = arrayfromargs(arguments).slice(3);
	debugStage("command", action);
	if (action === "load_vst3") load_vst3.apply(this, args);
	else if (action === "load_au") load_au.apply(this, args);
	else if (action === "bypass") bypass.apply(this, args);
	else if (action === "open") open();
	else if (action === "clear") clear();
	else if (action === "snapshot_export") snapshot_export.apply(this, args);
	else if (action === "snapshot_import") snapshot_import.apply(this, args);
	else if (action === "session_load") session_load.apply(this, args);
}

function bypass(value) {
	if (!state.loaded) return;
	state.bypassed = parseInt(value, 10) ? 1 : 0;
	disableTask.cancel();
	if (state.bypassed) {
		wetDry(false);
		disableTask.schedule(FADE_MS + 2);
	} else {
		outlet(0, "disable", 0);
		wetDry(true);
	}
	report();
}

function open() {
	if (state.loaded) outlet(0, "open");
}

function clear() {
	loadTask.cancel();
	queryTask.cancel();
	finalizeTask.cancel();
	loadTimeoutTask.cancel();
	disableTask.cancel();
	pendingLoad = null;
	wetDry(false);
	state.status = "clearing";
	report();
	clearTask.schedule(FADE_MS + 2);
}

function snapshot_export() {
	var path = arrayfromargs(arguments).join(" ");
	if (!state.loaded || !path) return;
	outlet(0, "deletesnapshot", 0);
	outlet(0, "addsnapshot", 0, "MLR Session");
	outlet(0, "exportsnapshot", 0, path);
	state.snapshot = path;
	messnamed("mlr_rack_status", "snapshot_exported", groupNumber - 1,
		slotNumber - 1, path);
}

function snapshot_import() {
	var path = arrayfromargs(arguments).join(" ");
	if (!state.loaded || !path) return;
	outlet(0, "importsnapshot", 0, path);
	outlet(0, "restore", 0);
	state.snapshot = path;
	report();
}

function session_load(payload) {
	var descriptor;
	try { descriptor = JSON.parse(String(payload || "{}")); }
	catch (error) {
		state.status = "error";
		state.error = "Invalid saved plugin descriptor";
		report();
		return;
	}
	pendingSnapshot = String(descriptor.snapshot || "");
	pendingBypass = descriptor.bypassed ? 1 : 0;
	if (!descriptor.format || !descriptor.uri) {
		clear();
		return;
	}
	beginLoad(descriptor.format, descriptor.uri, descriptor.name);
}

function list() {
	if (inlet !== 1) return;
	var args = arrayfromargs(arguments);
	var query = parseInt(args[0], 10);
	var value = args[1];
	if (query < 0) debugStage("response", query + " " + String(value));
	if (query === -1) queryValues.inputs = parseInt(value, 10) || 0;
	else if (query === -6) queryValues.editor = parseInt(value, 10) ? 1 : 0;
	else if (query === -7) queryValues.synth = parseInt(value, 10) ? 1 : 0;
	else if (query === -10) queryValues.latency = Math.max(0, parseInt(value, 10) || 0);
	else if (query > 0 && state.loaded) reportParameter();
	if (query < 0 && state.status === "loading") {
		finalizeTask.cancel();
		finalizeTask.schedule(25);
	}
}

function anything() {
	if (inlet !== 1 || !state.loaded) return;
	var query = parseInt(messagename, 10);
	if (query > 0) reportParameter();
}

function loadbang() {
	debugStage("online", "group=" + groupNumber + " slot=" + slotNumber);
	wetDry(false);
	outlet(0, "disable", 1);
	report();
}

function notifydeleted() {
	disableTask.cancel();
	clearTask.cancel();
	loadTask.cancel();
	queryTask.cancel();
	finalizeTask.cancel();
	loadTimeoutTask.cancel();
}
