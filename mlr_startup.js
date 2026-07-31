/*
 * Workstation-local startup settings for MLR.
 *
 * Copy mlr.local.example.json to mlr.local.json beside _mlr.maxpat and change
 * only the hardware available on this workstation.  The local file is ignored
 * by Git, so a MechaTrellis preference cannot surprise an ordinary monome.
 */

autowatch = 1;
inlets = 1;
outlets = 1;

var DEFAULTS = {
	mechatrellis: false,
	editorColors: false
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

function readJson(path) {
	var file = new File(path, "read");
	if (!file.isopen) return null;
	var text = "";
	while (file.position < file.eof) text += file.readline();
	file.close();
	try {
		return JSON.parse(text);
	} catch (error) {
		post("[mlr startup] could not parse " + path + ": " + error + "\n");
		return null;
	}
}

function emitSettings(settings) {
	var mechatrellis = settings.mechatrellis ? 1 : 0;
	var editorColors = settings.editorColors === undefined ?
		mechatrellis : (settings.editorColors ? 1 : 0);
	outlet(0, "mechatrellis", mechatrellis);
	outlet(0, "editorColors", editorColors);
	post("[mlr startup] MechaTrellis=" + mechatrellis +
		" editorColors=" + editorColors + "\n");
}

function reload() {
	var path = joinPath(projectDirectory.call(this), "mlr.local.json");
	var local = readJson(path);
	var settings = {
		mechatrellis: local && local.mechatrellis !== undefined ?
			!!local.mechatrellis : DEFAULTS.mechatrellis,
		editorColors: local && local.editorColors !== undefined ?
			!!local.editorColors : DEFAULTS.editorColors
	};
	emitSettings(settings);
}

function loadbang() {
	var task = new Task(reload, this);
	task.schedule(50);
}

function bang() {
	reload();
}

