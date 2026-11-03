# LiveCut group insert trial (superseded)

The group shortcut now controls native [Phase Cut](phase-cut.md). The notes
below record the earlier LiveCut trial; its shortcut and routing claims describe
that trial, not the current build. LiveCut can still be loaded manually through
Strip → Rack, and the optional build script remains available.

## Build and install

`scripts/build_livecut.sh --install` builds the scheffle LiveCut VST3 port for
the current Mac architecture and installs it into the user's VST3 folder.
It refuses to overwrite an existing installation. Run without `--install` to
build only. Sources and outputs remain in ignored `release/livecut/`.

Requires Git, Python 3, CMake, Apple's command-line compiler and macOS SDK.
The script pins LiveCut commit `ce00c216a5a974962163fbd5d4c465248dceac23`,
Steinberg SDK `v3.7.4_build_25` and VSTGUI `vstgui4_11_2`. Compatibility edits
allow command-line-tools builds, add a missing C++ standard header and keep
old GUI warnings from becoming compiler errors. DSP algorithms are unchanged.
The build runs the SDK validator and uses a local ad-hoc code signature.
Upstream sources/licenses remain alongside the build; this is a local audition,
not a bundled third-party plugin in MLR release archives.

Sources: [LiveCut port](https://github.com/scheffle/Livecut),
[VST3 SDK](https://github.com/steinbergmedia/vst3sdk),
[VSTGUI](https://github.com/steinbergmedia/vstgui).

## Play

1. Save your current MLR session before any patch reload. For a clean first
   trial, reopen MLR after saving so all rack/router scripts share fresh state.
2. In mode 2, press **row 6** under a group column (columns 1–8), immediately
   below the group latch in MLR or pattern Run in ṛta. First press loads LiveCut into the first empty
   rack slot. A full rack reports a notice instead of replacing an effect.
3. Start a loop/pattern in that group. Press the same button to turn cutting
   off/on with a 15 ms fade. This is an immediate performance toggle, not a
   beat-quantised toggle. LiveCut does the musical cut timing in native DSP.
4. Open **Strip → Rack**, select the group and use the LiveCut slot's **Open**
   control for its parameters. If Max cannot resolve the newly installed
   plugin, use Max's Plug-in Browser Full Scan, then HUD Refresh and retry.

Brightness: 0 = no LiveCut assigned; 3 = loaded but dry; 6 = loading/unavailable;
15 = loaded and active. HUD rack status distinguishes loading from errors.
The sample-browser overlay retains ownership of its own keys; ṛta's Scene
overlay does too.
For MLR edition the row sits below the group latch; for ṛta it sits below Run.

The shortcut controls the first LiveCut instance in the group's rack, follows
reordering, and reflects rack/HUD/session state. Loading more than one instance
is possible through the rack, but only the first gets this shortcut.
Enable/bypass and parameters use existing rack/session persistence.

LiveCut bypass is deliberately an external dry/wet fade: its DSP continues
running and consumes CPU while off, keeping input history current. Other
plugins still suspend on bypass. Avoid LiveCut's own Bypass parameter for this
workflow because the upstream processor skips its capture engine in that mode.
All tracks assigned to a group share its capture history. Track changes can
therefore carry fragments of the previous track, as with a delay tail.
Per-track random-position jumping has not been replaced.

## Verification and remaining listening checks

The native arm64 graphical build passed the SDK validator: 47 passed, 0 failed.
That establishes basic VST3 conformance, not audible or musical correctness.
Repository tests cover routing, brightness, safe slot allocation, confirmed
bypass state, clear/unassignment and continued processing during LiveCut bypass.

All 455 repository tests passed, including the LiveCut grid shortcut in both
product identities; `git diff --check` passed. Fresh MLR and ṛta
development trial projects were generated in `release/livecut/mlr-trial-v2/` and
`release/livecut/rta-trial-v2/`. These include the new scripts even when the current
Max project is running an older edition copy. Save the active session and close
its project before opening a trial project; do not run both engines together.
The installed plugin's ad-hoc signature was verified.
Every generated `.maxpat` passed `jq empty`; the three shared LiveCut runtime
scripts in both outputs match the expected edition transformation of source.
Product identities, manifests and session
formats remain as defined by the split. The direct RNBO instrument output paths
do not currently enter these sample-player group racks, so this trial does not
apply LiveCut to RNBO audio.

A separate silent Max smoke patch was created, but automation stalled in the
file dialog before plugin load/editor opening could be verified. No active
performance patch was closed or restarted. Max hosting and hardware behavior
remain unverified; SDK validation is not a substitute for that check.

Still audition BPM changes, stopping/restarting, repeated toggles, source-track
changes, silence, session save/open, multiple groups and CPU load. The upstream
VST3 processor leaves transport-change detection as a TODO, so restart alignment
deserves particular attention. The effect reports/uses host tempo and musical
position, but exact phrase reset behavior has not been established here.
Hardware button response and audible quality require a live Max/grid pass.
