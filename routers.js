/**
 * @deprecated — Superseded by grid_router.js (2026-03-28).
 *
 * This file used row-major order (row, col, state) which is incompatible
 * with grid_router.js (col, row, state — matching serialosc convention).
 * All routing, drawing, kmod handling, and automation are now consolidated
 * in grid_router.js inside grid_router_io.maxpat.
 *
 * Retained for reference only. Do not load via [js] or [v8].
 */

inlets = 2;
outlets = 3;

var kmod = 0;
var muted = [1,1,1,1,1,1,1,1];
var reverse_toggles = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

var record_automation = 0;
var grid_animate_task;

var testinc = 0;

grid_animate_task = new Task(grid_animate, this);
grid_animate_task.interval = 80;
grid_animate_task.repeat();

function grid_animate() {
	testinc = (testinc == 15) ? 5 : testinc + 1;
	if(record_automation == 1 && kmod == 2) {
		for(i = 1; i < 15; i++) {
			boxled(8, i, testinc);
		}
	}
}

function disable_automation() {
	record_automation = 0;
	outlet(2, record_automation);
	for(i = 1; i < 15; i++) {
		boxled(8, i, 0);
	}
}

function boxled(col, row, level) {
	messnamed("box/led", col, row, level);
}

function msg_int(a) {
	if(inlet == 1) {
		kmod = a;
		post("kmod " + kmod + "\n");
		
		if(kmod == 2) {
			for(i = 0; i < 8; i++) {
				boxled(i, 1, 8);
				boxled(i, 2, 8);
			}
		}
	}
}

function list(l) {
		var row = arguments[0];
		var col = arguments[1];
		var state = arguments[2];
		
		//post("routers.js: " + row + " " + col + " " + state + "\n");
		
		if(row == 1 && col < 8) {
			// groups etc
			handlegroup(col, state);
		} else if(row == 1 && col >= 8 && col < 12) {
			// pattern recorder toggles, if kmod == 1
		} else if(row == 1 && col >= 12) {
			// presets, reverse
		}
		
		if(row > 1 && state == 1 && kmod == 2) {
			// handle volume up down, left side buttons in mode 2
			if(col < 8) {
				grp = col + 1;
				
				if(row == 2) {
					// up
					// STACK*
					messnamed(grp + "vol_add", 4);
				}
				if(row == 3) {
					// down
					// STACK*
					messnamed(grp + "vol_add", -4);
				}
			}
			
			// toggle recording buttons
 			if(col == 8) {
				record_automation = 1 - record_automation;
				if(record_automation == 0) {
					disable_automation();
				}
				else {
					testinc = 1;
				}
				outlet(2, record_automation);
			}
			
			// reverse
			if(col == 15) {
				reverse_toggles[row] = 1 - reverse_toggles[row];
				targ = row + "[box]rev";
				messnamed(targ, reverse_toggles[row]);
				
			}
		}
		
		if(row > 0 && (col == 9 || col <= 15) && kmod == 2 && state == 1) {
			pass_button(col, row - 1, state);
		}
}

function handlegroup(channel, state) {	
	if(kmod == 1) {
		//outlet
		if(state == 1) {
			outlet(0, [channel, 0, 0]);
			outlet(2, channel + 1, 0);
			//utlet(1, 1);
			messnamed((channel + 1) + "[pl]stop", 1);
		}
	}	
	else if(kmod == 2) {
		//outlet
		if(state == 1) {
			//outlet(2, "bang");
			post("muted " + channel + " " + muted[channel] + "\n");
			muted[channel] = muted[channel] ? 0 : 1;
			messnamed((channel + 1) + "[box]mute", muted[channel]);
		}
	}
}

function pass_button(row, col, state) {
	outlet(1, [row, col, state]);
}