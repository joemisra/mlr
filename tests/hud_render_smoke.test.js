const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const SOURCE = fs.readFileSync(path.join(__dirname, '..', 'hud.js'), 'utf8');
const Model = require('../hud_model.js');

function createHarness() {
	const commands = [];
	const tasks = [];
	const metrics = { redraws: 0, schedules: [], calls: {} };
	function Task(callback, owner) {
		this.callback = callback;
		this.owner = owner;
		tasks.push(this);
	}
	Task.prototype.schedule = function (delay) {
		metrics.schedules.push({ task: this, delay });
	};
	Task.prototype.cancel = function () {
		metrics.schedules = metrics.schedules.filter(({ task }) => task !== this);
	};
	const mgraphics = { size: [720, 480] };
	for (const method of ['init', 'redraw', 'set_source_rgba', 'rectangle', 'fill',
		'set_line_width', 'stroke', 'move_to', 'line_to', 'select_font_face',
		'set_font_size', 'show_text']) mgraphics[method] = function () {
		metrics.calls[method] = (metrics.calls[method] || 0) + 1;
	};
	mgraphics.redraw = function () { metrics.redraws++; };
	const context = vm.createContext({
		autowatch: 0, inlets: 0, outlets: 0, mgraphics, Task,
		require(name) {
			if (name === 'hud_model.js') return Model;
			throw new Error(`unexpected module ${name}`);
		},
		outlet(...args) { commands.push(args); }
	});
	vm.runInContext(SOURCE, context, { filename: 'hud.js' });
	return {
		context, commands, mgraphics, metrics,
		runScheduled() {
			const pending = metrics.schedules.splice(0);
			for (const { task } of pending) task.callback.call(task.owner);
		}
	};
}

test('off-page and non-selected telemetry updates state without repainting the HUD', () => {
	const harness = createHarness();
	harness.context.page('session');
	harness.metrics.schedules.length = 0;
	harness.context.channel_strip_meter(0, -9, -14, 3);
	assert.equal(harness.context.state.channelStrips[0].inputDb, -9);
	assert.equal(harness.metrics.schedules.length, 0);

	harness.context.page('strip');
	harness.metrics.schedules.length = 0;
	harness.context.channel_strip_meter(2, -8, -12, 2);
	assert.equal(harness.context.state.channelStrips[2].inputDb, -8);
	assert.equal(harness.metrics.schedules.length, 0);

	harness.context.channel_strip_meter(0, -10, -15, 4);
	assert.equal(harness.metrics.schedules.length, 1);
	assert.equal(harness.metrics.schedules[0].delay, 33);
	harness.runScheduled();
	const redraws = harness.metrics.redraws;
	harness.context.channel_strip_meter(0, -10, -15, 4);
	assert.equal(harness.metrics.schedules.length, 0);
	assert.equal(harness.metrics.redraws, redraws);
});

test('capture messages have concrete V8UI receivers and update without console errors', () => {
	const harness = createHarness();
	assert.doesNotThrow(() => harness.context.capture_source('mix'));
	assert.doesNotThrow(() => harness.context.track_capture(
		2, 'recording', 19, 1500, 'capture-test'));
	assert.equal(harness.context.state.capture.source, 'mix');
	assert.equal(harness.context.state.capture.tracks[2].state, 'recording');
});

test('all HUD pages paint and expose bounded hit regions from 480x320 upward', () => {
	const harness = createHarness();
	for (const size of [[480, 320], [720, 480], [1100, 700]]) {
		harness.mgraphics.size = size;
		for (const page of Model.HUD_PAGES) {
			harness.context.page(page);
			assert.doesNotThrow(() => harness.context.paint());
			assert.equal(harness.context.hitRegions.some((region) => region.id === `tab:${page}`), true);
			for (const region of harness.context.hitRegions) {
				assert.equal(Number.isFinite(region.x + region.y + region.width + region.height), true);
				assert.equal(region.width >= 0 && region.height >= 0, true);
				assert.equal(region.x >= 0 && region.y >= 0, true);
				assert.equal(region.x + region.width <= size[0] + 0.01, true,
					`${page} region ${region.id} exceeds width at ${size.join('x')}`);
				assert.equal(region.y + region.height <= size[1] + 0.01, true,
					`${page} region ${region.id} exceeds height at ${size.join('x')}`);
			}
		}
	}
});

test('live virtual keys and pattern steps remain read-only', () => {
	const harness = createHarness();
	harness.context.page('live');
	harness.context.paint();
	const grid = harness.context.hitRegions.find((region) => region.id === 'grid:0:0');
	harness.context.activateRegion(grid, false);
	assert.deepEqual(harness.commands, []);

	harness.context.page('pattern');
	harness.context.paint();
	const step = harness.context.hitRegions.find((region) => region.id === 'pattern_step:0');
	harness.context.activateRegion(step, false);
	assert.deepEqual(harness.commands, []);
});

test('live page exposes a capture-and-reinitialize recovery control', () => {
	const harness = createHarness();
	harness.context.page('live');
	harness.context.paint();
	const recovery = harness.context.hitRegions.find((region) =>
		region.id === 'display_recover');
	assert.ok(recovery);
	harness.context.activateRegion(recovery, false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'display_recover'), true);
});

test('sample click auditions and a double-click also commits the assignment', () => {
	const harness = createHarness();
	harness.context.bank('ready', '/bank.json', '/samples', 1);
	harness.context.sample(0, 8, 'Kick', '/samples/kick.wav', 'WAVE', 1, 400, 48000);
	harness.context.page('samples');
	harness.context.paint();
	const sample = harness.context.hitRegions.find((region) => region.id === 'sample:0');
	const event = { clientX: sample.x + 2, clientY: sample.y + 2 };
	harness.context.onpointerup(event);
	assert.equal(harness.commands.some((command) => command[1] === 'sample_assign'), false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'sample_audition' && command[2] === 0), true);
	harness.context.onpointerup(event);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'sample_assign' && command[2] === 0 && command[3] === 0), true);
});

test('sample controls open folder scanning and the physical grid browser', () => {
	const harness = createHarness();
	harness.context.bank('ready', '/samples', '/samples', 1, 'smart-folder');
	harness.context.sample(0, 8, 'Kit Kick 01', '/samples/Kit Kick 01.wav',
		'WAVE', 1, 400, 48000, 'kick', 'kit kick', 240, 60, 35);
	harness.context.page('samples');
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'bank_scan'), false);
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'sample_grid'), false);
	assert.equal(harness.commands.some((command) => command[1] === 'bank_scan'), true);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'sample_grid' && command[2] === 1 &&
		command[3] === 0 && command[4] === -1), true);
});

test('sample page uses one wide sixteen-row column for tracks and bank samples', () => {
	const harness = createHarness();
	harness.context.bank('ready', '/bank.json', '/samples', 16);
	for (let index = 0; index < 16; index++) {
		harness.context.sample(index, index + 8,
			`A deliberately long sample filename number ${index + 1}.wav`,
			`/samples/long/path/${index + 1}.wav`, 'WAVE', 1, 400, 48000);
	}
	harness.context.page('samples');
	harness.context.paint();
	const tracks = harness.context.hitRegions.filter((region) =>
		region.id.startsWith('sample_track:'));
	const samples = harness.context.hitRegions.filter((region) =>
		/^sample:\d+$/.test(region.id));
	assert.equal(tracks.length, 16);
	assert.equal(samples.length, 16);
	assert.equal(new Set(tracks.map((region) => region.x)).size, 1);
	assert.equal(new Set(samples.map((region) => region.x)).size, 1);
	assert.equal(new Set(tracks.map((region) => region.y)).size, 16);
	assert.equal(new Set(samples.map((region) => region.y)).size, 16);
	assert.equal(samples[0].width > 180, true);
});

test('opening an empty Colors page automatically requests a fresh snapshot', () => {
	const harness = createHarness();
	harness.context.page('colors');
	assert.equal(harness.commands.some((command) => command[1] === 'snapshot'), true);
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) =>
		region.id === 'color_snapshot_retry'), true);
});

test('channel-strip page selects a group and edits its DSP controls', () => {
	const harness = createHarness();
	harness.context.channel_strip(0, 0, 1, 1, 0, -18, 4, 10, 120, 6, 0, 1, 0, 0);
	harness.context.page('strip');
	harness.context.paint();
	assert.equal(harness.commands.some((command) => command[1] === 'strip_snapshot'), true);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'strip_select' && command[2] === 0), true);
	const groupSix = harness.context.hitRegions.find((region) => region.id === 'strip_group:5');
	harness.context.activateRegion(groupSix, false);
	assert.equal(harness.context.state.selectedChannelStrip, 5);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'strip_select' && command[2] === 5), true);
	harness.context.paint();
	const clean = harness.context.hitRegions.find((region) => region.id === 'strip:5:engine:1');
	harness.context.activateRegion(clean, false);
	assert.equal(harness.context.state.channelStrips[5].engine, 1);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'strip_set' && command[2] === 5 &&
		command[3] === 'engine' && command[4] === 1), true);
});

test('rack sub-tab loads, bypasses, opens, clears, and reorders effects', () => {
	const harness = createHarness();
	harness.context.rack_inventory(JSON.stringify({ vst3: [
		{ format: 'vst3', uri: 'C74_VST3:/Vendor/Delay', name: 'Delay' }
	], au: [] }));
	harness.context.rack_state(0, 0, JSON.stringify({ name: 'Empty', status: 'empty' }));
	harness.context.page('strip');
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'strip_tab:rack'), false);
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'rack_load:0'), true);
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'rack_load:0'), false);
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'rack_plugin:0'), false);
	assert.equal(harness.commands.some((command) => command[1] === 'rack_load' &&
		command[2] === 0 && command[3] === 0 && command[4] === 'vst3'), true);
	harness.context.paint();
	for (const [id, command] of [['rack_bypass:0', 'rack_bypass'], ['rack_open:0', 'rack_open'],
		['rack_clear:0', 'rack_clear'], ['rack_down:0', 'rack_move']]) {
		harness.context.activateRegion(harness.context.hitRegions.find((region) => region.id === id), false);
		assert.equal(harness.commands.some((message) => message[1] === command), true, command);
	}
});

test('rack chooser keeps its old list visible while a paced refresh is in progress', () => {
	const harness = createHarness();
	harness.context.rack_inventory(JSON.stringify({ vst3: [
		{ format: 'vst3', uri: 'C74_VST3:/Vendor/Delay', name: 'Delay' }
	], au: [] }));
	harness.context.rack_inventory_status('listing', 2, 0, 0, 'Reading cache');
	harness.context.page('strip');
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'strip_tab:rack'), false);
	harness.context.paint();
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'rack_load:0'), false);
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'rack_plugin:0'), true);
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'rack_refresh'), true);
});

test('Session page exposes commands, dirty state, missing files, and save/discard/cancel confirmation', () => {
	const harness = createHarness();
	harness.context.session_state(JSON.stringify({ name: 'Jam', dirty: 1, busy: 0,
		confirmation: 'open', message: 'Save changes?', missing: [
			{ type: 'sample', path: '/missing/kick.wav' }
		] }));
	harness.context.page('session');
	harness.context.paint();
	assert.equal(harness.context.hitRegions.some((region) => region.id === 'session_command:session_save'), true);
	harness.context.activateRegion(harness.context.hitRegions.find((region) =>
		region.id === 'session_command:session_save'), false);
	for (const choice of ['save', 'discard', 'cancel']) {
		harness.context.activateRegion(harness.context.hitRegions.find((region) =>
			region.id === `session_confirm:${choice}`), false);
	}
	assert.equal(harness.commands.some((command) => command[1] === 'session_save'), true);
	assert.equal(harness.commands.filter((command) => command[1] === 'session_confirm').length, 3);
});

test('color lab edits one runtime role and exposes non-persistent reset controls', () => {
	const harness = createHarness();
	harness.context.color_role('rta.trigger', 'RTA', 0, 210, 255);
	harness.context.color_role('page.mainBase', 'PAGE', 18, 72, 180);
	harness.context.page('colors');
	harness.context.paint();
	const greenMaximum = harness.context.hitRegions.find((region) =>
		region.id === 'color_channel:1:255');
	assert.ok(greenMaximum);
	harness.context.activateRegion(greenMaximum, false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'color_role' && command[2] === 'rta.trigger' &&
		command[4] === 255), true);
	const reset = harness.context.hitRegions.find((region) => region.id === 'color_reset_role');
	harness.context.activateRegion(reset, false);
	assert.equal(harness.commands.some((command) =>
		command[1] === 'color_reset' && command[2] === 'rta.trigger'), true);
});

test('hardware color toggle is available without a palette snapshot and follows acknowledged runtime state', () => {
 const h = createHarness();
 for (const size of [[480,320],[720,480],[1100,700]]) {
  h.mgraphics.size = size;
  for (const page of ['live','colors']) {
   h.context.page(page); h.context.paint();
   const toggle = h.context.hitRegions.find(r => r.id === 'hardware_colors');
   assert.ok(toggle, `${page} at ${size}`);
   assert.ok(toggle.x >= 0 && toggle.x + toggle.width <= size[0]);
   assert.ok(toggle.y >= 0 && toggle.y + toggle.height <= size[1]);
   h.context.hardware_colors(0); h.context.activateRegion(toggle,false);
   assert.deepEqual(h.commands.at(-1), [0,'hardware_colors',1]);
   assert.equal(h.context.state.hardwareColors,0);
   h.context.hardware_colors(1); h.context.activateRegion(toggle,false);
   assert.deepEqual(h.commands.at(-1), [0,'hardware_colors',0]);
  }
 }
});

test('parameter banner reserves space, shows name value and layer, and clears without changing the page',()=>{
 const h=createHarness(),drawn=[];h.mgraphics.show_text=t=>drawn.push(t);
 h.context.parameter_focus(JSON.stringify({active:true,name:'Sweep decay',value:32,unit:'ms',track:15,bar:1,step:9,layer:'Group override'}));
 for(const size of [[720,480],[480,320]]){
  h.mgraphics.size=size;h.context.paint();
  assert.ok(h.context.pageLayout().contentY>=110);
 }
 assert.ok(drawn.includes('SWEEP DECAY'));assert.ok(drawn.includes('32 ms'));
 assert.ok(drawn.some(t=>String(t).includes('Group override')));
 h.context.parameter_focus('{"active":false}');assert.equal(h.context.pageLayout().contentY,60);
});

test('plugin scrollbar jumps to the last page and dragging cannot load a plugin', () => {
 const h=createHarness(),c=h.context;
 c.state.rackInventory.vst3=Array.from({length:100},(_,i)=>({name:'Plugin '+i,uri:'C74_VST3:/Plugin '+i,format:'vst3'}));
 c.page('strip');c.state.stripView='rack';c.state.rackChooser.active=1;c.paint();h.commands.length=0;
 const bar=c.hitRegions.find(r=>r.id==='rack_scrollbar');assert.ok(bar);
 c.onpointerdown({clientX:bar.x+7,clientY:bar.y+2});
 c.onpointermove({clientX:bar.x-80,clientY:bar.y+bar.height+100});
 c.onpointerup({clientX:bar.x-80,clientY:bar.y+bar.height+100});
 assert.equal(c.state.rackChooser.page,c.listPageCount('rack')-1);
 assert.equal(c.scrollbarDrag,null);assert.equal(h.commands.length,0);
 c.paint();const row=c.hitRegions.find(r=>r.payload.action==='rack_plugin');
 assert.ok(row.payload.entry.name.startsWith('Plugin 9'));
 c.onpointerdown({clientX:bar.x+7,clientY:bar.y});c.onpointerup({clientX:bar.x+7,clientY:bar.y});
 assert.equal(c.state.rackChooser.page,0);assert.equal(h.commands.length,0);
});

test('sample scrollbar uses the active folder and clamps when its list shrinks', () => {
 const h=createHarness(),c=h.context;
 c.state.bank.folders=[{id:'a',name:'A'},{id:'b',name:'B'}];c.state.bank.activeFolder=0;c.state.bank.activeFolderId='a';
 c.state.bank.samples=Array.from({length:112},(_,i)=>({id:i,name:'Sample '+i,folderId:i<80?'a':'b'}));
 c.page('samples');c.paint();h.commands.length=0;
 const bar=c.hitRegions.find(r=>r.id==='samples_scrollbar');assert.ok(bar);
 c.onpointerdown({clientX:bar.x+7,clientY:bar.y+bar.height-1});
 c.onpointerup({clientX:bar.x+7,clientY:bar.y+bar.height-1});
 assert.equal(c.state.samplePage,4);assert.equal(h.commands.length,0);
 c.paint();assert.ok(c.hitRegions.find(r=>r.id==='sample:64'));
 c.state.bank.samples=c.state.bank.samples.slice(0,3);c.paint();
 assert.equal(c.state.samplePage,0);
 assert.equal(c.hitRegions.some(r=>r.id==='samples_scrollbar'),false);
});

test('scrollbar hit areas stay bounded and separate from rows in compact and large HUDs', () => {
 const h=createHarness(),c=h.context;
 c.state.bank.samples=Array.from({length:100},(_,id)=>({id,name:'Sample '+id}));
 c.state.rackInventory.vst3=Array.from({length:100},(_,id)=>({id,name:'Plugin '+id}));
 for(const size of [[480,320],[720,480],[1100,700]]) {
  h.mgraphics.size=size;
  for(const target of ['rack','samples']) {
   c.page(target==='rack'?'strip':'samples');c.state.stripView='rack';c.state.rackChooser.active=1;c.paint();
   const bar=c.hitRegions.find(r=>r.id===target+'_scrollbar');assert.ok(bar);
   assert.ok(bar.x+bar.width<=size[0]);assert.ok(bar.y+bar.height<=size[1]);
   const rows=c.hitRegions.filter(r=>r.payload.action===(target==='rack'?'rack_plugin':'sample'));
   assert.ok(rows.every(r=>r.x+r.width<bar.x));
   assert.ok(rows.every(r=>r.y+r.height<=bar.y+bar.height+0.01));
  }
 }
});


test('hover stays stable across repaint and still updates when entering another control', () => {
 const h=createHarness();h.context.paint();
 const cell=h.context.hitRegions.find(r=>r.id==='grid:2:3');
 h.context.updatePointer(cell.x+2,cell.y+2);h.runScheduled();h.context.paint();
 h.context.updatePointer(cell.x+3,cell.y+3);
 assert.equal(h.metrics.schedules.length,0,'rebuilt region must not trigger another frame');
 const other=h.context.hitRegions.find(r=>r.id==='grid:3:3');
 h.context.updatePointer(other.x+2,other.y+2);
 assert.equal(h.metrics.schedules.length,1);
});

test('unrelated playhead and rack messages update state without scheduling frames', () => {
 const h=createHarness();h.context.page('pattern');h.metrics.schedules.length=0;
 h.context.pattern_playhead('track',15,0,3);
 assert.equal(h.metrics.schedules.length,0);
 h.context.pattern_playhead(h.context.state.pattern.targetType,h.context.state.pattern.targetId,0,3);
 assert.equal(h.metrics.schedules.length,1);
 h.context.page('strip');h.context.state.stripView='rack';h.metrics.schedules.length=0;
 h.context.rack_state(3,0,JSON.stringify({name:'Delay',status:'ready'}));
 assert.equal(h.context.state.pluginRacks[3].slots[0].name,'Delay');
 assert.equal(h.metrics.schedules.length,0);
 h.context.rack_state(0,0,JSON.stringify({name:'Echo',status:'ready'}));
 assert.equal(h.metrics.schedules.length,1);
 h.runScheduled();
 h.context.rack_latency(3,128,2.67,1);
 assert.equal(h.metrics.schedules.length,1,'global latency warning remains visible');
});

test('grid and stereo waveform batch matching geometry into a small number of draws', () => {
 const h=createHarness();h.context.hitRegions=[];
 h.context.drawGrid(10,10,300,true);
 assert.equal(h.context.hitRegions.length,256);
 assert.equal(h.metrics.calls.rectangle,514,'all cell fill and border rectangles remain');
 assert.equal(h.metrics.calls.fill,2);assert.equal(h.metrics.calls.stroke,2);
 h.metrics.calls={};
 const bins=Array.from({length:256},()=>[-0.5,0.5]);
 h.context.drawWaveform(10,10,300,100,{channels:[bins,bins]});
 assert.equal(h.metrics.calls.stroke,4,'border, center line and one path per channel');
 assert.equal(h.metrics.calls.line_to,513,'all waveform bins remain');
});

test('overlapping gate tails expire at the right step without wrapping', () => {
 const h=createHarness();const p={steps:[]};
 p.steps[0]={cut:1,gateLength:4};p.steps[2]={cut:1,gateLength:5};p.steps[8]={cut:0,gateLength:64};
 p.steps[62]={cut:1,gateLength:8};const tails=h.context.gateTails(p);
 assert.equal(tails[0],false);assert.equal(tails[1],true);assert.equal(tails[6],true);
 assert.equal(tails[7],false);assert.equal(tails[9],false);assert.equal(tails[63],true);
});


test('a preview waveform reaches the selected sample inspector', () => {
 const h=createHarness();h.context.sample(0,14,'Kick','/samples/kick.wav','WAVE',1,500,48000);
 h.context.state.selectedSample=0;h.context.page('samples');h.metrics.schedules.length=0;
 h.context.waveform(14,JSON.stringify({buffer:14,frames:24000,channels:[Array.from({length:256},()=>[-0.5,0.5])]}));
 assert.equal(h.metrics.schedules.length,1);
 h.context.paint();
 assert.ok(h.metrics.calls.line_to>=257,'selected sample waveform is painted');
});


test('phase page requests current state, edits only the selected group and stores presets', () => {
 const h=createHarness();h.context.paint();
 h.context.activateRegion(h.context.hitRegions.find(r=>r.id==='tab:phase'),false);h.context.paint();
 assert.ok(h.commands.some(m=>m[1]==='phase_snapshot'));
 h.context.activateRegion(h.context.hitRegions.find(r=>r.id==='phase_group:3'),false);h.context.paint();
 h.context.activateRegion(h.context.hitRegions.find(r=>r.id==='phase:chance:0.75'),false);
 for(const division of [3,6,12,16]) h.context.activateRegion(h.context.hitRegions.find(r=>r.id==='phase:division:'+division),false);
 h.context.activateRegion(h.context.hitRegions.find(r=>r.id==='phase:ramp:2'),false);
 h.context.activateRegion(h.context.hitRegions.find(r=>r.id==='phase_store:1'),false);
 assert.ok(h.commands.some(m=>m[1]==='phase_set'&&m[2]===3&&m[3]==='chance'&&m[4]===0.75));
 assert.ok(h.commands.some(m=>m[1]==='phase_set'&&m[2]===3&&m[3]==='ramp'&&m[4]===2));
 for(const division of [3,6,12,16]) assert.ok(h.commands.some(m=>m[1]==='phase_set'&&m[3]==='division'&&m[4]===division));
 assert.ok(h.commands.some(m=>m[1]==='phase_preset'&&m[2]===3&&m[3]==='store'&&m[4]===1));
 h.metrics.schedules.length=0;
 h.context.phase_cut(0,JSON.stringify({enabled:1,chance:1}));
 assert.equal(h.metrics.schedules.length,0);
 h.context.phase_cut(3,JSON.stringify({enabled:1,chance:0.75}));
 assert.equal(h.metrics.schedules.length,1);assert.equal(h.context.state.phaseCuts[3].chance,0.75);
 for(const size of [[480,320],[720,480],[1100,700]]){
  h.mgraphics.size=size;h.context.state.parameterFocus.active=true;h.context.paint();
  for(const r of h.context.hitRegions){assert.ok(r.width>0&&r.height>0,r.id);assert.ok(r.y+r.height<=size[1],r.id);}
 }
});

test('a remote peer slows only desktop telemetry redraws; local gestures remain immediate', () => {
 const harness = createHarness();
 harness.context.remote_peer(1);
 assert.equal(harness.metrics.schedules.at(-1).delay,150);
 harness.runScheduled();
 harness.context.clock(132,16);
 assert.equal(harness.metrics.schedules.at(-1).delay,150);
 const before = harness.metrics.redraws;
 harness.context.page('help');
 assert.equal(harness.metrics.redraws,before+1);
 harness.context.remote_peer(0);
 assert.equal(harness.metrics.schedules.at(-1).delay,33);
});

test('sample folder dropdown selects a named folder and removal sends its stable ID', () => {
	const h = createHarness();
	h.context.page('samples');
	h.context.sample_folders(JSON.stringify({ activeFolder: 0, activeFolderId: 'folder:0', folders: [
		{ id: 'folder:0', name: 'Drums', count: 3 }, { id: 'folder:4', name: 'Textures', count: 2 }
	] }));
	h.context.paint();
	h.context.activateRegion(h.context.hitRegions.find(r => r.id === 'folder_menu'));
	h.context.paint();
	const option = h.context.hitRegions.find(r => r.id === 'folder_option:1');
	assert.ok(option);
	h.context.activateRegion(option);
	assert.equal(h.context.state.bank.activeFolderId, 'folder:4');
	assert.equal(h.context.folderMenuOpen, false);
	h.context.paint();
	h.context.activateRegion(h.context.hitRegions.find(r => r.id === 'folder_remove'));
	assert.ok(h.commands.some(c => c[1] === 'sample_folder_remove' && c[2] === 'folder:4'));
});

test('native drop area follows the Samples page and hides on other pages', () => {
	const h = createHarness();
	const messages = [];
	h.context.patcher = { getnamed(name) {
		assert.equal(name, 'sample_drop_zone');
		return { message(...args) { messages.push(args); } };
	} };
	h.context.page('samples'); h.context.paint();
	assert.ok(messages.some(m => m[0] === 'hidden' && m[1] === 0));
	assert.ok(messages.some(m => m[0] === 'presentation_rect' && m.length === 5));
	h.context.page('live'); h.context.paint();
	assert.deepEqual(messages[messages.length - 1], ['hidden', 1]);
});
