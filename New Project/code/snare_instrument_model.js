// Portable parameter definitions for the RNBO snare laboratory.
// Values are physical units; grid ranges are ready for sequencer integration.
var SNARE_TRACK = 13; // zero-based: visible Track 14, native bus 15input
var SNARE_LOCKS = [
  "snareBodyHz", "snareBodyDecay", "snareBodyFM", "snareBodyBend",
  "snareNoiseDecay", "snareNoiseHz", "snareSnap", "snareDrive",
  "snareBodyLevel", "snareNoiseLevel", "snareNoiseQ", "snareLevel"
];

var SNARE_PAGES = [
  {name:"Body", parameters:["snareBodyHz", "snareBodyDecay", "snareBodyBend", "snareBodyFM"]},
  {name:"Noise", parameters:["snareNoiseDecay", "snareNoiseHz", "snareNoiseQ", "snareSnap"]},
  {name:"Mix / output", parameters:["snareBodyLevel", "snareNoiseLevel", "snareDrive", "snareLevel"]}
];

var PARAMETERS = {
  snareBodyHz:    {name:"Body pitch", rnbo:"bodyHz", min:40, max:1200, gridMin:90, gridMax:320, initial:180, scale:"log", fine:1, unit:"Hz"},
  snareBodyDecay: {name:"Body decay", rnbo:"bodyDecayMs", min:5, max:5000, gridMin:30, gridMax:900, initial:180, scale:"log", fine:5, unit:"ms"},
  snareBodyFM:    {name:"Body FM", rnbo:"bodyFM", min:0, max:16, gridMin:0, gridMax:4, initial:0.35, scale:"square", fine:0.01, unit:""},
  snareBodyBend:  {name:"Body bend", rnbo:"bodyBend", min:0, max:1200, gridMin:0, gridMax:500, initial:90, scale:"square", fine:1, unit:"Hz"},
  snareNoiseDecay:{name:"Noise decay", rnbo:"noiseDecayMs", min:5, max:10000, gridMin:30, gridMax:1800, initial:260, scale:"log", fine:5, unit:"ms"},
  snareNoiseHz:   {name:"Noise frequency", rnbo:"noiseHz", min:100, max:18000, gridMin:800, gridMax:12000, initial:3500, scale:"log", fine:25, unit:"Hz"},
  snareSnap:      {name:"Snap", rnbo:"snap", min:0, max:1, gridMin:0, gridMax:1, initial:0.45, scale:"square", fine:0.01, unit:""},
  snareDrive:     {name:"Drive", rnbo:"drive", min:0.25, max:8, gridMin:0.25, gridMax:8, initial:1.7, scale:"log", fine:0.05, unit:""},
  snareBodyLevel: {name:"Body level", rnbo:"bodyLevel", min:0, max:1, gridMin:0, gridMax:1, initial:0.65, scale:"square", fine:0.01, unit:""},
  snareNoiseLevel:{name:"Noise level", rnbo:"noiseLevel", min:0, max:1, gridMin:0, gridMax:1, initial:0.72, scale:"square", fine:0.01, unit:""},
  snareNoiseQ:    {name:"Noise Q", rnbo:"noiseQ", min:0.5, max:20, gridMin:0.5, gridMax:10, initial:1.1, scale:"log", fine:0.1, unit:""},
  snareLevel:     {name:"Level", rnbo:"level", min:0, max:1, gridMin:0, gridMax:1, initial:0.45, scale:"square", fine:0.01, unit:""}
};

function definition(id) { return Object.prototype.hasOwnProperty.call(PARAMETERS, id) ? PARAMETERS[id] : null; }
function clampValue(id, value) {
  var p=definition(id), n=Number(value);
  if (!p) return null;
  if (value===null || value===undefined || value==='' || !isFinite(n)) n=p.initial;
  return Math.max(p.min, Math.min(p.max, n));
}
function mappingRange(id, range) {
  var p=definition(id), lo=range && Number(range.min), hi=range && Number(range.max);
  if (!p) return null;
  if (!range || !isFinite(lo) || !isFinite(hi) || lo>=hi) return {min:p.gridMin,max:p.gridMax};
  lo=Math.max(p.min,Math.min(p.max,lo)); hi=Math.max(p.min,Math.min(p.max,hi));
  return lo<hi ? {min:lo,max:hi} : {min:p.gridMin,max:p.gridMax};
}
function mappingDefinition(id, range) {
  var p=definition(id), r=mappingRange(id,range);
  return p ? {min:r.min,max:r.max,scale:p.scale} : null;
}
function fromNormalized(id, position, range) {
  var p=mappingDefinition(id,range), n=Math.max(0,Math.min(1,Number(position)||0));
  if (!p) return null;
  if (p.scale==='log') return p.min*Math.pow(p.max/p.min,n);
  if (p.scale==='square') n*=n;
  return p.min+(p.max-p.min)*n;
}
function toNormalized(id, value, range) {
  var p=mappingDefinition(id,range), n;
  if (!p) return 0;
  n=Math.max(p.min,Math.min(p.max,clampValue(id,value)));
  if (p.scale==='log') return Math.log(n/p.min)/Math.log(p.max/p.min);
  n=(n-p.min)/(p.max-p.min);
  return p.scale==='square' ? Math.sqrt(n) : n;
}
function sanitize(values) {
  var result={};
  SNARE_LOCKS.forEach(function(id){result[id]=clampValue(id,(values||{})[id]);});
  return result;
}
function idForRNBO(name) {
  for (var i=0;i<SNARE_LOCKS.length;i++) if (PARAMETERS[SNARE_LOCKS[i]].rnbo===name) return SNARE_LOCKS[i];
  return null;
}

exports.SNARE_LOCKS=SNARE_LOCKS;
exports.SNARE_PAGES=SNARE_PAGES;
exports.SNARE_TRACK=SNARE_TRACK;
exports.definition=definition;
exports.clampValue=clampValue;
exports.mappingRange=mappingRange;
exports.fromNormalized=fromNormalized;
exports.toNormalized=toNormalized;
exports.sanitize=sanitize;
exports.idForRNBO=idForRNBO;
