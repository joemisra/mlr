"use strict";
var autowatch, inlets, outlets;
var canvas = document.getElementById('hud'), ctx = canvas.getContext('2d');
var connected = false, commandQueue = Promise.resolve();
var mgraphics = {
 size:[720,480], init:function(){}, redraw:function(){paint();},
 set_source_rgba:function(r,g,b,a){ctx.fillStyle=ctx.strokeStyle='rgba('+[r*255,g*255,b*255,a].join(',')+')';},
 // Match mgraphics: geometry accumulates until fill/stroke consumes the path.
 rectangle:function(x,y,w,h){ctx.rect(x,y,w,h);},
 fill:function(){ctx.fill();ctx.beginPath();}, stroke:function(){ctx.stroke();ctx.beginPath();},
 set_line_width:function(w){ctx.lineWidth=w;},
 move_to:function(x,y){ctx.moveTo(x,y);this.textX=x;this.textY=y;},
 line_to:function(x,y){ctx.lineTo(x,y);},
 select_font_face:function(name){this.font=name;},
 set_font_size:function(size){ctx.font=(/Bold/.test(this.font)?'bold ':'')+size+'px '+(/Menlo/.test(this.font)?'monospace':'Arial, sans-serif');},
 show_text:function(text){ctx.fillText(text,this.textX,this.textY);}
};
function Task(callback,owner){this.callback=callback.bind(owner);}
Task.prototype.cancel=function(){clearTimeout(this.timer);};
Task.prototype.schedule=function(delay){this.cancel();this.timer=setTimeout(this.callback,delay);};
function outlet(index){
 var args=Array.prototype.slice.call(arguments,1);
 if(!connected)return;
 commandQueue=commandQueue.then(function(){return fetch('/command'+location.search,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(args)});}).then(function(response){if(!response.ok)throw Error('Command rejected');}).catch(function(error){document.getElementById('status').textContent=error.message;});
}
window.addEventListener('load',function(){
 function resize(){var w=Math.max(720,window.innerWidth),h=Math.max(320,(window.innerHeight-36)*w/window.innerWidth);mgraphics.size=[w,h];canvas.width=w*devicePixelRatio;canvas.height=h*devicePixelRatio;canvas.style.height=(window.innerHeight-36)+'px';ctx.setTransform(devicePixelRatio,0,0,devicePixelRatio,0,0);paint();}
 resize();window.addEventListener('resize',resize);
 function point(event){var rect=canvas.getBoundingClientRect();return {clientX:(event.clientX-rect.left)*mgraphics.size[0]/rect.width,clientY:(event.clientY-rect.top)*mgraphics.size[1]/rect.height};}
 canvas.addEventListener('pointerdown',function(e){if(!connected)return;canvas.setPointerCapture(e.pointerId);onpointerdown(point(e));});
 canvas.addEventListener('pointermove',function(e){if(connected)onpointermove(point(e));});
 canvas.addEventListener('pointerup',function(e){if(connected)onpointerup(point(e));});
 canvas.addEventListener('pointercancel',function(){scrollbarDrag=null;});
 var events=new EventSource('/events'+location.search);
 events.addEventListener('snapshot',function(e){var previous=state;state=JSON.parse(e.data);for(var key of ['page','selectedTrack','selectedChannelStrip','selectedSample','samplePage','stripView','helpTopic'])state[key]=previous[key];visibleEventSignatures={};paint();});
 events.addEventListener('updates',function(e){var batch=JSON.parse(e.data);for(var data of batch)receive(data[0],data[1]);});
 events.onopen=function(){connected=true;document.getElementById('status').textContent='Connected · '+Model.Product.name;};
 events.onerror=function(){connected=false;scrollbarDrag=null;document.getElementById('status').textContent='Disconnected · reconnecting…';};
 var wakeLock;
 async function stayAwake(){if(document.visibilityState==='visible' && navigator.wakeLock)try{wakeLock=await navigator.wakeLock.request('screen');}catch(_){} }
 document.getElementById('fullscreen').onclick=async function(){try{await document.documentElement.requestFullscreen();}catch(_){}await stayAwake();};
 document.addEventListener('visibilitychange',function(){if(wakeLock && document.visibilityState==='visible')stayAwake();});
});
