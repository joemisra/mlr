"use strict";

var Product;
try { Product = require("mlr_product.js"); }
catch (error) { Product = require("./mlr_product.js"); }
var FORMAT = Product.rta ? "mlr-session" : "mlr-base-session";
var VERSION = Product.rta ? 4 : 1;
var Modulation, Scenes;
if (Product.rta) {
	try { Modulation = require("modulation_model.js"); }
	catch (error) { Modulation = require("./modulation_model.js"); }
	try { Scenes = require("scene_model.js"); }
	catch (error) { Scenes = require("./scene_model.js"); }
}

function deepClone(value) {
	return value === undefined ? undefined : JSON.parse(JSON.stringify(value));
}

function isObject(value) {
	return !!value && typeof value === "object" && !Array.isArray(value);
}

function ensureArray(value) {
	return Array.isArray(value) ? value : [];
}

function pad(value) {
	return String(value).length < 2 ? "0" + value : String(value);
}

function pluginSnapshotPath(groupIndex, slotIndex) {
	return "plugins/g" + pad(groupIndex + 1) + "-s" + pad(slotIndex + 1) + ".maxsnap";
}

function recordingPath(index) {
	return "recordings/recording-" + pad(index + 1) + ".wav";
}

function withBundleExtension(value) {
	var path = String(value || "").replace(/[\\/]$/, "");
	return /\.mlr-session$/i.test(path) ? path : path + ".mlr-session";
}

function sanitizeStep(step) {
	var source = isObject(step) ? step : {};
	var result = {
		cut: source.cut && isObject(source.cut) ? {
			track: Number.isFinite(Number(source.cut.track)) ? parseInt(source.cut.track, 10) : -1,
			slice: Number.isFinite(Number(source.cut.slice)) ? parseInt(source.cut.slice, 10) : 0,
			gateLength: Math.max(1, parseInt(source.cut.gateLength, 10) || 1)
		} : null,
		locks: isObject(source.locks) ? deepClone(source.locks) : {},
		probability: source.probability === undefined ? 15 :
			Math.max(0, Math.min(15, parseInt(source.probability, 10) || 0)),
		condition: parseInt(source.condition, 10) || 0
	};
	return result;
}

function sanitizeBar(bar, defaultLength) {
	var source = isObject(bar) ? bar : {};
	var steps = ensureArray(source.steps);
	var resultSteps = [];
	for (var index = 0; index < 64; index++) resultSteps.push(sanitizeStep(steps[index]));
	return {
		length: Math.max(1, Math.min(64, parseInt(source.length, 10) || defaultLength || 64)),
		steps: resultSteps
	};
}

function sanitizePattern(pattern, targetType) {
	var source = isObject(pattern) ? pattern : {};
	var defaultLength = targetType === "track" ? 16 : 64;
	var sourceBars = ensureArray(source.bars);
	if (!sourceBars.length && Array.isArray(source.steps)) {
		sourceBars = [{ length: source.length || defaultLength, steps: source.steps }];
	}
	if (!sourceBars.length) sourceBars = [{}];
	var bars = [];
	for (var index = 0; index < Math.min(8, sourceBars.length); index++) {
		bars.push(sanitizeBar(sourceBars[index], defaultLength));
	}
	return {
		version: Math.max(1, parseInt(source.version, 10) || 1),
		defaultTrack: Number.isFinite(Number(source.defaultTrack)) ?
			parseInt(source.defaultTrack, 10) : -1,
		lastUsedTrack: Number.isInteger(source.lastUsedTrack) &&
			source.lastUsedTrack >= 0 && source.lastUsedTrack < 16 ? source.lastUsedTrack : -1,
		rateNumerator: Math.max(1, parseInt(source.rateNumerator, 10) || 1),
		rateDenominator: Math.max(1, parseInt(source.rateDenominator, 10) || 1),
		bars: bars,
		parkedBars: ensureArray(source.parkedBars).map(function (bar) {
			return sanitizeBar(bar, defaultLength);
		}),
		currentBar: Math.max(0, Math.min(bars.length - 1, parseInt(source.currentBar, 10) || 0)),
		running: 0
	};
}

function sanitizePatterns(patterns) {
	var source = isObject(patterns) ? patterns : {};
	var result = {};
	Object.keys(source).forEach(function (key) {
		var parts = key.split(":");
		if ((parts[0] !== "group" && parts[0] !== "track") || !/^\d+$/.test(parts[1] || "")) return;
		result[key] = sanitizePattern(source[key], parts[0]);
	});
	return result;
}

function sanitizeSceneState(sceneState, tracks, legacyPatterns, modulation) {
	var result = Scenes.sanitizeState(sceneState, tracks, legacyPatterns, modulation);
	var library = {};
	Object.keys(result.patternLibrary || {}).forEach(function (key) {
		var targetType = key.indexOf("group-pattern:") === 0 ? "group" :
			(key.indexOf(":track-pattern:") >= 0 ? "track" : "");
		if (!targetType) return;
		library[key] = sanitizePattern(result.patternLibrary[key], targetType);
	});
	result.patternLibrary = library;
	Object.keys(result.trackSlots || {}).forEach(function (key) {
		result.trackSlots[key].modulation =
			Modulation.sanitizeState(result.trackSlots[key].modulation);
	});
	return result;
}

function sanitizeAutomation(source) {
	var automation = isObject(source) ? deepClone(source) : {};
	automation.armed = false;
	automation.recording = false;
	automation.playing = false;
	automation.tick = 0;
	automation.startTick = 0;
	automation.playHead = 0;
	return automation;
}

function migrateDocument(value) {
	if (!isObject(value) || !Product.rta) return value;
	var result = deepClone(value);
	if (result.format === "mlr-base-session") {
		// Validate before converting: never downgrade unknown future formats.
		if (!validateDocument(result).valid) return result;
		result.format = "mlr-session";
		result.rta = { patterns: {}, targetAutomation: {} };
	}
	var version = parseInt(result.version, 10) || 0;
	if (version === 1) {
		result.modulation = Modulation.sanitizeState(result.modulation);
		result.version = 2;
		version = 2;
	}
	if (version === 2) {
		if (!isObject(result.rta)) result.rta = {};
		result.rta.sceneState = sanitizeSceneState(null, result.tracks,
			result.rta.patterns, result.modulation);
		result.version = 3;
		version = 3;
	}
	if (version === 3) {
		if (!isObject(result.rta)) result.rta = {};
		result.rta.sceneState = sanitizeSceneState(result.rta.sceneState, result.tracks,
			result.rta.patterns, result.modulation);
		result.version = 4;
	}
	return result;
}

function buildDocument(fragments, existing) {
	var source = isObject(fragments) ? fragments : {};
	var router = isObject(source.router) ? source.router : {};
	var bank = isObject(source.bank) ? source.bank : {};
	var rack = isObject(source.rack) ? source.rack : {};
	var now = new Date().toISOString();
	var result = {
		format: FORMAT,
		version: VERSION,
		createdAt: existing && existing.createdAt ? existing.createdAt : now,
		modifiedAt: now,
		transport: deepClone(source.transport || { bpm: 120, quantize: 16, timeSignature: [4, 4] }),
		bank: deepClone(bank),
		tracks: ensureArray(router.tracks).slice(0, 16).map(deepClone),
		groups: ensureArray(router.groups).slice(0, 8).map(deepClone),
		channelStrips: ensureArray(source.channelStrips).slice(0, 8).map(deepClone),
		racks: ensureArray(rack.groups).slice(0, 8).map(deepClone),
		modulation: Product.rta ? Modulation.sanitizeState(router.modulation || source.modulation) : undefined,
		instrumentPresets: Product.rta ? deepClone(router.instrumentPresets || {}) : undefined,
		rta: Product.rta ? {
			patterns: sanitizePatterns(router.patterns),
			targetAutomation: deepClone(router.targetAutomation || {}),
			sceneState: sanitizeSceneState(router.sceneState, router.tracks,
				router.patterns, router.modulation || source.modulation)
		} : undefined,
		automation: sanitizeAutomation(router.automation),
		colors: deepClone(source.colors || {}),
		recordings: ensureArray(router.recordings).map(deepClone)
	};
	if (!Product.rta) {
		delete result.rta;
		delete result.modulation;
		delete result.instrumentPresets;
		result.tracks.forEach(function (track) { delete track.instrumentParameters; });
	}
	for (var group = 0; group < result.racks.length; group++) {
		var slots = ensureArray(result.racks[group].slots);
		for (var slot = 0; slot < slots.length; slot++) {
			if (slots[slot] && slots[slot].uri) {
				slots[slot].snapshot = pluginSnapshotPath(group, slot);
			}
		}
	}
	for (var recording = 0; recording < result.recordings.length; recording++) {
		result.recordings[recording].bundlePath = recordingPath(recording);
	}
	return result;
}

function validateDocument(source) {
	var errors = [];
	if (!isObject(source)) return { valid: false, errors: ["Session root must be an object"] };
	var base = source.format === "mlr-base-session";
	if (source.format !== FORMAT && !(Product.rta && base)) {
		errors.push(!Product.rta && source.format === "mlr-session" ?
			"Open this sequencer session in rta; MLR cannot discard its programming" : "Not an MLR session bundle");
		return { valid: false, errors: errors };
	}
	if (base && (source.rta !== undefined || source.modulation !== undefined || source.instrumentPresets !== undefined)) {
		errors.push("Base MLR sessions cannot contain sequencer, modulation, or instrument programming");
	}
	if (!Number.isInteger(source.version)) errors.push("Session version is missing");
	else if (source.version > (base ? 1 : VERSION)) errors.push("Session requires a newer MLR version");
	else if (source.version < 1) errors.push("Unsupported session version");
	if (!Array.isArray(source.tracks) || source.tracks.length !== 16) errors.push("Session must contain 16 tracks");
	if (!Array.isArray(source.groups) || source.groups.length !== 8) errors.push("Session must contain 8 groups");
	if (!Array.isArray(source.channelStrips) || source.channelStrips.length !== 8) {
		errors.push("Session must contain 8 channel strips");
	}
	if (!Array.isArray(source.racks) || source.racks.length !== 8) errors.push("Session must contain 8 plugin racks");
	if (!isObject(source.bank)) errors.push("Session sample bank is missing");
	else if (source.bank.folders !== undefined) {
		if (!Array.isArray(source.bank.folders) || source.bank.folders.length > 8) {
			errors.push("Session sample folders are invalid");
		} else {
			var folderIds = {};
			for (var folderIndex = 0; folderIndex < source.bank.folders.length; folderIndex++) {
				var folder = source.bank.folders[folderIndex];
				if (!isObject(folder) || !folder.id || folderIds[folder.id]) {
					errors.push("Invalid sample folder " + (folderIndex + 1));
				} else folderIds[folder.id] = 1;
			}
			var bankSamples = ensureArray(source.bank.samples);
			for (var bankSampleIndex = 0; bankSampleIndex < bankSamples.length; bankSampleIndex++) {
				var bankSample = bankSamples[bankSampleIndex];
				if (isObject(bankSample) && bankSample.folderId && !folderIds[bankSample.folderId]) {
					errors.push("Sample " + (bankSampleIndex + 1) + " uses an unknown folder");
				}
			}
		}
	}
	if (!base && (!isObject(source.rta) || !isObject(source.rta.patterns))) errors.push("Session ṛta data is missing");
	if (!base && source.version >= 2) {
		if (!isObject(source.modulation) || !isObject(source.modulation.sources) ||
			!Array.isArray(source.modulation.routes)) {
			errors.push("Session modulation data is missing");
		}
	}
	if (!base && source.version >= 3) {
		var sceneState = source.rta && source.rta.sceneState;
		var slots = source.version >= 4 ? sceneState && sceneState.trackSlots :
			sceneState && sceneState.trackSets;
		if (!isObject(sceneState) || !Array.isArray(sceneState.scenes) ||
			!sceneState.scenes.length || sceneState.scenes.length > Scenes.MAX_SCENES ||
			!isObject(slots) || !isObject(sceneState.patternLibrary)) {
			errors.push("Session scene data is missing");
		} else {
			for (var sceneIndex = 0; sceneIndex < sceneState.scenes.length; sceneIndex++) {
				var scene = sceneState.scenes[sceneIndex];
				if (sceneIndex > 0 && scene === null) continue;
				var slotRef = source.version >= 4 ? scene && scene.trackSlotRef :
					scene && scene.trackSetRef;
				if (!isObject(scene) || !Array.isArray(scene.groupPatternRefs) ||
					scene.groupPatternRefs.length !== Scenes.GROUP_COUNT ||
					!Array.isArray(scene.groupLaunch) ||
					scene.groupLaunch.length !== Scenes.GROUP_COUNT ||
					!slotRef || !slots[slotRef]) {
					errors.push("Invalid scene " + (sceneIndex + 1));
				}
			}
		}
	}
	if (Array.isArray(source.racks)) {
		for (var rackIndex = 0; rackIndex < source.racks.length; rackIndex++) {
			var rack = source.racks[rackIndex];
			if (!rack || !Array.isArray(rack.slots) || rack.slots.length !== 4) {
				errors.push("Plugin rack " + (rackIndex + 1) + " must contain 4 slots");
				continue;
			}
			for (var slotIndex = 0; slotIndex < rack.slots.length; slotIndex++) {
				var slot = rack.slots[slotIndex] || {};
				if (slot.uri && slot.format !== "vst3" && slot.format !== "au") {
					errors.push("Unsupported plugin format in rack " + (rackIndex + 1));
				}
				if (slot.uri && slot.format === "vst3" &&
					String(slot.uri).indexOf("C74_VST3:/") !== 0) {
					errors.push("Invalid VST3 identity in rack " + (rackIndex + 1));
				}
				if (slot.uri && slot.format === "au" &&
					String(slot.uri).indexOf("C74_AU:/") !== 0) {
					errors.push("Invalid Audio Unit identity in rack " + (rackIndex + 1));
				}
				if (slot.snapshot && !safeBundlePath(slot.snapshot, "plugins/")) {
					errors.push("Invalid plugin snapshot path in rack " + (rackIndex + 1));
				}
			}
		}
	}
	var recordings = ensureArray(source.recordings);
	var recordingBuffers = {};
	for (var recordingIndex = 0; recordingIndex < recordings.length; recordingIndex++) {
		var recording = recordings[recordingIndex] || {};
		if (!safeBundlePath(recording.bundlePath, "recordings/")) {
			errors.push("Invalid recording path");
		}
		var bufferName = String(recording.bufferName || "");
		var bufferMatch = /^([1-9]\d{0,2})file$/.exec(bufferName);
		var bufferIndex = bufferMatch ? parseInt(bufferMatch[1], 10) : 0;
		if (!bufferMatch || bufferIndex > 250 || recordingBuffers[bufferName]) {
			errors.push("Invalid or duplicate recording buffer");
		}
		if (recording.bufferIndex !== undefined &&
			parseInt(recording.bufferIndex, 10) !== bufferIndex) {
			errors.push("Recording buffer index does not match its name");
		}
		recordingBuffers[bufferName] = 1;
	}
	return { valid: errors.length === 0, errors: errors };
}

function safeBundlePath(value, prefix) {
	var path = String(value || "").replace(/\\/g, "/");
	return !!path && path.indexOf(prefix) === 0 && path.indexOf("../") < 0 &&
		path.charAt(0) !== "/" && !/^[A-Za-z]:/.test(path);
}

function basename(path) {
	var value = String(path || "").replace(/\\/g, "/");
	return value.substring(value.lastIndexOf("/") + 1);
}

function normalizePath(path) {
	return String(path || "").replace(/\\/g, "/").replace(/\/+$/, "");
}

function relativeSuffix(samplePath, root) {
	var path = normalizePath(samplePath);
	var normalizedRoot = normalizePath(root);
	if (normalizedRoot && path.indexOf(normalizedRoot + "/") === 0) {
		return path.substring(normalizedRoot.length + 1);
	}
	return basename(path);
}

function relinkSamples(document, folderFiles, exists) {
	var result = deepClone(document);
	var files = ensureArray(folderFiles).map(normalizePath);
	var byName = {};
	for (var fileIndex = 0; fileIndex < files.length; fileIndex++) {
		var name = basename(files[fileIndex]).toLowerCase();
		if (!byName[name]) byName[name] = [];
		byName[name].push(files[fileIndex]);
	}
	var relinked = [];
	var unresolved = [];
	var samples = ensureArray(result.bank.samples);
	var root = result.bank.root || "";
	var folderRoots = {};
	ensureArray(result.bank.folders).forEach(function (folder) {
		if (folder && folder.id) folderRoots[String(folder.id)] = folder.path || folder.root || "";
	});
	for (var sampleIndex = 0; sampleIndex < samples.length; sampleIndex++) {
		var sample = samples[sampleIndex];
		var path = typeof sample === "string" ? sample : String(sample.path || "");
		if (!path || (exists && exists(path))) continue;
		var sampleRoot = sample && typeof sample === "object" && sample.folderId &&
			folderRoots[String(sample.folderId)] !== undefined ?
			folderRoots[String(sample.folderId)] : root;
		var suffix = relativeSuffix(path, sampleRoot).toLowerCase();
		var suffixMatches = files.filter(function (candidate) {
			return candidate.toLowerCase().slice(-(suffix.length + 1)) === "/" + suffix ||
				candidate.toLowerCase() === suffix;
		});
		var matches = suffixMatches.length === 1 ? suffixMatches :
			(byName[basename(path).toLowerCase()] || []);
		if (matches.length === 1) {
			if (typeof sample === "string") samples[sampleIndex] = matches[0];
			else sample.path = matches[0];
			relinked.push({ index: sampleIndex, from: path, to: matches[0] });
		} else unresolved.push({ index: sampleIndex, path: path, ambiguous: matches.length > 1 });
	}
	return { document: result, relinked: relinked, unresolved: unresolved };
}

function stableObject(value) {
	if (Array.isArray(value)) return value.map(stableObject);
	if (!isObject(value)) return value;
	var result = {};
	Object.keys(value).sort().forEach(function (key) {
		if (key === "createdAt" || key === "modifiedAt" || key === "status" ||
			key === "error" || key === "latencySamples" || key === "loaded") return;
		result[key] = stableObject(value[key]);
	});
	return result;
}

function stableStringify(value) {
	return JSON.stringify(stableObject(value));
}

module.exports = {
	FORMAT: FORMAT,
	VERSION: VERSION,
	pluginSnapshotPath: pluginSnapshotPath,
	recordingPath: recordingPath,
	withBundleExtension: withBundleExtension,
	sanitizePattern: sanitizePattern,
	sanitizePatterns: sanitizePatterns,
	sanitizeSceneState: sanitizeSceneState,
	sanitizeAutomation: sanitizeAutomation,
	migrateDocument: migrateDocument,
	buildDocument: buildDocument,
	validateDocument: validateDocument,
	relinkSamples: relinkSamples,
	stableStringify: stableStringify,
	deepClone: deepClone
};
