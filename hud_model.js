"use strict";

/*
 * Portable state model for the MLR HUD.
 *
 * This module deliberately contains no Max, mgraphics, Buffer, Task, or patcher
 * APIs.  hud.js uses it in v8ui and the Node tests use the same reducer.
 */

var HUD_PAGES = ["live", "pattern", "strip", "samples", "colors", "session", "help"];
var GRID_SIZE = 16;
var TRACK_COUNT = 16;
var CHANNEL_COUNT = 8;
var SAMPLE_PAGE_SIZE = 16;

var COLORS = {
	background: [10, 13, 18],
	panel: [18, 23, 31],
	panelRaised: [25, 31, 41],
	line: [47, 57, 72],
	text: [226, 232, 240],
	dimText: [126, 139, 155],
	cyan: [0, 210, 255],
	green: [45, 230, 105],
	red: [225, 45, 70],
	amber: [255, 180, 20],
	purple: [190, 85, 255],
	blue: [70, 110, 235],
	white: [255, 255, 255]
};

var GROUP_COLORS = [
	[255, 65, 55], [255, 135, 20], [245, 205, 30], [40, 215, 90],
	[0, 195, 210], [35, 125, 255], [135, 75, 255], [235, 55, 190]
];

function clamp(value, minimum, maximum) {
	var number = Number(value);
	if (!isFinite(number)) number = minimum;
	return Math.min(maximum, Math.max(minimum, number));
}

function integer(value, fallback) {
	var parsed = parseInt(value, 10);
	return isFinite(parsed) ? parsed : fallback;
}

function blankTrack(index) {
	return {
		id: index,
		group: 7,
		buffer: -1,
		sampleIndex: -1,
		length: 16,
		position: 0,
		octave: 0,
		transpose: 0,
		reverse: 0,
		loopStart: 0,
		loopEnd: 16,
		loopDivision: 8,
		loopActive: 0
	};
}

function blankChannel(index) {
	return {
		id: index,
		volume: 100,
		muted: 0,
		timestretch: 0,
		gateLatch: 0,
		activeTrack: -1,
		lastActiveTrack: -1,
		running: 0
	};
}

function blankChannelStrip(index) {
	return {
		id: index,
		engine: 0,
		cutoff: 1,
		filterMod: 1,
		resonance: 0,
		threshold: -18,
		ratio: 4,
		attack: 10,
		release: 120,
		knee: 6,
		makeup: 0,
		mix: 1,
		drive: 0,
		trim: 0,
		inputDb: -120,
		outputDb: -120,
		reduction: 0
	};
}

function blankRackSlot(group, slot) {
	return { group: group, slot: slot, format: "", uri: "", name: "Empty",
		loaded: 0, bypassed: 0, latencySamples: 0, hasEditor: 0,
		status: "empty", error: "", snapshot: "" };
}

function blankRackGroup(index) {
	var slots = [];
	for (var slot = 0; slot < 4; slot++) slots.push(blankRackSlot(index, slot));
	return { id: index, slots: slots, latencySamples: 0, latencyMs: 0 };
}

function blankPattern() {
	return {
		targetType: "none",
		targetId: -1,
		running: 0,
		bars: 1,
		currentBar: 0,
		length: 64,
		rateNumerator: 1,
		rateDenominator: 1,
		defaultTrack: -1,
		playheadBar: -1,
		playheadStep: -1,
		decisionOutcome: "",
		steps: []
	};
}

function blankStep(index) {
	return {
		index: index,
		cut: 0,
		track: -1,
		slice: -1,
		probability: 15,
		condition: 0,
		gateLength: 1,
		locks: {},
		lockCount: 0
	};
}

function createState() {
	var tracks = [];
	var channels = [];
	var channelStrips = [];
	var racks = [];
	var levels = [];
	var colors = [];
	for (var track = 0; track < TRACK_COUNT; track++) tracks.push(blankTrack(track));
	for (var channel = 0; channel < CHANNEL_COUNT; channel++) channels.push(blankChannel(channel));
	for (var strip = 0; strip < CHANNEL_COUNT; strip++) channelStrips.push(blankChannelStrip(strip));
	for (var rack = 0; rack < CHANNEL_COUNT; rack++) racks.push(blankRackGroup(rack));
	for (var cell = 0; cell < GRID_SIZE * GRID_SIZE; cell++) {
		levels.push(0);
		colors.push([28, 48, 90]);
	}
	return {
		page: "live",
		mode: 1,
		bpm: 120,
		quantize: 16,
		grid: {
			levels: levels,
			colors: colors,
			pressed: {},
			lastPress: null
		},
		tracks: tracks,
		channels: channels,
		channelStrips: channelStrips,
		pluginRacks: racks,
		rackInventory: { vst3: [], au: [] },
		rackInventoryStatus: {
			phase: "idle", revision: 0, vst3: 0, au: 0,
			message: "Waiting for Max plugin cache"
		},
		rackInventoryStaging: {},
		rackLatencyMismatch: 0,
		stripView: "builtin",
		rackChooser: { active: 0, group: 0, slot: 0, format: "vst3", page: 0 },
		editor: {
			active: 0,
			choosing: 0,
			targetType: "none",
			targetId: -1,
			view: "sequence",
			heldStep: -1,
			parameter: "slice",
			record: 0
		},
		pattern: blankPattern(),
		patternSummaries: {},
		bank: {
			status: "empty",
			source: "json",
			path: "",
			root: "",
			count: 0,
			samples: [],
			assignments: new Array(TRACK_COUNT).fill(-1)
		},
		waveforms: {},
		selectedTrack: 0,
		selectedChannelStrip: 0,
		selectedSample: -1,
		samplePage: 0,
		sampleBrowserActive: 0,
		sampleBrowserPage: 0,
		colorLab: {
			roles: {},
			order: [],
			selected: "",
			page: 0
		},
		session: {
			name: "Untitled", path: "", dirty: 0, busy: 0, operation: "",
			missing: [], confirmation: "", message: "No session saved"
		},
		helpTopic: "follow",
		hover: null,
		notice: "HUD ready",
		noticeLevel: "info",
		revision: 0
	};
}

function eventArgs(args) {
	if (!args) return [];
	if (Array.isArray(args)) return args;
	return Array.prototype.slice.call(args);
}

function parseJson(value, fallback) {
	if (value && typeof value === "object") return value;
	try {
		return JSON.parse(String(value));
	} catch (error) {
		return fallback;
	}
}

function gridIndex(x, y) {
	return y * GRID_SIZE + x;
}

function hitRegion(id, x, y, width, height, payload) {
	return {
		id: String(id || ""),
		x: Number(x) || 0,
		y: Number(y) || 0,
		width: Math.max(0, Number(width) || 0),
		height: Math.max(0, Number(height) || 0),
		payload: payload || {}
	};
}

function regionAt(regions, x, y) {
	var list = Array.isArray(regions) ? regions : [];
	var px = Number(x);
	var py = Number(y);
	if (!isFinite(px) || !isFinite(py)) return null;
	for (var index = list.length - 1; index >= 0; index--) {
		var region = list[index];
		if (px >= region.x && py >= region.y && px <= region.x + region.width &&
			py <= region.y + region.height) return region;
	}
	return null;
}

function applyGridLevelMap(state, args) {
	var x0 = integer(args[0], 0);
	var y0 = integer(args[1], 0);
	var values = args.slice(2);
	var width = values.length >= 64 ? 8 : Math.max(1, integer(args[2], 8));
	if (values.length < 64 && args.length > 3) values = args.slice(3);
	for (var index = 0; index < values.length; index++) {
		var x = x0 + index % width;
		var y = y0 + Math.floor(index / width);
		if (x >= 0 && x < GRID_SIZE && y >= 0 && y < GRID_SIZE) {
			state.grid.levels[gridIndex(x, y)] = clamp(integer(values[index], 0), 0, 15);
		}
	}
}

function applyGridColorMap(state, args) {
	var x0 = integer(args[0], 0);
	var y0 = integer(args[1], 0);
	var values = args.slice(2);
	for (var cell = 0; cell * 3 + 2 < values.length; cell++) {
		var x = x0 + cell % 4;
		var y = y0 + Math.floor(cell / 4);
		if (x >= 0 && x < GRID_SIZE && y >= 0 && y < GRID_SIZE) {
			state.grid.colors[gridIndex(x, y)] = [
				clamp(integer(values[cell * 3], 0), 0, 255),
				clamp(integer(values[cell * 3 + 1], 0), 0, 255),
				clamp(integer(values[cell * 3 + 2], 0), 0, 255)
			];
		}
	}
}

function normalizeStep(source, index) {
	var step = blankStep(index);
	if (!source || typeof source !== "object") return step;
	var cut = source.cut && typeof source.cut === "object" ? source.cut : null;
	step.cut = cut ? 1 : 0;
	step.track = cut ? integer(cut.track, -1) : -1;
	step.slice = cut ? integer(cut.slice, -1) : -1;
	step.gateLength = cut ? clamp(integer(cut.gateLength, 1), 1, 64) : 1;
	step.probability = clamp(integer(source.probability, 15), 0, 15);
	var condition = integer(source.condition, 0);
	step.condition = Math.abs(condition) < 2 ? 0 :
		(condition < 0 ? -1 : 1) * clamp(Math.abs(condition), 2, 9);
	step.locks = source.locks && typeof source.locks === "object" ? source.locks : {};
	step.lockCount = Object.keys(step.locks).length + (step.condition ? 1 : 0);
	return step;
}

function applyPatternSnapshot(state, value) {
	var source = parseJson(value, null);
	if (!source) return;
	var pattern = blankPattern();
	pattern.targetType = source.targetType === "track" ? "track" : "group";
	pattern.targetId = integer(source.targetId, 0);
	pattern.running = source.running ? 1 : 0;
	pattern.bars = clamp(integer(source.bars, 1), 1, 8);
	pattern.currentBar = clamp(integer(source.currentBar, 0), 0, pattern.bars - 1);
	pattern.length = clamp(integer(source.length, 64), 1, 64);
	pattern.rateNumerator = Math.max(1, integer(source.rateNumerator, 1));
	pattern.rateDenominator = Math.max(1, integer(source.rateDenominator, 1));
	pattern.defaultTrack = integer(source.defaultTrack, -1);
	pattern.playheadBar = integer(source.playheadBar, -1);
	pattern.playheadStep = integer(source.playheadStep, -1);
	pattern.decisionOutcome = normalizeDecisionOutcome(source.decisionOutcome);
	var steps = Array.isArray(source.steps) ? source.steps : [];
	for (var index = 0; index < 64; index++) pattern.steps.push(normalizeStep(steps[index], index));
	state.pattern = pattern;
}

function applyEvent(state, topic, incomingArgs) {
	if (!state || typeof state !== "object") state = createState();
	var args = eventArgs(incomingArgs);
	switch (String(topic || "")) {
		case "grid_level_map":
			applyGridLevelMap(state, args);
			break;
		case "grid_color_map":
			applyGridColorMap(state, args);
			break;
		case "grid_color_cell": {
			var colorX = integer(args[0], -1);
			var colorY = integer(args[1], -1);
			if (colorX >= 0 && colorX < 16 && colorY >= 0 && colorY < 16) {
				state.grid.colors[gridIndex(colorX, colorY)] = [
					clamp(integer(args[2], 0), 0, 255),
					clamp(integer(args[3], 0), 0, 255),
					clamp(integer(args[4], 0), 0, 255)
				];
			}
			break;
		}
		case "grid_color_all":
			for (var colorCell = 0; colorCell < state.grid.colors.length; colorCell++) {
				state.grid.colors[colorCell] = [
					clamp(integer(args[0], 0), 0, 255),
					clamp(integer(args[1], 0), 0, 255),
					clamp(integer(args[2], 0), 0, 255)
				];
			}
			break;
		case "color_role": {
			var roleName = String(args[0] || "");
			if (!roleName) break;
			if (!state.colorLab.roles[roleName]) state.colorLab.order.push(roleName);
			state.colorLab.roles[roleName] = {
				name: roleName,
				category: String(args[1] || "PAGE"),
				label: colorRoleLabel(roleName),
				color: [
					clamp(integer(args[2], 0), 0, 255),
					clamp(integer(args[3], 0), 0, 255),
					clamp(integer(args[4], 0), 0, 255)
				]
			};
			if (!state.colorLab.selected) state.colorLab.selected = roleName;
			break;
		}
		case "grid_press": {
			var pressX = clamp(integer(args[0], 0), 0, 15);
			var pressY = clamp(integer(args[1], 0), 0, 15);
			var down = args[2] ? 1 : 0;
			var key = pressX + ":" + pressY;
			if (down) state.grid.pressed[key] = 1;
			else delete state.grid.pressed[key];
			state.grid.lastPress = { x: pressX, y: pressY, state: down };
			break;
		}
		case "mode":
			state.mode = clamp(integer(args[0], 1), 1, 4);
			break;
		case "clock":
			state.bpm = clamp(Number(args[0]) || 120, 20, 400);
			state.quantize = Math.max(1, integer(args[1], state.quantize));
			break;
		case "track": {
			var trackId = integer(args[0], -1);
			if (trackId >= 0 && trackId < TRACK_COUNT) {
				var trackState = state.tracks[trackId];
				trackState.group = clamp(integer(args[1], trackState.group), 0, 7);
				trackState.buffer = integer(args[2], trackState.buffer);
				trackState.length = clamp(integer(args[3], trackState.length), 1, 16);
				trackState.position = clamp(integer(args[4], trackState.position), 0, 15);
				trackState.octave = integer(args[5], trackState.octave);
				trackState.transpose = integer(args[6], trackState.transpose);
				trackState.reverse = args[7] ? 1 : 0;
				trackState.loopStart = clamp(Number(args[8]) || 0, 0, 16);
				trackState.loopEnd = clamp(Number(args[9]) || 16, 0, 16);
				trackState.loopDivision = Math.max(1, integer(args[10], trackState.loopDivision));
				trackState.loopActive = args[11] ? 1 : 0;
				if (args.length > 12) trackState.sampleIndex = integer(args[12], -1);
			}
			break;
		}
		case "channel": {
			var channelId = integer(args[0], -1);
			if (channelId >= 0 && channelId < CHANNEL_COUNT) {
				var channelState = state.channels[channelId];
				channelState.volume = clamp(Number(args[1]) || 0, 0, 158);
				channelState.muted = args[2] ? 1 : 0;
				channelState.timestretch = args[3] ? 1 : 0;
				channelState.gateLatch = args[4] ? 1 : 0;
				channelState.activeTrack = integer(args[5], -1);
				channelState.lastActiveTrack = integer(args[6], -1);
				channelState.running = args[7] ? 1 : 0;
			}
			break;
		}
		case "channel_strip": {
			var stripId = integer(args[0], -1);
			if (stripId >= 0 && stripId < CHANNEL_COUNT) {
				var stripState = state.channelStrips[stripId];
				stripState.engine = clamp(integer(args[1], stripState.engine), 0, 2);
				stripState.cutoff = clamp(Number(args[2]), 0, 1);
				stripState.filterMod = clamp(Number(args[3]), 0, 1);
				stripState.resonance = clamp(Number(args[4]), 0, 1);
				stripState.threshold = clamp(Number(args[5]), -60, 0);
				stripState.ratio = clamp(Number(args[6]), 1, 20);
				stripState.attack = clamp(Number(args[7]), 0.1, 500);
				stripState.release = clamp(Number(args[8]), 5, 5000);
				stripState.knee = clamp(Number(args[9]), 0, 24);
				stripState.makeup = clamp(Number(args[10]), -12, 24);
				stripState.mix = clamp(Number(args[11]), 0, 1);
				stripState.drive = clamp(Number(args[12]), 0, 12);
				stripState.trim = clamp(Number(args[13]), -24, 12);
			}
			break;
		}
		case "channel_strip_meter": {
			var meterId = integer(args[0], -1);
			if (meterId >= 0 && meterId < CHANNEL_COUNT) {
				var meterState = state.channelStrips[meterId];
				meterState.inputDb = clamp(Number(args[1]), -120, 24);
				meterState.outputDb = clamp(Number(args[2]), -120, 24);
				meterState.reduction = meterState.engine ?
					clamp(meterState.inputDb - meterState.outputDb +
						(Number(args[3]) || meterState.makeup), 0, 60) : 0;
			}
			break;
		}
		case "rack_inventory": {
			var inventory = parseJson(args[0], null);
			if (inventory) {
				state.rackInventory.vst3 = Array.isArray(inventory.vst3) ? inventory.vst3 : [];
				state.rackInventory.au = Array.isArray(inventory.au) ? inventory.au : [];
				state.rackInventoryStatus.phase = "ready";
				state.rackInventoryStatus.vst3 = state.rackInventory.vst3.length;
				state.rackInventoryStatus.au = state.rackInventory.au.length;
			}
			break;
		}
		case "rack_inventory_begin": {
			var beginRevision = Math.max(0, integer(args[0], 0));
			var beginFormat = String(args[1] || "");
			if (beginFormat === "vst3" || beginFormat === "au") {
				state.rackInventoryStaging[beginFormat] = {
					revision: beginRevision,
					expected: Math.max(0, integer(args[2], 0)),
					entries: []
				};
			}
			break;
		}
		case "rack_inventory_item": {
			var itemRevision = Math.max(0, integer(args[0], 0));
			var itemFormat = String(args[1] || "");
			var itemIndex = Math.max(0, integer(args[2], 0));
			var staging = state.rackInventoryStaging[itemFormat];
			if (staging && staging.revision === itemRevision &&
				(itemFormat === "vst3" || itemFormat === "au")) {
				staging.entries[itemIndex] = {
					format: itemFormat,
					uri: String(args[3] || ""),
					name: String(args[4] || args[3] || "Plugin")
				};
			}
			break;
		}
		case "rack_inventory_end": {
			var endRevision = Math.max(0, integer(args[0], 0));
			var endFormat = String(args[1] || "");
			var complete = state.rackInventoryStaging[endFormat];
			if (complete && complete.revision === endRevision) {
				var compactEntries = [];
				for (var inventoryIndex = 0; inventoryIndex < complete.entries.length;
					inventoryIndex++) {
					if (complete.entries[inventoryIndex]) compactEntries.push(complete.entries[inventoryIndex]);
				}
				// Do not replace a known-good list with a truncated transfer.
				if (compactEntries.length === complete.expected) {
					state.rackInventory[endFormat] = compactEntries;
				}
				delete state.rackInventoryStaging[endFormat];
			}
			break;
		}
		case "rack_inventory_status": {
			state.rackInventoryStatus.phase = String(args[0] || "idle");
			state.rackInventoryStatus.revision = Math.max(0, integer(args[1], 0));
			state.rackInventoryStatus.vst3 = Math.max(0, integer(args[2],
				state.rackInventory.vst3.length));
			state.rackInventoryStatus.au = Math.max(0, integer(args[3],
				state.rackInventory.au.length));
			state.rackInventoryStatus.message = String(args[4] || "");
			break;
		}
		case "rack_state": {
			var rackGroup = integer(args[0], -1);
			var rackSlot = integer(args[1], -1);
			var rackPayload = parseJson(args[2], null);
			if (rackPayload && rackGroup >= 0 && rackGroup < 8 && rackSlot >= 0 && rackSlot < 4) {
				var normalizedRackSlot = blankRackSlot(rackGroup, rackSlot);
				for (var rackKey in rackPayload) normalizedRackSlot[rackKey] = rackPayload[rackKey];
				state.pluginRacks[rackGroup].slots[rackSlot] = normalizedRackSlot;
			}
			break;
		}
		case "rack_latency": {
			var latencyGroup = integer(args[0], -1);
			if (latencyGroup >= 0 && latencyGroup < 8) {
				state.pluginRacks[latencyGroup].latencySamples = Math.max(0, integer(args[1], 0));
				state.pluginRacks[latencyGroup].latencyMs = Math.max(0, Number(args[2]) || 0);
				state.rackLatencyMismatch = args[3] ? 1 : 0;
			}
			break;
		}
		case "session_state": {
			var sessionPayload = parseJson(args[0], null);
			if (sessionPayload) {
				for (var sessionKey in state.session) {
					if (sessionPayload[sessionKey] !== undefined) state.session[sessionKey] = sessionPayload[sessionKey];
				}
				state.session.missing = Array.isArray(sessionPayload.missing) ? sessionPayload.missing : [];
			}
			break;
		}
		case "session_missing": {
			var missingIndex = Math.max(0, integer(args[0], 0));
			state.session.missing[missingIndex] = {
				type: String(args[1] || "sample"), path: String(args[2] || ""),
				ambiguous: args[3] ? 1 : 0
			};
			break;
		}
		case "editor":
			state.editor.active = args[0] ? 1 : 0;
			state.editor.choosing = args[1] ? 1 : 0;
			state.editor.targetType = String(args[2] || "none");
			state.editor.targetId = integer(args[3], -1);
			state.editor.view = String(args[4] || "sequence");
			state.editor.heldStep = integer(args[5], -1);
			state.editor.parameter = String(args[6] || "slice");
			state.editor.record = args[7] ? 1 : 0;
			break;
		case "pattern_summary": {
			var summaryKey = String(args[0]) + ":" + integer(args[1], 0);
			state.patternSummaries[summaryKey] = {
				targetType: String(args[0]),
				targetId: integer(args[1], 0),
				running: args[2] ? 1 : 0,
				bars: Math.max(1, integer(args[3], 1)),
				currentBar: Math.max(0, integer(args[4], 0)),
				length: clamp(integer(args[5], 64), 1, 64),
				rateNumerator: Math.max(1, integer(args[6], 1)),
				rateDenominator: Math.max(1, integer(args[7], 1)),
				content: args[8] ? 1 : 0
			};
			break;
		}
		case "pattern_snapshot":
			applyPatternSnapshot(state, args[0]);
			break;
		case "pattern_playhead":
			if (String(args[0]) === state.pattern.targetType &&
				integer(args[1], -1) === state.pattern.targetId) {
				state.pattern.playheadBar = integer(args[2], -1);
				state.pattern.playheadStep = integer(args[3], -1);
				state.pattern.decisionOutcome = normalizeDecisionOutcome(args[4]);
			}
			break;
		case "bank":
			state.bank.status = String(args[0] || "empty");
			state.bank.path = String(args[1] || "");
			state.bank.root = String(args[2] || "");
			state.bank.count = Math.max(0, integer(args[3], state.bank.samples.length));
			state.bank.source = String(args[4] || state.bank.source || "json");
			if (state.bank.status === "loading") state.bank.samples = [];
			break;
		case "sample": {
			var sampleId = integer(args[0], -1);
			if (sampleId >= 0) {
				state.bank.samples[sampleId] = {
					id: sampleId,
					buffer: integer(args[1], sampleId + 8),
					name: String(args[2] || ("Sample " + (sampleId + 1))),
					path: String(args[3] || ""),
					mediaType: String(args[4] || ""),
					channels: Math.max(0, integer(args[5], 0)),
					durationMs: Math.max(0, Number(args[6]) || 0),
					sampleRate: Math.max(0, Number(args[7]) || 0),
					category: String(args[8] || "other"),
					family: String(args[9] || "other"),
					color: [
						clamp(integer(args[10], COLORS.cyan[0]), 0, 255),
						clamp(integer(args[11], COLORS.cyan[1]), 0, 255),
						clamp(integer(args[12], COLORS.cyan[2]), 0, 255)
					]
				};
				state.bank.count = Math.max(state.bank.count, sampleId + 1);
			}
			break;
		}
		case "browser_selection":
			if (integer(args[0], -1) >= 0) selectTrack(state, integer(args[0], 0));
			if (integer(args[1], -1) >= 0) selectSample(state, integer(args[1], 0));
			break;
		case "sample_browser":
			state.sampleBrowserActive = args[0] ? 1 : 0;
			if (integer(args[1], -1) >= 0) selectTrack(state, integer(args[1], 0));
			if (integer(args[2], -1) >= 0) selectSample(state, integer(args[2], 0));
			state.sampleBrowserPage = Math.max(0, integer(args[3], state.sampleBrowserPage));
			break;
		case "assignment": {
			var assignmentTrack = integer(args[0], -1);
			var assignmentSample = integer(args[1], -1);
			if (assignmentTrack >= 0 && assignmentTrack < TRACK_COUNT) {
				state.bank.assignments[assignmentTrack] = assignmentSample;
				state.tracks[assignmentTrack].sampleIndex = assignmentSample;
				if (args.length > 2) state.tracks[assignmentTrack].buffer = integer(args[2], -1);
			}
			break;
		}
		case "waveform": {
			var waveform = parseJson(args[1], null);
			if (waveform) state.waveforms[String(integer(args[0], -1))] = waveform;
			break;
		}
		case "notice":
			state.noticeLevel = String(args[0] || "info");
			state.notice = args.slice(1).join(" ");
			break;
	}
	state.revision++;
	return state;
}

function setPage(state, page) {
	if (HUD_PAGES.indexOf(page) >= 0) state.page = page;
	return state.page;
}

function selectTrack(state, trackIndex) {
	state.selectedTrack = clamp(integer(trackIndex, 0), 0, TRACK_COUNT - 1);
	var assigned = state.bank.assignments[state.selectedTrack];
	if (assigned >= 0) {
		state.selectedSample = assigned;
		state.samplePage = Math.floor(assigned / SAMPLE_PAGE_SIZE);
	}
	return state.selectedTrack;
}

function selectChannelStrip(state, channelIndex) {
	state.selectedChannelStrip = clamp(integer(channelIndex, 0), 0, CHANNEL_COUNT - 1);
	return state.selectedChannelStrip;
}

function setStripView(state, view) {
	state.stripView = String(view) === "rack" ? "rack" : "builtin";
	return state.stripView;
}

function selectSample(state, sampleIndex) {
	var last = Math.max(0, state.bank.count - 1);
	state.selectedSample = state.bank.count ? clamp(integer(sampleIndex, 0), 0, last) : -1;
	if (state.selectedSample >= 0) state.samplePage = Math.floor(state.selectedSample / SAMPLE_PAGE_SIZE);
	return state.selectedSample;
}

function pageSamples(state) {
	var start = state.samplePage * SAMPLE_PAGE_SIZE;
	return state.bank.samples.slice(start, start + SAMPLE_PAGE_SIZE);
}

function modeName(mode, editor) {
	if (mode === 1) return "MAIN";
	if (mode === 2 && editor && editor.active) return "ṛta";
	if (mode === 2) return "MOD";
	if (mode === 3) return "GROUPS";
	return "AUX";
}

function targetLabel(type, id) {
	if (type !== "group" && type !== "track") return "NO TARGET";
	return type.toUpperCase() + " " + (integer(id, 0) + 1);
}

function rateLabel(numerator, denominator) {
	var n = Math.max(1, integer(numerator, 1));
	var d = Math.max(1, integer(denominator, 1));
	return n === d ? "1x" : n + "/" + d + "x";
}

function normalizeDecisionOutcome(value) {
	var outcome = String(value || "");
	return outcome === "conditionPlay" || outcome === "conditionSkip" ||
		outcome === "probabilityPlay" || outcome === "probabilitySkip" ? outcome : "";
}

function basename(path) {
	var text = String(path || "").replace(/\\/g, "/");
	return text.substring(text.lastIndexOf("/") + 1) || text;
}

function colorRoleLabel(name) {
	var raw = String(name || "");
	var parts = raw.split(".");
	var leaf = parts.length > 1 ? parts.slice(1).join(" ") : raw;
	if (parts[0] === "group") return "Group " + leaf;
	leaf = leaf.replace(/([a-z0-9])([A-Z])/g, "$1 $2");
	return leaf.charAt(0).toUpperCase() + leaf.substring(1);
}

function sampleLabel(state, sampleIndex) {
	var sample = state.bank.samples[sampleIndex];
	return sample ? (sample.name || basename(sample.path)) : "—";
}

function describeCell(mode, x, y, editor, helpTopic) {
	x = clamp(integer(x, 0), 0, 15);
	y = clamp(integer(y, 0), 0, 15);
	var topic = helpTopic && helpTopic !== "follow" ? helpTopic : modeName(mode, editor).toLowerCase();
	if (topic === "ṛta") topic = "sequence64";
	var title = "Grid " + (x + 1) + ", " + (y + 1);
	var detail = "Unassigned or contextual control";
	var gesture = "Press";
	var stateMeaning = "Brightness shows active, latched, or available state";
	var colorMeaning = "Semantic color follows the control role";
	if (topic === "main") {
		if (y === 0 && x < 8) detail = "Stop group " + (x + 1);
		else if (y === 0 && x >= 8 && x <= 11) detail = "Legacy pattern recorder " + (x - 7);
		else if (y === 0 && x === 13) {
			detail = "Record live cuts into ṛta";
			gesture = "Hold while playing";
		}
		else if (y === 0 && x >= 14) detail = "Page navigation";
		else if (y > 0) detail = "Track " + y + " slice " + (x + 1);
	} else if (topic === "mod") {
		if (y === 0 && x < 8) detail = "Mute group " + (x + 1);
		else if (y === 4 && x < 8) {
			detail = "Run or open group pattern " + (x + 1);
			gesture = "Tap Run · hold Open";
			colorMeaning = "Red family identifies pattern transport";
		} else if (x === 11 && y > 0) {
			detail = "Preview or open track phrase " + y;
			gesture = "Tap Preview · hold Open";
			colorMeaning = "Red family identifies phrase transport";
		}
		else if (x === 8) {
			detail = y === 0 ? "Randomize all tracks" :
				"Browse samples or randomize track " + y;
			if (y > 0) gesture = "Tap sample browser · hold Randomize";
		}
		else if (x === 13 || x === 14) detail = "Track-wide octave control";
		else if (x === 15) detail = "Reverse track " + y;
	} else if (topic === "groups") {
		detail = x >= 8 && y > 0 ? "Assign track " + y + " to group " + (x - 7) : "Page navigation";
	} else if (topic === "sequence64") {
		if (y >= 8 && y <= 11) {
			detail = "ṛta step " + ((y - 8) * 16 + x + 1);
			gesture = "Tap trigger · hold locks";
			stateMeaning = "Fill, playhead, probability, gate tail, and locks are layered";
		}
		else if (y === 12) detail = "Length, bar, and lock-parameter controls";
		else if (y === 13) detail = "Transport or selected lock value";
		else if (y === 14) detail = "Live lane, shapes, and tools";
		else if (y === 15 && x === 12) detail = "Open or close the split sample browser";
		else if (y === 15) detail = "Sequence navigation and target controls";
	} else if (topic === "locks") {
		if (y >= 8 && y <= 11) detail = "Select or enable step " + ((y - 8) * 16 + x + 1);
		else if (y === 12) {
			if (x === 12 && editor && editor.targetType === "group") {
				detail = "Track lock selector for group patterns";
			} else if ((x === 13 && editor && editor.targetType === "group") ||
				(x === 12 && editor && editor.targetType === "track")) {
				detail = "Conditional trigger selector";
			} else detail = "Choose the parameter edited on the selected step";
		} else if (y === 13 && editor && editor.parameter === "condition" && x < 8) {
			detail = "Condition: play once every " + (x + 2) + " pattern visits";
		} else if (y === 13 && editor && editor.parameter === "condition") {
			detail = "Condition: skip once every " + (x - 6) + " pattern visits";
		} else if (y === 13) detail = "Set the selected lock value";
		else if (y === 14) detail = "Choose lock shape or clear the selected lock";
		else detail = "Lock editor navigation";
		colorMeaning = "Parameter and shape families retain stable colors";
	} else if (topic === "samples") {
		if (y === 0) detail = "Sample browser: select track " + (x + 1);
		else if (y <= 6) detail = "Paged sample slot " + ((y - 1) * 16 + x + 1);
		else if (y === 7) detail = "Sample page navigation and close";
		else detail = "Lower-half ṛta editor remains active";
		gesture = y === 0 ? "Tap track · hold selected track to close" :
			(y <= 6 ? "Tap to audition · tap again to assign" : "Contextual editor control");
		stateMeaning = y === 0 ? "Bright is selected track" :
			(y <= 6 ? "Bright is selected; medium is assigned to the selected track" :
				"Top and bottom halves retain independent ownership");
		colorMeaning = y === 0 ? "Track uses its assigned group color" :
			(y <= 6 ? "Normalized filename families share stable colors" :
				"ṛta semantic colors remain unchanged below");
	}
	return {
		title: title,
		detail: detail,
		topic: topic,
		gesture: gesture,
		state: stateMeaning,
		color: colorMeaning
	};
}

module.exports = {
	HUD_PAGES: HUD_PAGES,
	GRID_SIZE: GRID_SIZE,
	TRACK_COUNT: TRACK_COUNT,
	CHANNEL_COUNT: CHANNEL_COUNT,
	SAMPLE_PAGE_SIZE: SAMPLE_PAGE_SIZE,
	COLORS: COLORS,
	GROUP_COLORS: GROUP_COLORS,
	createState: createState,
	applyEvent: applyEvent,
	setPage: setPage,
	selectTrack: selectTrack,
	selectChannelStrip: selectChannelStrip,
	setStripView: setStripView,
	selectSample: selectSample,
	pageSamples: pageSamples,
	gridIndex: gridIndex,
	hitRegion: hitRegion,
	regionAt: regionAt,
	modeName: modeName,
	targetLabel: targetLabel,
	rateLabel: rateLabel,
	basename: basename,
	colorRoleLabel: colorRoleLabel,
	sampleLabel: sampleLabel,
	describeCell: describeCell,
	normalizeStep: normalizeStep,
	clamp: clamp
};
