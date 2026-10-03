# Persistent Step Inspector Plan

Updated 2026-08-11. The first implementation is complete in `grid_router.js`
and covered by the editor regression suite. It is ready for a brightness-only
Max/grid play test; the decisions below remain the interaction contract for
that test.

## Core change

Selecting a group or track should always open Sequence with a selected step and
the step inspector visible. Holding a step is no longer required to reveal
Slice or the other parameters. The four 16-cell step rows remain the primary
pattern view; the three rows beneath them become a persistent contextual
inspector.

The selected step is an edit cursor, not a destructive toggle:

- Tapping an empty step creates its default cut and selects it, retaining the
  present fast-programming gesture.
- Tapping an existing step selects it without deleting its trigger.
- The selected step stays selected while parameters and targets are edited.
- A fresh target recalls its last runtime edit cursor, or begins at step 1.
- Cursor/inspector state remains transient; it is not session data.

This removes the current ambiguity where touching an existing step in order to
edit it can also remove its cut.

## Persistent rows

Grid coordinates below are one-based.

| Row | Proposed role |
| --- | --- |
| 9–12 | Sixty-four steps; tap to create/select, Delete+step to erase |
| 13 | Parameter/context tabs; Slice is selected initially |
| 14 | Sixteen-position value and audition lane for the selected context |
| 15 | Trigger, Live Write, shapes, and modulation-source controls |
| 16 | Universal navigation/modifiers, including Shift and Delete |

The parameter order can stay familiar: Slice, Probability, Volume, Filter,
Reverse, Transpose, Loop Division, Gate Length, Track, and Condition. A Pattern
tab in the remaining space temporarily exposes length, bars, and transport so
none of the existing structural controls disappear.

## Slice as the default instrument

Slice is the first visible parameter whenever a target is opened fresh.
Pressing a position on its row-14 value lane performs two related actions:

1. save that position on the selected step;
2. audition the resolved track at that position while the button is held.

Release ends the audition gate without stopping the pattern or changing its
Run state. A group target uses its selected/explicit/default track. A track
phrase continues to save its relative offset; direct audition plays that raw
position, while the launching group cut supplies the phrase root in playback.

Other parameters use the same selected-step/value-lane model. Volume, Filter,
Transpose, Reverse, divisions, gate length, Track, Condition, and Probability
therefore no longer require reopening a popup for each step. Only Slice needs
to trigger audio by default; later play testing can determine whether holding
Filter or Volume should provide a temporary preview without committing.

## Keeping the live-recording lane

The current live lane has two jobs that should be separated explicitly:

- ordinary Slice context: audition and edit the selected step;
- **Live Write** context: audition immediately and write cuts at the running
  playhead, preserving the existing performance-recording workflow.

Live Write should be a clearly lit latch or momentary modifier on row 15. With
it off, row 14 edits the selected step. With it on, the same physical lane
writes the current playing step. This retains learned muscle memory without
making the less-common recording behavior occupy a permanent row.

## Context row and modulation

Row 15 becomes secondary controls for the selected row-13 parameter:

- a Trigger control adds/removes the cut while preserving locks, supporting
  intentional trigless locks;
- Live Write changes the Slice lane from direct editing to playhead recording;
- Volume and Filter show Set, Glide, Pluck, Swell, Gate, and Pulse;
- routable parameters show LFO 1, LFO 2, ADSR, and AR.

Selecting a modulation source temporarily makes row 14 the signed amount lane.
Pressing the source again returns row 14 to the step value. Configured sources
remain medium-bright, the selected source is bright, and pressing its lit amount
again clears the route. This folds the new modulation matrix into the persistent
inspector instead of requiring a second hold-only overlay.

## Universal Delete modifier

There is no general Delete modifier in the current Sequence layout. Row 16,
column 12 is Shift; column 16 exits; contextual clears and bar removal currently
use several unrelated column-16 or double-press gestures.

Use the currently free **row 16, column 15** as a momentary Delete modifier:

- Delete + step clears the complete step: cut, locks, probability, and
  condition.
- Delete + parameter value clears that parameter from the selected step.
- Delete + modulation source clears that target-wide route.
- Delete + bar removes the bar only in Pattern context, retaining the existing
  safety confirmation initially.

The separate Trigger control removes only the cut and deliberately preserves
locks. That distinction makes trigless locks possible while Delete means
exactly “erase the thing I am pointing at.” Delete should never act on a target
or whole pattern without an additional confirmation gesture.

## Pattern context

An always-visible inspector displaces the current always-visible length/bar and
transport rows. A Pattern tab can reproduce them contextually:

- row 14: 16/32/48/64 length, bars 1–8, previous/next, add/remove;
- row 15: Run, Live Record, Restart, Stop, and clear viewed bar;
- Shift + any step: exact 1–64 endpoint, unchanged from today.

Pattern playback remains available from the mode-2 group/track Run shortcuts,
so moving these detailed controls behind one context does not hide the primary
performance gesture.

## Implementation status

Completed in this pass:

- per-target runtime edit cursors and an always-visible Slice-first inspector;
- non-destructive existing-step selection, separate Trigger, and universal
  Delete combinations for steps, values, routes, and confirmed bar removal;
- held Slice audition with a matched release gate;
- Live Write to the playing bar/step using the same Slice lane;
- contextual Pattern length, bars, transport, and clear controls;
- inline target-wide Filter routing for LFO 1, LFO 2, ADSR, and AR with signed
  depth, persistence, native signal generation, and HUD feedback.

Still pending is the hardware play test in brightness-only mode. Source rate,
polarity, envelope-time controls, activity animation, and additional
destinations remain follow-on modulation work rather than blockers for this
interaction pass.

## Acceptance checks

- Opening a target shows Slice for a selected step without starting playback.
- Existing steps can be selected repeatedly without losing triggers or locks.
- Slice press auditions immediately, release ends the audition, and the saved
  step plays the same position later.
- Live Write records at the playhead rather than overwriting the edit cursor.
- Trigger-off preserves locks; Delete+step removes the complete step.
- Shift exact length, bars, Run/Stop, sample browser, target jump, and exit all
  remain reachable.
- Modulation routes remain target-wide and survive sessions, while step edits
  remain step-local.
