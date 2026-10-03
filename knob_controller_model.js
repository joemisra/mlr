// Workstation/controller state only. Never serialize this into an MLR session.
function midiInteger(value, min, max) {
 var n = Number(value);
 return value !== null && value !== '' && isFinite(n) && Math.floor(n) === n && n >= min && n <= max ? n : null;
}
function sanitizeBindings(values) {
 if (!Array.isArray(values) || values.length !== 16) return null;
 var seen = {}, result = [];
 for (var i = 0; i < 16; i++) {
  var v = values[i], cc = v && midiInteger(v.cc, 0, 127), channel = v && midiInteger(v.channel, 1, 16);
  if (cc === null || channel === null || !v || seen[channel + ':' + cc]) return null;
  seen[channel + ':' + cc] = true;
  result.push({cc:cc, channel:channel});
 }
 return result;
}
function Pickup() { this.reset(); }
Pickup.prototype.reset = function() { this.slots = {}; };
Pickup.prototype.move = function(index, raw, target, signature) {
 raw = midiInteger(raw, 0, 127);
 if (raw === null || !isFinite(target) || target < 0 || target > 1) return {accepted:false};
 var n = raw / 127, slot = this.slots[index];
 // Value changes outside this controller (preset, mouse, grid, undo) re-arm.
 if (!slot || slot.signature !== signature || Math.abs(slot.target - target) > 1e-9) {
  slot = {signature:signature,target:target,previous:null,caught:false};
  this.slots[index] = slot;
 }
 var near = Math.abs(n - target) <= 1 / 127;
 var crossed = slot.previous !== null && (slot.previous - target) * (n - target) <= 0;
 slot.caught = slot.caught || near || crossed;
 var changed = slot.previous !== n;
 slot.previous = n;
 return {accepted:slot.caught && changed, normalized:n, direction:n < target ? 'up' : 'down', caught:slot.caught};
};
// Remember the actual mapped value (important for integer/rounded parameters).
Pickup.prototype.commit = function(index, normalized) { if (this.slots[index]) this.slots[index].target = normalized; };
exports.midiInteger = midiInteger;
exports.sanitizeBindings = sanitizeBindings;
exports.Pickup = Pickup;

// Bounded latest-value mailbox: never accumulate a FIFO of knob movements.
// Retain the first endpoint too, so a fast sweep can still cross pickup.
function LatestValues() { this.clear(); }
LatestValues.prototype.clear = function() { this.values = {}; this.epoch = null; };
LatestValues.prototype.push = function(index, value, epoch, bar, step) {
 if (this.epoch !== epoch) { this.clear(); this.epoch = epoch; }
 var old = this.values[index];
 if (!old || old.bar !== bar || old.step !== step) {
  this.values[index] = {knob:index,first:value,last:value,bar:bar,step:step};
 } else old.last = value;
};
LatestValues.prototype.take = function(epoch) {
 var result = [];
 if (this.epoch === epoch) for (var index in this.values) result.push(this.values[index]);
 this.clear();
 return result;
};
exports.LatestValues = LatestValues;
