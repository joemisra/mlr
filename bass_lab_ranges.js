autowatch = 1;
inlets = 1;
outlets = 2;
var Instruments = require("bass_instrument_model.js");
var ranges = {}, pending = {};
var flushTask = new Task(flushRanges, this);
Instruments.BASS_LOCKS.forEach(function(id) { ranges[id] = Instruments.mappingRange(id); });

function publishRange(id) {
 var r = ranges[id];
 outlet(0, id + "-min", "set", r.min);
 outlet(0, id + "-max", "set", r.max);
 messnamed("gridrouter", "bassRange", id, r.min, r.max);
}
function bang() { Instruments.BASS_LOCKS.forEach(publishRange); }
function setrange(id, edge, value) {
 if (!Instruments.definition(id) || (edge !== "min" && edge !== "max")) return;
 if (!pending[id]) pending[id] = {min:ranges[id].min,max:ranges[id].max};
 pending[id][edge] = Number(value);
 flushTask.cancel();
 flushTask.schedule(0);
}
function flushRanges() {
 var invalid = false;
 Instruments.BASS_LOCKS.forEach(function(id) {
  var r = pending[id], def = Instruments.definition(id);
  if (!r) return;
  if (isFinite(r.min) && isFinite(r.max) && r.min >= def.min && r.max <= def.max && r.min < r.max) ranges[id] = r;
  else invalid = true;
  publishRange(id);
 });
 pending = {};
 outlet(1, "set", invalid ? "Range rejected: keep Min < Max within the supported limits." : "Grid ranges ready. Existing sound values stay unchanged.");
}
