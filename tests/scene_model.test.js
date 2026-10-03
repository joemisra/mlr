const assert = require('node:assert/strict');
const test = require('node:test');

const Scenes = require('../scene_model.js');

function tracks(marker = 0) {
	return Array.from({ length: 16 }, (_, id) => ({
		id, group: id % 8, buffer: marker + id, sampleRef: null,
		loopStart: 0, loopEnd: 16
	}));
}

test('legacy aliases become Scene 1 group patterns and one independent Track Slot', () => {
	const legacy = {
		'group:0': { running: 1, bars: [{ length: 16, steps: [] }] },
		'track:3': { running: 0, bars: [{ length: 8, steps: [] }] }
	};
	const state = Scenes.createState(tracks(20), legacy, {
		sources: { 'group:0:lfo1': { shape: 'sine' }, 'track:3:lfo1': { shape: 'triangle' } },
		routes: [
			{ scope: 'group', targetId: 0 },
			{ scope: 'track', targetId: 3 }
		]
	});

	assert.equal(state.version, 2);
	assert.equal(state.scenes.length, 1);
	assert.equal(state.scenes[0].trackSlotRef, 'trackslot:0');
	assert.equal(state.scenes[0].groupPatternRefs[0], 'group-pattern:0:0');
	assert.equal(state.scenes[0].groupLaunch[0], 1);
	assert.equal(state.patternLibrary['group-pattern:0:0'].running, 1);
	assert.equal(state.patternLibrary['trackslot:0:track-pattern:3'].bars[0].length, 8);
	assert.equal(state.trackSlots['trackslot:0'].tracks[3].buffer, 23);
	assert.equal(state.trackSlots['trackslot:0'].tracks[3].playbackLoop, 1);
	assert.deepEqual(Object.keys(state.trackSlots['trackslot:0'].modulation.sources),
		['track:3:lfo1']);
});

test('a new Scene creates its matching empty Track Slot, but never overwrites an existing one', () => {
	const state = Scenes.createState(tracks(10), {}, {});
	const scene = Scenes.ensureScene(state, 2, {
		scene: state.scenes[0],
		trackSlotRef: 'trackslot:0',
		tracks: tracks(80),
		modulation: { sources: {}, routes: [] },
		trackPatternRefs: state.trackSlots['trackslot:0'].trackPatternRefs
	});

	assert.equal(state.scenes.length, 3);
	assert.equal(state.scenes[1], null);
	assert.equal(state.trackSlots['trackslot:1'], undefined);
	assert.equal(scene.id, 'scene:2');
	assert.equal(scene.trackSlotRef, 'trackslot:2');
	assert.deepEqual(scene.groupPatternRefs, state.scenes[0].groupPatternRefs);
	assert.notEqual(scene.groupPatternRefs, state.scenes[0].groupPatternRefs);
	assert.equal(state.trackSlots['trackslot:2'].tracks[0].buffer, 80);

	Scenes.ensureTrackSlot(state, 1, { tracks: tracks(200) });
	const scene2 = Scenes.ensureScene(state, 1, {
		scene: state.scenes[0], trackSlotRef: 'trackslot:0', tracks: tracks(300)
	});
	assert.equal(scene2.trackSlotRef, 'trackslot:0');
	assert.equal(state.trackSlots['trackslot:1'].tracks[0].buffer, 200);
});

test('sparse Scene and Track Slot libraries survive sanitizing independently', () => {
	const state = Scenes.createState(tracks(10), {}, {});
	Scenes.ensureScene(state, 15, { scene: state.scenes[0], tracks: tracks(90) });
	Scenes.ensureTrackSlot(state, 7, { tracks: tracks(70) });
	const clean = Scenes.sanitizeState(state, tracks(), {}, {});

	assert.equal(clean.scenes.length, 16);
	assert.equal(clean.scenes[1], null);
	assert.equal(clean.scenes[14], null);
	assert.equal(clean.scenes[15].id, 'scene:15');
	assert.equal(clean.trackSlots['trackslot:1'], undefined);
	assert.equal(clean.trackSlots['trackslot:7'].tracks[0].buffer, 70);
	assert.equal(clean.trackSlots['trackslot:15'].tracks[0].buffer, 90);
});

test('Scenes reference concrete Track Slots while cloning a Slot stays cycle-free', () => {
	const state = Scenes.createState(tracks(10), {}, {});
	state.trackSlots['trackslot:0'].tracks[0].playbackLoop = 0;
	Scenes.ensureScene(state, 1, { scene: state.scenes[0], tracks: tracks(40) });
	Scenes.ensureScene(state, 2, { scene: state.scenes[0], tracks: tracks(70) });

	assert.equal(Scenes.setSceneTrackSlot(state, 1, 0), true);
	assert.equal(Scenes.setSceneTrackSlot(state, 2, 0), true);
	assert.equal(state.scenes[1].trackSlotRef, 'trackslot:0');
	assert.equal(state.scenes[2].trackSlotRef, 'trackslot:0');
	assert.equal(Scenes.trackSlotSceneCount(state, 'trackslot:0'), 3);

	const fork = Scenes.ensureTrackSlot(state, 3, {
		sourceTrackSlotRef: 'trackslot:0'
	});
	assert.equal(Scenes.setSceneTrackSlot(state, 2, 3), true);
	assert.equal(fork.tracks[0].buffer, 10);
	assert.equal(fork.tracks[0].playbackLoop, 0);
	state.trackSlots['trackslot:0'].tracks[0].buffer = 999;
	assert.equal(fork.tracks[0].buffer, 10);
});

test('v1 Track Sets migrate to canonical v2 Track Slots without dangling links', () => {
	const source = {
		version: 1,
		activeSceneId: 'scene:0',
		selectedSceneId: 'scene:0',
		scenes: [{
			id: 'scene:0', ownTrackSetId: 'trackset:0', trackSetRef: 'trackset:0',
			groupPatternRefs: Array.from({ length: 8 }, (_, group) => `group-pattern:${group}:0`),
			groupLaunch: Array(8).fill(0)
		}],
		trackSets: {
			'trackset:0': {
				id: 'trackset:0', tracks: tracks(30),
				trackPatternRefs: Array.from({ length: 16 }, (_, track) =>
					`trackset:0:track-pattern:${track}`),
				modulation: { sources: {}, routes: [] }
			}
		},
		patternLibrary: {
			'trackset:0:track-pattern:4': { bars: [{ length: 12, steps: [] }] }
		},
		pendingLaunch: { sceneIndex: 12 }
	};
	const clean = Scenes.sanitizeState(source, tracks(), {}, {});

	assert.equal(clean.version, 2);
	assert.equal(clean.scenes[0].trackSlotRef, 'trackslot:0');
	assert.equal(clean.scenes[0].ownTrackSetId, undefined);
	assert.equal(clean.trackSets, undefined);
	assert.equal(clean.trackSlots['trackslot:0'].tracks.length, 16);
	assert.equal(clean.patternLibrary['trackslot:0:track-pattern:4'].bars[0].length, 12);
	assert.equal(clean.pendingLaunch, undefined);
});

test('Track Slot modulation replacement preserves group-scoped modulation', () => {
	const merged = Scenes.mergeTrackModulation({
		sources: { 'group:0:lfo1': { shape: 'sine' }, 'track:0:lfo1': { shape: 'old' } },
		routes: [{ scope: 'group', targetId: 0 }, { scope: 'track', targetId: 0 }]
	}, {
		sources: { 'track:0:lfo1': { shape: 'new' } },
		routes: [{ scope: 'track', targetId: 0, amount: 0.75 }]
	});

	assert.equal(merged.sources['group:0:lfo1'].shape, 'sine');
	assert.equal(merged.sources['track:0:lfo1'].shape, 'new');
	assert.deepEqual(merged.routes.map((route) => route.scope), ['group', 'track']);
	assert.equal(merged.routes[1].amount, 0.75);
});
