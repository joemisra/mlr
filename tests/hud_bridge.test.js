const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'hud_bridge.js'), 'utf8');

function createHarness(bufferOptions = {}) {
	const named = [];
	const outlets = [];
	const tasks = [];
	const bufferNames = [];
	let peekCalls = 0;
	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		tasks.push(this);
	}
	Task.prototype.schedule = function () {};
	Task.prototype.cancel = function () {};
	function Buffer(name) {
		if (bufferOptions.missing) throw new Error('missing');
		this.name = name;
		bufferNames.push(name);
	}
	Buffer.prototype.framecount = () => bufferOptions.frames === undefined ? 512 : bufferOptions.frames;
	Buffer.prototype.channelcount = () => bufferOptions.channels === undefined ? 2 : bufferOptions.channels;
	Buffer.prototype.samplerate = () => bufferOptions.sampleRate === undefined ? 48000 : bufferOptions.sampleRate;
	Buffer.prototype.peek = (channel, frame) => {
		peekCalls++;
		return Math.sin(frame / 17) * (channel === 1 ? 1 : 0.5);
	};
	const context = vm.createContext({
		Buffer, Task,
		autowatch: 0,
		inlets: 0,
		outlets: 0,
		messnamed(...args) { named.push(args); },
		outlet(...args) { outlets.push(args); }
	});
	vm.runInContext(SOURCE, context, { filename: 'hud_bridge.js' });
	return { context, named, outlets, tasks, bufferNames, peekCalls: () => peekCalls };
}

test('HUD commands route through existing buses and use zero-based IDs', () => {
	const harness = createHarness();
	harness.context.snapshot();
	harness.context.target('group', 3);
	harness.context.bar(2);
	harness.context.transport('restart');
	harness.context.display_recover();
	harness.context.sample_assign(7, 19);
	harness.context.sample_audition(19);
	harness.context.sample_preview_stop();
	harness.context.sample_grid(1, 7, 19);
	harness.context.sample_grid(0, 7, 19);
	harness.context.color_role('rta.trigger', 12, 34, 56);
	harness.context.color_reset('rta.trigger');
	harness.context.strip_snapshot();
	harness.context.strip_select(4);
	harness.context.strip_set(4, 'engine', 2);
	harness.context.strip_set(4, 'threshold', -72);
	harness.context.strip_set(4, 'drive', 99);
	harness.context.rack_load(2, 1, 'vst3', 'C74_VST3:/Delay');
	harness.context.rack_bypass(2, 1, 1);
	harness.context.rack_open(2, 1);
	harness.context.rack_clear(2, 1);
	harness.context.rack_move(2, 1, 2);
	harness.context.session_save_as();
	harness.context.session_confirm('discard');
	assert.equal(harness.named.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'hudSnapshot'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'hudTarget' && message[3] === 3), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'displayRecover'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'assign' && message[2] === 7 && message[3] === 19), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'preview' && message[2] === 19), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'previewStop'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'browserOpen' &&
		message[2] === 7 && message[3] === 19), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'browserClose'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'hudColorRole' &&
		message[2] === 'rta.trigger' && message[3] === 12 && message[5] === 56), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'gridrouter' && message[1] === 'hudColorReset' &&
		message[2] === 'rta.trigger'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'channel_strip_snapshot' && message[1] === 'bang'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'mlr_rack_cmd' && message[1] === 'state_snapshot'), true);
	assert.equal(harness.named.some((message) =>
		message[0] === 'channel_strip_selected' && message[1] === 'int' && message[2] === 5), true);
	assert.equal(harness.named.some((message) =>
		message[0] === '5[channelstrip]engine' && message[1] === 'int' && message[2] === 2), true);
	assert.equal(harness.named.some((message) =>
		message[0] === '5[channelstrip]threshold' && message[1] === 'float' && message[2] === -60), true);
	assert.equal(harness.named.some((message) =>
		message[0] === '5[channelstrip]drive' && message[1] === 'float' && message[2] === 12), true);
	assert.equal(harness.named.some((message) => message[0] === 'mlr_session_dirty' &&
		message[1] === 'dirty'), true);
	assert.equal(harness.named.some((message) => message[0] === 'mlr_rack_cmd' &&
		message[1] === 'command' && message[2] === 2 && message[3] === 1 &&
		message[4] === 'load'), true);
	assert.equal(harness.named.some((message) => message[0] === 'mlr_session_cmd' &&
		message[1] === 'command' && message[2] === 'save_as'), true);
	assert.equal(harness.named.some((message) => message[0] === 'mlr_session_cmd' &&
		message[2] === 'confirm' && message[3] === 'discard'), true);
	assert.equal(harness.outlets.length, 0);
	harness.context.bank_open();
	assert.deepEqual(harness.outlets[0], [0, 'bank_open']);
	harness.context.bank_scan();
	assert.deepEqual(harness.outlets[1], [0, 'bank_scan']);
	harness.context.bank_folder('/Samples/One Shots');
	assert.equal(harness.named.some((message) =>
		message[0] === 'sample_bank' && message[1] === 'scanFolder' &&
		message[2] === '/Samples/One Shots'), true);
});

test('waveform adapter reads existing mono/stereo buffers into 256 min/max bins', () => {
	const harness = createHarness({ frames: 1024, channels: 2, sampleRate: 44100 });
	harness.context.waveform_request(8);
	const message = harness.named.find((candidate) =>
		candidate[0] === 'mlr_hud_state' && candidate[1] === 'waveform');
	assert.ok(message);
	const waveform = JSON.parse(message[3]);
	assert.equal(waveform.buffer, 8);
	assert.equal(waveform.channels.length, 2);
	assert.equal(waveform.channels[0].length, 256);
	assert.equal(waveform.frames, 1024);
	const firstReadCount = harness.peekCalls();
	harness.context.waveform_request(8);
	assert.equal(harness.peekCalls(), firstReadCount);
	harness.context.clearWaveformCache();
	harness.context.waveform_request(8);
	assert.equal(harness.peekCalls() > firstReadCount, true);
});

test('preview waveform reads the private audition buffer but retains the bank buffer ID', () => {
	const harness = createHarness({ frames: 240, channels: 1 });
	harness.context.previewWaveform(14);
	assert.equal(harness.bufferNames.at(-1), 'mlr_sample_preview');
	const message = harness.named.find((candidate) =>
		candidate[0] === 'mlr_hud_state' && candidate[1] === 'waveform');
	assert.ok(message);
	assert.equal(message[2], 14);
	assert.equal(JSON.parse(message[3]).buffer, 14);
});

test('waveform binning handles very short mono and long samples', () => {
	for (const options of [
		{ frames: 3, channels: 1, sampleRate: 48000 },
		{ frames: 5_000_000, channels: 1, sampleRate: 96000 }
	]) {
		const harness = createHarness(options);
		harness.context.waveform_request(10);
		const message = harness.named.find((candidate) => candidate[1] === 'waveform');
		const waveform = JSON.parse(message[3]);
		assert.equal(waveform.channels.length, 1);
		assert.equal(waveform.channels[0].length, 256);
		assert.equal(waveform.frames, options.frames);
	}
});

test('empty buffers report an empty waveform rather than reloading audio', () => {
	const harness = createHarness({ frames: 0, channels: 0 });
	harness.context.waveform_request(12);
	const waveformMessage = harness.named.find((candidate) =>
		candidate[0] === 'mlr_hud_state' && candidate[1] === 'waveform');
	assert.ok(waveformMessage);
	assert.deepEqual(JSON.parse(waveformMessage[3]).channels, []);
});

test('missing named buffers produce a safe empty result and notice', () => {
	const harness = createHarness({ missing: true });
	harness.context.waveform_request(99);
	assert.equal(harness.named.some((candidate) =>
		candidate[0] === 'mlr_hud_state' && candidate[1] === 'notice'), true);
	assert.equal(harness.named.some((candidate) =>
		candidate[0] === 'mlr_hud_state' && candidate[1] === 'waveform'), false);
});
