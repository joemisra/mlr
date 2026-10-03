"use strict";

/*
 * Portable modulation configuration model.
 *
 * This module contains no Max APIs and deliberately does not generate
 * continuous values.  Native Max objects own signal-rate modulation; this
 * model owns durable source settings, route identity, and validation.
 */

var SOURCE_IDS = ["lfo1", "lfo2", "adsr", "ar"];
var PARAMETER_IDS = ["filter"];
var LFO_SHAPES = ["sine", "triangle", "saw", "square", "random"];
var POLARITIES = ["bipolar", "unipolar"];
var RESET_MODES = ["free", "transport"];

function isObject(value) {
	return !!value && typeof value === "object" && !Array.isArray(value);
}

function clone(value) {
	return value === undefined ? undefined : JSON.parse(JSON.stringify(value));
}

function clamp(value, minimum, maximum, fallback) {
	var number = Number(value);
	if (!isFinite(number)) number = fallback === undefined ? minimum : fallback;
	return Math.min(maximum, Math.max(minimum, number));
}

function integer(value, fallback) {
	var parsed = parseInt(value, 10);
	return isFinite(parsed) ? parsed : fallback;
}

function oneOf(value, choices, fallback) {
	var text = String(value || "").toLowerCase();
	return choices.indexOf(text) >= 0 ? text : fallback;
}

function defaultSource(sourceId) {
	var id = String(sourceId || "").toLowerCase();
	if (id === "lfo1" || id === "lfo2") {
		return {
			type: "lfo",
			rate: [1, id === "lfo1" ? 4 : 8],
			shape: "sine",
			phase: 0,
			polarity: "bipolar",
			reset: "free"
		};
	}
	if (id === "adsr") {
		return { type: "adsr", attack: 10, decay: 120, sustain: 0.7, release: 250 };
	}
	if (id === "ar") {
		return { type: "ar", attack: 10, release: 250, curve: "linear" };
	}
	return { type: "unknown", enabled: false };
}

function sanitizeRate(value, fallback) {
	var source = Array.isArray(value) ? value : fallback;
	return [
		Math.max(1, integer(source && source[0], 1)),
		Math.max(1, integer(source && source[1], 4))
	];
}

function sanitizeSource(sourceId, value) {
	var id = String(sourceId || "").toLowerCase();
	var source = isObject(value) ? value : {};
	var defaults = defaultSource(id);
	var result = clone(defaults);
	if (id === "lfo1" || id === "lfo2") {
		result.rate = sanitizeRate(source.rate, defaults.rate);
		result.shape = oneOf(source.shape, LFO_SHAPES, defaults.shape);
		result.phase = clamp(source.phase, 0, 1, defaults.phase);
		result.polarity = oneOf(source.polarity, POLARITIES, defaults.polarity);
		result.reset = oneOf(source.reset, RESET_MODES, defaults.reset);
	} else if (id === "adsr") {
		result.attack = clamp(source.attack, 0.1, 60000, defaults.attack);
		result.decay = clamp(source.decay, 0.1, 60000, defaults.decay);
		result.sustain = clamp(source.sustain, 0, 1, defaults.sustain);
		result.release = clamp(source.release, 0.1, 60000, defaults.release);
	} else if (id === "ar") {
		result.attack = clamp(source.attack, 0.1, 60000, defaults.attack);
		result.release = clamp(source.release, 0.1, 60000, defaults.release);
		result.curve = String(source.curve || defaults.curve);
	} else {
		// Preserve future ASL/custom descriptors without allowing an older build
		// to activate a source it does not understand.
		result = clone(source);
		result.type = String(source.type || "unknown");
		result.enabled = false;
	}
	return result;
}

function sourceKey(scope, targetId, sourceId) {
	return String(scope || "") + ":" + integer(targetId, -1) + ":" +
		String(sourceId || "").toLowerCase();
}

function validTarget(scope, targetId) {
	var id = integer(targetId, -1);
	return (scope === "group" && id >= 0 && id < 8) ||
		(scope === "track" && id >= 0 && id < 16);
}

function sanitizeRoute(value) {
	var source = isObject(value) ? value : {};
	var scope = String(source.scope || "").toLowerCase();
	var targetId = integer(source.targetId, -1);
	var parameterId = String(source.parameterId || "").toLowerCase();
	var sourceId = String(source.sourceId || "").toLowerCase();
	var known = validTarget(scope, targetId) &&
		SOURCE_IDS.indexOf(sourceId) >= 0 && PARAMETER_IDS.indexOf(parameterId) >= 0;
	return {
		scope: scope,
		targetId: targetId,
		parameterId: parameterId,
		sourceId: sourceId,
		amount: clamp(source.amount, -1, 1, 0),
		enabled: known && source.enabled !== false
	};
}

function routeKey(route) {
	return route.scope + ":" + route.targetId + ":" + route.parameterId + ":" + route.sourceId;
}

function createState() {
	return { sources: {}, routes: [] };
}

function sanitizeState(value) {
	var source = isObject(value) ? value : {};
	var result = createState();
	var sources = isObject(source.sources) ? source.sources : {};
	Object.keys(sources).forEach(function (key) {
		var parts = key.split(":");
		if (parts.length < 3) return;
		var scope = parts[0];
		var targetId = integer(parts[1], -1);
		var sourceId = parts.slice(2).join(":").toLowerCase();
		if (!validTarget(scope, targetId)) return;
		result.sources[sourceKey(scope, targetId, sourceId)] = sanitizeSource(sourceId, sources[key]);
	});
	var routes = Array.isArray(source.routes) ? source.routes : [];
	var indices = {};
	for (var index = 0; index < routes.length; index++) {
		var route = sanitizeRoute(routes[index]);
		if (!validTarget(route.scope, route.targetId) || !route.sourceId || !route.parameterId) continue;
		var key = routeKey(route);
		if (indices[key] === undefined) {
			indices[key] = result.routes.length;
			result.routes.push(route);
		} else result.routes[indices[key]] = route;
	}
	return result;
}

function setSource(state, scope, targetId, sourceId, value) {
	var result = sanitizeState(state);
	if (!validTarget(scope, targetId) || !sourceId) return result;
	result.sources[sourceKey(scope, targetId, sourceId)] = sanitizeSource(sourceId, value);
	return result;
}

function setRoute(state, value) {
	var result = sanitizeState(state);
	var route = sanitizeRoute(value);
	if (!validTarget(route.scope, route.targetId) || !route.sourceId || !route.parameterId) return result;
	var key = routeKey(route);
	var replaced = false;
	for (var index = 0; index < result.routes.length; index++) {
		if (routeKey(result.routes[index]) === key) {
			result.routes[index] = route;
			replaced = true;
			break;
		}
	}
	if (!replaced) result.routes.push(route);
	var sourceName = sourceKey(route.scope, route.targetId, route.sourceId);
	if (!result.sources[sourceName]) {
		result.sources[sourceName] = sanitizeSource(route.sourceId, {});
	}
	return result;
}

function clearRoute(state, scope, targetId, parameterId, sourceId) {
	var result = sanitizeState(state);
	var key = [scope, integer(targetId, -1), String(parameterId || "").toLowerCase(),
		String(sourceId || "").toLowerCase()].join(":");
	result.routes = result.routes.filter(function (route) { return routeKey(route) !== key; });
	return result;
}

module.exports = {
	SOURCE_IDS: SOURCE_IDS,
	PARAMETER_IDS: PARAMETER_IDS,
	createState: createState,
	defaultSource: defaultSource,
	sanitizeSource: sanitizeSource,
	sanitizeRoute: sanitizeRoute,
	sanitizeState: sanitizeState,
	setSource: setSource,
	setRoute: setRoute,
	clearRoute: clearRoute,
	sourceKey: sourceKey,
	routeKey: routeKey,
	validTarget: validTarget,
	clone: clone
};
