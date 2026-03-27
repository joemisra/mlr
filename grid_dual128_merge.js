utowatch = 1;
inlets = 2;
outlets = 1;

/**
 * Merge two Monome 128 press streams into one logical 256-sized stream for mlr.
 *
 * Physical layout: stack two 128s vertically — top = rows 0–7, bottom = rows 8–15
 * (same column index on both). Side‑by‑side 32×8 is NOT compatible with mlr’s 16×16 model.
 *
 * Inlet 0: (col, row, state) from the top grid → forwarded as-is when dual mode on.
 * Inlet 1: (col, row, state) from the bottom grid → row += 8.
 * dual128 0: only inlet 0 is used (inlet 1 ignored) — use one 128 or a real 256.
 * dual128 1: two-grid mode.
 *
 * Wire: [r box/press_a] → inlet 0, [r box/press_b] → inlet 1, outlet → [s box/press_mlr]
 */

var dual = 1;

function dual128(v) {
	dual = v ? 1 : 0;
}

function list() {
	var a = arrayfromargs(arguments);
	if (a.length < 3) {
		return;
	}
	var x = a[0] | 0;
	var y = a[1] | 0;
	var s = a[2] | 0;
	var rowOff = 0;
	if (dual && inlet === 1) {
		rowOff = 8;
	} else if (!dual && inlet === 1) {
		return;
	}
	y += rowOff;
	if (y < 0) {
		y = 0;
	}
	if (y > 15) {
		y = 15;
	}
	outlet(0, x, y, s);
}

function loadbang() {
	dual128(0);
}
