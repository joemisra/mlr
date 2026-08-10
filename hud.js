"use strict";

autowatch = 1;
inlets = 1;
outlets = 1;

var Model = require("hud_model.js");
var state = Model.createState();
var hitRegions = [];
var hoveredRegion = null;
var redrawPending = false;
var lastPointerX = -1;
var lastPointerY = -1;
var lastClickRegionId = "";
var lastClickTime = 0;

mgraphics.init();
mgraphics.autofill = 0;
mgraphics.relative_coords = 0;

var redrawTask = new Task(flushRedraw, this);

function flushRedraw() {
	redrawPending = false;
	mgraphics.redraw();
}

function scheduleRedraw(immediate) {
	if (immediate) {
		redrawTask.cancel();
		redrawPending = false;
		mgraphics.redraw();
		return;
	}
	if (redrawPending) return;
	redrawPending = true;
	redrawTask.schedule(33);
}

function rgb(source, alpha) {
	var color = source || [255, 255, 255];
	return [color[0] / 255, color[1] / 255, color[2] / 255,
		alpha === undefined ? 1 : alpha];
}

function setColor(color, alpha) {
	var value = rgb(color, alpha);
	mgraphics.set_source_rgba(value[0], value[1], value[2], value[3]);
}

function fillRect(x, y, width, height, color, alpha) {
	setColor(color, alpha);
	mgraphics.rectangle(x, y, Math.max(0, width), Math.max(0, height));
	mgraphics.fill();
}

function strokeRect(x, y, width, height, color, lineWidth, alpha) {
	setColor(color, alpha);
	mgraphics.set_line_width(lineWidth || 1);
	mgraphics.rectangle(x + 0.5, y + 0.5, Math.max(0, width - 1), Math.max(0, height - 1));
	mgraphics.stroke();
}

function line(x1, y1, x2, y2, color, lineWidth, alpha) {
	setColor(color, alpha);
	mgraphics.set_line_width(lineWidth || 1);
	mgraphics.move_to(x1, y1);
	mgraphics.line_to(x2, y2);
	mgraphics.stroke();
}

function text(value, x, y, size, color, bold) {
	setColor(color || Model.COLORS.text);
	mgraphics.select_font_face(bold ? "Arial Bold" : "Arial");
	mgraphics.set_font_size(size || 12);
	mgraphics.move_to(x, y);
	mgraphics.show_text(String(value));
}

function mono(value, x, y, size, color, bold) {
	setColor(color || Model.COLORS.text);
	mgraphics.select_font_face(bold ? "Menlo Bold" : "Menlo");
	mgraphics.set_font_size(size || 11);
	mgraphics.move_to(x, y);
	mgraphics.show_text(String(value));
}

function label(value, x, y, color) {
	mono(String(value).toUpperCase(), x, y, 9, color || Model.COLORS.dimText, true);
}

function ellipsis(value, maximum) {
	var string = String(value || "");
	return string.length > maximum ? string.substring(0, Math.max(1, maximum - 1)) + "…" : string;
}

function addHit(id, x, y, width, height, payload) {
	hitRegions.push(Model.hitRegion(id, x, y, width, height, payload));
}

function regionAt(x, y) {
	return Model.regionAt(hitRegions, x, y);
}

function button(id, title, x, y, width, height, active, color, payload) {
	var hovered = hoveredRegion && hoveredRegion.id === id;
	var base = active ? (color || Model.COLORS.cyan) : Model.COLORS.panelRaised;
	fillRect(x, y, width, height, base, active ? 0.34 : (hovered ? 1 : 0.72));
	strokeRect(x, y, width, height, active ? base : Model.COLORS.line, 1, hovered ? 1 : 0.8);
	mono(title, x + 7, y + height * 0.64, Math.max(9, Math.min(12, height * 0.44)),
		active ? Model.COLORS.white : Model.COLORS.text, active);
	addHit(id, x, y, width, height, payload);
}

function pageLayout() {
	var size = mgraphics.size;
	var width = Math.max(480, size[0]);
	var height = Math.max(320, size[1]);
	return {
		width: width,
		height: height,
		header: 48,
		margin: 12,
		contentX: 12,
		contentY: 60,
		contentWidth: width - 24,
		contentHeight: height - 72,
		compact: width < 620 || height < 400
	};
}

function drawHeader(layout) {
	fillRect(0, 0, layout.width, layout.header, Model.COLORS.panel);
	line(0, layout.header - 1, layout.width, layout.header - 1, Model.COLORS.line, 1);
	mono("MLR", 14, 20, 14, Model.COLORS.white, true);
	mono("ṛta · ऋत", 14, 37, 9, Model.COLORS.cyan, true);
	var tabX = layout.compact ? 50 : 68;
	var tabGap = 3;
	var statusReserve = layout.width >= 650 ? 160 : (layout.width >= 540 ? 76 : 0);
	var tabWidth = Math.min(layout.compact ? 57 : 68,
		Math.floor((layout.width - tabX - statusReserve - 8 -
			tabGap * (Model.HUD_PAGES.length - 1)) / Model.HUD_PAGES.length));
	for (var index = 0; index < Model.HUD_PAGES.length; index++) {
		var page = Model.HUD_PAGES[index];
		var pageTitle = page === "pattern" ? "ṛta" : page.toUpperCase();
		button("tab:" + page, pageTitle, tabX + index * (tabWidth + tabGap), 10,
			tabWidth, 28, state.page === page, Model.COLORS.cyan, { action: "page", page: page });
	}
	var statusX = tabX + Model.HUD_PAGES.length * tabWidth +
		(Model.HUD_PAGES.length - 1) * tabGap + 8;
	if (statusX + 118 < layout.width) {
		mono(Math.round(state.bpm) + " BPM", statusX, 21, 10, Model.COLORS.text, true);
		mono("Q " + state.quantize, statusX, 37, 9, Model.COLORS.dimText);
		var modeX = statusX + (layout.compact ? 62 : 72);
		mono(Model.modeName(state.mode, state.editor), modeX, 21, 10,
			state.mode === 2 ? Model.COLORS.red : Model.COLORS.cyan, true);
		if (!layout.compact) mono(Model.targetLabel(state.editor.targetType, state.editor.targetId),
			modeX, 37, 9, Model.COLORS.dimText);
		var running = state.pattern && state.pattern.running;
		if (!layout.compact) mono(running ? "RUN" : "STOP", statusX + 151, 21, 10,
			running ? Model.COLORS.green : Model.COLORS.red, true);
	}
	if (layout.width > 840) {
		var noticeColor = state.noticeLevel === "error" ? Model.COLORS.red :
			(state.noticeLevel === "warn" ? Model.COLORS.amber : Model.COLORS.dimText);
		mono(ellipsis(state.notice, 34), layout.width - 245, 29, 9, noticeColor);
	} else if (state.notice && layout.width >= 620) {
		var compactNoticeColor = state.noticeLevel === "error" ? Model.COLORS.red :
			(state.noticeLevel === "warn" ? Model.COLORS.amber : Model.COLORS.dimText);
		mono(ellipsis(state.notice, 18), layout.width - 132, 39, 8, compactNoticeColor);
	}
}

function drawGrid(x, y, size, interactiveHelp) {
	var gap = Math.max(1, Math.floor(size / 120));
	var cell = (size - gap * 15) / 16;
	fillRect(x - 6, y - 6, size + 12, size + 12, Model.COLORS.panel);
	strokeRect(x - 6, y - 6, size + 12, size + 12, Model.COLORS.line, 1);
	for (var row = 0; row < 16; row++) {
		for (var col = 0; col < 16; col++) {
			var index = Model.gridIndex(col, row);
			var level = state.grid.levels[index] / 15;
			var color = state.grid.colors[index] || Model.COLORS.cyan;
			var alpha = 0.08 + level * 0.92;
			var px = x + col * (cell + gap);
			var py = y + row * (cell + gap);
			fillRect(px, py, cell, cell, color, alpha);
			strokeRect(px, py, cell, cell, color, 1, 0.18 + level * 0.5);
			if (state.grid.pressed[col + ":" + row]) {
				strokeRect(px - 1, py - 1, cell + 2, cell + 2, Model.COLORS.white, 2, 1);
			}
			if (interactiveHelp) addHit("grid:" + col + ":" + row, px, py, cell, cell,
				{ action: "grid_hover", x: col, y: row });
		}
	}
	return { cell: cell, gap: gap };
}

function drawLivePage(layout) {
	var sideWidth = layout.compact ? 170 : Math.min(250, layout.contentWidth * 0.34);
	var gridSize = Math.min(layout.contentHeight - 4, layout.contentWidth - sideWidth - 20);
	gridSize = Math.max(220, gridSize);
	drawGrid(layout.contentX + 6, layout.contentY + 6, gridSize - 12, true);
	var sideX = layout.contentX + gridSize + 10;
	var sideY = layout.contentY;
	var sideH = layout.contentHeight;
	fillRect(sideX, sideY, layout.width - sideX - 12, sideH, Model.COLORS.panel);
	strokeRect(sideX, sideY, layout.width - sideX - 12, sideH, Model.COLORS.line, 1);
	label("Live context", sideX + 12, sideY + 19, Model.COLORS.cyan);
	var activeGroup = state.editor.targetType === "group" ? state.editor.targetId : -1;
	var activeTrack = state.editor.targetType === "track" ? state.editor.targetId : -1;
	if (activeTrack < 0 && activeGroup >= 0 && state.channels[activeGroup]) {
		activeTrack = state.channels[activeGroup].activeTrack;
	}
	mono(Model.targetLabel(state.editor.targetType, state.editor.targetId), sideX + 12, sideY + 43,
		15, Model.COLORS.white, true);
	if (activeTrack >= 0 && state.tracks[activeTrack]) {
		var track = state.tracks[activeTrack];
		var assignment = state.bank.assignments[activeTrack];
		label("Active track", sideX + 12, sideY + 72);
		mono("TRACK " + (activeTrack + 1) + "  GROUP " + (track.group + 1), sideX + 12,
			sideY + 91, 11, Model.GROUP_COLORS[track.group], true);
		label("Sample", sideX + 12, sideY + 118);
		mono(ellipsis(Model.sampleLabel(state, assignment), 28), sideX + 12, sideY + 138,
			11, Model.COLORS.text, true);
		mono("SLICE " + (track.position + 1) + " / " + track.length, sideX + 12, sideY + 158,
			10, Model.COLORS.dimText);
	}
	label("ṛta pattern / phrase", sideX + 12, sideY + 184);
	mono((state.pattern.running ? "RUNNING" : "STOPPED") + "  " +
		Model.rateLabel(state.pattern.rateNumerator, state.pattern.rateDenominator),
		sideX + 12, sideY + 204, 10,
		state.pattern.running ? Model.COLORS.green : Model.COLORS.dimText, true);
	mono(state.pattern.playheadStep >= 0 ?
		("BAR " + (state.pattern.playheadBar + 1) + "  STEP " + (state.pattern.playheadStep + 1)) :
		"NO PLAYHEAD", sideX + 12, sideY + 222, 9, Model.COLORS.dimText);
	if (!layout.compact) {
		var context = state.hover && state.hover.action === "grid_hover" ?
			Model.describeCell(state.mode, state.hover.x, state.hover.y, state.editor, "follow") :
			(state.grid.lastPress ? Model.describeCell(state.mode, state.grid.lastPress.x,
				state.grid.lastPress.y, state.editor, "follow") : null);
		var helpY = Math.max(sideY + 196, sideY + sideH - 116);
		line(sideX + 12, helpY - 17, layout.width - 24, helpY - 17, Model.COLORS.line, 1);
		label("Last / hovered control", sideX + 12, helpY);
		mono(context ? context.title : "MOVE OVER THE GRID", sideX + 12, helpY + 24, 10,
			Model.COLORS.white, true);
		text(context ? ellipsis(context.detail, 39) : "The virtual grid monitors hardware only.",
			sideX + 12, helpY + 47, 11, Model.COLORS.dimText);
		text(context ? ellipsis(context.detail.substring(39), 39) : "", sideX + 12,
			helpY + 65, 11, Model.COLORS.dimText);
	}
	button("display_recover", "CAPTURE + REINIT GRID", sideX + 10,
		sideY + sideH - 31, layout.width - sideX - 32, 24, false,
		Model.COLORS.red, { action: "command", command: "display_recover" });
}

function stepColor(step) {
	if (!step) return Model.COLORS.panelRaised;
	if (step.cut && step.lockCount) return Model.COLORS.purple;
	if (step.cut && step.gateLength > 1) return Model.COLORS.green;
	if (step.cut) return Model.COLORS.cyan;
	if (step.lockCount) return Model.COLORS.amber;
	return Model.COLORS.panelRaised;
}

function decisionOutcomeColor(outcome) {
	var role = state.colorLab.roles["rta." + String(outcome || "")];
	if (role && role.color) return role.color;
	if (outcome === "conditionPlay") return [255, 135, 25];
	if (outcome === "conditionSkip") return [255, 45, 55];
	if (outcome === "probabilityPlay") return [255, 225, 35];
	if (outcome === "probabilitySkip") return [185, 70, 255];
	return Model.COLORS.white;
}

function decisionOutcomeLabel(outcome) {
	if (outcome === "conditionPlay") return "COND PLAY";
	if (outcome === "conditionSkip") return "COND SKIP";
	if (outcome === "probabilityPlay") return "PROB PLAY";
	if (outcome === "probabilitySkip") return "PROB SKIP";
	return "";
}

function gateTailAt(pattern, stepIndex) {
	for (var sourceIndex = Math.max(0, stepIndex - 63); sourceIndex < stepIndex; sourceIndex++) {
		var source = pattern.steps[sourceIndex];
		if (source && source.cut && source.gateLength > stepIndex - sourceIndex) return true;
	}
	return false;
}

function drawPatternPage(layout) {
	var x = layout.contentX;
	var y = layout.contentY;
	var width = layout.contentWidth;
	var selectorH = 58;
	fillRect(x, y, width, selectorH, Model.COLORS.panel);
	strokeRect(x, y, width, selectorH, Model.COLORS.line, 1);
	label("Groups", x + 8, y + 14);
	var groupButtonW = Math.min(34, (width * 0.42 - 12) / 8);
	for (var group = 0; group < 8; group++) {
		button("target:group:" + group, String(group + 1), x + 8 + group * groupButtonW,
			y + 22, groupButtonW - 2, 27,
			state.editor.targetType === "group" && state.editor.targetId === group,
			Model.GROUP_COLORS[group], { action: "target", type: "group", id: group });
	}
	var trackX = x + width * 0.44;
	label("Tracks", trackX, y + 14);
	var trackButtonW = Math.max(12, (width * 0.56 - 8) / 16);
	for (var targetTrack = 0; targetTrack < 16; targetTrack++) {
		button("target:track:" + targetTrack, String(targetTrack + 1),
			trackX + targetTrack * trackButtonW, y + 22, trackButtonW - 2, 27,
			state.editor.targetType === "track" && state.editor.targetId === targetTrack,
			Model.COLORS.red, { action: "target", type: "track", id: targetTrack });
	}

	var controlY = y + selectorH + 8;
	var pattern = state.pattern;
	mono("ṛta · ऋत  " + Model.targetLabel(pattern.targetType, pattern.targetId),
		x, controlY + 17, 14,
		Model.COLORS.white, true);
	mono("BAR " + (pattern.currentBar + 1) + "/" + pattern.bars + "  " +
		pattern.length + " STEPS  " + Model.rateLabel(pattern.rateNumerator, pattern.rateDenominator) +
		(pattern.decisionOutcome ? "  ·  " + decisionOutcomeLabel(pattern.decisionOutcome) : ""),
		x, controlY + 36, 10, pattern.decisionOutcome ?
			decisionOutcomeColor(pattern.decisionOutcome) : Model.COLORS.dimText);
	var transportX = x + width - 232;
	button("transport:run", pattern.running ? "RUNNING" : "RUN", transportX, controlY,
		72, 32, !!pattern.running, Model.COLORS.green, { action: "transport", command: "run" });
	button("transport:stop", "STOP", transportX + 78, controlY, 70, 32, false,
		Model.COLORS.red, { action: "transport", command: "stop" });
	button("transport:restart", "RESTART", transportX + 154, controlY, 78, 32, false,
		Model.COLORS.white, { action: "transport", command: "restart" });

	var stepsY = controlY + 51;
	var inspectorW = layout.compact ? 150 : 205;
	var stepsW = width - inspectorW - 12;
	var gap = 3;
	var stepW = (stepsW - gap * 15) / 16;
	var stepH = Math.min(54,
		(layout.contentHeight - (stepsY - y) - (layout.compact ? 42 : 16)) / 4);
	for (var row = 0; row < 4; row++) {
		for (var col = 0; col < 16; col++) {
			var stepIndex = row * 16 + col;
			var step = pattern.steps[stepIndex];
			var sx = x + col * (stepW + gap);
			var sy = stepsY + row * (stepH + gap);
			var color = stepColor(step);
			var tail = gateTailAt(pattern, stepIndex);
			var available = stepIndex < pattern.length;
			if (tail && step && !step.cut) color = Model.COLORS.blue;
			var probabilityAlpha = step ? 0.3 + 0.42 * step.probability / 15 : 0.3;
			fillRect(sx, sy, stepW, stepH, available ? color : Model.COLORS.background,
				available ? probabilityAlpha : 0.25);
			var isPlayhead = pattern.playheadBar === pattern.currentBar &&
				pattern.playheadStep === stepIndex;
			strokeRect(sx, sy, stepW, stepH,
				isPlayhead ? decisionOutcomeColor(pattern.decisionOutcome) : color,
				isPlayhead ? 2 : 1, 1);
			if (stepIndex < pattern.length) mono(String(stepIndex + 1), sx + 3, sy + 12, 7,
				step && (step.cut || step.lockCount) ? Model.COLORS.white : Model.COLORS.dimText);
			if (available && step) {
				fillRect(sx + 2, sy + stepH - 3,
					Math.max(1, (stepW - 4) * step.probability / 15), 2, Model.COLORS.white, 0.7);
				if (step.cut) fillRect(sx + stepW - 4, sy + 2, 2, 5,
					step.track < 0 ? Model.COLORS.dimText : Model.COLORS.green, 1);
			}
			addHit("pattern_step:" + stepIndex, sx, sy, stepW, stepH,
				{ action: "inspect_step", step: stepIndex });
		}
	}
	var inspectorX = x + stepsW + 12;
	fillRect(inspectorX, stepsY, inspectorW, stepH * 4 + gap * 3, Model.COLORS.panel);
	strokeRect(inspectorX, stepsY, inspectorW, stepH * 4 + gap * 3, Model.COLORS.line, 1);
	var inspectIndex = state.hover && state.hover.action === "inspect_step" ? state.hover.step :
		(pattern.playheadStep >= 0 ? pattern.playheadStep : 0);
	var inspected = pattern.steps[inspectIndex] || Model.normalizeStep(null, inspectIndex);
	label("Step inspector", inspectorX + 10, stepsY + 18, Model.COLORS.amber);
	mono("STEP " + (inspectIndex + 1), inspectorX + 10, stepsY + 42, 15, Model.COLORS.white, true);
	mono(inspected.cut ? "TRIGGER  SLICE " + (inspected.slice + 1) : "NO TRIGGER",
		inspectorX + 10, stepsY + 66, 10, inspected.cut ? Model.COLORS.cyan : Model.COLORS.dimText);
	mono("PROB " + inspected.probability + "/15", inspectorX + 10, stepsY + 86, 10,
		Model.COLORS.text);
	var conditionLabel = inspected.condition > 0 ? "EVERY " + inspected.condition :
		(inspected.condition < 0 ? "SKIP " + Math.abs(inspected.condition) : "ALWAYS");
	mono("GATE " + inspected.gateLength + " · " + conditionLabel,
		inspectorX + 10, stepsY + 106, 10, Model.COLORS.text);
	mono("TRACK " + (inspected.track < 0 ? "INHERIT" : inspected.track + 1), inspectorX + 10,
		stepsY + 126, 10, Model.COLORS.text);
	var lockNames = Object.keys(inspected.locks || {});
	label("Locks", inspectorX + 10, stepsY + 151);
	text(lockNames.length ? ellipsis(lockNames.join(" · "), 27) : "None",
		inspectorX + 10, stepsY + 171, 10, lockNames.length ? Model.COLORS.amber : Model.COLORS.dimText);
	var barY = stepsY + stepH * 4 + gap * 3 + 8;
	label("Bars", x, barY + 11);
	for (var bar = 0; bar < 8; bar++) {
		button("bar:" + bar, String(bar + 1), x + 42 + bar * 32, barY - 4, 27, 24,
			bar === pattern.currentBar, Model.COLORS.blue, { action: "bar", id: bar });
	}
}

function drawWaveform(x, y, width, height, waveform) {
	fillRect(x, y, width, height, Model.COLORS.background);
	strokeRect(x, y, width, height, Model.COLORS.line, 1);
	line(x + 1, y + height / 2, x + width - 1, y + height / 2, Model.COLORS.line, 1, 0.7);
	if (!waveform || !Array.isArray(waveform.channels) || !waveform.channels.length) {
		mono("NO WAVEFORM", x + 12, y + height / 2 + 4, 10, Model.COLORS.dimText);
		return;
	}
	for (var channel = 0; channel < waveform.channels.length && channel < 2; channel++) {
		var bins = waveform.channels[channel];
		if (!Array.isArray(bins) || !bins.length) continue;
		var laneHeight = height / Math.min(2, waveform.channels.length);
		var laneTop = y + channel * laneHeight;
		var center = laneTop + laneHeight / 2;
		var color = channel === 0 ? Model.COLORS.cyan : Model.COLORS.purple;
		for (var index = 0; index < bins.length; index++) {
			var pair = bins[index];
			var px = x + 1 + index * (width - 2) / Math.max(1, bins.length - 1);
			var minimum = Array.isArray(pair) ? Number(pair[0]) || 0 : 0;
			var maximum = Array.isArray(pair) ? Number(pair[1]) || 0 : 0;
			line(px, center - maximum * laneHeight * 0.45, px,
				center - minimum * laneHeight * 0.45, color, 1, 0.9);
		}
	}
}

function stripValueMatches(left, right) {
	return Math.abs(Number(left) - Number(right)) < 0.0001;
}

function stripChoiceRow(title, parameter, choices, x, y, width, height, strip, formatter) {
	var labelWidth = Math.min(58, Math.max(43, width * 0.19));
	label(title, x, y + Math.max(12, height * 0.56));
	var choiceX = x + labelWidth;
	var gap = 2;
	var buttonWidth = (width - labelWidth - gap * (choices.length - 1)) / choices.length;
	var buttonHeight = Math.max(12, height - 10);
	var buttonY = y + Math.max(4, (height - buttonHeight) * 0.5);
	for (var index = 0; index < choices.length; index++) {
		var value = choices[index];
		var titleValue = formatter ? formatter(value) : String(value);
		button("strip:" + strip.id + ":" + parameter + ":" + index,
			titleValue, choiceX + index * (buttonWidth + gap), buttonY,
			buttonWidth, buttonHeight, stripValueMatches(strip[parameter], value),
			parameter === "engine" ? Model.COLORS.green : Model.COLORS.cyan,
			{ action: "strip_set", channel: strip.id, parameter: parameter, value: value });
	}
}

function normalizedCutoffLabel(value) {
	var frequency = 35 * Math.pow(18000 / 35, Model.clamp(Number(value), 0, 1));
	if (frequency >= 1000) return (frequency / 1000).toFixed(frequency >= 10000 ? 0 : 1) + "k";
	return String(Math.round(frequency));
}

function compactMilliseconds(value) {
	return Number(value) >= 1000 ? (Number(value) / 1000).toFixed(1) + "s" : String(value);
}

function drawStripMeter(title, value, minimum, maximum, x, y, width, height, color, suffix) {
	label(title, x, y + 9, color);
	var labelWidth = 63;
	var meterX = x + labelWidth;
	var meterWidth = Math.max(20, width - labelWidth - 42);
	fillRect(meterX, y, meterWidth, height, Model.COLORS.background);
	strokeRect(meterX, y, meterWidth, height, Model.COLORS.line, 1);
	var normalized = Model.clamp((Number(value) - minimum) / (maximum - minimum), 0, 1);
	fillRect(meterX + 1, y + 1, Math.max(0, (meterWidth - 2) * normalized),
		Math.max(0, height - 2), color, 0.82);
	mono((Number(value) > -100 ? Number(value).toFixed(1) : "−∞") + (suffix || ""),
		meterX + meterWidth + 5, y + height * 0.72, 8, Model.COLORS.dimText);
}

function drawRackChooser(x, y, width, height) {
	fillRect(x, y, width, height, Model.COLORS.panel);
	strokeRect(x, y, width, height, Model.COLORS.cyan, 1);
	label("Load effect plug-in · Group " + (state.rackChooser.group + 1) +
		" · Slot " + (state.rackChooser.slot + 1), x + 10, y + 17, Model.COLORS.cyan);
	button("rack_format:vst3", "VST3", x + 10, y + 27, 58, 24,
		state.rackChooser.format === "vst3", Model.COLORS.cyan,
		{ action: "rack_format", format: "vst3" });
	button("rack_format:au", "AU", x + 72, y + 27, 48, 24,
		state.rackChooser.format === "au", Model.COLORS.cyan,
		{ action: "rack_format", format: "au" });
	button("rack_refresh", "REFRESH", x + width - 132, y + 27, 62, 24, false,
		Model.COLORS.amber, { action: "rack_refresh" });
	button("rack_close", "CLOSE", x + width - 66, y + 27, 56, 24, false,
		Model.COLORS.red, { action: "rack_close" });
	var entries = state.rackInventory[state.rackChooser.format] || [];
	var pageSize = height < 330 ? 6 : 8;
	var pageCount = Math.max(1, Math.ceil(entries.length / pageSize));
	state.rackChooser.page = Model.clamp(state.rackChooser.page, 0, pageCount - 1);
	var start = state.rackChooser.page * pageSize;
	var listY = y + 60;
	var rowHeight = Math.max(24, Math.min(34, (height - 98) / pageSize));
	if (!entries.length) {
		var inventoryStatus = state.rackInventoryStatus || {};
		var waiting = inventoryStatus.phase === "listing" || inventoryStatus.phase === "publishing";
		mono(waiting ? "READING MAX PLUGIN CACHE…" : "NO CACHED PLUG-INS FOUND",
			x + 12, listY + 21, 10, waiting ? Model.COLORS.amber : Model.COLORS.dimText, true);
		text(waiting ? "The previous list stays usable until refresh completes." :
			"Use Max's Plug-in Browser Full Scan, then press Refresh.",
			x + 12, listY + 43, 10, Model.COLORS.dimText);
	}
	for (var index = 0; index < pageSize; index++) {
		var entry = entries[start + index];
		if (!entry) continue;
		button("rack_plugin:" + (start + index), ellipsis(entry.name || entry.id, 58),
			x + 10, listY + index * rowHeight, width - 20, rowHeight - 3, false,
			Model.COLORS.green, { action: "rack_plugin", entry: entry });
	}
	button("rack_prev", "PREV", x + 10, y + height - 30, 58, 22,
		state.rackChooser.page > 0, Model.COLORS.purple,
		{ action: "rack_page", delta: -1 });
	button("rack_next", "NEXT", x + 72, y + height - 30, 58, 22,
		state.rackChooser.page + 1 < pageCount, Model.COLORS.purple,
		{ action: "rack_page", delta: 1 });
	mono("PAGE " + (state.rackChooser.page + 1) + "/" + pageCount +
		" · " + entries.length + " CACHED", x + 142, y + height - 15,
		9, Model.COLORS.dimText);
}

function drawRackBody(layout, x, y, width, height) {
	var rack = state.pluginRacks[state.selectedChannelStrip] || state.pluginRacks[0];
	if (state.rackChooser.active) {
		drawRackChooser(x, y, width, height);
		return;
	}
	var latencyColor = state.rackLatencyMismatch ? Model.COLORS.amber : Model.COLORS.dimText;
	label("Serial effects · post strip / pre fader", x, y + 13, Model.COLORS.green);
	mono(rack.latencySamples + " samples · " + rack.latencyMs.toFixed(2) + " ms" +
		(state.rackLatencyMismatch ? " · GROUP LATENCIES DIFFER" : ""),
		x + width - Math.min(width - 4, 330), y + 13, 8, latencyColor);
	var listY = y + 23;
	var rowHeight = Math.max(54, (height - 23) / 4);
	for (var slotIndex = 0; slotIndex < 4; slotIndex++) {
		var slot = rack.slots[slotIndex];
		var rowY = listY + slotIndex * rowHeight;
		fillRect(x, rowY, width, rowHeight - 5, Model.COLORS.panel);
		strokeRect(x, rowY, width, rowHeight - 5,
			slot.status === "error" || slot.status === "unsupported" ? Model.COLORS.red : Model.COLORS.line, 1);
		var controlsWidth = layout.compact ? 236 : 266;
		var controlsX = x + width - controlsWidth - 7;
		mono("S" + (slotIndex + 1) + "  " + ellipsis(slot.name || "Empty",
			layout.compact ? 20 : 32), x + 9, rowY + 20, 11,
			slot.loaded ? Model.COLORS.white : Model.COLORS.dimText, true);
		mono((slot.format ? slot.format.toUpperCase() + " · " : "") +
			(slot.error || slot.status || "empty") + " · " + slot.latencySamples + " smp",
			x + 9, rowY + 39, 8,
			slot.error ? Model.COLORS.red : Model.COLORS.dimText);
		var controlY = rowY + Math.max(8, (rowHeight - 31) * 0.5);
		button("rack_load:" + slotIndex, "LOAD", controlsX, controlY, 43, 27, false,
			Model.COLORS.cyan, { action: "rack_choose", slot: slotIndex });
		button("rack_bypass:" + slotIndex, "BYP", controlsX + 46, controlY, 40, 27,
			slot.bypassed, Model.COLORS.amber, { action: "rack_bypass", slot: slotIndex });
		button("rack_open:" + slotIndex, "EDIT", controlsX + 89, controlY, 43, 27,
			false, Model.COLORS.green, { action: "rack_open", slot: slotIndex });
		button("rack_clear:" + slotIndex, "CLR", controlsX + 135, controlY, 38, 27,
			false, Model.COLORS.red, { action: "rack_clear", slot: slotIndex });
		button("rack_up:" + slotIndex, "↑", controlsX + 176, controlY, 27, 27,
			false, Model.COLORS.purple, { action: "rack_move", slot: slotIndex, target: slotIndex - 1 });
		button("rack_down:" + slotIndex, "↓", controlsX + 206, controlY, 27, 27,
			false, Model.COLORS.purple, { action: "rack_move", slot: slotIndex, target: slotIndex + 1 });
	}
}

function drawStripPage(layout) {
	var x = layout.contentX;
	var y = layout.contentY;
	var width = layout.contentWidth;
	var height = layout.contentHeight;
	var selectorHeight = 42;
	fillRect(x, y, width, selectorHeight, Model.COLORS.panel);
	strokeRect(x, y, width, selectorHeight, Model.COLORS.line, 1);
	button("strip_tab:builtin", "BUILT-IN", x + 8, y + 8, 70, 26,
		state.stripView === "builtin", Model.COLORS.green,
		{ action: "strip_tab", view: "builtin" });
	button("strip_tab:rack", "RACK", x + 82, y + 8, 54, 26,
		state.stripView === "rack", Model.COLORS.cyan,
		{ action: "strip_tab", view: "rack" });
	var groupStart = x + (layout.compact ? 146 : 174);
	var groupButtonWidth = Math.min(52,
		(width - (groupStart - x) - 8 - 2 * 7) / 8);
	for (var group = 0; group < 8; group++) {
		button("strip_group:" + group, String(group + 1),
			groupStart + group * (groupButtonWidth + 2), y + 8,
			groupButtonWidth, 26, state.selectedChannelStrip === group,
			Model.GROUP_COLORS[group], { action: "strip_select", channel: group });
	}
	if (state.stripView === "rack") {
		drawRackBody(layout, x, y + selectorHeight + 2, width, height - selectorHeight - 2);
		return;
	}

	var strip = state.channelStrips[state.selectedChannelStrip] || state.channelStrips[0];
	var gap = layout.compact ? 9 : 16;
	var leftWidth = Math.floor(width * (layout.compact ? 0.63 : 0.62));
	var rightX = x + leftWidth + gap;
	var rightWidth = width - leftWidth - gap;
	var controlsY = y + selectorHeight + 2;
	var availableHeight = height - selectorHeight - 2;
	var rowHeight = Math.min(40, availableHeight / 8);
	var cutoffChoices = [0, 0.14, 0.29, 0.43, 0.57, 0.71, 0.86, 1];
	stripChoiceRow("ENGINE", "engine", [0, 1, 2], x, controlsY,
		leftWidth, rowHeight, strip, function (value) {
			return ["BYP", "CLEAN", "OMX"][value];
		});
	stripChoiceRow("CUTOFF", "cutoff", cutoffChoices, x, controlsY + rowHeight,
		leftWidth, rowHeight, strip, normalizedCutoffLabel);
	stripChoiceRow("RES", "resonance", [0, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 1],
		x, controlsY + rowHeight * 2, leftWidth, rowHeight, strip,
		function (value) { return String(Math.round(value * 10)); });
	stripChoiceRow("THRESH", "threshold", [-48, -42, -36, -30, -24, -18, -12, -6, 0],
		x, controlsY + rowHeight * 3, leftWidth, rowHeight, strip);
	stripChoiceRow("RATIO", "ratio", [1, 2, 3, 4, 6, 8, 12, 20],
		x, controlsY + rowHeight * 4, leftWidth, rowHeight, strip);
	stripChoiceRow("ATTACK", "attack", [0.1, 0.3, 1, 3, 10, 30, 100, 300],
		x, controlsY + rowHeight * 5, leftWidth, rowHeight, strip, compactMilliseconds);
	stripChoiceRow("RELEASE", "release", [10, 30, 60, 120, 250, 500, 1000, 2500],
		x, controlsY + rowHeight * 6, leftWidth, rowHeight, strip, compactMilliseconds);
	stripChoiceRow("KNEE", "knee", [0, 3, 6, 9, 12, 18, 24],
		x, controlsY + rowHeight * 7, leftWidth, rowHeight, strip);

	var meterHeight = layout.compact ? 13 : 17;
	var meterStep = meterHeight + (layout.compact ? 7 : 9);
	drawStripMeter("INPUT", strip.inputDb, -60, 0, rightX, controlsY + 3,
		rightWidth, meterHeight, Model.COLORS.cyan, " dB");
	drawStripMeter("OUTPUT", strip.outputDb, -60, 0, rightX, controlsY + 3 + meterStep,
		rightWidth, meterHeight, Model.COLORS.green, " dB");
	drawStripMeter("GAIN Δ", strip.reduction, 0, 24, rightX, controlsY + 3 + meterStep * 2,
		rightWidth, meterHeight, Model.COLORS.amber, " dB");
	var effectiveCutoff = Math.min(strip.cutoff, strip.filterMod);
	mono("FILTER " + normalizedCutoffLabel(effectiveCutoff) +
		"  BASE " + normalizedCutoffLabel(strip.cutoff) +
		"  ṚTA " + Math.round(strip.filterMod * 100) + "%",
		rightX, controlsY + 3 + meterStep * 3 + 7, 8, Model.COLORS.dimText);

	var rightControlsY = controlsY + 3 + meterStep * 3 + (layout.compact ? 10 : 16);
	var rightRowHeight = Math.min(rowHeight,
		(height - (rightControlsY - y) - 2) / 4);
	stripChoiceRow("MAKEUP", "makeup", [-6, 0, 3, 6, 9, 12, 18],
		rightX, rightControlsY, rightWidth, rightRowHeight, strip);
	stripChoiceRow("MIX", "mix", [0, 0.25, 0.5, 0.75, 1],
		rightX, rightControlsY + rightRowHeight, rightWidth, rightRowHeight, strip,
		function (value) { return String(Math.round(value * 100)); });
	stripChoiceRow("DRIVE", "drive", [0, 2, 4, 6, 8, 10, 12],
		rightX, rightControlsY + rightRowHeight * 2, rightWidth, rightRowHeight, strip);
	stripChoiceRow("TRIM", "trim", [-12, -6, -3, 0, 3, 6, 12],
		rightX, rightControlsY + rightRowHeight * 3, rightWidth, rightRowHeight, strip);
}

function drawSampleGridReference(x, y, size) {
	var gap = 1;
	var cell = (size - 15 * gap) / 16;
	for (var row = 0; row < 16; row++) {
		for (var col = 0; col < 16; col++) {
			var sampleIndex = state.sampleBrowserPage * 96 + (row - 1) * 16 + col;
			var sample = row > 0 && row <= 6 ? state.bank.samples[sampleIndex] : null;
			var available = row === 0 || (row <= 6 && !!sample) || row === 7 || row >= 8;
			var active = row === 0 ? col === state.selectedTrack :
				(row <= 6 ? sampleIndex === state.selectedSample :
					(row === 7 && col === 4 + state.sampleBrowserPage));
			var color;
			var alpha;
			if (row === 0) color = Model.GROUP_COLORS[state.tracks[col].group];
			else if (row <= 6) color = sample && sample.color ? sample.color : Model.COLORS.panelRaised;
			else if (row === 7) {
				color = col === 15 ? Model.COLORS.red :
					((col === 0 || col === 1 || (col >= 4 && col <= 6)) ?
						Model.COLORS.purple : Model.COLORS.panelRaised);
			} else color = state.grid.colors[Model.gridIndex(col, row)] || Model.COLORS.panelRaised;
			alpha = row >= 8 ? Math.max(0.12,
				(state.grid.levels[Model.gridIndex(col, row)] || 0) / 15) :
				(active ? 1 : (available ? 0.28 : 0.1));
			fillRect(x + col * (cell + gap), y + row * (cell + gap), cell, cell,
				available ? color : Model.COLORS.panelRaised, alpha);
		}
	}
	strokeRect(x - 2, y - 2, size + 4, size + 4, Model.COLORS.line, 1);
}

function drawSamplesPage(layout) {
	var x = layout.contentX;
	var y = layout.contentY;
	var width = layout.contentWidth;
	var height = layout.contentHeight;
	var inspectorMinimum = layout.compact ? 104 : 196;
	var listsWidth = Math.max(280, Math.min(layout.compact ? 420 : 560,
		width - inspectorMinimum - 14));
	var listGap = 8;
	var trackW = Math.floor((listsWidth - listGap) * 0.44);
	var bankW = listsWidth - listGap - trackW;
	var bankX = x + trackW + listGap;
	var rightX = x + listsWidth + 14;
	var rightWidth = width - listsWidth - 14;
	var controlsHeight = layout.compact ? 23 : 27;
	var controlsY = y + height - controlsHeight - 3;
	var listTop = y + 21;
	var listBottom = controlsY - 7;
	var rowGap = layout.compact ? 1 : 2;
	var rowHeight = Math.max(9,
		(listBottom - listTop - rowGap * 15) / 16);
	var trackCharacters = Math.max(10, Math.floor((trackW - 16) / 5.8));
	var sampleCharacters = Math.max(12, Math.floor((bankW - 16) / 5.8));

	label("Tracks", x, y + 12, Model.COLORS.green);
	for (var track = 0; track < 16; track++) {
		var ty = listTop + track * (rowHeight + rowGap);
		var assigned = state.bank.assignments[track];
		button("sample_track:" + track, ellipsis("T" + (track + 1) + " · " +
			Model.sampleLabel(state, assigned), trackCharacters), x, ty,
			trackW, rowHeight,
			track === state.selectedTrack, Model.GROUP_COLORS[state.tracks[track].group],
			{ action: "sample_track", id: track });
	}
	label("Bank · " + state.bank.status, bankX, y + 12,
		state.bank.status === "ready" ? Model.COLORS.cyan : Model.COLORS.amber);
	var pageSamples = Model.pageSamples(state);
	for (var sampleOffset = 0; sampleOffset < 16; sampleOffset++) {
		var sample = pageSamples[sampleOffset];
		var sampleId = state.samplePage * 16 + sampleOffset;
		var sy = listTop + sampleOffset * (rowHeight + rowGap);
		button("sample:" + sampleId, sample ? ellipsis((sampleId + 1) + " · " + sample.name,
			sampleCharacters) : "—", bankX, sy, bankW, rowHeight,
			sampleId === state.selectedSample,
			sample && sample.color ? sample.color : Model.COLORS.cyan,
			{ action: "sample", id: sampleId, enabled: !!sample });
	}
	var controlGap = layout.compact ? 3 : 5;
	var scanWidth = layout.compact ? 78 : 100;
	var openWidth = layout.compact ? 55 : 75;
	var reloadWidth = layout.compact ? 50 : 58;
	var assignWidth = layout.compact ? 56 : 72;
	var pagerWidth = layout.compact ? 23 : 27;
	var controlX = x;
	button("bank_scan", "SCAN FOLDER…", controlX, controlsY, scanWidth, controlsHeight,
		false, Model.COLORS.purple,
		{ action: "command", command: "bank_scan" });
	controlX += scanWidth + controlGap;
	button("bank_open", "BANK FILE…", controlX, controlsY, openWidth, controlsHeight,
		false, Model.COLORS.amber,
		{ action: "command", command: "bank_open" });
	controlX += openWidth + controlGap;
	button("bank_reload", "RELOAD", controlX, controlsY, reloadWidth, controlsHeight,
		false, Model.COLORS.blue,
		{ action: "command", command: "bank_reload" });
	controlX += reloadWidth + controlGap;
	button("assign", "ASSIGN", controlX, controlsY, assignWidth, controlsHeight,
		false, Model.COLORS.green,
		{ action: "assign" });
	var totalPages = Math.max(1, Math.ceil(state.bank.count / 16));
	controlX += assignWidth + controlGap;
	button("sample_prev", "‹", controlX, controlsY, pagerWidth, controlsHeight,
		false, Model.COLORS.panelRaised,
		{ action: "sample_page", delta: -1 });
	controlX += pagerWidth + controlGap;
	button("sample_next", "›", controlX, controlsY, pagerWidth, controlsHeight,
		false, Model.COLORS.panelRaised,
		{ action: "sample_page", delta: 1 });
	controlX += pagerWidth + controlGap + 2;
	mono("PAGE " + (state.samplePage + 1) + "/" + totalPages,
		controlX, controlsY + controlsHeight * 0.7, 8, Model.COLORS.dimText);

	var selected = state.bank.samples[state.selectedSample];
	var waveform = selected ? state.waveforms[String(selected.buffer)] : null;
	label("Selected sample", rightX, y + 12, Model.COLORS.purple);
	mono(selected ? ellipsis(selected.name, Math.max(10, Math.floor(rightWidth / 7))) :
		"NO SAMPLE", rightX, y + 33, layout.compact ? 10 : 12, Model.COLORS.white, true);
	text(selected ? ellipsis(selected.path, Math.max(12, Math.floor(rightWidth / 5.8))) :
		"Select a bank sample.", rightX, y + 51, 9, Model.COLORS.dimText);
	var waveformHeight = layout.compact ? 64 : 88;
	drawWaveform(rightX, y + 61, rightWidth, waveformHeight, waveform);
	if (selected) {
		mono((selected.channels || "?") + " CH   " +
			(selected.durationMs ? (selected.durationMs / 1000).toFixed(2) + " S" : "—") + "   " +
			(selected.sampleRate ? Math.round(selected.sampleRate) + " HZ" : "—"),
			rightX, y + 61 + waveformHeight + 17, 8, Model.COLORS.dimText);
		mono((selected.category || "other").toUpperCase() + " · " +
			ellipsis(selected.family || "", Math.max(8, Math.floor(rightWidth / 7))),
			rightX, y + 61 + waveformHeight + 34, 8, selected.color || Model.COLORS.cyan);
	}
	var previewActionY = y + 61 + waveformHeight + (layout.compact ? 45 : 49);
	var previewActionWidth = Math.max(38, (rightWidth - 4) / 2);
	button("preview_stop", layout.compact ? "STOP" : "STOP PREVIEW", rightX,
		previewActionY, previewActionWidth, 23, false, Model.COLORS.red,
		{ action: "command", command: "sample_preview_stop" });
	button("sample_grid", state.sampleBrowserActive ? "CLOSE GRID" : "GRID BROWSE",
		rightX + previewActionWidth + 4, previewActionY, previewActionWidth, 23,
		state.sampleBrowserActive, Model.COLORS.purple, { action: "sample_grid" });
	if (!layout.compact) {
		var proposalY = y + 61 + waveformHeight + 80;
		label("Physical split grid · page " + (state.sampleBrowserPage + 1) + "/" +
			Math.max(1, Math.ceil(state.bank.count / 96)), rightX, proposalY, Model.COLORS.amber);
		var proposalSize = Math.min(rightWidth, y + height - proposalY - 18);
		if (proposalSize >= 72) drawSampleGridReference(rightX, proposalY + 10, proposalSize);
	} else label("Grid map: Help → Samples", rightX, y + 61 + waveformHeight + 82,
		Model.COLORS.amber);
}

function colorHex(color) {
	function hex(value) {
		var textValue = Math.round(Model.clamp(value, 0, 255)).toString(16).toUpperCase();
		return textValue.length < 2 ? "0" + textValue : textValue;
	}
	return "#" + hex(color[0]) + hex(color[1]) + hex(color[2]);
}

function drawColorsPage(layout) {
	var x = layout.contentX;
	var y = layout.contentY;
	var width = layout.contentWidth;
	var height = layout.contentHeight;
	var listWidth = layout.compact ? 150 : 210;
	var rolesPerPage = layout.compact ? 8 : 10;
	var roleCount = state.colorLab.order.length;
	var rolePages = Math.max(1, Math.ceil(roleCount / rolesPerPage));
	state.colorLab.page = Model.clamp(state.colorLab.page, 0, rolePages - 1);
	var roleStart = state.colorLab.page * rolesPerPage;

	fillRect(x, y, listWidth, height, Model.COLORS.panel);
	strokeRect(x, y, listWidth, height, Model.COLORS.line, 1);
	label("Runtime color roles", x + 10, y + 17, Model.COLORS.purple);
	for (var roleOffset = 0; roleOffset < rolesPerPage; roleOffset++) {
		var roleName = state.colorLab.order[roleStart + roleOffset];
		var role = roleName ? state.colorLab.roles[roleName] : null;
		if (!role) continue;
		var roleY = y + 29 + roleOffset * (layout.compact ? 31 : 34);
		var title = role.category + "  " + role.label;
		button("color_role:" + roleName, ellipsis(title, layout.compact ? 20 : 28),
			x + 8, roleY, listWidth - 16, layout.compact ? 27 : 30,
			state.colorLab.selected === roleName, role.color,
			{ action: "color_role_select", name: roleName });
	}
	var roleNavY = y + height - 34;
	button("color_role_prev", "‹", x + 8, roleNavY, 28, 25, false, Model.COLORS.panelRaised,
		{ action: "color_role_page", delta: -1 });
	button("color_role_next", "›", x + 40, roleNavY, 28, 25, false, Model.COLORS.panelRaised,
		{ action: "color_role_page", delta: 1 });
	mono("PAGE " + (state.colorLab.page + 1) + "/" + rolePages,
		x + 78, roleNavY + 17, 9, Model.COLORS.dimText);

	var selected = state.colorLab.roles[state.colorLab.selected];
	var rightX = x + listWidth + 16;
	var rightWidth = width - listWidth - 16;
	label("Color lab · session only", rightX, y + 17, Model.COLORS.amber);
	if (!selected) {
		mono("WAITING FOR COLOR SNAPSHOT", rightX, y + 48, 12, Model.COLORS.dimText, true);
		text("The snapshot is requested automatically when this page opens.",
			rightX, y + 72, 10, Model.COLORS.dimText);
		button("color_snapshot_retry", "RETRY SNAPSHOT", rightX, y + 91, 126, 27,
			false, Model.COLORS.purple, { action: "command", command: "snapshot" });
		return;
	}
	mono(selected.category + " / " + selected.label, rightX, y + 46,
		14, Model.COLORS.white, true);
	mono(selected.name + "  " + colorHex(selected.color), rightX, y + 67,
		10, Model.COLORS.dimText);
	var swatchWidth = Math.min(190, rightWidth * 0.42);
	fillRect(rightX, y + 82, swatchWidth, 72, selected.color);
	strokeRect(rightX, y + 82, swatchWidth, 72, Model.COLORS.white, 1, 0.55);
	if (!layout.compact && rightWidth > 380) {
		var previewSize = Math.min(148, rightWidth - swatchWidth - 28);
		label("Live grid", rightX + swatchWidth + 22, y + 78, Model.COLORS.cyan);
		drawGrid(rightX + swatchWidth + 28, y + 91, previewSize, false);
	}

	var channelNames = ["R", "G", "B"];
	var channelColors = [Model.COLORS.red, Model.COLORS.green, Model.COLORS.blue];
	var channelY = y + 180;
	var fineWidth = 27;
	var barWidth = Math.max(190, rightWidth - fineWidth * 2 - 16);
	var segmentGap = 2;
	var segmentWidth = (barWidth - segmentGap * 15) / 16;
	for (var channel = 0; channel < 3; channel++) {
		var rowY = channelY + channel * 61;
		mono(channelNames[channel] + " " + selected.color[channel], rightX, rowY + 12,
			10, channelColors[channel], true);
		button("color_fine_down:" + channel, "−", rightX + 40, rowY - 5,
			fineWidth, 24, false, channelColors[channel],
			{ action: "color_channel_delta", channel: channel, delta: -1 });
		button("color_fine_up:" + channel, "+", rightX + 71, rowY - 5,
			fineWidth, 24, false, channelColors[channel],
			{ action: "color_channel_delta", channel: channel, delta: 1 });
		var barX = rightX;
		for (var level = 0; level < 16; level++) {
			var value = Math.round(level * 255 / 15);
			var preview = selected.color.slice();
			preview[channel] = value;
			var segmentX = barX + level * (segmentWidth + segmentGap);
			var active = Math.round(selected.color[channel] * 15 / 255) === level;
			fillRect(segmentX, rowY + 25, segmentWidth, 23, preview, active ? 1 : 0.55);
			strokeRect(segmentX, rowY + 25, segmentWidth, 23,
				active ? Model.COLORS.white : preview, active ? 2 : 1, 0.9);
			addHit("color_channel:" + channel + ":" + value,
				segmentX, rowY + 25, segmentWidth, 23,
				{ action: "color_channel", channel: channel, value: value });
		}
	}
	var resetY = y + height - 36;
	button("color_reset_role", "RESET ROLE", rightX, resetY, 100, 27, false,
		Model.COLORS.amber, { action: "color_reset", name: selected.name });
	button("color_reset_all", "RESET ALL", rightX + 108, resetY, 96, 27, false,
		Model.COLORS.red, { action: "color_reset", name: "all" });
	mono("Runtime only · no config files are written", rightX + 218, resetY + 18,
		9, Model.COLORS.dimText);
}

function drawSessionPage(layout) {
	var x = layout.contentX;
	var y = layout.contentY;
	var width = layout.contentWidth;
	var height = layout.contentHeight;
	var session = state.session;
	fillRect(x, y, width, height, Model.COLORS.panel);
	strokeRect(x, y, width, height, Model.COLORS.line, 1);
	label("Modern MLR session", x + 14, y + 20, Model.COLORS.cyan);
	mono(ellipsis(session.name || "Untitled", 54) + (session.dirty ? "  •" : ""),
		x + 14, y + 53, 20, session.dirty ? Model.COLORS.amber : Model.COLORS.white, true);
	mono(session.path ? ellipsis(session.path, layout.compact ? 62 : 100) : "NOT YET SAVED",
		x + 14, y + 75, 9, Model.COLORS.dimText);
	var controlsY = y + 94;
	var controlWidth = Math.max(70, Math.min(104, (width - 28 - 4 * 7) / 5));
	var commands = [
		["NEW", "session_new", Model.COLORS.red],
		["OPEN", "session_open", Model.COLORS.cyan],
		["SAVE", "session_save", Model.COLORS.green],
		["SAVE AS", "session_save_as", Model.COLORS.purple],
		["RELINK", "session_relink", Model.COLORS.amber]
	];
	for (var commandIndex = 0; commandIndex < commands.length; commandIndex++) {
		button("session_command:" + commands[commandIndex][1], commands[commandIndex][0],
			x + 14 + commandIndex * (controlWidth + 7), controlsY, controlWidth, 31,
			false, commands[commandIndex][2],
			{ action: "session_command", command: commands[commandIndex][1] });
	}
	var statusY = y + 148;
	fillRect(x + 14, statusY, width - 28, 54, Model.COLORS.background);
	strokeRect(x + 14, statusY, width - 28, 54,
		session.busy ? Model.COLORS.cyan : Model.COLORS.line, 1);
	label(session.busy ? (session.operation || "WORKING") :
		(session.dirty ? "Unsaved changes" : "Session status"), x + 25, statusY + 18,
		session.busy ? Model.COLORS.cyan : (session.dirty ? Model.COLORS.amber : Model.COLORS.green));
	mono(ellipsis(session.message || "Ready", layout.compact ? 56 : 94),
		x + 25, statusY + 39, 10, Model.COLORS.text);
	var missing = session.missing || [];
	label("Missing resources · " + missing.length, x + 14, y + 229,
		missing.length ? Model.COLORS.amber : Model.COLORS.dimText);
	var missingRows = Math.max(1, Math.floor((height - 250) / 26));
	if (!missing.length) {
		mono("NONE", x + 14, y + 255, 10, Model.COLORS.dimText);
	} else {
		for (var missingIndex = 0; missingIndex < Math.min(missingRows, missing.length); missingIndex++) {
			var resource = missing[missingIndex] || {};
			mono((resource.ambiguous ? "? " : "! ") +
				String(resource.type || "sample").toUpperCase() + "  " +
				ellipsis(Model.basename(resource.path || ""), layout.compact ? 46 : 76),
				x + 14, y + 254 + missingIndex * 26, 9, Model.COLORS.amber);
		}
	}
	if (session.confirmation) {
		var dialogWidth = Math.min(520, width - 48);
		var dialogHeight = 142;
		var dialogX = x + (width - dialogWidth) * 0.5;
		var dialogY = y + (height - dialogHeight) * 0.5;
		fillRect(dialogX, dialogY, dialogWidth, dialogHeight, Model.COLORS.panelRaised);
		strokeRect(dialogX, dialogY, dialogWidth, dialogHeight, Model.COLORS.amber, 2);
		label("Unsaved session", dialogX + 16, dialogY + 22, Model.COLORS.amber);
		text("Save changes before " + session.confirmation + "?", dialogX + 16,
			dialogY + 51, 13, Model.COLORS.white, true);
		button("session_confirm:save", "SAVE", dialogX + 16, dialogY + 87, 90, 32,
			false, Model.COLORS.green, { action: "session_confirm", choice: "save" });
		button("session_confirm:discard", "DISCARD", dialogX + 114, dialogY + 87, 96, 32,
			false, Model.COLORS.red, { action: "session_confirm", choice: "discard" });
		button("session_confirm:cancel", "CANCEL", dialogX + 218, dialogY + 87, 90, 32,
			false, Model.COLORS.dimText, { action: "session_confirm", choice: "cancel" });
	}
}

function drawHelpPage(layout) {
	var x = layout.contentX;
	var y = layout.contentY;
	var topicW = layout.compact ? 96 : 150;
	var topics = ["follow", "main", "mod", "groups", "sequence64", "locks", "samples"];
	label("Reference", x, y + 12, Model.COLORS.amber);
	for (var index = 0; index < topics.length; index++) {
		var topicSpacing = layout.compact ? 30 : 38;
		var helpTitle = topics[index] === "sequence64" ? "ṛta" : topics[index].toUpperCase();
		button("help:" + topics[index], helpTitle, x,
			y + 24 + index * topicSpacing, topicW, layout.compact ? 25 : 32,
			state.helpTopic === topics[index], Model.COLORS.amber,
			{ action: "help", topic: topics[index] });
	}
	var gridSize = Math.min(layout.contentHeight - 24,
		layout.contentWidth - topicW - (layout.compact ? 150 : 250));
	var gridX = x + topicW + 20;
	var gridY = y + 8;
	drawGrid(gridX, gridY, gridSize, true);
	var infoX = gridX + gridSize + 18;
	var topic = state.helpTopic === "follow" ? Model.modeName(state.mode, state.editor).toLowerCase() : state.helpTopic;
	if (topic === "ṛta") topic = "sequence64";
	label("Topic", infoX, y + 14, Model.COLORS.cyan);
	mono(topic === "sequence64" ? "ṛta · ऋत" : topic.toUpperCase(),
		infoX, y + 38, 16, Model.COLORS.white, true);
	var hovered = state.hover && state.hover.action === "grid_hover" ? state.hover :
		(state.grid.lastPress || { x: 0, y: 0 });
	var description = Model.describeCell(state.mode, hovered.x, hovered.y, state.editor, topic);
	label("Control", infoX, y + 76);
	mono(description.title, infoX, y + 98, 11, Model.COLORS.white, true);
	text(ellipsis(description.detail, 36), infoX, y + 122, 11, Model.COLORS.text);
	text(ellipsis(description.detail.substring(36), 36), infoX, y + 141, 11, Model.COLORS.text);
	label("Gesture", infoX, y + 164);
	text(ellipsis(description.gesture, 34), infoX, y + 183, 10, Model.COLORS.text);
	label("State / color", infoX, y + 208);
	text(ellipsis(description.state, 34), infoX, y + 227, 10, Model.COLORS.dimText);
	text(ellipsis(description.color, 34), infoX, y + 245, 10, Model.COLORS.dimText);
	var legends = [
		[Model.COLORS.cyan, "TRIGGER / SEQUENCE"],
		[Model.COLORS.green, "GATE / RUN"],
		[Model.COLORS.amber, "LOCK / SETUP"],
		[Model.COLORS.purple, "TRIGGER + LOCK"],
		[Model.COLORS.red, "STOP / RECORD"]
	];
	if (!layout.compact) label("Legend", infoX, y + 271);
	for (var legend = 0; !layout.compact && legend < legends.length; legend++) {
		fillRect(infoX, y + 284 + legend * 22, 14, 14, legends[legend][0]);
		mono(legends[legend][1], infoX + 22, y + 295 + legend * 22, 9, Model.COLORS.dimText);
	}
	if (!layout.compact) text("Help browsing never changes the grid.", infoX,
		y + layout.contentHeight - 8, 10, Model.COLORS.dimText);
}

function paint() {
	var layout = pageLayout();
	hitRegions = [];
	fillRect(0, 0, layout.width, layout.height, Model.COLORS.background);
	drawHeader(layout);
	if (state.page === "live") drawLivePage(layout);
	else if (state.page === "pattern") drawPatternPage(layout);
	else if (state.page === "strip") drawStripPage(layout);
	else if (state.page === "samples") drawSamplesPage(layout);
	else if (state.page === "colors") drawColorsPage(layout);
	else if (state.page === "session") drawSessionPage(layout);
	else drawHelpPage(layout);
}

function sendCommand() {
	var args = Array.prototype.slice.call(arguments);
	outlet.apply(this, [0].concat(args));
}

function requestColorSnapshot() {
	// Color roles change at runtime and are not continuously streamed. Asking on
	// entry makes the Colors page robust to HUD/router load-order races.
	sendCommand("snapshot");
}

function activateRegion(region, doubleClick) {
	if (!region || !region.payload) return;
	var payload = region.payload;
	if (payload.action === "page") {
		Model.setPage(state, payload.page);
		if (payload.page === "colors") requestColorSnapshot();
		if (payload.page === "strip") {
			sendCommand("strip_snapshot");
			sendCommand("strip_select", state.selectedChannelStrip);
		}
		if (payload.page === "session") sendCommand("session_command", "snapshot");
	} else if (payload.action === "target") {
		sendCommand("target", payload.type, payload.id);
	} else if (payload.action === "bar") {
		sendCommand("bar", payload.id);
	} else if (payload.action === "transport") {
		sendCommand("transport", payload.command);
	} else if (payload.action === "strip_select") {
		Model.selectChannelStrip(state, payload.channel);
		sendCommand("strip_select", state.selectedChannelStrip);
	} else if (payload.action === "strip_tab") {
		Model.setStripView(state, payload.view);
	} else if (payload.action === "strip_set") {
		var selectedStrip = state.channelStrips[payload.channel];
		if (selectedStrip) selectedStrip[payload.parameter] = payload.value;
		sendCommand("strip_set", payload.channel, payload.parameter, payload.value);
	} else if (payload.action === "rack_choose") {
		state.rackChooser.active = 1;
		state.rackChooser.group = state.selectedChannelStrip;
		state.rackChooser.slot = payload.slot;
		state.rackChooser.page = 0;
	} else if (payload.action === "rack_close") {
		state.rackChooser.active = 0;
	} else if (payload.action === "rack_format") {
		state.rackChooser.format = payload.format === "au" ? "au" : "vst3";
		state.rackChooser.page = 0;
	} else if (payload.action === "rack_page") {
		var rackEntries = state.rackInventory[state.rackChooser.format] || [];
		var rackPages = Math.max(1, Math.ceil(rackEntries.length / (pageLayout().contentHeight < 330 ? 6 : 8)));
		state.rackChooser.page = Model.clamp(state.rackChooser.page + payload.delta, 0, rackPages - 1);
	} else if (payload.action === "rack_refresh") {
		sendCommand("rack_refresh");
	} else if (payload.action === "rack_plugin") {
		var plugin = payload.entry || {};
		sendCommand("rack_load", state.rackChooser.group, state.rackChooser.slot,
			plugin.format || state.rackChooser.format, plugin.uri || plugin.id || "");
		state.rackChooser.active = 0;
	} else if (payload.action === "rack_bypass") {
		var bypassRack = state.pluginRacks[state.selectedChannelStrip];
		var bypassSlot = bypassRack && bypassRack.slots[payload.slot];
		sendCommand("rack_bypass", state.selectedChannelStrip, payload.slot,
			bypassSlot && bypassSlot.bypassed ? 0 : 1);
	} else if (payload.action === "rack_open") {
		sendCommand("rack_open", state.selectedChannelStrip, payload.slot);
	} else if (payload.action === "rack_clear") {
		sendCommand("rack_clear", state.selectedChannelStrip, payload.slot);
	} else if (payload.action === "rack_move") {
		if (payload.target >= 0 && payload.target < 4) {
			sendCommand("rack_move", state.selectedChannelStrip, payload.slot, payload.target);
		}
	} else if (payload.action === "session_command") {
		sendCommand(payload.command);
	} else if (payload.action === "session_confirm") {
		sendCommand("session_confirm", payload.choice);
	} else if (payload.action === "sample_track") {
		Model.selectTrack(state, payload.id);
	} else if (payload.action === "sample" && payload.enabled) {
		Model.selectSample(state, payload.id);
		var sample = state.bank.samples[state.selectedSample];
		if (sample) sendCommand("sample_audition", state.selectedSample);
		if (doubleClick) sendCommand("sample_assign", state.selectedTrack, state.selectedSample);
	} else if (payload.action === "assign") {
		if (state.selectedSample >= 0) sendCommand("sample_assign", state.selectedTrack, state.selectedSample);
	} else if (payload.action === "sample_grid") {
		sendCommand("sample_grid", state.sampleBrowserActive ? 0 : 1,
			state.selectedTrack, state.selectedSample);
	} else if (payload.action === "command") {
		sendCommand(payload.command);
	} else if (payload.action === "sample_page") {
		var pages = Math.max(1, Math.ceil(state.bank.count / 16));
		state.samplePage = Model.clamp(state.samplePage + payload.delta, 0, pages - 1);
	} else if (payload.action === "color_role_select") {
		state.colorLab.selected = payload.name;
	} else if (payload.action === "color_role_page") {
		var rolesPerPage = pageLayout().compact ? 8 : 10;
		var rolePages = Math.max(1, Math.ceil(state.colorLab.order.length / rolesPerPage));
		state.colorLab.page = Model.clamp(state.colorLab.page + payload.delta, 0, rolePages - 1);
	} else if (payload.action === "color_channel" || payload.action === "color_channel_delta") {
		var selectedRole = state.colorLab.roles[state.colorLab.selected];
		if (selectedRole) {
			var nextValue = payload.action === "color_channel" ? payload.value :
				selectedRole.color[payload.channel] + payload.delta;
			selectedRole.color[payload.channel] = Math.round(Model.clamp(nextValue, 0, 255));
			sendCommand("color_role", selectedRole.name,
				selectedRole.color[0], selectedRole.color[1], selectedRole.color[2]);
		}
	} else if (payload.action === "color_reset") {
		sendCommand("color_reset", payload.name);
	} else if (payload.action === "help") {
		state.helpTopic = payload.topic;
	}
	scheduleRedraw(true);
}

function updatePointer(x, y) {
	lastPointerX = x;
	lastPointerY = y;
	var next = regionAt(x, y);
	if (next === hoveredRegion) return;
	hoveredRegion = next;
	state.hover = next ? next.payload : null;
	scheduleRedraw(false);
}

function onpointermove(event) {
	updatePointer(event.clientX, event.clientY);
}
onpointermove.local = 1;

function onpointerdown(event) {
	updatePointer(event.clientX, event.clientY);
}
onpointerdown.local = 1;

function onpointerup(event) {
	updatePointer(event.clientX, event.clientY);
	var region = regionAt(event.clientX, event.clientY);
	var now = Date.now();
	var doubleClick = !!(region && region.id === lastClickRegionId && now - lastClickTime <= 350);
	lastClickRegionId = region ? region.id : "";
	lastClickTime = now;
	activateRegion(region, doubleClick);
}
onpointerup.local = 1;

function onpointerleave() {
	hoveredRegion = null;
	state.hover = null;
	scheduleRedraw(false);
}
onpointerleave.local = 1;

function onclick(x, y) {
	updatePointer(x, y);
	activateRegion(regionAt(x, y), false);
}
onclick.local = 1;

function ondblclick(x, y) {
	updatePointer(x, y);
	activateRegion(regionAt(x, y), true);
}
ondblclick.local = 1;

function onresize() {
	scheduleRedraw(false);
}
onresize.local = 1;

function receive(topic, args) {
	Model.applyEvent(state, topic, Array.prototype.slice.call(args));
	scheduleRedraw(false);
}

function grid_level_map() { receive("grid_level_map", arguments); }
function grid_color_map() { receive("grid_color_map", arguments); }
function grid_color_cell() { receive("grid_color_cell", arguments); }
function grid_color_all() { receive("grid_color_all", arguments); }
function grid_press() { receive("grid_press", arguments); }
function mode() { receive("mode", arguments); }
function clock() { receive("clock", arguments); }
function track() { receive("track", arguments); }
function channel() { receive("channel", arguments); }
function editor() { receive("editor", arguments); }
function pattern_summary() { receive("pattern_summary", arguments); }
function pattern_snapshot() { receive("pattern_snapshot", arguments); }
function pattern_playhead() { receive("pattern_playhead", arguments); }
function bank() { receive("bank", arguments); }
function sample() { receive("sample", arguments); }
function assignment() { receive("assignment", arguments); }
function browser_selection() { receive("browser_selection", arguments); }
function sample_browser() { receive("sample_browser", arguments); }
function waveform() { receive("waveform", arguments); }
function notice() { receive("notice", arguments); }
function color_role() { receive("color_role", arguments); }
function channel_strip() { receive("channel_strip", arguments); }
function channel_strip_meter() { receive("channel_strip_meter", arguments); }
function rack_inventory() { receive("rack_inventory", arguments); }
function rack_inventory_begin() { receive("rack_inventory_begin", arguments); }
function rack_inventory_item() { receive("rack_inventory_item", arguments); }
function rack_inventory_end() { receive("rack_inventory_end", arguments); }
function rack_inventory_status() { receive("rack_inventory_status", arguments); }
function rack_state() { receive("rack_state", arguments); }
function rack_latency() { receive("rack_latency", arguments); }
function session_state() { receive("session_state", arguments); }
function session_missing() { receive("session_missing", arguments); }

function page(value) {
	var requested = Model.setPage(state, String(value || ""));
	if (requested === "colors") requestColorSnapshot();
	if (requested === "strip") {
		sendCommand("strip_snapshot");
		sendCommand("strip_select", state.selectedChannelStrip);
	}
	if (requested === "session") sendCommand("session_command", "snapshot");
	scheduleRedraw(true);
}

function bang() {
	sendCommand("snapshot");
	scheduleRedraw(true);
}

function loadbang() {
	var task = new Task(function () {
		sendCommand("snapshot");
		scheduleRedraw(true);
	}, this);
	task.schedule(100);
}

function notifydeleted() {
	redrawTask.cancel();
}
