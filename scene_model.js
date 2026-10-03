"use strict";

var VERSION = 2;
var MAX_SCENES = 16;
var MAX_TRACK_SLOTS = 16;
var GROUP_COUNT = 8;
var TRACK_COUNT = 16;
var PATTERN_SLOTS = 12;

function clone(value) {
	return value === undefined ? undefined : JSON.parse(JSON.stringify(value));
}

function isObject(value) {
	return !!value && typeof value === "object" && !Array.isArray(value);
}

function boundedIndex(value, maximum) {
	var parsed = parseInt(value, 10);
	return isFinite(parsed) && parsed >= 0 && parsed < maximum ? parsed : 0;
}

function sceneId(index) {
	return "scene:" + boundedIndex(index, MAX_SCENES);
}

function trackSlotId(index) {
	return "trackslot:" + boundedIndex(index, MAX_TRACK_SLOTS);
}

function trackSlotIndexForId(id) {
	var match = /^(?:trackslot|trackset):(\d+)$/.exec(String(id || ""));
	return match ? boundedIndex(match[1], MAX_TRACK_SLOTS) : -1;
}

function canonicalTrackSlotId(id, fallbackIndex) {
	var index = trackSlotIndexForId(id);
	return trackSlotId(index >= 0 ? index : boundedIndex(fallbackIndex, MAX_TRACK_SLOTS));
}

function groupPatternId(groupIndex, slotIndex) {
	return "group-pattern:" + boundedIndex(groupIndex, GROUP_COUNT) + ":" +
		boundedIndex(slotIndex, PATTERN_SLOTS);
}

function trackPatternId(slotId, trackIndex) {
	return canonicalTrackSlotId(slotId, 0) + ":track-pattern:" +
		boundedIndex(trackIndex, TRACK_COUNT);
}

function fixedArray(source, length, fallback) {
	var input = Array.isArray(source) ? source : [];
	var result = [];
	for (var index = 0; index < length; index++) {
		result.push(input[index] === undefined ?
			(typeof fallback === "function" ? fallback(index) : clone(fallback)) :
			clone(input[index]));
	}
	return result;
}

function splitTrackModulation(modulation) {
	var source = isObject(modulation) ? modulation : {};
	var sources = isObject(source.sources) ? source.sources : {};
	var result = { sources: {}, routes: [] };
	Object.keys(sources).forEach(function (key) {
		if (key.indexOf("track:") === 0) result.sources[key] = clone(sources[key]);
	});
	var routes = Array.isArray(source.routes) ? source.routes : [];
	for (var index = 0; index < routes.length; index++) {
		if (routes[index] && routes[index].scope === "track") {
			result.routes.push(clone(routes[index]));
		}
	}
	return result;
}

function withoutTrackModulation(modulation) {
	var source = isObject(modulation) ? modulation : {};
	var sources = isObject(source.sources) ? source.sources : {};
	var result = { sources: {}, routes: [] };
	Object.keys(sources).forEach(function (key) {
		if (key.indexOf("track:") !== 0) result.sources[key] = clone(sources[key]);
	});
	var routes = Array.isArray(source.routes) ? source.routes : [];
	for (var index = 0; index < routes.length; index++) {
		if (routes[index] && routes[index].scope !== "track") {
			result.routes.push(clone(routes[index]));
		}
	}
	return result;
}

function mergeTrackModulation(globalModulation, trackModulation) {
	var result = withoutTrackModulation(globalModulation);
	var local = splitTrackModulation(trackModulation);
	Object.keys(local.sources).forEach(function (key) {
		result.sources[key] = clone(local.sources[key]);
	});
	result.routes = result.routes.concat(clone(local.routes));
	return result;
}

function defaultTrack(trackIndex) {
	return { id: trackIndex, group: trackIndex % GROUP_COUNT, buffer: 0,
		sampleRef: null, playbackLoop: 1 };
}

function sanitizeTrack(source, trackIndex) {
	var result = isObject(source) ? clone(source) : defaultTrack(trackIndex);
	if (result.id === undefined) result.id = trackIndex;
	if (result.playbackLoop === undefined) result.playbackLoop = 1;
	else result.playbackLoop = result.playbackLoop ? 1 : 0;
	return result;
}

function makeTrackSlot(index, tracks, modulation) {
	var id = trackSlotId(index);
	return {
		id: id,
		name: "Track Slot " + (index + 1),
		tracks: fixedArray(tracks, TRACK_COUNT, defaultTrack).map(function (track, trackIndex) {
			return sanitizeTrack(track, trackIndex);
		}),
		trackPatternRefs: fixedArray([], TRACK_COUNT, function (trackIndex) {
			return trackPatternId(id, trackIndex);
		}),
		modulation: splitTrackModulation(modulation)
	};
}

function makeScene(index, groupRefs, groupLaunch, trackSlotRef) {
	return {
		id: sceneId(index),
		name: "Scene " + (index + 1),
		trackSlotRef: canonicalTrackSlotId(trackSlotRef, index),
		groupPatternRefs: fixedArray(groupRefs, GROUP_COUNT, function (groupIndex) {
			return groupPatternId(groupIndex, 0);
		}),
		groupLaunch: fixedArray(groupLaunch, GROUP_COUNT, 0).map(function (value) {
			return value ? 1 : 0;
		})
	};
}

function copyTrackPatterns(state, sourceRefs, destinationSlot) {
	var refs = Array.isArray(sourceRefs) ? sourceRefs : [];
	for (var track = 0; track < TRACK_COUNT; track++) {
		var sourceRef = refs[track];
		var destinationRef = destinationSlot.trackPatternRefs[track];
		if (sourceRef && state.patternLibrary[sourceRef]) {
			state.patternLibrary[destinationRef] = clone(state.patternLibrary[sourceRef]);
			state.patternLibrary[destinationRef].running = 0;
		}
	}
}

function createState(tracks, legacyPatterns, modulation) {
	var patterns = isObject(legacyPatterns) ? legacyPatterns : {};
	var library = {};
	var groupRefs = [];
	var groupLaunch = [];
	var slot = makeTrackSlot(0, tracks, modulation);
	for (var group = 0; group < GROUP_COUNT; group++) {
		var groupId = groupPatternId(group, 0);
		var groupPattern = patterns["group:" + group];
		groupRefs.push(groupId);
		groupLaunch.push(groupPattern && groupPattern.running ? 1 : 0);
		if (groupPattern) library[groupId] = clone(groupPattern);
	}
	for (var track = 0; track < TRACK_COUNT; track++) {
		var trackPattern = patterns["track:" + track];
		if (trackPattern) library[slot.trackPatternRefs[track]] = clone(trackPattern);
	}
	var state = {
		version: VERSION,
		activeSceneId: sceneId(0),
		selectedSceneId: sceneId(0),
		scenes: [makeScene(0, groupRefs, groupLaunch, slot.id)],
		trackSlots: {},
		patternLibrary: library
	};
	state.trackSlots[slot.id] = slot;
	return state;
}

function sceneIndexForId(id) {
	var match = /^scene:(\d+)$/.exec(String(id || ""));
	return match ? boundedIndex(match[1], MAX_SCENES) : 0;
}

function sourceTrackSlot(source, index) {
	var slots = isObject(source.trackSlots) ? source.trackSlots :
		(isObject(source.trackSets) ? source.trackSets : {});
	return slots[trackSlotId(index)] || slots["trackset:" + index] || null;
}

function sanitizeTrackSlot(source, index, fallbackTracks, modulation) {
	var fallback = makeTrackSlot(index, fallbackTracks, modulation);
	var input = isObject(source) ? source : {};
	var id = trackSlotId(index);
	return {
		id: id,
		name: String(input.name || fallback.name).replace(/^Track Set /, "Track Slot "),
		tracks: fixedArray(input.tracks, TRACK_COUNT, function (trackIndex) {
			return fallback.tracks[trackIndex];
		}).map(function (track, trackIndex) { return sanitizeTrack(track, trackIndex); }),
		trackPatternRefs: fixedArray([], TRACK_COUNT,
			function (trackIndex) { return trackPatternId(id, trackIndex); }),
		modulation: splitTrackModulation(input.modulation || fallback.modulation)
	};
}

function requestedSceneTrackSlot(input, index) {
	if (input.trackSlotRef !== undefined) return canonicalTrackSlotId(input.trackSlotRef, index);
	if (input.trackSetRef !== undefined) return canonicalTrackSlotId(input.trackSetRef, index);
	return trackSlotId(index);
}

function sanitizeScene(source, index, state) {
	var input = isObject(source) ? source : {};
	var fallback = makeScene(index);
	var requested = requestedSceneTrackSlot(input, index);
	if (!state.trackSlots[requested]) {
		requested = state.trackSlots[trackSlotId(index)] ? trackSlotId(index) : trackSlotId(0);
	}
	return {
		id: sceneId(index),
		name: String(input.name || fallback.name),
		trackSlotRef: requested,
		groupPatternRefs: fixedArray(input.groupPatternRefs, GROUP_COUNT,
			function (groupIndex) { return groupPatternId(groupIndex, 0); }).map(String),
		groupLaunch: fixedArray(input.groupLaunch, GROUP_COUNT, 0).map(function (value) {
			return value ? 1 : 0;
		})
	};
}

function sanitizeState(value, fallbackTracks, legacyPatterns, modulation) {
	if (!isObject(value) || !Array.isArray(value.scenes) ||
		(!isObject(value.trackSlots) && !isObject(value.trackSets))) {
		return createState(fallbackTracks, legacyPatterns, modulation);
	}
	var source = clone(value);
	var sourceLibrary = isObject(source.patternLibrary) ? source.patternLibrary : {};
	var state = {
		version: VERSION,
		activeSceneId: sceneId(sceneIndexForId(source.activeSceneId)),
		selectedSceneId: sceneId(sceneIndexForId(source.selectedSceneId)),
		scenes: [],
		trackSlots: {},
		patternLibrary: {}
	};
	Object.keys(sourceLibrary).forEach(function (key) {
		if (key.indexOf("group-pattern:") === 0) state.patternLibrary[key] = clone(sourceLibrary[key]);
	});
	for (var slotIndex = 0; slotIndex < MAX_TRACK_SLOTS; slotIndex++) {
		var inputSlot = sourceTrackSlot(source, slotIndex);
		if (!inputSlot && slotIndex !== 0) continue;
		var slot = sanitizeTrackSlot(inputSlot, slotIndex, fallbackTracks, modulation);
		state.trackSlots[slot.id] = slot;
		var sourceRefs = inputSlot && Array.isArray(inputSlot.trackPatternRefs) ?
			inputSlot.trackPatternRefs : [];
		for (var track = 0; track < TRACK_COUNT; track++) {
			var oldRef = sourceRefs[track] || (isObject(source.trackSets) ?
				"trackset:" + slotIndex + ":track-pattern:" + track :
				trackPatternId(slot.id, track));
			if (sourceLibrary[oldRef]) {
				state.patternLibrary[slot.trackPatternRefs[track]] = clone(sourceLibrary[oldRef]);
			}
		}
	}
	var count = Math.max(1, Math.min(MAX_SCENES, source.scenes.length));
	for (var emptyIndex = 0; emptyIndex < count; emptyIndex++) state.scenes.push(null);
	for (var sceneIndex = 0; sceneIndex < count; sceneIndex++) {
		if (sceneIndex !== 0 && !isObject(source.scenes[sceneIndex])) continue;
		state.scenes[sceneIndex] = sanitizeScene(source.scenes[sceneIndex], sceneIndex, state);
	}
	if (!state.scenes[sceneIndexForId(state.activeSceneId)]) state.activeSceneId = sceneId(0);
	if (!state.scenes[sceneIndexForId(state.selectedSceneId)]) {
		state.selectedSceneId = state.activeSceneId;
	}
	return state;
}

function ensureTrackSlot(state, index, seed) {
	var target = boundedIndex(index, MAX_TRACK_SLOTS);
	if (!state || !isObject(state.trackSlots) || !isObject(state.patternLibrary)) return null;
	var id = trackSlotId(target);
	if (state.trackSlots[id]) return state.trackSlots[id];
	var sourceRef = seed && seed.sourceTrackSlotRef ?
		canonicalTrackSlotId(seed.sourceTrackSlotRef, 0) : "";
	var source = sourceRef ? state.trackSlots[sourceRef] : null;
	var tracks = seed && Array.isArray(seed.tracks) ? seed.tracks : (source ? source.tracks : []);
	var modulation = seed && seed.modulation ? seed.modulation : (source ? source.modulation : {});
	var slot = makeTrackSlot(target, tracks, modulation);
	state.trackSlots[id] = slot;
	var sourceRefs = seed && Array.isArray(seed.trackPatternRefs) ? seed.trackPatternRefs :
		(source ? source.trackPatternRefs : []);
	copyTrackPatterns(state, sourceRefs, slot);
	return slot;
}

function ensureScene(state, index, seed) {
	var target = boundedIndex(index, MAX_SCENES);
	if (!state || !Array.isArray(state.scenes) || !isObject(state.trackSlots)) return null;
	if (state.scenes[target]) return state.scenes[target];
	while (state.scenes.length <= target) state.scenes.push(null);
	var seedScene = seed && seed.scene ? seed.scene : state.scenes[0];
	var currentRef = seed && seed.trackSlotRef ?
		canonicalTrackSlotId(seed.trackSlotRef, 0) :
		(seedScene && seedScene.trackSlotRef ? seedScene.trackSlotRef : trackSlotId(0));
	var matchingId = trackSlotId(target);
	var chosenRef = currentRef;
	if (!state.trackSlots[matchingId]) {
		ensureTrackSlot(state, target, {
			sourceTrackSlotRef: currentRef,
			tracks: seed && seed.tracks,
			modulation: seed && seed.modulation,
			trackPatternRefs: seed && seed.trackPatternRefs
		});
		chosenRef = matchingId;
	} else if (!state.trackSlots[chosenRef]) chosenRef = matchingId;
	state.scenes[target] = makeScene(target,
		seedScene ? seedScene.groupPatternRefs : null,
		seedScene ? seedScene.groupLaunch : null,
		chosenRef);
	return state.scenes[target];
}

function setSceneTrackSlot(state, sceneIndex, slotIndex) {
	var scene = state && state.scenes ? state.scenes[sceneIndex] : null;
	var id = trackSlotId(slotIndex);
	if (!scene || !state.trackSlots[id]) return false;
	scene.trackSlotRef = id;
	return true;
}

function trackSlotSceneCount(state, slotRef) {
	if (!state || !Array.isArray(state.scenes)) return 0;
	var id = canonicalTrackSlotId(slotRef, 0);
	var count = 0;
	for (var index = 0; index < state.scenes.length; index++) {
		if (state.scenes[index] && state.scenes[index].trackSlotRef === id) count++;
	}
	return count;
}

module.exports = {
	VERSION: VERSION,
	MAX_SCENES: MAX_SCENES,
	MAX_TRACK_SLOTS: MAX_TRACK_SLOTS,
	GROUP_COUNT: GROUP_COUNT,
	TRACK_COUNT: TRACK_COUNT,
	PATTERN_SLOTS: PATTERN_SLOTS,
	sceneId: sceneId,
	trackSlotId: trackSlotId,
	trackSlotIndexForId: trackSlotIndexForId,
	groupPatternId: groupPatternId,
	trackPatternId: trackPatternId,
	createState: createState,
	sanitizeState: sanitizeState,
	ensureTrackSlot: ensureTrackSlot,
	ensureScene: ensureScene,
	setSceneTrackSlot: setSceneTrackSlot,
	trackSlotSceneCount: trackSlotSceneCount,
	splitTrackModulation: splitTrackModulation,
	withoutTrackModulation: withoutTrackModulation,
	mergeTrackModulation: mergeTrackModulation,
	clone: clone
};
