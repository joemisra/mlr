"use strict";

/*
 * Pure Role + State + Motion color compositor.
 *
 * This module has no Max or hardware dependencies. Canonical grid brightness
 * deliberately does not participate in RGB composition: classic-grid output
 * remains identical when semantic color is enabled or disabled.
 */

var OPERATIONS = ["replace", "add", "half_add", "sub", "half_sub", "mul"];

function clampByte(value) {
	var number = Number(value);
	if (!isFinite(number)) number = 0;
	return Math.min(255, Math.max(0, Math.round(number)));
}

function normalizeRgb(rgb) {
	var source = Array.isArray(rgb) || (rgb && typeof rgb.length === "number") ? rgb : [];
	return [clampByte(source[0]), clampByte(source[1]), clampByte(source[2])];
}

function normalizeOperation(operation) {
	var name = String(operation || "").toLowerCase();
	return OPERATIONS.indexOf(name) >= 0 ? name : "replace";
}

function operateChannel(base, operand, operation) {
	var a = clampByte(base);
	var b = clampByte(operand);
	switch (normalizeOperation(operation)) {
		case "add": return Math.min(255, a + b);
		case "half_add": return Math.floor((a + b) / 2);
		case "sub": return Math.max(0, a - b);
		case "half_sub": return Math.floor(Math.max(0, a - b) / 2);
		case "mul": return Math.round(a * b / 255);
		default: return b;
	}
}

function applyOperation(baseRgb, operandRgb, operation) {
	var base = normalizeRgb(baseRgb);
	var operand = normalizeRgb(operandRgb);
	return [
		operateChannel(base[0], operand[0], operation),
		operateChannel(base[1], operand[1], operation),
		operateChannel(base[2], operand[2], operation)
	];
}

function normalizeModifier(modifier) {
	if (!modifier || modifier.enabled === false || modifier.op === "none") return null;
	return {
		op: normalizeOperation(modifier.op),
		rgb: normalizeRgb(modifier.rgb),
		amount: clampByte(modifier.amount === undefined ? 255 : modifier.amount)
	};
}

function applyModifier(baseRgb, modifier) {
	var base = normalizeRgb(baseRgb);
	var normalized = normalizeModifier(modifier);
	if (!normalized || normalized.amount === 0) return base;
	var operated = applyOperation(base, normalized.rgb, normalized.op);
	var amount = normalized.amount / 255;
	return [
		clampByte(base[0] + (operated[0] - base[0]) * amount),
		clampByte(base[1] + (operated[1] - base[1]) * amount),
		clampByte(base[2] + (operated[2] - base[2]) * amount)
	];
}

function compose(roleRgb, stateModifier, motionModifier) {
	return applyModifier(applyModifier(roleRgb, stateModifier), motionModifier);
}

function composeFrame(levels, roles, states, motions) {
	var count = roles && roles.length ? roles.length : 0;
	var frameLevels = new Array(count);
	var colors = new Array(count);
	for (var index = 0; index < count; index++) {
		frameLevels[index] = Math.min(15, Math.max(0,
			Math.round(Number(levels && levels[index]) || 0)));
		colors[index] = compose(roles[index], states && states[index],
			motions && motions[index]);
	}
	return { levels: frameLevels, colors: colors };
}

exports.OPERATIONS = OPERATIONS;
exports.clampByte = clampByte;
exports.normalizeRgb = normalizeRgb;
exports.normalizeOperation = normalizeOperation;
exports.operateChannel = operateChannel;
exports.applyOperation = applyOperation;
exports.normalizeModifier = normalizeModifier;
exports.applyModifier = applyModifier;
exports.compose = compose;
exports.composeFrame = composeFrame;
