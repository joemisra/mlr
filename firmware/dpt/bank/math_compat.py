"""Cache unchanged float32 DSP coefficients; preserve the exported equations."""
import re
HELPER='''
#include <cmath>
// One cache per exported call site. Single DSP instance, audio-thread ownership.
// Recompute whenever the input changes; no approximation of the math function.
template<int Site> static inline float mlr_dpt_exp(float x) {
 static float input=0,output=1;
 if(x!=input){input=x;output=std::exp(x);} return output;
}
template<int Site> static inline float mlr_dpt_tan(float x) {
 static float input=0,output=0;
 if(x!=input){input=x;output=std::tan(x);} return output;
}
template<int Site> static inline float mlr_dpt_drive_norm(float x) {
 static float input=0,output=0;
 if(x!=input){input=x;output=std::tanh(x);} return output;
}
'''
def adapt(text):
 if 'mlr_dpt_drive_norm' in text:raise ValueError('Math adapter expects the original/noise-adapted export')
 counts={}
 for name in ('exp','tan'):
  count=0
  def sub(m):
   nonlocal count
   count+=1
   return f'mlr_dpt_{name}<{count}>('
  text,n=re.subn(r'\brnbo_'+name+r'\(',sub,text)
  if n<1:raise ValueError('Missing expected '+name+' call sites')
  counts[name]=n
 count=0
 def drive(m):
  nonlocal count
  count+=1
  return f'mlr_dpt_drive_norm<{count}>(drive)'
 text,n=re.subn(r'\brnbo_tanh\(drive\)',drive,text)
 if n!=16:raise ValueError(f'Expected 16 drive normalization calls, got {n}')
 # RNBO's mixed int/float overload otherwise dispatches double pow().
 text,n=re.subn(r'\brnbo_pow\(\s*2,', 'rnbo_pow(2.0f,', text)
 if n!=2:raise ValueError(f'Expected two bass pow(2, ...) calls, got {n}')
 return HELPER+text
