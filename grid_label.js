// A transient 3x5 bitmap label, centered in rows 2-6 of the upper grid.
// Four characters fit a 16-column grid; callers supply meaningful abbreviations.
var FONT = {
 A:['010','101','111','101','101'], B:['110','101','110','101','110'], C:['011','100','100','100','011'], D:['110','101','101','101','110'], E:['111','100','110','100','111'], F:['111','100','110','100','100'], G:['011','100','101','101','011'], H:['101','101','111','101','101'], I:['111','010','010','010','111'], J:['001','001','001','101','010'], K:['101','101','110','101','101'], L:['100','100','100','100','111'], M:['101','111','111','101','101'], N:['101','111','111','111','101'], O:['010','101','101','101','010'], P:['110','101','110','100','100'], Q:['010','101','101','111','011'], R:['110','101','110','101','101'], S:['011','100','010','001','110'], T:['111','010','010','010','010'], U:['101','101','101','101','111'], V:['101','101','101','101','010'], W:['101','101','111','111','101'], X:['101','101','010','101','101'], Y:['101','101','010','010','010'], Z:['111','001','010','100','111'], ' ':['000','000','000','000','000']
};
function bitmap(label,width,height) {
 var mask=new Uint8Array(width*height), word=String(label||'').toUpperCase().replace(/[^A-Z ]/g,'').slice(0,Math.floor((width+1)/4));
 var left=Math.floor((width-(word.length*4-1))/2);
 for(var c=0;c<word.length;c++)for(var y=0;y<5 && y+1<Math.min(8,height);y++)for(var x=0;x<3;x++)
  if(FONT[word[c]][y][x]==='1')mask[(y+1)*width+left+c*4+x]=1;
 return mask;
}
function opacity(elapsed) { return elapsed<500 ? 1 : Math.max(0,1-(elapsed-500)/500); }
function level(base,glyph,alpha) { return Math.round(base*(1-alpha)+(glyph?15:2)*alpha); }
function color(rgb,glyph,alpha) { return glyph ? rgb.map(function(v){return Math.round(v*(1-alpha)+255*alpha);}) : rgb; }
exports.bitmap=bitmap;exports.opacity=opacity;exports.level=level;exports.color=color;
