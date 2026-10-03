const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const test = require('node:test');

const Core = require('../mlr_session_core.js');
const Manager = require('../mlr_session_manager.js');

test('manager publishes open and relink documents through the pre-created Max dictionary', () => {
	assert.equal(Manager.TRANSFER_DICT_NAME, 'mlr_session_manager_transfer');
});

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

test('current document sanitizes runtime transport state without losing programming', () => {
	const fragments = fixture();
	fragments.router.patterns['group:0'] = { running: 1, defaultTrack: 2, lastUsedTrack: 14, steps: [{
		cut: { track: -1, slice: 4, gateLength: 3 }, locks: { filter: { value: 8 } }
	}] };
	fragments.router.automation = { armed: true, recording: true, playing: true, events: [{ x: 1 }] };
	fragments.rack.groups[0].slots[0] = { format: 'vst3', uri: 'C74_VST3:/Delay',
		name: 'Delay', loaded: 1, bypassed: 0 };
	const document = Core.buildDocument(fragments);
	assert.deepEqual(Core.validateDocument(document), { valid: true, errors: [] });
	assert.equal(document.rta.patterns['group:0'].running, 0);
	assert.equal(document.rta.patterns['group:0'].defaultTrack, 2);
	assert.equal(document.rta.patterns['group:0'].lastUsedTrack, 14);
	assert.equal(document.rta.sceneState.patternLibrary['group-pattern:0:0'].lastUsedTrack, 14);
	assert.equal(document.rta.patterns['group:0'].bars[0].steps[0].cut.slice, 4);
	assert.equal(document.rta.patterns['group:0'].bars[0].steps[1].probability, 15);
	assert.equal(document.automation.recording, false);
	assert.equal(document.racks[0].slots[0].snapshot, 'plugins/g01-s01.maxsnap');
});

test('version-one sessions migrate through modulation into a Scene 1 v4 document', () => {
	const legacy = Core.buildDocument(fixture());
	legacy.version = 1;
	delete legacy.modulation;
	delete legacy.rta.sceneState;
	const migrated = Core.migrateDocument(legacy);
	assert.equal(migrated.version, 4);
	assert.deepEqual(migrated.modulation, { sources: {}, routes: [] });
	assert.equal(migrated.rta.sceneState.scenes[0].id, 'scene:0');
	assert.equal(migrated.rta.sceneState.scenes[0].trackSlotRef, 'trackslot:0');
	assert.deepEqual(Core.validateDocument(migrated), { valid: true, errors: [] });
	assert.equal(legacy.modulation, undefined, 'migration must not mutate the parsed document');
});

test('version-two aliases migrate into Scene 1 without losing group or track programming', () => {
	const legacy = Core.buildDocument(fixture());
	legacy.version = 2;
	delete legacy.rta.sceneState;
	legacy.rta.patterns = {
		'group:2': { defaultTrack: 4, steps: [{ cut: { track: 4, slice: 7 } }] },
		'track:4': { steps: [{ cut: { track: 4, slice: 2 } }] }
	};
	const migrated = Core.migrateDocument(legacy);
	const scenes = migrated.rta.sceneState;
	assert.equal(migrated.version, 4);
	assert.equal(scenes.patternLibrary['group-pattern:2:0'].bars[0].steps[0].cut.slice, 7);
	assert.equal(scenes.patternLibrary['trackslot:0:track-pattern:4'].bars[0].steps[0].cut.slice, 2);
	assert.equal(scenes.trackSlots['trackslot:0'].tracks.length, 16);
});

test('version-three Track Sets migrate to canonical Track Slots and pattern references', () => {
	const legacy = Core.buildDocument(fixture());
	legacy.version = 3;
	legacy.rta.sceneState = {
		version: 1,
		activeSceneId: 'scene:0',
		selectedSceneId: 'scene:0',
		scenes: [{
			id: 'scene:0', name: 'Scene 1', ownTrackSetId: 'trackset:0',
			trackSetRef: 'trackset:0',
			groupPatternRefs: Array.from({ length: 8 }, (_, group) =>
				`group-pattern:${group}:0`),
			groupLaunch: Array(8).fill(0)
		}],
		trackSets: {
			'trackset:0': {
				id: 'trackset:0', name: 'Track Set 1', tracks: fixture().router.tracks,
				trackPatternRefs: Array.from({ length: 16 }, (_, track) =>
					`trackset:0:track-pattern:${track}`),
				modulation: { sources: {}, routes: [] }
			}
		},
		patternLibrary: {
			'trackset:0:track-pattern:2': {
				bars: [{ length: 16, steps: [{ cut: { track: 2, slice: 6 } }] }]
			}
		}
	};
	const migrated = Core.migrateDocument(legacy);
	assert.equal(migrated.version, 4);
	assert.equal(migrated.rta.sceneState.scenes[0].trackSlotRef, 'trackslot:0');
	assert.equal(migrated.rta.sceneState.trackSets, undefined);
	assert.equal(migrated.rta.sceneState.patternLibrary[
		'trackslot:0:track-pattern:2'].bars[0].steps[0].cut.slice, 6);
	assert.deepEqual(Core.validateDocument(migrated), { valid: true, errors: [] });
});

test('session documents persist sanitized modulation routes and future descriptors', () => {
	const fragments = fixture();
	fragments.router.modulation = {
		sources: {
			'group:0:lfo1': { rate: [1, 8], shape: 'triangle' },
			'track:2:future': { type: 'asl', program: 'to(1, 1)', enabled: true }
		},
		routes: [
			{ scope: 'group', targetId: 0, parameterId: 'filter', sourceId: 'lfo1', amount: 0.5 },
			{ scope: 'track', targetId: 2, parameterId: 'pan', sourceId: 'future', amount: 1 }
		]
	};
	const document = Core.buildDocument(fragments);
	assert.equal(document.version, 4);
	assert.deepEqual(document.modulation.sources['group:0:lfo1'].rate, [1, 8]);
	assert.equal(document.modulation.routes[0].enabled, true);
	assert.equal(document.modulation.sources['track:2:future'].program, 'to(1, 1)');
	assert.equal(document.modulation.routes[1].enabled, false);
	assert.deepEqual(Core.validateDocument(document), { valid: true, errors: [] });
});

test('v4 documents persist Scene combinations and shared Track Slot references', () => {
	const fragments = fixture();
	const sceneState = Core.sanitizeSceneState(null, fragments.router.tracks, {}, {});
	const Scenes = require('../scene_model.js');
	Scenes.ensureScene(sceneState, 1, {
		scene: sceneState.scenes[0], tracks: fragments.router.tracks
	});
	sceneState.scenes[1].groupPatternRefs[3] = 'group-pattern:3:5';
	Scenes.setSceneTrackSlot(sceneState, 1, 0);
	fragments.router.sceneState = sceneState;
	const document = Core.buildDocument(fragments);

	assert.equal(document.version, 4);
	assert.equal(document.rta.sceneState.scenes[1].groupPatternRefs[3], 'group-pattern:3:5');
	assert.equal(document.rta.sceneState.scenes[1].trackSlotRef, 'trackslot:0');
	assert.deepEqual(Core.validateDocument(document), { valid: true, errors: [] });
});

test('v4 documents preserve empty Scene slots without inventing intermediate Track Slots', () => {
	const fragments = fixture();
	const Scenes = require('../scene_model.js');
	const sceneState = Core.sanitizeSceneState(null, fragments.router.tracks, {}, {});
	Scenes.ensureScene(sceneState, 15, {
		scene: sceneState.scenes[0], tracks: fragments.router.tracks
	});
	fragments.router.sceneState = sceneState;
	const document = Core.buildDocument(fragments);

	assert.equal(document.rta.sceneState.scenes.length, 16);
	assert.equal(document.rta.sceneState.scenes[1], null);
	assert.equal(document.rta.sceneState.scenes[14], null);
	assert.equal(document.rta.sceneState.scenes[15].id, 'scene:15');
	assert.equal(document.rta.sceneState.trackSlots['trackslot:1'], undefined);
	assert.deepEqual(Core.validateDocument(document), { valid: true, errors: [] });
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

test('relink uses each scanned folder root when identical filenames exist', () => {
	const document = Core.buildDocument(fixture());
	document.bank.folders = [
		{ id: 'folder:0', name: 'Drums', path: '/old/drums' },
		{ id: 'folder:1', name: 'Textures', path: '/old/textures' }
	];
	document.bank.samples = [
		{ path: '/old/drums/kits/shared.wav', folderId: 'folder:0' },
		{ path: '/old/textures/air/shared.wav', folderId: 'folder:1' }
	];
	const result = Core.relinkSamples(document, [
		'/new/library/kits/shared.wav', '/new/library/air/shared.wav'
	], () => false);
	assert.equal(result.document.bank.samples[0].path, '/new/library/kits/shared.wav');
	assert.equal(result.document.bank.samples[1].path, '/new/library/air/shared.wav');
	assert.deepEqual(result.unresolved, []);
	assert.deepEqual(Core.validateDocument(result.document), { valid: true, errors: [] });
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

test('Max macOS volume paths resolve to filesystem paths before save and open', () => {
	if (process.platform !== 'darwin') return;
	const homeTarget = path.join(os.homedir(), 'Music', 'MLR Session Test');
	const maxPath = `Macintosh HD:${homeTarget}`;
	assert.equal(Manager.filesystemPath(maxPath), homeTarget);
	assert.equal(Manager.bundlePath(maxPath), `${homeTarget}.mlr-session`);
	assert.equal(Manager.sessionJsonPath(`${maxPath}.mlr-session`),
		`${homeTarget}.mlr-session/session.json`);
	assert.equal(Manager.filesystemPath('External Disk:/MLR/Jam'),
		'/Volumes/External Disk/MLR/Jam');
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

test('recording assets may use any distinct physical file buffer through 250', () => {
	const fragments = fixture();
	fragments.router.recordings = [
		{ id: 'capture-a', bufferIndex: 10, bufferName: '10file' },
		{ id: 'capture-b', bufferIndex: 250, bufferName: '250file' }
	];
	const document = Core.buildDocument(fragments);
	assert.deepEqual(Core.validateDocument(document), { valid: true, errors: [] });

	document.recordings[1].bufferName = '251file';
	assert.equal(Core.validateDocument(document).valid, false);
});
