/*
 * Portable sample-bank loader.
 *
 * The default manifest is sample-bank.json beside the MLR patch. Paths in the
 * manifest are resolved relative to its "root" directory. Version 2 may group
 * one append-only catalog into up to eight folder roots. Imported files use
 * MLR's existing file-list/buffer path, so scenes, presets, and front-page
 * menus continue to use stable numeric selections.
 */

autowatch = 1;
inlets = 1;
outlets = 0;

var manifestPath = "";
var manifestDirectory = "";
var bank = null;
var bankSource = "json";
var pendingSamples = [];
var sampleRecords = [];
var sampleFolders = [];
var activeFolderId = "";
var runtimeAssignments = makeFilledArray(16, -1);
var loadIndex = 0;
var loadTask = null;
var FIRST_MENU_INDEX = 8;
var FIRST_BANK_BUFFER = FIRST_MENU_INDEX + 1;
var TRACK_COUNT = 16;
var SMART_SCAN_LIMIT = 240;
var SMART_SCAN_VISIT_LIMIT = 12000;
var SMART_SCAN_MAX_DEPTH = 8;
var SMART_SCAN_STEP_BUDGET = 96;
var MAX_SAMPLE_FOLDERS = 8;
var MAX_FILE_BUFFER = 250;
var BUFFER_MUTATION_SETTLE_MS = 75;
var scanRoot = "";
var scanLimit = SMART_SCAN_LIMIT;
var scanQueue = [];
var scanCurrent = null;
var scanCurrentDepth = 0;
var scanCandidates = [];
var scanVisited = 0;
var scanTask = null;
var scanTargetFolderId = "";
var sessionStateApplying = false;
var pendingCapture = null;
var captureSerial = 0;
var captureSourceMode = "input";
var recordingAssets = {};

// sample_bank.js runs in Max's legacy [js] engine, where Array.prototype.fill
// is not available. Keep array construction ES5-compatible here even though
// the HUD and router run in [v8].
function makeFilledArray(length, value) {
	var values = new Array(length);
	for (var index = 0; index < length; index++) values[index] = value;
	return values;
}

function directoryOf(path) {
	var slash = Math.max(path.lastIndexOf("/"), path.lastIndexOf("\\"));
	return slash >= 0 ? path.substring(0, slash) : "";
}

function projectDirectory() {
	var path = this.patcher && this.patcher.filepath ? this.patcher.filepath : "";
	return directoryOf(path);
}

function joinPath(base, name) {
	if (!base) return name;
	if (!name) return base;
	if (name.charAt(0) === "/" || /^[A-Za-z]:[\\/]/.test(name) ||
		/^[^\\/]+:\//.test(name)) return name;
	return base + (base.charAt(base.length - 1) === "/" ? "" : "/") + name;
}

function normalizeSampleEntry(entry) {
	if (typeof entry === "string") return entry;
	if (entry && typeof entry.path === "string") return entry.path;
	return "";
}

function basename(path) {
	var normalized = String(path || "").replace(/\\/g, "/");
	return normalized.substring(normalized.lastIndexOf("/") + 1) || normalized;
}

function pathKey(path) {
	return String(path || "").replace(/\\/g, "/").replace(/\/+$/, "").toLowerCase();
}

function folderIndexById(folderId) {
	for (var index = 0; index < sampleFolders.length; index++) {
		if (sampleFolders[index].id === folderId) return index;
	}
	return -1;
}

function folderIndexByPath(path) {
	var requested = pathKey(path);
	for (var index = 0; index < sampleFolders.length; index++) {
		if (pathKey(sampleFolders[index].path) === requested) return index;
	}
	return -1;
}

function nextFolderId(folders) {
	var used = {};
	for (var index = 0; index < folders.length; index++) used[folders[index].id] = 1;
	for (var candidate = 0; candidate < MAX_SAMPLE_FOLDERS; candidate++) {
		var id = "folder:" + candidate;
		if (!used[id]) return id;
	}
	return "";
}

function cloneFolder(folder, fallbackId) {
	var source = folder && typeof folder === "object" ? folder : {};
	var folderPath = String(source.path || source.root || "");
	return {
		id: String(source.id || fallbackId),
		name: String(source.name || basename(folderPath) || ("Folder " + (parseInt(fallbackId.split(":")[1], 10) + 1))),
		path: folderPath,
		source: String(source.source || "folder"),
		sampleIndices: []
	};
}

function publishFolders() {
	var folders = [];
	for (var index = 0; index < sampleFolders.length; index++) {
		folders.push({
			id: sampleFolders[index].id,
			name: sampleFolders[index].name,
			path: sampleFolders[index].path,
			source: sampleFolders[index].source,
			count: sampleFolders[index].sampleIndices.length
		});
	}
	publishHud("sample_folders", JSON.stringify({
		activeFolderId: activeFolderId,
		activeFolder: Math.max(0, folderIndexById(activeFolderId)),
		folders: folders
	}));
}

function supportedAudioPath(path) {
	return /\.(?:wav|wave|aif|aiff)$/i.test(String(path || ""));
}

var SMART_CATEGORY_ORDER = {
	"kick": 0, "snare-clap": 1, "hat-cymbal": 2, "percussion": 3,
	"bass": 4, "melodic": 5, "vocal": 6, "fx-texture": 7,
	"loop": 8, "other": 9
};

function smartCategory(path) {
	var name = basename(path).toLowerCase().replace(/[_\-.]+/g, " ");
	var context = String(path || "").toLowerCase().replace(/[_\-.\/]+/g, " ");
	if (/\b(kick|bd|bass drum)\b/.test(name)) return "kick";
	if (/\b(snare|sd|clap|rim|rimshot)\b/.test(name)) return "snare-clap";
	if (/\b(hat|hihat|hi hat|hh|cymbal|crash|ride|shaker)\b/.test(name)) return "hat-cymbal";
	if (/\b(perc|percussion|conga|bongo|tom|clave|cowbell|tamb|wood)\b/.test(name)) return "percussion";
	if (/\b(bass|sub|808)\b/.test(name)) return "bass";
	if (/\b(vocal|vox|voice|chant|phrase|spoken)\b/.test(name)) return "vocal";
	if (/\b(fx|effect|impact|riser|sweep|noise|texture|atmo|foley|glitch)\b/.test(name)) return "fx-texture";
	if (/\b(loop|break|groove|beat)\b/.test(name) || /\b\d{2,3}\s*bpm\b/.test(context)) return "loop";
	if (/\b(chord|stab|key|keys|piano|guitar|synth|lead|pad|pluck|organ|bell|mallet)\b/.test(name)) return "melodic";
	return "other";
}

function smartFamily(path, category) {
	var name = basename(path).replace(/\.[^.]+$/, "").toLowerCase();
	name = name.replace(/[_\-.()[\]{}]+/g, " ");
	name = name.replace(/([a-g])(?:#|b)?-?\d\b/g, " $1 ");
	name = name.replace(/\b(?:take|tk|ver|version|v|vel|velocity|rr|roundrobin)\s*\d+\b/g, " ");
	name = name.replace(/\b\d{1,4}\b/g, " ");
	name = name.replace(/\s+/g, " ").replace(/^\s+|\s+$/g, "");
	var tokens = name ? name.split(" ") : [];
	if (tokens.length > 5) tokens = tokens.slice(0, 5);
	return tokens.join(" ") || category;
}

function stringHash(value) {
	var text = String(value || "");
	var hash = 2166136261;
	for (var index = 0; index < text.length; index++) {
		hash ^= text.charCodeAt(index);
		hash += (hash << 1) + (hash << 4) + (hash << 7) + (hash << 8) + (hash << 24);
	}
	return hash >>> 0;
}

function hsvToRgb(hue, saturation, value) {
	var h = ((hue % 360) + 360) % 360;
	var s = Math.max(0, Math.min(1, saturation));
	var v = Math.max(0, Math.min(1, value));
	var chroma = v * s;
	var section = h / 60;
	var secondary = chroma * (1 - Math.abs(section % 2 - 1));
	var rgb = [0, 0, 0];
	if (section < 1) rgb = [chroma, secondary, 0];
	else if (section < 2) rgb = [secondary, chroma, 0];
	else if (section < 3) rgb = [0, chroma, secondary];
	else if (section < 4) rgb = [0, secondary, chroma];
	else if (section < 5) rgb = [secondary, 0, chroma];
	else rgb = [chroma, 0, secondary];
	var match = v - chroma;
	return [Math.round((rgb[0] + match) * 255), Math.round((rgb[1] + match) * 255),
		Math.round((rgb[2] + match) * 255)];
}

function smartSampleDetails(path) {
	var category = smartCategory(path);
	var family = smartFamily(path, category);
	var categoryIndex = SMART_CATEGORY_ORDER[category];
	var hash = stringHash(family);
	var categoryHue = [8, 345, 48, 82, 205, 268, 315, 180, 132, 32][categoryIndex];
	var hue = categoryHue + (hash % 45) - 22;
	var saturation = 0.62 + ((hash >>> 8) % 18) / 100;
	var brightness = 0.82 + ((hash >>> 16) % 14) / 100;
	return { category: category, family: family, color: hsvToRgb(hue, saturation, brightness) };
}

function smartCompareEntries(left, right) {
	var leftCategory = SMART_CATEGORY_ORDER[left.category];
	var rightCategory = SMART_CATEGORY_ORDER[right.category];
	if (leftCategory !== rightCategory) return leftCategory - rightCategory;
	if (left.family < right.family) return -1;
	if (left.family > right.family) return 1;
	var leftName = String(left.name || "").toLowerCase();
	var rightName = String(right.name || "").toLowerCase();
	return leftName < rightName ? -1 : (leftName > rightName ? 1 : 0);
}

function publishHud() {
	var args = arrayfromargs(arguments);
	messnamed.apply(this, ["mlr_hud_state"].concat(args));
}

function markSessionDirty(reason) {
	if (!sessionStateApplying) {
		messnamed("mlr_session_dirty", "dirty", String(reason || "sample bank"));
	}
}

function publishSample(index) {
	var sample = sampleRecords[index];
	if (!sample) return;
	publishHud("sample", index, sample.buffer, sample.name, sample.path,
		sample.mediaType, sample.channels || 0, sample.durationMs || 0,
		sample.sampleRate || 0, sample.category || "other", sample.family || "other",
		sample.color[0], sample.color[1], sample.color[2], sample.folderId || "folder:0");
}

function sampleReference(index) {
	var sample = sampleRecords[index];
	if (!sample) return null;
	if (sample.kind === "recording" && sample.recordingId) {
		return { folderId: "recording", path: String(sample.recordingId) };
	}
	var folderId = sample.folderId || (sampleFolders[0] ? sampleFolders[0].id : "folder:0");
	var folderIndex = folderIndexById(folderId);
	var root = folderIndex >= 0 ? String(sampleFolders[folderIndex].path || "") : "";
	var path = String(sample.path || "").replace(/\\/g, "/");
	var normalizedRoot = root.replace(/\\/g, "/").replace(/\/+$/, "");
	var relative = normalizedRoot && pathKey(path).indexOf(pathKey(normalizedRoot) + "/") === 0 ?
		path.substring(normalizedRoot.length + 1) : path;
	return { folderId: folderId, path: relative };
}

function publishAssignment(track, writeThrough) {
	var sampleIndex = runtimeAssignments[track];
	publishHud("assignment", track, sampleIndex,
		sampleIndex >= 0 ? FIRST_MENU_INDEX + sampleIndex : -1);
	messnamed("gridrouter", "sampleBrowserAssignment", track, sampleIndex);
	var reference = sampleReference(sampleIndex);
	messnamed("gridrouter", "sampleBrowserReference", track, sampleIndex,
		reference ? reference.folderId : "", reference ? reference.path : "",
		writeThrough ? 1 : 0);
}

function hudSnapshot() {
	publishHud("bank", pendingSamples.length ? "ready" : "empty", manifestPath,
		bank && typeof bank.root === "string" ? bank.root : "", pendingSamples.length,
		bankSource);
	publishFolders();
	for (var sample = 0; sample < sampleRecords.length; sample++) publishSample(sample);
	for (var track = 0; track < TRACK_COUNT; track++) publishAssignment(track);
}

function readText(path) {
	var file = new File(path, "read");
	if (!file.isopen) {
		post("[sample bank] could not open " + path + "\n");
		return null;
	}
	var text = "";
	while (file.position < file.eof) text += file.readline();
	file.close();
	return text;
}

function readJson(path) {
	var text = readText(path);
	if (text === null) return null;
	try {
		return JSON.parse(text);
	} catch (error) {
		post("[sample bank] could not parse " + path + ": " + error + "\n");
		return null;
	}
}

function parseLegacyList(text) {
	var source = String(text || "").replace(/\r/g, ";");
	var statements = source.split(";");
	var paths = [];
	var seen = {};
	for (var index = 0; index < statements.length; index++) {
		var statement = statements[index];
		var quoted = statement.match(/,\s*"([^"]+\.(?:wav|wave|aif|aiff))"/i);
		var plain = quoted ? null : statement.match(/,\s*([^\s,;]+\.(?:wav|wave|aif|aiff))(?=\s|$)/i);
		var path = quoted ? quoted[1] : (plain ? plain[1] : "");
		if (!path || seen[path]) continue;
		seen[path] = 1;
		paths.push(path);
	}
	return paths;
}

function mediaType(path) {
	var lower = path.toLowerCase();
	if (/\.aif$|\.aiff$/.test(lower)) return "AIFF";
	return "WAVE";
}

function resetFileList() {
	messnamed("[samplebank]coll", "clear");
	messnamed("[samplebank]reset", "bang");
}

function stopPlaybackForBufferMutation() {
	// groove~ can retain a buffer read pointer for the current signal vector.
	// Stop every player and discard armed native cuts before buffer~ receives a
	// replace, then let the scheduler cross several audio vectors before loadNext.
	messnamed("[mlr]stop", "bang");
	for (var channel = 1; channel <= 8; channel++) {
		messnamed(channel + "[pl]stop", "int", 1);
		messnamed("sequence64_audio_cancel", "int", channel);
	}
}

function loadNext() {
	if (loadIndex >= pendingSamples.length) {
		finishLoad();
		return;
	}
	var path = pendingSamples[loadIndex++];
	if (!path) {
		if (loadTask) loadTask.schedule(1);
		return;
	}
	messnamed("[samplebank]type", mediaType(path));
	messnamed("[samplebank]path", path);
	if (loadTask) loadTask.schedule(35);
}

function assignmentIndex(value, sampleCount, fallback) {
	var parsed = parseInt(value, 10);
	if (!isFinite(parsed)) parsed = fallback;
	if (parsed < 0 || parsed >= sampleCount) return -1;
	return parsed;
}

function finishLoad() {
	var count = pendingSamples.length;
	if (count > 0) messnamed("[samplebank]count", count);
	var assignments = bank && Array.isArray(bank.trackAssignments) ?
		bank.trackAssignments : [];
	for (var track = 0; track < TRACK_COUNT; track++) {
		var sampleIndex = count > 0 ?
			assignmentIndex(assignments[track], count, track % count) : -1;
		runtimeAssignments[track] = sampleIndex;
		if (sampleIndex >= 0) {
			messnamed((track + 2) + "[sample]select",
				FIRST_MENU_INDEX + sampleIndex);
		}
		publishAssignment(track);
	}
	publishHud("bank", count ? "ready" : "empty", manifestPath,
		bank && typeof bank.root === "string" ? bank.root : "", count, bankSource);
	publishFolders();
	publishHud("notice", count ? "info" : "warn", count ?
		("Loaded " + count + " bank sample" + (count === 1 ? "" : "s")) :
		"The sample bank is empty");
	post("[sample bank] loaded " + count + " sample" +
		(count === 1 ? "" : "s") + " from " + manifestPath + "\n");
}

function startBankLoad(path, loadedBank, sourceType) {
	messnamed("gridrouter", "sampleBrowserClose");
	messnamed("mlr_sample_preview", "stop");
	stopPlaybackForBufferMutation();
	manifestPath = path;
	manifestDirectory = directoryOf(path);
	bank = loadedBank;
	bankSource = sourceType || "json";
	sampleFolders = [];
	var folderSources = bank && Array.isArray(bank.folders) ? bank.folders : [];
	for (var folderIndex = 0; folderIndex < folderSources.length &&
		folderIndex < MAX_SAMPLE_FOLDERS; folderIndex++) {
		var loadedFolder = cloneFolder(folderSources[folderIndex], "folder:" + folderIndex);
		loadedFolder.path = joinPath(manifestDirectory, loadedFolder.path);
		sampleFolders.push(loadedFolder);
	}
	var root = joinPath(manifestDirectory,
		typeof bank.root === "string" ? bank.root : "");
	if (!sampleFolders.length) {
		sampleFolders.push(cloneFolder({
			id: "folder:0",
			name: basename(root || path) || "Samples",
			path: root || path,
			source: bankSource
		}, "folder:0"));
	}
	activeFolderId = String(bank.activeFolderId || sampleFolders[0].id);
	if (folderIndexById(activeFolderId) < 0) activeFolderId = sampleFolders[0].id;
	pendingSamples = [];
	sampleRecords = [];
	runtimeAssignments = makeFilledArray(TRACK_COUNT, -1);
	var recordingDescriptors = {};
	var loadedRecordings = bank && Array.isArray(bank.recordings) ? bank.recordings : [];
	if (!loadedRecordings.length) {
		for (var retainedRecordingId in recordingAssets) {
			loadedRecordings.push(recordingAssets[retainedRecordingId]);
		}
	}
	for (var recordingIndex = 0; recordingIndex < loadedRecordings.length; recordingIndex++) {
		var loadedRecording = loadedRecordings[recordingIndex] || {};
		if (loadedRecording.id) {
			recordingDescriptors[String(loadedRecording.id)] = loadedRecording;
			recordingAssets[String(loadedRecording.id)] = loadedRecording;
		}
	}
	for (var index = 0; index < bank.samples.length; index++) {
		var entry = bank.samples[index];
		var isRecording = entry && typeof entry === "object" &&
			String(entry.kind || "") === "recording" && entry.recordingId;
		var recordingDescriptor = isRecording ?
			recordingDescriptors[String(entry.recordingId)] : null;
		var relative = isRecording ? String(recordingDescriptor &&
			(recordingDescriptor.resolvedPath || recordingDescriptor.temporaryPath) || "") :
			normalizeSampleEntry(entry);
		if (relative) {
			var entryFolderId = entry && typeof entry === "object" && entry.folderId ?
				String(entry.folderId) : sampleFolders[0].id;
			var entryFolderIndex = folderIndexById(entryFolderId);
			if (entryFolderIndex < 0) {
				entryFolderIndex = 0;
				entryFolderId = sampleFolders[0].id;
			}
			var entryRoot = sampleFolders[entryFolderIndex].path || root;
			var absolute = joinPath(entryRoot, relative);
			var details = smartSampleDetails(absolute);
			if (entry && typeof entry === "object") {
				if (entry.category) details.category = String(entry.category);
				if (entry.family) details.family = String(entry.family);
				if (entry.color && entry.color.length >= 3) {
					details.color = [parseInt(entry.color[0], 10) || 0,
						parseInt(entry.color[1], 10) || 0, parseInt(entry.color[2], 10) || 0];
				}
			}
			pendingSamples.push(absolute);
			sampleRecords.push({
				buffer: FIRST_MENU_INDEX + sampleRecords.length,
				name: entry && typeof entry === "object" && entry.name ?
					String(entry.name) : basename(relative),
				path: absolute,
				mediaType: mediaType(absolute),
				channels: 0,
				durationMs: 0,
				sampleRate: 0,
				category: details.category,
				family: details.family,
				color: details.color,
				folderId: entryFolderId,
				kind: isRecording ? "recording" : "sample",
				recordingId: isRecording ? String(entry.recordingId) : "",
				recordingSource: isRecording && recordingDescriptor ?
					String(recordingDescriptor.source || "input") : ""
			});
			sampleFolders[entryFolderIndex].sampleIndices.push(sampleRecords.length - 1);
			if (isRecording && recordingDescriptor) {
				var runtimeBuffer = FIRST_BANK_BUFFER + sampleRecords.length - 1;
				messnamed("gridrouter", "recordingRegistered", String(entry.recordingId),
					runtimeBuffer, String(recordingDescriptor.source || "input"), relative);
			}
		}
	}
	loadIndex = 0;
	resetFileList();
	publishHud("bank", "loading", manifestPath,
		typeof bank.root === "string" ? bank.root : "", pendingSamples.length,
		bankSource);
	publishFolders();
	publishHud("notice", "info", "Loading " + pendingSamples.length + " bank samples");
	for (var sample = 0; sample < sampleRecords.length; sample++) publishSample(sample);
	if (loadTask) loadTask.cancel();
	loadTask = new Task(loadNext, this);
	loadTask.schedule(BUFFER_MUTATION_SETTLE_MS);
	markSessionDirty("sample bank");
	return true;
}

function loadManifest(path) {
	var loadedBank = readJson(path);
	if (!loadedBank || !Array.isArray(loadedBank.samples)) {
		publishHud("notice", "error", "Could not open sample bank " + basename(path));
		return false;
	}
	return startBankLoad(path, loadedBank, "json");
}

function loadLegacyList(path) {
	var text = readText(path);
	if (text === null) {
		publishHud("notice", "error", "Could not open legacy list " + basename(path));
		return false;
	}
	var paths = parseLegacyList(text);
	if (!paths.length) {
		publishHud("notice", "error", "No audio paths found in " + basename(path));
		return false;
	}
	var entries = [];
	for (var index = 0; index < paths.length; index++) {
		entries.push({ path: paths[index], name: basename(paths[index]) });
	}
	return startBankLoad(path, {
		version: 1,
		root: "",
		samples: entries,
		trackAssignments: []
	}, "legacy-list");
}

function closeScanFolder() {
	if (scanCurrent && typeof scanCurrent.close === "function") scanCurrent.close();
	scanCurrent = null;
}

function sampleEntryFromRecord(sample) {
	var entry = {
		name: sample.name,
		path: sample.kind === "recording" ? "" : sample.path,
		mediaType: sample.mediaType,
		channels: sample.channels || 0,
		durationMs: sample.durationMs || 0,
		sampleRate: sample.sampleRate || 0,
		category: sample.category || "other",
		family: sample.family || "other",
		color: sample.color ? sample.color.slice() : [0, 210, 255],
		folderId: sample.folderId || (sampleFolders[0] ? sampleFolders[0].id : "folder:0")
	};
	if (sample.kind === "recording" && sample.recordingId) {
		entry.kind = "recording";
		entry.recordingId = sample.recordingId;
	}
	return entry;
}

function folderSnapshots() {
	var folders = [];
	for (var index = 0; index < sampleFolders.length; index++) {
		folders.push({
			id: sampleFolders[index].id,
			name: sampleFolders[index].name,
			path: sampleFolders[index].path,
			source: sampleFolders[index].source
		});
	}
	return folders;
}

function finishSmartScan() {
	closeScanFolder();
	if (scanTask) scanTask.cancel();
	var entries = [];
	for (var index = 0; index < scanCandidates.length; index++) {
		var candidate = scanCandidates[index];
		var details = smartSampleDetails(candidate);
		entries.push({ path: candidate, name: basename(candidate),
			category: details.category, family: details.family, color: details.color });
	}
	entries.sort(smartCompareEntries);
	if (!entries.length) {
		// A failed/empty scan is non-destructive: keep the active bank and restore
		// its HUD snapshot instead of presenting stale sample rows under count 0.
		hudSnapshot();
		publishHud("notice", "warn", "No WAV or AIFF samples found in " + basename(scanRoot));
		return false;
	}
	var targetIndex = folderIndexById(scanTargetFolderId);
	var folders = folderSnapshots();
	if (targetIndex < 0) {
		folders.push({ id: scanTargetFolderId, name: basename(scanRoot) || "Samples",
			path: scanRoot, source: "smart-folder" });
		targetIndex = folders.length - 1;
	} else {
		folders[targetIndex].name = basename(scanRoot) || folders[targetIndex].name;
		folders[targetIndex].path = scanRoot;
		folders[targetIndex].source = "smart-folder";
	}

	// Global sample indices are append-only. Track Slots currently persist the
	// legacy numeric buffer/menu selection, so adding or rescanning a folder must
	// never renumber samples already referenced by a scene.
	var merged = [];
	var knownPaths = {};
	for (var existingIndex = 0; existingIndex < sampleRecords.length; existingIndex++) {
		var existingEntry = sampleEntryFromRecord(sampleRecords[existingIndex]);
		merged.push(existingEntry);
		knownPaths[pathKey(existingEntry.path)] = existingIndex;
	}
	for (var entryIndex = 0; entryIndex < entries.length; entryIndex++) {
		var scanned = entries[entryIndex];
		var key = pathKey(scanned.path);
		if (knownPaths[key] !== undefined) {
			var known = merged[knownPaths[key]];
			known.name = scanned.name;
			known.category = scanned.category;
			known.family = scanned.family;
			known.color = scanned.color;
			known.folderId = scanTargetFolderId;
			continue;
		}
		scanned.folderId = scanTargetFolderId;
		knownPaths[key] = merged.length;
		merged.push(scanned);
	}
	var assignments = sampleRecords.length ? runtimeAssignments.slice() : [];
	return startBankLoad("folder-library", {
		version: 2,
		root: "",
		organizer: "filename-family-v1",
		folders: folders,
		activeFolderId: scanTargetFolderId,
		samples: merged,
		trackAssignments: assignments,
		recordings: Object.keys(recordingAssets).map(function (id) { return recordingAssets[id]; })
	}, folders.length > 1 ? "folder-library" : "smart-folder");
}

function openNextScanFolder() {
	closeScanFolder();
	while (scanQueue.length) {
		var next = scanQueue.shift();
		var folder = new Folder(next.path);
		folder.reset();
		if (!folder.end || folder.count > 0) {
			scanCurrent = folder;
			scanCurrentDepth = next.depth;
			return true;
		}
		folder.close();
	}
	return false;
}

function scanFolderStep() {
	var budget = SMART_SCAN_STEP_BUDGET;
	while (budget-- > 0 && scanCandidates.length < scanLimit &&
		scanVisited < SMART_SCAN_VISIT_LIMIT) {
		if (!scanCurrent && !openNextScanFolder()) {
			finishSmartScan();
			return;
		}
		if (scanCurrent.end) {
			closeScanFolder();
			continue;
		}
		var name = String(scanCurrent.filename || "");
		var type = String(scanCurrent.filetype || "");
		var parent = String(scanCurrent.pathname || "");
		var fullPath = joinPath(parent, name);
		scanCurrent.next();
		scanVisited++;
		if (!name || name.charAt(0) === ".") continue;
		if (type === "fold") {
			if (scanCurrentDepth < SMART_SCAN_MAX_DEPTH) {
				scanQueue.push({ path: fullPath, depth: scanCurrentDepth + 1 });
			}
		} else if (supportedAudioPath(fullPath)) scanCandidates.push(fullPath);
	}
	if (scanCandidates.length >= scanLimit || scanVisited >= SMART_SCAN_VISIT_LIMIT) {
		finishSmartScan();
		return;
	}
	if (scanTask) scanTask.schedule(1);
}

function scanFolder() {
	var requested = arrayfromargs(arguments).join(" ");
	if (!requested) return false;
	var existingFolder = folderIndexByPath(requested);
	if (existingFolder >= 0) scanTargetFolderId = sampleFolders[existingFolder].id;
	else {
		if (sampleFolders.length >= MAX_SAMPLE_FOLDERS) {
			publishHud("notice", "warn", "The eight sample-folder slots are full");
			return false;
		}
		scanTargetFolderId = nextFolderId(sampleFolders);
	}
	scanRoot = requested;
	scanLimit = SMART_SCAN_LIMIT;
	scanQueue = [{ path: scanRoot, depth: 0 }];
	scanCandidates = [];
	scanVisited = 0;
	closeScanFolder();
	if (scanTask) scanTask.cancel();
	scanTask = new Task(scanFolderStep, this);
	publishHud("bank", "scanning", scanRoot, scanRoot, sampleRecords.length, "smart-folder");
	publishHud("notice", "info", "Smart sorting up to " + scanLimit + " samples…");
	scanTask.schedule(0);
	return true;
}

function preview(sampleIndex) {
	var sample = parseInt(sampleIndex, 10);
	if (!isFinite(sample) || sample < 0 || sample >= sampleRecords.length) return false;
	messnamed("mlr_sample_preview", "preview", sampleRecords[sample].path,
		sampleRecords[sample].buffer);
	publishHud("browser_selection", -1, sample);
	return true;
}

function previewStop() {
	messnamed("mlr_sample_preview", "stop");
}

function browserOpen(trackIndex, sampleIndex) {
	var track = parseInt(trackIndex, 10);
	var sample = parseInt(sampleIndex, 10);
	var keepActiveFolder = parseInt(arguments[2], 10) ? true : false;
	track = isFinite(track) ? Math.max(0, Math.min(15, track)) : 0;
	if (!isFinite(sample) || sample < 0 || sample >= sampleRecords.length) {
		sample = !keepActiveFolder && runtimeAssignments[track] >= 0 &&
			runtimeAssignments[track] < sampleRecords.length ?
			runtimeAssignments[track] : -1;
	}
	if (!keepActiveFolder && sample >= 0 && sampleRecords[sample] &&
		folderIndexById(sampleRecords[sample].folderId) >= 0) {
		activeFolderId = sampleRecords[sample].folderId;
	}
	var activeIndex = folderIndexById(activeFolderId);
	if (activeIndex < 0) activeIndex = 0;
	var visible = sampleFolders[activeIndex] ? sampleFolders[activeIndex].sampleIndices : [];
	messnamed("gridrouter", "sampleBrowserReset", Math.min(visible.length, SMART_SCAN_LIMIT),
		sampleFolders.length, activeIndex);
	for (var index = 0; index < visible.length && index < SMART_SCAN_LIMIT; index++) {
		var globalIndex = visible[index];
		var color = sampleRecords[globalIndex].color;
		messnamed("gridrouter", "sampleBrowserColor", index, color[0], color[1], color[2],
			globalIndex);
	}
	for (var assignmentTrack = 0; assignmentTrack < TRACK_COUNT; assignmentTrack++) {
		messnamed("gridrouter", "sampleBrowserAssignment", assignmentTrack,
			runtimeAssignments[assignmentTrack]);
	}
	messnamed("gridrouter", "sampleBrowserOpen", track, sample);
	publishFolders();
}

function activateFolder(folderIndex) {
	var folder = parseInt(folderIndex, 10);
	if (!isFinite(folder) || folder < 0 || folder >= sampleFolders.length) return false;
	activeFolderId = sampleFolders[folder].id;
	publishFolders();
	return true;
}

function selectFolder(folderIndex, trackIndex) {
	var folder = parseInt(folderIndex, 10);
	if (!activateFolder(folder)) return false;
	var track = parseInt(trackIndex, 10);
	if (!isFinite(track) || track < 0 || track >= TRACK_COUNT) track = 0;
	var assigned = runtimeAssignments[track];
	if (assigned < 0 || !sampleRecords[assigned] ||
		sampleRecords[assigned].folderId !== activeFolderId) assigned = -1;
	browserOpen(track, assigned, 1);
	return true;
}

function browserClose() {
	messnamed("gridrouter", "sampleBrowserClose");
}

function nextCaptureId() {
	captureSerial++;
	return "capture-" + new Date().getTime() + "-" + captureSerial;
}

function captureTemporaryPath(recordingId) {
	return "/tmp/mlr-" + String(recordingId || "capture").replace(/[^A-Za-z0-9_-]/g, "-") + ".wav";
}

function setCaptureSource(source) {
	var requested = String(source || "").toLowerCase();
	if (requested !== "input" && requested !== "mix") return false;
	captureSourceMode = requested;
	messnamed("mlr_capture_source", requested === "mix" ? 1 : 0);
	messnamed("gridrouter", "captureSourceState", captureSourceMode);
	publishHud("capture_source", captureSourceMode);
	return true;
}

function toggleCaptureSource() {
	return setCaptureSource(captureSourceMode === "input" ? "mix" : "input");
}

function capturePress(trackIndex) {
	var track = parseInt(trackIndex, 10);
	if (!isFinite(track) || track < 0 || track >= TRACK_COUNT) return false;
	if (pendingCapture) {
		publishHud("notice", "warn", "Finish the current capture first");
		messnamed("gridrouter", "trackCaptureState", track, "idle", 0, 0, "");
		return false;
	}
	var bufferIndex = FIRST_BANK_BUFFER + sampleRecords.length;
	if (bufferIndex > MAX_FILE_BUFFER) {
		publishHud("notice", "error", "The audio buffer catalog is full");
		messnamed("gridrouter", "trackCaptureState", track, "idle", 0, 0, "");
		return false;
	}
	var recordingId = nextCaptureId();
	pendingCapture = {
		id: recordingId,
		track: track,
		bufferIndex: bufferIndex,
		temporaryPath: captureTemporaryPath(recordingId),
		source: captureSourceMode,
		released: false
	};
	messnamed("gridrouter", "trackCaptureState", track, "armed", bufferIndex, 0,
		recordingId);
	messnamed("mlr_session_recording_state", 1);
	messnamed("mlr_track_capture", "press", track, bufferIndex);
	return true;
}

function captureRelease(trackIndex) {
	var track = parseInt(trackIndex, 10);
	if (!pendingCapture || track !== pendingCapture.track) return false;
	pendingCapture.released = true;
	messnamed("mlr_track_capture", "release", track);
	return true;
}

function captureEngineState(state, trackIndex, bufferIndex, durationMs) {
	var stateName = String(state || "");
	var track = parseInt(trackIndex, 10);
	var buffer = parseInt(bufferIndex, 10);
	var duration = parseFloat(durationMs) || 0;
	if (!pendingCapture || track !== pendingCapture.track ||
		buffer !== pendingCapture.bufferIndex) return false;
	if (stateName === "complete") {
		messnamed("gridrouter", "trackCaptureState", track, "finishing", buffer,
			duration, pendingCapture.id);
		messnamed("mlr_session_recording_export", "capture", pendingCapture.id,
			buffer + "file", pendingCapture.temporaryPath, track, buffer, duration,
			pendingCapture.source);
		return true;
	}
	messnamed("gridrouter", "trackCaptureState", track, stateName, buffer,
		duration, pendingCapture.id);
	return true;
}

function captureCommitted(recordingId, temporaryPath, trackIndex, bufferIndex,
	durationMs, source) {
	var id = String(recordingId || "");
	var track = parseInt(trackIndex, 10);
	var buffer = parseInt(bufferIndex, 10);
	var duration = parseFloat(durationMs) || 0;
	if (!pendingCapture || id !== pendingCapture.id || track !== pendingCapture.track ||
		buffer !== pendingCapture.bufferIndex) return false;
	var sampleIndex = sampleRecords.length;
	var name = "Capture " + String(sampleIndex + 1);
	var details = smartSampleDetails(name + " loop.wav");
	details.color = [255, 45, 145];
	var folderId = sampleFolders[0] ? sampleFolders[0].id : "folder:0";
	pendingSamples.push(String(temporaryPath || pendingCapture.temporaryPath));
	sampleRecords.push({
		buffer: FIRST_MENU_INDEX + sampleIndex,
		name: name,
		path: String(temporaryPath || pendingCapture.temporaryPath),
		mediaType: "WAVE",
		channels: 2,
		durationMs: duration,
		sampleRate: 0,
		category: "loop",
		family: "capture",
		color: details.color,
		folderId: folderId,
		kind: "recording",
		recordingId: id,
		recordingSource: String(source || pendingCapture.source || "input")
	});
	recordingAssets[id] = {
		id: id,
		source: String(source || pendingCapture.source || "input"),
		bufferIndex: buffer,
		bufferName: buffer + "file",
		temporaryPath: String(temporaryPath || pendingCapture.temporaryPath),
		catalogSample: 1
	};
	if (sampleFolders[0]) sampleFolders[0].sampleIndices.push(sampleIndex);
	// The buffer already contains the take. Extend the legacy menu/coll metadata
	// without reloading it or interrupting playback.
	messnamed("[file]list", "append", name);
	messnamed("[file]number", buffer);
	messnamed("[samplebank]coll", buffer, String(temporaryPath || pendingCapture.temporaryPath),
		duration, name);
	runtimeAssignments[track] = sampleIndex;
	messnamed((track + 2) + "[sample]select", FIRST_MENU_INDEX + sampleIndex);
	publishSample(sampleIndex);
	publishAssignment(track, true);
	messnamed("gridrouter", "recordingRegistered", id, buffer,
		String(source || pendingCapture.source || "input"),
		String(temporaryPath || pendingCapture.temporaryPath));
	messnamed("gridrouter", "trackCaptureState", track, "complete", buffer,
		duration, id);
	publishFolders();
	publishHud("notice", "info", name + " assigned to Track " + (track + 1));
	markSessionDirty("track audio capture");
	pendingCapture = null;
	messnamed("mlr_session_recording_state", 0);
	return true;
}

function captureFailed(recordingId) {
	if (!pendingCapture || String(recordingId || "") !== pendingCapture.id) return false;
	messnamed("gridrouter", "trackCaptureState", pendingCapture.track, "idle", 0, 0, "");
	publishHud("notice", "error", "Audio capture could not be committed");
	pendingCapture = null;
	messnamed("mlr_session_recording_state", 0);
	return true;
}

function assign(trackIndex, sampleIndex) {
	var track = parseInt(trackIndex, 10);
	var sample = parseInt(sampleIndex, 10);
	if (!isFinite(track) || track < 0 || track >= TRACK_COUNT ||
		!isFinite(sample) || sample < 0 || sample >= pendingSamples.length) {
		publishHud("notice", "error", "Invalid sample assignment");
		return false;
	}
	runtimeAssignments[track] = sample;
	messnamed((track + 2) + "[sample]select", FIRST_MENU_INDEX + sample);
	publishAssignment(track, true);
	publishHud("notice", "info", "Track " + (track + 1) + " assigned " +
		sampleRecords[sample].name);
	markSessionDirty("sample assignment");
	return true;
}

// Track state stores the one-based buffer/file number emitted by [umenu], while
// runtimeAssignments stores a zero-based sample-catalog index. Scene/Track Slot
// recall updates audio directly, so mirror that durable selection here without
// retriggering the menu or marking the session dirty.
function syncTrackBuffer(trackIndex, bufferIndex) {
	var track = parseInt(trackIndex, 10);
	var buffer = parseInt(bufferIndex, 10);
	if (!isFinite(track) || track < 0 || track >= TRACK_COUNT) return false;
	var sample = isFinite(buffer) && buffer >= FIRST_BANK_BUFFER ?
		buffer - FIRST_BANK_BUFFER : -1;
	if (sample < 0 || sample >= sampleRecords.length) sample = -1;
	runtimeAssignments[track] = sample;
	publishAssignment(track);
	return true;
}

function sessionSnapshot(requestId) {
	var samples = [];
	for (var index = 0; index < sampleRecords.length; index++) {
		samples.push(sampleEntryFromRecord(sampleRecords[index]));
	}
	var snapshot = {
		source: bankSource,
		path: manifestPath,
		root: bank && typeof bank.root === "string" ? bank.root : "",
		folders: folderSnapshots(),
		samples: samples,
		assignments: runtimeAssignments.slice()
	};
	var dictName = "mlr_session_bank_fragment";
	var dict = new Dict(dictName);
	dict.parse(JSON.stringify(snapshot));
	messnamed("mlr_session_fragment", "bank_dict", String(requestId || ""), dictName);
}

function sessionApplyDict(dictName) {
	try {
		var dict = new Dict(String(dictName || ""));
		var document = JSON.parse(dict.stringify());
		if (document.bank) {
			var bankDocument = document.bank;
			bankDocument.recordings = Array.isArray(document.recordings) ?
				document.recordings : [];
			return sessionApply(JSON.stringify(bankDocument));
		}
		return sessionApply(JSON.stringify(document));
	} catch (error) {
		publishHud("notice", "error", "Could not read saved sample-bank dictionary");
		return false;
	}
}

function sessionApply(payload) {
	var source;
	try { source = JSON.parse(String(payload || "{}")); }
	catch (error) {
		publishHud("notice", "error", "Could not parse saved sample bank");
		return false;
	}
	var samples = Array.isArray(source.samples) ? source.samples : [];
	var assignments = Array.isArray(source.assignments) ? source.assignments : [];
	sessionStateApplying = true;
	var result = startBankLoad(source.path || "session", {
		version: source.folders ? 2 : 1,
		root: "",
		folders: Array.isArray(source.folders) ? source.folders : [],
		samples: samples,
		trackAssignments: assignments,
		// SessionApplyDict attaches the bundle's resolved recording descriptors
		// to the bank fragment. Keep them through this normalization step so
		// catalog recording entries resolve to their installed sidecar files.
		recordings: Array.isArray(source.recordings) ? source.recordings : []
	}, source.source || "session");
	// finishLoad executes asynchronously; retain the guard until its first load
	// step has been scheduled, then normal user changes become dirty again.
	var releaseTask = new Task(function () { sessionStateApplying = false; }, this);
	releaseTask.schedule(Math.max(100, samples.length * 40 + 100));
	return result;
}

function sessionNew() {
	sessionStateApplying = true;
	for (var track = 0; track < TRACK_COUNT; track++) {
		runtimeAssignments[track] = -1;
		messnamed((track + 2) + "[sample]select", 0);
		publishAssignment(track);
	}
	sessionStateApplying = false;
	publishHud("notice", "info", "New session · sample library retained");
}

function bufferMetadata(path, fileIndex, channels, durationMs, sampleRate) {
	var bufferIndex = parseInt(fileIndex, 10);
	var sampleIndex = bufferIndex - FIRST_BANK_BUFFER;
	if (sampleIndex < 0 || sampleIndex >= sampleRecords.length) {
		var normalized = String(path || "");
		for (var index = 0; index < sampleRecords.length; index++) {
			if (sampleRecords[index].path === normalized) {
				sampleIndex = index;
				break;
			}
		}
	}
	if (sampleIndex < 0 || sampleIndex >= sampleRecords.length) return;
	var sample = sampleRecords[sampleIndex];
	sample.channels = parseInt(channels, 10) || 0;
	sample.durationMs = parseFloat(durationMs) || 0;
	sample.sampleRate = parseFloat(sampleRate) || 0;
	publishSample(sampleIndex);
}

function read(path) {
	var requested = arrayfromargs(arguments).join(" ");
	if (!requested) requested = joinPath(projectDirectory.call(this), "sample-bank.json");
	else if (requested.charAt(0) !== "/" && !/^[A-Za-z]+:/.test(requested)) {
		requested = joinPath(projectDirectory.call(this), requested);
	}
	if (/\.json$/i.test(requested)) loadManifest(requested);
	else loadLegacyList(requested);
}

function reload() {
	var activeIndex = folderIndexById(activeFolderId);
	if ((bankSource === "smart-folder" || bankSource === "folder-library") &&
		activeIndex >= 0 && sampleFolders[activeIndex].path) {
		scanFolder(sampleFolders[activeIndex].path);
	}
	else read(manifestPath || joinPath(projectDirectory.call(this), "sample-bank.json"));
}

function status() {
	post("[sample bank] manifest=" + (manifestPath || "(default)") +
		" folders=" + sampleFolders.length + " samples=" + pendingSamples.length + "\n");
}

function loadbang() {
	setCaptureSource(captureSourceMode);
	var task = new Task(reload, this);
	task.schedule(150);
}
