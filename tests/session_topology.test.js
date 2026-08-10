const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');

const ROOT = path.join(__dirname, '..');
const patch = (name) => JSON.parse(fs.readFileSync(path.join(ROOT, name), 'utf8')).patcher;

test('session service connects Max snapshot bridge, Node filesystem manager, dialogs, and recording exporter', () => {
	const session = patch('mlr_session_service.maxpat');
	const text = session.boxes.map(({ box }) => box.text || '');
	for (const required of [
		'r mlr_session_cmd', 'r mlr_session_dirty', 'r mlr_session_fragment',
		'r mlr_hud_state', 'r mlr_session_recording_state',
		'v8 mlr_session_bridge.js @autowatch 1',
		'node.script mlr_session_manager.js @autostart 1',
		'route save_dialog open_dialog relink_dialog', 'savedialog',
		'opendialog fold', 'mlr_recording_export'
	]) assert.equal(text.includes(required), true, `missing ${required}`);
	const recording = patch('mlr_recording_export.maxpat');
	const recordingText = recording.boxes.map(({ box }) => box.text || '');
	assert.equal(recordingText.includes('buffer~ mlr_session_export 1 2'), true);
	assert.equal(recordingText.includes('js mlr_recording_export.js'), true);
});

test('live record path reports active state and session snapshot derives only referenced 1file–7file buffers', () => {
	const record = patch('rec.maxpat');
	assert.equal(record.boxes.some(({ box }) => box.text === 's mlr_session_recording_state'), true);
	const router = fs.readFileSync(path.join(ROOT, 'grid_router.js'), 'utf8');
	assert.match(router, /function sessionRecordingSnapshot\(tracks\)/);
	assert.match(router, /bufferIndex < 1 \|\| bufferIndex > 7/);
	assert.match(router, /messnamed\(recordingBuffer \+ "load", "replace"/);
	const bridge = fs.readFileSync(path.join(ROOT, 'mlr_session_bridge.js'), 'utf8');
	assert.match(bridge, /Stop live recording before saving/);
	assert.match(bridge, /mlr_session_recording_export/);
	assert.match(bridge, /function router_dict\(/);
	assert.match(bridge, /sessionApplyDict/);
});

test('session load applies only preflighted stopped state and excludes hardware/transient caches', () => {
	const core = fs.readFileSync(path.join(ROOT, 'mlr_session_core.js'), 'utf8');
	const manager = fs.readFileSync(path.join(ROOT, 'mlr_session_manager.js'), 'utf8');
	const router = fs.readFileSync(path.join(ROOT, 'grid_router.js'), 'utf8');
	assert.match(manager, /validateDocument\(document\)/);
	assert.match(manager, /atomicInstall/);
	assert.match(router, /function sessionStopAndReset\(\)/);
	assert.match(router, /workspace\.propertyStacks64 = \{\}/);
	assert.match(router, /function sessionApplyDict\(dictName\)/);
	for (const forbidden of ['serialosc', 'grid cache', 'playhead phase']) {
		assert.equal(core.includes(`\"${forbidden}\"`), false);
	}
});
