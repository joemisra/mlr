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
	assert.equal(recording.lines.some(({ patchline }) =>
		patchline.source[0] === 'obj-buffer' && patchline.source[1] === 1 &&
		patchline.destination[0] === 'obj-js' && patchline.destination[1] === 1), true,
	'buffer completion outlet must acknowledge the recording export');
});

test('live record path reports active state and session snapshot retains registered capture buffers', () => {
	const record = patch('rec.maxpat');
	assert.equal(record.boxes.some(({ box }) => box.text === 's mlr_session_recording_state'), true);
	const router = fs.readFileSync(path.join(ROOT, 'grid_router.js'), 'utf8');
	assert.match(router, /function sessionRecordingSnapshot\(tracks\)/);
	assert.match(router, /knownRecordingBuffers/);
	assert.match(router, /sessionRecordingRestoreTask\.schedule\(75\)/);
	assert.match(router, /messnamed\(recording\.buffer \+ "load", "replace"/);
	const bridge = fs.readFileSync(path.join(ROOT, 'mlr_session_bridge.js'), 'utf8');
	assert.match(bridge, /Stop live recording before saving/);
	assert.match(bridge, /mlr_session_recording_export/);
	assert.match(bridge, /function router_dict\(/);
	assert.match(bridge, /sessionApplyDict/);
});

test('per-track capture stays stereo and changes record state only on native bar boundaries', () => {
	const main = patch('_mlr.maxpat');
	const capture = patch('mlr_track_capture.maxpat');
	const mainText = main.boxes.map(({ box }) => box.text || '');
	const text = capture.boxes.map(({ box }) => box.text || '');
	assert.equal(mainText.includes('mlr_track_capture'), true);
	for (const required of [
		'r mlr_track_capture', 'r sequence64_pulse', 'counter 0 63',
		'receive~ rec1', 'receive~ rec2', 'receive~ out1', 'receive~ out2',
		'selector~ 2', 'record~ 1file 2', 's sample_bank'
	]) assert.equal(text.includes(required), true, `missing ${required}`);
	const hasConnection = (source, outlet, destination, inlet) => capture.lines.some(({ patchline }) =>
		patchline.source[0] === source && patchline.source[1] === outlet &&
		patchline.destination[0] === destination && patchline.destination[1] === inlet);
	assert.equal(hasConnection('obj-rpulse', 0, 'obj-counter', 0), true);
	assert.equal(hasConnection('obj-boundary', 0, 'obj-boundary-order', 0), true);
	assert.equal(hasConnection('obj-record-one', 0, 'obj-record', 0), true);
	assert.equal(hasConnection('obj-record-zero', 0, 'obj-record', 0), true);
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
