autowatch = 1;
inlets = 1;
outlets = 2;

var ColorMath = require("grid_color_math.js");
var GridLabel = require("grid_label.js");
var labelMask = null, labelAlpha = 0, labelStarted = 0, labelTask = null;

/**
 * Varibright LED state bridge: JS byte arrays -> /grid/led/level/map
 * Map layout matches mlr4k3r0update7/gridfantastic: 8x8 blocks at (0,0), (8,0),
 * and for 256 also (0,8), (8,8).
 * The bridge owns stable foreground/background arrays plus transient animation
 * level/mask arrays. Masked animation cells
 * temporarily override the stable composite; an animation can therefore blink
 * a bright key darker without ever modifying or erasing its underlying state.
 *
 * dual128 1: two stacked 128 grids as one 256 — outlet 0 = top rows (0–7),
 * outlet 1 = bottom rows (logical 8–15 mapped to physical 0–7). Use edition 256.
 */

var prefix = "/box";
var edition = 256;
var dual128Mode = 0;
var mechatrellisExtensionsEnabled = 0;
var foreground = new Uint8Array(16 * 16);
var bg = new Uint8Array(16 * 16);
var animationLevels = new Uint8Array(16 * 16);
var animationMask = new Uint8Array(16 * 16);
var foregroundClearCount = 0;
var frameBatchDepth = 0;
var roleColors = new Uint8Array(16 * 16 * 3);
var stateColorModifiers = new Array(16 * 16).fill(null);
var motionColorModifiers = new Array(16 * 16).fill(null);
var hudColors = new Uint8Array(16 * 16 * 3);
var colorDirty = new Uint8Array(16 * 16);
var stateDirty = new Uint8Array(16 * 16);
var fullStateFramePending = 0;
var nextStateFrameId = 1;
var hudColorPresets = new Array(8);
var hardwareStats = {
	levelFrames: 0,
	levelMapPackets: 0,
	extensionPackets: 0,
	colorSetPackets: 0,
	colorMapPackets: 0,
	colorAllPackets: 0,
	presetStorePackets: 0,
	presetRecallPackets: 0,
	stateSetPackets: 0,
	stateMapPackets: 0,
	frameBeginPackets: 0,
	frameMapPackets: 0,
	frameCommitPackets: 0,
	lastLevelFrameTime: 0,
	lastExtensionTime: 0,
	lastExtensionPath: ""
};


// Separate from animationMask: labels cannot cancel playhead or pulse animations.
function parameterLabel(word) {
 if (labelTask) labelTask.cancel();
 var wh = dims_for_edition(edition);
 labelMask = GridLabel.bitmap(word, wh[0], wh[1]);
 labelAlpha = 1; labelStarted = Date.now();
 if (!labelTask) labelTask = new Task(parameterLabelTick, this);
 refreshParameterLabel();
 labelTask.schedule(50);
}
function refreshParameterLabel() {
 var wh = dims_for_edition(edition);
 for (var i=0; i<wh[0]*Math.min(8,wh[1]); i++) { stateDirty[i]=1; colorDirty[i]=1; }
 flush();
}
function parameterLabelTick() {
 var next = Math.round(GridLabel.opacity(Date.now()-labelStarted)*15)/15;
 if (next !== labelAlpha) { labelAlpha=next; refreshParameterLabel(); }
 if (next > 0) labelTask.schedule(50);
 else labelMask=null;
}
function parameterLabelClear() {
 if (labelTask) labelTask.cancel();
 if (!labelMask) return;
 labelAlpha=0; labelMask=null; refreshParameterLabel();
}
function labelApplies(index) {
 return labelMask && labelAlpha>0 && index<dims_for_edition(edition)[0]*8;
}
function notifydeleted() { if (labelTask) labelTask.cancel(); }

function loadbang() {
	var wh = dims_for_edition(edition);
	post("[grid_matrix_bridge] JS state dim=" + wh + "\n");
	// A complete router frame follows every load/recompile, so no external named
	// Jitter storage or constructor binding is required for these 256 bytes.
	messnamed("gridrouter", "hardwareResync");
}

function resetLevelState(width, height) {
	if (labelTask) labelTask.cancel();
	labelMask=null; labelAlpha=0;
	var cells = width * height;
	foreground = new Uint8Array(cells);
	bg = new Uint8Array(cells);
	animationLevels = new Uint8Array(cells);
	animationMask = new Uint8Array(cells);
	foregroundClearCount++;
}

function publishHud() {
	var args = arrayfromargs(arguments);
	messnamed.apply(this, ["mlr_hud_state"].concat(args));
}

function noteExtensionPacket(path, packetCount) {
	var count = Math.max(1, parseInt(packetCount, 10) || 1);
	hardwareStats.extensionPackets += count;
	hardwareStats.lastExtensionTime = Date.now();
	hardwareStats.lastExtensionPath = String(path || "");
	if (path === "/grid/led/color/set") hardwareStats.colorSetPackets += count;
	else if (path === "/grid/led/color/map") hardwareStats.colorMapPackets += count;
	else if (path === "/grid/led/color/all") hardwareStats.colorAllPackets += count;
	else if (path === "/grid/led/color/preset/store") hardwareStats.presetStorePackets += count;
	else if (path === "/grid/led/color/preset/recall") hardwareStats.presetRecallPackets += count;
	else if (path === "/grid/led/state/set") hardwareStats.stateSetPackets += count;
	else if (path === "/grid/led/state/map") hardwareStats.stateMapPackets += count;
	else if (path === "/grid/led/frame/begin") hardwareStats.frameBeginPackets += count;
	else if (path === "/grid/led/frame/map") hardwareStats.frameMapPackets += count;
	else if (path === "/grid/led/frame/commit") hardwareStats.frameCommitPackets += count;
}

function bytesToArray(values) {
	var result = [];
	for (var index = 0; index < values.length; index++) result.push(values[index]);
	return result;
}

function byteHash(values) {
	var hash = 2166136261;
	for (var index = 0; index < values.length; index++) {
		hash ^= values[index] & 255;
		hash = Math.imul(hash, 16777619);
	}
	return hash >>> 0;
}

function resetHudColors(width, height) {
	var cells = width * height;
	roleColors = new Uint8Array(cells * 3);
	stateColorModifiers = new Array(cells).fill(null);
	motionColorModifiers = new Array(cells).fill(null);
	hudColors = new Uint8Array(cells * 3);
	colorDirty = new Uint8Array(cells);
	stateDirty = new Uint8Array(cells);
	fullStateFramePending = 1;
	for (var cell = 0; cell < width * height; cell++) {
		roleColors[cell * 3] = 28;
		roleColors[cell * 3 + 1] = 48;
		roleColors[cell * 3 + 2] = 90;
		hudColors[cell * 3] = 28;
		hudColors[cell * 3 + 1] = 48;
		hudColors[cell * 3 + 2] = 90;
	}
	hudColorPresets = new Array(8);
}

function dims_for_edition(e) {
	if (e === 64) return [8, 8];
	if (e === 128) return [16, 8];
	return [16, 16];
}

function set_edition(n) {
	if (n !== 64 && n !== 128 && n !== 256) {
		post("[grid_matrix_bridge] bad edition " + n + " (use 64, 128, or 256)\n");
		return;
	}
	edition = n | 0;
	var wh = dims_for_edition(edition);
	resetLevelState(wh[0], wh[1]);
	resetHudColors(wh[0], wh[1]);
	post("[grid_matrix_bridge] edition=" + edition + " dim=" + wh + "\n");
}

function bang() {
	flush();
}

function flush() {
	if (frameBatchDepth > 0) return;
	send_level_maps();
}

function clear() {
	post("[grid_matrix_bridge] clear() called\n");
	foreground.fill(0);
	stateDirty.fill(1);
	foregroundClearCount++;
	flush();
}

/**
 * Atomically replace a page. Periodic flushes are suppressed between these
 * messages, so the physical grid never receives the intermediate blank frame.
 */
function beginframe() {
	frameBatchDepth++;
	if (frameBatchDepth === 1) {
		foreground.fill(0);
		stateDirty.fill(1);
		fullStateFramePending = 1;
		foregroundClearCount++;
		for (var i = 0; i < bg.length; i++) bg[i] = 0;
	}
}

/**
 * Atomically apply a partial update without clearing either matrix plane.
 * This is the transaction used by renderer diffs and moving indicators.
 */
function beginupdate() {
	frameBatchDepth++;
}

/**
 * Atomically install a complete router-owned foreground/background frame.
 * Arguments are: width height, width*height foreground values, then the same
 * number of background values. The live matrix is untouched until validation
 * and staging have both completed.
 */
function replaceframe() {
	var args = arrayfromargs(arguments);
	if (args.length < 2) {
		post("[grid_matrix_bridge] replaceframe missing dimensions\n");
		return;
	}
	var width = parseInt(args[0], 10);
	var height = parseInt(args[1], 10);
	var wh = dims_for_edition(edition);
	var cells = width * height;
	if (width !== wh[0] || height !== wh[1] || cells <= 0 ||
		args.length !== 2 + cells * 2) {
		post("[grid_matrix_bridge] replaceframe rejected dim=" + width + "x" + height +
			" values=" + Math.max(0, args.length - 2) + " expected=" + (wh[0] * wh[1] * 2) + "\n");
		return;
	}
	var nextForeground = new Uint8Array(cells);
	var background = new Uint8Array(cells);
	for (var i = 0; i < cells; i++) {
		nextForeground[i] = clamp(parseInt(args[2 + i], 10) || 0, 0, 15);
		background[i] = clamp(parseInt(args[2 + cells + i], 10) || 0, 0, 15);
	}
	foreground = nextForeground;
	bg = background;
	stateDirty.fill(1);
	fullStateFramePending = 1;
	flush();
}

function endframe() {
	if (frameBatchDepth === 0) return;
	frameBatchDepth--;
	if (frameBatchDepth === 0) send_level_maps();
}

function setcell(x, y, v) {
	x = x | 0;
	y = y | 0;
	v = clamp(Math.floor(v), 0, 15);
	var wh = dims_for_edition(edition);
	if (x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_matrix_bridge] setcell out of range x=" + x + " y=" + y +
			" dim=" + wh[0] + "x" + wh[1] + "\n");
		return;
	}
	var index = y * wh[0] + x;
	if (foreground[index] !== v) stateDirty[index] = 1;
	foreground[index] = v;
}

function setcell_bg(x, y, v) {
	x = x | 0;
	y = y | 0;
	v = clamp(Math.floor(v), 0, 15);
	var wh = dims_for_edition(edition);
	if (x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) return;
	var index = y * wh[0] + x;
	if (bg[index] !== v) stateDirty[index] = 1;
	bg[index] = v;
}

function clear_bg() {
	post("[grid_matrix_bridge] clear_bg() called\n");
	for (var i = 0; i < bg.length; i++) {
		if (bg[i]) stateDirty[i] = 1;
		bg[i] = 0;
	}
}

function fill_bg(v) {
	v = clamp(Math.floor(v), 0, 15);
	for (var i = 0; i < bg.length; i++) {
		if (bg[i] !== v) stateDirty[i] = 1;
		bg[i] = v;
	}
}

function fade_step() {
	// Retained as a compatibility no-op for the old grid_matrix_io demo inlet.
	// Fading the router-owned base matrix was the source of gradual grid clears;
	// all live fades now belong to grid_anim_engine's transient overlay.
}

function fill(v) {
	v = clamp(Math.floor(v), 0, 15);
	for (var i = 0; i < foreground.length; i++) {
		if (foreground[i] !== v) stateDirty[i] = 1;
		foreground[i] = v;
	}
}

/** Transient animation updates arrive from grid_anim_engine.js. */
function animcell(x, y, level, visible) {
	x = parseInt(x, 10);
	y = parseInt(y, 10);
	var wh = dims_for_edition(edition);
	if (!isFinite(x) || !isFinite(y) || x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_matrix_bridge] animcell out of range x=" + x + " y=" + y +
			" dim=" + wh[0] + "x" + wh[1] + "\n");
		return;
	}
	var index = y * wh[0] + x;
	animationLevels[index] = clamp(parseInt(level, 10) || 0, 0, 15);
	animationMask[index] = parseInt(visible, 10) ? 1 : 0;
	colorDirty[index] = 1;
	stateDirty[index] = 1;
}

function animclear() {
	for (var index = 0; index < animationMask.length; index++) {
		if (animationMask[index]) {
			colorDirty[index] = 1;
			stateDirty[index] = 1;
		}
	}
	animationLevels.fill(0);
	animationMask.fill(0);
}

function roleColorAt(index) {
	var offset = index * 3;
	return [roleColors[offset], roleColors[offset + 1], roleColors[offset + 2]];
}

function animationMotionModifier(index) {
	if (!animationMask[index]) return null;
	return {
		op: "half_add",
		rgb: [255, 255, 255],
		amount: Math.round(animationLevels[index] / 15 * 224)
	};
}

function composedColorAt(index) {
	var rgb = ColorMath.compose(roleColorAt(index), stateColorModifiers[index],
		animationMotionModifier(index) || motionColorModifiers[index]);
	return labelApplies(index) ? GridLabel.color(rgb, labelMask[index], labelAlpha) : rgb;
}

function updateComposedColor(index) {
	var rgb = composedColorAt(index);
	var offset = index * 3;
	var changed = hudColors[offset] !== rgb[0] || hudColors[offset + 1] !== rgb[1] ||
		hudColors[offset + 2] !== rgb[2];
	hudColors[offset] = rgb[0];
	hudColors[offset + 1] = rgb[1];
	hudColors[offset + 2] = rgb[2];
	colorDirty[index] = 0;
	return changed;
}

function flushComposedColorCells() {
	var wh = dims_for_edition(edition);
	for (var index = 0; index < colorDirty.length; index++) {
		if (!colorDirty[index]) continue;
		var force = colorDirty[index] > 1;
		var changed = updateComposedColor(index);
		if (!changed && !force) continue;
		var x = index % wh[0];
		var y = Math.floor(index / wh[0]);
		var offset = index * 3;
		var rgb = [hudColors[offset], hudColors[offset + 1], hudColors[offset + 2]];
		publishHud("grid_color_cell", x, y, rgb[0], rgb[1], rgb[2]);
		stateDirty[index] = 1;
		if (mechatrellisExtensionsEnabled === 1) {
			extension_cell("/grid/led/color/set", x, y, rgb);
		}
	}
}

function setRoleColor(index, rgb) {
	var normalized = ColorMath.normalizeRgb(rgb);
	var offset = index * 3;
	roleColors[offset] = normalized[0];
	roleColors[offset + 1] = normalized[1];
	roleColors[offset + 2] = normalized[2];
	// Role commands are explicit hardware requests. Preserve them even when the
	// Max-side composed value is unchanged (for example after enabling the
	// optional extension or reconnecting a device).
	colorDirty[index] = 2;
}

function colorModifier(operation, red, green, blue, amount) {
	if (String(operation || "").toLowerCase() === "none") return null;
	return ColorMath.normalizeModifier({
		op: operation,
		rgb: [red, green, blue],
		amount: amount
	});
}

function setColorModifier(layer, x, y, operation, red, green, blue, amount) {
	var wh = dims_for_edition(edition);
	var normalizedX = parseInt(x, 10);
	var normalizedY = parseInt(y, 10);
	if (!isFinite(normalizedX) || !isFinite(normalizedY) || normalizedX < 0 ||
		normalizedY < 0 || normalizedX >= wh[0] || normalizedY >= wh[1]) return false;
	var index = normalizedY * wh[0] + normalizedX;
	var modifier = colorModifier(operation, red, green, blue, amount);
	if (layer === "motion") motionColorModifiers[index] = modifier;
	else stateColorModifiers[index] = modifier;
	colorDirty[index] = 1;
	if (frameBatchDepth === 0) {
		flushComposedColorCells();
		flushV2StateUpdates();
	}
	return true;
}

function colorstatecell(x, y, operation, red, green, blue, amount) {
	return setColorModifier("state", x, y, operation, red, green, blue, amount);
}

function colormotioncell(x, y, operation, red, green, blue, amount) {
	return setColorModifier("motion", x, y, operation, red, green, blue, amount);
}

function colorlayersclear() {
	for (var index = 0; index < stateColorModifiers.length; index++) {
		stateColorModifiers[index] = null;
		motionColorModifiers[index] = null;
		colorDirty[index] = 1;
	}
}

function composedLevels() {
	var values = new Uint8Array(foreground.length);
	for (var index = 0; index < values.length; index++) {
		var base = foreground[index] > bg[index] ? foreground[index] : bg[index];
		var level = animationMask[index] ? animationLevels[index] : base;
		values[index] = labelApplies(index) ? GridLabel.level(level,labelMask[index],labelAlpha) : level;
	}
	return values;
}

function stateMapValues(levels, width, x0, y0) {
	var values = [];
	for (var y = 0; y < 4; y++) {
		for (var x = 0; x < 4; x++) {
			var index = (y0 + y) * width + x0 + x;
			var offset = index * 3;
			values.push(levels[index], hudColors[offset], hudColors[offset + 1],
				hudColors[offset + 2]);
		}
	}
	return values;
}

function outputV2(path, outputIndex, args) {
	noteExtensionPacket(path, 1);
	outlet.apply(this, [outputIndex, prefix + path].concat(args));
}

function v2DeviceSegments(width, height) {
	if (!dual128Mode) return [{ output: 0, logicalY: 0, height: height }];
	var segments = [{ output: 0, logicalY: 0, height: Math.min(8, height) }];
	if (height > 8) segments.push({ output: 1, logicalY: 8, height: height - 8 });
	return segments;
}

function sendV2FullStateFrame(levels, width, height) {
	var frameId = nextStateFrameId;
	nextStateFrameId = nextStateFrameId >= 255 ? 1 : nextStateFrameId + 1;
	var segments = v2DeviceSegments(width, height);
	for (var segmentIndex = 0; segmentIndex < segments.length; segmentIndex++) {
		var segment = segments[segmentIndex];
		outputV2("/grid/led/frame/begin", segment.output,
			[frameId, width, segment.height]);
		for (var logicalY = segment.logicalY;
			logicalY < segment.logicalY + segment.height; logicalY += 4) {
			for (var x = 0; x < width; x += 4) {
				outputV2("/grid/led/frame/map", segment.output,
					[frameId, x, logicalY - segment.logicalY].concat(
						stateMapValues(levels, width, x, logicalY)));
			}
		}
		outputV2("/grid/led/frame/commit", segment.output, [frameId]);
	}
	stateDirty.fill(0);
	fullStateFramePending = 0;
}

function sendV2SparseState(levels, width, height) {
	for (var y0 = 0; y0 < height; y0 += 4) {
		for (var x0 = 0; x0 < width; x0 += 4) {
			var dirtyCount = 0;
			for (var y = 0; y < 4; y++) {
				for (var x = 0; x < 4; x++) {
					if (stateDirty[(y0 + y) * width + x0 + x]) dirtyCount++;
				}
			}
			if (!dirtyCount) continue;
			var outputIndex = dual128Mode && y0 >= 8 ? 1 : 0;
			var deviceY = dual128Mode && y0 >= 8 ? y0 - 8 : y0;
			if (dirtyCount >= 4) {
				outputV2("/grid/led/state/map", outputIndex,
					[x0, deviceY].concat(stateMapValues(levels, width, x0, y0)));
				for (var mapY = 0; mapY < 4; mapY++) {
					for (var mapX = 0; mapX < 4; mapX++) {
						stateDirty[(y0 + mapY) * width + x0 + mapX] = 0;
					}
				}
			} else {
				for (var cellY = 0; cellY < 4; cellY++) {
					for (var cellX = 0; cellX < 4; cellX++) {
						var index = (y0 + cellY) * width + x0 + cellX;
						if (!stateDirty[index]) continue;
						var offset = index * 3;
						outputV2("/grid/led/state/set", outputIndex,
							[x0 + cellX, deviceY + cellY, levels[index],
								hudColors[offset], hudColors[offset + 1], hudColors[offset + 2]]);
						stateDirty[index] = 0;
					}
				}
			}
		}
	}
}

function flushV2StateUpdates() {
	if (mechatrellisExtensionsEnabled !== 2 || frameBatchDepth > 0) return;
	var wh = dims_for_edition(edition);
	var levels = composedLevels();
	if (fullStateFramePending) sendV2FullStateFrame(levels, wh[0], wh[1]);
	else sendV2SparseState(levels, wh[0], wh[1]);
}

function send_level_maps() {
	var wh = dims_for_edition(edition);
	var w = wh[0];
	var composite = composedLevels();
	publishHudLevelMaps(composite, w, wh[1]);
	flushComposedColorCells();
	hardwareStats.levelFrames++;
	hardwareStats.lastLevelFrameTime = Date.now();
	if (mechatrellisExtensionsEnabled === 2) {
		flushV2StateUpdates();
		return;
	}
	var path = prefix + "/grid/led/level/map";
	var regions = regions_for_edition(edition);
	hardwareStats.levelMapPackets += regions.length;
	for (var i = 0; i < regions.length; i++) {
		var ox = regions[i][0];
		var oy = regions[i][1];
		out_block(path, ox, oy, block8_from_u8(composite, w, ox, oy));
	}
}

function publishHudLevelMaps(composite, width, height) {
	var regions = regions_for_edition(edition);
	for (var region = 0; region < regions.length; region++) {
		var ox = regions[region][0];
		var oy = regions[region][1];
		if (oy >= height) continue;
		publishHud.apply(this, ["grid_level_map", ox, oy].concat(
			block8_from_u8(composite, width, ox, oy)));
	}
}

function publishHudColorMaps() {
	var wh = dims_for_edition(edition);
	for (var y0 = 0; y0 < wh[1]; y0 += 4) {
		for (var x0 = 0; x0 < wh[0]; x0 += 4) {
			var values = [];
			for (var y = 0; y < 4; y++) {
				for (var x = 0; x < 4; x++) {
					var offset = ((y0 + y) * wh[0] + x0 + x) * 3;
					values.push(hudColors[offset], hudColors[offset + 1], hudColors[offset + 2]);
				}
			}
			publishHud.apply(this, ["grid_color_map", x0, y0].concat(values));
		}
	}
}

function hudSnapshot() {
	var wh = dims_for_edition(edition);
	var width = wh[0];
	var composite = composedLevels();
	publishHudLevelMaps(composite, width, wh[1]);
	publishHudColorMaps();
}

function regions_for_edition(e) {
	if (e === 64) return [[0, 0]];
	if (e === 128) return [[0, 0], [8, 0]];
	return [[0, 0], [8, 0], [0, 8], [8, 8]];
}

function block8_from_u8(u8, w, ox, oy) {
	var out = [];
	for (var row = 0; row < 8; row++) {
		for (var col = 0; col < 8; col++) {
			out.push(u8[(oy + row) * w + (ox + col)]);
		}
	}
	return out;
}

function out_block(path, ox, oy, bytes) {
	if (!dual128Mode || oy < 8) {
		outlet.apply(this, [0, path, ox, oy].concat(bytes));
	} else {
		outlet.apply(this, [1, path, ox, oy - 8].concat(bytes));
	}
}

function clamp(n, lo, hi) {
	return Math.min(hi, Math.max(lo, n));
}

function mechatrellis(enabled) {
	var requested = parseInt(enabled, 10);
	mechatrellisExtensionsEnabled = isFinite(requested) ? clamp(requested, 0, 2) : 0;
	if (mechatrellisExtensionsEnabled === 2) {
		stateDirty.fill(1);
		fullStateFramePending = 1;
	}
	post("[grid_matrix_bridge] MechaTrellis private OSC " +
		(mechatrellisExtensionsEnabled ? "v" + mechatrellisExtensionsEnabled : "disabled") + "\n");
}

// MechaTrellis private OSC extension. These messages bypass the level matrix:
// persistent color commands change only the color layer, while RGB/level8
// commands can be used by callers that intentionally want 8-bit LED control.
function extension_cell(path, x, y, values) {
	if (!mechatrellisExtensionsEnabled) return;
	x = parseInt(x, 10);
	y = parseInt(y, 10);
	var wh = dims_for_edition(edition);
	if (!isFinite(x) || !isFinite(y) || x < 0 || y < 0 || x >= wh[0] || y >= wh[1]) {
		post("[grid_matrix_bridge] extension cell out of range\n");
		return;
	}
	var args = [prefix + path, x, y].concat(values);
	noteExtensionPacket(path, 1);
	if (!dual128Mode || y < 8) {
		outlet.apply(this, [0].concat(args));
	} else {
		args[2] = y - 8;
		outlet.apply(this, [1].concat(args));
	}
}

function extension_all(path, values) {
	if (!mechatrellisExtensionsEnabled) return;
	var args = [prefix + path].concat(values);
	noteExtensionPacket(path, dual128Mode ? 2 : 1);
	outlet.apply(this, [0].concat(args));
	if (dual128Mode) outlet.apply(this, [1].concat(args));
}

function extension_map(path, x, y, values) {
	if (!mechatrellisExtensionsEnabled) return;
	x = parseInt(x, 10);
	y = parseInt(y, 10);
	var wh = dims_for_edition(edition);
	if (!isFinite(x) || !isFinite(y) || x < 0 || y < 0 ||
		x + 4 > wh[0] || y + 4 > wh[1] || !values || values.length !== 48) {
		post("[grid_matrix_bridge] extension 4x4 map out of range\n");
		return;
	}
	if (dual128Mode && y < 8 && y + 4 > 8) {
		post("[grid_matrix_bridge] extension 4x4 map crosses dual-grid boundary\n");
		return;
	}
	var args = [prefix + path, x, y].concat(values);
	noteExtensionPacket(path, 1);
	if (!dual128Mode || y < 8) {
		outlet.apply(this, [0].concat(args));
	} else {
		args[2] = y - 8;
		outlet.apply(this, [1].concat(args));
	}
}

function colorcell(x, y, r, g, b) {
	var wh = dims_for_edition(edition);
	var normalizedX = parseInt(x, 10);
	var normalizedY = parseInt(y, 10);
	if (normalizedX >= 0 && normalizedY >= 0 && normalizedX < wh[0] && normalizedY < wh[1]) {
		setRoleColor(normalizedY * wh[0] + normalizedX, [r, g, b]);
		if (frameBatchDepth === 0) {
			flushComposedColorCells();
			flushV2StateUpdates();
		}
	}
}

function colormap() {
	var args = arrayfromargs(arguments);
	if (args.length !== 50) {
		post("[grid_matrix_bridge] colormap requires x y plus 16 RGB triples\n");
		return;
	}
	var colors = [];
	for (var i = 2; i < args.length; i++) {
		colors.push(clamp(parseInt(args[i], 10) || 0, 0, 255));
	}
	var wh = dims_for_edition(edition);
	var mapX = parseInt(args[0], 10);
	var mapY = parseInt(args[1], 10);
	if (mapX >= 0 && mapY >= 0 && mapX + 4 <= wh[0] && mapY + 4 <= wh[1]) {
		for (var cell = 0; cell < 16; cell++) {
			var index = (mapY + Math.floor(cell / 4)) * wh[0] + mapX + (cell % 4);
			setRoleColor(index, colors.slice(cell * 3, cell * 3 + 3));
			updateComposedColor(index);
			stateDirty[index] = 1;
			var offset = index * 3;
			colors[cell * 3] = hudColors[offset];
			colors[cell * 3 + 1] = hudColors[offset + 1];
			colors[cell * 3 + 2] = hudColors[offset + 2];
		}
		publishHud.apply(this, ["grid_color_map", mapX, mapY].concat(colors));
		if (mechatrellisExtensionsEnabled === 1) {
			extension_map("/grid/led/color/map", mapX, mapY, colors);
		} else if (mechatrellisExtensionsEnabled === 2 && frameBatchDepth === 0) {
			flushV2StateUpdates();
		}
	}
}

function colorall(r, g, b) {
	var values = ColorMath.normalizeRgb([r, g, b]);
	var hasModifiers = false;
	for (var cell = 0; cell < roleColors.length / 3; cell++) {
		if (stateColorModifiers[cell] || motionColorModifiers[cell] || animationMask[cell]) {
			hasModifiers = true;
		}
		setRoleColor(cell, values);
		updateComposedColor(cell);
	}
	if (mechatrellisExtensionsEnabled === 2) {
		publishHudColorMaps();
		stateDirty.fill(1);
		fullStateFramePending = 1;
		flushV2StateUpdates();
	} else if (!hasModifiers) {
		publishHud("grid_color_all", values[0], values[1], values[2]);
		extension_all("/grid/led/color/all", values);
	} else {
		publishHudColorMaps();
		var wh = dims_for_edition(edition);
		for (var y = 0; y < wh[1]; y += 4) {
			for (var x = 0; x < wh[0]; x += 4) {
				var map = [];
				for (var mapY = 0; mapY < 4; mapY++) {
					for (var mapX = 0; mapX < 4; mapX++) {
						var offset = ((y + mapY) * wh[0] + x + mapX) * 3;
						map.push(hudColors[offset], hudColors[offset + 1], hudColors[offset + 2]);
					}
				}
				extension_map("/grid/led/color/map", x, y, map);
			}
		}
	}
}

function colorpresetstore(slot) {
	var target = clamp(parseInt(slot, 10) || 0, 0, 7);
	hudColorPresets[target] = new Uint8Array(hudColors);
	if (mechatrellisExtensionsEnabled === 1) {
		extension_all("/grid/led/color/preset/store", [target]);
	}
}

function colorpresetrecall(slot) {
	var target = clamp(parseInt(slot, 10) || 0, 0, 7);
	if (hudColorPresets[target]) {
		roleColors = new Uint8Array(hudColorPresets[target]);
		stateColorModifiers = new Array(roleColors.length / 3).fill(null);
		motionColorModifiers = new Array(roleColors.length / 3).fill(null);
		hudColors = new Uint8Array(hudColorPresets[target]);
		colorDirty = new Uint8Array(roleColors.length / 3);
		publishHudColorMaps();
	}
	if (mechatrellisExtensionsEnabled === 1) {
		extension_all("/grid/led/color/preset/recall", [target]);
	} else if (mechatrellisExtensionsEnabled === 2) {
		stateDirty.fill(1);
		fullStateFramePending = 1;
		flushV2StateUpdates();
	}
}

function rgbcell(x, y, r, g, b) {
	var values = [
		clamp(parseInt(r, 10) || 0, 0, 255),
		clamp(parseInt(g, 10) || 0, 0, 255),
		clamp(parseInt(b, 10) || 0, 0, 255)
	];
	var wh = dims_for_edition(edition);
	var normalizedX = parseInt(x, 10);
	var normalizedY = parseInt(y, 10);
	if (normalizedX >= 0 && normalizedY >= 0 && normalizedX < wh[0] && normalizedY < wh[1]) {
		var offset = (normalizedY * wh[0] + normalizedX) * 3;
		roleColors[offset] = values[0];
		roleColors[offset + 1] = values[1];
		roleColors[offset + 2] = values[2];
		hudColors[offset] = values[0];
		hudColors[offset + 1] = values[1];
		hudColors[offset + 2] = values[2];
		publishHud("grid_color_cell", normalizedX, normalizedY, values[0], values[1], values[2]);
	}
	extension_cell("/grid/led/rgb/set", x, y, values);
}

function rgball(r, g, b) {
	var values = [
		clamp(parseInt(r, 10) || 0, 0, 255),
		clamp(parseInt(g, 10) || 0, 0, 255),
		clamp(parseInt(b, 10) || 0, 0, 255)
	];
	for (var cell = 0; cell < hudColors.length / 3; cell++) {
		roleColors[cell * 3] = values[0];
		roleColors[cell * 3 + 1] = values[1];
		roleColors[cell * 3 + 2] = values[2];
		hudColors[cell * 3] = values[0];
		hudColors[cell * 3 + 1] = values[1];
		hudColors[cell * 3 + 2] = values[2];
	}
	publishHud("grid_color_all", values[0], values[1], values[2]);
	extension_all("/grid/led/rgb/all", values);
}

function level8cell(x, y, level) {
	extension_cell("/grid/led/level8/set", x, y, [clamp(parseInt(level, 10) || 0, 0, 255)]);
}

function level8all(level) {
	extension_all("/grid/led/level8/all", [clamp(parseInt(level, 10) || 0, 0, 255)]);
}

function intensity8(level) {
	extension_all("/grid/led/intensity8", [clamp(parseInt(level, 10) || 0, 0, 255)]);
}

/**
 * Capture the authoritative Max-side matrix and color cache before recovery.
 * The firmware protocol is write-only, so this records what was requested,
 * packet counters, and volatile preset hashes—not a claimed hardware readback.
 */
function diagnostic_snapshot(incidentId) {
	var wh = dims_for_edition(edition);
	var composite = composedLevels();
	var presetHashes = [];
	for (var slot = 0; slot < hudColorPresets.length; slot++) {
		presetHashes.push(hudColorPresets[slot] ? byteHash(hudColorPresets[slot]) : null);
	}
	var snapshot = {
		edition: edition,
		width: wh[0],
		height: wh[1],
		prefix: prefix,
		dual128: dual128Mode,
		mechaTrellisExtensions: mechatrellisExtensionsEnabled,
		mechaTrellisProtocol: mechatrellisExtensionsEnabled,
		frameBatchDepth: frameBatchDepth,
		foreground: bytesToArray(foreground),
		background: bytesToArray(bg),
		animationLevels: bytesToArray(animationLevels),
		animationMask: bytesToArray(animationMask),
		composite: bytesToArray(composite),
		roleColors: bytesToArray(roleColors),
		stateColorModifiers: stateColorModifiers,
		motionColorModifiers: motionColorModifiers,
		colors: bytesToArray(hudColors),
		foregroundHash: byteHash(foreground),
		backgroundHash: byteHash(bg),
		animationLevelHash: byteHash(animationLevels),
		animationMaskHash: byteHash(animationMask),
		compositeHash: byteHash(composite),
		roleColorHash: byteHash(roleColors),
		colorHash: byteHash(hudColors),
		presetHashes: presetHashes,
		packetStats: {
			levelFrames: hardwareStats.levelFrames,
			levelMapPackets: hardwareStats.levelMapPackets,
			extensionPackets: hardwareStats.extensionPackets,
			colorSetPackets: hardwareStats.colorSetPackets,
			colorMapPackets: hardwareStats.colorMapPackets,
			colorAllPackets: hardwareStats.colorAllPackets,
			presetStorePackets: hardwareStats.presetStorePackets,
			presetRecallPackets: hardwareStats.presetRecallPackets,
			stateSetPackets: hardwareStats.stateSetPackets,
			stateMapPackets: hardwareStats.stateMapPackets,
			frameBeginPackets: hardwareStats.frameBeginPackets,
			frameMapPackets: hardwareStats.frameMapPackets,
			frameCommitPackets: hardwareStats.frameCommitPackets,
			lastLevelFrameTime: hardwareStats.lastLevelFrameTime,
			lastExtensionTime: hardwareStats.lastExtensionTime,
			lastExtensionPath: hardwareStats.lastExtensionPath
		}
	};
	messnamed("gridrouter", "displayDiagnosticSnapshot",
		String(incidentId || "unknown"), JSON.stringify(snapshot));
}

/** Send "dump" to this object to print fg/bg/composite state to Max console. */
function dump() {
	var wh = dims_for_edition(edition);
	var w = wh[0]; var h = wh[1];
	post("[grid_matrix_bridge] === DUMP fg/bg/composite === edition=" + edition + " dim=" + w + "x" + h + "\n");
	for (var y = 0; y < h; y++) {
		var fgRow = [], bgRow = [], cRow = [];
		for (var x = 0; x < w; x++) {
			var idx = y * w + x;
			var f = foreground[idx], b = bg[idx], c = f > b ? f : b;
			fgRow.push(f.toString(16));
			bgRow.push(b.toString(16));
			cRow.push(c.toString(16));
		}
		post("  row " + y + "  fg:[" + fgRow.join(" ") + "]  bg:[" + bgRow.join(" ") + "]  out:[" + cRow.join(" ") + "]\n");
	}
}

function anything() {
	var a = arrayfromargs(arguments);
	switch (messagename) {
		case "edition":
			set_edition(parseInt(a[0], 10));
			break;
		case "prefix":
			prefix = a.length ? a.join(" ") : "/box";
			break;
		case "dual128":
			dual128Mode = a[0] ? 1 : 0;
			post("[grid_matrix_bridge] dual128Mode=" + dual128Mode + "\n");
			break;
		case "mechatrellis":
			mechatrellis(a[0]);
			break;
		case "setcell_bg":
			if (a.length >= 3) setcell_bg(parseInt(a[0], 10), parseInt(a[1], 10), parseInt(a[2], 10));
			break;
		case "clear_bg":
			clear_bg();
			break;
		case "fill_bg":
			if (a.length >= 1) fill_bg(parseInt(a[0], 10));
			break;
		case "beginframe":
			beginframe();
			break;
		case "beginupdate":
			beginupdate();
			break;
		case "replaceframe":
			replaceframe.apply(this, a);
			break;
		case "endframe":
			endframe();
			break;
		case "endupdate":
			endframe();
			break;
		case "animcell":
			if (a.length >= 4) animcell(a[0], a[1], a[2], a[3]);
			break;
		case "animclear":
			animclear();
			break;
		case "colorlayersclear":
			colorlayersclear();
			break;
		case "colorstatecell":
			if (a.length >= 7) colorstatecell.apply(this, a);
			break;
		case "colormotioncell":
			if (a.length >= 7) colormotioncell.apply(this, a);
			break;
		case "colorcell":
			if (a.length >= 5) colorcell.apply(this, a);
			break;
		case "colorall":
			if (a.length >= 3) colorall.apply(this, a);
			break;
		case "colormap":
			if (a.length === 50) colormap.apply(this, a);
			break;
		case "colorpresetstore":
			if (a.length >= 1) colorpresetstore.apply(this, a);
			break;
		case "colorpresetrecall":
			if (a.length >= 1) colorpresetrecall.apply(this, a);
			break;
		case "rgbcell":
			if (a.length >= 5) rgbcell.apply(this, a);
			break;
		case "rgball":
			if (a.length >= 3) rgball.apply(this, a);
			break;
		case "level8cell":
			if (a.length >= 3) level8cell.apply(this, a);
			break;
		case "level8all":
			if (a.length >= 1) level8all.apply(this, a);
			break;
		case "intensity8":
			if (a.length >= 1) intensity8.apply(this, a);
			break;
	}
}
