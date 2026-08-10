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
	if (inlet !== 0 || messagename !== "export") return;
	var args = atoms(arguments);
	if (args.length < 3) return;
	queue.push({
		requestId: String(args[0]),
		bufferName: String(args[1]),
		path: args.slice(2).join(" ")
	});
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
	outlet(1, "recording_exported", active.requestId, active.bufferName);
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
