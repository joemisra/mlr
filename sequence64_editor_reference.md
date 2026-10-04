# ṛta (ऋत) Editor Reference

Updated 2026-08-24. Grid coordinates in this document are one-based.

**ṛta** is the user-facing name of this pattern-and-phrase instrument.
`Sequence64` remains the internal implementation and compatibility identifier.

## Safety and compatibility

- The editor is available only on a 16×16 grid and remains dormant until a
  group or track is explicitly selected. Mode-2 row 16 columns 1–3 remain
  visible as its inert Sequence / Setup / Scene entry and view indicators.
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
Use **GRID COLOR ON/OFF** on the HUD's Live or Colors page to switch hardware
color and remember the choice in the ignored `mlr.local.json`. Turning color
off neutralizes the retained hardware palette and keeps standard 0–15 levels.
The local file can also select `mechatrellisProtocol` 1 or 2; the toggle preserves
that selection and other workstation settings. Without a local file both
MechaTrellis private OSC and semantic color start disabled.
The Sequence view uses cyan for triggers, green for gated triggers, amber for
locks, magenta for combined trigger+lock steps, blue-violet for gate tails,
white for the playhead, and orange for the held step. Run/Add are green,
recording is pink, destructive controls are red, Sequence navigation is cyan,
and Setup navigation is amber. Empty step cells are level 0 with black RGB, so
a complete step deletion visibly turns the cell off in either hardware mode.

Conditional and probability decisions temporarily replace the white playhead:
orange means Condition played, red means Condition skipped, yellow means
Probability played, and violet means Probability skipped. The flash lasts one
audio-derived subpulse, then reveals the normal playhead or saved step color.
When both settings are present, a failed Condition is red; after Condition
passes, the later Probability result supplies the visible yellow/violet result.
All four colors are editable from the HUD Colors page.

Turning off a trigger deliberately preserves its locks, so an amber cell after
that action is a triggerless lock rather than a stuck color. With no remaining
locks, the renderer explicitly restores the neutral step color.

Each lock parameter and predefined shape also has a stable color. Setup reuses
the eight group colors and gives volume, octave/transpose, reverse, randomization, loop
division, loop bounds, playback loop, latch, timestretch, and mute separate families. Color
changes can be sent even when a cell's level does not change. The standard
0–15 level remains the complete state representation and is always sent through
the ordinary renderer. Full palette refreshes use persistent 4×4 color maps;
playheads, presses, and other sparse feedback retain the one-cell color path.

## Saved model

Sequence64 aliases are now resolved through the scene library. Group patterns
have 12 reusable slots per group, and each independent Track Slot stores the 16 phrase-pattern
references that appear as `track:0` through `track:15` to the existing engine.
This indirection leaves the proven sequencer paths unchanged while Scene view
can replace a whole combination. See
[`docs/scenes-and-track-slots.md`](docs/scenes-and-track-slots.md) for the full-grid
layout, direct selection rules, and session migration.

Scene is now a composite construction view: row 1 holds Scenes; rows 2–9 put
each group's 12 pattern slots left-to-right; row 10 selects independent Track
Slots; row 11 holds global transport; and rows 12–15 keep a directly editable
64-step bar for the most recently touched group. The dedicated Sequence view
retains its existing rows 9–12 step grid and all structural/lock controls.

Playback loop is durable per-track Track Slot data. `1` preserves ordinary
wrapping `groove~` playback; `0` lets the buffer reach its end as a true
one-shot. This is separate from the saved loop-region start/end and its active
toggle. Because tracks in one group share a player, the selected track's
playback-loop value is restored immediately before every manual, auditioned,
or sequenced cut.

Each group owns a looping arrangement pattern. Each track owns a reusable
one-shot phrase pattern:

```text
pattern = {
  version: 9,
  defaultTrack: -1..15,
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
  cut: null | { track: -1..15, slice: 0..15, gateLength: 1..64 },
  probability: 0..15,
  condition: 0 | 2..9 | -2..-9,
  locks: {
    slice?:        { value: 0..15, behavior: "set" },
    volume?:       { value: 0..15, behavior: shape },
    filter?:       { value: 0..15, behavior: shape },
    reverse?:      { value: 0|1, behavior: "set" },
    transpose?:    {
      value: -96..96 total semitones,
      pitchOctave: -8..8,
      pitchSemitone: -6..7,
      behavior: "set"
    },
    loopDivision?: { value: 4|6|8|12|16|24|32|48, behavior: "set" }
  }
}
```

Tapping an empty step creates a cut on slice 1 by default (stored as `slice: 0`).
This keeps the compact four-row editor useful without exposing its Slice lane;
live recording and explicit Slice edits continue to retain their captured or
chosen values. Group patterns remember their last chosen track for new cuts.
Selecting an existing cut, choosing Track with the grid or a knob, and live
recording update this choice; sequencer playback does not. New cuts store that
track explicitly when it still belongs to the group. The choice is per pattern
and survives save/open. Earlier inherited cuts keep their original default.

New group targets start with one 64-step bar. New track phrases start empty with
one 16-step bar, matching the tracker-style instrument-phrase role. Either can
be resized or extended to eight bars. Version-1/2/3/4/5/6/7/8 and legacy single-bar data
becomes bar 1 without being deleted. Internally, `pattern.length` and
`pattern.steps` remain compatibility aliases for bar 1.

Version-6 octave locks migrate to Transpose at twelve semitones per old octave
unit. Version 8 records the octave and semitone UI components while retaining
their combined total for playback and compatibility. Version 9 adds the
per-step conditional trigger; older steps migrate to unconditional (`0`).

For a group pattern, `track: -1` inherits `defaultTrack`. A fresh or migrated
group pattern resolves that default from the current active track, then the last
active track, then the lowest-numbered track assigned to the group. It remains
unavailable when the group has no tracks. An explicit Track is validated again
at playback, so reassigning that track to another group leaves the step saved
but waiting for correction. Live recording always writes an exact track. A
direct-track phrase always resolves to its selected track.

`running`, held buttons, per-target edit cursor, inspector context, chooser
state, the in-progress live take, active shapes, and clear/remove confirmation
are runtime state. The viewed bar is saved per target. A JS reload closes the
editor; choosing a target again resets Run while preserving its pattern.

## Event semantics

The clock advances from a dedicated audio-derived `sequence64_pulse`, one pulse
per step. `time.maxpat` derives it from the same quarter-note phase signal as
`tr_pulse`. Its `rate~ 0.125` ramp crosses two detected edges eight times per
quarter, producing 16 steps per quarter note and 64 per 4/4 bar. Native edges
define these subdivisions; V8 still prepares musical events for the native
bridge and can be delayed by a busy low-priority queue. Playback reads validated
pattern objects, while editing and newly replaced pattern identities use the
normalization path. At rates above 1×, crossed logical steps are serviced within
the callback. Playback-driven editor/HUD updates and groove position displays
share one on-demand 33 ms task; musical state and recording capture update
immediately, and the task displays the latest state when it runs.
The four 16-step parts of the viewed bar remain simultaneously visible on rows
9–12:

- Row 9 is bar subdivisions 1–16.
- Row 10 is subdivisions 17–32.
- Row 11 is subdivisions 33–48.
- Row 12 is subdivisions 49–64.

One bar is the default. The group arrangement traverses its active lengths
consecutively and loops to bar 1. A track phrase traverses its active length
once and stops. Bars 1–8 remain on row 16 columns 4–11 in every Sequence
inspector context, so another bar can be inspected or edited
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
providing every length from 1 through 64. Row 13 columns 1–4 remain quick
presets for 16, 32, 48, and 64 in every Sequence inspector context. A shifted length gesture cannot
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

The eight row-16 bar buttons have two gestures: tap an active bar to view it (or tap
the first inactive bar to add it), and hold bar N for roughly 350 ms to set the
pattern to N active bars. Shortening parks trailing bar data; extending restores
those bars before creating blank ones. A completed main-page live take defines
a new pattern and discards previously parked trailing bars.

The step inspector is persistent. Tapping an empty step creates its default cut
and selects it; tapping an existing step selects it without deleting anything.
Each target recalls a transient edit cursor, with step 1 and Slice as the fresh
defaults. Parameter buttons occupy row 13 columns 5–14. Group patterns retain
Track at column 13 and Condition at column 14; track phrases omit Track and put
Condition at column 13. Row 13 column 15 selects Pattern context.

Row 14 is the selected parameter's value lane. Slice edits are locks over the
cut's recorded/default slice, and the lane shows both the effective locked
slice and current playback position. Pressing Slice saves the value and sends
an immediate MLR press; releasing it sends the matching release. This audition
does not change the target's Run state. With Live Write latched at row 15 column
2, the same lane records the playing bar/step rather than the edit cursor.
Clearing the slice lock returns to the underlying cut slice. In a group pattern
that value is absolute. In a track phrase it is an offset: the phrase adds it
modulo 16 to the launching group cut, or to the track's current slice during
standalone Preview. Offset 0 preserves the root slice.

When Transpose is selected, row 14 columns 1 and 2 subtract or add twelve
semitones inside that step's pitch lock. Columns 3–16 select its fine component
from −6 through +7 semitones. Both components are saved together, may be edited
in either order, and produce one combined Transpose value. Setup uses the same
mapping on row 11 while Record is latched; with Record off, its octave buttons
and semitone row edit the track-wide playback baseline instead.

When Track is selected, row 14 shows all 16 positions but lights only tracks
assigned to the group. Its bright cell is the step's explicit Track or inherited
default. Selecting a track stores it on the step and creates a default cut when
needed. Clearing Track returns the cut to `track: -1`. Direct-track patterns do
not show or accept the Track parameter.

When Condition is selected, row 14 exposes all sixteen occurrence conditions.
Columns 1–8 are **Every 2** through **Every 9**: the step plays only on each Nth
visit. Columns 9–16 are **Skip 2** through **Skip 9**: the step plays on every
visit except each Nth one. Visit 1 begins after Restart, and a group-launched
track phrase inherits that group-pattern visit number, keeping nested rhythmic
shapes phase-aligned. Clear restores unconditional playback. The condition is
tested before probability, locks, or audio, and it does not erase any saved step
data when it skips.

Setup provides track-wide baselines without a modifier: row 9 assigns the
group, row 10 sets group volume, row 11 edits octave/semitone pitch, row 12
holds Reverse, Random Offset, and loop division, and rows 13–14 set the loop
region bounds. On row 15, columns 1–7 are Region Loop, Latch, Timestretch,
Mute, Clear Motion, Restore Start, and Playback Loop. A bright Playback Loop
cell repeats the sample; a dim cell is a true one-shot.

Row 15 column 1 toggles the selected step's cut while preserving all locks,
making triggerless locks intentional. Columns 6–11 select Set, Glide, Pluck,
Swell, Gate, and Pulse for Volume/Filter. When Filter is selected, columns
12–15 choose LFO 1, LFO 2, ADSR, or AR and temporarily turn row 14 into a signed
route-depth lane. Press the selected source again to leave route editing.
Column 16 clears the selected step parameter.

Row 16 column 15 is momentary Delete. Delete + step clears the complete step;
Delete + value clears the selected parameter; Delete + Filter source clears
that target-wide route. In Pattern context, Delete + bar uses the same two-press
confirmation as ordinary bar removal. Trigger alone never clears locks.

Pattern context keeps the persistent structure visible: row 13 columns 1–4 are
the 16/32/48/64 length presets, and row 16 columns 4–11 are bars 1–8. Row 14
columns 13–16 are previous, next, add, and confirmed remove. Row 15 columns
1–4 are Run/Preview, Live Write, Restart, and Stop; row 15 column 16 clears the
viewed bar with confirmation.

Pattern row 15 column 3 is Restart. Each pattern has its own phase origin, so
Restart moves only that pattern to bar 1 step 1 and leaves every other pattern
in place. It fires step 1 immediately and continues with step 2 on the next
pulse. If the pattern was stopped, Restart also starts and latches its playback.

For a group target, Pattern row 15 column 1 is latched Run/Stop. For a track target it
is one-shot Preview/Stop: Preview starts the phrase from step 1 using the
track's current slice as its seed hit, and returns to stopped at the phrase end.
The mode-2 track buttons in column 12 use the same Preview/Stop behavior.
Pattern row 15 column 4 is the unambiguous Stop button for either target type;
it is intentionally separate from Restart.

Starting a group, restarting a pattern, launching a Scene, or previewing a track
phrase starts global transport automatically. Global Stop freezes the shared
Sequence64 phase and silences sequencer-owned audio/modulation without clearing
group Run latches; Global Start resumes those latches. Turning off the final
group or completing the final Preview stops transport. Manual main-page cuts
remain independent and do not start it.

On mode 2, group Run keys at row 5 columns 1–8 and phrase Preview keys at
column 12 rows 2–16 also provide trigger feedback. A running full-bright key
briefly dips and returns bright; a stopped phrase key flashes bright and returns
dim. When a group cut launches a phrase, both corresponding keys pulse.

Mode-2 column 10 is the destination-first audio recorder. Row 1 toggles its
stereo source: level 6 is external input and level 15 is the internal mix.
Pressing a track row arms capture and starts global transport if necessary;
recording begins at the next native 64-step bar boundary. Releasing requests a
stop at the following boundary, so a quick tap still records one whole bar.
The completed float32 stereo take joins the sample catalog, is assigned to that
track, and writes through to the active Track Slot. Referenced takes are copied
into a saved session and restored from the bundle as catalog samples. This is
forward capture; retrospective pre-roll is a separate follow-on layer.

Row 16 column 14 is a separated navigation shortcut. From a group it opens the
group's current track, then last track, then resolved default. From a track it
returns to that track's assigned group. It works from Sequence or Setup and
does not alter playback.

Mode-2 row 16 columns 1–3 are always Sequence, Setup, and Scene. Tapping the
currently open view collapses the editor and returns rows 9–16 to the ordinary
track controls while leaving the target and its playback intact. Tapping any
of the three view keys reopens that view. The old three-row grid VU overlay is
disabled so it cannot cover this navigation or the lower track controls.

Row 16 column 13 toggles the sample browser without closing the editor. The
browser owns only rows 1–8: row 1 selects tracks, rows 2–7 show one 96-sample
page, and row 8 provides previous/next, direct page selection, and Close.
Rows 9–16 continue to draw and accept Sequence or Setup input. Sample-browser
ownership rejects legacy playhead, clock, and animation writes in its top half,
so asynchronous Max callbacks cannot paint through it.

MIDI and CV pattern trigger *targets* are intentionally deferred. Separately,
MLR mirrors each accepted player hit to the ES-9 output for that hit's assigned
group (groups 1–8 → Max device channels 9–16). This output is post-condition and
post-probability; a skipped step does not pulse. It is a trigger mirror only and
cannot select, start, or stop a pattern. The portable default is disabled and
the local ES-9 workstation enables it through `mlr.local.json`.

When a running group cut selects a track, that track's non-empty phrase launches
as a child of the group event. Phrase step 1 merges with the group hit: its locks
apply to that hit, its effective Slice is added modulo 16 to the group slice,
and there is never a double trigger. Its Condition and Probability can suppress
that merged hit, so their playhead result matches the audible outcome. Later
phrase cuts retrigger relative to the same group-slice root. An empty phrase
leaves the group cut unchanged.

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

1. Test the step's Every/Skip condition for the current pattern visit.
2. Test the step probability.
3. Apply this step's locks and start or replace explicit parameter shapes.
4. Send the cut press/release pair to the resolved track.

An ordinary cut is a trigger: it moves MLR and stays there. A gate length does
not undo that cut. Instead, it supplies the lifetime of a Gate parameter shape
and the visible tail in the Sequence view.

The red group Run row and track Run column on mode 2 are also editor shortcuts:
tap to toggle Run, or hold for about 350 ms to open that target without changing
its Run state.

The parameter shapes are deliberately fixed presets:

| Shape | Result |
|-------|--------|
| Set | Jump to the destination for this step, then restore on the next step |
| Glide | Move to the destination over four steps and latch |
| Pluck | Fast attack toward the destination, then return over four steps |
| Swell | Slower rise and return over eight steps |
| Gate | Attack, sustain for the step's gate length, then release |
| Pulse | Alternate start/destination over four steps, then return |

The ordinary Set behavior is step-scoped, including across an empty following
step. Glide remains the explicit move-and-latch shape. Stop cancels every active
Set/Glide/Pluck/Swell/Gate/Pulse state for that target,
including modulation applied by its active child phrase.
A new event for the same target and parameter replaces the existing voice.
Clear Motion returns every active voice to its current latched value. Restore
Start State also restores the track/channel snapshot and playback position taken
when Run was pressed.

Sequence writers are stacked per controlled property: channel volume/filter and
track reverse/transpose/loop division. A Set frame is removed at the next step;
longer shapes retain ownership for their stated duration or until Stop. Removing
a frame restores the preceding writer or the original/manual baseline. Manual
edits replace that baseline. Saved cuts, locks, probability, shapes, and Track
choices are never erased by Stop.

Each group player also records the Sequence target that supplied its latest
cut. Child phrase triggers retain their parent group's audio owner. Stop sends
`N[pl]stop` only when the stopped target is still that owner. Manual cuts and
the live lane clear ownership, so stopping an older or superseded target does
not interrupt current audio.

Volume shapes control the existing `N[gatefx]level` multiplier. Filter shapes
send `N[filterfx]level <normalized-value> <ramp-ms>` into the native filter path;
the four target-wide modulation sources are summed there at signal rate.

## Hardware test pass

1. Open mode 2. Verify the legacy page is unchanged before target selection.
2. Hold row 1 column 14. Select a group from row 1 or a track from column 16;
   keep holding and change target once, then release. Confirm no mute/reverse
   change occurred.
3. Confirm step 1 and Slice are selected immediately. Tap steps 1, 17, 33, and
   49; tap each again and verify none are deleted. Hold row 13 column 4 to set a
   64-step length, select Pattern at row 13 column 15, and press Run. Confirm the
   four rows advance in order. Press Pattern row 15 column 3 and confirm only
   this pattern restarts immediately at step 1; column 4 stops it.
4. Hold Shift at row 16 column 12 and tap steps 1, 23, and 64; confirm each
   becomes the exact endpoint without toggling its cut. Still holding Shift,
   select 1/2×, 1×, and 2× on row 14 and verify the playhead rate changes
   without jumping. Open a track phrase while its group runs and confirm the
   editor switch does not change either target's timing.
5. In Pattern context, hold bar 4 at row 16 column 7 and confirm four bars
   appear, then hold bar 2 at row 16 column 5 and return to bar 4 to confirm
   trailing data was parked and restored. Use taps and the
   previous/next buttons to switch views. Enter different cuts on two bars and
   confirm Run crosses the boundary without resetting phase. While bar 1 is
   playing, view bar 2 and confirm only the bar-1 playhead indicator is hidden.
   Change lengths while Run is active: a still-valid playhead must stay put,
   while removing its bar or shortening behind it must restart this pattern at
   step 1 without sending player Stop.
6. Return to Slice. Confirm its row-14 lime marker follows playback. Hold a
   value and verify audition begins, then ends on release. Change Slice,
   Probability, Volume Set, and Gate Length without reopening anything. Repeat
   with Pluck, Swell, Gate, and Pulse. Use Trigger at row 15 column 1 to remove
   the cut while preserving locks, then hold Delete at row 16 column 15 and tap
   the step to clear it completely.
7. Stop during a Gate and during a Swell. Both should cancel and restore their
   underlying value while their programmed shapes remain saved. Press Clear
   Motion, then Restore Start State.
8. Return to the main page. Hold row 1 column 14 and perform a one-bar take,
   releasing near its end. Confirm it becomes 64 steps and uses the audible
   quantized slices. Repeat for six beats and confirm a 64-step bar plus a
   32-step final bar. For a group target, play two tracks in the same group and
   one in another group; only the first two should record. Briefly hold/release
   without playing and confirm the saved take is unchanged.
9. In Sequence, tap row 15 column 2 to latch Live Write, use the Slice lane, and
   confirm the playing step changes while the edit cursor does not. Then press
   Setup on row 16. Change volume, transpose, and loop division, then tap Live
   Write again. Toggle Playback Loop at row 15 column 7, trigger near the end,
   and confirm dim stops at the buffer end while bright wraps. Switch between
   two tracks in the same group with opposite settings and confirm neither
   inherits the other's mode. Confirm Set locks appear at the current sequence
   step and return to the baseline on the next step. For a group, select Track at row 13
   column 13 and verify row 14 filters to assigned tracks, saves an explicit
   track, and returns to the inherited default when cleared. During the gesture the volume row
   previews the modulation layer; with Record released it controls the base
   channel volume as usual.
10. Select Filter, choose each source on row 15 columns 12–15, and set positive
    and negative depths on row 14. Verify audible movement, envelope retrigger
    and release, route persistence after target changes, lit-route clearing,
    and Delete + source.
11. Tap the current view key on row 16 columns 1–3. Confirm the editor collapses,
    the lower mode-2 pitch controls work, and playback continues. Reopen Setup,
    then Exit with row 16 column 16 and confirm the target clears.
12. On MechaTrellis, enable `editorColors 1` and verify the trigger/lock/gate,
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


### Instrument pages

Track 15 hosts the kick and Track 14 hosts the snare. In either track inspector, or on a group-pattern step resolving to one of those tracks, row 13 / column 16 toggles instrument controls. Row 13 / columns 10–12 select one of three four-parameter pages; columns 5–8 select a parameter. Row 14 sets its value. Row 15 / column 3 toggles baseline editing, columns 4–5 make fine adjustments, and existing Live Write and Clear remain available. Coordinates are one-based.

With the knob input's Grid focus selected, the expanded MLR parameter page also maps knobs in its visible parameter order, including sample tracks. Holding a step writes locks; Live Write records to the incoming MIDI step. Switching between MLR and instrument pages rearms pickup. The exact knob map and current-value versus step-edit behavior are documented in [the knob-control guide](docs/rnbo-drum-lab.md).

Group instrument locks override track-phrase locks on their shared merged hit without altering stored values. Later phrase hits use their own locks or the manual baseline. Moving between kick and snare group steps changes the visible engine and parameter IDs while keeping the current page number. Selecting a sample-only step returns to sample controls. Each scheduled hit captures its twelve effective parameters, and an unlocked following hit returns to the baseline without changing the older tail. The Min/Max fields in each Lab patch map future grid edits while leaving stored physical values unchanged. See `docs/rnbo-kick-lab.md` and `docs/rnbo-snare-lab.md` for parameter names and ranges.

### Sound presets in Setup

On instrument tracks, row 15 columns 8–15 are eight sound slots. Tap recalls;
Shift (row 16 column 12) + tap stores or overwrites. Each engine has a separate
bank. Brightness 2 identifies empty slots, 5 stored slots, and 15 the selected
slot while its sound still matches the baseline. Editing the sound removes
that bright match indication. HUD notices name the engine and slot; the grid
uses compact KP1–KP8 / SP1–SP8 labels.

Slots contain only the engine's twelve sound baselines. Recall applies them as
one baseline change, without recording locks during Live Write or changing
existing patterns. Queued hits and ringing tails retain their captured values.
Banks persist at session scope across Track Slot switches; selection indicators
are transient. Old sessions load empty banks.

### Parameter identification

Selecting a parameter shows a persistent HUD name/value/context banner and a brief bitmap abbreviation over rows 1–8. Selecting another step or changing values updates the HUD without restarting the label. Kick page changes announce BODY / FMAT / RES; snare page changes announce BODY / NOIS / MIX. The label holds for 500 ms, then fades for 500 ms back to the current underlying display; rows 9–16 and grid input are unchanged. Closing parameter context cancels it. See `docs/parameter-announcements.md`.

### Hat instrument on Track 13

Track 13 now has the same instrument-page, baseline, lock, and sound-bank behavior as Track 14 snare and Track 15 kick. Row 13, column 16 selects hat controls; columns 10–12 select **Metal**, **Shape**, or **Filter / output**, announced as METL, SHAP, and FILT. The four controls per page are listed in `docs/rnbo-hat-lab.md`. Setup row 15, columns 8–15 contains the independent hat sound bank, announced as HP1–HP8. It follows the same tap-to-recall and Shift-plus-tap-to-store gestures. Hat lab and updated native bridge must be loaded for audible sequenced locks.

### Clap instrument on Track 12

Track 12 uses the shared instrument controls, baseline editing, step locks, and sound presets. Row 13, column 16 switches to clap controls; columns 10–12 select **Claps**, **Tone**, and **Tail / output**, announced as CLAP, TONE, and TAIL. Burst count is a whole number from 1–8. Its independent eight-slot sound bank occupies Setup row 15, columns 8–15, announced as CP1–CP8, with the usual tap-to-recall and Shift-plus-tap-to-store gestures. Open `rnbo_clap.maxpat` and reload the updated native bridge before testing sequenced locks. See `docs/rnbo-clap-lab.md` for the twelve controls and their ranges.

### Selected-step feedback

A selected step containing a trigger or locks breathes slowly between brightness 11 and 15 on a two-second cycle, even with transport stopped. With semantic color enabled, a soft rose tint moves with the pulse while retaining some of the underlying trigger/lock color. The playhead and physically held step take priority. Empty/deleted steps remain dark. The display-only pulse suspends outside the visible Sequence editor and during Shift length/rate or modulation-matrix views; it does not affect sound timing or session data.

### Step copy/paste

**Row 16, column 14 (Target Jump)** is now tap-to-jump and hold-to-copy. A normal tap jumps between group and track on release. In Sequence, hold it and tap the source step, then tap one or more destinations while keeping it held. Release to finish. The first source tap can happen immediately; holding without a step for 350 ms displays COPY and suppresses the jump. After capture, the grid displays PASTE and the HUD identifies copied/pasted steps.

The clipboard captures the complete step: trigger, slice/track/gate settings, every lock and shape, probability, and condition. Each paste replaces the destination with an independent copy of that snapshot. Triggerless and empty steps stay triggerless/empty; copying does not audition or record a note. Empty sources therefore clear destination contents when pasted.

You can tap existing bar buttons while holding Copy to paste into another bar of the same pattern. Other editing controls are suppressed during the gesture. Release Copy to access them again. Starting Copy with Shift or Delete already held is ignored. Leaving the editor/view clears the gesture; clipboard state is never saved. Setup retains tap-to-jump and has no step-copy action. Shift and Delete keep their existing meanings.

### Additional instrument tracks

Tom / Rim / Bell / FM Bass use visible tracks 11 / 10 / 9 / 8. The same instrument toggle, three parameter pages, step locks, base editing and independent session preset banks apply. Bass Note is an integer MIDI pitch, separate from sample transpose. Full page mappings are in [the extended-engine guide](docs/rnbo-extended-synths.md).
