#!/bin/bash
# Reproducible local LiveCut audition build; third-party sources stay in release/.
set -euo pipefail
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
build_root="$repo_root/release/livecut"
mkdir -p "$build_root"
if [ ! -d "$build_root/Livecut/.git" ]; then
  git clone https://github.com/scheffle/Livecut.git "$build_root/Livecut"
  git -C "$build_root/Livecut" checkout ce00c216a5a974962163fbd5d4c465248dceac23
fi
if [ ! -d "$build_root/vst3sdk/.git" ]; then
  git clone --depth 1 --branch v3.7.4_build_25 --recursive --shallow-submodules \
    https://github.com/steinbergmedia/vst3sdk.git "$build_root/vst3sdk"
  git -C "$build_root/vst3sdk/vstgui4" fetch --depth 1 origin tag vstgui4_11_2
  git -C "$build_root/vst3sdk/vstgui4" checkout vstgui4_11_2
fi
# Compatibility edits only: CLT compiler support, explicit GUI option, and
# missing standard include / obsolete warning-as-error policy in VSTGUI 4.11.
python3 - "$build_root" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
p = root/'vst3sdk/cmake/modules/SMTG_DetectPlatform.cmake'
s = p.read_text().replace('message(FATAL_ERROR "[SMTG] XCode 9 or newer is required")',
 'message(STATUS "MLR audition: using installed Apple command-line compiler and macOS SDK")')
p.write_text(s)
p = root/'Livecut/VST3/CMakeLists.txt'
p.write_text(p.read_text().replace('set(SMTG_ADD_VSTGUI ON)', 'option(SMTG_ADD_VSTGUI "Build Livecut GUI" ON)'))
p = root/'vst3sdk/vstgui4/vstgui/lib/vstguibase.h'
s = p.read_text()
if '#include <utility>' not in s: p.write_text('#include <utility>\n'+s)
for folder in ['lib','uidescription','standalone']:
 p = root/'vst3sdk/vstgui4/vstgui'/folder/'CMakeLists.txt'
 p.write_text(p.read_text().replace('PRIVATE -Wall -Werror', 'PRIVATE -Wall'))
PY
cmake -S "$build_root/Livecut/VST3" -B "$build_root/build" \
 -DCMAKE_BUILD_TYPE=Release -Dvst3sdk_SOURCE_DIR="$build_root/vst3sdk" \
 -DCMAKE_OSX_ARCHITECTURES="$(uname -m)" -DSMTG_CREATE_PLUGIN_LINK=OFF \
 -DSMTG_ADD_VSTGUI=ON -DSMTG_ENABLE_VST3_HOSTING_EXAMPLES=OFF \
 -DSMTG_ENABLE_VST3_PLUGIN_EXAMPLES=OFF -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build "$build_root/build" --target Livecut -j 6
plugin="$build_root/build/VST3/Release/Livecut.vst3"
codesign --force --deep --sign - "$plugin"
file "$plugin/Contents/MacOS/Livecut"
if [ "${1:-}" = '--install' ]; then
 destination="$HOME/Library/Audio/Plug-Ins/VST3/Livecut.vst3"
 if [ -e "$destination" ]; then
  printf 'Existing plugin preserved: %s\nNew build: %s\n' "$destination" "$plugin"
  exit 1
 fi
 mkdir -p "$(dirname "$destination")"
 ditto "$plugin" "$destination"
 printf 'Installed: %s\n' "$destination"
fi
