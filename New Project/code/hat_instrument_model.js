// Portable physical controls and grid mappings for the RNBO hat.
var HAT_TRACK = 12; // visible Track 13, native bus 14input
var HAT_LOCKS = ["hatPitch", "hatDecay", "hatSpread", "hatInharmonicity", "hatNoiseDecay", "hatFilterHz", "hatAttack", "hatDrive", "hatMetalLevel", "hatNoiseLevel", "hatFilterQ", "hatLevel"];
var HAT_PAGES = [{"name": "Metal", "parameters": ["hatPitch", "hatSpread", "hatInharmonicity", "hatMetalLevel"]}, {"name": "Shape", "parameters": ["hatDecay", "hatNoiseDecay", "hatAttack", "hatNoiseLevel"]}, {"name": "Filter / output", "parameters": ["hatFilterHz", "hatFilterQ", "hatDrive", "hatLevel"]}];
var PARAMETERS = {
  "hatPitch": {
    "name": "Metal pitch",
    "rnbo": "metalHz",
    "min": 100,
    "max": 6000,
    "gridMin": 300,
    "gridMax": 1800,
    "initial": 700,
    "scale": "log",
    "fine": 5,
    "unit": "Hz"
  },
  "hatDecay": {
    "name": "Metal decay",
    "rnbo": "decayMs",
    "min": 5,
    "max": 10000,
    "gridMin": 20,
    "gridMax": 2000,
    "initial": 120,
    "scale": "log",
    "fine": 5,
    "unit": "ms"
  },
  "hatSpread": {
    "name": "Spread",
    "rnbo": "spread",
    "min": 0.1,
    "max": 4,
    "gridMin": 0.4,
    "gridMax": 2.5,
    "initial": 1,
    "scale": "log",
    "fine": 0.01,
    "unit": ""
  },
  "hatInharmonicity": {
    "name": "Inharmonicity",
    "rnbo": "inharmonicity",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.65,
    "scale": "linear",
    "fine": 0.01,
    "unit": ""
  },
  "hatNoiseDecay": {
    "name": "Noise decay",
    "rnbo": "noiseDecayMs",
    "min": 5,
    "max": 10000,
    "gridMin": 15,
    "gridMax": 2000,
    "initial": 85,
    "scale": "log",
    "fine": 5,
    "unit": "ms"
  },
  "hatFilterHz": {
    "name": "Filter frequency",
    "rnbo": "filterHz",
    "min": 100,
    "max": 18000,
    "gridMin": 1500,
    "gridMax": 12000,
    "initial": 6500,
    "scale": "log",
    "fine": 25,
    "unit": "Hz"
  },
  "hatAttack": {
    "name": "Attack",
    "rnbo": "attack",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.4,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  },
  "hatDrive": {
    "name": "Drive",
    "rnbo": "drive",
    "min": 0.25,
    "max": 8,
    "gridMin": 0.25,
    "gridMax": 6,
    "initial": 1.4,
    "scale": "log",
    "fine": 0.05,
    "unit": ""
  },
  "hatMetalLevel": {
    "name": "Metal level",
    "rnbo": "metalLevel",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.7,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  },
  "hatNoiseLevel": {
    "name": "Noise level",
    "rnbo": "noiseLevel",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.55,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  },
  "hatFilterQ": {
    "name": "Filter Q",
    "rnbo": "filterQ",
    "min": 0.5,
    "max": 20,
    "gridMin": 0.5,
    "gridMax": 8,
    "initial": 0.8,
    "scale": "log",
    "fine": 0.1,
    "unit": ""
  },
  "hatLevel": {
    "name": "Level",
    "rnbo": "level",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.4,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  }
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
  if (n===0) return p.min;
  if (n===1) return p.max;
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
  HAT_LOCKS.forEach(function(id){result[id]=clampValue(id,(values||{})[id]);});
  return result;
}
function idForRNBO(name) {
  for (var i=0;i<HAT_LOCKS.length;i++) if (PARAMETERS[HAT_LOCKS[i]].rnbo===name) return HAT_LOCKS[i];
  return null;
}

exports.HAT_LOCKS=HAT_LOCKS;
exports.HAT_PAGES=HAT_PAGES;
exports.HAT_TRACK=HAT_TRACK;
exports.definition=definition;
exports.clampValue=clampValue;
exports.mappingRange=mappingRange;
exports.fromNormalized=fromNormalized;
exports.toNormalized=toNormalized;
exports.sanitize=sanitize;
exports.idForRNBO=idForRNBO;
