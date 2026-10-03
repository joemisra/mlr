# Native sequence player prototype

This is an opt-in timing experiment. Ordinary Run still uses V8 playback.
`grid_router.js` can now hand explicitly selected deterministic drum groups to
an optional native bridge, after the complete cache is acknowledged. The full
sequencer contract has not been migrated and this is not enabled by default.

## Build and verify

The C++17 core tests require CMake and a compiler, without Max or its SDK:

```sh
cmake -S native -B native/build -DCMAKE_BUILD_TYPE=Release
cmake --build native/build
ctest --test-dir native/build --output-on-failure
```

To build the macOS external, obtain Cycling '74's official
[max-sdk-base](https://github.com/Cycling74/max-sdk-base) outside this repository
and configure `-DMAX_SDK_PATH=/absolute/path/to/max-sdk-base`. The initial build
used SDK commit `c03a2922a2a8ff149165a1e2ea134e9321d6e202`. The resulting universal
arm64/x86_64 `mlr.sequence_player.mxo` is placed in the repository root and
ad-hoc signed. The binary and build directory are ignored. This prototype is
not included in the release path; shipping and cross-platform packaging remain
separate work.

## Cache contract

`sequence64_native_compile.js` is preparation-only CommonJS code for Node/Max V8. `compile(snapshot,
{epoch, generation, groupIds})` returns an upload plan; it neither publishes to
Max nor starts playback. Selected groups are zero-based, explicit, and distinct.
The plan expands independent cycles to a common cycle of at most 512 native
subdivision pulses.

The prototype accepts deterministic 1× group patterns, explicit six-drum cuts,
slice locks, and instrument `set` locks. Every hit contains all 12 instrument
parameters, with unlocked values restored from its track baseline. It rejects
probability, conditions, track phrases, gates, parameter shapes, lock-only
steps, sample/melodic tracks, active legacy automation, modulation routes, and
cycles exceeding the fixed bound. Rejected input stays stopped; ordinary Run
continues to use the existing playback path.

The Max object takes control messages in its left inlet and native `bang`
pulses in its right inlet:

```text
begin  epoch generation length
event  epoch generation step group track slice p1 ... p12
commit epoch generation
abort
start epoch
stop
rewind
reset
cancel epoch group
resume epoch group
status
hello requestNonce
observe
cancelcurrent group
```

Steps are zero-based. Groups are 1–8; track input buses are 11–16; slices are
0–15. Its left outlet emits `[group track slice p1 ... p12]`. Its right outlet
reports status and the new epoch after reset. Invalid uploads abort staging;
duplicate hits for the same group/subdivision and nonfinite parameters fail.
`hello` reports the current epoch, request nonce and protocol version 1; a successful commit
reports its epoch/generation. `cancelcurrent` is the bridge's direct local
channel-cancel path. `observe` polls the most recent hit per group. A production
instance (`mlr.sequence_player production`) takes a process-wide singleton lease
to prevent two optional bridges from generating duplicate playback.

Three fixed banks separate preparation, publication, and playback. The producer
is serialized; playback consumes immutable banks through lock-free publication.
A complete commit replaces a pending publication, and the next native pulse
adopts it. A commit does not start transport. Replacement preserves subdivision
phase modulo the new length; `rewind` applies on the next pulse. The core pulse
path allocates no memory and takes no mutex. Synchronous downstream Max objects
still have their own timing and thread behavior.

`stop` silences output and freezes phase. `reset` also invalidates old epochs,
clears cancellation, and rewinds. Stale uploads and start commands are rejected.
Group cancellation survives cache replacement until explicit resume. Feedback
stop/reset/cancel is rechecked between simultaneous output frames. Reentrant or
concurrent pulses are dropped. Production clock, transport, session and ownership
integration enforces these boundaries for the explicit experiment below.

## Explicit MLR handoff

Build the external and reload MLR's edited audio bridge. Open **one**
`sequence64_native_bridge.maxpat` alongside MLR and the drum lab. Stop transport
and all patterns, select the Sequence64 layout, and ensure the selected groups
have explicit eligible drum cuts with empty sample slots. Send this to
`gridrouter` to start groups 1–6 from step zero:

```text
nativeSequence64Groups 1 2 3 4 5 6
```

The router preflights a frozen snapshot, requests the external's epoch, uploads
the full cache, and waits for a matching commit acknowledgement. Only then does
it clear pending legacy cuts, resume the selected native groups, rewind, and
start playback. A missing bridge times out after two seconds; stale/rejected
acknowledgements cannot start playback. Existing group running/display state
remains available, but V8 skips musical execution for those groups.

Native frames enter the existing `sequence64_audio_bridge.maxpat` action order:
instrument parameters → track/channel addressing → press → trigger → release.
Raw `[mlr]stop` and `sequence64_audio_cancel` reach the external directly without
waiting for V8. `nativeSequence64Stop` ends the experiment. A manual cut, edit,
live-record gesture, session restore, or optional-bridge close releases the
cache. Edits/manual cuts stop the experiment's groups; ordinary Run can then
play them through V8. Run/restart changes and transport pause release native
ownership to the ordinary path. Session restore stays stopped. Autowatch reload
silences/resets the external before the new V8 instance resumes ordinary logic.

The native pulse stores just one atomic latest-hit record per group. A 33 ms
low-priority poll supplies display-only telemetry, coalescing missed hits during
V8 stalls instead of queuing every hit. Observations carry their immutable cache
epoch; released/stale observations cannot change ownership. Grid/HUD rendering
is not required for subsequent native audio. Ownership, epochs, caches and
observations are transient and are not added to session documents.

Observation polling starts only after protocol-version acknowledgement. An older
loaded external fails the handoff with a restart notice instead of repeated
polling errors. If Max prints `rejected observe` from an older bridge patch, it
has an older external already loaded.
Rebuilding the file does not replace Max's loaded code: quit and relaunch Max
before reopening the optional bridge. Account for unsaved state first.

## Live Max probe

Open `sequence64_native_probe.maxpat` alone after building the external. It has
no audio output, input, RNBO voice, grid connection, or production MLR buses.
The all-ones parameter fixture is solely for click measurement and must not be
routed to instruments. On load it publishes six simultaneous hits every four
pulses and remains stopped. A 16 Hz `phasor~` rising edge supplies native pulses.
Six `click~` outputs record into a 10-second buffer.

With the patch focused and locked:

1. Press **d** to enable DSP, then **r** to record/run.
2. Press **a** to block V8 for 750 ms on each 1000 ms low-priority tick.
3. After at least 10 seconds, press **s** to stop playback, recording and stalls.
4. Press **w** to write `/tmp/mlr-native-probe.wav`.
5. Run `python3 scripts/analyze_native_probe.py /tmp/mlr-native-probe.wav`.

Close the probe before reopening production patches because its key controls
are global Max key listeners. The probe does not restore DSP automatically.

Live verification on October 2, 2026 used Max with CoreAudio at 48 kHz,
32-sample I/O and signal vectors, Overdrive on, and Scheduler in Audio Interrupt
on. The console confirmed repeated `stalled_ms 750` events. The 480,000-frame
capture contained 40 hits per channel, every interval was exactly 12,000 samples
(250 ms), and every onset matched across all six channels. The machine-local
WAV and analyzer report are retained under ignored `native/build/`.

This first capture demonstrates independence from low-priority V8 stalls for
the native trigger-to-click path.

## RNBO and complete-dispatch captures

`sequence64_native_rnbo_probe.maxpat` embeds the actual six RNBO voices with
shortened decay parameters and a seventh click-reference channel. The native
list adapter applies all parameters before triggering each voice. Rebuild it
with `node scripts/build_native_rnbo_probe.js` if voice sources change.

`sequence64_native_integration_probe.maxpat` additionally uses the actual router,
optional native bridge, and embedded production audio dispatch. Each voice uses
the labs' native step-cache/track-press path. Its isolated fixture loads through
the public session API and stays stopped until **r** requests the explicit
handoff. Rebuild it with `node scripts/build_native_integration_probe.js` after
rebuilding the RNBO probe or changing the audio dispatch.

Open either probe alone, never alongside MLR or a hardware-output drum lab.
They share MLR message buses and the integration fixture replaces the shared
Max runtime state. Both omit hardware audio outputs. Use **d**, **r**, **a**,
**s**, **w** as above. Files are `/tmp/mlr-native-rnbo-probe.wav` and
`/tmp/mlr-native-integration-probe.wav`. Analyze with:

```sh
python3 scripts/analyze_native_probe.py --rnbo /tmp/mlr-native-integration-probe.wav
```

On October 2, 2026 both 10-second captures contained ten reference hits spaced
exactly 48,000 samples apart at 48 kHz during repeated 750 ms V8 stalls. Each
voice crossed the fixed PCM onset threshold on the reference sample for every
hit (zero-sample offset), and all pre-hit windows were quiet. This verifies
the fixed short-tail fixtures through RNBO and the internal dispatch. It does
not establish timing for every preset/lock/phrase, production clock startup,
session dialogs, hardware audio or grid hardware. Machine-local WAVs/reports
are retained in ignored `native/build/`.

## Next migration boundary

Before making this the default, validate the opt-in path with the production
clock/grid, refine live-edit/phase-preserving cache replacement, and complete
cross-platform external packaging. Expand probability, conditions, phrase
scheduling, rates, shapes and scene changes with explicit native semantics and
tests before migrating their patterns. The current edit behavior deliberately
stops the experiment rather than attempt that replacement.
