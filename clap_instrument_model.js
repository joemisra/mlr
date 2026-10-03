// Physical controls and grid mappings for the RNBO clap.
var CLAP_TRACK = 11; // visible Track 12, native bus 13input
var CLAP_LOCKS = ["clapCount", "clapBurstDecay", "clapSpacing", "clapScatter", "clapTailDecay", "clapFilterHz", "clapBrightness", "clapDrive", "clapBalance", "clapTailLevel", "clapFilterQ", "clapLevel"];
var CLAP_PAGES = [{"name": "Claps", "parameters": ["clapCount", "clapSpacing", "clapBurstDecay", "clapScatter"]}, {"name": "Tone", "parameters": ["clapFilterHz", "clapFilterQ", "clapBrightness", "clapDrive"]}, {"name": "Tail / output", "parameters": ["clapTailDecay", "clapTailLevel", "clapBalance", "clapLevel"]}];
var PARAMETERS = {
  "clapCount": {
    "name": "Burst count",
    "rnbo": "count",
    "min": 1,
    "max": 8,
    "gridMin": 1,
    "gridMax": 6,
    "initial": 3,
    "scale": "linear",
    "fine": 1,
    "unit": ""
  },
  "clapBurstDecay": {
    "name": "Burst decay",
    "rnbo": "burstDecayMs",
    "min": 1,
    "max": 200,
    "gridMin": 3,
    "gridMax": 35,
    "initial": 10,
    "scale": "log",
    "fine": 1,
    "unit": "ms"
  },
  "clapSpacing": {
    "name": "Burst spacing",
    "rnbo": "spacingMs",
    "min": 2,
    "max": 100,
    "gridMin": 5,
    "gridMax": 35,
    "initial": 12,
    "scale": "log",
    "fine": 1,
    "unit": "ms"
  },
  "clapScatter": {
    "name": "Timing scatter",
    "rnbo": "scatter",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.15,
    "scale": "linear",
    "fine": 0.01,
    "unit": ""
  },
  "clapTailDecay": {
    "name": "Tail decay",
    "rnbo": "tailDecayMs",
    "min": 5,
    "max": 10000,
    "gridMin": 40,
    "gridMax": 2000,
    "initial": 280,
    "scale": "log",
    "fine": 5,
    "unit": "ms"
  },
  "clapFilterHz": {
    "name": "Filter frequency",
    "rnbo": "filterHz",
    "min": 100,
    "max": 18000,
    "gridMin": 500,
    "gridMax": 6000,
    "initial": 1600,
    "scale": "log",
    "fine": 25,
    "unit": "Hz"
  },
  "clapBrightness": {
    "name": "Brightness",
    "rnbo": "brightness",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.2,
    "scale": "linear",
    "fine": 0.01,
    "unit": ""
  },
  "clapDrive": {
    "name": "Drive",
    "rnbo": "drive",
    "min": 0.25,
    "max": 8,
    "gridMin": 0.25,
    "gridMax": 6,
    "initial": 1.5,
    "scale": "log",
    "fine": 0.05,
    "unit": ""
  },
  "clapBalance": {
    "name": "Burst / tail balance",
    "rnbo": "balance",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.45,
    "scale": "linear",
    "fine": 0.01,
    "unit": ""
  },
  "clapTailLevel": {
    "name": "Tail level",
    "rnbo": "tailLevel",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.65,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  },
  "clapFilterQ": {
    "name": "Filter Q",
    "rnbo": "filterQ",
    "min": 0.5,
    "max": 20,
    "gridMin": 0.5,
    "gridMax": 8,
    "initial": 1.1,
    "scale": "log",
    "fine": 0.1,
    "unit": ""
  },
  "clapLevel": {
    "name": "Level",
    "rnbo": "level",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.5,
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
  n=Math.max(p.min, Math.min(p.max, n));
  return id === "clapCount" ? Math.round(n) : n;
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
  if (n===0) return clampValue(id,p.min);
  if (n===1) return clampValue(id,p.max);
  if (p.scale==='log') return p.min*Math.pow(p.max/p.min,n);
  if (p.scale==='square') n*=n;
  return clampValue(id,p.min+(p.max-p.min)*n);
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
  CLAP_LOCKS.forEach(function(id){result[id]=clampValue(id,(values||{})[id]);});
  return result;
}
function idForRNBO(name) {
  for (var i=0;i<CLAP_LOCKS.length;i++) if (PARAMETERS[CLAP_LOCKS[i]].rnbo===name) return CLAP_LOCKS[i];
  return null;
}

exports.CLAP_LOCKS=CLAP_LOCKS;
exports.CLAP_PAGES=CLAP_PAGES;
exports.CLAP_TRACK=CLAP_TRACK;
exports.definition=definition;
exports.clampValue=clampValue;
exports.mappingRange=mappingRange;
exports.fromNormalized=fromNormalized;
exports.toNormalized=toNormalized;
exports.sanitize=sanitize;
exports.idForRNBO=idForRNBO;
