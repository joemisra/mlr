# MLR / ṛta split review — 2026-10-03

## Preserved baseline

`469959f` preserves the integrated development snapshot on
`agent/mlr-64-step-locks`. Before this checkpoint, local HEAD and the freshly
fetched upstream branch both pointed to `3dae4f7` (2026-08-10). This repository
has one registered worktree. The newest implementation found here was the
uncommitted working tree, not `master` or the older grid prototype branch.
This is an inventory of this repository, not a search of other projects or
unsaved Max editor buffers.

The checkpoint intentionally preserves the interdependent changes together:
sample banking/capture, session v4, grid/HUD changes, scenes/track slots,
modulation, RNBO instruments, DPT firmware sources/exports, and the native
sequencer experiment. It is a recovery baseline, not a claim that every
experiment is release-ready.

`New Project/` is a separate Max instrument/export project. Its 18 JavaScript
files match their root counterparts byte-for-byte at review time. Preserve it
until its patch/export role is deliberately consolidated. RNBO exports and
bundled vendor sources retain exporter whitespace via `.gitattributes`.
Build products, local hardware settings, sample audio, and the stray compiler
dependency file `firmware/dpt/bank/-g1` remain ignored and present locally.
Git alone does not back up those ignored assets or unsaved Max state.

## Existing disable command: useful, but incomplete

Send `extendedEditors 0` to `s gridrouter` to disable grid editor entry.
`extendedEditors 1` restores entry. The current implementation:

- Sets `editorWorkspace.enabled`, clears the target/editor gestures, stops
  sequencer targets, releases native ownership, and restores owned controls.
- Makes `editorWorkspaceAvailable()` false so normal grid editor entry is
  unavailable. Existing automated coverage checks this entry behavior.
- Does not remove any modules or audio patchers, or change the session schema.
- Is not a durable product setting: initialization defaults to enabled, and
  `mlr_startup.js` does not supply this option.

It is **not a complete ṛta-off product mode**. `hudTarget()` calls
`selectEditorTarget()` without checking enabled, and `hudTransport()` can then
start the target. A read-only Node harness probe reproduced:

```text
extendedEditors(0)              enabled=0 active=false
hudTarget('group', 0)
hudTransport('run')             enabled=0 active=true running=1 transport=1
```

`sequence64SubPulse()` checks layout, not enabled; the clock processor checks
transport and processes pending scene launches. The disable path also needs
an explicit audit of queued scenes, previews, and every non-grid command path.
`editorLayout legacy` selects the older editor prototype; it does not remove
the editor feature. Collapsing the view is also not a disable operation.

No disable command was sent to a live Max patch during this review.

## Proposed ownership after the split

| Area | Focused MLR edition | Separate ṛta project |
| --- | --- | --- |
| Sample cutting, groups, pattern recorders, existing Mod controls | Keep familiar behavior | Reuse the audio/sample engine where needed |
| Serialosc discovery/hotplug, dual-grid routing, redraw recovery | Keep improvements | Share or port fixes |
| Sample folders/browser, assignments, recording capture/export | Keep relevant improvements | Reuse |
| Session save/open, asset relinking, plugin state, stopped restore | Keep, with deliberate schema boundary | Keep full sequencer state |
| Sequence64, locks, scenes, track slots, phrase previews | Remove from runtime/UI | Own here |
| Sequencer modulation, synth labs, native timing experiment | Exclude from initial MLR handoff | Keep as appropriate; firmware is a separate deliverable |
| HUD | Retain only useful MLR controls if desired | Main application page |
| Private semantic colors | Optional; ordinary brightness remains complete | Optional; ordinary brightness remains complete |

Relevant base fixes are mixed into `grid_router.js`, `sample_bank.js`, session
files, `_mlr.maxpat`, `file_list.maxpat`, and player/strip abstractions. Reverting
to `master` or deleting all `sequence64*` files would lose improvements or
break references. The current session core imports scenes/modulation and
requires an `rta` object; version 4 cannot simply become an MLR-only schema by
deleting that field. Define import/preservation behavior before changing it.

## Recommended implementation sequence

1. Branch both editions from the preserved integrated baseline. Keep this
   checkpoint reachable while extracting dependencies.
2. Implement a tested MLR product mode: startup default, grid and HUD entry
   guards, sequencer launch/clock guards, and cancellation of queued work and
   owned playback. Keep base MLR transport and pattern recorders independent.
   Verify disable while running, pending launches, session open, and JS reload.
3. Produce a minimal `_mlr.maxpat` topology and release manifest containing
   only the MLR runtime dependencies. Keep sample/session/grid improvements.
   Use `mechatrellis 0` and `editorColors 0` for the Kero test handoff.
4. Give ṛta its own entry patch and project identity. Promote `hud.maxpat` to
   the main window, with explicit ownership of audio, transport, sessions,
   sample bank, racks, grid routing, and teardown. The current HUD is an
   embedded controller talking to MLR buses, not a standalone engine host.
5. Once each edition starts independently, separate repositories if desired
   and document how shared fixes move between them. Retain the MLR GPL/license
   provenance and RNBO export licensing notices.

The user's requested small MLR additions still need to be enumerated; they are
not inferred from the larger ṛta feature set. The split itself was reviewed,
not implemented in this checkpoint.

The existing release script archives all tracked files before pruning a fixed
development list. Now that the experiments are committed, it would include
extra lab/export/firmware sources. Do not treat its current output as the
focused MLR handoff; use an explicit edition manifest when implementing that
release. No release bundle was generated during this review.

## Verification of the checkpoint

- `npm test`: 431 passed, zero failed/skipped.
- `jq empty`: all 47 changed/new `.maxpat` files passed.
- C++17 native sequence-player core tests: passed, including allocation,
  publication, cancellation, phase, reset, and concurrent preparation checks.
- DPT `build.py --midi-test`: host MIDI/CC/velocity/note-off/pitch/FIFO checks
  passed. No firmware flashing or full firmware rebuild was performed.
- Staged and working-tree `git diff --check`: passed, with generated/vendor
  RNBO whitespace excluded by the documented attributes.

These are unit, topology, parsing, and host checks. Max dialogs, actual audio,
physical grids, firmware behavior, and unsaved Max state were not exercised.
