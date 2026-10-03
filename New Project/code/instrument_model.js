// Portable instrument parameter definitions. Values are stored in physical
// units; grid columns and controller positions are only input mappings.
var KICK_TRACK = 14; // zero-based: visible Track 15, native bus 16input
var KICK_LOCKS = ["kickPitch", "kickDecay", "kickFM", "kickSweep", "kickSweepDecay", "kickFMRatio", "kickClick", "kickDrive", "kickResMix", "kickResHz", "kickResQ", "kickLevel"];
var KICK_PAGES = [
  {
    "name": "Body",
    "parameters": [
      "kickPitch",
      "kickDecay",
      "kickSweep",
      "kickSweepDecay"
    ]
  },
  {
    "name": "FM / attack",
    "parameters": [
      "kickFM",
      "kickFMRatio",
      "kickClick",
      "kickDrive"
    ]
  },
  {
    "name": "Resonator / output",
    "parameters": [
      "kickResMix",
      "kickResHz",
      "kickResQ",
      "kickLevel"
    ]
  }
];
var PARAMETERS = {
  "kickPitch": {
    "name": "Pitch",
    "rnbo": "baseHz",
    "min": 10,
    "max": 2000,
    "gridMin": 20,
    "gridMax": 120,
    "initial": 48,
    "scale": "log",
    "fine": 0.5,
    "unit": "Hz"
  },
  "kickDecay": {
    "name": "Decay",
    "rnbo": "ampDecayMs",
    "min": 1,
    "max": 30000,
    "gridMin": 20,
    "gridMax": 2000,
    "initial": 620,
    "scale": "log",
    "fine": 5,
    "unit": "ms"
  },
  "kickFM": {
    "name": "FM",
    "rnbo": "fmIndex",
    "min": 0,
    "max": 32,
    "gridMin": 0,
    "gridMax": 4,
    "initial": 0.15,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  },
  "kickSweep": {
    "name": "Sweep",
    "rnbo": "pitchAmount",
    "min": 0,
    "max": 600,
    "gridMin": 0,
    "gridMax": 600,
    "initial": 150,
    "scale": "square",
    "fine": 1,
    "unit": "Hz"
  },
  "kickSweepDecay": {
    "name": "Sweep decay",
    "rnbo": "pitchDecayMs",
    "min": 1,
    "max": 300,
    "gridMin": 1,
    "gridMax": 300,
    "initial": 32,
    "scale": "log",
    "fine": 1,
    "unit": "ms"
  },
  "kickFMRatio": {
    "name": "FM ratio",
    "rnbo": "fmRatio",
    "min": 0.125,
    "max": 8,
    "gridMin": 0.125,
    "gridMax": 8,
    "initial": 1.5,
    "scale": "log",
    "fine": 0.025,
    "unit": ""
  },
  "kickClick": {
    "name": "Click",
    "rnbo": "clickLevel",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.08,
    "scale": "square",
    "fine": 0.01,
    "unit": ""
  },
  "kickDrive": {
    "name": "Drive",
    "rnbo": "drive",
    "min": 0.25,
    "max": 8,
    "gridMin": 0.25,
    "gridMax": 8,
    "initial": 1.8,
    "scale": "log",
    "fine": 0.05,
    "unit": ""
  },
  "kickResMix": {
    "name": "Res mix",
    "rnbo": "resonMix",
    "min": 0,
    "max": 1,
    "gridMin": 0,
    "gridMax": 1,
    "initial": 0.22,
    "scale": "linear",
    "fine": 0.01,
    "unit": ""
  },
  "kickResHz": {
    "name": "Res frequency",
    "rnbo": "resonHz",
    "min": 25,
    "max": 400,
    "gridMin": 25,
    "gridMax": 400,
    "initial": 58,
    "scale": "log",
    "fine": 0.5,
    "unit": "Hz"
  },
  "kickResQ": {
    "name": "Res Q",
    "rnbo": "resonQ",
    "min": 0.5,
    "max": 24,
    "gridMin": 0.5,
    "gridMax": 24,
    "initial": 8,
    "scale": "log",
    "fine": 0.1,
    "unit": ""
  },
  "kickLevel": {
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
	var p = definition(id);
	if (!p) return null;
	var n = Number(value);
	if (value === null || value === undefined || value === '' || !isFinite(n)) n = p.initial;
	return Math.max(p.min, Math.min(p.max, n));
}
function mappingRange(id, range) {
	var p = definition(id);
	if (!p) return null;
	var lo = range && Number(range.min), hi = range && Number(range.max);
	if (!range || !isFinite(lo) || !isFinite(hi) || lo >= hi) return {min:p.gridMin,max:p.gridMax};
	lo = Math.max(p.min, Math.min(p.max, lo));
	hi = Math.max(p.min, Math.min(p.max, hi));
	return lo < hi ? {min:lo,max:hi} : {min:p.gridMin,max:p.gridMax};
}
function mappingDefinition(id, range) {
	var p = definition(id), r = mappingRange(id, range);
	return p ? {min:r.min,max:r.max,scale:p.scale} : null;
}
function fromNormalized(id, position, range) {
	var p = mappingDefinition(id, range);
	if (!p) return null;
	var n = Math.max(0, Math.min(1, Number(position) || 0));
	if (p.scale === 'log') return p.min * Math.pow(p.max / p.min, n);
	if (p.scale === 'square') n *= n;
	return p.min + (p.max - p.min) * n;
}
function toNormalized(id, value, range) {
	var p = mappingDefinition(id, range);
	if (!p) return 0;
	var n = Math.max(p.min, Math.min(p.max, clampValue(id, value)));
	if (p.scale === 'log') return Math.log(n / p.min) / Math.log(p.max / p.min);
	n = (n - p.min) / (p.max - p.min);
	return p.scale === 'square' ? Math.sqrt(n) : n;
}
function sanitize(values) {
	var result = {};
	KICK_LOCKS.forEach(function (id) { result[id] = clampValue(id, (values || {})[id]); });
	return result;
}
function idForRNBO(name) {
	for (var i = 0; i < KICK_LOCKS.length; i++) {
		if (PARAMETERS[KICK_LOCKS[i]].rnbo === name) return KICK_LOCKS[i];
	}
	return null;
}
exports.KICK_TRACK = KICK_TRACK;
exports.KICK_LOCKS = KICK_LOCKS;
exports.definition = definition;
exports.clampValue = clampValue;
exports.fromNormalized = fromNormalized;
exports.toNormalized = toNormalized;
exports.sanitize = sanitize;
exports.idForRNBO = idForRNBO;

exports.mappingRange = mappingRange;

exports.KICK_PAGES = KICK_PAGES;
