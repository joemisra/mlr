"use strict";

/* Max adapter and shared state owner for all eight group plugin racks. */

autowatch = 1;
inlets = 1;
outlets = 1;

var Model = require("plugin_rack_model.js");
var rackState = Model.createState();
var inventorySeen = { vst3: {}, au: {} };
var inventoryTask = new Task(publishInventory, this);
var inventoryPublishTask = new Task(publishInventoryChunk, this);
var inventoryPublishQueue = [];
var inventoryRevision = 0;
var inventoryRequestActive = 0;
var inventoryScanMessages = { vst3: 0, au: 0 };
var inventoryScanAtoms = { vst3: 0, au: 0 };
var sessionApplying = 0;

function argsArray(args) {
	return Array.prototype.slice.call(args || []);
}

function publish() {
	var args = argsArray(arguments);
	messnamed.apply(this, ["mlr_hud_state"].concat(args));
}

function publishInventory() {
	var formats = ["vst3", "au"];
	var counts = { vst3: 0, au: 0 };
	for (var formatIndex = 0; formatIndex < formats.length; formatIndex++) {
		var format = formats[formatIndex];
		var entries = [];
		for (var uri in inventorySeen[format]) entries.push(inventorySeen[format][uri]);
		Model.setInventory(rackState, format, entries);
		counts[format] = rackState.inventory[format].length;
	}
	inventoryRequestActive = 0;
	if (typeof post === "function") {
		post("[mlr rack] cache listing: " + counts.vst3 + " VST3 / " + counts.au +
			" AU cached; scanner messages " + inventoryScanMessages.vst3 + "/" +
			inventoryScanMessages.au + "; atoms " + inventoryScanAtoms.vst3 + "/" +
			inventoryScanAtoms.au + "\n");
	}
	queueInventoryPublish(counts);
}

function queueInventoryPublish(counts) {
	inventoryRevision++;
	inventoryPublishTask.cancel();
	inventoryPublishQueue = [];
	var formats = ["vst3", "au"];
	for (var formatIndex = 0; formatIndex < formats.length; formatIndex++) {
		var format = formats[formatIndex];
		var entries = rackState.inventory[format] || [];
		inventoryPublishQueue.push(["rack_inventory_begin", inventoryRevision,
			format, entries.length]);
		for (var index = 0; index < entries.length; index++) {
			inventoryPublishQueue.push(["rack_inventory_item", inventoryRevision,
				format, index, entries[index].uri, entries[index].name]);
		}
		inventoryPublishQueue.push(["rack_inventory_end", inventoryRevision, format]);
	}
	inventoryPublishQueue.push(["rack_inventory_status", "ready", inventoryRevision,
		counts.vst3 || 0, counts.au || 0, "Plugin cache ready"]);
	publish("rack_inventory_status", "publishing", inventoryRevision,
		counts.vst3 || 0, counts.au || 0, "Preparing plugin list");
	inventoryPublishTask.interval = 1;
	inventoryPublishTask.repeat();
}

function publishInventoryChunk() {
	var batchSize = 24;
	for (var index = 0; index < batchSize && inventoryPublishQueue.length; index++) {
		var message = inventoryPublishQueue.shift();
		publish.apply(this, message);
	}
	if (!inventoryPublishQueue.length) inventoryPublishTask.cancel();
}

function publishGroupLatency(groupIndex) {
	var group = rackState.groups[groupIndex];
	if (!group) return;
	publish("rack_latency", groupIndex, group.latencySamples,
		Model.groupLatencyMs(rackState, groupIndex), rackState.latencyMismatch ? 1 : 0);
}

function publishSlot(groupIndex, slotIndex) {
	var group = rackState.groups[groupIndex];
	var slot = group && group.slots[slotIndex];
	if (!slot) return;
	publish("rack_state", groupIndex, slotIndex, JSON.stringify(slot));
	publishGroupLatency(groupIndex);
}

function snapshot() {
	publishInventory();
	state_snapshot();
}

function state_snapshot() {
	for (var group = 0; group < Model.GROUP_COUNT; group++) {
		for (var slot = 0; slot < Model.SLOT_COUNT; slot++) publishSlot(group, slot);
	}
}

function addInventory(format, incoming) {
	var normalized = Model.normalizeFormat(format);
	if (!normalized) return;
	var values = argsArray(incoming);
	inventoryScanMessages[normalized]++;
	inventoryScanAtoms[normalized] += values.length;
	var identifier = values.join(" ");
	var entry = Model.normalizeInventoryEntry(normalized, identifier);
	if (!entry) return;
	inventorySeen[normalized][entry.uri] = entry;
	inventoryTask.cancel();
	inventoryTask.schedule(80);
}

function plug_vst3() { addInventory("vst3", arguments); }
function plug_au() { addInventory("au", arguments); }

function refresh() {
	if (inventoryRequestActive) {
		publish("rack_inventory_status", "listing", inventoryRevision, 0, 0,
			"Already reading the Max plugin cache");
		return;
	}
	inventoryRequestActive = 1;
	inventorySeen = { vst3: {}, au: {} };
	inventoryScanMessages = { vst3: 0, au: 0 };
	inventoryScanAtoms = { vst3: 0, au: 0 };
	inventoryTask.cancel();
	publish("rack_inventory_status", "listing", inventoryRevision, 0, 0,
		"Reading the Max plugin cache");
	// Do not pass vstscan's optional `effect` filter here. Max 9's cache can
	// contain otherwise valid legacy .vst3info/.auinfo records without the newer
	// category field; the filter silently hides all of those records. Slots
	// validate audio inputs and the synth flag after construction instead.
	outlet(0, "listvst3");
	outlet(0, "listau");
	// listvst3/listau normally answer synchronously. This also completes cleanly
	// when one format has no cached effects instead of leaving the HUD waiting.
	inventoryTask.schedule(250);
}

function sendSlot(group, slot, selector) {
	var payload = argsArray(arguments).slice(3);
	messnamed.apply(this, ["mlr_rack_slot_cmd", "slot_command", group, slot,
		selector].concat(payload));
}

function validAddress(group, slot) {
	return group >= 0 && group < Model.GROUP_COUNT && slot >= 0 && slot < Model.SLOT_COUNT;
}

function findInventoryEntry(format, identifier) {
	var normalized = Model.normalizeFormat(format);
	var entries = rackState.inventory[normalized] || [];
	var id = String(identifier || "");
	for (var index = 0; index < entries.length; index++) {
		if (entries[index].uri === id || entries[index].id === id || String(index) === id) {
			return entries[index];
		}
	}
	return Model.normalizeInventoryEntry(normalized, id);
}

function markDirty(reason) {
	if (!sessionApplying) messnamed("mlr_session_dirty", "dirty", String(reason || "rack"));
}

function command(groupIndex, slotIndex, action) {
	var group = parseInt(groupIndex, 10);
	var slot = parseInt(slotIndex, 10);
	var commandName = String(action || "").toLowerCase();
	var rest = argsArray(arguments).slice(3);
	if (commandName === "snapshot") {
		snapshot();
		return;
	}
	if (!validAddress(group, slot)) return;
	if (commandName === "load") {
		var format = Model.normalizeFormat(rest[0]);
		var entry = findInventoryEntry(format, rest.slice(1).join(" "));
		if (!entry || !format) {
			publish("notice", "error", "Only VST3 and Audio Unit effects are supported");
			return;
		}
		Model.setSlot(rackState, group, slot, {
			format: format, uri: entry.uri, name: entry.name,
			loaded: 0, bypassed: 0, status: "loading"
		});
		publishSlot(group, slot);
		sendSlot(group, slot, format === "vst3" ? "load_vst3" : "load_au",
			entry.uri, entry.name);
		markDirty("plugin loaded");
	} else if (commandName === "bypass") {
		var bypassed = rest.length ? (parseInt(rest[0], 10) ? 1 : 0) :
			(rackState.groups[group].slots[slot].bypassed ? 0 : 1);
		sendSlot(group, slot, "bypass", bypassed);
		markDirty("plugin bypass");
	} else if (commandName === "open") {
		sendSlot(group, slot, "open");
	} else if (commandName === "clear") {
		sendSlot(group, slot, "clear");
		markDirty("plugin cleared");
	} else if (commandName === "move") {
		var target = parseInt(rest[0], 10);
		if (!validAddress(group, target) || target === slot) return;
		messnamed("mlr_session_node_cmd", "rack_move", group, slot, target,
			JSON.stringify(rackState.groups[group].slots[slot]),
			JSON.stringify(rackState.groups[group].slots[target]));
		markDirty("plugin reordered");
	}
}

function slot_status(groupIndex, slotIndex, payload) {
	var group = parseInt(groupIndex, 10);
	var slot = parseInt(slotIndex, 10);
	if (!validAddress(group, slot)) return;
	var source;
	try {
		source = JSON.parse(String(payload || "{}"));
	} catch (error) {
		source = { status: "error", error: String(error) };
	}
	var previous = rackState.groups[group].slots[slot];
	if (!source.uri && previous.uri) source.uri = previous.uri;
	if (!source.format && previous.format) source.format = previous.format;
	if (!source.name && previous.name) source.name = previous.name;
	if (!source.snapshot && previous.snapshot) source.snapshot = previous.snapshot;
	Model.setSlot(rackState, group, slot, source);
	publishSlot(group, slot);
	if (source.status === "unsupported" || source.status === "missing" || source.status === "error") {
		publish("notice", "warn", "Group " + (group + 1) + " slot " + (slot + 1) +
			": " + (source.error || source.status));
	}
}

function slot_parameter(groupIndex, slotIndex) {
	var group = parseInt(groupIndex, 10);
	var slot = parseInt(slotIndex, 10);
	if (validAddress(group, slot)) markDirty("plugin parameter");
}

function sessionSnapshot(requestId) {
	var dictName = "mlr_session_rack_fragment";
	var dict = new Dict(dictName);
	dict.parse(JSON.stringify({ groups: Model.snapshot(rackState), sampleRate: rackState.sampleRate }));
	messnamed("mlr_session_fragment", "rack_dict", String(requestId || ""), dictName);
}

function sessionApplyDict(dictName) {
	try {
		var dict = new Dict(String(dictName || ""));
		var document = JSON.parse(dict.stringify());
		return sessionApply(JSON.stringify({ groups: document.racks || document.groups || [] }));
	} catch (error) {
		publish("notice", "error", "Could not read saved rack dictionary");
		return false;
	}
}

function sessionApply(payload) {
	var source;
	try { source = JSON.parse(String(payload || "{}")); }
	catch (error) { return false; }
	var groups = Array.isArray(source.groups) ? source.groups : [];
	sessionApplying++;
	for (var group = 0; group < Model.GROUP_COUNT; group++) {
		var savedSlots = groups[group] && Array.isArray(groups[group].slots) ? groups[group].slots : [];
		for (var slot = 0; slot < Model.SLOT_COUNT; slot++) {
			var descriptor = Model.normalizeSlot(savedSlots[slot], group, slot);
			Model.setSlot(rackState, group, slot, descriptor);
			if (descriptor.uri && descriptor.format) {
				sendSlot(group, slot, "session_load", JSON.stringify(descriptor));
			} else sendSlot(group, slot, "clear");
			publishSlot(group, slot);
		}
	}
	sessionApplying--;
	return true;
}

function sessionNew() {
	sessionApplying++;
	for (var group = 0; group < Model.GROUP_COUNT; group++) {
		for (var slot = 0; slot < Model.SLOT_COUNT; slot++) sendSlot(group, slot, "clear");
	}
	rackState = Model.createState();
	sessionApplying--;
	snapshot();
}

function swap_export(groupIndex, fromIndex, toIndex, fromPath, toPath) {
	var group = parseInt(groupIndex, 10);
	var from = parseInt(fromIndex, 10);
	var to = parseInt(toIndex, 10);
	if (!validAddress(group, from) || !validAddress(group, to)) return;
	if (rackState.groups[group].slots[from].loaded) sendSlot(group, from, "snapshot_export", fromPath);
	if (rackState.groups[group].slots[to].loaded) sendSlot(group, to, "snapshot_export", toPath);
}

function swap_load(groupIndex, fromIndex, toIndex, fromPayload, toPayload) {
	var group = parseInt(groupIndex, 10);
	var from = parseInt(fromIndex, 10);
	var to = parseInt(toIndex, 10);
	if (!validAddress(group, from) || !validAddress(group, to)) return;
	var fromDescriptor;
	var toDescriptor;
	try {
		fromDescriptor = JSON.parse(String(fromPayload || "{}"));
		toDescriptor = JSON.parse(String(toPayload || "{}"));
	} catch (error) { return; }
	sendSlot(group, from, "session_load", JSON.stringify(toDescriptor));
	sendSlot(group, to, "session_load", JSON.stringify(fromDescriptor));
	Model.moveSlot(rackState, group, from, to);
	publishSlot(group, from);
	publishSlot(group, to);
}

function sample_rate(value) {
	var parsed = Number(value);
	if (isFinite(parsed) && parsed > 0) rackState.sampleRate = parsed;
	Model.updateLatencies(rackState);
	for (var group = 0; group < Model.GROUP_COUNT; group++) publishGroupLatency(group);
}

function loadbang() {
	refresh();
	var task = new Task(snapshot, this);
	task.schedule(180);
}

function notifydeleted() {
	inventoryTask.cancel();
	inventoryPublishTask.cancel();
}
