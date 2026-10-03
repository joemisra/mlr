const fs=require('node:fs'),path=require('node:path');
const root=path.resolve(__dirname,'..');
const patch=JSON.parse(fs.readFileSync(path.join(root,'sequence64_native_rnbo_probe.maxpat'))).patcher;
const boxes=Object.fromEntries(patch.boxes.map(({box})=>[box.id,box]));
boxes.player.text='sequence64_native_bridge';
boxes.start.text='nativeSequence64Groups 1 2 3 4 5 6';
boxes.stop.text='nativeSequence64Stop';
boxes.fixture.text='v8 sequence64_native_integration_fixture.js @autowatch 0';boxes.fixture.maxclass='newobj';
boxes.title.text='Native integration probe — actual router, optional bridge, production dispatch and six RNBO voices; no hardware output';
boxes.write.text='writewave /tmp/mlr-native-integration-probe.wav';
patch.lines=patch.lines.filter(({patchline:e})=>e.source[0]!=='player'&&e.destination[0]!=='player');
function add(id,text,x,y){patch.boxes.push({box:{id,maxclass:'newobj',text,patching_rect:[x,y,250,22]}});}
function connect(s,o,d,i){patch.lines.push({patchline:{source:[s,o],destination:[d,i]}});}
add('pulse-send','s sequence64_pulse',100,1480);connect('edge',0,'pulse-send',0);
add('native-frame','r sequence64_native_frame',650,1480);connect('native-frame',0,'route',0);
add('router','v8 grid_router.js @autowatch 0',1800,1480);
add('router-receive','r gridrouter',1800,1430);connect('router-receive',0,'router',0);
add('router-pulse','r sequence64_pulse',2100,1430);connect('router-pulse',0,'router',3);
add('router-send','s gridrouter',500,1480);connect('start',0,'router-send',0);connect('stop',0,'router-send',0);
add('fixture-defer','deferlow',500,1530);
patch.lines=patch.lines.filter(({patchline:e})=>!(e.source[0]==='load'&&e.destination[0]==='fixture'));
connect('load',0,'fixture-defer',0);connect('fixture-defer',0,'fixture',0);
const bridge=JSON.parse(fs.readFileSync(path.join(root,'sequence64_audio_bridge.maxpat'))).patcher;
patch.boxes.push({box:{id:'dispatch',maxclass:'newobj',text:'p production_audio_dispatch',patcher:bridge,patching_rect:[1800,1550,250,22]}});
add('hud','r mlr_hud_state',1800,1630);add('notices','route notice',1800,1670);add('notice-print','print native_integration',1800,1710);
connect('hud',0,'notices',0);connect('notices',0,'notice-print',0);
['kick','snare','hat','clap','tom','rim'].forEach((id,ch)=>{
    boxes[id+'-order'].text='t b b';
    // Replace the direct RNBO trigger adapter with the labs' actual native
    // step cache and track-press trigger path, fed by the production bridge.
    patch.lines=patch.lines.filter(({patchline:e})=>!(e.source[0]==='route'&&e.destination[0]===id+'-slice')&&
        !(e.source[0]===id+'-slice')&&!(e.source[0]===id+'-order'&&e.source[1]===1));
    add(id+'-step','r rnbo_'+id+'_step',ch*260+40,2100);
    add(id+'-step-unpack','unpack '+Array(12).fill('f').join(' '),ch*260+40,2140);
    add(id+'-pak','pak '+Array(12).fill('0.').join(' '),ch*260+40,2180);
    add(id+'-values','zl reg',ch*260+40,2220);
    connect(id+'-step',0,id+'-step-unpack',0);
    for(let i=0;i<12;i++)connect(id+'-step-unpack',i,id+'-pak',i);
    connect(id+'-pak',0,id+'-values',1);connect(id+'-order',1,id+'-values',0);connect(id+'-values',0,id+'-unpack',0);
    add(id+'-press','r '+(16-ch)+'input',ch*260+40,2280);
    add(id+'-press-unpack','unpack i i',ch*260+40,2320);
    add(id+'-press-select','sel 1',ch*260+40,2360);
    connect(id+'-press',0,id+'-press-unpack',0);connect(id+'-press-unpack',1,id+'-press-select',0);
    connect(id+'-press-select',0,id+'-order',0);
});
fs.writeFileSync(path.join(root,'sequence64_native_integration_probe.maxpat'),JSON.stringify({patcher:patch},null,2)+'\n');
