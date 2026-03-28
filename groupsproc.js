/**
 * @deprecated — Superseded by grid_router.js (2026-03-28).
 *
 * This file had a bug: line 32 treated `muted` (an array) as a scalar,
 * replacing the entire array with 0 or 1 on first toggle.
 * Group/channel stop and mute logic is now in grid_router.js
 * (handleRow0Channel, handleModMute).
 *
 * Retained for reference only. Do not load via [js] or [v8].
 */

inlets = 2;
outlets = 3;
var kmod = 2;
var muted = [1,1,1,1,1,1,1,1];

function loadbang() {
	outlet(2, 1);
}

function msg_int(a) {
	if(inlet == 1) {
		kmod = a;
	}
}

function list(l) {
	post(arguments[1] + "\n");
	channel = arguments[0];
	value = arguments[1];
	if(kmod == 1) {
		//outlet
		if(value == 1) {
			outlet(0, [channel, 0, 0]);
			//utlet(1, 1);
			messnamed((channel + 1) + "[pl]stop", 1);
		}
	}	
	else if(kmod == 2) {
		//outlet
		if(value == 1) {
			//outlet(2, "bang");
			muted = muted ? 0 : 1;
			messnamed((channel + 1) + "[box]mute", muted);
		}
	}	
}