const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const {createRemoteHUD} = require('../remote_hud_server');

test('remote HUD authenticates, streams state, and forwards only allowed commands', async t => {
 const commands = [];
 const remote = createRemoteHUD({token:'test-pair', command:args=>commands.push(args)});
 await new Promise(resolve=>remote.server.listen(0,'127.0.0.1',resolve));
 t.after(()=>{remote.server.closeAllConnections();remote.server.close();});
 const base = `http://127.0.0.1:${remote.server.address().port}`;
 assert.equal((await fetch(base)).status,403);
 assert.equal((await fetch(base+'/?token=test-pair')).status,200);
 const send = args => fetch(base+'/command?token=test-pair',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(args)});
 assert.equal((await send(['transport','stop'])).status,204);
 assert.deepEqual(commands.pop(),['transport','stop']);
 assert.equal((await send(['eval','bad'])).status,400);
 assert.equal((await send(['target',{}])).status,400);
 remote.ingest('clock',[143,16]);
 const controller = new AbortController();
 const response = await fetch(base+'/events?token=test-pair',{signal:controller.signal});
 const reader = response.body.getReader();
 const first = new TextDecoder().decode((await reader.read()).value);
 assert.match(first,/event: snapshot/);assert.match(first,/"bpm":143/);
 remote.ingest('clock',[144,16]);
 const next = new TextDecoder().decode((await reader.read()).value);
 assert.match(next,/event: updates/);assert.match(next,/144/);controller.abort();
 const modules = await (await fetch(base+'/modules.js?token=test-pair')).text();
 const context = vm.createContext({});vm.runInContext(modules,context);
 assert.equal(context.require('hud_model.js').createState().bpm,120);
 assert.equal(context.require('hud_model.js').Product.rta,true);
});

test('canvas adapter renders all current HUD pages and maps touch to commands', () => {
 const Model = require('../hud_model');
 const events = {}, commands = [];
 const ctx = new Proxy({}, {get(target,key){return target[key] || (()=>{});}});
 const canvas = {getContext:()=>ctx,style:{},addEventListener:(name,fn)=>events[name]=fn,getBoundingClientRect:()=>({left:0,top:0,width:800,height:400}),setPointerCapture(){}};
 const elements = {hud:canvas,status:{},fullscreen:{}};
 class EventSource {constructor(){this.listeners={};EventSource.instance=this;}addEventListener(name,fn){this.listeners[name]=fn;}}
 const context = vm.createContext({require:()=>Model,document:{getElementById:id=>elements[id],addEventListener(){}},window:{innerWidth:800,innerHeight:436,addEventListener:(name,fn)=>events[name]=fn},location:{search:'?token=pair'},navigator:{},devicePixelRatio:2,EventSource,setTimeout:()=>1,clearTimeout(){},fetch:async(url,options)=>{commands.push(JSON.parse(options.body));return {ok:true};}});
 vm.runInContext(fs.readFileSync('remote_hud_client.js','utf8'),context);
 vm.runInContext(fs.readFileSync('hud.js','utf8'),context);
 events.load();EventSource.instance.onopen();
 for(const page of Model.HUD_PAGES){context.state.page=page;context.paint();}
 context.state.page='live';context.paint();
 const region=context.hitRegions.find(r=>r.payload.action==='page' && r.payload.page==='strip');
 assert.ok(region);
 context.activateRegion(region,false);
 assert.equal(context.state.page,'strip');
 EventSource.instance.onerror();assert.equal(context.connected,false);
});

test('Max telemetry batcher eliminates idle IPC and coalesces bursts before Node', () => {
 const messages = [], tasks = [];
 function Task(fn) { this.fn=fn;tasks.push(this); }
 Task.prototype.schedule=function(){};Task.prototype.cancel=function(){};
 const context=vm.createContext({autowatch:0,inlets:0,outlets:0,Task,Map,Set,messnamed(){},outlet:(...args)=>messages.push(args)});
 vm.runInContext(fs.readFileSync('remote_hud_batch.js','utf8'),context);
 for(let i=0;i<10000;i++)context.enqueue('channel_strip_meter',[0,i,0,0]);
 context.flush();assert.equal(messages.length,0);
 context.active(1);
 for(let i=0;i<10000;i++)context.enqueue('channel_strip_meter',[0,i,0,0]);
 context.enqueue('grid_color_cell',[0,0,255,0,0]);
 context.enqueue('grid_color_all',[0,0,0]);
 context.enqueue('grid_color_cell',[0,0,0,255,0]);
 context.enqueue('rack_inventory_begin',[1]);
 context.enqueue('rack_inventory_item',[1,'a']);
 context.enqueue('rack_inventory_item',[1,'b']);
 context.enqueue('rack_inventory_end',[1]);
 context.flush();assert.equal(messages.length,1);
 const batch=JSON.parse(messages[0][2]);
 assert.equal(batch.length,7);assert.equal(batch[0][1][1],9999);
 assert.deepEqual(batch.slice(1,3).map(e=>e[0]),['grid_color_all','grid_color_cell']);
 assert.deepEqual(batch.slice(3).map(e=>e[0]),['rack_inventory_begin','rack_inventory_item','rack_inventory_item','rack_inventory_end']);
 context.active(0);context.enqueue('clock',[150,16]);context.flush();assert.equal(messages.length,1);
});

test('only first/last connected phone enables/disables Max telemetry', async t => {
 const switches=[],commands=[];
 const remote=createRemoteHUD({token:'pair',stream:v=>switches.push(v),command:args=>commands.push(args)});
 await new Promise(resolve=>remote.server.listen(0,'127.0.0.1',resolve));
 t.after(()=>{remote.server.closeAllConnections();remote.server.close();});
 const url=`http://127.0.0.1:${remote.server.address().port}/events?token=pair`;
 const first=new AbortController(),second=new AbortController();
 await fetch(url,{signal:first.signal});await fetch(url,{signal:second.signal});
 assert.deepEqual(switches,[1]);assert.deepEqual(commands,[['snapshot']]);
 first.abort();second.abort();
 await new Promise(resolve=>setTimeout(resolve,30));
 assert.deepEqual(switches,[1,0]);
});

test('large snapshots cross a simulated Max symbol limit intact in bounded bursts', () => {
 const {createBatchReceiver}=require('../remote_hud_server');
 const received=[], messages=[];
 const accept=createBatchReceiver(batch=>received.push(batch));
 function Task(){};Task.prototype.schedule=function(){};Task.prototype.cancel=function(){};
 const context=vm.createContext({autowatch:0,inlets:0,outlets:0,Task,Map,Set,messnamed(){},outlet:(out,selector,...args)=>{
  assert.ok(args.every(arg=>typeof arg!=='string'||Buffer.byteLength(arg)<32767));
  messages.push(selector);
  if(selector==='batch_chunk')accept(...args);else received.push(JSON.parse(args[0]));
 }});
 vm.runInContext(fs.readFileSync('remote_hud_batch.js','utf8'),context);
 context.active(1);
 const payload='sample 🥁 ऋत '.repeat(18000);
 context.enqueue('waveform',[0,payload]);
 context.flush();assert.equal(received.length,0);assert.equal(messages.length,4);
 for(let i=0;i<100;i++)context.flush();
 assert.equal(received.length,1);assert.equal(received[0][0][1][1],payload);
 assert.throws(()=>accept(2,1,2,'bad'),/Out-of-order/);
});

test('browser paths paint every static grid cell and every waveform bin', () => {
 // Model Canvas path retention/reset semantics rather than no-op drawing calls.
 let path=[];const fills=[],strokes=[];
 const ctx={beginPath(){path=[];},rect(...args){path.push(['rect',...args]);},
  moveTo(...args){path.push(['move',...args]);},lineTo(...args){path.push(['line',...args]);},
  fill(){fills.push(path.slice());},stroke(){strokes.push(path.slice());},fillText(){}};
 const context=vm.createContext({require:()=>require('../hud_model'),
  document:{getElementById:()=>({getContext:()=>ctx})},window:{addEventListener(){}}});
 vm.runInContext(fs.readFileSync('remote_hud_client.js','utf8'),context);
 vm.runInContext(fs.readFileSync('hud.js','utf8'),context);
 // Four uniform quadrants reproduce the static regions lost by resetting each rect.
 for(let y=0;y<16;y++)for(let x=0;x<16;x++)context.state.grid.levels[y*16+x]=(x<8?3:6)+(y<8?0:6);
 context.drawGrid(10,10,320,false);
 const cellRects=fills.slice(1).flat().filter(p=>p[0]==='rect');
 assert.equal(cellRects.length,256);
 assert.equal(new Set(cellRects.map(p=>p.slice(1,3).join(','))).size,256);
 assert.equal(strokes.slice(1).flat().filter(p=>p[0]==='rect').length,256);
 fills.length=0;strokes.length=0;
 context.drawWaveform(10,10,300,100,{channels:[Array(256).fill([-0.7,0.7]),Array(256).fill([-0.3,0.3])]});
 assert.equal(strokes.length,4,'border, center line and one path per waveform channel');
 assert.equal(strokes[2].filter(p=>p[0]==='line').length,256);
 assert.equal(strokes[3].filter(p=>p[0]==='line').length,256);
});

test('short bookmark pairs once and the same cookie works across server restarts', async t => {
 const os=require('node:os'),path=require('node:path');
 const {loadRemoteSettings}=require('../remote_hud_server');
 const dir=fs.mkdtempSync(path.join(os.tmpdir(),'hud-pair-'));
 t.after(()=>fs.rmSync(dir,{recursive:true,force:true}));
 const file=path.join(dir,'local','remote-hud.json');
 const settings=loadRemoteSettings(file);
 assert.deepEqual(loadRemoteSettings(file),settings);
 assert.match(settings.pairingCode,/^\d{8}$/);
 if(process.platform!=='win32')assert.equal(fs.statSync(file).mode & 0o777,0o600);
 let cookie;
 for(let cycle=0;cycle<2;cycle++) {
  const remote=createRemoteHUD({...loadRemoteSettings(file)});
  await new Promise(resolve=>remote.server.listen(0,'127.0.0.1',resolve));
  const base=`http://127.0.0.1:${remote.server.address().port}`;
  try {
   assert.match(await (await fetch(base)).text(),/Pairing code/);
   assert.equal((await fetch(base+'/client.js')).status,403);
   if(!cookie) {
    const paired=await fetch(base+'/pair',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:new URLSearchParams({code:settings.pairingCode}),redirect:'manual'});
    assert.equal(paired.status,303);assert.equal(paired.headers.get('location'),'/');
    const header=paired.headers.get('set-cookie');assert.match(header,/HttpOnly; SameSite=Strict/);
    cookie=header.split(';')[0];
   }
   assert.match(await (await fetch(base,{headers:{Cookie:cookie}})).text(),/<canvas/);
   assert.equal((await fetch(base+'/client.js',{headers:{Cookie:cookie}})).status,200);
   assert.equal((await fetch(base+'/command',{method:'POST',headers:{Cookie:cookie,'Content-Type':'application/json'},body:'["snapshot"]'})).status,204);
   const blocked=await fetch(base+'/pair',{method:'POST',headers:{Origin:'http://unrelated.invalid','Content-Type':'application/x-www-form-urlencoded'},body:new URLSearchParams({code:settings.pairingCode})});
   assert.equal(blocked.status,403);
  }finally{remote.server.closeAllConnections();await new Promise(resolve=>remote.server.close(resolve));}
 }
 // A damaged local file must not silently replace a previously paired token.
 fs.writeFileSync(file,'{}');assert.throws(()=>loadRemoteSettings(file),/Invalid remote HUD credentials/);
});

test('incorrect pairing codes are rate-limited without opening control access', async t => {
 const remote=createRemoteHUD({pairingCode:'12345678'});
 await new Promise(resolve=>remote.server.listen(0,'127.0.0.1',resolve));
 t.after(()=>{remote.server.closeAllConnections();remote.server.close();});
 const base=`http://127.0.0.1:${remote.server.address().port}`;
 for(let i=0;i<6;i++) {
  const res=await fetch(base+'/pair',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'code=00000000',redirect:'manual'});
  assert.equal(res.status,i<5?403:429);assert.equal(res.headers.get('set-cookie'),null);
 }
 assert.equal((await fetch(base+'/events')).status,403);
});

test('pairing form preserves browser origin and accepts hostname case and charset parameters', async t => {
 const http=require('node:http');
 const remote=createRemoteHUD({pairingCode:'12345678'});
 await new Promise(resolve=>remote.server.listen(0,'127.0.0.1',resolve));
 t.after(()=>{remote.server.closeAllConnections();remote.server.close();});
 const port=remote.server.address().port;
 const page=await fetch(`http://127.0.0.1:${port}/`);
 assert.equal(page.headers.get('referrer-policy'),'same-origin');
 async function post(origin,type='application/x-www-form-urlencoded; charset=UTF-8') {
  return new Promise((resolve,reject)=>{
   const req=http.request({hostname:'127.0.0.1',port,path:'/pair',method:'POST',headers:{Host:'MacBook-Pro.local:7350',Origin:origin,'Content-Type':type}},res=>{res.resume();res.on('end',()=>resolve(res.statusCode));});
   req.on('error',reject);req.end('code=12345678');
  });
 }
 assert.equal(await post('http://macbook-pro.local:7350'),303);
 assert.equal(await post('http://MACBOOK-PRO.local:7350'),303);
 assert.equal(await post('http://unrelated.invalid:7350'),403);
 assert.equal(await post('null'),403);
});
