# MLR

Open `mlr.maxproj`, then `_mlr.maxpat` if the entry window is not already open.
This is the focused sample-cutting edition. Max 9 with V8 and Node for Max is
required by the current code. Connect the grid through serialosc, load samples,
assign rows, raise group/master levels, and enable audio when ready.

Main, Mod, Groups, and the four original pattern recorders remain. The sample
browser, sample folders, capture/export, channel strips/plugin racks, session
save/open, and grid recovery improvements are retained. HUD opens a companion
window for Live, Strip, Samples, Session, and Help.

On Mod, row 5 columns 1–8 toggle group gate latches; column 12 cycles each
track's loop division. Column 9 opens the sample browser on a tap or randomizes
on a hold. Column 10 controls track capture. Grid coordinates are one-based.
There are no sequencer view buttons, phrase launches, instrument engines, or
sequencer modulation in this edition. `extendedEditors 1` cannot enable them.

Save and open modern sessions from HUD → Session. New bundles use the
`mlr-base-session` format inside the existing `.mlr-session` folder extension.
They restore stopped. ṛta can import these bundles. Full integrated/ṛta sessions
are rejected before MLR changes state, so their programming is never silently
lost. Keep those sessions for ṛta; do not edit their format field to force them
into MLR. The older MLR preset controls remain separate from modern sessions.

No audio samples or local hardware preferences are required in Git. Use your
own sample folders or a packaged `samples/` folder. Missing source paths must
be relinked from Session. Plugin availability remains specific to your machine.

Brightness 0–15 carries all grid state. This build defaults to
`mechatrellis 0`, `editorColors 0`, and CV pulses off. The example local settings
are also safe for ordinary monome hardware.

Open one edition at a time in a Max process: the inherited named audio/control
buses are shared. Save before closing an existing patch. Never open this
project alongside the integrated development patch or ṛta.

Automated checks do not certify physical grid, audio, or Max dialog behavior.
`SPLIT-NOTES.md` gives validation results and the remaining live smoke test.
MLR's original GPL v2 attribution and license are retained in `mlr_info.txt`
and `license_mlr.txt`.
