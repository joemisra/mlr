# Eight-engine RNBO / DPT bank

**The eight-engine SRAM target builds successfully.** The real minimal export is imported from `rnbo_bank`; the full exported DSP passes native audio/MIDI tests. The corrected bank is installed and verified through ST-Link, boots through v6.4, and runs at roughly 75% observed CPU. Audible playback, MIDI wiring and worst-case load still need live confirmation. The working kick/CV firmware is separate in the parent directory. No firmware is flashed by these tools.

**Do not flash this image at 0x08000000 using the old kick procedure.** It is a bootloader application linked to run at 0x24000000 in SRAM. It requires a compatible Daisy bootloader, with the application stored in external QSPI flash. Confirm/back up the currently installed firmware and choose a DPT/Patch SM-compatible bootloader before installation. The existing Oopsy bundle contains an older v4 bootloader, whose compatibility has not been verified here; do not assume that binary is the correct installer.

## Measured build result (September 30, 2026)

- Initial size-oriented internal-flash build: 186,588 bytes, exceeding 128 KiB.
- LTO/no-RTTI build: approximately 157.8 KB, still too large for internal flash.
- Successful SRAM bootloader image: `build/sram/mlr_rnbo_bank_sram.bin`, 157,420 bytes.
- AXI SRAM: 288,496 / 524,288 bytes (55.03%), including code and the 128 KiB RNBO arena.
- DTCM: 106,180 / 131,072 bytes (81.01%); DMA RAM: 17,160 / 32,768 bytes.
- No SDRAM allocation. Host RNBO startup allocation is 47,904 bytes, with no allocations during the tested MIDI/control/audio run. This is a host measurement, not a measured MCU allocation count.

The local SRAM linker layout is derived from the bundled libDaisy layout. `rnbo_arena.ld` moves only the RNBO arena into AXI SRAM so it does not exhaust DTCM. `BOOT_APP` preserves bootloader startup initialization. The original hardware-driver/library files are not edited. LTO and size optimization trade performance for footprint; measure simultaneous long tails on hardware before assuming real-time headroom.

[Official Daisy bootloader overview](https://github.com/electro-smith/DaisyBootloader) and [installation/memory-layout documentation](https://github.com/electro-smith/libDaisy/blob/master/doc/md/_a7_Getting-Started-Daisy-Bootloader.md) describe QSPI storage and SRAM execution. These establish the platform route, not verification of the installed DPT bootloader.

## Required Max export

Open/reopen `rnbo_bank_export.maxpat` (the generated file now contains the complete bank). It embeds the unchanged eight RNBO cores, with unique parameter IDs and eight mono outputs. This is a silent export harness with no DAC, MIDI output or MLR trigger subscriptions. Its automatic export may need the same manual sidebar step used for the kick.

Use C++ Source Code, **Minimal Export**, **Copy C++ library code**, class `rnbomatic`, fixed sample rate **48000**, fixed vector size **48**, export name **rnbo_source** without an extension. Choose a fresh output directory, such as `rnbo_bank` in the project root. Do not overwrite the working kick export.

From the MLR root:

```sh
python3 firmware/dpt/bank/build.py --midi-test
python3 firmware/dpt/bank/build.py --export-dir rnbo_bank --host-test
python3 firmware/dpt/bank/build.py --memory sram
```

The importer accepts `rnbo_source.h` or `rnbo_source.cpp.h`, verifies all eight hit ports, and reuses the parent's DPT/libDaisy dependencies. `--memory flash` retains the original 128 KiB internal-flash layout for size checks and currently overflows; `--memory sram` selects the working bootloader layout with a separate build directory. The commands never install a bootloader or program hardware.

`noise_compat.py` applies a checked portability adaptation to five noise generators and the clap scatter generator. Their 31-bit Park–Miller state cannot be represented exactly as float32. The adapter stores that state as uint32 and uses the exact Schrage update (no 64-bit division), preserving the original integer sequence. The untouched exported header is retained as `generated/rnbo_source.original.h`, and build-input hashes capture both forms. Changed/unrecognized generated patterns fail rather than receiving a guessed replacement. The host test compares 300,000 updates against the original integer recurrence, resolves all 96 parameters/eight hit ports, checks output isolation and finite simultaneous audio, and exercises MIDI control with the allocation arena sealed.

Regenerate the export harness, mapping manifest and C++ parameter table from the desktop engines using `node scripts/build_dpt_bank.js`. Close/reopen only the export harness after regeneration; export again. `midi-map.json` records physical units, default values, CC numbers and mapping curves.

## MIDI protocol

Accepts the existing **UART MIDI input** and **USB MIDI on the Daisy module’s built-in USB connector**. Channels are human-numbered:

| Channel | Engine |
| --- | --- |
| 1 | Kick |
| 2 | Snare |
| 3 | Hat |
| 4 | Clap |
| 5 | Tom |
| 6 | Rim |
| 7 | Bell |
| 8 | FM Bass |

Any nonzero-velocity Note On triggers the assigned voice. For percussion, pitch stays at its parameter value. For Bass, the MIDI note selects pitch, clamped to the existing 12–96 range. Velocity multiplies the engine's Level **for that hit only**. Note Off and zero-velocity Note On leave tails alone. Each engine remains monophonic; a new hit replaces its previous hit. Messages on channels 9–16 are ignored.

CC 20–31 set that channel's twelve controls in the desktop schema/packet order, using default lab grid ranges and curves. These CC values are persistent baselines, not automatically reverting locks. Drum Lab's native DPT adapter sends resolved physical snapshots for each trigger, including lock and baseline restoration. Select DPT USB MIDI to enable that route; Local RNBO remains the startup default.

Foreground code parses UART MIDI and pushes accepted events through a bounded single-producer/single-consumer queue. The audio callback applies CCs and per-hit values before triggering RNBO. Events are quantized to the 48-sample block boundary; multiple hits on the same voice within a block collapse to its last trigger/settings. Queue overflow drops newest messages and increments `rnbo_midi_dropped`; sustained overload needs a sender-rate budget. The callback drains at most 32 events per block.

Gate 1 still triggers the kick using the existing eight-CV map. CV values are sampled/smoothed continuously, but affect gate-triggered hits only. MIDI kick hits apply all twelve MIDI baselines, so preceding CV hits cannot latch CV settings into subsequent MIDI hits. If a gate and MIDI kick arrive in the same callback, the gate hit wins. Gate 2 triggers the snare at full velocity using its current channel-2 MIDI parameter baselines (exported defaults until CCs arrive). Gate release leaves its tail alone. Both gates can fire together. A gate-2 edge takes precedence over a MIDI snare hit in the same callback.

All eight voices are mixed to codec outputs 1/2 at 0.25 per-voice gain, with a final hard safety clamp. Output is dual mono. External DAC audio and per-voice physical outputs are not part of this target. CPU diagnostics (`rnbo_cpu_average`, `rnbo_cpu_peak`), queue drops, block faults and per-voice hit counters are exposed for ST-Link measurement. Test all voices simultaneously with long tails before deciding hardware headroom is adequate.

The existing DPT driver's startup gate blink remains: use the same bring-up precautions as the kick target. The user has confirmed the parent eight-CV kick image works on hardware.

## CC order by voice

**kick (channel 1)**: 20 Pitch; 21 Decay; 22 FM; 23 Sweep; 24 Sweep decay; 25 FM ratio; 26 Click; 27 Drive; 28 Res mix; 29 Res frequency; 30 Res Q; 31 Level.

**snare (channel 2)**: 20 Body pitch; 21 Body decay; 22 Body FM; 23 Body bend; 24 Noise decay; 25 Noise frequency; 26 Snap; 27 Drive; 28 Body level; 29 Noise level; 30 Noise Q; 31 Level.

**hat (channel 3)**: 20 Metal pitch; 21 Metal decay; 22 Spread; 23 Inharmonicity; 24 Noise decay; 25 Filter frequency; 26 Attack; 27 Drive; 28 Metal level; 29 Noise level; 30 Filter Q; 31 Level.

**clap (channel 4)**: 20 Burst count; 21 Burst decay; 22 Burst spacing; 23 Timing scatter; 24 Tail decay; 25 Filter frequency; 26 Brightness; 27 Drive; 28 Burst / tail balance; 29 Tail level; 30 Filter Q; 31 Level.

**tom (channel 5)**: 20 Pitch; 21 Decay; 22 Pitch bend; 23 Bend decay; 24 FM amount; 25 FM ratio; 26 Shell ratio; 27 Shell level; 28 Noise level; 29 Noise decay; 30 Drive; 31 Level.

**rim (channel 6)**: 20 Pitch; 21 Decay; 22 Shell ratio; 23 Shell level; 24 Click level; 25 Strike decay; 26 Strike filter; 27 Strike Q; 28 FM amount; 29 FM ratio; 30 Drive; 31 Level.

**bell (channel 7)**: 20 Pitch; 21 Decay; 22 FM ratio; 23 FM index; 24 FM decay; 25 Inharmonicity; 26 Mode level; 27 Mode decay; 28 Strike; 29 Brightness; 30 Drive; 31 Level.

**bass (channel 8)**: 20 Note; 21 Decay; 22 FM index; 23 FM ratio; 24 FM decay; 25 Feedback; 26 Sub level; 27 Brightness; 28 Attack; 29 Pitch bend; 30 Drive; 31 Level.


## Hardware upload (September 30, 2026)

The connected board already contained the official v6.4 intdfu-2000ms bootloader, verified against its full binary. Internal flash was backed up under ignored `build/bootloader-backup/`. The 157,420-byte SRAM bank was downloaded at `0x90040000`; DFU reported success. QSPI readback did not match and cannot verify the image: upstream `shared/dfu.cpp` has invalid read-address/return-pointer handling. QSPI upload files in the backup directory must not be used for restoration. Playback and runtime compatibility remain untested. Press RESET without BOOT and wait for the grace period to end, then test Gate 1 kick and Gate 2 snare.

## Startup correction and MIDI activity output

The v6.4 bootloader resets the MCU before entering the SRAM application. The
older Oopsy DPT driver skipped clock initialization for SRAM, assuming the
pre-v6 bootloader had already configured clocks. `build.py` now creates a
checked local copy of that driver with clock/MPU initialization enabled. The
shared Oopsy driver is untouched. This bank now targets the v6 bootloader.

The corrected image reached startup stage 8 and processed thousands of audio
blocks when loaded into RAM with ST-Link. The measured MCU arena use was 47,904
bytes, with no allocation fault or processor fault. This establishes startup
and callback activity, not audible playback or full-load real-time performance.

Gate Out 1 emits a 10 ms pulse on received UART MIDI Note On with nonzero
velocity, on any channel (including channels not assigned to engines). Closely
spaced notes extend the pulse. Note Off and zero-velocity Note On do not pulse.
This diagnostic is serviced in the foreground; it indicates parsed MIDI
reception, not sample-accurate trigger timing. The hardware driver's existing
startup gate blinks still occur before normal operation.

Debugger counters include `rnbo_startup_stage` (8 = audio started, 0xE1 = export
validation failure), `rnbo_audio_blocks`, `rnbo_midi_notes_received`,
`rnbo_hits`, `rnbo_cpu_average`, `rnbo_cpu_peak`, and allocation/block/queue faults.

The initial size-optimized build measured above 100% callback CPU on the MCU.
The bank now builds with `-O3 -fsingle-precision-constant`: decimal literals in
RNBO otherwise promote float32 expressions to double-precision transcendental
functions. The resulting 265,164-byte image measured about 75% average and 78%
peak in the observed run. This is not an exhaustive worst-case MIDI/parameter
stress test. The corrected clock setup, speed optimization, and literal precision
are all required for the current eight-voice target.

The corrected bank was permanently installed through a RAM-resident QSPI helper
loaded with ST-Link. The helper reported zero byte mismatches; a separate SWD
readback of all 265,164 bytes matched SHA-256
`66c9402dd0ec385e7da24ab9c8b2208291510d230f7dc5188d19dc00f7db32e2`.
After reset through the existing bootloader, startup reached stage 8, audio blocks
advanced, CPU averaged about 75%, and fault registers were clear. The old QSPI
application area was backed up as `build/bootloader-backup/qspi-before-stlink-valid.bin`.
Unlike the earlier USB uploads, this SWD backup is valid. Installer sources and
payload are retained in ignored `build/flash_helper.cpp`, `build/flash_helper.mk`,
and `build/bank_payload.h`; the helper must only be loaded into RAM, not flashed
as the application. USB updater enumeration remains unresolved.

The user confirmed hardware MIDI reception with the Mac sending through the ES-9 MIDI jack. Bank mix gain was raised from 0.125 to 0.25 per voice (+6.02 dB); per-voice Level controls remain available and the final output clamp remains in place. Dense simultaneous hits can reach that clamp sooner.

The +6 dB gain revision was also installed through ST-Link and independently read back byte-for-byte; SHA-256 `baa3d59bb8a88f46a6f09e7881f1a7c91b6cc1e78a6d46a331e2e89c5f76ef63`.

## Bell/Bass load correction

Live playback on all eight channels exposed callback peaks above 100%, while
the application MIDI queue reported zero drops. `math_compat.py` now caches
unchanged exponential/filter coefficients and drive normalization per exported
call site. It recomputes the original float math whenever the argument changes;
it does not approximate the equations or shorten tails. Bass's two integer-base
`pow(2, ...)` calls now use a float base so RNBO selects `powf` rather than double
`pow`. The adapter is applied to the retained original export after noise repair.

The audio queue now admits only nonzero Note On on channels 1–8 and mapped CC
20–31; ignored MIDI events are counted before queueing. Gate Out 1 still reports
nonzero Note On reception on any channel. Added `rnbo_audio_overruns` counts
callbacks longer than the 1 ms budget, and `rnbo_midi_ignored` counts events
excluded from the audio queue. These do not measure losses upstream of the
application queue.

The eight-voice host smoke and MIDI/FIFO tests pass. In the observed Live run,
all eight hit counters advanced, callback peak was about 89%, and both audio
overruns and application MIDI queue drops were zero. The user confirmed that
channels 7–8 now play smoothly with the other voices. This is a tested pattern,
not a guarantee for every extreme parameter combination.

The 259,280-byte optimized bank was installed persistently and read back through ST-Link with an exact match; SHA-256 `5ff84b81eb81bc94f08663b4c141dc4976a7eb84e7a5afc95a13efc6826b8df3`.

## Drum Lab / ṛta USB control

Open `rnbo_drum_lab.maxpat`, refresh its MIDI ports, select the Daisy MIDI
output, then choose **DPT USB MIDI** above the voice tabs. Local RNBO is the
safe startup default and the MIDI port starts at `none`. DPT mode mutes the
local drum sends; monitor the DPT audio outputs separately. Existing lab knobs,
preset buttons, grid edits and resolved per-step snapshots feed the same voices
on the DPT. Selecting DPT mode or changing MIDI ports synchronizes current lab
values. MIDI input on the DPT is not an audio interface.

Native Max patchers (`dpt_*_midi` and `dpt_pack21`) encode 21-bit normalized
values over each parameter's internal physical min/max, so expanded grid ranges
are retained. The sequenced hit path contains no JavaScript or deferred queue.
Manual edits and sync set hardware baselines; a full hit snapshot is applied
without changing those baselines. Thus step locks do not latch into subsequent
unlocked hits. Bass snapshot pitch is supplied as a parameter, not overwritten
by an arbitrary trigger note. Ordinary channel 1–8 Note On and CC20–31 continue
to work from Live over either transport.

SysEx wire format: `F0 7D 4D 4C 52 01 command voice payload F7`.
Voice is 0–7. Command 1 has parameter index (0–11), then three 7-bit bytes
MSB first; command 2 has twelve such values and triggers; command 3 has twelve
values and updates baselines without triggering. Values map linearly over the
internal ranges using `n / 2097151`. Packets with wrong lengths, version,
identifiers, channel or non-data bytes are rejected. Protocol decoder and
baseline/non-latching behavior are covered by native MIDI tests. USB event and
invalid-packet counters are exposed as `rnbo_usb_events` / `rnbo_usb_invalid`.

The bundled old USB transport had a multi-packet receive bug (`buffer` reused instead of `buffer + i`). The bank builds a checked local `generated/usb_midi_bank.cpp` correction; shared libDaisy sources are unchanged. The expanded audio event queue lives in AXI SRAM and its indices are initialized explicitly before use.

USB-capable bank installed and verified byte-for-byte (271,984 bytes). Project tests: 382/382; native MIDI/SysEx tests pass. Live USB/Max validation remains pending: macOS does not currently enumerate a Daisy MIDI destination, and Max window control is blocked by macOS accessibility permissions. Reconnect the module USB and reopen Drum Lab to complete the live check.

USB live verification completed after reconnecting the cable and rebooting:
macOS exposes **Daisy Seed Built In**. Sending two ordinary notes (Bell/Bass)
and eight complete lab hit snapshots over USB incremented every voice hit
counter exactly as expected (1 each, 2 for Bell/Bass), added ten USB events,
and caused no application queue drops or additional rejected packets. This
also exercises multiple USB-MIDI packets in a single transfer. The latest
272,072-byte image is installed and independently read back byte-for-byte.
USB initialization now waits for VBUS in the foreground, allowing audio and
UART to start without a connected host. Cable-absent/cold-power behavior still
needs a physical unplug test. The Max UI still needs a live reopen/edit test;
automated patch topology tests are not a substitute for that check.

### Eight channel performance knobs

The eight panel controls now follow MIDI channel order: Kick, Snare, Hat, Clap,
Tom, Rim, Bell, Bass. Their bipolar ADC readings (including any CV contribution)
are mapped to 0–1. The first 75% of travel fades the channel from silence to
unity with a squared level curve. Above 75%, level stays at unity and a
post-engine soft saturator rises from 1x to 4x drive. Controls are smoothed over
approximately 50 ms and affect ringing tails. Engine drive, preset level,
velocity and per-step locks remain intact underneath this performance stage.
At 75% the stage is transparent. Fully counterclockwise mutes that channel.

This replaces the previous Gate 1-only kick CV parameter assignments. Both gate
inputs now trigger their respective voice baselines, just like full-velocity
MIDI hits (Gate 1 kick, Gate 2 snare). USB and DIN routing are unchanged.
