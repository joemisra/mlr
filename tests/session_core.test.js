const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const test = require('node:test');

const Core = require('../mlr_session_core.js');
const Manager = require('../mlr_session_manager.js');

function fixture() {
	const tracks = Array.from({ length: 16 }, (_, id) => ({ id, group: id % 8, buffer: id + 8 }));
	const groups = Array.from({ length: 8 }, (_, id) => ({ id, volume: 100 }));
	const channelStrips = Array.from({ length: 8 }, (_, id) => ({ id, cutoff: 1 }));
	const racks = Array.from({ length: 8 }, (_, id) => ({ id,
		slots: Array.from({ length: 4 }, () => ({ name: 'Empty', loaded: 0 })) }));
	return { router: { tracks, groups, patterns: {}, targetAutomation: {}, automation: {}, recordings: [] },
		bank: { root: '/samples', samples: [], assignments: Array(16).fill(-1) },
		rack: { groups: racks }, channelStrips, transport: { bpm: 126, quantize: 16 }, colors: {} };
}

test('version-one document sanitizes runtime transport state without losing programming', () => {
	const fragments = fixture();
	fragments.router.patterns['group:0'] = { running: 1, defaultTrack: 2, steps: [{
		cut: { track: -1, slice: 4, gateLength: 3 }, locks: { filter: { value: 8 } }
	}] };
	fragments.router.automation = { armed: true, recording: true, playing: true, events: [{ x: 1 }] };
	fragments.rack.groups[0].slots[0] = { format: 'vst3', uri: 'C74_VST3:/Delay',
		name: 'Delay', loaded: 1, bypassed: 0 };
	const document = Core.buildDocument(fragments);
	assert.deepEqual(Core.validateDocument(document), { valid: true, errors: [] });
	assert.equal(document.rta.patterns['group:0'].running, 0);
	assert.equal(document.rta.patterns['group:0'].defaultTrack, 2);
	assert.equal(document.rta.patterns['group:0'].bars[0].steps[0].cut.slice, 4);
	assert.equal(document.rta.patterns['group:0'].bars[0].steps[1].probability, 15);
	assert.equal(document.automation.recording, false);
	assert.equal(document.racks[0].slots[0].snapshot, 'plugins/g01-s01.maxsnap');
});

test('newer or malformed bundles fail preflight before apply', () => {
	const document = Core.buildDocument(fixture());
	assert.equal(Core.validateDocument({ ...document, version: 99 }).valid, false);
	assert.equal(Core.validateDocument({ ...document, tracks: [] }).valid, false);
	assert.equal(Core.validateDocument({ ...document, format: 'legacy' }).valid, false);
	const vst2 = structuredClone(document);
	vst2.racks[0].slots[0] = { format: 'vst2', uri: 'OldPlugin', snapshot: '../escape' };
	assert.equal(Core.validateDocument(vst2).valid, false);
});

test('relink prefers a unique relative suffix then a unique exact filename', () => {
	const document = Core.buildDocument(fixture());
	document.bank.samples = [
		{ path: '/old/root/drums/kick.wav' },
		{ path: '/old/root/snare.wav' },
		{ path: '/old/root/ambiguous.wav' }
	];
	document.bank.root = '/old/root';
	const result = Core.relinkSamples(document, [
		'/new/library/drums/kick.wav', '/new/library/snare.wav',
		'/a/ambiguous.wav', '/b/ambiguous.wav'
	], () => false);
	assert.equal(result.document.bank.samples[0].path, '/new/library/drums/kick.wav');
	assert.equal(result.document.bank.samples[1].path, '/new/library/snare.wav');
	assert.equal(result.unresolved[0].ambiguous, true);
});

test('bundle reader validates and atomic install replaces only a .mlr-session target', () => {
	const temporary = fs.mkdtempSync(path.join(os.tmpdir(), 'mlr-session-test-'));
	try {
		const target = path.join(temporary, 'Jam.mlr-session');
		const staging = path.join(temporary, 'staging');
		fs.mkdirSync(target);
		fs.writeFileSync(path.join(target, 'old.txt'), 'old');
		fs.mkdirSync(staging);
		const document = Core.buildDocument(fixture());
		fs.writeFileSync(path.join(staging, 'session.json'), JSON.stringify(document));
		Manager.atomicInstall(staging, target);
		assert.equal(fs.existsSync(path.join(target, 'old.txt')), false);
		assert.equal(Manager.readDocument(target).document.format, Core.FORMAT);
		assert.throws(() => Manager.atomicInstall(path.join(temporary, 'missing'), path.join(temporary, 'unsafe')),
			/non-session/);
	} finally {
		fs.rmSync(temporary, { recursive: true, force: true });
	}
});

test('recording and plugin sidecars are unique and resolved inside the bundle', () => {
	const fragments = fixture();
	fragments.router.recordings = [{ bufferIndex: 1, bufferName: '1file' },
		{ bufferIndex: 2, bufferName: '2file' }];
	fragments.rack.groups[2].slots[3] = { format: 'au', uri: 'C74_AU:/aufx/test', loaded: 1 };
	const document = Core.buildDocument(fragments);
	assert.deepEqual(document.recordings.map((item) => item.bundlePath),
		['recordings/recording-01.wav', 'recordings/recording-02.wav']);
	assert.equal(document.racks[2].slots[3].snapshot, 'plugins/g03-s04.maxsnap');
	const resolved = Manager.resolveBundleAssets(document, '/tmp/Test.mlr-session');
	assert.equal(resolved.recordings[0].resolvedPath,
		'/tmp/Test.mlr-session/recordings/recording-01.wav');
	assert.equal(resolved.racks[2].slots[3].snapshot,
		'/tmp/Test.mlr-session/plugins/g03-s04.maxsnap');
});
