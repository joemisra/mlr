# Grid LED Routing Reference

Architecture map for the mlr grid LED and key-press signal flow.
Updated 2026-03-28.

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
  │
  │  grid_router.js:
  │    boxled / boxledrow / boxledcol  → led(x,y,level)
  │      → outlet(1, "setcell", x, y, level)
  │    onKmodChange → messnamed("togridmatrixio", "clear"/"flush")
  │    drawModPage / animateLeds → led() calls (kmod 2 only)
  │
  │  Outlet 1 → s togridmatrixio
  │
       ▼
  grid_matrix_io.maxpat  (contains grid_matrix_bridge.js + grid_anim_engine.js)
  │  Inlet 0: r togridmatrixio  — setcell / flush / clear / edition / dual128
  │  Inlet 1: toggle            — qmetro 33ms periodic flush (manual enable)
  │  Inlet 2: button            — anim engine tick (manual / undriven)
  │  Inlet 3: r togridmatrixanim — kf / line animation commands
  │
  │  Internal wiring:
  │    inlet 0 ──► grid_matrix_bridge.js (setcell writes to jit.matrix)
  │    inlet 1 ──► toggle → qmetro 33 → [t b b] out1 → "flush" msg → bridge
  │    inlet 2 ──► "tick" msg → grid_anim_engine.js
  │    inlet 3 ──► grid_anim_engine.js (kf / line)
  │    anim_engine outlet 0 ──► "flush" msg → bridge  (triggers flush on dirty)
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

Keyframe-based per-cell interpolation. Shares the same `jit.matrix` as the bridge.

**Sources:**
- `p grid_drawing`: `line <row> 0 15 8 0 0 16` on key press (flash-fade row)
- `p grid_metronome`: `kf 12 0 15 0 0 4` and `kf 13 0 15 0 0 32` on beats

**Status:** The tick input (grid_matrix_io inlet 2) is connected to a manual button
in `_mlr.maxpat` — no automatic driver. Animations are queued but never processed
unless manually ticked. To activate, connect a `[metro]` or `[r tr_pulse]` to
grid_matrix_io inlet 2.

---

## All Named Sends / Receives

### _mlr.maxpat (top level)

| Bus | Direction | Purpose |
|-----|-----------|---------|
| `togridmatrixio` | s/r | setcell, flush, clear, edition to LED bridge |
| `togridmatrixanim` | s/r | kf, line commands to animation engine |
| `fromgridmatrixio` | s/r | LED OSC output from bridge → composite |
| `gridrouter` | s/r | boxled/boxledrow/boxledcol to grid_router.js |
| `grid_router_playback` | s/r | Normal-mode presses from grid_router → p box |
| `kmod` | s/r | Current kmod value (1–4) |
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

2. **Animation engine tick undriven**: `grid_matrix_io` inlet 2 is connected to
   a manual `[button]` in `_mlr.maxpat`. The `p grid_drawing` key-press
   animations and `p grid_metronome` beat flashes are queued but never executed.
   Connect a `[metro 16]` or `[r tr_pulse]` to inlet 2 to activate.

3. **grid_matrix_io outlet 1 not connected**: When `dual128Mode=1` in the bridge,
   bottom-half LED data is sent to outlet 1 which has no patchcord in
   `_mlr.maxpat`. This is correct when using `grid_composite_2x128` (which
   expects `dual128 0`), but would need wiring for the alt two-grid path.
