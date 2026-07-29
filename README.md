# mlr

A live sample-cutting platform for the Monome Grid 256, running in Max 8 with serialosc.

Originally by Brian Crabtree (monome.org, 2006), with major modifications by Joseph Melnyk
(8 channels, 4 pattern recorders, mod page, session slots, input buffers, and more — see
`mlr_info.txt` for full changelog). Updated for serialosc + Max 8 compatibility.

Licensed under GPL v2 (see `license_mlr.txt`).

## Quick Start

1. Open `_mlr.maxpat` in Max 8
2. Connect your Monome Grid 256 via serialosc
3. Drop audio files onto the file drop area
4. Assign files to rows, push up group volume + master volume, turn on DAC
5. Press keys on the grid to cut and remix

For full operation details, see `mlr_info.txt` (opens from within the patch via the info button).
The new lower-half sequencer is documented in `sequence64_editor_reference.md`.
A printable visual cheat sheet is available as
[`docs/mlr-grid-reference.svg`](docs/mlr-grid-reference.svg), with a PNG copy
for quick viewing.

## Developer Tooling

### MechaTrellis color and 8-bit LED helpers

`grid_router.js` exposes private MechaTrellis LED commands through the existing
`gridrouter` message bus. Persistent color helpers do not change a cell's
legacy brightness or state, so the existing mlr drawing and animation paths
continue to use their standard 0–15 levels.

Private commands are blocked by default. Enable them only for MechaTrellis:

```text
mechatrellis 1
```

Send these messages to `s gridrouter` (or directly to `grid_router_io`):

```text
colorCell x y r g b
colorMap x y r0 g0 b0 ... r15 g15 b15
colorAll r g b
colorRow y r g b
colorCol x r g b
colorRect x0 y0 x1 y1 r g b
applyPageColors [page]
storeColorPreset slot
recallColorPreset slot
initializePageColorPresets
autoPageColors 0|1
```

`colorMap` assigns a row-major 4×4 block while leaving all legacy LED levels
unchanged. Enabling MechaTrellis mode uploads automatic starter palettes for
kmod pages 1–4, using 16 maps per 16×16 palette, and stores them in firmware
slots 0–3. Later page changes send a single preset-recall packet. Their RGB
values live in `PAGE_COLORS` and `GROUP_COLORS` near the top of
`grid_router.js`.

Send `autoPageColors 0` to keep manual colors across page changes, or
`applyPageColors 1` through `applyPageColors 4` to rebuild and store one page.
Because firmware slots live in RAM, send `initializePageColorPresets` after a
MechaTrellis reset that occurs while mlr remains open. Maps are lightly paced
so they do not crowd legacy LED frames out of serialosc's nonblocking serial
connection.

The remaining private commands are also available when direct 8-bit control is
needed:

```text
rgbCell x y r g b
rgbAll r g b
level8Cell x y level
level8All level
intensity8 level
```

Unlike `colorCell` and `colorAll`, the RGB and level8 commands intentionally
change LED output state. Values are clamped to 0–255 by both mlr and serialosc.

### Mode 2: 16×16 target chooser and 64-step editor

Grid positions below are one-based. The top grid row is row 1. This workspace is
opt-in: until a target is selected, the existing main and mode-2 controls behave
exactly as before.

On a 16×16 grid, hold mode-2 row 1 column 14 to open the target chooser:

- Row 1, columns 1–8 select groups 1–8.
- Column 16, rows 2–16 select tracks 1–15.
- The chooser owns those cells only while column 14 is held, so target selection
  cannot mute a group or toggle a track's reverse state.
- Keep holding column 14 to change targets quickly. Selecting the current target
  cancels it; releasing column 14 always hides the chooser.
- A selection is silent and persists when switching between mode 2 and the main
  page. Press row 16 column 16 in the editor to exit completely.

The lower half has two views. Row 16 column 1 selects **Sequence**, column 2
selects **Setup**, and column 16 exits.

#### Sequence view

| Grid cells | Function |
|------------|----------|
| Rows 9–12 | Viewed bar: steps 1–16, 17–32, 33–48, and 49–64 |
| Row 13, columns 1–4 | Hold to set viewed-bar length to 16 / 32 / 48 / 64 |
| Row 13, columns 5–12 | Tap to select/add a bar; hold bar N to set the pattern to N active bars |
| Row 13, columns 13–14 | Previous / next bar |
| Row 13, column 15 | Add and select a bar, up to eight |
| Row 13, column 16 | Remove the viewed bar; press twice within 1.2 seconds |
| Row 14, column 1 | Run/Stop; Run is explicitly started but remains latched after editor exit |
| Row 14, column 2 | Tap to latch/unlatch parameter-lock recording |
| Row 14, column 16 | Clear the viewed bar; press twice within 1.2 seconds |
| Row 15 | Playable 16-slice lane for the selected/current track; the bright cell follows live position |

The row-15 lane uses the same ordinary MLR input path as the front page. Tap
row 14 column 2 to latch Record, then play the lane to write each cut into the
Sequence64 step currently under the playhead. Tap Record again to stop. For a
group target, the cut stores the exact active track as well as the slice.

The Sequence clock receives one phase-locked `sequence64_pulse` per step from
`time.maxpat`. It uses `rate~ 0.125` and both ramp edges to produce 16 steps per
quarter note (64 per 4/4 bar). This is 16 times the quarter-note `tr_pulse`;
JavaScript no longer schedules or catches up intermediate steps. Its four
16-step parts are already visible together on rows 9–12; those rows are four
quarters of one bar, not four independent pattern passes.

Every target starts with one 64-step bar. Up to eight bars can be added and they
play consecutively before looping back to bar 1. The selected bar button is
bright; while Run is active, a different playing bar is shown at an intermediate
level. Tap an existing bar to view it, or tap the first inactive bar to add it.
Hold any of the eight buttons for about 350 ms to set the total active length to
that many bars. Shortening parks trailing bars instead of erasing them, so
holding a longer length later restores their data. Changing the viewed bar does
not interrupt playback. Changing the bar count stops that target's Run so that
a structural edit cannot move the transport unexpectedly. Existing single-bar
patterns remain bar 1.

Tap and release a step to add or remove its cut trigger. Hold a step for about
350 ms to open its lock editor; the editor stays open after release. Click the
selected step again to close it, or click another active step to edit that one.
The live track-position lane yields to these popup controls while the editor is
open. A slice choice is stored as a lock over the recorded/default cut slice;
clearing that lock reveals the original slice again.
The controls are centered on rows 13–15:

| Lock row | Columns |
|----------|---------|
| Row 13 | 5 slice, 6 probability, 7 volume, 8 future filter, 9 reverse, 10 octave, 11 loop division, 12 gate length |
| Row 14 | Value; slice/probability/volume/filter use columns 1–16, octave uses 1–7, division uses 1–8, and gate length uses 1–16 |
| Row 15 | For volume/filter: 6 Set, 7 Glide, 8 Pluck, 9 Swell, 10 Gate, 11 Pulse; column 16 clears the selected lock |

Turning off a cyan/green trigger preserves its parameter locks. A resulting
amber cell is a valid triggerless lock, not a stale LED; a step with neither a
trigger nor locks returns to the neutral color.

Trigger cuts and Set locks are latched. Exiting the editor also leaves Run
latched; all running track and group targets continue on the shared clock and
can run concurrently. Stopping a target prevents its new events and releases
its active Gate shapes, but it deliberately does not move a
loop back or restore a persistent parameter. Pluck, Swell, and Pulse tails can
continue after the step or after Stop. A newer event on the same target and
parameter replaces the older shape. `Restore Start State` is the explicit way
to return to the values and playback position captured at Run. Reloading the
JavaScript or disabling/changing the editor layout stops all Sequence64 targets
as a safety boundary.

Volume locks use the existing per-channel `[gatefx]level` multiplier, leaving
the normal channel-volume control intact. Filter locks already emit the parallel
`N[filterfx]level value ramp-ms` bus and preserve their data, but are silent until
the planned filter DSP stage is added.

#### Live recording and Setup

With a target selected, return to the main page and hold row 1 column 14 while
performing cuts. The first accepted, quantized `chRowPos` starts a take;
releasing column 14 ends it. The elapsed time is rounded to the nearest 16-step
beat, with a one-beat minimum. mlr automatically creates full 64-step bars plus
a 16/32/48/64-step final bar, up to eight bars. For example, a six-beat take
becomes one 64-step bar followed by a 32-step bar.

The finalized take replaces the target's previous cut triggers while preserving
probability, parameter locks, and gate length at newly recorded positions. A
recorded slice replaces an older slice edit at that position. The take remains
aligned to the global sequence clock, and Run remains explicitly opt-in. A
track target accepts only that track; a group target accepts tracks assigned to
that group and stores the exact played track/slice. A cut sent while record was
held may still commit after release when its quantized position arrives. If no
matching cut arrives during the gesture, the saved pattern is unchanged.

The Setup view consolidates direct controls:

| Row | Function |
|-----|----------|
| 9 | Group assignment/indicator |
| 10 | Channel volume |
| 11 | Track octave −3 through +3 |
| 12 | Columns 1/2 reverse/random offset; columns 3–10 loop division 1/4 through 1/48 |
| 13 | Loop start |
| 14 | Loop end |
| 15 | Columns 1–4 loop on/off, channel latch, timestretch, mute; column 5 Clear Motion; column 6 Restore Start State |

Tap Sequence row 14 column 2 to latch Record, switch to Setup, and move a
supported control to write a Set lock at the current step. While recording, the
volume row previews and records the modulation multiplier instead of moving the
base channel fader; with Record off it remains the ordinary channel-volume
control. Return to Sequence and tap Record again to stop. A group target follows
its current active track for manually entered steps; a live-recorded group cut
stores the exact track played.

The renderer uses non-clearing `beginupdate` transactions for cell diffs. The
feature is unavailable on 8×8 and 16×8 grids. Send `extendedEditors 0|1` to
disable/enable it. `clearEditorTargetData` resets the selected target and
`clearEditorAllData` resets all targets. `editorLayout legacy` temporarily
restores the saved six-page prototype; `editorLayout sequence64` returns to the
new default. Legacy 16-step data is copied once into the first 16 new steps and
is never deleted by migration.

MechaTrellis private OSC is disabled by default. Send `mechatrellis 1` to
`s gridrouter` only when a MechaTrellis is connected; send `mechatrellis 0`
before switching back to a normal monome. The final OSC bridge blocks every
private color, RGB, 8-bit, and preset command while this hardware mode is off,
but standard 0–15 levels continue normally.

Semantic MechaTrellis editor color is enabled with hardware mode. It can also
be changed with `editorColors 0|1`; the older `editorBrightnessColors` name
remains an alias. Brightness still communicates state through the standard
0–15 levels, while hue communicates function:

| Color family | Editor meaning |
|--------------|----------------|
| Cyan / green / amber / magenta | Trigger / gated trigger / lock / trigger+lock |
| Blue-violet / white / lime / orange | Gate tail / sequence playhead / track position / held step |
| Green / pink / red | Run or Add / Record / destructive action or Exit |
| Blue / amber | Sequence and bar navigation / Setup |

Lock parameters and predefined shapes each have stable colors. Setup uses group
colors plus dedicated families for volume, octave, reverse, randomization,
division, loop bounds, latch, timestretch, and mute. Full editor palettes use
4×4 maps; subsequent state and color-only changes use single-cell diffs. This
keeps one-cell playheads and navigation feedback responsive without repainting
a tile. Standard levels remain authoritative, so monochrome Grid Zero behavior
is identical. The option defaults off to avoid private OSC traffic on non-color
hardware.

### Mode 2: Sequence64 Run controls and columns 10–12

Mode-2 row 5, columns 1–8 toggle Run/Stop for group patterns 1–8. These
buttons replace the older channel short-loop latch row.

| Column | Rows | Function |
|--------|------|----------|
| 10 | 2 play/stop; 3 loop; 4–7 length 1/2/4/8 bars; 8 arm/stop record | Clocked grid-button automation |
| 11 | 2–6 = 1/32, 1/16, 1/8, 1/4, 1/2 | Global input quantize |
| 12 | 2 onward, one row per track | Toggle Run/Stop for that track's Sequence64 pattern |

Short-loop range, division, and channel latch remain together in the Sequence64
Setup view. Triggering a track on a latched channel still reapplies its selected
short loop at the new playback position.

To test automation, remain on mode 2: select a short length, press column 10
row 8 to arm, then press a non-automation control such as mute or random
offset. The first such press starts recording. Press the arm pad again to stop
early, or let the selected length expire. With loop off, press column 10 row 2
to play the capture once. Automation currently records press-down events and
stores grid coordinates rather than page identity, so changing pages during
recording or playback is not supported.

### Compact `.maxpat` Analysis

Use the local analyzer to strip UI/layout noise and summarize object topology:

```bash
python3 scripts/analyze_maxpat.py grid_router_io.maxpat --no-comments --depth 1
python3 scripts/analyze_maxpat.py _mlr.maxpat --no-comments --sends-only
```

This is useful when reviewing large patches with an LLM because it preserves:

- objects and connections
- subpatcher hierarchy
- send/receive topology
- bpatcher and JS/V8 references

### Codex MCP Server

This repo includes a local stdio MCP server for Codex:

```bash
python3 scripts/maxpat_mcp_server.py
```

It exposes static patch-analysis tools:

- `list_maxpat_files`
- `analyze_maxpat`
- `analyze_maxpat_batch`
- `max_bridge_status`

It also adapts the existing Max Socket.IO bridge on `127.0.0.1:5002` into live MCP tools for:

- patch object/patch-cord inspection
- selection inspection and expansion
- object attribute reads
- object creation, connection, and message/attribute edits

Requirements:

- `python-socketio` installed in the Python interpreter used to launch the server
- Max running with `_mlr.maxpat` open and the `MaxMSP_Agent` bridge active

Optional docs support:

- if `/Users/jm/Projects/MaxMSP-MCP-Server/docs.json` is present, the server also exposes `list_all_objects` and `get_object_doc`

## File Reference

### Main Patch

| File | Purpose |
|------|---------|
| `_mlr.maxpat` | Main application — open this in Max 8 |

### Audio Engine Patches

| File | Purpose |
|------|---------|
| `pl.maxpat` | Playback engine — `groove~` with tempo sync, fade, position control. One instance per channel row. |
| `output.maxpat` | Per-channel output routing — volume, mute, metering. Routes to main out (dac 1-2) and monitor (dac 3-4). |
| `mon.maxpat` | Monitor output bus — receives `mon1`/`mon2` signals, applies gain, outputs to dac 3-4. |
| `chmon.maxpat` | Channel monitor routing — gates individual channels between main and monitor buses. |
| `ch.maxpat` | Channel interface and routing control. |

### Timing System

| File | Purpose |
|------|---------|
| `time.maxpat` | Master clock — generates tempo pulses, BPM, phase signals. Sends `tr_pulse`, the phase-locked `sequence64_pulse`, `tr_tempo`, and `box/led`. |
| `clock.maxpat` | Clock source selection (internal/external/beat clock), swing, MIDI device routing. |
| `clock2.maxpat` | Secondary clock — beat clock distribution, MIDI tempo sync. Sends `gome_pulse`, `gome_tempo`. |

### Pattern and Sequencing

| File | Purpose |
|------|---------|
| `pattern.maxpat` | Pattern recording/playback — records key sequences via `seq~`, syncs to clock, loops. |

### Effects

| File | Purpose |
|------|---------|
| `djfxxx-0.2.maxpat` | DJ effects rack — delay, filter, ringmod, flanger, scratch, granular, stutter. Large patch with LED feedback. |
| `djio.maxpat` | DJ effects I/O interface — handles state and LED updates for the effects page. |

### Interface and Grid

| File | Purpose |
|------|---------|
| `wcell.maxpat` | Grid cell with "weird" modulation factor. Sends to `#1[weird]`. |
| `wcellg.maxpat` | Grid cell variant — receives from `#1[weird]`. |
| `64notemute.abs.maxpat` | MIDI note-to-mute mapping via `coll midi_settings`. |

### Preset and File Management

| File | Purpose |
|------|---------|
| `preset.maxpat` | Preset save/recall system — stores row configs via `coll`, keyboard navigation. |
| `file_list.maxpat` | Sample file browser/manager — loads audio files, uses `file.abs` abstraction. |

### Live Abstractions (Binary, .mxb)

These are old-format Max binary abstractions still used by the patches. They cannot be
version-controlled meaningfully (binary diffs). Converting to `.maxpat` format in Max would
make them inspectable and diffable.

| File | Used By |
|------|---------|
| `64button.abs.mxb` | `_mlr.maxpat` (8 bpatcher instances) |
| `64midi.abs.mxb` | `_mlr.maxpat` (9 bpatcher instances) |
| `64note.abs.mxb` | `_mlr.maxpat` (16 bpatcher instances) |
| `64num.abs.mxb` | `_mlr.maxpat`, `64notemute.abs.maxpat` |
| `fade.mxb` | `pl.maxpat`, `output.maxpat`, `_mlr.maxpat` |

### Hidden Abstractions (no file extension)

These extensionless files are actually Max binary abstractions loaded via the search path.
Do not rename, move, or delete them.

| File | Used By |
|------|---------|
| `showMeter` | `_mlr.maxpat` — meter display components |
| `agate` | `djfxxx-0.2.maxpat` — gate effect |
| `session` | `_mlr.maxpat` — session state bpatcher |
| `file.abs` | `file_list.maxpat` — per-file abstraction (hundreds of instances) |

### Data and Config Files

| File | Purpose |
|------|---------|
| `midi_settings` | MIDI control mapping — saved/loaded by `coll midi_settings` |
| `_save.txt` | Saved button mapping state |
| `rec.pat` | Pattern recorder state (bpatcher in `_mlr.maxpat`) |
| `rec_b.pat` | Pattern recorder state (dependency) |

### Preset/Pattern Files (User Data)

These are user-created data files loaded via file dialogs. Not hardcoded into the patches
(except `dope-preset` which has a legacy hardcoded path).

| File | Purpose |
|------|---------|
| `default pattern` | Default pattern sequence data |
| `default pattern 2` | Default pattern sequence data |
| `dope-preset` / `dope-preset_flist` | User preset + file list |
| `myfirstpreset` / `myfirstpreset_flist` | User preset + file list |

### Documentation

| File | Purpose |
|------|---------|
| `mlr_info.txt` | Modification changelog and full operation docs (loaded by patch) |
| `license_mlr.txt` | GPL v2 license text (loaded by patch) |
| `documentation.rtf` | **Note:** This is documentation for polygome 256, not mlr. Kept for reference. |

### Images

| File | Purpose |
|------|---------|
| `mlr.png` | Logo displayed in main patch UI |
| `logo.png` | Not referenced by patches |
| `step.png` | Not referenced by patches |

## Architecture

### Signal Flow

```
Grid 256 (serialosc)
  |
  v
_mlr.maxpat (main orchestrator)
  |
  +---> time.maxpat / clock.maxpat -----> tr_pulse, tr_tempo, [time]phase
  |                                           |
  +---> pl.maxpat (per-channel)  <-----------+  (tempo sync)
  |       |   groove~ playback
  |       v
  +---> djfxxx-0.2.maxpat (effects) -----> output.maxpat (per-channel)
  |                                             |
  +---> pattern.maxpat (records key sequences)  +---> dac~ 1 2 (main)
  |                                             +---> mon.maxpat ---> dac~ 3 4 (monitor)
  +---> preset.maxpat (save/recall)
  +---> file_list.maxpat (sample browser)
```

### Messaging Protocol

Inter-patch communication uses Max `send`/`receive` with namespaced names.
The `#1` prefix is a Max argument placeholder — it becomes the channel number (1-8)
when the patch is instantiated.

**Clock namespace (`[time]`):**
- `[time]bpm` — current BPM
- `[time]ms` — milliseconds per beat
- `[time]phase` — sync phasor signal (audio rate via `send~`/`receive~`)
- `[time]preset` — tempo preset recall
- `tr_pulse` — clock tick
- `tr_tempo` — tempo value
- `tr_pulse_duration` — pulse width

**Playback namespace (`[pl]`, `[box]`):**
- `#1[pl]stop` — stop playback for channel #1
- `#1[pl]on` — playback active flag
- `#1[box]mute` — mute channel #1
- `#1[box]rev` — reverse playback for channel #1
- `#1[box]rowPos` — current row position (3 ints: row, col, state)
- `[box]output` — output routing

**Volume:**
- `#1vol` — volume level for channel #1
- `#1vol_add` — increment/decrement volume
- `raw_volume` / `raw_mute` — raw control values

**Pattern:**
- `pattern_in` / `pattern_out` — pattern data bus

**Grid LEDs:**
- `box/led` — LED update messages (col, row, level)
- `_box/led` — secondary LED bus (used by djio)

**Global control:**
- `kmod` — modifier key state (0=normal, 1=stop mode, 2=mod page)
- `[mlr]start` / `[mlr]stop` / `[mlr]reset` — transport control
- `[mlr]q` — quantize setting
- `randoggu` — random pattern trigger

**Monitor:**
- `mon1` / `mon2` — monitor audio bus (signal rate)
- `monvol` — monitor volume
- `#1chmon` — per-channel monitor enable

**Effects:**
- `#1[weird]` — weird modulation factor
- `weirdoffset` — weird offset signal (audio rate)
- `#1djfxsel` — DJ effect selection
- `#1mlrdjstat` — DJ effect status

## Untracked / Work-in-Progress Files

The following files exist in the working directory but are **not referenced by any patch**
and are not tracked in git. They may be works-in-progress or experiments:

- `routers.js` — grid input routing logic (similar to the `p routers` subpatcher in `_mlr.maxpat`)
- `buttonseq.js` — step sequencer recorder
- `groupsproc.js` — group processing (subset of routers.js logic; contains a bug where `muted` is used as scalar instead of array)
- `groupsproc` (no extension) — tiny code fragment, same logic as groupsproc.js

## Packaging a handoff

Create a tested, versioned ZIP containing the Max runtime project without Git
metadata, test tooling, MCP helpers, editor settings, or `node_modules`:

```sh
./scripts/package_release.sh
```

The ZIP and its SHA-256 checksum are written to `release/`. Packaging requires
all tracked changes to be committed, so the handoff always identifies the exact
source revision from which it was created.
