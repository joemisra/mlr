// Shared portable mapping code for catalog-based voices. No runtime/UI state.
exports.create = function(engine) {
 var defs={},ids=[];
 engine.parameters.forEach(function(p){defs[p.id]=p;ids.push(p.id);});
 function definition(id){return Object.prototype.hasOwnProperty.call(defs,id)?defs[id]:null;}
 function clampValue(id,value){
  var p=definition(id),n=Number(value);if(!p)return null;
  if(value===null||value===undefined||value===''||!isFinite(n))n=p.initial;
  n=Math.max(p.min,Math.min(p.max,n));return p.integer?Math.round(n):n;
 }
 function mappingRange(id,range){
  var p=definition(id);if(!p)return null;
  var lo=range&&Number(range.min),hi=range&&Number(range.max);
  if(range&&isFinite(lo)&&isFinite(hi)){
   lo=Math.max(p.min,Math.min(p.max,lo));hi=Math.max(p.min,Math.min(p.max,hi));
   if(lo<hi)return {min:lo,max:hi};
  }
  return {min:p.gridMin,max:p.gridMax};
 }
 function fromNormalized(id,position,range){
  var p=definition(id),r=mappingRange(id,range);if(!p)return null;
  var n=Math.max(0,Math.min(1,Number(position)||0));
  if(n===0)return clampValue(id,r.min);if(n===1)return clampValue(id,r.max);
  if(p.scale==='log')return clampValue(id,r.min*Math.pow(r.max/r.min,n));
  if(p.scale==='square')n*=n;
  return clampValue(id,r.min+(r.max-r.min)*n);
 }
 function toNormalized(id,value,range){
  var p=definition(id),r=mappingRange(id,range);if(!p)return 0;
  var n=Math.max(r.min,Math.min(r.max,clampValue(id,value)));
  if(p.scale==='log')return Math.log(n/r.min)/Math.log(r.max/r.min);
  n=(n-r.min)/(r.max-r.min);return p.scale==='square'?Math.sqrt(n):n;
 }
 var api={definition:definition,clampValue:clampValue,mappingRange:mappingRange,
  fromNormalized:fromNormalized,toNormalized:toNormalized,
  sanitize:function(values){var out={};ids.forEach(function(id){out[id]=clampValue(id,(values||{})[id]);});return out;},
  idForRNBO:function(name){for(var i=0;i<ids.length;i++)if(defs[ids[i]].rnbo===name)return ids[i];return null;}};
 api[engine.id.toUpperCase()+'_TRACK']=engine.track;
 api[engine.id.toUpperCase()+'_LOCKS']=ids;
 api[engine.id.toUpperCase()+'_PAGES']=engine.pageIndices.map(function(indices,i){return {name:engine.pageNames[i],parameters:indices.map(function(n){return ids[n];})};});
 return api;
};
