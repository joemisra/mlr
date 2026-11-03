# HUD performance pass — October 4, 2026

This pass keeps the existing pages and controls. The proposed native Phase Cut
page is deferred until the existing HUD has been checked in Max.

## Changes

- Compare hover regions by stable IDs and rebind their payloads after painting.
  Rebuilding hit regions no longer causes another frame when the pointer stays
  inside the same control.
- Ignore unrelated playhead/rack events for drawing while retaining their state.
  A global plugin latency mismatch still refreshes the selected rack's warning.
- Batch non-overlapping grid rectangles by color and brightness; preserve all
  256 cell hit regions, pressed outlines, and ordinary 0–15 brightness.
- Draw each waveform channel in one path instead of stroking every bin.
- Cache graphics color, font and line width within a paint, resetting the cache
  at every new paint because Max owns the context between callbacks.
- Calculate overlapping gate tails in one traversal of the 64 pattern steps.
- Use already serialized JSON payloads directly as event signatures.
- Match focused MLR's active-track telemetry filtering to its Live display.

The existing 33 ms telemetry redraw coalescing remains. Direct clicks continue
to request immediate feedback. There are no changes to audio timing or sessions.

## Verification

The Node drawing harness compared the original and revised rendering primitives
at 480×320, 720×480, and 1100×700 across every existing HUD page. Geometry,
colors, text and font settings matched. These are primitive comparisons, not
raster screenshot comparisons.

At 720×480, with grid brightness cycling through all 16 values, a second color
on every fifth cell, and one pressed cell, Live changed from 269 fills / 270
strokes to 45 fills / 46 strokes. A stereo waveform with 256 bins per channel
changed from 514 strokes to 4; all waveform line primitives matched.

Tests cover hover stability after repaint, event filtering including the global
latency warning, batched grid/waveform geometry counts, overlapping gate tails,
all existing pages and sizes, and plugin/sample scrollbar interaction.
`npm test`: 462 passing. Both independent editions were rebuilt and their Max
JSON parsed. `git diff --check` passed.

These results measure graphics calls in a mock harness, not Max frame times,
CPU load, raster appearance, or audio underruns. Live Max testing remains:
play several groups while viewing Live and Strip, browse and drag both list
scrollbars, move between pages, resize, and watch selected ṛta playheads. Use
one edition per Max process and save current work before switching builds.

Trial projects:
- `release/hud-optimized/mlr-trial-v2/mlr.maxproj`
- `release/hud-optimized/rta-trial-v2/rta.maxproj`

The native effect experiment is parked in ignored
`release/phasecut/prototype/` and is not included in these projects.

References: [v8ui](https://docs.cycling74.com/reference/v8ui/) and
[MGraphics](https://docs.cycling74.com/apiref/js/mgraphics/).


## Waveform follow-up

The user exercised the optimized HUD in Max and reported that the existing
controls and layouts remained responsive and in place. Waveforms were absent
both before and after the optimization.

The adapter called `Buffer.samplerate()`, which is absent from Max's documented
JavaScript Buffer API. Its metadata exception path therefore published an
empty waveform before reading samples. The reader now uses `Buffer.length()`
and derives sample rate from frames and duration. The mock was corrected to
match that API. Preview-ready notifications also invalidate the private
preview buffer's cached waveform because replacement audio can have the same
ID, frame count, channel count and sample rate.

Regression checks cover actual nonzero waveform bins, duration/sample rate,
replacement audio at identical dimensions, and delivery to the selected
sample inspector. All 464 tests pass; both editions were rebuilt and Max
patch JSON validated. This waveform repair still needs a live Max check.

Updated projects: `release/hud-optimized/mlr-trial-v3/mlr.maxproj` and
`release/hud-optimized/rta-trial-v3/rta.maxproj`.


## Preview buffer namespace repair

The v3 build still reported an empty preview buffer. Inspecting the live Max
console showed `buffer~ mlr_sample_preview: already in use` at startup. The
preview's `receive` and `buffer~` shared that symbol. The audio buffer and
`play~` now use `mlr_sample_preview_audio`; the control bus remains
`mlr_sample_preview`. The waveform adapter reads the distinct audio name.
A topology regression checks that the buffer's name is not also used by a
message sender/receiver and that the adapter reads the matching name.

A silent native Max probe exercised the preview replace/ready/reader chain
using a generated mono WAV: 2400 frames, 48 kHz, 50 ms, and nonzero bins.
The actual HUD v8ui Samples inspector visibly rendered the waveform from
those bins. The temporary probe had private message buses and silent audio
sends; it was closed afterward. The user's active ṛta patch was not restarted
or closed. This verifies native loading, metadata, and waveform drawing;
it is not an audible audition or grid test.

All 465 tests pass. Both independent projects were rebuilt and Max patch
JSON validated. Latest builds: `release/hud-optimized/mlr-trial-v4/mlr.maxproj`
and `release/hud-optimized/rta-trial-v4/rta.maxproj`.

Cycling '74 also documents the buffer/message name constraint in its
[buffer tutorial](https://docs.cycling74.com/learn/articles/05_mspbasicchapter03/).

## Phase Cut continuation

After the user confirmed the optimized HUD and repaired waveform, the native
Phase Cut reader, per-group Mod shortcut, Phase page and session presets were
added. See [Phase Cut](phase-cut.md) for controls, fresh-build instructions and
the separate native signal checks. The earlier deferred prototype notes above
describe the HUD optimization checkpoint.

## Live follow-up — October 27, 2026

The first large-batch remote implementation exceeded Max's symbol limit;
Unicode-safe bounded fragments now cover that transfer (see `REMOTE-HUD.md`).
A separate cache-listing reply, `plug_au_blacklisted`, lacked a controller
handler. AU/VST3 blacklist replies are now consumed and excluded from the
chooser in either reply order; a fresh listing resets that bookkeeping.
All 479 automated tests pass, and both editions rebuild with valid patch JSON.

During a later physical-grid failure, a captured group-7 pattern contained
triggers at one-based steps 5, 22, 39 and 56. Router level caches matched matrix
foreground values; those four cells were lit in the matrix, frameBatchDepth was
zero and level frames continued. Display recovery preserved the pattern. The
user rebooted the grid and reported that it worked again. That supports a
stale device-side display diagnosis but does not establish its cause.

Audio stutter remained with the phone disconnected and improved but persisted
after the remote Node process was terminated. Max subsequently restarted that
service, invalidating that as a sustained server-off comparison. The optional
remote patch was then closed and port 7350 verified without a listener; the
playing edition was preserved. CoreAudio logs reported Max callback
overloads and client timeouts on ES-9/Push 3, with some callback durations around
25–34 ms. The active Max setup was ES-9 input/output at 44.1 kHz, I/O vector 512,
signal vector 32, Overdrive and Scheduler in Audio Interrupt enabled, around
34% reported DSP utilization, and all eight Phase Cut engines disabled. Logs
also identified the CNTRLR editor as another active audio client. These are
observations, not proof of a driver, sample-rate, or other-client root cause.
No audio device, buffer or scheduler settings were changed for these checks.
Diagnostic probe windows were closed afterward; playback was preserved.

### ES-9 USB failure identified

Further timestamp analysis showed that the earlier overload reports were
clustered at 18:58:04–18:58:08 America/Chicago, rather than continuing throughout
the later listening test. A fresh 90-second overload query returned no records.
They therefore do not by themselves explain the ongoing audible fault.

The more specific driver trace at 19:05:43.685 shows ES-9
`AUAInputTransferManager_completeBlock` returning transaction status
`0xe00002ed`. Apple's installed IOKit `IOReturn.h` defines this as
`kIOReturnNotResponding` (device not responding). The next driver message
requests an audio-device configuration change. CoreAudio stops Max's ES-9 I/O,
the driver deinitializes both input and output transfer managers, and then
recreates them and resumes I/O. Another identical input-transfer error follows
at 19:05:44.502. A three-minute query contained 82 Max PauseIO/ResumeIO pairs.
These events occurred with the optional remote HUD patch closed.

The USB registry places ES-9 and the grid beneath the TS4 USB2.0 hub branch;
Push 3 is on the other USB host-controller tree. This identifies a common path
worth isolating, not proof that the dock or cable is defective. A subsequent
45-second USB-error query was empty, so the failure was intermittent. The next
controlled hardware test is to connect ES-9 directly to the Mac with a known-good
cable, preserving the Max session and checking the same driver error query.
No physical USB or audio configuration changes were made by the agent.

Local diagnostic evidence (temporary files):
- `/tmp/mlr-usb-reconfigure-detail.log`: input-transfer error and stream rebuild.
- `/tmp/mlr-audio-restart-detail.log`: corresponding Max ES-9 I/O stop/start.
- `/tmp/mlr-audio-device-changes.log`: repeated device I/O transitions.
- `/tmp/mlr-investigate-max.sample.txt` and
  `/tmp/mlr-investigate-cntrlr.sample.txt`: contemporaneous stack samples.
