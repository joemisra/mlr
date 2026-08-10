"use strict";

/* Max adapter for the portable HUD model. */

autowatch = 1;
inlets = 1;
outlets = 1;

var hudBpmValue = 120;
var hudQuantizeValue = 16;
var waveformCache = {};
var WAVEFORM_BINS = 256;
var SAMPLES_PER_BIN = 6;

function publish() {
	var args = Array.prototype.slice.call(arguments);
	messnamed.apply(this, ["mlr_hud_state"].concat(args));
}

function snapshot() {
	messnamed("gridrouter", "hudSnapshot");
	messnamed("sample_bank", "hudSnapshot");
	messnamed("togridmatrixio", "hudSnapshot");
	messnamed("channel_strip_snapshot", "bang");
	messnamed("mlr_rack_cmd", "snapshot");
	messnamed("mlr_session_cmd", "snapshot");
	publish("clock", hudBpmValue, hudQuantizeValue);
}

function target(targetType, targetId) {
	var type = String(targetType || "");
	var id = parseInt(targetId, 10);
	if ((type !== "group" && type !== "track") || !isFinite(id)) return;
	messnamed("gridrouter", "hudTarget", type, id);
}

function bar(barIndex) {
	var id = parseInt(barIndex, 10);
	if (!isFinite(id)) return;
	messnamed("gridrouter", "hudBar", id);
}

function transport(command) {
	var action = String(command || "").toLowerCase();
	if (action !== "run" && action !== "stop" && action !== "restart") return;
	messnamed("gridrouter", "hudTransport", action);
}

function display_recover() {
	messnamed("gridrouter", "displayRecover");
}

function bank_open() {
	outlet(0, "bank_open");
}

function bank_scan() {
	outlet(0, "bank_scan");
}

function bank_reload() {
	messnamed("sample_bank", "reload");
}

function bank_read() {
	var path = Array.prototype.slice.call(arguments).join(" ");
	if (path) messnamed("sample_bank", "read", path);
}

function bank_folder() {
	var path = Array.prototype.slice.call(arguments).join(" ");
	if (path) messnamed("sample_bank", "scanFolder", path);
}

function sample_assign(trackIndex, sampleIndex) {
	var track = parseInt(trackIndex, 10);
	var sample = parseInt(sampleIndex, 10);
	if (!isFinite(track) || !isFinite(sample) || track < 0 || track >= 16 || sample < 0) return;
	messnamed("sample_bank", "assign", track, sample);
}

function sample_audition(sampleIndex) {
	var sample = parseInt(sampleIndex, 10);
	if (isFinite(sample) && sample >= 0) messnamed("sample_bank", "preview", sample);
}

function sample_preview_stop() {
	messnamed("sample_bank", "previewStop");
}

function sample_grid(enabled, trackIndex, sampleIndex) {
	if (parseInt(enabled, 10)) {
		messnamed("sample_bank", "browserOpen", parseInt(trackIndex, 10) || 0,
			parseInt(sampleIndex, 10));
	} else messnamed("sample_bank", "browserClose");
}

function color_role(name, red, green, blue) {
	var role = String(name || "");
	if (!role) return;
	messnamed("gridrouter", "hudColorRole", role,
		Math.max(0, Math.min(255, parseInt(red, 10) || 0)),
		Math.max(0, Math.min(255, parseInt(green, 10) || 0)),
		Math.max(0, Math.min(255, parseInt(blue, 10) || 0)));
}

function color_reset(name) {
	messnamed("gridrouter", "hudColorReset", String(name || "all"));
}

function strip_select(channelIndex) {
	var channel = parseInt(channelIndex, 10);
	if (!isFinite(channel) || channel < 0 || channel >= 8) return;
	// The DSP abstractions use one-based #1 arguments; the HUD protocol remains
	// zero-based everywhere outside this adapter.
	messnamed("channel_strip_selected", "int", channel + 1);
}

function strip_snapshot() {
	messnamed("channel_strip_snapshot", "bang");
	messnamed("mlr_rack_cmd", "state_snapshot");
}

function strip_set(channelIndex, parameter, incomingValue) {
	var channel = parseInt(channelIndex, 10);
	var name = String(parameter || "");
	var value = Number(incomingValue);
	if (!isFinite(channel) || channel < 0 || channel >= 8 || !isFinite(value)) return;
	var ranges = {
		engine: [0, 2], cutoff: [0, 1], resonance: [0, 1],
		threshold: [-60, 0], ratio: [1, 20], attack: [0.1, 500],
		release: [5, 5000], knee: [0, 24], makeup: [-12, 24],
		mix: [0, 1], drive: [0, 12], trim: [-24, 12]
	};
	if (!ranges[name]) return;
	value = Math.max(ranges[name][0], Math.min(ranges[name][1], value));
	if (name === "engine") value = Math.round(value);
	messnamed((channel + 1) + "[channelstrip]" + name,
		name === "engine" ? "int" : "float", value);
	messnamed("mlr_session_dirty", "dirty", "channel strip");
}

function rack_command(groupIndex, slotIndex, action) {
	var group = parseInt(groupIndex, 10);
	var slot = parseInt(slotIndex, 10);
	if (!isFinite(group) || group < 0 || group >= 8 ||
		!isFinite(slot) || slot < 0 || slot >= 4) return;
	var args = Array.prototype.slice.call(arguments, 3);
	messnamed.apply(this, ["mlr_rack_cmd", "command", group, slot,
		String(action || "")].concat(args));
}

function rack_load(groupIndex, slotIndex, format, identifier) {
	rack_command(groupIndex, slotIndex, "load", String(format || ""),
		String(identifier || ""));
}

function rack_bypass(groupIndex, slotIndex, enabled) {
	rack_command(groupIndex, slotIndex, "bypass", parseInt(enabled, 10) ? 1 : 0);
}

function rack_open(groupIndex, slotIndex) {
	rack_command(groupIndex, slotIndex, "open");
}

function rack_clear(groupIndex, slotIndex) {
	rack_command(groupIndex, slotIndex, "clear");
}

function rack_move(groupIndex, slotIndex, targetIndex) {
	rack_command(groupIndex, slotIndex, "move", parseInt(targetIndex, 10));
}

function rack_refresh() {
	messnamed("mlr_rack_cmd", "refresh");
}

function session_command(action) {
	var args = Array.prototype.slice.call(arguments, 1);
	messnamed.apply(this, ["mlr_session_cmd", "command", String(action || "")].concat(args));
}

function session_new() { session_command("new"); }
function session_open() { session_command("open"); }
function session_save() { session_command("save"); }
function session_save_as() { session_command("save_as"); }
function session_relink() { session_command("relink"); }
function session_confirm(choice) { session_command("confirm", String(choice || "cancel")); }

function bufferValue(buffer, channel, frame) {
	var value;
	try {
		value = buffer.peek(channel, frame, 1);
	} catch (error) {
		return 0;
	}
	if (Array.isArray(value)) value = value[0];
	value = Number(value);
	return isFinite(value) ? value : 0;
}

function buildWaveform(bufferIndex, requestedBufferName) {
	var bufferName = requestedBufferName || (String(bufferIndex) + "file");
	var buffer;
	try {
		buffer = new Buffer(bufferName);
	} catch (error) {
		publish("notice", "error", "Could not open buffer " + bufferName);
		return null;
	}
	var frames = 0;
	var channels = 0;
	var sampleRate = 0;
	try {
		frames = Math.max(0, parseInt(buffer.framecount(), 10) || 0);
		channels = Math.max(0, parseInt(buffer.channelcount(), 10) || 0);
		sampleRate = Math.max(0, Number(buffer.samplerate()) || 0);
	} catch (metadataError) {
		publish("notice", "warn", "Buffer " + bufferName + " is unavailable");
		return { buffer: bufferIndex, frames: 0, sampleRate: 0, channels: [] };
	}
	if (!frames || !channels) {
		publish("notice", "warn", "Buffer " + bufferName + " is empty");
		return { buffer: bufferIndex, frames: frames, sampleRate: sampleRate, channels: [] };
	}
	var cacheKey = bufferName + ":" + bufferIndex + ":" + frames + ":" + channels + ":" + sampleRate;
	if (waveformCache[cacheKey]) return waveformCache[cacheKey];
	var result = {
		buffer: bufferIndex,
		frames: frames,
		sampleRate: sampleRate,
		durationMs: sampleRate ? frames * 1000 / sampleRate : 0,
		channels: []
	};
	var drawnChannels = Math.min(2, channels);
	for (var channel = 1; channel <= drawnChannels; channel++) {
		var bins = [];
		for (var bin = 0; bin < WAVEFORM_BINS; bin++) {
			var start = Math.floor(bin * frames / WAVEFORM_BINS);
			var end = Math.max(start + 1, Math.floor((bin + 1) * frames / WAVEFORM_BINS));
			var minimum = 1;
			var maximum = -1;
			for (var sample = 0; sample < SAMPLES_PER_BIN; sample++) {
				var position = start + Math.floor((end - start - 1) * sample /
					Math.max(1, SAMPLES_PER_BIN - 1));
				var value = bufferValue(buffer, channel, position);
				if (value < minimum) minimum = value;
				if (value > maximum) maximum = value;
			}
			bins.push([minimum, maximum]);
		}
		result.channels.push(bins);
	}
	waveformCache[cacheKey] = result;
	return result;
}

function waveform_request(bufferIndex) {
	var id = parseInt(bufferIndex, 10);
	if (!isFinite(id) || id < 0) return;
	var waveform = buildWaveform(id);
	if (waveform) publish("waveform", id, JSON.stringify(waveform));
}

function previewWaveform(bufferIndex) {
	var id = parseInt(bufferIndex, 10);
	if (!isFinite(id) || id < 0) return;
	var waveform = buildWaveform(id, "mlr_sample_preview");
	if (waveform) publish("waveform", id, JSON.stringify(waveform));
}

function hudBpm(value) {
	var parsed = Number(value);
	if (isFinite(parsed) && parsed > 0) hudBpmValue = parsed;
	publish("clock", hudBpmValue, hudQuantizeValue);
}

function hudQuantize(value) {
	var parsed = parseInt(value, 10);
	if (isFinite(parsed) && parsed > 0) hudQuantizeValue = parsed;
	publish("clock", hudBpmValue, hudQuantizeValue);
}

function hudMode(value) {
	publish("mode", parseInt(value, 10) || 1);
}

function hudPress(x, y, state) {
	publish("grid_press", parseInt(x, 10) || 0, parseInt(y, 10) || 0,
		parseInt(state, 10) ? 1 : 0);
}

function clearWaveformCache() {
	waveformCache = {};
}

function loadbang() {
	var task = new Task(snapshot, this);
	task.schedule(150);
}
