"use strict";
// Durable controls only. Event decisions and read heads live in gen~.
var DEFAULTS = { enabled: 0, division: 4, chance: 0.35, range: 4,
 repeat: 0.25, reverse: 0, wet: 1, fade_ms: 6, ramp: 0 };
var CHOICES = { enabled: [0,1], division: [1,2,3,4,6,8,12,16], chance: [0,0.1,0.25,0.35,0.5,0.75,1],
 range: [0,1,2,4,8,16], repeat: [0,0.1,0.25,0.5,0.75,1], reverse: [0,0.1,0.25,0.5,1],
 wet: [0,0.25,0.5,0.75,1], fade_ms: [2,4,6,10,20], ramp: [0,1,2] };
var FACTORIES = [
 { name: "NUDGE", values: {division:2,chance:0.25,range:2,repeat:0,reverse:0,wet:1,fade_ms:6,ramp:0} },
 { name: "SHUFFLE", values: {division:4,chance:0.35,range:4,repeat:0.25,reverse:0,wet:1,fade_ms:6,ramp:0} },
 { name: "STUTTER", values: {division:8,chance:0.75,range:0,repeat:1,reverse:0,wet:1,fade_ms:4,ramp:0} },
 { name: "FRACTURE", values: {division:4,chance:0.75,range:16,repeat:0.5,reverse:0.25,wet:1,fade_ms:6,ramp:0} }
];
function parameters(source) {
 var result = {}; source = source || {};
 Object.keys(DEFAULTS).forEach(function(key) {
  var value = source[key] === undefined ? DEFAULTS[key] : Number(source[key]);
  if (!isFinite(value)) value = DEFAULTS[key];
  var choices = CHOICES[key];
  if (key === "division" || key === "enabled" || key === "ramp") {
   if (choices.indexOf(value) < 0) value = DEFAULTS[key];
  } else value = Math.max(choices[0], Math.min(choices[choices.length - 1], value));
  if (key === "range") value = Math.round(value);
  result[key] = value;
 });
 return result;
}
function sanitize(source) {
 source = source || {};
 var result = parameters(source);
 result.presets = Array.from({length:4}, function(_,i) {
  return source.presets && source.presets[i] ? parameters(source.presets[i]) : null;
 });
 return result;
}
// The first trial's sessions/presets omit ramp; they retain flat slices.
function validParameters(source) {
 if (!source || typeof source !== "object" || Array.isArray(source)) return false;
 var p = parameters(source);
 return Object.keys(DEFAULTS).every(function(k) {
  if (k === "ramp" && source[k] === undefined) return true;
  return typeof source[k] === "number" && source[k] === p[k];
 });
}
function valid(source) {
 if (!validParameters(source)) return false;
 if (Object.keys(source).some(function(k){return k !== "presets" && !Object.prototype.hasOwnProperty.call(DEFAULTS,k);})) return false;
 return Array.isArray(source.presets) && source.presets.length === 4 && source.presets.every(function(s) {
  if (s === null) return true;
  return validParameters(s) && Object.keys(s).every(function(k){return Object.prototype.hasOwnProperty.call(DEFAULTS,k);});
 });
}
function rateLabel(division) {
 return ({1:"1/4",2:"1/8",3:"1/8T",4:"1/16",6:"1/16T",8:"1/32",12:"1/32T",16:"1/64"})[division] || "—";
}
exports.DEFAULTS=DEFAULTS; exports.CHOICES=CHOICES; exports.FACTORIES=FACTORIES;
exports.parameters=parameters; exports.sanitize=sanitize; exports.valid=valid; exports.rateLabel=rateLabel;
