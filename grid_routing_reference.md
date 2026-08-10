# Grid LED Routing Reference

Architecture map for the mlr grid LED and key-press signal flow.
Updated 2026-08-03.

---

## LED Data Path (normal operation)

```
Audio Engine (p chnls / playback heads)
  │
  ├─ s box/led           single cell:  col row level
  ├─ s box/led_row       full row:     row lev0 lev1 …
  └─ s box/led_col       full column:  col lev0 lev1 …
       │
       ▼
  p grid_drawing
  │  r box/led  → [t b l] → [prepend boxled]  → s gridrouter
  │  r box/led_row        → [prepend boxledrow] → s gridrouter
  │  r box/led_col        → [prepend boxledcol] → s gridrouter
  │
  │  Also: r rawpress → switch (kmod) → animation kf → s togridmatrixanim
  │        (key-press flash-fade on row; only active when kmod==1)
  │
       ▼
  grid_router_io.maxpat  (contains grid_router.js)
  │  Inlet 0: r gridrouter + r box/press_mlr (key events)
  │  Inlet 1: r kmod       (internal)
  │  Inlet 2: r tr_pulse   (internal — clock tick for automation)
  │  Inlet 3: r sequence64_pulse (internal — audio-derived step clock)
  │
  │  grid_router.js:
  │    boxled / boxledrow / boxledcol  → led(x,y,level)
  │      → outlet(1, "setcell", x, y, level)
  │    onKmodChange → suppress callback-time LED writes → broadcast kmod state
  │      → render complete foreground/background arrays → replaceframe
  │      (the bridge swaps the validated frame atomically; no cleared page exists)
  │    editor cell diff → beginupdate → changed setcell(s) → endupdate
  │      (same atomic flush, without clearing the existing matrix)
  │    64-step editor clock → advance independent shape voices
  │      → probability → persistent parameter locks → quantized cut trigger
  │      (rate~ 0.125 plus both edges produces 16 phase-locked steps per
  │       quarter note: exactly 64 steps per 4/4 bar)
  │      (JavaScript receives one pulse per step; no scheduled subdivision
  │       callbacks or catch-up bursts can accumulate phase drift)
  │      (one bar is the default; up to eight per-target bars play consecutively
  │       while the user may independently view/edit another bar)
  │      (Run resets off whenever a target is selected; Stop releases Gate
  │       shapes but leaves ordinary MLR cuts and Set locks latched)
  │    main-page hold col 14 + matching cut → wait for quantized chRowPos
  │      → buffer exact track/slice and absolute sequence-clock position
  │      → on release, round take to nearest 16-step beat and create 1–8 bars
  │    optional editorColors → paced semantic palette + color-only cell diffs
  │      (visible page sent directly as 4×4 maps at 8 ms; no auto presets)
  │      (off by default; legacy 0–15 levels remain authoritative)
  │    drawModPage / animateLeds → led() calls (kmod 2 only)
  │
  │  Outlet 1 → s togridmatrixio
  │
       ▼
  grid_matrix_io.maxpat  (contains grid_matrix_bridge.js + grid_anim_engine.js)
  │  Inlet 0: r togridmatrixio  — replaceframe / setcell / flush
  │                               / beginupdate / endupdate
  │                               / edition / dual128 / color extension commands
  │  Inlet 1: toggle            — qmetro 33ms periodic flush (manual enable)
  │  Inlet 2: button            — anim engine tick (manual / undriven)
  │  Inlet 3: r togridmatrixanim — kf / line animation commands
  │
  │  Internal wiring:
  │    inlet 0 ──► grid_matrix_bridge.js
  │      replaceframe validates and swaps the stable foreground/background
  │      in one operation; beginupdate preserves both for small live diffs
  │    inlet 1 ──► toggle → qmetro 33 → [t b b] out1 → "flush" msg → bridge
  │    inlet 2 ──► "tick" msg → grid_anim_engine.js
  │    inlet 3 ──► grid_anim_engine.js (kf / line)
  │    anim_engine outlet 0 ──► bridge  (animcell / animclear / flush;
  │      the bridge owns separate level + transparency-mask byte arrays;
  │      completed cells clear only their mask and reveal the router base)
  │    bridge outlet 0 ──► grid_matrix_io outlet 0
  │    bridge outlet 1 ──► grid_matrix_io outlet 1
  │
  │  Outlet 0 → s fromgridmatrixio   (primary LED OSC stream)
  │  Outlet 1 → ⚠️  NOT CONNECTED in _mlr.maxpat
  │             (intended for bottom-half when bridge dual128=1)
  │
       ▼
  grid_composite_2x128.maxpat  (contains grid_composite_2x128.js)
  │  Inlet 0: r fromgridmatrixio (LED data only)
  │
  │  Internal:
  │    JS splits /grid/led/level/map by oy offset:
  │      oy <  8  → outlet 0 → [udpsend 127.0.0.1 #1]  (top grid serialosc port)
  │      oy >= 8  → outlet 1 → [udpsend 127.0.0.1 #2]  (bottom grid serialosc port)
  │    /grid/led/all and /grid/led/level/all → sent to BOTH outlets
  │    Key events: internal [udpreceive 58901/58902] → JS merges (bottom y+=8)
  │
  │  Outlet (maxpat): merged key events → p oscreceiveroute
  │    → OSC-route /box/grid/key → s rawpress (animation) + s box/press_a (playback)
```

The HUD Live page's **Capture + Reinit Grid** action snapshots the bridge's
foreground, background, composite, semantic-color cache, palette hashes, and
outgoing packet counters before and after a full hardware resync. Incidents are
written to `/tmp/mlr-display-incidents.jsonl` and cross-referenced in
`/tmp/mlr-diagnostic.log`. The private MechaTrellis color packets have no reply,
so these records describe the exact state requested by Max rather than verified
firmware state. Readback would require a future firmware/libmonome/serialosc
protocol addition; no standard serialosc messages are changed by recovery.

The router and matrix bridge are one logical 16×16/edition-256 surface.
`grid_composite_2x128` may split that downstream across two physical panels,
but the matrix bridge stays `dual128 0`. Startup and recovery explicitly
reassert `edition 256` and `dual128 0`, so stale Max Global state cannot reduce
HUD snapshots to 16×8. Automatic MechaTrellis colors upload only the visible
palette directly; firmware preset store/recall is explicit/manual compatibility
functionality rather than part of page switching or recovery.

---

## Key Press Data Path

```
Physical Grid(s)
  │
  ├─ Top 128:    serialosc port #1 → /sys/port 58901 → [udpreceive 58901]
  └─ Bottom 128: serialosc port #2 → /sys/port 58902 → [udpreceive 58902]
       │
       ▼
  grid_composite_2x128.js
  │  Inlet 1 (top):    /grid/key x y s  → outlet 2 as-is
  │  Inlet 2 (bottom): /grid/key x y s  → y += 8 → outlet 2
  │
       ▼
  grid_composite_2x128 maxpat outlet → p oscreceiveroute
  │  OSC-route /box/grid/key → s rawpress + s box/press_a
  │  OSC-route /box/mute     → s raw_mute
  │  OSC-route /box/volume   → s raw_volume
  │
       ▼
  s box/press_a → grid_dual128_hub (r box/press_a)
  → grid_dual128_merge.js (dual=0, passthrough) → s box/press_mlr
  → grid_router_io (r box/press_mlr) → grid_router.js
```

### 16×16 editor ownership

The editor is dormant until mode-2 physical column 14 is held and a group or
track is selected. Its default `sequence64` layout owns physical rows 9–16 only
while mode 2 is visible. Rows 9–12 map row-major to steps 1–64; row 16 switches
between Sequence and Setup or exits. The selected target persists on the main
page so holding physical column 14 there can record cuts, but no lower-half LEDs
or legacy key routes are intercepted outside mode 2.

The sample browser is a separate split overlay. It owns rows 1–8 while open and
deliberately yields rows 9–16 to the active editor. Its renderer composes both
halves into one atomic frame, and the ordinary LED/animation paths reject
top-half writes until the browser closes. Row 16 column 13 toggles it from
Sequence or Setup; its 240-entry cap is presented as three 96-sample pages.

Each target starts with one bar and may contain up to eight. Sequence row 13
chooses a viewed bar, steps through bars, adds a bar, or removes one with a
double press. Bars play consecutively; switching the viewed bar is non-disruptive
and hides the playhead when a different bar is playing. Structural add/remove
operations stop Run. Setup lock recording follows the playing bar, not the
independently viewed bar. Main-page live cuts are buffered until record release,
when their take length determines the required bar count and partial final bar.

`chRowPos` is the commit point for live cuts. A normal-mode press first creates a
short-lived pending record candidate; only the matching track's returned,
quantized position is stored. Sequencer-generated cuts carry a playback guard so
they cannot recursively record themselves. It is also the authoritative
persistent playhead update: each callback replaces a primed trigger position and
clears stale playback markers on sibling tracks in the same channel.

Sequence64 Transpose is sent as signed semitones and combines with the existing
track-wide octave multiplier in `ch.maxpat`: playback rate is
`2^octave × 2^(transpose/12)`. In the lock editor, the first two pitch keys
subtract/add twelve semitones in the step lock; the remaining fourteen select
its −6 through +7 semitone component.

The six-page prototype remains behind `editorLayout legacy` for comparison and
rollback. `editorLayout sequence64` is the production default. Each legacy
target's first 16 gates/probabilities/gate-FX values migrate once into new step
objects, without modifying the old dictionaries.

---

## Key Merge (grid_dual128_hub.maxpat)

```
  r box/press_a  (top grid)    → grid_dual128_merge.js inlet 0
  r box/press_b  (bottom grid) → grid_dual128_merge.js inlet 1
                                    │
                                    │  When dual=1: bottom row += 8
                                    │  When dual=0: bottom inlet ignored
                                    ▼
                                  s box/press_mlr → grid_router_io inlet 0
```

The hub's `dual128 1/0` toggle controls the merge only, not the LED bridge.
The bridge `dual128` mode should always be 0 when using `grid_composite_2x128`.

---

## Animation Engine (grid_anim_engine.js)

Keyframe-based per-cell interpolation. The animator sends `animcell` and
`animclear` messages to the bridge, which owns stable foreground/background and
transient level/mask byte arrays. This supports both bright flashes and inverse
dark blinks without named-Jitter binding or allowing a fade-to-zero to erase
page state.

**Sources:**
- `p grid_drawing`: `line <row> 0 15 8 0 0 16` on key press (flash-fade row)
- `p grid_metronome`: `kf 12 0 15 0 0 4` and `kf 13 0 15 0 0 32` on beats

**Status:** `_mlr.maxpat` starts the animation tick automatically. The legacy
whole-row key flash, metronome flash, and router feedback all render through the
transient overlay. Clearing or recompiling the animator drops the mask and
immediately reveals the authoritative base.

---

## All Named Sends / Receives

### _mlr.maxpat (top level)

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `togridmatrixio` | s/r | complete frame, live diffs, flush, edition to LED bridge |
| `togridmatrixanim` | s/r | kf, line commands to animation engine |
| `fromgridmatrixio` | s/r | LED OSC output from bridge → composite |
| `gridrouter` | s/r | boxled/boxledrow/boxledcol to grid_router.js |
| `mlr_hud_state` | s/r | Passive normalized HUD snapshots and incremental state |
| `sample_bank` | s/r | Bank reload/read/folder scan, preview, runtime assignment, metadata snapshot |
| `mlr_sample_preview` | r | Private sample audition player; does not replace a track buffer |
| `mlr_hud_preview_ready` | s/r | Preview-buffer load completion → cached HUD waveform |
| `grid_router_playback` | s/r | Normal-mode presses from grid_router → p box |
| `kmod` | s/r | Current grid page (1=Main, 2=Mod/Sequence64, 3=Groups) |
| `tr_pulse` | r | Transport clock pulse |
| `box_out` | r | ⚠️ Dead — no active senders (legacy intra-patch UDP path) |
| `pattern_out` | r | Pattern recorder output |
| `box_clear` | r | |
| `dacgo` | r | DAC on/off |
| `randoggu` | r | |

### p grid_drawing

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `box/led` | r | Single-cell LED from playback heads |
| `box/led_row` | r | Full-row LED from playback heads |
| `box/led_col` | r | Full-column LED |
| `box/shutdown` | r | Grid shutdown signal |
| `box/test` | r | Test signal |
| `box/intensity` | r | Intensity control |
| `kmod` | r | Mode filtering (switch input) |
| `rawpress` | r | Raw key press for animation trigger |
| `gridrouter` | s | Formatted LED commands to grid_router |
| `togridmatrixanim` | s | Animation keyframes |

### p grid_metronome

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `[mlr]trig` | r | Trigger flash on col 12 row 0 |
| `[time]pulse` | r | Time pulse flash on col 13 row 0 |
| `togridmatrixanim` | s | Animation keyframes for metronome LEDs |

### p box > p chnls

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `N[box]rowPos` | r | Row position for channel N (1–8) |
| `box/led_row` | s | Full-row LED updates from playback |
| `box/led` | s | Single-cell LED updates |

### p box

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `[box]output` | r | Channel output |
| `grid_router_playback` | r | Grid press events from router |
| `kmod` | r | Mode value |
| `box/led` | s | LED output (2 senders) |
| `pagechange` | s | Page change notification |

### p oscreceiveroute

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `rawpress` | s | Raw key presses from grid → animation trigger |
| `raw_mute` | s | Mute state from grid OSC |
| `raw_volume` | s | Volume state from grid OSC |
| `box/press_a` | s | Key events (col row state) → grid_dual128_hub merge |

### p animations

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `[time]phase` | r~ | Audio-rate phase signal |
| `box_out` | s | ⚠️ Dead — not connected to composite (legacy path removed) |

### p debug

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `kmod` | r | Mode value display |
| `[time]bpm` | r | BPM display |
| `[time]ms` | r | ms display |
| `64sync-out` | r | Sync activity indicator |

### grid_router_io.maxpat (internal)

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `kmod` | r | Mode value → grid_router.js inlet 1 |
| `tr_pulse` | r | Clock tick → grid_router.js inlet 2 |
| `togridmatrixio` | s | LED setcell from grid_router.js outlet 1 |

### grid_dual128_hub.maxpat

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `box/press_a` | r | Top grid key presses |
| `box/press_b` | r | Bottom grid key presses |
| `box/press_mlr` | s | Merged key stream |
| `togridmatrixio` | s | Edition message only (not dual128 toggle) |

---

## Known Issues / Technical Debt

1. **Dead data paths**: `r box_out` has no active senders — vestigial from
   pre-bridge architecture. The `p animations` subpatcher sends to `s box_out`
   but is no longer connected to the composite. Consider removing both.

2. **Animation traffic**: The always-on tick sends a complete varibright frame
   only when an overlay level changes. It is now state-safe, but region-dirty
   map output remains a possible future optimization for dense animation use.

3. **grid_matrix_io outlet 1 not connected**: When `dual128Mode=1` in the bridge,
   bottom-half LED data is sent to outlet 1 which has no patchcord in
   `_mlr.maxpat`. This is correct when using `grid_composite_2x128` (which
   expects `dual128 0`), but would need wiring for the alt two-grid path.
