const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');

const ROOT = path.join(__dirname, '..');
const readPatch = (name) => JSON.parse(fs.readFileSync(path.join(ROOT, name), 'utf8')).patcher;

test('dedicated 720x480 HUD window contains named V8UI and state bridge', () => {
	const patch = readPatch('hud.maxpat');
	assert.equal(patch.rect[2] >= 720, true);
	assert.equal(patch.rect[3] >= 480, true);
	assert.equal(patch.openinpresentation, 1);
	const boxes = patch.boxes.map((entry) => entry.box);
	const ui = boxes.find((box) => box.varname === 'mlr_hud');
	assert.ok(ui);
	assert.equal(ui.maxclass, 'v8ui');
	assert.equal(ui.filename, 'hud.js');
	assert.deepEqual(ui.presentation_rect, [0, 0, 720, 480]);
	assert.equal(boxes.some((box) => box.text === 'r mlr_hud_state'), true);
	assert.equal(boxes.some((box) => box.text === 'v8 hud_bridge.js @autowatch 1'), true);
	assert.equal(boxes.some((box) => box.text === 'r [samplebank]reset'), true);
	assert.equal(boxes.some((box) => box.text === 'route bank_open bank_scan'), true);
	assert.equal(boxes.some((box) => box.text === 'opendialog fold'), true);
	assert.equal(boxes.some((box) => box.text === 'prepend bank_folder'), true);
	assert.equal(boxes.some((box) => box.text === 'sample_preview'), true);
	assert.equal(boxes.some((box) => box.text === 'r mlr_hud_preview_ready'), true);
});

test('sample audition uses a private buffer and the existing stereo output buses', () => {
	const patch = readPatch('sample_preview.maxpat');
	const boxes = patch.boxes.map((entry) => entry.box);
	assert.equal(boxes.some((box) => box.text === 'r mlr_sample_preview'), true);
	assert.equal(boxes.some((box) => box.text === 'buffer~ mlr_sample_preview 1000 2'), true);
	assert.equal(boxes.some((box) => box.text === 'play~ mlr_sample_preview 2'), true);
	assert.equal(boxes.some((box) => box.text === '*~ 0.2'), true);
	assert.equal(boxes.some((box) => box.text === 'send~ dac1'), true);
	assert.equal(boxes.some((box) => box.text === 'send~ dac2'), true);
	assert.equal(boxes.some((box) => box.text === 'prepend previewWaveform'), true);
	assert.equal(boxes.some((box) => box.text === 's mlr_hud_preview_ready'), true);
});

test('MLR root exposes a HUD opener wired to the dedicated patcher', () => {
	const patch = readPatch('_mlr.maxpat');
	const boxes = patch.boxes.map((entry) => entry.box);
	assert.equal(boxes.some((box) => box.varname === 'mlr_hud_open'), true);
	assert.equal(boxes.some((box) => box.varname === 'mlr_hud_host' && box.name === 'hud.maxpat'), true);
	assert.equal(boxes.some((box) => box.maxclass === 'newobj' && box.text === 'pcontrol'), true);
});

test('HUD publishers and command adapters remain separate from hardware protocol output', () => {
	const matrix = fs.readFileSync(path.join(ROOT, 'grid_matrix_bridge.js'), 'utf8');
	const router = fs.readFileSync(path.join(ROOT, 'grid_router.js'), 'utf8');
	const bank = fs.readFileSync(path.join(ROOT, 'sample_bank.js'), 'utf8');
	assert.match(matrix, /function hudSnapshot\(\)/);
	assert.match(matrix, /publishHudLevelMaps\(composite/);
	assert.match(router, /function hudTransport\(action\)/);
	assert.match(router, /stopSequence64Target\(workspace\.targetType/);
	assert.match(bank, /function assign\(trackIndex, sampleIndex\)/);
	assert.match(bank, /function bufferMetadata\(path, fileIndex, channels, durationMs, sampleRate\)/);
	assert.match(bank, /function scanFolder\(\)/);
	assert.match(bank, /function preview\(sampleIndex\)/);
	assert.match(router, /function dispatchSampleBrowser\(col, row, state\)/);
});

test('router is the only root display writer and mode changes use complete-frame replacement', () => {
	const main = readPatch('_mlr.maxpat');
	const matrixPatch = readPatch('grid_matrix_io.maxpat');
	const router = fs.readFileSync(path.join(ROOT, 'grid_router.js'), 'utf8');
	const incoming = main.lines.filter(({ patchline }) =>
		patchline.destination[0] === 'obj-172' && patchline.destination[1] === 0);
	assert.deepEqual(incoming.map(({ patchline }) => patchline.source[0]), ['obj-244']);
	assert.equal(matrixPatch.boxes.some(({ box }) => box.text === 'clear'), false);
	assert.match(router,
		/function renderCompletePage\(page, synchronizeLegacyState, skipColorRefresh\)/);
	assert.match(router, /"replaceframe", s\.gridWidth, s\.gridHeight/);
	assert.doesNotMatch(router, /outlet\(1, "beginframe"\)/);
	assert.doesNotMatch(router, /case 4: handleStepSeqPage/);
});

test('each player inserts the channel strip and four-slot rack before the legacy fader and routing', () => {
	const root = readPatch('_mlr.maxpat');
	const mixer = root.boxes.find(({ box }) => box.id === 'obj-239').box.patcher;
	assert.equal(mixer.boxes.filter(({ box }) => box.name === 'output.maxpat').length, 8);
	const output = readPatch('output.maxpat');
	assert.equal(output.boxes.some(({ box }) => box.text === 'pl #1'), true);
	const patch = readPatch('pl.maxpat');
	const boxes = patch.boxes.map((entry) => entry.box);
	const strip = boxes.find((box) => box.id === 'obj-channel-strip');
	const rack = boxes.find((box) => box.id === 'obj-plugin-rack');
	assert.ok(strip);
	assert.ok(rack);
	assert.equal(strip.text, 'channel_strip #1');
	assert.equal(rack.text, 'mlr_plugin_rack #1');
	const connections = patch.lines.map(({ patchline }) =>
		[patchline.source[0], patchline.source[1], patchline.destination[0], patchline.destination[1]].join(':'));
	assert.equal(connections.includes('obj-1:0:obj-channel-strip:0'), true);
	assert.equal(connections.includes('obj-1:1:obj-channel-strip:1'), true);
	assert.equal(connections.includes('obj-channel-strip:0:obj-plugin-rack:0'), true);
	assert.equal(connections.includes('obj-channel-strip:1:obj-plugin-rack:1'), true);
	assert.equal(connections.includes('obj-plugin-rack:0:obj-41:0'), true);
	assert.equal(connections.includes('obj-plugin-rack:1:obj-40:0'), true);
	assert.equal(connections.includes('obj-channel-strip:0:obj-41:0'), false);
	assert.equal(connections.includes('obj-channel-strip:1:obj-40:0'), false);
	assert.equal(connections.includes('obj-1:0:obj-41:0'), false);
	assert.equal(connections.includes('obj-1:1:obj-40:0'), false);
});

test('HUD hosts rack, transport, and modern session services while legacy presets stay hidden', () => {
	const hud = readPatch('hud.maxpat');
	const hudText = hud.boxes.map(({ box }) => box.text || '');
	for (const service of ['mlr_plugin_service', 'mlr_plugin_transport', 'mlr_session_service']) {
		assert.equal(hudText.includes(service), true, `missing ${service}`);
	}
	const root = readPatch('_mlr.maxpat');
	const legacy = root.boxes.find(({ box }) => box.id === 'obj-242').box.patcher;
	for (const id of ['obj-65', 'obj-117', 'obj-125']) {
		assert.equal(legacy.boxes.find(({ box }) => box.id === id).box.presentation, 0);
	}
});

test('channel strip has exact-bypass defaults, both compressor engines, filter locks, and selected metering', () => {
	const patch = readPatch('channel_strip.maxpat');
	const boxes = patch.boxes.map((entry) => entry.box);
	const text = boxes.map((box) => box.text || '');
	for (const required of [
		'mlr_filter', 'mlr_compressor', 'omx.comp~', 'mlr_saturator',
		'r #1[filterfx]level', 'loadmess 1.', 'loadmess 0', 'loadmess 0.',
		'r channel_strip_snapshot', 'r channel_strip_selected',
		'prepend channel_strip', 'prepend channel_strip_meter', 's mlr_hud_state'
	]) assert.equal(text.includes(required), true, `missing ${required}`);
	assert.equal(text.filter((value) => value === 's mlr_hud_state').length, 2);
	assert.equal(text.includes('metro 100'), true);
	assert.equal(text.includes('speedlim 90'), true);
});

test('custom Gen stages implement open filter bypass, stereo-linked gain, and zero-drive bypass', () => {
	function codeFrom(name) {
		const patch = readPatch(name);
		const codes = [];
		function visit(candidate) {
			if (!candidate || typeof candidate !== 'object') return;
			if (candidate.maxclass === 'codebox') codes.push(candidate.code || '');
			for (const value of Object.values(candidate)) {
				if (Array.isArray(value)) value.forEach(visit);
				else if (value && typeof value === 'object') visit(value);
			}
		}
		visit(patch);
		return codes.join('\n');
	}
	const filter = codeFrom('mlr_filter.maxpat');
	const compressor = codeFrom('mlr_compressor.maxpat');
	const saturator = codeFrom('mlr_saturator.maxpat');
	assert.match(filter, /cutoff = min\(baseCutoff, modCutoff\)/);
	assert.match(filter, /out1 = mix\(v2L, in1, openMix\)/);
	assert.match(compressor, /level = max\(abs\(in1\), abs\(in2\)\)/);
	assert.match(compressor, /Param threshold/);
	assert.match(compressor, /gainDb = 0;[\s\S]*if \(knee/);
	assert.match(saturator, /amount = clip\(drive_db \/ 12/);
	assert.match(saturator, /out1 = mix\(in1, satL, amount\)/);
});

test('channel-strip engine weights avoid the unsupported conditional expr form', () => {
	const patch = readPatch('channel_strip.maxpat');
	const expressions = patch.boxes.map((entry) => entry.box.text || '')
		.filter((text) => text.startsWith('expr '));
	assert.equal(expressions.some((text) => text.startsWith('expr if(')), false);
	assert.equal(expressions.includes('expr 1. - $f2 * ($i1 != 0)'), true);
	assert.equal(expressions.includes('expr $f2 * ($i1 == 1)'), true);
	assert.equal(expressions.includes('expr $f2 * ($i1 == 2)'), true);
});
