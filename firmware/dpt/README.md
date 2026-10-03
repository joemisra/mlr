# RNBO → DPT: first build target

This is a separate **kick-only bring-up target** for the user-confirmed v2.11 DPT. The desktop eight-engine lab stays intact. Gate input 1 triggers the original kick; codec outputs 1/2 carry dual mono at 0.5 adapter gain. Eight CV inputs now set the controls listed below. Gate polling is once per 48-sample block (1 ms at 48 kHz), not sample-accurate edge timestamping. MIDI, all-eight mixing, and external DAC audio are subsequent stages.

## Current status

Located the January Oopsy development checkout at `/Users/jm/Documents/Max 8/Library/oopsy_repo`. Hardware project link: `/Users/jm/Projects/dsp-hardware/dpt/firmware/oopsy`. Its `DPT_OOPSY_PROJECT_CONTEXT.md` records a working oscillator example and an unresolved reverb startup/silence investigation. Those are historical reports, not a fresh hardware verification.

The actual DPT implementation uses the custom `source/lib/daisy_dpt.{h,cpp}`, `source/lib/dev/DAC7554.{h,cpp}`, and bundled libDaisy. It initializes the Patch SM hardware, including peripherals beyond the codec. In particular, **its existing Init routine pulses both gate outputs during its startup blink test**. Keep downstream gate destinations disconnected during bring-up. The RNBO adapter does not deliberately write external DAC audio, but it still runs that existing hardware initialization.

The old context document is not exact source documentation: it describes gate Debounce calls that are absent in the current driver; the current implementation calls `Trig()` directly. Preserve this driver version during initial validation.

The user exported the supplied harness into `../../rnbo_kick` on September 30, 2026. Its `rnbo_source.cpp.h` and common headers have been imported into `generated/`. **The user confirmed the gate-only firmware works on DPT: gate 1 triggers kick audio on outputs 1/2. The new eight-CV build compiles and passes host tests; its physical control mapping still needs testing.**

The actual exported C++ also passes a native Mac smoke test: silence before a hit, finite dual-mono output after the named `hit` message, and a silent tail after four seconds. The shared allocator is sealed before triggering; this run makes no further allocations and uses 6,600 bytes of its 32 KiB pool on the Mac. MCU allocation use and CPU load still require measurement on hardware.

Eight-CV ARM link: 119,116 bytes flash (90.88% of 128 KiB), 130,820 bytes main SRAM (24.95% of 512 KiB), and 17,160 bytes RAM_D2. No linked SDRAM allocation. This leaves 11,956 bytes of internal flash; review the code footprint or execution layout before adding the full engine bank. RNBO signal helpers are compiled with strict aliasing disabled. Generated-code signedness/unused warnings and inherited bare-metal syscall/linker warnings remain.

## Eight CV controls

| Input | Kick parameter | Range | Curve |
| --- | --- | --- | --- |
| CV 1 | Pitch | 20–120 Hz | Log |
| CV 2 | Decay | 20–2000 ms | Log |
| CV 3 | FM amount | 0–4 | Square |
| CV 4 | Drive | 0.25–8 | Log |
| CV 5 | Sweep amount | 0–600 Hz | Square |
| CV 6 | Sweep decay | 1–300 ms | Log |
| CV 7 | FM ratio | 0.125–8 | Log |
| CV 8 | Resonator mix | 0–1 | Linear |

These use the default lab grid ranges in `instrument_model.js`; saved desktop range presets are not transferred automatically. The driver initializes CV_1 through CV_8 as bipolar controls. We map its -1..+1 values to 0..1, then apply each curve. Zero input selects the midpoint **position**, not necessarily the arithmetic midpoint of the physical range. Exact voltage endpoints and knob travel need a live calibration check; the software does not assume a measured voltage span.

ADC processing and approximately 5 ms additional smoothing run at the 1 kHz callback rate. Parameter IDs are resolved at startup. At a gate edge, all eight values are applied before the RNBO hit message; a ringing hit retains its captured settings. Click level, resonator frequency, resonator Q, and Level remain at their exported defaults. No parameter changes allocate memory after startup in the host test.

`rnbo_cv_raw[8]` and `rnbo_cv_position[8]` are debugger-visible raw-driver and mapped-position readings. The existing driver's CV pin order is retained, including its reordered CV 5–8 pins. Test the physical labels against that order before changing firmware pin assignments.

The current image is `build/mlr_rnbo_kick_cv.bin`; `build/mlr_rnbo_kick_gate_only.bin` preserves the previous user-confirmed image. Rebuilding produces `build/mlr_rnbo_kick.bin`; the CV-named copy is a snapshot of this build.

## Export in Max

Open `rnbo_kick_export.maxpat`. This silent harness has no DAC and no MLR trigger receivers, so it can coexist with the running lab. Its RNBO core is embedded from the existing kick. It exposes the twelve unchanged parameters and a named `hit` message inlet.

The harness requests export after opening; the `bang` message retries. If automatic export does not work, double-click RNBO and use its C++ export sidebar:

- Output Directory: this folder's `generated` directory
- Export Name: `rnbo_source` (no extension)
- Minimal Export: enabled
- Copy C++ library code: enabled
- Class Name: `rnbomatic`
- Fixed Sample Rate: `48000`
- Fixed Vector Size: `48`

Expected files: `generated/rnbo_source.h` and `generated/common/RNBO_MinimalEngine.h` plus its sibling headers. Look for export success in the Max Console. Rebuild the harness after changing the kick with `node scripts/build_dpt_export_patch.js` from the MLR root. Close/reopen only this export patch when its embedded core changes.

## Build without flashing

From the MLR root:

```sh
python3 firmware/dpt/build.py --export-dir rnbo_kick --host-test
python3 firmware/dpt/build.py --check
python3 firmware/dpt/build.py
```

The import option accepts either `rnbo_source.h` or the RNBO-created `rnbo_source.cpp.h`; the supplied export remains untouched. `--host-test` compiles and executes the real exported DSP on the Mac.

Use `--oopsy-source /path/to/oopsy/source` on another workstation. The helper validates dependencies, creates local ignored symlinks, runs `make`, and records source hashes/compiler version in `build/build-inputs.json`. It never invokes `program` or DFU. Missing export files stop the build before compilation. Keep the project path free of spaces for the inherited Makefile.

Review the linker memory report and `build/mlr_rnbo_kick.map`. The inherited internal-flash layout allows 128 KiB flash and 512 KiB main SRAM. This target supplies a 32 KiB startup allocator and seals it before starting audio; allocation after startup traps with `rnbo_allocation_fault=true`. It does not reserve an RNBO SDRAM pool. The driver's hardware Init can still initialize SDRAM. Do not conclude that eight engines will fit from this one-engine target.

Inspect `rnbo_pool_used`, `rnbo_cpu_average`, `rnbo_cpu_peak`, `rnbo_hit_count`, and `rnbo_block_faults` with ST-Link once hardware testing is arranged. CPU values are fractions of a block deadline. Capture worst-case triggered load, not just idle. Do not flash over the current firmware until its restore image/build is identified.

## Next milestones

1. Completed: import the real minimal export, run the native smoke test, and compile/link this target.
2. Gate/audio playback confirmed by the user. Test the new eight-CV mapping and record hardware CPU peaks.
3. Add MIDI/control delivery, with parameter changes applied before triggers. Reuse the desktop parameter IDs and physical units.
4. Add the other voices progressively and measure worst-case simultaneous tails.
5. Evaluate codec mix and external DAC routing separately. The existing DAC7554 path and its throughput need measurement before assuming it supports four more full-rate audio outputs.

The Max V8 sequencer is not part of the firmware export. RNBO Minimal Export also does not export preset banks; DPT preset persistence will need an adapter using the existing parameter schema.

References: [Cycling ’74 Minimal Export](https://rnbo.cycling74.com/learn/minimal-export) and [official bare-metal example](https://github.com/Cycling74/rnbo.example.baremetal). The installed RNBO 1.4.5 exporter supplied the config field names used by `dpt_export.js`.
