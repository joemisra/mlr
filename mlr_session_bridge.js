"use strict";

/* Max-side session transaction coordinator. Filesystem work stays in Node. */

autowatch = 1;
inlets = 1;
outlets = 2;

var Core = require("mlr_session_core.js");
var Model = require("hud_model.js");
var observed = Model.createState();
var racks = { groups: [] };
var status = {
	name: "Untitled",
	path: "",
	dirty: 0,
	busy: 0,
	operation: "",
	missing: [],
	confirmation: "",
	message: "No session saved"
};
var currentDocument = null;
var pendingAction = "";
var pendingTransactions = {};
var transactionSerial = 0;
var recordingActive = 0;
var activeSaveDocument = null;
var saveAfterAction = "";
var exportedRecordings = {};
var startupSettling = 1;
var mutationSerial = 0;
var activeSaveRevision = 0;

function argsArray(args) {
	return Array.prototype.slice.call(args || []);
}

function publish() {
	var args = argsArray(arguments);
	messnamed.apply(this, ["mlr_hud_state"].concat(args));
}

function publishStatus() {
	publish("session_state", JSON.stringify(status));
	for (var index = 0; index < status.missing.length; index++) {
		var missing = status.missing[index];
		publish("session_missing", index, missing.type || "sample", missing.path || "",
			missing.ambiguous ? 1 : 0);
	}
}

function setBusy(operation, message) {
	status.busy = operation ? 1 : 0;
	status.operation = String(operation || "");
	if (message) status.message = String(message);
	publishStatus();
}

function dirty(reason) {
	if (startupSettling || (status.busy && status.operation !== "save")) return;
	mutationSerial++;
	status.dirty = 1;
	status.message = String(reason || "Session changed");
	publishStatus();
}

function snapshot() {
	publishStatus();
}

function state() {
	var args = argsArray(arguments);
	var topic = String(args.shift() || "");
	var previousStrip = "";
	if (topic === "channel_strip") {
		var previousStripIndex = parseInt(args[0], 10);
		if (previousStripIndex >= 0 && previousStripIndex < 8) {
			previousStrip = JSON.stringify(observed.channelStrips[previousStripIndex]);
		}
	}
	Model.applyEvent(observed, topic, args);
	if (topic === "channel_strip" && previousStrip) {
		var nextStripIndex = parseInt(args[0], 10);
		if (JSON.stringify(observed.channelStrips[nextStripIndex]) !== previousStrip) {
			dirty("channel strip");
		}
	}
	if (topic === "rack_state") {
		var group = parseInt(args[0], 10);
		var slot = parseInt(args[1], 10);
		var payload;
		try { payload = JSON.parse(String(args[2] || "{}")); }
		catch (error) { payload = null; }
		if (payload && group >= 0 && group < 8 && slot >= 0 && slot < 4) {
			if (!racks.groups[group]) racks.groups[group] = { id: group, slots: [] };
			racks.groups[group].slots[slot] = payload;
		}
	}
}

function transactionId() {
	transactionSerial++;
	return "snapshot-" + Date.now() + "-" + transactionSerial;
}

function beginSnapshot(operation, path) {
	if (recordingActive) {
		status.message = "Stop live recording before saving";
		publish("notice", "warn", status.message);
		publishStatus();
		return false;
	}
	var id = transactionId();
	pendingTransactions[id] = { id: id, operation: operation, path: path || "", fragments: {} };
	setBusy(operation, operation === "save" ? "Collecting session state…" : "Collecting session state…");
	messnamed("gridrouter", "sessionSnapshot", id);
	messnamed("sample_bank", "sessionSnapshot", id);
	messnamed("mlr_rack_session", "sessionSnapshot", id);
	messnamed("channel_strip_snapshot", "bang");
	messnamed("gridrouter", "hudSnapshot");
	var task = new Task(function () { finishSnapshot(id); }, this);
	task.schedule(220);
	return true;
}

function parseFragment(payload) {
	try { return JSON.parse(String(payload || "{}")); }
	catch (error) { return null; }
}

function router(requestId, payload) {
	var transaction = pendingTransactions[String(requestId || "")];
	if (transaction) transaction.fragments.router = parseFragment(payload);
}

function router_dict(requestId, dictName) {
	var transaction = pendingTransactions[String(requestId || "")];
	if (transaction) transaction.fragments.router = dictObject(dictName);
}

function bank(requestId, payload) {
	var transaction = pendingTransactions[String(requestId || "")];
	if (transaction) transaction.fragments.bank = parseFragment(payload);
}

function bank_dict(requestId, dictName) {
	var transaction = pendingTransactions[String(requestId || "")];
	if (transaction) transaction.fragments.bank = dictObject(dictName);
}

function rack(requestId, payload) {
	var transaction = pendingTransactions[String(requestId || "")];
	if (transaction) transaction.fragments.rack = parseFragment(payload);
}

function rack_dict(requestId, dictName) {
	var transaction = pendingTransactions[String(requestId || "")];
	if (transaction) transaction.fragments.rack = dictObject(dictName);
}

function channelStripSnapshot() {
	var result = [];
	for (var index = 0; index < 8; index++) {
		var strip = observed.channelStrips[index] || {};
		result.push({
			id: index, engine: strip.engine, cutoff: strip.cutoff,
			filterMod: strip.filterMod, resonance: strip.resonance,
			threshold: strip.threshold, ratio: strip.ratio, attack: strip.attack,
			release: strip.release, knee: strip.knee, makeup: strip.makeup,
			mix: strip.mix, drive: strip.drive, trim: strip.trim
		});
	}
	return result;
}

function colorSnapshot(routerFragment) {
	if (routerFragment && routerFragment.colors) return routerFragment.colors;
	var result = {};
	var roles = observed.colorLab && observed.colorLab.roles ? observed.colorLab.roles : {};
	for (var name in roles) result[name] = roles[name].color.slice();
	return result;
}

function finishSnapshot(id) {
	var transaction = pendingTransactions[id];
	if (!transaction) return;
	delete pendingTransactions[id];
	if (!transaction.fragments.router || !transaction.fragments.bank || !transaction.fragments.rack) {
		setBusy("", "Session snapshot timed out");
		publish("notice", "error", "Session snapshot timed out");
		return;
	}
	var fragments = {
		router: transaction.fragments.router,
		bank: transaction.fragments.bank,
		rack: transaction.fragments.rack,
		transport: { bpm: observed.bpm, quantize: observed.quantize, timeSignature: [4, 4] },
		channelStrips: channelStripSnapshot(),
		colors: colorSnapshot(transaction.fragments.router)
	};
	var document = Core.buildDocument(fragments, currentDocument);
	if (transaction.operation === "save") {
		activeSaveRevision = mutationSerial;
		activeSaveDocument = document;
		var dict = new Dict("mlr_session_snapshot");
		dict.parse(JSON.stringify(document));
		outlet(0, "save_bundle", transaction.path, "mlr_session_snapshot");
	} else {
		currentDocument = document;
		setBusy("", status.message);
	}
}

function requestDialog(kind) {
	outlet(1, String(kind));
}

function command(action) {
	var requested = String(action || "").toLowerCase();
	var rest = argsArray(arguments).slice(1);
	if (status.busy && requested !== "snapshot") {
		publish("notice", "warn", "Session " + status.operation + " is still in progress");
		return;
	}
	if (requested === "snapshot") snapshot();
	else if (requested === "new" || requested === "open") {
		if (status.dirty) {
			pendingAction = requested;
			status.confirmation = requested;
			status.message = "Save changes before " + (requested === "new" ? "starting over?" : "opening another session?");
			publishStatus();
		} else performAction(requested);
	} else if (requested === "save") {
		if (status.path) beginSnapshot("save", status.path);
		else requestDialog("save_dialog");
	} else if (requested === "save_as") requestDialog("save_dialog");
	else if (requested === "relink" && status.path) requestDialog("relink_dialog");
	else if (requested === "confirm") confirm(rest[0]);
}

function performAction(action) {
	if (action === "new") {
		setBusy("new", "Creating new session…");
		messnamed("gridrouter", "sessionNew");
		messnamed("sample_bank", "sessionNew");
		messnamed("mlr_rack_session", "sessionNew");
		for (var channel = 1; channel <= 8; channel++) {
			var defaults = { engine: 0, cutoff: 1, resonance: 0, threshold: -18,
				ratio: 4, attack: 10, release: 120, knee: 6, makeup: 0,
				mix: 1, drive: 0, trim: 0 };
			for (var parameter in defaults) {
				messnamed(channel + "[channelstrip]" + parameter,
					parameter === "engine" ? "int" : "float", defaults[parameter]);
			}
		}
		currentDocument = null;
		status.name = "Untitled";
		status.path = "";
		status.dirty = 0;
		mutationSerial = 0;
		status.missing = [];
		status.confirmation = "";
		setBusy("", "New session · sample library retained");
	} else if (action === "open") requestDialog("open_dialog");
}

function confirm(choice) {
	var selected = String(choice || "cancel").toLowerCase();
	var action = pendingAction;
	pendingAction = "";
	status.confirmation = "";
	if (selected === "cancel") {
		status.message = "Canceled";
		publishStatus();
	} else if (selected === "discard") {
		status.dirty = 0;
		performAction(action);
	} else if (selected === "save") {
		saveAfterAction = action;
		if (status.path) beginSnapshot("save", status.path);
		else requestDialog("save_dialog");
	}
}

function save_path() {
	var path = argsArray(arguments).join(" ");
	if (path) beginSnapshot("save", path);
}

function open_path() {
	var path = argsArray(arguments).join(" ");
	if (!path) return;
	setBusy("open", "Opening session…");
	outlet(0, "open_bundle", path);
}

function relink_path() {
	var path = argsArray(arguments).join(" ");
	if (!path) return;
	setBusy("relink", "Searching for missing samples…");
	outlet(0, "relink_bundle", path);
}

function save_assets(requestId, stagingPath) {
	exportedRecordings[String(requestId)] = { expected: 0, completed: 0 };
	if (!activeSaveDocument) {
		outlet(0, "finalize_save", requestId);
		return;
	}
	for (var group = 0; group < activeSaveDocument.racks.length; group++) {
		var slots = activeSaveDocument.racks[group].slots || [];
		for (var slot = 0; slot < slots.length; slot++) {
			if (slots[slot] && slots[slot].snapshot) {
				messnamed("mlr_rack_slot_cmd", "slot_command", group, slot,
					"snapshot_export", stagingPath + "/" + slots[slot].snapshot);
			}
		}
	}
	var recordings = activeSaveDocument.recordings || [];
	var exportable = [];
	for (var exportIndex = 0; exportIndex < recordings.length; exportIndex++) {
		if (recordings[exportIndex].bufferName && recordings[exportIndex].bundlePath) {
			exportable.push(recordings[exportIndex]);
		}
	}
	exportedRecordings[String(requestId)].expected = exportable.length;
	for (var recording = 0; recording < exportable.length; recording++) {
		messnamed("mlr_session_recording_export", "export", requestId,
			exportable[recording].bufferName,
			stagingPath + "/" + exportable[recording].bundlePath);
	}
	if (!exportable.length) {
		var finalizeTask = new Task(function () { outlet(0, "finalize_save", requestId); }, this);
		finalizeTask.schedule(180);
	}
}

function recording_exported(requestId) {
	var state = exportedRecordings[String(requestId)];
	if (!state) return;
	state.completed++;
	if (state.completed >= state.expected) outlet(0, "finalize_save", requestId);
}

function save_complete(path, name) {
	currentDocument = activeSaveDocument;
	activeSaveDocument = null;
	status.path = String(path || "");
	status.name = String(name || "Untitled");
	status.dirty = mutationSerial === activeSaveRevision ? 0 : 1;
	status.confirmation = "";
	setBusy("", status.dirty ? "Saved snapshot · newer changes remain" : "Session saved");
	if (saveAfterAction) {
		var action = saveAfterAction;
		saveAfterAction = "";
		if (status.dirty) {
			pendingAction = action;
			status.confirmation = action;
			status.message = "Newer changes appeared while saving";
			publishStatus();
		} else performAction(action);
	}
}

function dictObject(name) {
	try {
		var dict = new Dict(String(name || ""));
		return JSON.parse(dict.stringify());
	} catch (error) { return null; }
}

function applyDocument(document) {
	if (!document) return false;
	setBusy("open", "Restoring session…");
	var applyDictName = "mlr_session_apply_runtime";
	var applyDict = new Dict(applyDictName);
	applyDict.parse(JSON.stringify(document));
	messnamed("gridrouter", "sessionApplyDict", applyDictName);
	messnamed("sample_bank", "sessionApplyDict", applyDictName);
	messnamed("mlr_rack_session", "sessionApplyDict", applyDictName);
	for (var stripIndex = 0; stripIndex < 8; stripIndex++) {
		var strip = document.channelStrips[stripIndex] || {};
		for (var parameter in strip) {
			if (parameter === "id" || typeof strip[parameter] !== "number") continue;
			messnamed((stripIndex + 1) + "[channelstrip]" + parameter,
				parameter === "engine" ? "int" : "float", strip[parameter]);
		}
	}
	if (document.transport && document.transport.bpm) {
		messnamed("[time]bpm", "float", document.transport.bpm);
	}
	return true;
}

function open_ready(dictName, path, name, missingPayload) {
	var document = dictObject(dictName);
	if (!applyDocument(document)) {
		session_error("open", "Session dictionary was unavailable");
		return;
	}
	currentDocument = document;
	status.path = String(path || "");
	status.name = String(name || "Untitled");
	status.dirty = 0;
	mutationSerial = 0;
	status.confirmation = "";
	try { status.missing = JSON.parse(String(missingPayload || "[]")); }
	catch (error) { status.missing = []; }
	setBusy("", status.missing.length ?
		("Loaded stopped · " + status.missing.length + " sample(s) missing") : "Loaded stopped");
}

function relink_ready(dictName, path, missingPayload, relinkedCount) {
	var document = dictObject(dictName);
	if (document) applyDocument(document);
	currentDocument = document || currentDocument;
	status.path = String(path || status.path);
	status.dirty = 1;
	mutationSerial++;
	try { status.missing = JSON.parse(String(missingPayload || "[]")); }
	catch (error) { status.missing = []; }
	setBusy("", "Relinked " + (parseInt(relinkedCount, 10) || 0) + " sample(s)");
}

function rack_swap_export(group, from, to, fromPath, toPath) {
	messnamed("mlr_rack_session", "swap_export", group, from, to, fromPath, toPath);
}

function rack_swap_load(group, from, to, fromPayload, toPayload) {
	messnamed("mlr_rack_session", "swap_load", group, from, to, fromPayload, toPayload);
}

function session_error(operation) {
	var message = argsArray(arguments).slice(1).join(" ");
	activeSaveDocument = null;
	setBusy("", String(operation || "Session") + " failed: " + message);
	publish("notice", "error", status.message);
}

function recording_state(value) {
	recordingActive = parseInt(value, 10) ? 1 : 0;
}

function loadbang() {
	var task = new Task(function () {
		messnamed("gridrouter", "hudSnapshot");
		messnamed("sample_bank", "hudSnapshot");
		messnamed("channel_strip_snapshot", "bang");
		messnamed("mlr_rack_cmd", "snapshot");
		publishStatus();
	}, this);
	task.schedule(250);
	var settleTask = new Task(function () { startupSettling = 0; }, this);
	settleTask.schedule(1200);
}
