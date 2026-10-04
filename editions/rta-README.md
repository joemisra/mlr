# ṛta · ऋत

Open `rta.maxproj`, then `_rta.maxpat` if needed. The HUD is the main application
window. This project owns its hidden `rta_engine.maxpat`, one clock, the sample
bank, plugin/session services, grid routing, and the eight RNBO instruments.
It runs without opening `_mlr.maxpat` or adding the source repository to Max's
search path. Use a current Max 9 installation with V8, Node for Max, and RNBO.

The top panel provides the existing tempo/transport controls, an Audio toggle,
a master fader, and access to the instrument controls. Audio starts off.
The eight instrument tracks (visible tracks 8–15) default to groups 8–1:
Bass, Bell, Rim, Tom, Clap, Hat, Snare, Kick. Sample-track defaults are retained.
Saved sessions restore their own assignments. Group patterns remember the last
track you chose for newly inserted steps, including after save/open.

Use **GRID COLOR ON/OFF** on Live or Colors to enable MechaTrellis hardware
colors. The choice is saved in `mlr.local.json` beside the patch and applies at
next startup. Turning it off restores a neutral palette and standard brightness.
New builds default to color off; this workstation preference is outside sessions.

Raise the appropriate group levels from HUD → Strip (Group Volume) before
expecting playback. The HUD pages expose patterns, strips/racks, samples,
sessions, grid monitoring, and help. Close the entry window only after saving;
its close handler stops runtime ownership, sample preview, and audio.

`rta_engine.maxpat` is the supporting engine, not another patch to open as a
second instance. The instrument window is also already instantiated: use the
entry window's instrument button rather than opening a duplicate drum lab.
The optional native sequencer external and firmware build/export experiments
are development artifacts and are not included in this project.

Existing integrated version 1–4 `.mlr-session` bundles migrate and restore
stopped. Base MLR bundles (`mlr-base-session`, version 1) can be imported; saving
in ṛta creates the full version 4 format. Use Save As when importing a base MLR
session if you want it to remain usable in MLR. Hardware preferences and grid
layout remain local, outside session documents.

Use your own sample folders, or relink missing files from the Session page.
Brightness-only grids remain fully supported. The build defaults to ordinary
monome settings and disabled CV output. Private MechaTrellis colors remain an
explicit workstation choice.

Save and close any existing MLR/integrated patch before opening this project.
Run one edition at a time in a Max process because inherited named buses are
shared. The automatic checks cover source, topology, and host behavior; live
Max/grid/audio validation is still necessary on your rig.

See `SPLIT-NOTES.md` for validation results and the remaining live smoke test.
See `sequence64_editor_reference.md` for the grid gestures. MLR GPL v2
provenance remains in `license_mlr.txt` and `mlr_info.txt`; RNBO remains subject
to its own installed runtime/export licensing.
