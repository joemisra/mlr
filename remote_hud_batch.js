"use strict";
// Coalesce display telemetry BEFORE Node for Max IPC. Never run audio here.
autowatch = 1;
inlets = 1;
outlets = 1;
var enabled = false;
var pending = new Map();
var serial = 0;
var transferSerial = 0;
var wire = [];
var wireIndex = 0;
var flushTask = new Task(flush, this);
var keyed = new Set(['track','channel','sample','assignment','waveform','track_capture','phase_cut','channel_strip','channel_strip_meter','session_missing','color_role','rack_latency']);
var paired = new Set(['grid_level_map','grid_color_map','grid_color_cell','grid_press','pattern_summary','pattern_playhead','rack_state']);
// Inventory begin/item/end must stay ordered and complete across flushes.
var ordered = new Set(['rack_inventory_begin','rack_inventory_item','rack_inventory_end']);
function active(value) {
 enabled = !!Number(value);
 messnamed("mlr_hud_state", "remote_peer", enabled ? 1 : 0);
 flushTask.cancel(); pending.clear(); wire = []; wireIndex = 0;
 if (enabled) flushTask.schedule(50);
}
function enqueue(topic, args) {
 if (!enabled) return;
 var key = ordered.has(topic) ? 'ordered:' + serial++ : topic;
 if (keyed.has(topic)) key += ':' + args[0];
 if (paired.has(topic)) key += ':' + args[0] + ':' + args[1];
 // Preserve last-update order (all-color resets must precede newer cells).
 pending.delete(key); pending.set(key, [topic,args]);
}
function anything() { enqueue(String(messagename), Array.prototype.slice.call(arguments)); }
function flush() {
 if (!enabled) return;
 if (!wire.length && pending.size) {
  var batch = Array.from(pending.values()); pending.clear();
  var json = JSON.stringify(batch);
  // Max symbols truncate near 32767 bytes. 4096 UTF-16 units remain well
  // below that even for multibyte text; chunks rejoin before JSON parsing.
  if (json.length <= 4096) wire = [['batch',json]];
  else {
   var id = ++transferSerial, parts = [], start = 0;
   while (start < json.length) {
    var end = Math.min(start + 4096,json.length);
    var last = json.charCodeAt(end-1);
    if (end < json.length && last >= 0xD800 && last <= 0xDBFF) end--;
    parts.push(json.slice(start,end)); start = end;
   }
   for (var part = 0; part < parts.length; part++) wire.push(['batch_chunk',id,part,parts.length,parts[part]]);
  }
 }
 // Bound snapshot IPC bursts as well as steady playback telemetry.
 for (var sent = 0; sent < 4 && wireIndex < wire.length; sent++,wireIndex++) {
  outlet.apply(this,[0].concat(wire[wireIndex]));
 }
 if (wireIndex >= wire.length) {wire = []; wireIndex = 0;}
 flushTask.schedule(50);
}
function notifydeleted() { flushTask.cancel(); messnamed("mlr_hud_state", "remote_peer", 0); }
