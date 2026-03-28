autowatch = 1;
inlets = 3;
outlets = 3;

/**
 * Virtual composite Monome: two 128s stacked as one logical 256 for mlr.
 * No monome-device bpatcher — uses raw UDP to serialosc (two ports).
 *
 * Inlet 0: same combined stream that normally goes to [monome-device] inlet
 *          (e.g. [r box_out] + [grid_matrix_io] merged) — LED OSC is split;
 *          other OSC passes through outlet 2 only.
 * Inlet 1: [udpreceive] from top grid’s serialosc port.
 * Inlet 2: [udpreceive] from bottom grid’s serialosc port.
 *
 * Outlet 0 → [udpsend 127.0.0.1 topPort]   (LED top half, rows 0–7)
 * Outlet 1 → [udpsend 127.0.0.1 bottomPort] (LED bottom half, logical 8–15 → phys 0–7)
 * Outlet 2 → parent OSC fan-in (was monome outlet): keys merged, non-LED passthrough from top.
 *
 * Use with [grid_matrix_bridge] dual128 0 and edition 256 — one LED stream, split here.
 */

function pathStr(p) {
	if (p === undefined || p === null) {
		return "";
	}
	return p.toString();
}

/** grid_matrix_bridge defaults to /monome; mlr oscreceiveroute expects /box. */
function swapMonomeToBox(full) {
	if (!full || !full.length) {
		return full;
	}
	var h = pathStr(full[0]);
	if (h.indexOf("/monome/") === 0) {
		var out = ["/box/" + h.slice(8)];
		var i;
		for (i = 1; i < full.length; i++) {
			out.push(full[i]);
		}
		return out;
	}
	return full;
}

function emit(outn, full) {
	if (!full || !full.length) {
		return;
	}
	var args = [outn];
	var i;
	for (i = 0; i < full.length; i++) {
		args.push(full[i]);
	}
	outlet.apply(this, args);
}

function emitLed(outn, full) {
	emit(outn, swapMonomeToBox(full));
}

function isLedPath(ps) {
	return ps.indexOf("grid/led") >= 0;
}

function ledDispatch(full) {
	var ps = pathStr(full[0]);
	if (ps.indexOf("/grid/led/all") >= 0 || ps.indexOf("grid/led/all") >= 0) {
		emitLed(0, full);
		emitLed(1, full);
		return;
	}
	if (ps.indexOf("/grid/led/level/all") >= 0 || ps.indexOf("grid/led/level/all") >= 0) {
		emitLed(0, full);
		emitLed(1, full);
		return;
	}
	if (ps.indexOf("/grid/led/level/map") >= 0 || ps.indexOf("grid/led/level/map") >= 0) {
		var ox = full[1] | 0;
		var oy = full[2] | 0;
		var tail = [];
		var i;
		for (i = 3; i < full.length; i++) {
			tail.push(full[i]);
		}
		if (oy < 8) {
			emitLed(0, [full[0], ox, oy].concat(tail));
		} else {
			emitLed(1, [full[0], ox, oy - 8].concat(tail));
		}
		return;
	}
	if (ps.indexOf("/grid/led/level/set") >= 0 || ps.indexOf("grid/led/level/set") >= 0) {
		var x = full[1] | 0;
		var y = full[2] | 0;
		var rest = [];
		var j;
		for (j = 3; j < full.length; j++) {
			rest.push(full[j]);
		}
		if (y < 8) {
			emitLed(0, [full[0], x, y].concat(rest));
		} else {
			emitLed(1, [full[0], x, y - 8].concat(rest));
		}
		return;
	}
	if (ps.indexOf("/grid/led/set") >= 0 || ps.indexOf("grid/led/set") >= 0) {
		var x2 = full[1] | 0;
		var y2 = full[2] | 0;
		var rest2 = [];
		var k;
		for (k = 3; k < full.length; k++) {
			rest2.push(full[k]);
		}
		if (y2 < 8) {
			emitLed(0, [full[0], x2, y2].concat(rest2));
		} else {
			emitLed(1, [full[0], x2, y2 - 8].concat(rest2));
		}
		return;
	}
	if (ps.indexOf("/grid/led/row") >= 0 || ps.indexOf("grid/led/row") >= 0) {
		var row = full[1] | 0;
		var tailR = [];
		var r;
		for (r = 2; r < full.length; r++) {
			tailR.push(full[r]);
		}
		if (row < 8) {
			emitLed(0, [full[0], row].concat(tailR));
		} else {
			emitLed(1, [full[0], row - 8].concat(tailR));
		}
		return;
	}
	emitLed(0, full);
	emitLed(1, full);
}

function parentInbound(full) {
	if (!full.length) {
		return;
	}
	var ps = pathStr(full[0]);
	if (isLedPath(ps)) {
		ledDispatch(full);
	} else {
		emit(2, swapMonomeToBox(full));
	}
}

function keyDispatch(full, isBottom) {
	if (!full.length) {
		return;
	}
	var ps = pathStr(full[0]);
	if (ps.indexOf("grid/key") < 0) {
		if (!isBottom) {
			emit(2, swapMonomeToBox(full));
		}
		return;
	}
	var x = full[1] | 0;
	var y = full[2] | 0;
	var s = full[3] | 0;
	if (isBottom) {
		y += 8;
		if (y > 15) {
			y = 15;
		}
	}
	emit(2, swapMonomeToBox([full[0], x, y, s]));
}

function udpInbound(full, isBottom) {
	if (!full.length) {
		return;
	}
	var ps = pathStr(full[0]);
	if (ps.indexOf("grid/key") >= 0) {
		keyDispatch(full, isBottom);
	} else if (!isBottom) {
		emit(2, swapMonomeToBox(full));
	}
}

function routeInbound(full) {
	if (inlet === 0) {
		parentInbound(full);
	} else if (inlet === 1) {
		udpInbound(full, false);
	} else {
		udpInbound(full, true);
	}
}

function list() {
	routeInbound(arrayfromargs(arguments));
}

function anything() {
	routeInbound([messagename].concat(arrayfromargs(arguments)));
}

function loadbang() {
	post("[grid_composite_2x128] #1 #2 = device UDP (LED). Keys → local udpreceive 58901 / 58902 (see patch init /sys/port).\n");
}
