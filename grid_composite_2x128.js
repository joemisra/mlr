autowatch = 1;
inlets = 3;
outlets = 3;

var dual128_on = 0; // 0 = single-256 (default), 1 = two 128s
var edition = 256;
/**
 * Composite grid driver for mlr — supports both a native 256 and two stacked 128s.
 *
 * MODE: dual128 0  (default) — single monome 256
 *   Inlet 0: LED data — passed straight through to outlet 0, no splitting or y-remapping.
 *   Inlet 1: [udpreceive 58901] — all key events (y 0-15 native). Inlet 2 unused.
 *   Outlet 0 -> [udpsend] single device serialosc port.
 *   Outlet 1 -> unused.
 *
 * MODE: dual128 1 — two monome 128s stacked as one logical 256
 *   Inlet 0: LED data — /grid/led/level/map split by oy (top/bottom).
 *   Inlet 1: [udpreceive 58901] — top grid key events (y 0-7).
 *   Inlet 2: [udpreceive 58902] — bottom grid key events (y remapped +8 -> 8-15).
 *   Outlet 0 -> [udpsend] top grid serialosc port (LEDs rows 0-7).
 *   Outlet 1 -> [udpsend] bottom grid serialosc port (LEDs rows 8-15 -> phys 0-7).
 *
 * Outlet 2 (both modes) -> key events (/prefix/grid/key x y s)
 *             -> p oscreceiveroute -> s rawpress + s box/press_a
 *
 * Send "dual128 0" or "dual128 1" to inlet 0 to switch mode at any time.
 * A loadbang in the patch fires "dual128 0" automatically on startup.
 */

// --- LED Dispatch (inlet 0) ------------------------------------------------

function ledDispatch(args) {
	if (!args.length) return;
	var path = args[0].toString();

	// Single-256 mode: pass all LED messages straight to outlet 0, no splitting or remapping.
	// The 256 understands y 0-15 natively.
	if (!dual128_on) {
		emit(0, args);
		return;
	}

	// dual-128 mode below ---

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
		// In single-256 mode the device already sends native y 0-15 on one port;
		// inlet 2 never fires and no offset is needed.
		if (isBottom && dual128_on) {
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

function dual128(mode) {
	dual128_on = mode ? 1 : 0;
	post("[grid_composite_2x128] mode: " + (dual128_on ? "dual-128 (two 128s)" : "single-256") + "\n");
}

function loadbang() {
	post("[grid_composite_2x128] ready — mode: " + (dual128_on ? "dual-128 (two 128s)" : "single-256") + "\n");
}
