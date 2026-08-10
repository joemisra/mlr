"use strict";

/* Portable state and validation for MLR's eight four-slot effect racks. */

var GROUP_COUNT = 8;
var SLOT_COUNT = 4;
var SUPPORTED_FORMATS = ["vst3", "au"];

function integer(value, fallback) {
	var parsed = parseInt(value, 10);
	return isFinite(parsed) ? parsed : fallback;
}

function clamp(value, minimum, maximum) {
	return Math.min(maximum, Math.max(minimum, Number(value) || 0));
}

function blankSlot(group, slot) {
	return {
		group: group,
		slot: slot,
		format: "",
		uri: "",
		name: "Empty",
		loaded: 0,
		bypassed: 0,
		latencySamples: 0,
		hasEditor: 0,
		status: "empty",
		error: "",
		snapshot: ""
	};
}

function createState() {
	var groups = [];
	for (var group = 0; group < GROUP_COUNT; group++) {
		var slots = [];
		for (var slot = 0; slot < SLOT_COUNT; slot++) slots.push(blankSlot(group, slot));
		groups.push({ id: group, slots: slots, latencySamples: 0 });
	}
	return {
		groups: groups,
		inventory: { vst3: [], au: [] },
		sampleRate: 48000,
		latencyMismatch: 0,
		revision: 0
	};
}

function normalizeFormat(value) {
	var format = String(value || "").toLowerCase();
	if (format === "audio-unit" || format === "audiounit") format = "au";
	return SUPPORTED_FORMATS.indexOf(format) >= 0 ? format : "";
}

function canonicalUri(format, identifier) {
	var normalized = normalizeFormat(format);
	var value = String(identifier || "");
	if (!normalized || !value) return "";
	if (/^C74_(?:VST3|AU):\//.test(value)) return value;
	return (normalized === "vst3" ? "C74_VST3:/" : "C74_AU:/") + value;
}

function displayName(identifier) {
	var value = String(identifier || "").replace(/^C74_(?:VST3|AU):\//, "");
	var slash = Math.max(value.lastIndexOf("/"), value.lastIndexOf("\\"));
	return value.substring(slash + 1) || value || "Empty";
}

function normalizeInventoryEntry(format, source) {
	var identifier = source && typeof source === "object" ?
		String(source.id || source.uri || source.name || "") : String(source || "");
	var uri = canonicalUri(format, identifier);
	if (!uri) return null;
	return {
		format: normalizeFormat(format),
		id: uri.replace(/^C74_(?:VST3|AU):\//, ""),
		uri: uri,
		name: source && typeof source === "object" && source.name ?
			String(source.name) : displayName(identifier)
	};
}

function setInventory(state, format, entries) {
	var normalized = normalizeFormat(format);
	if (!normalized || !state) return [];
	var next = [];
	var seen = {};
	var source = Array.isArray(entries) ? entries : [];
	for (var index = 0; index < source.length; index++) {
		var entry = normalizeInventoryEntry(normalized, source[index]);
		if (!entry || seen[entry.uri]) continue;
		seen[entry.uri] = 1;
		next.push(entry);
	}
	next.sort(function (left, right) {
		return left.name.toLowerCase().localeCompare(right.name.toLowerCase());
	});
	state.inventory[normalized] = next;
	state.revision++;
	return next;
}

function normalizeSlot(source, group, slot) {
	var result = blankSlot(group, slot);
	if (!source || typeof source !== "object") return result;
	result.format = normalizeFormat(source.format);
	result.uri = canonicalUri(result.format, source.uri || source.id || source.name);
	result.name = String(source.name || displayName(result.uri));
	result.loaded = source.loaded ? 1 : 0;
	result.bypassed = source.bypassed ? 1 : 0;
	result.latencySamples = Math.max(0, integer(source.latencySamples, 0));
	result.hasEditor = source.hasEditor ? 1 : 0;
	result.status = String(source.status || (result.loaded ? "ready" :
		(result.uri ? "missing" : "empty")));
	result.error = String(source.error || "");
	result.snapshot = String(source.snapshot || "");
	return result;
}

function updateLatencies(state) {
	var minimum = Infinity;
	var maximum = 0;
	for (var group = 0; group < state.groups.length; group++) {
		var total = 0;
		for (var slot = 0; slot < state.groups[group].slots.length; slot++) {
			var item = state.groups[group].slots[slot];
			if (item.loaded && !item.bypassed) total += item.latencySamples;
		}
		state.groups[group].latencySamples = total;
		minimum = Math.min(minimum, total);
		maximum = Math.max(maximum, total);
	}
	if (!isFinite(minimum)) minimum = 0;
	state.latencyMismatch = maximum !== minimum ? 1 : 0;
}

function setSlot(state, groupIndex, slotIndex, source) {
	var group = integer(groupIndex, -1);
	var slot = integer(slotIndex, -1);
	if (!state || group < 0 || group >= GROUP_COUNT || slot < 0 || slot >= SLOT_COUNT) return null;
	var next = normalizeSlot(source, group, slot);
	state.groups[group].slots[slot] = next;
	updateLatencies(state);
	state.revision++;
	return next;
}

function moveSlot(state, groupIndex, fromIndex, toIndex) {
	var group = integer(groupIndex, -1);
	var from = integer(fromIndex, -1);
	var to = integer(toIndex, -1);
	if (!state || group < 0 || group >= GROUP_COUNT || from < 0 || from >= SLOT_COUNT ||
		to < 0 || to >= SLOT_COUNT || from === to) return false;
	var slots = state.groups[group].slots;
	var left = slots[from];
	var right = slots[to];
	slots[from] = normalizeSlot(right, group, from);
	slots[to] = normalizeSlot(left, group, to);
	updateLatencies(state);
	state.revision++;
	return true;
}

function groupLatencyMs(state, groupIndex) {
	var group = integer(groupIndex, -1);
	if (!state || group < 0 || group >= GROUP_COUNT) return 0;
	var sampleRate = Math.max(1, Number(state.sampleRate) || 48000);
	return state.groups[group].latencySamples * 1000 / sampleRate;
}

function snapshot(state) {
	var result = [];
	for (var group = 0; group < GROUP_COUNT; group++) {
		var slots = [];
		for (var slot = 0; slot < SLOT_COUNT; slot++) {
			var source = state.groups[group].slots[slot];
			slots.push({
				format: source.format,
				uri: source.uri,
				name: source.name,
				loaded: source.loaded ? 1 : 0,
				bypassed: source.bypassed ? 1 : 0,
				latencySamples: source.latencySamples,
				hasEditor: source.hasEditor ? 1 : 0,
				status: source.status,
				error: source.error,
				snapshot: source.snapshot
			});
		}
		result.push({ id: group, slots: slots });
	}
	return result;
}

module.exports = {
	GROUP_COUNT: GROUP_COUNT,
	SLOT_COUNT: SLOT_COUNT,
	SUPPORTED_FORMATS: SUPPORTED_FORMATS,
	blankSlot: blankSlot,
	createState: createState,
	normalizeFormat: normalizeFormat,
	canonicalUri: canonicalUri,
	normalizeInventoryEntry: normalizeInventoryEntry,
	setInventory: setInventory,
	normalizeSlot: normalizeSlot,
	setSlot: setSlot,
	moveSlot: moveSlot,
	updateLatencies: updateLatencies,
	groupLatencyMs: groupLatencyMs,
	snapshot: snapshot,
	clamp: clamp
};
