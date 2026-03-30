autowatch = 1;
inlets = 1;
outlets = 2;

/**
 * Keyframe queue per cell: pairs (target, frames). frames==0 = instant.
 * tick advances one animation step per cell (one lerp step per segment per tick).
 * outlet 1: flush — only when matrix changed (dirty).
 * Same matrix name as grid_matrix_bridge.js (@args).
 */

var matrixName = "grid_matrix_io_state";
var edition = 256;
var cells = {};

if (jsarguments.length > 1) {
	matrixName = jsarguments[1];
}

function bind_matrix() {
	var jm = new JitterMatrix(1, "char", 16, 16);
	jm.name = matrixName;
	return jm;
}

function dims_for_edition(e) {
	if (e === 64) return [8, 8];
	if (e === 128) return [16, 8];
	return [16, 16];
}

function clamp(v, lo, hi) {
	return Math.min(hi, Math.max(lo, v));
}

function clampLevel(v) {
	return clamp(Math.round(v), 0, 15) | 0;
}

function loadbang() {
	post("[grid_anim_engine] matrix=" + matrixName + " edition=" + edition + "\n");
}

function edition_msg(n) {
	var v = parseInt(n, 10);
	if (v === 64 || v === 128 || v === 256) {
		edition = v;
		post("[grid_anim_engine] edition=" + edition + "\n");
	}
}

function edition(e) {
	edition_msg(e);
}

function clear_anim() {
	cells = {};
	post("[grid_anim_engine] queues cleared (matrix unchanged)\n");
}

function tick() {
	var jm = bind_matrix();
	var dirty = false;
	var k;
	for (k in cells) {
		if (advanceCell(k, cells[k], jm)) {
			dirty = true;
		}
	}
	if (dirty) {
		outlet(0, "flush");
	}
}

function readLevel(x, y) {
	var jm = bind_matrix();
	var w = jm.dim[0];
	var h = jm.dim[1];
	var u8 = new Uint8Array(w * h);
	jm.copymatrixtoarray(u8);
	return u8[y * w + x] | 0;
}

function ensureCell(key) {
	if (!cells[key]) {
		var xy = key.split(",");
		var x = parseInt(xy[0], 10);
		var y = parseInt(xy[1], 10);
		cells[key] = { level: readLevel(x, y), q: [], seg: null };
	}
	return cells[key];
}

function parsePairs(args) {
	var pairs = [];
	var i;
	for (i = 0; i + 1 < args.length; i += 2) {
		pairs.push({
			t: clampLevel(parseFloat(args[i])),
			f: Math.max(0, parseInt(args[i + 1], 10) | 0)
		});
	}
	return pairs;
}

function kf() {
	var x = parseInt(arguments[0], 10);
	var y = parseInt(arguments[1], 10);
	var rest = [];
	var i;
	for (i = 2; i < arguments.length; i++) {
		rest.push(arguments[i]);
	}
	applyKf(x, y, rest);
}

function applyKf(x, y, numList) {
	var wh = dims_for_edition(edition);
	if (isNaN(x) || isNaN(y) || x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_anim_engine] kf out of range\n");
		return;
	}
	if (numList.length < 2 || numList.length % 2 !== 0) {
		post("[grid_anim_engine] kf needs pairs target frames ...\n");
		return;
	}
	var key = x + "," + y;
	var c = ensureCell(key);
	c.q = parsePairs(numList);
	c.seg = null;
	//post("[grid_anim_engine] kf replace " + key + " segments=" + c.q.length + "\n");
}

function line() {
	var y = parseInt(arguments[0], 10);
	var x0 = parseInt(arguments[1], 10);
	var x1 = parseInt(arguments[2], 10);
	var rest = [];
	var i;
	for (i = 3; i < arguments.length; i++) {
		rest.push(arguments[i]);
	}
	if (rest.length < 2 || rest.length % 2 !== 0) {
		post("[grid_anim_engine] line needs pairs after y x0 x1\n");
		return;
	}
	var step = x0 <= x1 ? 1 : -1;
	var x;
	for (x = x0; x !== x1 + step; x += step) {
		applyKf(x, y, rest);
	}
}

function advanceCell(key, c, jm) {
	var xy = key.split(",");
	var x = parseInt(xy[0], 10);
	var y = parseInt(xy[1], 10);
	var dirty = false;

	function writeLevel(val) {
		var v = clampLevel(val);
		if (c.level !== v) {
			c.level = v;
			jm.setcell2d(x, y, v);
			dirty = true;
		}
	}

	var didInstant = false;
	while (c.q.length > 0 && !c.seg && c.q[0].f === 0) {
		didInstant = true;
		var h = c.q.shift();
		writeLevel(h.t);
	}
	if (didInstant && c.q.length > 0 && !c.seg && c.q[0].f > 0) {
		return dirty;
	}

	if (c.seg) {
		var s = c.seg;
		var v = Math.round(s.start + (s.target - s.start) * (s.step / s.frames));
		writeLevel(v);
		s.step++;
		if (s.step > s.frames) {
			writeLevel(s.target);
			c.seg = null;
			while (c.q.length > 0 && !c.seg && c.q[0].f === 0) {
				h = c.q.shift();
				writeLevel(h.t);
			}
		}
		return dirty;
	}

	if (c.q.length > 0) {
		var n = c.q.shift();
		if (n.f === 0) {
			writeLevel(n.t);
			while (c.q.length > 0 && c.q[0].f === 0) {
				n = c.q.shift();
				writeLevel(n.t);
			}
			return dirty;
		}
		c.seg = {
			start: c.level,
			target: n.t,
			frames: n.f,
			step: 1
		};
		var v0 = Math.round(c.seg.start + (c.seg.target - c.seg.start) * (c.seg.step / c.seg.frames));
		writeLevel(v0);
		c.seg.step++;
		if (c.seg.step > c.seg.frames) {
			writeLevel(c.seg.target);
			c.seg = null;
		}
		return dirty;
	}

	return dirty;
}

function setcell(x, y, v) {
	x = x | 0;
	y = y | 0;
	v = clamp(Math.floor(v), 0, 15);
	var jm = bind_matrix();
	var wh = jm.dim;
	if (x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_anim_engine] setcell out of range\n");
		return;
	}
	jm.setcell2d(x, y, v);
}

function anything() {
	var a = arrayfromargs(messagename, arguments);
	if (messagename === "edition") {
		edition_msg(a[0]);
	} else if (messagename === "tick") {
		tick();
	} else if (messagename === "clear_anim") {
		clear_anim();
	} else if (messagename === "kf" && a.length >= 4) {
		applyKf(parseInt(a[0], 10), parseInt(a[1], 10), a.slice(2));
	} else if (messagename === "line" && a.length >= 5) {
		var rest = a.slice(3);
		if (rest.length < 2 || rest.length % 2 !== 0) {
			post("[grid_anim_engine] line bad pairs\n");
			return;
		}
		var y = parseInt(a[0], 10);
		var x0 = parseInt(a[1], 10);
		var x1 = parseInt(a[2], 10);
		var step = x0 <= x1 ? 1 : -1;
		var x;
		for (x = x0; x !== x1 + step; x += step) {
			applyKf(x, y, rest);
		}
	}
}
