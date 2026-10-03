// Hardware-silent integration probe only. Uses the router's public session API.
autowatch = 0;
function bang() {
    var source = {tracks: [], patterns: {}, automation: {events: [], length:128}, modulation:{routes:[]}};
    for (var track=0;track<16;track++) source.tracks.push({group:7,buffer:0});
    ["kick","snare","hat","clap","tom","rim"].forEach(function(id,group) {
        var model = require(id === "kick" ? "instrument_model.js" : id+"_instrument_model.js");
        var locks = model[id.toUpperCase()+"_LOCKS"], values=model.sanitize({}), track=14-group;
        locks.forEach(function(parameter) {
            if (/Decay$/.test(parameter)) values[parameter]=model.clampValue(parameter,30);
        });
        source.tracks[track]={group:group,buffer:0,instrumentParameters:values};
        source.patterns["group:"+group]={rateNumerator:1,rateDenominator:1,bars:[{length:16,steps:
            Array.from({length:16},function(_,step) {return {cut:step===0?{track:track,slice:0,gateLength:1}:null,
                locks:{},condition:0,probability:15};})}]};
    });
    var dict=new Dict("native_integration_fixture"); dict.parse(JSON.stringify(source));
    messnamed("gridrouter","editorLayout","sequence64");
    messnamed("gridrouter","sessionApplyDict","native_integration_fixture");
    post("[native integration] stopped six-drum fixture loaded\n");
}
