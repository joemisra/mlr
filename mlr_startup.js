/*
 * Workstation-local startup settings for MLR.
 *
 * Copy mlr.local.example.json to mlr.local.json beside _mlr.maxpat and change
 * only the hardware available on this workstation.  The local file is ignored
 * by Git, so color-grid or CV-output preferences cannot surprise other rigs.
 */

autowatch = 1;
inlets = 1;
outlets = 1;

var DEFAULTS = {
	mechatrellis: false,
	mechatrellisProtocol: 1,
	editorColors: false,
	cvPulseEnabled: false,
	cvPulseLevel: 0.5
};

function projectDirectory() {
	var path = this.patcher && this.patcher.filepath ? this.patcher.filepath : "";
	var slash = Math.max(path.lastIndexOf("/"), path.lastIndexOf("\\"));
	return slash >= 0 ? path.substring(0, slash) : "";
}

function joinPath(base, name) {
	if (!base) return name;
	return base + (base.charAt(base.length - 1) === "/" ? "" : "/") + name;
}

function readJson(path, strict) {
	var file = new File(path, "read");
	if (!file.isopen) return null;
	var text = "";
	while (file.position < file.eof) text += file.readline();
	file.close();
	try {
		return JSON.parse(text);
	} catch (error) {
		post("[mlr startup] could not parse " + path + ": " + error + "\n");
		if (strict) throw error;
		return null;
	}
}

// The HUD switch is a workstation preference, never session state. Retain CV,
// protocol and any other local settings when persisting this one choice.
function hardware_colors(enabled) {
	var active = parseInt(enabled, 10) ? 1 : 0;
	var path = joinPath(projectDirectory.call(this), "mlr.local.json");
	var local = null;
	var saved = false;
	try {
		local = readJson(path, true) || {};
		if (typeof local !== "object" || local instanceof Array) throw new Error("Invalid local settings");
		local.mechatrellis = !!active;
		local.editorColors = !!active;
		var file = new File(path, "write", "TEXT");
		if (!file.isopen) throw new Error("Could not write local settings");
		try {
			file.writeline(JSON.stringify(local, null, 2));
			file.eof = file.position;
		} finally { file.close(); }
		saved = true;
	} catch (error) {
		post("[mlr startup] color preference not saved: " + error + "\n");
	}
	var requested = parseInt(local && local.mechatrellisProtocol, 10);
	var protocol = active ? Math.min(2, Math.max(1, isFinite(requested) ? requested : DEFAULTS.mechatrellisProtocol)) : 0;
	outlet(0, "mechatrellis", protocol);
	outlet(0, "editorColors", active);
	messnamed("mlr_hud_state", "notice", saved ? "info" : "warn",
		"Grid color " + (active ? "on" : "off") + (saved ? " · saved locally" : " · preference could not be saved"));
}

function emitSettings(settings) {
	var requestedProtocol = parseInt(settings.mechatrellisProtocol, 10);
	var mechatrellis = settings.mechatrellis ?
		Math.min(2, Math.max(1, isFinite(requestedProtocol) ? requestedProtocol : 1)) : 0;
	var editorColors = settings.editorColors === undefined ?
		(mechatrellis ? 1 : 0) : (settings.editorColors ? 1 : 0);
	var requestedCvLevel = parseFloat(settings.cvPulseLevel);
	var cvPulseLevel = isFinite(requestedCvLevel) ?
		Math.min(1, Math.max(0, requestedCvLevel)) : DEFAULTS.cvPulseLevel;
	var cvPulseEnabled = settings.cvPulseEnabled ? 1 : 0;
	outlet(0, "mechatrellis", mechatrellis);
	outlet(0, "editorColors", editorColors);
	messnamed("mlr_cv_pulse_config", "config", cvPulseEnabled, cvPulseLevel);
	post("[mlr startup] MechaTrellis=" + mechatrellis +
		" editorColors=" + editorColors +
		" cvPulse=" + cvPulseEnabled +
		" cvLevel=" + cvPulseLevel + "\n");
}

function reload() {
	var path = joinPath(projectDirectory.call(this), "mlr.local.json");
	var local = readJson(path);
	var settings = {
		mechatrellis: local && local.mechatrellis !== undefined ?
			!!local.mechatrellis : DEFAULTS.mechatrellis,
		mechatrellisProtocol: local && local.mechatrellisProtocol !== undefined ?
			local.mechatrellisProtocol : DEFAULTS.mechatrellisProtocol,
		editorColors: local && local.editorColors !== undefined ?
			!!local.editorColors : DEFAULTS.editorColors,
		cvPulseEnabled: local && local.cvPulseEnabled !== undefined ?
			!!local.cvPulseEnabled : DEFAULTS.cvPulseEnabled,
		cvPulseLevel: local && local.cvPulseLevel !== undefined ?
			local.cvPulseLevel : DEFAULTS.cvPulseLevel
	};
	emitSettings(settings);
}

// Keep the Task alive for the lifetime of the js object. A function-local Task
// can be collected before its callback runs, which silently leaves the bridge
// in ordinary-monome-safe mode even when mlr.local.json enables MechaTrellis.
var startupApplyTask = new Task(reload, this);

function loadbang() {
	startupApplyTask.cancel();
	// Allow the grid router and matrix bridge receivers to finish loading first.
	startupApplyTask.schedule(250);
}

function bang() {
	reload();
}
