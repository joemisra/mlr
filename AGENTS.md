# MLR Repository Instructions

## Validation

- Run `npm test` after JavaScript, session, HUD, grid-routing, or Max topology changes.
- Run `git diff --check` before handing work back.
- Validate edited `.maxpat` files with `jq empty <file>`; avoid formatting or
  mechanically rewriting unrelated patch JSON.
- Distinguish unit/topology verification from a live Max/grid test. Do not claim
  hardware or dialog behavior was verified unless it was exercised in Max.

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
