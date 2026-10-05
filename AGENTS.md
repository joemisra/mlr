# MLR Repository Instructions

## MLR and ṛta separation

This repository is the **shared source checkout for two separate Max
products**, not a single MLR product with an optional sequencer. Read
`docs/mlr-rta-split.md` before changing product boundaries, startup, packaging,
or session compatibility.

- **MLR** is the focused sample-cutting product: groups, original pattern
  recorders, sample folders/browser, capture/export, channel strips/plugin
  racks, modern sessions, and grid recovery. Do not add ṛta navigation,
  sequencing, locks, scenes, instruments, or sequencer modulation to its UI
  or runtime. Shared base fixes should remain available to MLR.
- **ṛta (RTA / Sequence64)** owns the sequencer, parameter locks, scenes,
  track slots, modulation, and RNBO instruments. Its generated `_rta.maxpat`
  is the main entry, with the HUD as the front panel. `rta_engine.maxpat`
  and the instrument lab are supporting instances, not additional patches
  to open. The sample-page knob/lock workflow belongs to ṛta.
- The root `_mlr.maxpat` and `mlr_product.js` remain the **integrated
  development environment**. Opening that root patch is not testing the
  focused MLR product. The builder sets an immutable product identity in
  each output; local preferences and session documents must not override it.
- `scripts/build_editions.js` creates self-contained Max projects from
  `editions/mlr.json` and `editions/rta.json`. MLR opens `mlr.maxproj` /
  `_mlr.maxpat`; ṛta opens `rta.maxproj` / `_rta.maxpat`. Edit shared source,
  the builder, and the appropriate manifest, then rebuild into fresh output
  directories. Do not fix generated copies under `release/` as source.
- These are separate product builds, **not separate Git repositories**.
  Inspect current HEAD and working-tree changes before continuing. The
  split was implemented in `1dc2524`; `469959f` is the preserved integrated
  baseline. `agent/rta-standalone` was created at that baseline and is not
  evidence of the newest ṛta implementation. The earlier
  `docs/mlr-rta-split-review.md` records pre-implementation findings, not
  current runtime behavior.
- MLR writes `mlr-base-session` v1; ṛta writes `mlr-session` v4. Both use the
  `.mlr-session` folder extension and restore stopped. ṛta imports base MLR
  sessions and integrated v1–4 sessions. MLR rejects full ṛta sessions at
  preflight rather than silently discarding programming. Preserve this
  boundary unless the user explicitly requests a migration design.
- Run one edition per Max process: inherited named audio/control buses are
  shared. Account for unsaved state and restored windows before live tests.
  Keep validation claims aligned with the checks actually performed; the
  remaining live checks are listed in `docs/mlr-rta-split.md`.

## Validation

- Run `npm test` after JavaScript, session, HUD, grid-routing, or Max topology changes.
- Run `git diff --check` before handing work back.
- Validate edited `.maxpat` files with `jq empty <file>`; avoid formatting or
  mechanically rewriting unrelated patch JSON.
- Distinguish unit/topology verification from a live Max/grid test. Do not claim
  hardware or dialog behavior was verified unless it was exercised in Max.
- For shared runtime, dependency, or builder changes, verify both generated
  editions. Keep explicit manifests complete without including lab exports,
  firmware builds, or development-only dependencies in the MLR handoff.

## Runtime invariants

- Standard 0–15 brightness is the complete grid state. Semantic color is an
  optional decoration and must never be required to understand or operate MLR.
- Kero test builds use `mechatrellis 0` and `editorColors 0` unless explicitly
  testing the private color extension.
- Session open preflights before apply, stops transport/runtime ownership, and
  restores durable state without automatically starting playback.
- Hardware layout, transient playheads, display caches, and local workstation
  preferences do not belong in session documents.
- Keep native/audio-timed work out of low-priority JavaScript when timing is
  musically consequential.

## Working references

- `sequence64_editor_reference.md` describes the current ṛta grid model.
- `grid_routing_reference.md` describes grid input, rendering, and ownership.
- `docs/modulation-roadmap.md` describes the modulation and portable ASL plan.
- `scripts/package_release.sh` is the release path; it requires a clean tracked
  worktree and produces a ZIP plus SHA-256 checksum under ignored `release/`.

## Max reload boundary

V8 scripts with autowatch may reload in place. Changes to the Node session
manager require the session service/patch to restart before live testing. Do not
close or restart an active Max patch without accounting for unsaved state.
