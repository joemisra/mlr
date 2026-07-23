# 64-Step Editor Reference

Updated 2026-07-22. Grid coordinates in this document are one-based.

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

## Saved model

Each group and direct track owns an independent pattern:

```text
pattern = {
  version: 2,
  running: 0 | 1,
  currentBar: 0..7,
  bars: [1..8 × bar]
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

`running`, held buttons, chooser state, the in-progress live take, active
shapes, and clear/remove confirmation are runtime state. The viewed bar is saved
per target. A JS reload closes the editor; choosing a target again resets Run
while preserving its pattern.

## Event semantics

The clock advances four evenly spaced sequence steps per `tr_pulse`: one at the
incoming pulse and three at measured quarter-pulse intervals. This is eight
times the six-page prototype rate, so all 64 steps occupy 16 master pulses. The
four 16-step parts of the viewed bar remain simultaneously visible on rows
9–12:

- Row 9 is bar subdivisions 1–16.
- Row 10 is subdivisions 17–32.
- Row 11 is subdivisions 33–48.
- Row 12 is subdivisions 49–64.

If Max delivers a scheduled quarter-pulse callback late, the next master pulse
accounts for the missing subdivision before advancing. This keeps every bar at
exactly 64 steps instead of allowing alternate 16-step sections to drift.

One bar is the default. Up to eight bars may be added; playback traverses their
active lengths consecutively and then loops to bar 1. Row 13 selects the viewed
bar independently of the playing bar, so another bar can be inspected or edited
without interrupting Run. Momentary Setup lock recording always writes the
playing bar and step. Adding or removing a bar stops Run; removal and clearing
the viewed bar each require a second press within 1.2 seconds.

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
3. Tap steps 1, 17, 33, and 49. Set length to 64 and press Run. Confirm the
   four rows advance in order and stopping leaves the last cut playing.
4. Add bar 2 from row 13, then use the direct bar buttons and previous/next
   buttons to switch between bars. Enter different cuts on both bars and confirm
   Run crosses the boundary without resetting phase. While bar 1 is playing,
   view bar 2 and confirm only the bar-1 playhead indicator is hidden.
5. Hold a step. Add probability, volume Set, and gate length. Repeat with Pluck,
   Swell, Gate, and Pulse; confirm the visible gate tail and audible modulation.
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
10. Repeat navigation and monochrome-level checks on Grid Zero. Do not enable
   `editorBrightnessColors`; its default is off.

Run the automated checks before a hardware pass:

```bash
npm test
node --check grid_router.js
python3 scripts/analyze_maxpat.py grid_router_io.maxpat --no-comments --depth 1
python3 scripts/analyze_maxpat.py pl.maxpat --no-comments --depth 1
```
