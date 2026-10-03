#!/usr/bin/env python3
"""Validate and build an RNBO minimal export against the existing DPT drivers. Never flash."""
import argparse, hashlib, json, pathlib, shutil, subprocess, sys, tempfile
ROOT=pathlib.Path(__file__).resolve().parent
DEFAULT=pathlib.Path.home()/'Documents/Max 8/Library/oopsy_repo/source'
def main():
 p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--oopsy-source',type=pathlib.Path,default=DEFAULT)
 p.add_argument('--export-dir',type=pathlib.Path,help='Import a Max minimal export, accepting rnbo_source.h or rnbo_source.cpp.h')
 p.add_argument('--host-test',action='store_true',help='Compile and run the exported DSP locally, without ARM build')
 p.add_argument('--check',action='store_true',help='Validate prerequisites without building')
 args=p.parse_args(); src=args.oopsy_source.resolve()
 if args.export_dir:
  export=args.export_dir.resolve()
  candidates=[export/n for n in ['rnbo_source.h','rnbo_source.cpp.h'] if (export/n).is_file()]
  if len(candidates)!=1 or not (export/'common/RNBO_MinimalEngine.h').is_file():
   sys.exit('Expected exactly one RNBO source header and a minimal common/ library in export directory.')
  source=candidates[0].read_text()
  if 'class rnbomatic' not in source or 'case TAG("hit"):' not in source:
   sys.exit('Export must contain class rnbomatic and named hit input; use the DPT export harness.')
  generated=ROOT/'generated';generated.mkdir(exist_ok=True)
  if candidates[0].resolve()!=(generated/'rnbo_source.h').resolve():shutil.copy2(candidates[0],generated/'rnbo_source.h')
  if (export/'common').resolve()!=(generated/'common').resolve():shutil.copytree(export/'common',generated/'common',dirs_exist_ok=True)
  if (export/'description.json').is_file() and export!=generated:shutil.copy2(export/'description.json',generated/'description.json')
 if args.host_test:
  with tempfile.TemporaryDirectory(prefix='mlr-dpt-') as temp:
   executable=str(pathlib.Path(temp)/'smoke')
   subprocess.run(['c++','-std=c++14','-O2','-fno-strict-aliasing','-I'+str(ROOT/'generated/common'),str(ROOT/'smoke.cpp'),'-o',executable],check=True)
   subprocess.run([executable],check=True)
  return
 required=[src/'lib/daisy_dpt.h',src/'lib/daisy_dpt.cpp',src/'lib/dev/DAC7554.cpp',src/'libdaisy/core/Makefile',src/'libdaisy/build/libdaisy.a',ROOT/'generated/rnbo_source.h',ROOT/'generated/common/RNBO_MinimalEngine.h']
 missing=[str(f) for f in required if not f.is_file()]
 for tool in ['arm-none-eabi-g++','arm-none-eabi-size','make']:
  if not shutil.which(tool):missing.append(tool)
 if missing:sys.exit('Missing prerequisites:\n'+'\n'.join(missing)+'\nOpen rnbo_kick_export.maxpat in Max and export Minimal C++ into generated/.')
 header=(ROOT/'generated/rnbo_source.h').read_text()
 if 'class rnbomatic' not in header or 'case TAG("hit"):' not in header:sys.exit('Expected RNBO class rnbomatic; re-export using the supplied configuration.')
 required += sorted((ROOT/'generated/common').glob('*.h')) + [ROOT/'main.cpp',ROOT/'rnbo_allocator.h',ROOT/'kick_cv.h',ROOT/'Makefile',src/'lib/dev/DAC7554.h',src/'libdaisy/core/STM32H750IB_flash.lds']
 record={'oopsy_source':str(src),'sample_rate':48000,'block_size':48,'sha256':{str(f):hashlib.sha256(f.read_bytes()).hexdigest() for f in required},'compiler':subprocess.check_output(['arm-none-eabi-g++','--version'],text=True).splitlines()[0]}
 if args.check:print(json.dumps(record,indent=2));return
 deps=ROOT/'.deps';deps.mkdir(exist_ok=True)
 for name,target in [('dpt',src/'lib'),('libdaisy',src/'libdaisy')]:
  link=deps/name
  if link.is_symlink() and link.resolve()==target.resolve():continue
  if link.exists() or link.is_symlink():sys.exit(f'{link} already points elsewhere; refusing to replace it.')
  link.symlink_to(target,target_is_directory=True)
 # GNU make needs a space-free working directory even though dependency targets may have spaces.
 if any(c.isspace() for c in str(ROOT)):sys.exit('Move this target to a space-free project path before building.')
 subprocess.run(['make','-j2'],cwd=ROOT,check=True)
 (ROOT/'build/build-inputs.json').write_text(json.dumps(record,indent=2)+'\n')
 subprocess.run(['arm-none-eabi-size','build/mlr_rnbo_kick.elf'],cwd=ROOT,check=True)
if __name__=='__main__':main()
