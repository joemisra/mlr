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

function prefix_msg(s) {
	prefix = s;
}

function bang() {
	flush();
}

function flush() {
	send_level_maps();
}

function clear() {
	var jm = bind_matrix();
	jm.clear();
	flush();
	//outlet(0, prefix + "/grid/led/all", 0);
	//if (dual128Mode) {
	//	outlet(1, prefix + "/grid/led/all", 0);
	//}
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
	var w = wh[0];
	var h = wh[1];
	var u8 = new Uint8Array(w * h);
	jm.copymatrixtoarray(u8);
	var i;
	for (i = 0; i < u8.length; i++) {
		u8[i] = Math.max(0, (u8[i] | 0) - 1);
	}
	jm.copyarraytomatrix(u8);
}

function fill(v) {
	v = clamp(Math.floor(v), 0, 15);
	var jm = bind_matrix();
	jm.fillplane(0, v);
}

function send_level_maps() {
	var jm = bind_matrix();
	var wh = jm.dim;
	var w = wh[0];
	var h = wh[1];
	var u8 = new Uint8Array(w * h);
	jm.copymatrixtoarray(u8);
	var path = prefix + "/grid/led/level/map";
	var regions = regions_for_edition(edition);
	var i;
	for (i = 0; i < regions.length; i++) {
		var ox = regions[i][0];
		var oy = regions[i][1];
		var data = block8_from_u8(u8, w, ox, oy);
		out_list(path, ox, oy, data);
	}
}

function regions_for_edition(e) {
	if (e === 64) return [[0, 0]];
	if (e === 128) return [[0, 0], [8, 0]];
	return [[0, 0], [8, 0], [0, 8], [8, 8]];
}

function block8_from_u8(u8, w, ox, oy) {
	var row, col;
	var out = [];
	for (row = 0; row < 8; row++) {
		for (col = 0; col < 8; col++) {
			out.push(clamp(u8[(oy + row) * w + (ox + col)] | 0, 0, 15));
		}
	}
	return out;
}

function out_list(path, ox, oy, bytes) {
	var args = [path, ox, oy];
	var i;
	for (i = 0; i < bytes.length; i++) {
		args.push(bytes[i]);
	}
	if (!dual128Mode) {
		outlet.apply(this, [0].concat(args));
		return;
	}
	if (oy < 8) {
		outlet.apply(this, [0].concat(args));
	} else {
		var argsB = [path, ox, oy - 8];
		for (i = 0; i < bytes.length; i++) {
			argsB.push(bytes[i]);
		}
		outlet.apply(this, [1].concat(argsB));
	}
}

function clamp(n, lo, hi) {
	return Math.min(hi, Math.max(lo, n));
}

function anything() {
	var a = arrayfromargs(arguments);
	if (messagename === "edition") {
		set_edition(parseInt(a[0], 10));
	} else if (messagename === "prefix") {
		prefix = a.length ? a.join(" ") : "/box";
	} else if (messagename === "setcell" && a.length >= 3) {
		setcell(a[0], a[1], a[2]);
	} else if (messagename === "fill" && a.length) {
		fill(a[0]);
	} else if (messagename === "flush") {
		flush();
	} else if (messagename === "clear") {
		clear();
	} else if (messagename === "fade_step") {
		fade_step();
	} else if (messagename === "dual128") {
		dual128Mode = a[0] ? 1 : 0;
		post("[grid_matrix_bridge] dual128Mode=" + dual128Mode + "\n");
	}
}
