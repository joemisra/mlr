# Separate MLR and ṛta projects

The integrated source remains the development checkout. The edition builder
creates independent Max projects from explicit manifests in `editions/`.
Both projects reuse reviewed source files; neither needs the other project's
entry patch or the source checkout on Max's search path. Separate Git
repositories have not been created.

## Build and open

```sh
node scripts/build_editions.js mlr /tmp/mlr-project
node scripts/build_editions.js rta /tmp/rta-project
```

Choose fresh output directories. Open `mlr.maxproj` or `rta.maxproj`, then its
entry patch if Max does not open it automatically. Save and close any existing
MLR, ṛta, or integrated patch first. Max may restore windows from its previous
run; check Window before testing. Run one edition per Max process because the
inherited named audio and control buses are shared.

MLR opens `_mlr.maxpat` with a companion HUD. ṛta opens `_rta.maxpat`; its HUD,
clock, master level and audio switch are the front panel. `rta_engine.maxpat`
and the instrument lab are already instantiated. Do not open duplicate
engine or lab instances. Max 9, V8, Node for Max and the existing serialosc OSC
externals are host requirements; ṛta also requires RNBO.

MLR retains sample cutting, groups, the original pattern recorders, capture,
sample folders, strips/racks, modern sessions and grid recovery. Its product
identity prevents sequencer entry, launches, scenes, instruments and
sequencer modulation. Its Mod page retains group latches and track loop
division. ṛta owns the sequencer, parameter locks, scenes, track slots,
modulation and RNBO instruments. The sample parameter-page knob and knob-to-
lock work preserved in `469959f` belongs to ṛta's sample page. The native
sequencer and firmware experiments remain development artifacts.

Both bundles default to ordinary 0–15 brightness with MechaTrellis colors,
editor colors and CV pulses disabled. Local workstation preferences are not
copied. Development MCP helpers and Socket.IO dependencies are excluded.
Legacy recorder references are normalized to `.maxpat`; opaque binary
patches receive explicit `.mxb` filenames and their reviewed dependencies.

## Session boundary

MLR saves `mlr-base-session` version 1 inside a `.mlr-session` folder. It
contains the base sample, mixer, strip, rack and automation state, without
sequencer, modulation or instrument programming. MLR rejects full integrated
or ṛta documents during preflight, before applying state.

Ṛta imports base MLR sessions and existing integrated versions 1–4. Saving in
ṛta produces `mlr-session` version 4. Use Save As after importing an MLR bundle
if the original must stay usable in MLR. Both restore stopped; grid layout,
playheads, display caches and local preferences remain outside session files.

## Verification on 2026-10-03

- 440 automated tests pass, including isolated MLR module loading, disabled
  sequencer command paths, HUD pages, edition dependencies/topology, base
  session round-trip, ṛta import and full-session rejection.
- Both generated projects opened in Max 9.2. The MLR HUD showed only its five
  base pages. The rebuilt ṛta entry displayed its clock and HUD, and saved a
  valid full version 4 session through its own Session page.
- Live startup exposed missing legacy recorder/fade/MIDI dependencies and a
  clock viewport offset; these were corrected in the builder and covered by
  automated assertions.
- The isolated MLR Save As check did not complete after an interrupted dialog.
  Earlier mixer gestures were exercised with a restored integrated patch also
  present, so they are not counted as isolated product verification.
- Physical MIDI knobs, grid gestures, audio playback, stopped reopen and close
  teardown have not been verified for the final bundles. The inherited
  optional `link.session` object reported unavailable on this Max installation;
  the internal tempo and session save were exercised.

These packages are review/test builds. Automated checks and a startup/save
smoke test do not establish hardware or complete live session behavior.

## Remaining live smoke test

1. Start MLR alone. Confirm its six HUD pages (including Phase), group volume/mute, sample
   assignment/cutting, capture, original pattern recorders and Mod controls.
2. Save a base session, change state, reopen it and confirm restored state with
   transport stopped. Try a full ṛta session and confirm rejection without
   changing the current MLR state.
3. Close MLR and start ṛta alone. Open the base session, confirm stopped import,
   and Save As a full session. Confirm the sample and RNBO paths both play.
4. Focus ṛta's sample parameter page. Check pickup, visible knob order,
   baseline edits, held-step locks and incoming-step live locks. Repeat after
   changing target and page; stale controller batches must not apply.
5. Save before closing. Verify preview, sequencer ownership and audio stop on
   teardown. Repeat startup after a Max restart without restored duplicates.

## Package

After committing a clean tracked worktree:

```sh
scripts/package_release.sh all
```

The script tests, builds both manifests, parses generated patches and writes
ZIPs with SHA-256 checksums under ignored `release/`. Each project includes
`START-HERE.md`, this file as `SPLIT-NOTES.md`, build hashes, source commit and
file checksums. Sample audio is included only if a local `samples/` directory
exists. No remote publishing or repository push is part of packaging.

Original MLR GPL v2 attribution remains in `license_mlr.txt` and `mlr_info.txt`.
Installed RNBO/export licensing remains separate.
