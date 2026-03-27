inlets = 4;
outlets = 2;


var sequences = [];

var channels = 8;
var sequence_length = 32;

var step = 0;

var armed = 0;


for(i = 0; i < channels; i++) {
	sequences[i] = new Array(sequence_length);
	for(j = 0; j < sequence_length; j++) {
		sequences[i][j] = 0;
	}
}

function msg_int(a) {
		if(inlet == 1) {
			// step has changed
			if(step == (sequence_length - 1) && a == 0) {
				//armed = 0;
				outlet(1, armed);
			}
			step = a;
		}
		
		if(inlet == 2) {
			armed = a;
			
			outlet(1, armed);
		}
		
}

function clearwhich(a) {
		var row = arguments[0];
		var state = arguments[1];
				
		for(j = 0; j < sequence_length; j++) {
			sequences[row][j] = 0;
		}
		
		outlet(0, row + 1, sequences[row]);
}

function list(l) {
		
	if(inlet == 0) {
	var row = arguments[0];
	var col = arguments[1];
	var state = arguments[2];
		
	if(row > 1) {
		var seqrow = row - 2;
		
		if(armed) {
			if(state == 1) {
				post("row " + row);
				sequences[seqrow][step] = 1;
				outlet(0, row - 1, 1);
			}
		}
	}
	}
}