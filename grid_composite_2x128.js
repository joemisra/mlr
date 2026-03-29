autowatch = 1;
inlets = 3;
outlets = 3;

/**
 * Two Monome 128s stacked as one logical 256 for mlr.
 * Replaces monome-device -- uses raw UDP to serialosc (two device ports).
 *
 * Inlet 0: LED data from grid_matrix_bridge via [r fromgridmatrixio].
 *          Bridge must use dual128 0, edition 256, prefix /box.
 *          Only /grid/led/level/map and /grid/led/all are expected.
 * Inlet 1: [udpreceive 58901] -- top grid serialosc key events.
 * Inlet 2: [udpreceive 58902] -- bottom grid serialosc key events.
 *
 * Outlet 0 -> [udpsend] top grid serialosc port (LEDs rows 0-7)
 * Outlet 1 -> [udpsend] bottom grid serialosc port (LEDs rows 8-15 -> phys 0-7)
 * Outlet 2 -> key events (/prefix/grid/key x y s, bottom y += 8)
 *             -> p oscreceiveroute -> s rawpress + s box/press_a
 */

// --- LED Dispatch (inlet 0) ------------------------------------------------

function ledDispatch(args) {
	if (!args.length) return;
	var path = args[0].toString();

	// /grid/led/all or /grid/led/level/all -> send to both grids
	if (path.indexOf("grid/led/all") >= 0 || path.indexOf("grid/led/level/all") >= 0) {
		emit(0, args);
		emit(1, args);
		return;
	}

	// /grid/led/level/map ox oy data... -> split by oy
	if (path.indexOf("grid/led/level/map") >= 0) {
		var ox = args[1] | 0;
		var oy = args[2] | 0;
		if (oy < 8) {
			emit(0, args);
		} else {
			var remapped = [args[0], ox, oy - 8];
			for (var i = 3; i < args.length; i++) {
				remapped.push(args[i]);
			}
			emit(1, remapped);
		}
		return;
	}

	// Unknown LED message -> send to both (safety fallback)
	emit(0, args);
	emit(1, args);
}

// --- Key Dispatch (inlets 1-2) ----------------------------------------------

function keyDispatch(args, isBottom) {
	if (!args.length) return;
	var path = args[0].toString();

	if (path.indexOf("grid/key") >= 0) {
		var x = args[1] | 0;
		var y = args[2] | 0;
		var s = args[3] | 0;
		if (isBottom) {
			y = Math.min(y + 8, 15);
		}
		emit(2, [args[0], x, y, s]);
		return;
	}

	// Non-key messages from top grid pass through (e.g. /sys/id)
	if (!isBottom) {
		emit(2, args);
	}
}

// --- Inlet Routing ----------------------------------------------------------

function list() {
	var args = arrayfromargs(arguments);
	if (inlet === 0) {
		ledDispatch(args);
	} else {
		keyDispatch(args, inlet === 2);
	}
}

function anything() {
	var args = [messagename].concat(arrayfromargs(arguments));
	if (inlet === 0) {
		ledDispatch(args);
	} else {
		keyDispatch(args, inlet === 2);
	}
}

// --- Helpers ----------------------------------------------------------------

function emit(outn, args) {
	if (!args || !args.length) return;
	var out = [outn];
	for (var i = 0; i < args.length; i++) {
		out.push(args[i]);
	}
	outlet.apply(this, out);
}

function loadbang() {
	post("[grid_composite_2x128] ready\n");
}
