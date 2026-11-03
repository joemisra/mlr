"use strict";
// Optional Node for Max service. Built-ins only; no dependency installation.
const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const os = require('node:os');
const Model = require('./hud_model.js');
const COMMANDS = new Set(['snapshot','target','bar','transport','display_recover','hardware_colors','bank_open','bank_scan','bank_reload','sample_assign','sample_audition','sample_preview_stop','sample_grid','sample_folder','color_role','color_reset','strip_select','strip_set','strip_snapshot','group_volume','group_mute','phase_set','phase_preset','phase_snapshot','rack_bypass','rack_clear','rack_load','rack_move','rack_open','rack_refresh','session_command','session_confirm','session_new','session_open','session_save','session_save_as','session_relink']);
// Workstation credentials live outside sessions and generated project folders.
function loadRemoteSettings(file = path.join(os.homedir(),'.mlr','remote-hud.json')) {
 try {
  const settings = JSON.parse(fs.readFileSync(file,'utf8'));
  if (!/^[a-f0-9]{36}$/.test(settings.token) || !/^\d{8}$/.test(settings.pairingCode)) throw Error('Invalid remote HUD credentials: ' + file);
  return settings;
 } catch (error) {
  if (error.code !== 'ENOENT') throw error;
  fs.mkdirSync(path.dirname(file),{recursive:true,mode:0o700});
  const settings = {token:crypto.randomBytes(18).toString('hex'),pairingCode:String(crypto.randomInt(10000000,100000000))};
  try { fs.writeFileSync(file,JSON.stringify(settings,null,2)+'\n',{flag:'wx',mode:0o600}); }
  catch (writeError) { if (writeError.code === 'EEXIST') return loadRemoteSettings(file); throw writeError; }
  return settings;
 }
}
const PAIR_PAGE = `<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Pair remote HUD</title><style>body{background:#0a0d12;color:#e2e8f0;font:18px system-ui;max-width:360px;margin:15vh auto;padding:24px}input,button{box-sizing:border-box;width:100%;font:inherit;padding:14px;margin-top:16px;border-radius:8px}button{background:#00d2ff;border:0}p{line-height:1.5}</style></head><body><h1>Remote HUD</h1><p>Enter the pairing code shown in Max. This browser will remember it.</p><form method="post" action="/pair"><label>Pairing code<input name="code" inputmode="numeric" pattern="[0-9]{8}" maxlength="8" autocomplete="one-time-code" required autofocus></label><button>Connect</button></form></body></html>`;
function sameRequestOrigin(req) {
 if (!req.headers.origin) return true;
 try { return new URL(req.headers.origin).origin === new URL(`http://${req.headers.host}`).origin; }
 catch (_) { return false; }
}
function requestMediaType(req) {return String(req.headers['content-type'] || '').split(';')[0].trim().toLowerCase();}
function createRemoteHUD({command = () => {}, stream = () => {}, pairingCode = '', token = crypto.randomBytes(18).toString('hex')} = {}) {
 const state = Model.createState(), clients = new Set();
 const assets = {'/':'remote_hud.html','/client.js':'remote_hud_client.js','/hud.js':'hud.js'};
 const modules = ['hud_model.js','mlr_product.js','phase_cut_model.js'];
 const pairAttempts = new Map();
 function setPairCookie(res) { res.setHeader('Set-Cookie',`mlr_hud=${token}; HttpOnly; SameSite=Strict; Path=/; Max-Age=31536000`); }
 function send(res, event, data) { if (res.writableLength > 1024 * 1024) { res.destroy(); clients.delete(res); return; } res.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`); }
 const server = http.createServer(async (req,res) => {
  const url = new URL(req.url, 'http://localhost');
  res.setHeader('Cache-Control','no-store');
  // A no-referrer policy makes browser form POSTs carry Origin: null.
  // Keep same-origin form provenance while withholding referrers off-site.
  res.setHeader('Referrer-Policy','same-origin');
  const originOK = sameRequestOrigin(req);
  if (req.method === 'POST' && url.pathname === '/pair') {
   if (!originOK || requestMediaType(req) !== 'application/x-www-form-urlencoded') { res.writeHead(403); res.end(); return; }
   const address = req.socket.remoteAddress;
   const previous = pairAttempts.get(address);
   const attempt = previous && Date.now()-previous.started < 60000 ? previous : {started:Date.now(),count:0};
   if (attempt.count >= 5) { res.writeHead(429); res.end('Too many attempts. Please wait one minute.'); return; }
   try {
    let body=''; for await (const chunk of req) { body+=chunk; if(body.length>128)throw Error('Invalid code'); }
    if (!pairingCode || new URLSearchParams(body).get('code') !== pairingCode) {
     attempt.count++; pairAttempts.set(address,attempt); res.writeHead(403); res.end('Incorrect pairing code. Go back and try again.'); return;
    }
    pairAttempts.delete(address);setPairCookie(res);res.writeHead(303,{Location:'/'});res.end();
   } catch (_) { res.writeHead(400);res.end('Invalid pairing request'); }
   return;
  }
  const cookie = String(req.headers.cookie || '').split(';').some(value=>value.trim() === `mlr_hud=${token}`);
  const tokenOK = url.searchParams.get('token') === token;
  if (!cookie && !tokenOK) {
   if (req.method === 'GET' && url.pathname === '/' && pairingCode) {res.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});res.end(PAIR_PAGE);return;}
   res.writeHead(403);res.end('Open the HUD home page to pair this browser.');return;
  }
  // Old token bookmarks still work and establish the same persistent browser cookie.
  if (tokenOK && req.method === 'GET' && url.pathname === '/') setPairCookie(res);

  if (req.method === 'GET' && url.pathname === '/events') {
   res.writeHead(200, {'Content-Type':'text/event-stream','Connection':'keep-alive'});
   const first = clients.size === 0;
   clients.add(res); send(res,'snapshot',state);
   if (first) { stream(1); command(['snapshot']); }
   req.on('close', () => { clients.delete(res); if (!clients.size) stream(0); });
   return;
  }
  if (req.method === 'POST' && url.pathname === '/command') {
   // JSON header prevents cross-origin form posts; no CORS access is granted.
   if (requestMediaType(req) !== 'application/json' || !originOK) { res.writeHead(403); res.end(); return; }
   try {
    let body = ''; for await (const chunk of req) { body += chunk; if (body.length > 16384) throw Error('Too large'); }
    const args = JSON.parse(body);
    if (!Array.isArray(args) || !COMMANDS.has(args[0]) || args.length > 32 || args.some(v => !['string','number'].includes(typeof v) || (typeof v === 'number' && !Number.isFinite(v)))) throw Error('Invalid command');
    command(args); res.writeHead(204); res.end();
   } catch (_) { res.writeHead(400); res.end('Invalid command'); } return;
  }
  if (req.method === 'GET' && url.pathname === '/modules.js') {
   res.setHeader('Content-Type','text/javascript');
   res.end('var remoteModules = {};\n' + modules.map(name => `remoteModules[${JSON.stringify(name)}] = (function(){var module={exports:{}};var exports=module.exports;var require=function(n){return remoteModules[n.replace(/^\\.\\//,"")];};\n${fs.readFileSync(path.join(__dirname,name),'utf8')}\nreturn module.exports;})();`).reverse().join('\n') + '\nfunction require(n){return remoteModules[n];}'); return;
  }
  if (req.method === 'GET' && assets[url.pathname]) {
   res.setHeader('Content-Type',url.pathname === '/' ? 'text/html; charset=utf-8':'text/javascript');
   res.end(fs.readFileSync(path.join(__dirname,assets[url.pathname]))); return;
  }
  res.writeHead(404); res.end();
 });
 const heartbeat = setInterval(() => { for (const res of clients) res.write(': heartbeat\n\n'); },15000);
 heartbeat.unref(); server.on('close',()=>{clearInterval(heartbeat); for(const res of clients)res.end();});
 function ingestBatch(batch) {
  if (!Array.isArray(batch)) return;
  for (const [topic,args] of batch) Model.applyEvent(state,topic,args);
  for (const res of clients) send(res,'updates',batch);
 }
 return { server, token, ingestBatch, ingest(topic,args) { ingestBatch([[topic,args]]); } };
}
// Reassemble bounded Max symbol fragments before attempting JSON parsing.
function createBatchReceiver(accept) {
 let transfer = null;
 return function receive(id,index,count,chunk) {
  if (!Number.isInteger(id) || !Number.isInteger(index) || !Number.isInteger(count) || count < 1 || count > 4096 || index < 0 || index >= count || typeof chunk !== 'string' || chunk.length > 4096) throw Error('Invalid batch chunk');
  if (index === 0) transfer = {id,count,parts:[]};
  if (!transfer || transfer.id !== id || transfer.count !== count || index !== transfer.parts.length) { transfer = null; throw Error('Out-of-order batch chunk'); }
  transfer.parts.push(chunk);
  if (transfer.parts.length === count) {
   const json = transfer.parts.join(''); transfer = null;
   accept(JSON.parse(json));
  }
 };
}
module.exports = {createRemoteHUD, createBatchReceiver, loadRemoteSettings, COMMANDS};
let max;
try { max = require('max-api'); } catch (_) {}
if (max) {
 const settings = loadRemoteSettings();
 const remote = createRemoteHUD({...settings, command: args => max.outlet(...args), stream: enabled => max.outlet('remote_stream',enabled)});
 let lastBatchError = 0;
 function reportBatchError(error) {
  if (Date.now() - lastBatchError < 5000) return;
  lastBatchError = Date.now(); max.post('Remote HUD batch: ' + error.message);
 }
 const receiveChunk = createBatchReceiver(batch => remote.ingestBatch(batch));
 max.addHandler('batch', json => {
  try { remote.ingestBatch(JSON.parse(json)); } catch (error) { reportBatchError(error); }
 });
 max.addHandler('batch_chunk', (...args) => {
  try { receiveChunk(...args); } catch (error) { reportBatchError(error); }
 });
 remote.server.on('error', error => max.post(`Remote HUD: ${error.message}`));
 remote.server.listen(7350,'0.0.0.0',()=>{
  const host = os.hostname().replace(/\.local$/i,'');
  max.post(`Remote HUD bookmark: http://${host}.local:7350/`);
  max.post(`Pairing code (enter once per browser): ${settings.pairingCode}`);
  max.post('Same-Wi-Fi IP fallback:');
  for(const entries of Object.values(os.networkInterfaces()))for(const address of entries || [])if(address.family === 'IPv4' && !address.internal)max.post(`http://${address.address}:7350/`);
  max.outlet('remote_stream',0);
 });
}
