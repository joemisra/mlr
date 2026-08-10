autowatch = 1;
inlets = 1;
outlets = 2;

/**
 * Keyframe queue per cell: pairs (target, frames). frames==0 = instant.
 * tick advances one animation step per cell (one lerp step per segment per tick).
 * outlet 0: flush — only when the transient overlay changed (dirty).
 *
 * Animation cells are sent as explicit overlay messages to
 * grid_matrix_bridge.js, which composites them over stable foreground and
 * background arrays. This
 * prevents a fade-to-zero from permanently erasing the page underneath it.
 */

var edition = 256;
var cells = {};

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
	resetAnimationState();
	post("[grid_anim_engine] message overlay edition=" + edition + "\n");
	// If autowatch recompiles during a flash, immediately reveal the preserved
	// base instead of leaving the last animated hardware frame latched.
	messnamed("togridmatrixio", "flush");
}

function resetAnimationState() {
	cells = {};
	outlet(0, "animclear");
}

function edition_msg(n) {
	var v = parseInt(n, 10);
	if (v === 64 || v === 128 || v === 256) {
		edition = v;
		resetAnimationState();
		post("[grid_anim_engine] edition=" + edition + "\n");
	}
}

function edition(e) {
	edition_msg(e);
}

function clear_anim() {
	cells = {};
	outlet(0, "animclear");
	outlet(0, "flush");
	post("[grid_anim_engine] queues and transient overlay cleared\n");
}

function tick() {
	var k;
	var hasCells = false;
	for (k in cells) {
		hasCells = true;
		break;
	}
	if (!hasCells) return;

	var dirty = false;
	for (k in cells) {
		var cell = cells[k];
		if (!cell.seg && cell.q.length === 0 && cell.retirePending) {
			if (hideCell(k, cell)) dirty = true;
			delete cells[k];
			continue;
		}
		if (advanceCell(k, cell)) {
			dirty = true;
		}
		// Keep a completed override visible through this flush. The next tick
		// clears its mask, revealing whatever base value the router owns now.
		if (!cell.seg && cell.q.length === 0) cell.retirePending = true;
	}
	if (dirty) {
		outlet(0, "flush");
	}
}

function ensureCell(key) {
	if (!cells[key]) {
		var xy = key.split(",");
		var x = parseInt(xy[0], 10);
		var y = parseInt(xy[1], 10);
		cells[key] = {
			level: 0,
			q: [],
			seg: null,
			visible: false,
			retirePending: false
		};
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
	c.retirePending = false;
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

function hideCell(key, c) {
	if (!c.visible) return false;
	var xy = key.split(",");
	outlet(0, "animcell", parseInt(xy[0], 10), parseInt(xy[1], 10), 0, 0);
	c.visible = false;
	return true;
}

function advanceCell(key, c) {
	var xy = key.split(",");
	var x = parseInt(xy[0], 10);
	var y = parseInt(xy[1], 10);
	var dirty = false;

	function writeLevel(val) {
		var v = clampLevel(val);
		if (!c.visible || c.level !== v) {
			c.level = v;
			outlet(0, "animcell", x, y, v, 1);
			c.visible = true;
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
	var wh = dims_for_edition(edition);
	if (x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_anim_engine] setcell out of range\n");
		return;
	}
	outlet(0, "animcell", x, y, v, 1);
}

function anything() {
	var a = arrayfromargs(arguments);
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
