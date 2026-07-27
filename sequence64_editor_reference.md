# 64-Step Editor Reference

Updated 2026-07-23. Grid coordinates in this document are one-based.

## Safety and compatibility

- The editor is available only on a 16×16 grid and remains dormant until a
  group or track is explicitly selected.
- Selecting a target never starts playback. Every target's Run state is reset
  when selected.
- Without a selected target, main-page column 14 and all legacy controls keep
  their previous behavior.
- Grid Zero uses the same 0–15 levels as MechaTrellis. Optional color updates do
  not participate in sequencing or state decisions.
- `editorLayout legacy` selects the checkpointed six-page implementation;
  `editorLayout sequence64` selects the default implementation.

## Optional semantic colors

Send `editorColors 1` for the MechaTrellis palette; send `editorColors 0` for
monochrome hardware. The legacy `editorBrightnessColors` command is an alias.
The Sequence view uses cyan for triggers, green for gated triggers, amber for
locks, magenta for combined trigger+lock steps, blue-violet for gate tails,
white for the playhead, and orange for the held step. Run/Add are green,
recording is pink, destructive controls are red, Sequence navigation is cyan,
and Setup navigation is amber.

Turning off a trigger deliberately preserves its locks, so an amber cell after
that action is a triggerless lock rather than a stuck color. With no remaining
locks, the renderer explicitly restores the neutral step color.

Each lock parameter and predefined shape also has a stable color. Setup reuses
the eight group colors and gives volume, octave, reverse, randomization, loop
division, loop bounds, latch, timestretch, and mute separate families. Color
changes can be sent even when a cell's level does not change. The standard
0–15 level remains the complete state representation and is always sent through
the ordinary renderer. Full palette refreshes use persistent 4×4 color maps;
playheads, presses, and other sparse feedback retain the one-cell color path.

## Saved model

Each group and direct track owns an independent pattern:

```text
pattern = {
  version: 2,
  running: 0 | 1,
  currentBar: 0..7,
  bars: [1..8 × active bar],
  parkedBars: [0..7 × preserved inactive bar]
}

bar = {
  length: 16 | 32 | 48 | 64,
  steps: [64 × step]
}

step = {
  cut: null | { track: -1..14, slice: 0..15, gateLength: 1..16 },
  probability: 0..15,
  locks: {
    slice?:        { value: 0..15, behavior: "set" },
    volume?:       { value: 0..15, behavior: shape },
    filter?:       { value: 0..15, behavior: shape },
    reverse?:      { value: 0|1, behavior: "set" },
    octave?:       { value: -3..3, behavior: "set" },
    loopDivision?: { value: 4|6|8|12|16|24|32|48, behavior: "set" }
  }
}
```

New targets start with one 64-step bar. Version-1 and legacy single-bar data
becomes bar 1 without being deleted. Internally, `pattern.length` and
`pattern.steps` remain compatibility aliases for bar 1.

For a manual group step, `track: -1` resolves the group's active track when the
step plays. Live recording always writes an exact track. A direct-track pattern
always resolves to its selected track.

`running`, held buttons, the selected step editor, chooser state, the in-progress
live take, active shapes, and clear/remove confirmation are runtime state. The
viewed bar is saved per target. A JS reload closes the editor; choosing a target
again resets Run while preserving its pattern.

## Event semantics

The clock advances from a dedicated audio-derived `sequence64_pulse`, one pulse
per step. `time.maxpat` derives it from the same quarter-note phase signal as
`tr_pulse`. Its `rate~ 0.125` ramp crosses two detected edges eight times per
quarter, producing 16 steps per quarter note and 64 per 4/4 bar. JavaScript does
not schedule or catch up subdivisions, avoiding low-priority callback jitter.
The four 16-step parts of the viewed bar remain simultaneously visible on rows
9–12:

- Row 9 is bar subdivisions 1–16.
- Row 10 is subdivisions 17–32.
- Row 11 is subdivisions 33–48.
- Row 12 is subdivisions 49–64.

One bar is the default. Up to eight bars may be added; playback traverses their
active lengths consecutively and then loops to bar 1. Row 13 selects the viewed
bar independently of the playing bar, so another bar can be inspected or edited
without interrupting Run. Momentary Setup lock recording always writes the
playing bar and step. Adding or removing a bar stops Run; removal and clearing
the viewed bar each require a second press within 1.2 seconds. The four
16/32/48/64 buttons require a roughly 350 ms hold before changing the viewed
bar's step length, preventing an accidental structural edit.

The eight bar buttons have two gestures: tap an active bar to view it (or tap
the first inactive bar to add it), and hold bar N for roughly 350 ms to set the
pattern to N active bars. Shortening parks trailing bar data; extending restores
those bars before creating blank ones. A completed main-page live take defines
a new pattern and discards previously parked trailing bars.

A tap toggles a cut. Holding an active step for roughly 350 ms opens its lock
editor, which remains open after release. Clicking the selected step closes the
editor without changing the cut; clicking another active step moves the editor
to it. Parameter buttons are centered on columns 5–12 and the six shape buttons
on columns 6–11. Slice edits are locks over the cut's recorded/default slice,
and the value row shows the effective locked slice. Clearing the slice lock
returns to the underlying cut slice.

With the popup closed, row 15 also carries a bright 16-position playback marker
for the direct target track or the currently active track in a group target.
It follows the same playback-position feed as the main page and disappears when
the target is stopped. The marker temporarily yields to the popup controls.

Main-page live recording is take-based. Holding row 1 column 14 arms it, and the
first matching quantized `chRowPos` establishes the take start. Release measures
from that first audible event and rounds to the nearest 16-step beat, with a
minimum of 16 and maximum of 512 steps. Finalization creates as many full
64-step bars as needed and gives the last bar a 16/32/48/64-step length. Buffered
events prevent a take longer than the currently allocated pattern from wrapping
and overwriting its first bar before finalization.

A completed take replaces cut triggers but preserves probabilities, parameter
locks, and gate length at re-recorded positions; its exact quantized slice wins
over an older slice edit. Events retain global clock phase. An empty gesture
does nothing, a pending quantized cut may finish just after release, and
recording does not implicitly enable Run.

1. Test the step probability.
2. Apply persistent track locks and start or replace parameter shapes.
3. Send the cut press/release pair to the resolved track.

An ordinary cut is a trigger: it moves MLR and stays there. A gate length does
not undo that cut. Instead, it supplies the lifetime of a Gate parameter shape
and the visible tail in the Sequence view.

The parameter shapes are deliberately fixed presets:

| Shape | Result |
|-------|--------|
| Set | Jump to the destination and latch |
| Glide | Move to the destination over four steps and latch |
| Pluck | Fast attack toward the destination, then return over four steps |
| Swell | Slower rise and return over eight steps |
| Gate | Attack, sustain for the step's gate length, then release |
| Pulse | Alternate start/destination over four steps, then return |

Shapes are independent of the sequence transport once started. Stop releases
Gate shapes, while Pluck/Swell/Pulse tails finish. A new event for the same
target and parameter replaces the existing voice. Clear Motion returns every
active voice to its current latched value. Restore Start State also restores the
track/channel snapshot and playback position taken when Run was pressed.

Volume shapes control the existing `N[gatefx]level` multiplier. Filter shapes
send `N[filterfx]level <normalized-value> <ramp-ms>` as a future DSP hook.

## Hardware test pass

1. Open mode 2. Verify the legacy page is unchanged before target selection.
2. Hold row 1 column 14. Select a group from row 1 or a track from column 16;
   keep holding and change target once, then release. Confirm no mute/reverse
   change occurred.
3. Tap steps 1, 17, 33, and 49. Hold the 64-length button and press Run. Confirm the
   four rows advance in order and stopping leaves the last cut playing.
4. Hold bar 4 on row 13 and confirm four bars appear, then hold bar 2 and return
   to bar 4 to confirm trailing data was parked and restored. Use taps and the
   previous/next buttons to switch views. Enter different cuts on two bars and
   confirm Run crosses the boundary without resetting phase. While bar 1 is
   playing, view bar 2 and confirm only the bar-1 playhead indicator is hidden.
5. While a target is playing, confirm the lime marker on row 15 follows its
   actual playback position; for a group, switch tracks and confirm the marker
   follows the active one. Hold a step until its centered editor opens, then
   release it. Confirm the marker yields to the popup. Change the slice and
   verify both its selected LED and the audible trigger, then clear it and
   confirm the original slice returns. Add probability, volume Set, and gate
   length. Repeat with Pluck, Swell, Gate, and Pulse; confirm the editor remains
   open, the visible gate tail and audible modulation. Click the selected step
   again and confirm the editor closes without toggling it.
6. Stop during a Gate and during a Swell. Gate should release; Swell should
   finish. Press Clear Motion, then Restore Start State.
7. Return to the main page. Hold row 1 column 14 and perform a one-bar take,
   releasing near its end. Confirm it becomes 64 steps and uses the audible
   quantized slices. Repeat for six beats and confirm a 64-step bar plus a
   32-step final bar. For a group target, play two tracks in the same group and
   one in another group; only the first two should record. Briefly hold/release
   without playing and confirm the saved take is unchanged.
8. In Sequence, hold row 14 column 2 and press Setup on row 16. Change volume,
   octave, and loop division, then release row 14 column 2. Confirm Set locks
   appear at the current sequence step. During this gesture the volume row
   previews the modulation layer; with Record released it controls the base
   channel volume as usual.
9. Exit with row 16 column 16. Confirm the lower mode-2 controls work normally.
10. On MechaTrellis, enable `editorColors 1` and verify the trigger/lock/gate,
   navigation, parameter, shape, and Setup color families. Repeat navigation
   and monochrome-level checks on Grid Zero with `editorColors 0`; its default
   is off. Confirm every actionable dim cell remains visible; cells outside the
   selected bar length should be dark and non-actionable. On the first palette
   load, confirm there is no 256-cell sweep (a brief tile-wise draw is okay).
   Then watch the playhead, track-position marker, button presses, and one-cell
   pings to confirm their colors update immediately without repainting a 4×4
   block.

Run the automated checks before a hardware pass:

```bash
npm test
node --check grid_router.js
python3 scripts/analyze_maxpat.py grid_router_io.maxpat --no-comments --depth 1
python3 scripts/analyze_maxpat.py pl.maxpat --no-comments --depth 1
```
