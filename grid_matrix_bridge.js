autowatch = 1;
inlets = 1;
outlets = 2;

/**
 * Varibright LED state bridge: jit.matrix (char 0–15) -> /grid/led/level/map
 * Map layout matches mlr4k3r0update7/gridfantastic: 8x8 blocks at (0,0), (8,0),
 * and for 256 also (0,8), (8,8).
 * Requires Max JS v8 + Jitter (copymatrixtoarray / copyarraytomatrix).
 *
 * Two-plane compositing: the jit.matrix holds the foreground (interactive LEDs,
 * overlays, animations). A separate background array sets the minimum brightness
 * per cell (e.g. playback position indicators). Each cell renders as
 * max(foreground, background). Background persists across foreground clears.
 *
 * dual128 1: two stacked 128 grids as one 256 — outlet 0 = top rows (0–7),
 * outlet 1 = bottom rows (logical 8–15 mapped to physical 0–7). Use edition 256.
 */

var matrixName = "grid_matrix_io_state";
var prefix = "/box";
var edition = 256;
var dual128Mode = 0;
var bg = new Uint8Array(16 * 16);
var frameBatchDepth = 0;

if (jsarguments.length > 1) {
	matrixName = jsarguments[1];
}

function bind_matrix() {
	var jm = new JitterMatrix(1, "char", 16, 16);
	jm.name = matrixName;
	return jm;
}

function loadbang() {
	post("[grid_matrix_bridge] matrix=" + matrixName + "\n");
	set_edition(256);
}

function dims_for_edition(e) {
	if (e === 64) return [8, 8];
	if (e === 128) return [16, 8];
	return [16, 16];
}

function set_edition(n) {
	if (n !== 64 && n !== 128 && n !== 256) {
		post("[grid_matrix_bridge] bad edition " + n + " (use 64, 128, or 256)\n");
		return;
	}
	edition = n | 0;
	var wh = dims_for_edition(edition);
	var jm = bind_matrix();
	jm.planecount = 1;
	jm.type = "char";
	jm.dim = wh;
	jm.clear();
	bg = new Uint8Array(wh[0] * wh[1]);
	post("[grid_matrix_bridge] edition=" + edition + " dim=" + wh + "\n");
}

function bang() {
	flush();
}

function flush() {
	if (frameBatchDepth > 0) return;
	send_level_maps();
}

function clear() {
	post("[grid_matrix_bridge] clear() called\n");
	bind_matrix().clear();
	flush();
}

/**
 * Atomically replace a page. Periodic flushes are suppressed between these
 * messages, so the physical grid never receives the intermediate blank frame.
 */
function beginframe() {
	frameBatchDepth++;
	if (frameBatchDepth === 1) {
		bind_matrix().clear();
		for (var i = 0; i < bg.length; i++) bg[i] = 0;
	}
}

/**
 * Atomically apply a partial update without clearing either matrix plane.
 * This is the transaction used by renderer diffs and moving indicators.
 */
function beginupdate() {
	frameBatchDepth++;
}

function endframe() {
	if (frameBatchDepth === 0) return;
	frameBatchDepth--;
	if (frameBatchDepth === 0) send_level_maps();
}

function setcell(x, y, v) {
	x = x | 0;
	y = y | 0;
	v = clamp(Math.floor(v), 0, 15);
	var jm = bind_matrix();
	var wh = jm.dim;
	if (x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_matrix_bridge] setcell out of range\n");
		return;
	}
	jm.setcell2d(x, y, v);
}

function setcell_bg(x, y, v) {
	x = x | 0;
	y = y | 0;
	v = clamp(Math.floor(v), 0, 15);
	var wh = dims_for_edition(edition);
	if (x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) return;
	bg[y * wh[0] + x] = v;
}

function clear_bg() {
	post("[grid_matrix_bridge] clear_bg() called\n");
	for (var i = 0; i < bg.length; i++) bg[i] = 0;
}

function fill_bg(v) {
	v = clamp(Math.floor(v), 0, 15);
	for (var i = 0; i < bg.length; i++) bg[i] = v;
}

function fade_step() {
	var jm = bind_matrix();
	var wh = jm.dim;
	var u8 = new Uint8Array(wh[0] * wh[1]);
	jm.copymatrixtoarray(u8);
	for (var i = 0; i < u8.length; i++) {
		u8[i] = Math.max(0, u8[i] - 1);
	}
	jm.copyarraytomatrix(u8);
}

function fill(v) {
	v = clamp(Math.floor(v), 0, 15);
	bind_matrix().fillplane(0, v);
}

function send_level_maps() {
	var jm = bind_matrix();
	var wh = jm.dim;
	var w = wh[0];
	var n = w * wh[1];
	var fg = new Uint8Array(n);
	jm.copymatrixtoarray(fg);
	var composite = new Uint8Array(n);
	for (var j = 0; j < n; j++) {
		composite[j] = fg[j] > bg[j] ? fg[j] : bg[j];
	}
	var path = prefix + "/grid/led/level/map";
	var regions = regions_for_edition(edition);
	for (var i = 0; i < regions.length; i++) {
		var ox = regions[i][0];
		var oy = regions[i][1];
		out_block(path, ox, oy, block8_from_u8(composite, w, ox, oy));
	}
}

function regions_for_edition(e) {
	if (e === 64) return [[0, 0]];
	if (e === 128) return [[0, 0], [8, 0]];
	return [[0, 0], [8, 0], [0, 8], [8, 8]];
}

function block8_from_u8(u8, w, ox, oy) {
	var out = [];
	for (var row = 0; row < 8; row++) {
		for (var col = 0; col < 8; col++) {
			out.push(u8[(oy + row) * w + (ox + col)]);
		}
	}
	return out;
}

function out_block(path, ox, oy, bytes) {
	if (!dual128Mode || oy < 8) {
		outlet.apply(this, [0, path, ox, oy].concat(bytes));
	} else {
		outlet.apply(this, [1, path, ox, oy - 8].concat(bytes));
	}
}

function clamp(n, lo, hi) {
	return Math.min(hi, Math.max(lo, n));
}

// MechaTrellis private OSC extension. These messages bypass the level matrix:
// persistent color commands change only the color layer, while RGB/level8
// commands can be used by callers that intentionally want 8-bit LED control.
function extension_cell(path, x, y, values) {
	x = parseInt(x, 10);
	y = parseInt(y, 10);
	var wh = dims_for_edition(edition);
	if (!isFinite(x) || !isFinite(y) || x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_matrix_bridge] extension cell out of range\n");
		return;
	}
	var args = [prefix + path, x, y].concat(values);
	if (!dual128Mode || y < 8) {
		outlet.apply(this, [0].concat(args));
	} else {
		args[2] = y - 8;
		outlet.apply(this, [1].concat(args));
	}
}

function extension_all(path, values) {
	var args = [prefix + path].concat(values);
	outlet.apply(this, [0].concat(args));
	if (dual128Mode) outlet.apply(this, [1].concat(args));
}

function extension_map(path, x, y, values) {
	x = parseInt(x, 10);
	y = parseInt(y, 10);
	var wh = dims_for_edition(edition);
	if (!isFinite(x) || !isFinite(y) || x < 0 || y < 0 ||
		x + 4 > wh[0] || y + 4 > wh[1] || !values || values.length !== 48) {
		post("[grid_matrix_bridge] extension 4x4 map out of range\n");
		return;
	}
	if (dual128Mode && y < 8 && y + 4 > 8) {
		post("[grid_matrix_bridge] extension 4x4 map crosses dual-grid boundary\n");
		return;
	}
	var args = [prefix + path, x, y].concat(values);
	if (!dual128Mode || y < 8) {
		outlet.apply(this, [0].concat(args));
	} else {
		args[2] = y - 8;
		outlet.apply(this, [1].concat(args));
	}
}

function colorcell(x, y, r, g, b) {
	extension_cell("/grid/led/color/set", x, y, [
		clamp(parseInt(r, 10) || 0, 0, 255),
		clamp(parseInt(g, 10) || 0, 0, 255),
		clamp(parseInt(b, 10) || 0, 0, 255)
	]);
}

function colormap() {
	var args = arrayfromargs(arguments);
	if (args.length !== 50) {
		post("[grid_matrix_bridge] colormap requires x y plus 16 RGB triples\n");
		return;
	}
	var colors = [];
	for (var i = 2; i < args.length; i++) {
		colors.push(clamp(parseInt(args[i], 10) || 0, 0, 255));
	}
	extension_map("/grid/led/color/map", args[0], args[1], colors);
}

function colorall(r, g, b) {
	extension_all("/grid/led/color/all", [
		clamp(parseInt(r, 10) || 0, 0, 255),
		clamp(parseInt(g, 10) || 0, 0, 255),
		clamp(parseInt(b, 10) || 0, 0, 255)
	]);
}

function colorpresetstore(slot) {
	extension_all("/grid/led/color/preset/store", [clamp(parseInt(slot, 10) || 0, 0, 7)]);
}

function colorpresetrecall(slot) {
	extension_all("/grid/led/color/preset/recall", [clamp(parseInt(slot, 10) || 0, 0, 7)]);
}

function rgbcell(x, y, r, g, b) {
	extension_cell("/grid/led/rgb/set", x, y, [
		clamp(parseInt(r, 10) || 0, 0, 255),
		clamp(parseInt(g, 10) || 0, 0, 255),
		clamp(parseInt(b, 10) || 0, 0, 255)
	]);
}

function rgball(r, g, b) {
	extension_all("/grid/led/rgb/all", [
		clamp(parseInt(r, 10) || 0, 0, 255),
		clamp(parseInt(g, 10) || 0, 0, 255),
		clamp(parseInt(b, 10) || 0, 0, 255)
	]);
}

function level8cell(x, y, level) {
	extension_cell("/grid/led/level8/set", x, y, [clamp(parseInt(level, 10) || 0, 0, 255)]);
}

function level8all(level) {
	extension_all("/grid/led/level8/all", [clamp(parseInt(level, 10) || 0, 0, 255)]);
}

function intensity8(level) {
	extension_all("/grid/led/intensity8", [clamp(parseInt(level, 10) || 0, 0, 255)]);
}

/** Send "dump" to this object to print fg/bg/composite state to Max console. */
function dump() {
	var jm = bind_matrix();
	var wh = jm.dim;
	var w = wh[0]; var h = wh[1];
	var fg = new Uint8Array(w * h);
	jm.copymatrixtoarray(fg);
	post("[grid_matrix_bridge] === DUMP fg/bg/composite === edition=" + edition + " dim=" + w + "x" + h + "\n");
	for (var y = 0; y < h; y++) {
		var fgRow = [], bgRow = [], cRow = [];
		for (var x = 0; x < w; x++) {
			var idx = y * w + x;
			var f = fg[idx], b = bg[idx], c = f > b ? f : b;
			fgRow.push(f.toString(16));
			bgRow.push(b.toString(16));
			cRow.push(c.toString(16));
		}
		post("  row " + y + "  fg:[" + fgRow.join(" ") + "]  bg:[" + bgRow.join(" ") + "]  out:[" + cRow.join(" ") + "]\n");
	}
}

function anything() {
	var a = arrayfromargs(arguments);
	switch (messagename) {
		case "edition":
			set_edition(parseInt(a[0], 10));
			break;
		case "prefix":
			prefix = a.length ? a.join(" ") : "/box";
			break;
		case "dual128":
			dual128Mode = a[0] ? 1 : 0;
			post("[grid_matrix_bridge] dual128Mode=" + dual128Mode + "\n");
			break;
		case "setcell_bg":
			if (a.length >= 3) setcell_bg(parseInt(a[0], 10), parseInt(a[1], 10), parseInt(a[2], 10));
			break;
		case "clear_bg":
			clear_bg();
			break;
		case "fill_bg":
			if (a.length >= 1) fill_bg(parseInt(a[0], 10));
			break;
		case "beginframe":
			beginframe();
			break;
		case "beginupdate":
			beginupdate();
			break;
		case "endframe":
			endframe();
			break;
		case "endupdate":
			endframe();
			break;
		case "colorcell":
			if (a.length >= 5) colorcell.apply(this, a);
			break;
		case "colorall":
			if (a.length >= 3) colorall.apply(this, a);
			break;
		case "colormap":
			if (a.length === 50) colormap.apply(this, a);
			break;
		case "colorpresetstore":
			if (a.length >= 1) colorpresetstore.apply(this, a);
			break;
		case "colorpresetrecall":
			if (a.length >= 1) colorpresetrecall.apply(this, a);
			break;
		case "rgbcell":
			if (a.length >= 5) rgbcell.apply(this, a);
			break;
		case "rgball":
			if (a.length >= 3) rgball.apply(this, a);
			break;
		case "level8cell":
			if (a.length >= 3) level8cell.apply(this, a);
			break;
		case "level8all":
			if (a.length >= 1) level8all.apply(this, a);
			break;
		case "intensity8":
			if (a.length >= 1) intensity8.apply(this, a);
			break;
	}
}
