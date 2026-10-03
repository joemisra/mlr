# Scenes, group patterns, and Track Slots

Updated 2026-08-24. Grid coordinates are one-based.

Scene view is optimized for building a song with one-tap performance actions.
Its durable libraries are independent:

- A **group pattern** is reusable ṛta programming for one of eight groups.
- A **Track Slot** stores all 16 tracks: sample and group assignments,
  loop-region and playback-loop/one-shot state, pitch/reverse/random settings,
  the 16 track phrases, and track-scoped modulation.
- A **Scene** stores eight group-pattern references, their Run states, and one
  concrete Track Slot reference.

A Scene references a Track Slot; it does not own one. Several Scenes may share
one Slot intentionally, and changing a Scene's reference never renames, moves,
or overwrites the Slot.

## Grid map

| Area | Action |
|---|---|
| Row 1, columns 1–16 | Tap a stored Scene to launch it; tap an empty Scene to capture the current performance |
| Rows 2–9, columns 1–12 | One group per row; tap one of its 12 pattern slots, and an empty slot forks the live pattern |
| Rows 2–9, column 13 | Run/stop that row's group pattern |
| Row 10, columns 1–16 | Directly select Track Slots 1–16; an empty Slot clones the current Slot |
| Row 11, columns 1–3 | Global Start / Stop / Reset |
| Rows 12–15, columns 1–16 | Edit the focused group's current 64-step bar |
| Row 16, columns 1–3 | Sequence / Setup / Scene |
| Row 16, column 12 | Shift |
| Row 16, column 16 | Exit ṛta |

Shift + Scene selects a stored Scene without launching. Shift + empty pattern
creates a blank pattern instead of a fork. These are advanced construction
gestures; ordinary capture, launch, pattern selection, Run, and Track Slot
selection require no modifier. Touching a pattern row also focuses that group,
so the four step rows immediately follow the pattern being constructed. The
dedicated Sequence view remains available for bar structure, locks, rates, and
the rest of the pattern tools.

Scene, group-pattern, and track-phrase Preview launches start global transport
without a modifier. Global Stop is a performance pause: it freezes the ṛta
clock, cancels armed sequencer cuts, stops sequencer-owned players, and releases
runtime modulation, but leaves group Run latches intact. Start resumes those
latched patterns from the frozen phase. Turning off the final running group (or
finishing the final one-shot Preview) stops global transport automatically;
ordinary manual sample cuts do not start it.

## Write-through editing

There is no Store step in the ordinary workflow:

- selecting a group pattern immediately updates the active Scene reference;
- changing a group's Run state immediately updates the active Scene;
- track edits immediately update the currently active Track Slot;
- track-scoped modulation immediately updates that Track Slot;
- row 10 immediately updates the active Scene's Track Slot reference when its
  switch commits.

Pattern objects are edited through their library references, so Sequence edits
are already durable in the selected pattern. Session dirty state follows these
mutations automatically.

## Empty-slot creation

Tapping empty Scene N captures the live group combination without interrupting
audio. If Track Slot N is also empty, it is initialized as a clone of the
current Slot and the new Scene references it. If Track Slot N already exists,
capture clones the current Slot into the next empty Track Slot instead. This
keeps new Scenes independent by default without adopting or overwriting an
unrelated Slot. Row 10 can still link two Scenes to one Slot deliberately.

Tapping an empty Track Slot on row 10 clones the current Slot, selects the new
clone, and updates the active Scene. High Scene and Track Slot indexes remain
sparse: creating Scene 16 or Track Slot 16 does not materialize slots 2–15.

## Launch timing and minimal application

Scene and Track Slot launches queue to the next 64-step boundary while transport
and a group pattern are running. While transport is stopped, the same actions
commit immediately rather than waiting on a frozen clock. Tapping the same
queued target again moves it to the next step. A launch commit compares the
audible performance with the destination:

- an unchanged group-pattern reference with the same Run state keeps its phase;
- only changed groups stop, replace, or start;
- a Scene using the current Track Slot performs zero track recalls;
- a different Track Slot applies only tracks whose durable values differ;
- track modulation is reapplied only when its Track Slot state differs;
- only active track previews/phrases are stopped when phrase aliases change.

The boundary is serviced by the audio-derived `sequence64_pulse`; no JavaScript
timer or second musical clock is introduced. The native audio trigger bridge
continues to release sequenced cuts.

## Brightness contract

Standard 0–15 brightness is the complete interface. Optional color is never
required to operate Scene view.

- Scene row: active and playing pulses 15 ↔ 8 once per beat; active but stopped
  is 15, selected is 10, stored is 4, empty is 2, and queued is 15 ↔ 3.
- Pattern cells: running pulses 15 ↔ 8 once per beat, selected/stopped is 10,
  stored is 6, and empty is 2. The separate Run control stays steadily latched.
- Track Slot row: 15 active, 8 stored and shared by multiple Scenes, 4 stored,
  2 empty, 15 ↔ 3 queued.

Scene installs a Role palette when optional color is enabled, then sends State
and Motion modifiers to the matrix bridge. Each group row keeps its group hue;
selected/active cells brighten toward white; shared Track Slots add violet;
playing cells receive a brief Motion-layer dim on the beat; queued cells add
amber; and the embedded steps retain trigger, gate, lock,
playhead, and decision semantics. Those decorations never alter the canonical
brightness frame or the meaning of any cell.

## Sessions and migration

Session format version 4 stores the Scene library, group/track pattern library,
independent `trackSlots`, and concrete `trackSlotRef` values under
`rta.sceneState`. Versions 1 and 2 migrate their aliases into Scene 1. Version 3
`trackSets` and `trackset:*` pattern references migrate to canonical Track Slots
without losing shared references or programming. Session open still preflights,
stops runtime ownership, restores durable state, and does not start playback.

The sample bank may contain up to eight scanned folders. Its catalog remains
append-only during folder additions/rescans, so existing Track Slot sample
indices are stable. The Slot schema also preserves an optional `sampleRef`
field for a path/folder-stable identity as that resolver is completed.

## Next state-history phase

Undo/redo and Locks are deliberately separate from write-through persistence.
Undo/redo will be a short in-memory transaction history. Locks will be explicit,
session-persisted snapshots of the durable musical graph and will restore
through the same diff engine; they will not capture playheads, held notes,
transport ownership, hardware state, or display caches.

## Live-test checklist

Use `mechatrellis 0` and `editorColors 0` for the baseline Kero build.

1. Capture an empty Scene and confirm audio does not restart.
2. Randomize samples in two newly captured Scenes and confirm each Scene recalls
   its own Track Slot without pressing Store.
3. Change a pattern and Run state, switch away and back, and confirm both recall
   without pressing Store.
4. Tap an empty row-10 cell, edit a track, and confirm only the new Track Slot
   changes.
5. Switch between two Scenes sharing a Track Slot and confirm no sample menus or
   track recalls fire.
6. Switch to a different Track Slot and confirm only changed tracks are applied.
7. Keep one group pattern unchanged across a Scene change and confirm its phase
   is continuous.
8. Save, restart Max clean, open the session, and confirm Scenes, Track Slots,
   shared references, patterns, and samples return while playback stays stopped.
