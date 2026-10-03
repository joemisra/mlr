"""Keep the exported Park–Miller noise sequence exact in float32 firmware.
Only the six recognized 31-bit LCG state declarations/updates are adapted.
The original Max export is retained as generated/rnbo_source.original.h.
"""
import re
HELPER='''
#include <cstdint>
// Schrage form: exact Park–Miller update without float rounding or 64-bit division.
static inline uint32_t mlr_dpt_noise_next(uint32_t offset) {
    const int32_t state = static_cast<int32_t>(offset + 1u);
    int32_t next = 16807 * (state % 127773) - 2836 * (state / 127773);
    if (next <= 0) next += 2147483647;
    return static_cast<uint32_t>(next - 1);
}
'''
def adapt(text):
 if 'mlr_dpt_noise_next' in text:return text
 pattern=r'(__codebox_tilde_\d+_(?:noiseState|scatterState)) = this->wrap\(\(\1 \+ 1\) \* 16807, 0, 2147483647\) - 1;'
 states=re.findall(pattern,text)
 if len(states)!=6:raise ValueError('Expected six known Park–Miller generators; inspect the changed export before adapting.')
 for local in states:
  member=local[2:]
  text,n=re.subn(r'\bnumber '+member+r';','uint32_t '+member+';',text)
  if n!=1:raise ValueError('Unexpected noise state declaration: '+member)
 text,n=re.subn(pattern,lambda m:m[1]+' = mlr_dpt_noise_next('+m[1]+');',text)
 assert n==6
 return HELPER+text
if __name__=='__main__':
 from pathlib import Path
 root=Path(__file__).resolve().parent
 src=root/'generated/rnbo_source.h';original=root/'generated/rnbo_source.original.h'
 text=src.read_text()
 if 'mlr_dpt_noise_next' not in text:original.write_text(text)
 src.write_text(adapt(text))
