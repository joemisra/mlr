# 64-Step Editor Reference

Updated 2026-07-30. Grid coordinates in this document are one-based.

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
For permanent startup behavior, copy `mlr.local.example.json` to the ignored
`mlr.local.json`; without that local file both MechaTrellis private OSC and
semantic color start disabled.
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

Each group owns a looping arrangement pattern. Each track owns a reusable
one-shot phrase pattern:

```text
pattern = {
  version: 5,
  defaultTrack: -1..14,
  rateNumerator: 1..16,
  rateDenominator: 1..16,
  running: 0 | 1,
  currentBar: 0..7,
  bars: [1..8 × active bar],
  parkedBars: [0..7 × preserved inactive bar]
}

bar = {
  length: 1..64,
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

New group targets start with one 64-step bar. New track phrases start empty with
one 16-step bar, matching the tracker-style instrument-phrase role. Either can
be resized or extended to eight bars. Version-1/2/3/4 and legacy single-bar data
becomes bar 1 without being deleted. Internally, `pattern.length` and
`pattern.steps` remain compatibility aliases for bar 1.

For a group pattern, `track: -1` inherits `defaultTrack`. A fresh or migrated
group pattern resolves that default from the current active track, then the last
active track, then the lowest-numbered track assigned to the group. It remains
unavailable when the group has no tracks. An explicit Track is validated again
at playback, so reassigning that track to another group leaves the step saved
but waiting for correction. Live recording always writes an exact track. A
direct-track phrase always resolves to its selected track.

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

One bar is the default. The group arrangement traverses its active lengths
consecutively and loops to bar 1. A track phrase traverses its active length
once and stops. Row 13 selects the viewed
bar independently of the playing bar, so another bar can be inspected or edited
without interrupting Run. Latched Setup lock recording always writes the
playing bar and step. Adding/removing bars, changing the active bar count, and
changing a bar's 1–64 step length do not stop Run. The pattern keeps its
current bar/step when that location remains valid. If an edit removes the
playing bar or shortens it behind the playhead, only that pattern immediately
restarts at bar 1 step 1. Removal and clearing the viewed bar each require a
second press within 1.2 seconds. The four length buttons require a roughly
350 ms hold, preventing an accidental structural edit.

Row 16 column 12 is a momentary Shift key in Sequence view. While it is held,
tapping any step in rows 9–12 makes that step the viewed bar's exact endpoint,
providing every length from 1 through 64. The ordinary row-13 length buttons
remain quick presets for 16, 32, 48, and 64. A shifted length gesture cannot
also toggle the step's cut, even if Shift is released before the step.

Shift also exposes a saved rate row at row 14 columns 1–9:

| Column | Rate |
|--------|------|
| 1 | 1/4× |
| 2 | 1/3× |
| 3 | 1/2× |
| 4 | 2/3× |
| 5 | 1× |
| 6 | 3/2× |
| 7 | 2× |
| 8 | 3× |
| 9 | 4× |

Group patterns and track phrases both default to 1× and store their own rational
rate. The currently viewed target never supplies timing to another target, so
switching between a group and one of its phrases cannot alter either playhead.
A live rate change keeps the current pattern location and rebases its local
phase. At rates above 1×, every crossed logical step is serviced so triggers are
not skipped. Active parameter shapes are rebased and continue at their owning
pattern's rate.

The eight bar buttons have two gestures: tap an active bar to view it (or tap
the first inactive bar to add it), and hold bar N for roughly 350 ms to set the
pattern to N active bars. Shortening parks trailing bar data; extending restores
those bars before creating blank ones. A completed main-page live take defines
a new pattern and discards previously parked trailing bars.

A tap toggles a cut. Holding an active step for roughly 350 ms opens its lock
editor, which remains open after release. Clicking the selected step closes the
editor without changing the cut; clicking another active step moves the editor
to it. Clicking an empty step while the editor is open creates its default cut
and moves the editor there, allowing several steps to be programmed without
closing the popup. Parameter buttons occupy columns 5–12, with group patterns
adding Track at column 13, and the six shape buttons remain on columns 6–11.
Slice edits are locks over the cut's recorded/default slice, and the value row
shows the effective locked slice. Clearing the slice lock returns to the
underlying cut slice.

When Track is selected, row 14 shows all 16 positions but lights only tracks
assigned to the group. Its bright cell is the step's explicit Track or inherited
default. Selecting a track stores it on the step and creates a default cut when
needed. Clearing Track returns the cut to `track: -1`. Direct-track patterns do
not show or accept the Track parameter.

With the popup closed, row 15 also carries a bright 16-position playback marker
for the direct target track or the currently active track in a group target.
It follows the same playback-position feed as the main page and disappears when
the target is stopped. Pressing the live lane immediately triggers the resolved
MLR player and replaces a stale marker before the DSP callback arrives, so the
lane also works before Sequence64 Run has been engaged. The marker temporarily
yields to the popup controls.

Sequence row 14 column 3 is Restart. Each pattern has its own phase origin, so
Restart moves only that pattern to bar 1 step 1 and leaves every other pattern
in place. It fires step 1 immediately and continues with step 2 on the next
pulse. If the pattern was stopped, Restart also starts and latches its playback.

For a group target, row 14 column 1 is latched Run/Stop. For a track target it
is one-shot Preview/Stop: Preview starts the phrase from step 1 using the
track's current slice as its seed hit, and returns to stopped at the phrase end.
The mode-2 track buttons in column 12 use the same Preview/Stop behavior.
Row 14 column 4 is the unambiguous Pattern Stop button for either target type;
it is intentionally separate from Restart.

On mode 2, group Run keys at row 5 columns 1–8 and phrase Preview keys at
column 12 rows 2–16 also provide trigger feedback. A running full-bright key
briefly dips and returns bright; a stopped phrase key flashes bright and returns
dim. When a group cut launches a phrase, both corresponding keys pulse.

Row 16 column 14 is a separated navigation shortcut. From a group it opens the
group's current track, then last track, then resolved default. From a track it
returns to that track's assigned group. It works from Sequence or Setup and
does not alter playback.

MIDI and CV pattern trigger targets are intentionally deferred. No MIDI/CV
routing or target behavior is added by this revision.

When a running group cut selects a track, that track's non-empty phrase launches
as a child of the group event. Phrase step 1 merges with the group hit: its locks
apply to that hit, an explicit phrase cut overrides the group slice, and there
is never a double trigger. Later phrase cuts retrigger their programmed slices.
An empty phrase leaves the group cut unchanged.

Retriggering a track restarts its phrase. Triggering another track assigned to
the same group cancels the earlier child phrase because the tracks share one
group player. Manual cuts and the live lane also cancel the child phrase and
clear Sequence64 audio ownership, preventing the phrase from pulling playback
back to an old position. Ordinary `chRowPos` messages are treated only as
playback telemetry: continuous position reports cannot cancel their own phrase.

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

Stop cancels every active Set/Glide/Pluck/Swell/Gate/Pulse state for that target,
including modulation applied by its active child phrase.
A new event for the same target and parameter replaces the existing voice.
Clear Motion returns every active voice to its current latched value. Restore
Start State also restores the track/channel snapshot and playback position taken
when Run was pressed.

Sequence writers are stacked per controlled property: channel volume/filter and
track reverse/octave/loop division. Stopping a target removes its frames and
restores the preceding writer or the original/manual baseline. Manual edits
replace that baseline. Saved cuts, locks, probability, shapes, and Track choices
are never erased by Stop.

Each group player also records the Sequence target that supplied its latest
cut. Child phrase triggers retain their parent group's audio owner. Stop sends
`N[pl]stop` only when the stopped target is still that owner. Manual cuts and
the live lane clear ownership, so stopping an older or superseded target does
not interrupt current audio.

Volume shapes control the existing `N[gatefx]level` multiplier. Filter shapes
send `N[filterfx]level <normalized-value> <ramp-ms>` as a future DSP hook.

## Hardware test pass

1. Open mode 2. Verify the legacy page is unchanged before target selection.
2. Hold row 1 column 14. Select a group from row 1 or a track from column 16;
   keep holding and change target once, then release. Confirm no mute/reverse
   change occurred.
3. Tap steps 1, 17, 33, and 49. Hold the 64-length button and press Run. Confirm the
   four rows advance in order and Stop halts the player when this pattern still
   owns its latest cut. Press row 14 column 3 and confirm only this pattern
   restarts immediately at step 1.
4. Hold Shift at row 16 column 12 and tap steps 1, 23, and 64; confirm each
   becomes the exact endpoint without toggling its cut. Still holding Shift,
   select 1/2×, 1×, and 2× on row 14 and verify the playhead rate changes
   without jumping. Open a track phrase while its group runs and confirm the
   editor switch does not change either target's timing.
5. Hold bar 4 on row 13 and confirm four bars appear, then hold bar 2 and return
   to bar 4 to confirm trailing data was parked and restored. Use taps and the
   previous/next buttons to switch views. Enter different cuts on two bars and
   confirm Run crosses the boundary without resetting phase. While bar 1 is
   playing, view bar 2 and confirm only the bar-1 playhead indicator is hidden.
   Change lengths while Run is active: a still-valid playhead must stay put,
   while removing its bar or shortening behind it must restart this pattern at
   step 1 without sending player Stop.
6. While a target is playing, confirm the lime marker on row 15 follows its
   actual playback position; for a group, switch tracks and confirm the marker
   follows the active one. Hold a step until its centered editor opens, then
   release it. Confirm the marker yields to the popup. Change the slice and
   verify both its selected LED and the audible trigger, then clear it and
   confirm the original slice returns. Add probability, volume Set, and gate
   length. Repeat with Pluck, Swell, Gate, and Pulse; confirm the editor remains
   open, the visible gate tail and audible modulation. Click the selected step
   again and confirm the editor closes without toggling it.
7. Stop during a Gate and during a Swell. Both should cancel and restore their
   underlying value while their programmed shapes remain saved. Press Clear
   Motion, then Restore Start State.
8. Return to the main page. Hold row 1 column 14 and perform a one-bar take,
   releasing near its end. Confirm it becomes 64 steps and uses the audible
   quantized slices. Repeat for six beats and confirm a 64-step bar plus a
   32-step final bar. For a group target, play two tracks in the same group and
   one in another group; only the first two should record. Briefly hold/release
   without playing and confirm the saved take is unchanged.
9. In Sequence, tap row 14 column 2 to latch Record, then press Setup on row 16.
   Change volume, octave, and loop division, then tap Record again. Confirm Set locks
   appear at the current sequence step. For a group, select Track at row 13
   column 13 and verify row 14 filters to assigned tracks, saves an explicit
   track, and returns to the inherited default when cleared. During the gesture the volume row
   previews the modulation layer; with Record released it controls the base
   channel volume as usual.
10. Exit with row 16 column 16. Confirm the lower mode-2 controls work normally.
11. On MechaTrellis, enable `editorColors 1` and verify the trigger/lock/gate,
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
