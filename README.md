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

## Developer Tooling

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
| `time.maxpat` | Master clock — generates tempo pulses, BPM, phase signals. Sends `tr_pulse`, `tr_tempo`, `box/led`. |
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
