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
var pendingSamples = [];
var loadIndex = 0;
var loadTask = null;
var FIRST_MENU_INDEX = 8;
var TRACK_COUNT = 16;

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
	if (name.charAt(0) === "/" || /^[A-Za-z]+:/.test(name)) return name;
	return base + (base.charAt(base.length - 1) === "/" ? "" : "/") + name;
}

function normalizeSampleEntry(entry) {
	if (typeof entry === "string") return entry;
	if (entry && typeof entry.path === "string") return entry.path;
	return "";
}

function readJson(path) {
	var file = new File(path, "read");
	if (!file.isopen) {
		post("[sample bank] no manifest at " + path + "\n");
		return null;
	}
	var text = "";
	while (file.position < file.eof) text += file.readline();
	file.close();
	try {
		return JSON.parse(text);
	} catch (error) {
		post("[sample bank] could not parse " + path + ": " + error + "\n");
		return null;
	}
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
	for (var track = 0; track < TRACK_COUNT && count > 0; track++) {
		var sampleIndex = assignmentIndex(assignments[track], count, track % count);
		if (sampleIndex >= 0) {
			messnamed((track + 2) + "[sample]select",
				FIRST_MENU_INDEX + sampleIndex);
		}
	}
	post("[sample bank] loaded " + count + " sample" +
		(count === 1 ? "" : "s") + " from " + manifestPath + "\n");
}

function loadManifest(path) {
	manifestPath = path;
	manifestDirectory = directoryOf(path);
	bank = readJson(path);
	if (!bank || !Array.isArray(bank.samples)) return false;
	var root = joinPath(manifestDirectory,
		typeof bank.root === "string" ? bank.root : "");
	pendingSamples = [];
	for (var index = 0; index < bank.samples.length; index++) {
		var relative = normalizeSampleEntry(bank.samples[index]);
		if (relative) pendingSamples.push(joinPath(root, relative));
	}
	loadIndex = 0;
	resetFileList();
	if (loadTask) loadTask.cancel();
	loadTask = new Task(loadNext, this);
	loadTask.schedule(25);
	return true;
}

function read(path) {
	var requested = arrayfromargs(arguments).join(" ");
	if (!requested) requested = joinPath(projectDirectory.call(this), "sample-bank.json");
	else if (requested.charAt(0) !== "/" && !/^[A-Za-z]+:/.test(requested)) {
		requested = joinPath(projectDirectory.call(this), requested);
	}
	loadManifest(requested);
}

function reload() {
	read(manifestPath || joinPath(projectDirectory.call(this), "sample-bank.json"));
}

function status() {
	post("[sample bank] manifest=" + (manifestPath || "(default)") +
		" samples=" + pendingSamples.length + "\n");
}

function loadbang() {
	var task = new Task(reload, this);
	task.schedule(150);
}

