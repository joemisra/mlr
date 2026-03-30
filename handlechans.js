inlets = 1;

var s = new Global("mlr");

function list() {
    for(i=0;i<8; i++) {
        s.channels[i].on = arguments[i];
    }
    s.drawChannelsPlaying();
}