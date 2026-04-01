autowatch = 1;
inlets = 1;
outlets = 2;

/**
 * Varibright LED state bridge: jit.matrix (char 0–15) -> /grid/led/level/map
 * Map layout matches mlr4k3r0update7/gridfantastic: 8x8 blocks at (0,0), (8,0),
 * and for 256 also (0,8), (8,8).
 * Requires Max JS v8 + Jitter (copymatrixtoarray / copyarraytomatrix).
 *
 * dual128 1: two stacked 128 grids as one 256 — outlet 0 = top rows (0–7),
 * outlet 1 = bottom rows (logical 8–15 mapped to physical 0–7). Use edition 256.
 */

var matrixName = "grid_matrix_io_state";
var prefix = "/box";
var edition = 256;
var dual128Mode = 0;

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
	post("[grid_matrix_bridge] edition=" + edition + " dim=" + wh + "\n");
}

function bang() {
	send_level_maps();
}

function flush() {
	send_level_maps();
}

function clear() {
	bind_matrix().clear();
	send_level_maps();
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
	var u8 = new Uint8Array(w * wh[1]);
	jm.copymatrixtoarray(u8);
	var path = prefix + "/grid/led/level/map";
	var regions = regions_for_edition(edition);
	for (var i = 0; i < regions.length; i++) {
		var ox = regions[i][0];
		var oy = regions[i][1];
		out_block(path, ox, oy, block8_from_u8(u8, w, ox, oy));
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

// Only messages without dedicated handlers reach anything():
// "edition", "prefix", and "dual128".
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
	}
}
