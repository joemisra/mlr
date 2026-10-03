const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'mlr_session_bridge.js'), 'utf8');
const Core = require('../mlr_session_core.js');
const Model = require('../hud_model.js');

function createHarness() {
	const named = [];
	const outlets = [];
	const tasks = [];
	const dictionaries = new Map();
	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.delay = -1;
		tasks.push(this);
	}
	Task.prototype.schedule = function (delay) { this.delay = delay; };
	Task.prototype.repeat = function () { this.repeating = true; };
	Task.prototype.cancel = function () { this.delay = -1; this.repeating = false; };
	function Dict(name) { this.name = String(name); }
	Dict.prototype.parse = function (json) { dictionaries.set(this.name, JSON.parse(json)); };
	Dict.prototype.stringify = function () { return JSON.stringify(dictionaries.get(this.name) || {}); };
	const context = vm.createContext({
		autowatch: 0, inlets: 0, outlets: 0, Task, Dict,
		require(name) {
			if (name === 'mlr_session_core.js') return Core;
			if (name === 'hud_model.js') return Model;
			throw new Error(`unexpected module ${name}`);
		},
		messnamed(...args) { named.push(args); },
		outlet(...args) { outlets.push(args); }
	});
	vm.runInContext(SOURCE, context, { filename: 'mlr_session_bridge.js' });
	return { context, named, outlets, tasks, dictionaries };
}

function fragments() {
	return {
		router: {
			tracks: Array.from({ length: 16 }, (_, id) => ({ id, group: id % 8, buffer: id + 8 })),
			groups: Array.from({ length: 8 }, (_, id) => ({ id, volume: 100 })),
			patterns: {}, targetAutomation: {}, automation: {}, recordings: []
		},
		bank: { root: '/samples', samples: [], assignments: Array(16).fill(-1) },
		rack: { groups: Array.from({ length: 8 }, (_, id) => ({ id,
			slots: Array.from({ length: 4 }, () => ({ name: 'Empty', loaded: 0 })) })) }
	};
}

test('session bridge pre-creates the Node transfer dictionary used by open and relink', () => {
	const harness = createHarness();
	assert.equal(harness.context.MANAGER_TRANSFER_DICT, 'mlr_session_manager_transfer');
	assert.equal(harness.context.managerTransferDict.name, harness.context.MANAGER_TRANSFER_DICT);
});

test('session bridge collects large fragments through named Dicts and emits one validated save', () => {
	const harness = createHarness();
	assert.equal(harness.context.beginSnapshot('save', '/tmp/Jam'), true);
	const id = Object.keys(harness.context.pendingTransactions)[0];
	const data = fragments();
	for (const kind of ['router', 'bank', 'rack']) {
		const name = `fragment_${kind}`;
		harness.dictionaries.set(name, data[kind]);
		harness.context[`${kind}_dict`](id, name);
	}
	harness.context.finishSnapshot(id);
	const save = harness.outlets.find((message) => message[1] === 'save_bundle');
	assert.deepEqual(save, [0, 'save_bundle', '/tmp/Jam', 'mlr_session_snapshot']);
	const document = harness.dictionaries.get('mlr_session_snapshot');
	assert.equal(Core.validateDocument(document).valid, true);
	assert.equal(document.tracks.length, 16);
});

test('session bridge refuses save while recording and uses a Dict for stopped restore', () => {
	const harness = createHarness();
	harness.context.recording_state(1);
	assert.equal(harness.context.beginSnapshot('save', '/tmp/Jam'), false);
	assert.equal(harness.outlets.length, 0);
	assert.equal(harness.named.some((message) => message[0] === 'mlr_hud_state' &&
		message[1] === 'notice' && message.join(' ').includes('Stop live recording')), true);

	const document = Core.buildDocument(fragments());
	harness.context.recording_state(0);
	assert.equal(harness.context.applyDocument(document), true);
	assert.equal(harness.dictionaries.get('mlr_session_apply_runtime').format, Core.FORMAT);
	for (const bus of ['gridrouter', 'sample_bank', 'mlr_rack_session']) {
		assert.equal(harness.named.some((message) => message[0] === bus &&
			message[1] === 'sessionApplyDict' && message[2] === 'mlr_session_apply_runtime'), true);
	}
});

test('session save without recording exports finalizes without a disposable local Task', () => {
	const harness = createHarness();
	harness.context.activeSaveDocument = Core.buildDocument(fragments());
	harness.context.save_assets('save-empty', '/tmp/staging');
	assert.equal(harness.outlets.some((message) =>
		message[1] === 'finalize_save' && message[2] === 'save-empty'), true);
});

test('dirty New/Open commands require explicit save, discard, or cancel', () => {
	const harness = createHarness();
	harness.context.startupSettling = 0;
	harness.context.dirty('test edit');
	harness.context.command('new');
	assert.equal(harness.context.status.confirmation, 'new');
	harness.context.confirm('cancel');
	assert.equal(harness.context.status.confirmation, '');
	assert.equal(harness.context.status.dirty, 1);
});

test('session snapshot waits for late fragments instead of failing on a fixed delay', () => {
	const harness = createHarness();
	assert.equal(harness.context.beginSnapshot('save', '/tmp/Jam'), true);
	const id = Object.keys(harness.context.pendingTransactions)[0];
	const task = harness.context.pendingTransactions[id].task;
	assert.equal(task.delay, 4000);
	assert.equal(harness.context.pendingTransactions[id] !== undefined, true);
	assert.equal(harness.outlets.some((message) => message[1] === 'save_bundle'), false);

	const data = fragments();
	for (const kind of ['router', 'bank']) {
		const name = `late_fragment_${kind}`;
		harness.dictionaries.set(name, data[kind]);
		harness.context[`${kind}_dict`](id, name);
	}
	assert.equal(harness.context.pendingTransactions[id] !== undefined, true);
	harness.dictionaries.set('late_fragment_rack', data.rack);
	harness.context.rack_dict(id, 'late_fragment_rack');
	assert.equal(harness.context.pendingTransactions[id], undefined);
	assert.equal(task.delay, -1);
	assert.equal(harness.outlets.some((message) => message[1] === 'save_bundle'), true);
});

test('session snapshot timeout cancels polling and identifies missing fragments', () => {
	const harness = createHarness();
	assert.equal(harness.context.beginSnapshot('save', '/tmp/Jam'), true);
	const id = Object.keys(harness.context.pendingTransactions)[0];
	const transaction = harness.context.pendingTransactions[id];
	harness.context.snapshotTimeout(id);
	assert.equal(transaction.task.delay, -1);
	assert.equal(harness.context.pendingTransactions[id], undefined);
	assert.match(harness.context.status.message, /missing router, sample bank, plug-in rack/);
});

test('session snapshot can be cancelled without leaving a busy transaction', () => {
	const harness = createHarness();
	assert.equal(harness.context.beginSnapshot('save', '/tmp/Jam'), true);
	const id = Object.keys(harness.context.pendingTransactions)[0];
	const task = harness.context.pendingTransactions[id].task;
	harness.context.cancel_snapshot('Cancelled for test');
	assert.equal(task.delay, -1);
	assert.deepEqual(Object.keys(harness.context.pendingTransactions), []);
	assert.equal(harness.context.status.busy, 0);
	assert.equal(harness.context.status.message, 'Cancelled for test');
});
