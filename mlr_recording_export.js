"use strict";

/* Serializes live recording buffer exports for .mlr-session saves. */

autowatch = 1;
inlets = 2;
outlets = 2;

var queue = [];
var active = null;
var writeTask = new Task(beginWrite, this);

function atoms(args) {
	return Array.prototype.slice.call(args || []);
}

function anything() {
	if (inlet !== 0 || (messagename !== "export" && messagename !== "capture")) return;
	var args = atoms(arguments);
	if (args.length < 3) return;
	var request = {
		kind: messagename,
		requestId: String(args[0]),
		bufferName: String(args[1]),
		path: args.slice(2).join(" ")
	};
	if (messagename === "capture") {
		if (args.length < 7) return;
		request.path = String(args[2]);
		request.track = parseInt(args[3], 10) || 0;
		request.bufferIndex = parseInt(args[4], 10) || 0;
		request.durationMs = parseFloat(args[5]) || 0;
		request.source = String(args[6] || "input");
	}
	queue.push(request);
	startNext();
}

function startNext() {
	if (active || !queue.length) return;
	active = queue.shift();
	outlet(0, "set", active.bufferName);
	writeTask.schedule(20);
}

function beginWrite() {
	if (!active) return;
	// Explicitly select float32 before writing so the live buffer is not
	// quantized into buffer~'s legacy 16-bit WAV default.
	outlet(0, "samptype", "float32");
	outlet(0, "writewave", active.path);
}

function bang() {
	if (inlet !== 1 || !active) return;
	if (active.kind === "capture") {
		messnamed("sample_bank", "captureCommitted", active.requestId, active.path,
			active.track, active.bufferIndex, active.durationMs, active.source);
	} else outlet(1, "recording_exported", active.requestId, active.bufferName);
	active = null;
	startNext();
}

function clear() {
	queue = [];
	active = null;
	writeTask.cancel();
}

function notifydeleted() {
	writeTask.cancel();
}
