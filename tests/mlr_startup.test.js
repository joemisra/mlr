const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');

const source = fs.readFileSync(path.join(__dirname, '..', 'mlr_startup.js'), 'utf8');
const localPath = '/rig/mlr.local.json';

function createHarness(contents, writable = true) {
 const files = new Map(contents === undefined ? [] : [[localPath, contents]]);
 const outlets = [], named = [], tasks = [];
 function File(filename, mode) {
  this.filename = filename; this.mode = mode; this.position = 0;
  this.text = files.get(filename) || '';
  this.isopen = mode === 'read' ? files.has(filename) : writable;
  this.eof = this.text.length;
 }
 File.prototype.readline = function () { this.position = this.eof; return this.text; };
 File.prototype.writeline = function (line) { files.set(this.filename, line + '\n'); this.position = line.length + 1; };
 File.prototype.close = function () { this.isopen = false; };
 function Task(callback, owner) { this.callback = () => callback.call(owner); tasks.push(this); }
 Task.prototype.cancel = function () {};
 Task.prototype.schedule = function () {};
 const context = vm.createContext({File, Task, patcher: {filepath:'/rig/rta_engine.maxpat'},
  outlet(...args) { outlets.push(args); }, messnamed(...args) { named.push(args); }, post() {}});
 vm.runInContext(source, context);
 return {context, outlets, named, files, tasks};
}

test('hardware color defaults stay off and the HUD command bus reaches local startup settings', () => {
 const h = createHarness(); h.context.reload();
 assert.ok(h.outlets.some(m => m[1] === 'mechatrellis' && m[2] === 0));
 assert.ok(h.outlets.some(m => m[1] === 'editorColors' && m[2] === 0));
 assert.equal(h.files.size, 0);
 const p = JSON.parse(fs.readFileSync(path.join(__dirname, '..', '_mlr.maxpat'))).patcher;
 assert.equal(p.boxes.find(b => b.box.id === 'obj-startup-cmd').box.text, 'r mlr_startup_cmd');
 assert.ok(p.lines.some(l => l.patchline.source[0] === 'obj-startup-cmd' && l.patchline.destination[0] === 'obj-187'));
});

test('on/off survives restart, preserves protocol and unrelated local preferences, and does not dirty sessions', () => {
 const h = createHarness(JSON.stringify({mechatrellisProtocol:2,cvPulseEnabled:true,cvPulseLevel:0.25,other:'retain'}));
 h.context.hardware_colors(1);
 assert.deepEqual(JSON.parse(h.files.get(localPath)), {
  mechatrellisProtocol:2,cvPulseEnabled:true,cvPulseLevel:0.25,other:'retain',mechatrellis:true,editorColors:true});
 assert.ok(h.outlets.some(m => m[1] === 'mechatrellis' && m[2] === 2));
 assert.equal(h.named.some(m => m[0] === 'mlr_cv_pulse_config' || m[0] === 'mlr_session_dirty'), false);
 const restart = createHarness(h.files.get(localPath)); restart.context.reload();
 assert.ok(restart.outlets.some(m => m[1] === 'mechatrellis' && m[2] === 2));
 h.context.hardware_colors(0);
 const off = createHarness(h.files.get(localPath)); off.context.reload();
 assert.ok(off.outlets.some(m => m[1] === 'mechatrellis' && m[2] === 0));
 assert.equal(JSON.parse(h.files.get(localPath)).cvPulseEnabled, true);
});

test('malformed or unwritable local settings are preserved and runtime color still changes with a visible warning', () => {
 for (const [contents,writable] of [['{broken',true],['{"other":123}',false]]) {
  const h = createHarness(contents,writable); h.context.hardware_colors(1);
  assert.equal(h.files.get(localPath),contents);
  assert.ok(h.outlets.some(m => m[1] === 'mechatrellis' && m[2] === 1));
  assert.ok(h.named.some(m => m[0] === 'mlr_hud_state' && m[1] === 'notice' && m[2] === 'warn'));
 }
});
