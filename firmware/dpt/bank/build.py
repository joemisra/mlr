#!/usr/bin/env python3
"""Build the eight-engine RNBO bank; never programs the board."""
import argparse, pathlib, shutil, subprocess, sys, hashlib, json
ROOT=pathlib.Path(__file__).resolve().parent
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--memory',choices=['flash','sram'],default='flash')
p.add_argument('--export-dir',type=pathlib.Path)
p.add_argument('--host-test',action='store_true')
p.add_argument('--midi-test',action='store_true')
a=p.parse_args()
if a.midi_test:
 import tempfile
 with tempfile.TemporaryDirectory(prefix='dpt-midi-') as temp:
  exe=str(pathlib.Path(temp)/'test')
  subprocess.run(['c++','-std=c++14','-O2',str(ROOT/'midi_test.cpp'),'-o',exe],check=True)
  subprocess.run([exe],check=True)
 sys.exit(0)
if a.export_dir:
 source=a.export_dir.resolve()
 headers=[source/n for n in ['rnbo_source.h','rnbo_source.cpp.h'] if (source/n).is_file()]
 if len(headers)!=1 or not (source/'common/RNBO_MinimalEngine.h').is_file():sys.exit('Expected one minimal RNBO export header and common/.')
 text=headers[0].read_text()
 for voice in ['kick','snare','hat','clap','tom','rim','bell','bass']:
  if 'case TAG("hit_'+voice+'"):' not in text:sys.exit('Wrong export: missing hit_'+voice)
 if 'class rnbomatic' not in text:sys.exit('Export class must be rnbomatic.')
 out=ROOT/'generated';out.mkdir(exist_ok=True)
 if headers[0]!=(out/'rnbo_source.h'):shutil.copy2(headers[0],out/'rnbo_source.h')
 if source/'common'!=out/'common':shutil.copytree(source/'common',out/'common',dirs_exist_ok=True)
if not (ROOT/'generated/rnbo_source.h').is_file():sys.exit('Export rnbo_bank_export.maxpat as Minimal C++ first, then run with --export-dir PATH.')
for dep in ['dpt','libdaisy']:
 if not (ROOT.parent/'.deps'/dep).is_dir():sys.exit('Run the kick target build first to resolve local Oopsy dependencies.')
# Refuse to turn a stale kick export into a bank build, even without import.
text=(ROOT/'generated/rnbo_source.h').read_text()
for voice in ['kick','snare','hat','clap','tom','rim','bell','bass']:
 if 'case TAG("hit_'+voice+'"):' not in text:sys.exit('Wrong generated header: missing '+voice)
from noise_compat import adapt
from math_compat import adapt as adapt_math
source=ROOT/'generated/rnbo_source.h'
original=source.read_text()
if 'mlr_dpt_noise_next' not in original:
 (ROOT/'generated/rnbo_source.original.h').write_text(original)
adapted=adapt_math(adapt((ROOT/'generated/rnbo_source.original.h').read_text()))
if adapted!=source.read_text():source.write_text(adapted)
if a.host_test:
 import tempfile
 with tempfile.TemporaryDirectory(prefix='dpt-bank-') as temp:
  exe=str(pathlib.Path(temp)/'smoke')
  subprocess.run(['c++','-std=c++14','-O2','-fno-strict-aliasing','-I'+str(ROOT/'generated/common'),str(ROOT/'smoke.cpp'),'-o',exe],check=True)
  subprocess.run([exe],check=True)
 sys.exit(0)
# Bootloader v6 resets the MCU before entering the SRAM application. The old
# Oopsy driver assumes v4 left clocks configured; adapt only our local copy.
driver=(ROOT.parent/'.deps/dpt/daisy_dpt.cpp').read_text()
old='if (memory != System::MemoryRegion::INTERNAL_FLASH)\n                syscfg.skip_clocks = true;'
if driver.count(old)!=1:sys.exit('Unexpected DPT clock setup; refusing to adapt it.')
driver=driver.replace(old,'// v6 bootloader enters after reset: initialize clocks and MPU.\n            syscfg.skip_clocks = false;')
out=ROOT/'generated/daisy_dpt_bank.cpp'
if not out.exists() or out.read_text()!=driver:out.write_text(driver)
# Old USB transport repeats the first event in multi-packet USB transfers.
usb=(ROOT.parent/'.deps/libdaisy/src/hid/usb_midi.cpp').read_text()
old='midi_usb_handle.UsbToMidi(buffer, packet_length);'
if usb.count(old)!=1:sys.exit('Unexpected USB receive callback; inspect before adapting.')
usb=usb.replace(old,'midi_usb_handle.UsbToMidi(buffer + i, packet_length);')
out=ROOT/'generated/usb_midi_bank.cpp'
if not out.exists() or out.read_text()!=usb:out.write_text(usb)
layout=(ROOT.parent/('.deps/libdaisy/core/STM32H750IB_'+a.memory+'.lds')).read_text()
marker='\t.bss (NOLOAD) :'
if layout.count(marker)!=1:sys.exit('Unexpected libDaisy linker layout; refusing to modify it.')
layout=layout.replace(marker,(ROOT/'rnbo_arena.ld').read_text()+'\n'+marker)
(ROOT/('generated/layout_'+a.memory+'.lds')).write_text(layout)
subprocess.run(['make','-j2','MEMORY='+a.memory],cwd=ROOT,check=True)
files=[ROOT/'generated/usb_midi_bank.cpp',ROOT/'generated/daisy_dpt_bank.cpp',ROOT/'build.py',ROOT/('generated/layout_'+a.memory+'.lds'),ROOT/'rnbo_arena.ld',ROOT/'noise_compat.py',ROOT/'math_compat.py',ROOT/'generated/rnbo_source.original.h',ROOT/'main.cpp',ROOT/'Makefile',ROOT/'midi_state.h',ROOT/'usb_protocol.h',ROOT/'physical_ranges.h',ROOT/'midi_queue.h',ROOT/'bank_parameters.h',ROOT/'generated/rnbo_source.h',ROOT.parent/'rnbo_allocator.h',ROOT/'channel_knobs.h']+list((ROOT/'generated/common').glob('*.h'))
files += [ROOT.parent/'.deps/dpt/daisy_dpt.cpp',ROOT.parent/'.deps/dpt/daisy_dpt.h',ROOT.parent/'.deps/dpt/dev/DAC7554.cpp',ROOT.parent/'.deps/dpt/dev/DAC7554.h',ROOT.parent/'.deps/libdaisy/build/libdaisy.a',ROOT.parent/('.deps/libdaisy/core/STM32H750IB_'+a.memory+'.lds')]
record={'memory':a.memory,'compiler':subprocess.check_output(['arm-none-eabi-g++','--version'],text=True).splitlines()[0],'inputs':{str(f):hashlib.sha256(f.read_bytes()).hexdigest() for f in files}}
(ROOT/'build'/a.memory/'build-inputs.json').write_text(json.dumps(record,indent=2)+'\n')
subprocess.run(['arm-none-eabi-size','build/'+a.memory+'/mlr_rnbo_bank_'+a.memory+'.elf'],cwd=ROOT,check=True)

image=ROOT/'build'/a.memory/('mlr_rnbo_bank_'+a.memory+'.bin')
image.with_suffix('.sha256').write_text(hashlib.sha256(image.read_bytes()).hexdigest()+'  '+str(image)+'\n')
