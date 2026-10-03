autowatch = 1;
inlets = 1;
outlets = 2; // status text, ctlin port messages
var Knobs = require('knob_controller_model.js');
var bindings = defaultBindings(1), learning = null, inputPort = 'none';
var bindingStore = new Dict('mlr_knob_bindings');
var knobRuntime = new Global('mlr_knob_input_runtime');
var pendingValues = new Knobs.LatestValues(), pendingFlush = false, lastInputValues = {};
var flushTask = new Task(flush, this);
function clearPending() {
 flushTask.cancel(); pendingFlush = false; pendingValues.clear(); lastInputValues = {};
}
function flush() {
 pendingFlush = false;
 var epoch = knobRuntime.epoch, values = pendingValues.take(epoch);
 if (values.length) messnamed('gridrouter', 'knobBatch', epoch, JSON.stringify(values));
}
function defaultBindings(channel) {
 var result = [];
 for (var i = 0; i < 16; i++) result.push({cc:32 + i,channel:channel});
 return result;
}
function status(text) { outlet(0, 'set', text); }
function loadbang() {
 try { bindings = Knobs.sanitizeBindings(JSON.parse(bindingStore.stringify()).bindings) || bindings; } catch (_) {}
 bindingStore.parse(JSON.stringify({version:1,bindings:bindings}));
 status('CC 32–47 ready (channel 1 by default). Select the controller input port.');
}
function channel(number) {
 var ch = Knobs.midiInteger(number, 1, 16);
 if (ch === null) return;
 clearPending();
 bindings = defaultBindings(ch); learning = null;
 bindingStore.parse(JSON.stringify({version:1,bindings:bindings}));
 messnamed('gridrouter', 'knobReset');
 status('CC 32–47 · channel ' + ch + ' · pickup armed.');
}
function port() {
 var name = arrayfromargs(arguments).join(' ');
 // Never silently listen to all devices, including the DPT MIDI output loop.
 if (!name || name === 'all') return;
 clearPending();
 inputPort = name;
 learning = null;
 outlet(1, 'port', name);
 messnamed('gridrouter', 'knobReset');
 status('Input: ' + name + (bindings ? ' · pickup armed' : ' · learn the 16 knobs'));
}
function learn() {
 if (inputPort === 'none') { status('Select a MIDI input port first.'); return; }
 clearPending();
 learning = [];
 messnamed('gridrouter', 'knobReset');
 status('Learn: move knob 1. Continue in physical order through knob 16.');
}
function cancel() { clearPending(); learning = null; status('Learning cancelled; previous mapping retained.'); }
function cc(value, controller, channel) {
 value = Knobs.midiInteger(value, 0, 127);
 controller = Knobs.midiInteger(controller, 0, 127);
 channel = Knobs.midiInteger(channel, 1, 16);
 if (inputPort === 'none' || value === null || controller === null || channel === null) return;
 if (learning) {
  for (var i = 0; i < learning.length; i++) if (learning[i].cc === controller && learning[i].channel === channel) return;
  learning.push({cc:controller,channel:channel});
  if (learning.length === 16) {
   bindings = Knobs.sanitizeBindings(learning); learning = null;
   bindingStore.parse(JSON.stringify({version:1,bindings:bindings}));
   status('16 knobs learned. Save map to keep this controller setup.');
  } else status('Knob ' + learning.length + ' learned · move knob ' + (learning.length + 1));
  return; // learning must never edit a sound or record locks
 }
 if (!bindings) return;
 for (var k = 0; k < bindings.length; k++) if (bindings[k].cc === controller && bindings[k].channel === channel) {
  var epoch = knobRuntime.epoch;
  if (typeof epoch !== 'number') return; // main MLR router is not loaded
  var bar = knobRuntime.live ? knobRuntime.bar : -1, step = knobRuntime.live ? knobRuntime.step : -1;
  var key = epoch + ':' + bar + ':' + step;
  var previous = lastInputValues[k];
  if (previous && previous.key === key && previous.value === value) return;
  lastInputValues[k] = {key:key,value:value};
  pendingValues.push(k + 1, value, epoch, bar, step);
  if (!pendingFlush) { pendingFlush = true; flushTask.schedule(33); }
  return;
 }
}
function dictionary(name) {
 try {
  var next = Knobs.sanitizeBindings(JSON.parse(new Dict(String(name)).stringify()).bindings);
  if (!next) {
   bindingStore.parse(JSON.stringify({version:1,bindings:bindings}));
   status('Map rejected: need 16 distinct CC/channel pairs.'); return;
  }
  bindings = next; learning = null;
  clearPending();
  bindingStore.parse(JSON.stringify({version:1,bindings:bindings}));
  messnamed('gridrouter', 'knobReset'); status('Controller map loaded · pickup armed.');
 } catch (_) { status('Controller map could not be read.'); }
}
function source(index) { clearPending(); messnamed('gridrouter', 'knobSource', Number(index) === 1 ? 'lab' : 'grid'); }
