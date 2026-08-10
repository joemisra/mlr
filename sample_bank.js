/*
 * Portable sample-bank loader.
 *
 * The default manifest is sample-bank.json beside the MLR patch. Paths in the
 * manifest are resolved relative to its "root" directory. Imported files use
 * MLR's existing file-list/buffer path, so presets and the front-page menus
 * continue to work normally.
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
var runtimeAssignments = makeFilledArray(16, -1);
var loadIndex = 0;
var loadTask = null;
var FIRST_MENU_INDEX = 8;
var TRACK_COUNT = 16;
var SMART_SCAN_LIMIT = 240;
var SMART_SCAN_VISIT_LIMIT = 12000;
var SMART_SCAN_MAX_DEPTH = 8;
var SMART_SCAN_STEP_BUDGET = 96;
var scanRoot = "";
var scanLimit = SMART_SCAN_LIMIT;
var scanQueue = [];
var scanCurrent = null;
var scanCurrentDepth = 0;
var scanCandidates = [];
var scanVisited = 0;
var scanTask = null;
var sessionStateApplying = false;

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
		sample.color[0], sample.color[1], sample.color[2]);
}

function publishAssignment(track) {
	var sampleIndex = runtimeAssignments[track];
	publishHud("assignment", track, sampleIndex,
		sampleIndex >= 0 ? FIRST_MENU_INDEX + sampleIndex : -1);
	messnamed("gridrouter", "sampleBrowserAssignment", track, sampleIndex);
}

function hudSnapshot() {
	publishHud("bank", pendingSamples.length ? "ready" : "empty", manifestPath,
		bank && typeof bank.root === "string" ? bank.root : "", pendingSamples.length,
		bankSource);
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

function loadNext() {
	if (loadIndex >= pendingSamples.length) {
		finishLoad();
		return;
	}
	var path = pendingSamples[loadIndex++];
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
	publishHud("notice", count ? "info" : "warn", count ?
		("Loaded " + count + " bank sample" + (count === 1 ? "" : "s")) :
		"The sample bank is empty");
	post("[sample bank] loaded " + count + " sample" +
		(count === 1 ? "" : "s") + " from " + manifestPath + "\n");
}

function startBankLoad(path, loadedBank, sourceType) {
	messnamed("gridrouter", "sampleBrowserClose");
	messnamed("mlr_sample_preview", "stop");
	manifestPath = path;
	manifestDirectory = directoryOf(path);
	bank = loadedBank;
	bankSource = sourceType || "json";
	var root = joinPath(manifestDirectory,
		typeof bank.root === "string" ? bank.root : "");
	pendingSamples = [];
	sampleRecords = [];
	runtimeAssignments = makeFilledArray(TRACK_COUNT, -1);
	for (var index = 0; index < bank.samples.length; index++) {
		var relative = normalizeSampleEntry(bank.samples[index]);
		if (relative) {
			var absolute = joinPath(root, relative);
			var entry = bank.samples[index];
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
				color: details.color
			});
		}
	}
	loadIndex = 0;
	resetFileList();
	publishHud("bank", "loading", manifestPath,
		typeof bank.root === "string" ? bank.root : "", pendingSamples.length,
		bankSource);
	publishHud("notice", "info", "Loading " + pendingSamples.length + " bank samples");
	for (var sample = 0; sample < sampleRecords.length; sample++) publishSample(sample);
	if (loadTask) loadTask.cancel();
	loadTask = new Task(loadNext, this);
	loadTask.schedule(25);
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
	return startBankLoad(scanRoot, {
		version: 1,
		root: "",
		organizer: "filename-family-v1",
		samples: entries,
		trackAssignments: []
	}, "smart-folder");
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
	track = isFinite(track) ? Math.max(0, Math.min(15, track)) : 0;
	if (!isFinite(sample) || sample < 0 || sample >= sampleRecords.length) {
		sample = runtimeAssignments[track] >= 0 && runtimeAssignments[track] < sampleRecords.length ?
			runtimeAssignments[track] : -1;
	}
	messnamed("gridrouter", "sampleBrowserReset", Math.min(sampleRecords.length, SMART_SCAN_LIMIT));
	for (var index = 0; index < sampleRecords.length && index < SMART_SCAN_LIMIT; index++) {
		var color = sampleRecords[index].color;
		messnamed("gridrouter", "sampleBrowserColor", index, color[0], color[1], color[2]);
	}
	for (var assignmentTrack = 0; assignmentTrack < TRACK_COUNT; assignmentTrack++) {
		messnamed("gridrouter", "sampleBrowserAssignment", assignmentTrack,
			runtimeAssignments[assignmentTrack]);
	}
	messnamed("gridrouter", "sampleBrowserOpen", track, sample);
}

function browserClose() {
	messnamed("gridrouter", "sampleBrowserClose");
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
	publishAssignment(track);
	publishHud("notice", "info", "Track " + (track + 1) + " assigned " +
		sampleRecords[sample].name);
	markSessionDirty("sample assignment");
	return true;
}

function sessionSnapshot(requestId) {
	var samples = [];
	for (var index = 0; index < sampleRecords.length; index++) {
		var sample = sampleRecords[index];
		samples.push({
			name: sample.name,
			path: sample.path,
			mediaType: sample.mediaType,
			channels: sample.channels || 0,
			durationMs: sample.durationMs || 0,
			sampleRate: sample.sampleRate || 0,
			category: sample.category || "other",
			family: sample.family || "other",
			color: sample.color ? sample.color.slice() : [0, 210, 255]
		});
	}
	var snapshot = {
		source: bankSource,
		path: manifestPath,
		root: bank && typeof bank.root === "string" ? bank.root : "",
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
		return sessionApply(JSON.stringify(document.bank || document));
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
		version: 1,
		root: "",
		samples: samples,
		trackAssignments: assignments
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
	var sampleIndex = bufferIndex - FIRST_MENU_INDEX;
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
	if (bankSource === "smart-folder" && manifestPath) scanFolder(manifestPath);
	else read(manifestPath || joinPath(projectDirectory.call(this), "sample-bank.json"));
}

function status() {
	post("[sample bank] manifest=" + (manifestPath || "(default)") +
		" samples=" + pendingSamples.length + "\n");
}

function loadbang() {
	var task = new Task(reload, this);
	task.schedule(150);
}
