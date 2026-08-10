const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const Rack = require('../plugin_rack_model.js');
const ROOT = path.join(__dirname, '..');
const patch = (name) => JSON.parse(fs.readFileSync(path.join(ROOT, name), 'utf8')).patcher;

test('rack model keeps eight ordered four-slot groups and canonical VST3/AU inventory', () => {
	const state = Rack.createState();
	assert.equal(state.groups.length, 8);
	assert.equal(state.groups.every((group) => group.slots.length === 4), true);
	Rack.setInventory(state, 'vst3', ['Vendor/Delay', 'Vendor/Delay']);
	Rack.setInventory(state, 'au', [{ id: 'aufx/abcd/efgh', name: 'AU Effect' }]);
	assert.equal(state.inventory.vst3[0].uri, 'C74_VST3:/Vendor/Delay');
	assert.equal(state.inventory.au[0].uri, 'C74_AU:/aufx/abcd/efgh');
	assert.equal(Rack.normalizeFormat('vst2'), '');
});

test('latency totals ignore bypassed slots and flag unequal groups', () => {
	const state = Rack.createState();
	state.sampleRate = 48000;
	Rack.setSlot(state, 0, 0, { format: 'vst3', uri: 'Delay', loaded: 1, latencySamples: 240 });
	assert.equal(state.groups[0].latencySamples, 240);
	assert.equal(Rack.groupLatencyMs(state, 0), 5);
	assert.equal(state.latencyMismatch, 1);
	Rack.setSlot(state, 0, 0, { format: 'vst3', uri: 'Delay', loaded: 1,
		bypassed: 1, latencySamples: 240 });
	assert.equal(state.groups[0].latencySamples, 0);
	assert.equal(state.latencyMismatch, 0);
});

test('slot moves retain descriptors while rebasing physical slot addresses', () => {
	const state = Rack.createState();
	Rack.setSlot(state, 3, 0, { format: 'vst3', uri: 'A', name: 'A', loaded: 1 });
	Rack.setSlot(state, 3, 1, { format: 'au', uri: 'B', name: 'B', loaded: 1 });
	assert.equal(Rack.moveSlot(state, 3, 0, 1), true);
	assert.equal(state.groups[3].slots[0].name, 'B');
	assert.equal(state.groups[3].slots[0].slot, 0);
	assert.equal(state.groups[3].slots[1].name, 'A');
	assert.equal(state.groups[3].slots[1].slot, 1);
});

test('rack patch is four serial dry-safe stereo vst slots', () => {
	const rack = patch('mlr_plugin_rack.maxpat');
	const rackText = rack.boxes.map(({ box }) => box.text || '');
	for (let slot = 1; slot <= 4; slot++) assert.equal(rackText.includes(`mlr_plugin_slot #1 ${slot}`), true);
	const slot = patch('mlr_plugin_slot.maxpat');
	const text = slot.boxes.map(({ box }) => box.text || '');
	assert.equal(text.includes('r mlr_rack_slot_cmd'), true);
	assert.equal(text.some((value) => value.includes('[rack]slot')), false);
	for (const required of ['vst~ 2 2 @autosave 0 @legacytransport 0', 'line~', '*~', '+~']) {
		assert.equal(text.includes(required), true, `missing ${required}`);
	}
	const source = fs.readFileSync(path.join(ROOT, 'mlr_plugin_slot.js'), 'utf8');
	assert.match(source, /FADE_MS = 15/);
	assert.match(source, /queryValues\.inputs <= 0 \|\| queryValues\.synth/);
	assert.match(source, /outlet\(0, "get", -10\)/);
	assert.match(source, /outlet\(0, "disable", 1\)/);
	assert.match(source, /LOAD_TIMEOUT_MS = 10000/);
	assert.match(source, /loadTask\.schedule\(FADE_MS \+ 2\)/);
	assert.match(source, /function slot_command\(groupIndex, slotIndex, selector\)/);
	assert.match(source, /queryTask\.repeat\(\)/);
	assert.doesNotMatch(source, /queryTask\.schedule\(QUERY_INTERVAL_MS\)/);
	assert.match(source, /if \(!descriptor\.format \|\| !descriptor\.uri\) \{[\s\S]*clear\(\)/);
});

test('plugin service scans VST3/AU and mirrors BPM plus clock state to transport', () => {
	const service = patch('mlr_plugin_service.maxpat');
	assert.equal(service.boxes.some(({ box }) => box.text === 'vstscan'), true);
	assert.equal(service.boxes.some(({ box }) => box.text === 'r mlr_rack_cmd'), true);
	const controller = fs.readFileSync(path.join(ROOT, 'mlr_plugin_rack_controller.js'), 'utf8');
	assert.match(controller, /outlet\(0, "listvst3"\)/);
	assert.match(controller, /outlet\(0, "listau"\)/);
	assert.doesNotMatch(controller, /"list(?:vst3|au)", "effect"/);
	assert.match(controller, /rack_inventory_begin/);
	assert.match(controller, /rack_inventory_item/);
	assert.match(controller, /rack_inventory_end/);
	assert.match(controller, /"mlr_rack_slot_cmd", "slot_command", group, slot/);
	assert.match(controller, /batchSize = 24/);
	assert.doesNotMatch(controller, /publish\("rack_inventory", JSON\.stringify/);
	const transport = patch('mlr_plugin_transport.maxpat');
	const text = transport.boxes.map(({ box }) => box.text || '');
	assert.equal(text.includes('r [time]bpm'), true);
	assert.equal(text.includes('prepend tempo'), true);
	assert.equal(text.includes('loadmess timesig 4 4, 0'), true);
	assert.equal(text.includes('r [mlr]start'), true);
	assert.equal(text.includes('r [mlr]stop'), true);
	assert.equal(text.includes('transport'), true);
});

test('rack controller paces a large inventory as atomic begin/item/end messages', () => {
	const source = fs.readFileSync(path.join(ROOT, 'mlr_plugin_rack_controller.js'), 'utf8');
	const named = [];
	const scanCommands = [];
	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.scheduled = false;
	}
	Task.prototype.schedule = function () { this.scheduled = true; };
	Task.prototype.repeat = function () { this.scheduled = true; };
	Task.prototype.cancel = function () { this.scheduled = false; };
	const context = vm.createContext({
		autowatch: 0, inlets: 0, outlets: 0, Task,
		require(name) {
			if (name === 'plugin_rack_model.js') return Rack;
			throw new Error(`unexpected module ${name}`);
		},
		messnamed(...args) { named.push(args); },
		outlet(...args) { scanCommands.push(args); }
	});
	vm.runInContext(source, context, { filename: 'mlr_plugin_rack_controller.js' });
	context.refresh();
	for (let index = 0; index < 300; index++) context.plug_vst3(`Vendor/Effect ${index}`);
	for (let index = 0; index < 180; index++) context.plug_au(`Vendor/AU Effect ${index}`);
	context.publishInventory();
	assert.equal(context.inventoryPublishTask.scheduled, true,
		'paced transfer must use a repeating task rather than rescheduling itself');
	while (context.inventoryPublishQueue.length) context.publishInventoryChunk();
	assert.equal(context.inventoryPublishTask.scheduled, false);
	const hud = named.filter((message) => message[0] === 'mlr_hud_state');
	assert.deepEqual(scanCommands.find((message) => message[1] === 'listvst3'), [0, 'listvst3']);
	assert.deepEqual(scanCommands.find((message) => message[1] === 'listau'), [0, 'listau']);
	assert.equal(hud.some((message) => message[1] === 'rack_inventory'), false);
	assert.equal(hud.filter((message) => message[1] === 'rack_inventory_item').length, 480);
	assert.equal(hud.filter((message) => message[1] === 'rack_inventory_begin').length, 2);
	assert.equal(hud.filter((message) => message[1] === 'rack_inventory_end').length, 2);
	assert.equal(hud.at(-1)[1], 'rack_inventory_status');
	assert.equal(hud.at(-1)[2], 'ready');
});

test('plugin slot defers construction and polls until the host reports readiness', () => {
	const source = fs.readFileSync(path.join(ROOT, 'mlr_plugin_slot.js'), 'utf8');
	const outlets = [];
	const named = [];
	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		this.scheduled = false;
	}
	Task.prototype.schedule = function () { this.scheduled = true; };
	Task.prototype.repeat = function () { this.scheduled = true; };
	Task.prototype.cancel = function () { this.scheduled = false; };
	const context = vm.createContext({
		autowatch: 0, inlets: 2, outlets: 3, inlet: 0,
		jsarguments: ['mlr_plugin_slot.js', 1, 1], Task,
		arrayfromargs(args) { return Array.prototype.slice.call(args); },
		messnamed(...args) { named.push(args); },
		outlet(...args) { outlets.push(args); }
	});
	vm.runInContext(source, context, { filename: 'mlr_plugin_slot.js' });
	context.load_vst3('C74_VST3:/Vendor/Delay', 'Delay');
	assert.equal(context.state.status, 'loading');
	assert.equal(outlets.some((message) => message[1] === 'plug'), false,
		'third-party construction must be deferred until after the dry fade');
	context.loadTask.callback.call(context.loadTask.owner);
	assert.equal(outlets.some((message) => message[1] === 'plug_vst3' &&
		message[2] === 'Vendor/Delay'), true);
	const plugIndex = outlets.findIndex((message) => message[1] === 'plug_vst3');
	assert.equal(outlets.slice(0, plugIndex).some((message) =>
		message[1] === 'disable' && message[2] === 0), false,
		'plugin construction must remain disabled until metadata validation');
	assert.equal(context.queryTask.scheduled, true);
	context.queryTask.callback.call(context.queryTask.owner);
	assert.equal(outlets.filter((message) => message[1] === 'get').length, 4);
	context.clear();
	context.clearTask.callback.call(context.clearTask.owner);
	context.load_au('C74_AU:/Vendor/Delay', 'Delay AU');
	context.loadTask.callback.call(context.loadTask.owner);
	assert.equal(outlets.some((message) => message[1] === 'plug_au' &&
		message[2] === 'Vendor/Delay'), true);
	context.queryTask.callback.call(context.queryTask.owner);
	context.inlet = 1;
	context.list(-1, 2);
	context.list(-6, 1);
	context.list(-7, 0);
	context.list(-10, 64);
	context.finalizeTask.callback.call(context.finalizeTask.owner);
	assert.equal(context.state.status, 'ready');
	assert.equal(context.state.loaded, 1);
	assert.equal(context.state.latencySamples, 64);
	assert.equal(context.pendingLoad, null);
	assert.equal(named.some((message) => message[0] === 'mlr_rack_status' &&
		message[1] === 'slot_status'), true);
});
