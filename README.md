# mlr

A live sample-cutting platform for the Monome Grid 256, running in Max 8 with serialosc.

Originally by Brian Crabtree (monome.org, 2006), with major modifications by Joseph Melnyk
(8 channels, 4 pattern recorders, mod page, session slots, input buffers, and more — see
`mlr_info.txt` for full changelog). Updated for serialosc + Max 8 compatibility.

Licensed under GPL v2 (see `license_mlr.txt`).

## Quick Start

1. Open `_mlr.maxpat` in Max 8
2. Connect your Monome Grid 256 via serialosc
3. Drop audio files onto the file drop area
4. Assign files to rows, push up group volume + master volume, turn on DAC
5. Press keys on the grid to cut and remix

For full operation details, see `mlr_info.txt` (opens from within the patch via the info button).
The new lower-half sequencer is named **ṛta (ऋत)** and is documented in
`sequence64_editor_reference.md`. `Sequence64` remains its internal identifier
for saved state, messages, filenames, and compatibility with existing sessions.
A printable visual cheat sheet is available as
[`docs/mlr-grid-reference.svg`](docs/mlr-grid-reference.svg), with a PNG copy
for quick viewing.

## Developer Tooling

### MechaTrellis color and 8-bit LED helpers

`grid_router.js` exposes private MechaTrellis LED commands through the existing
`gridrouter` message bus. Persistent color helpers do not change a cell's
legacy brightness or state, so the existing mlr drawing and animation paths
continue to use their standard 0–15 levels.

Private commands are blocked by default. Enable them only for MechaTrellis:

```text
mechatrellis 1
```

Send these messages to `s gridrouter` (or directly to `grid_router_io`):

```text
colorCell x y r g b
colorMap x y r0 g0 b0 ... r15 g15 b15
colorAll r g b
colorRow y r g b
colorCol x r g b
colorRect x0 y0 x1 y1 r g b
applyPageColors [page]
storeColorPreset slot
recallColorPreset slot
initializePageColorPresets
autoPageColors 0|1
```

`colorMap` assigns a row-major 4×4 block while leaving all legacy LED levels
unchanged. Enabling MechaTrellis mode uploads the currently visible page as 16
paced maps. Page changes directly upload the new page palette; automatic color
handling does not depend on volatile firmware preset slots. Their RGB values
live in `PAGE_COLORS` and `GROUP_COLORS` near the top of `grid_router.js`.

Send `autoPageColors 0` to keep manual colors across page changes, or
`applyPageColors 1` through `applyPageColors 3` to upload one page.
`initializePageColorPresets` remains as a compatibility message, but now simply
invalidates remembered preset status and resends the visible page or sample
browser. Maps are paced at 8 ms so they do not crowd standard LED frames out of
serialosc's nonblocking serial connection. `storeColorPreset` and
`recallColorPreset` remain available only for deliberate manual use.

The current private color extension is write-only: firmware returns no reply
for maps, colors, or preset recalls. MLR can therefore record the complete
Max-side requested state and packet counters, but it cannot truthfully read the
LED/palette state back from the device. Actual firmware verification would
require a coordinated firmware, libmonome, and serialosc protocol extension;
ordinary monome/old-serialosc operation remains untouched here.

The remaining private commands are also available when direct 8-bit control is
needed:

```text
rgbCell x y r g b
rgbAll r g b
level8Cell x y level
level8All level
intensity8 level
```

Unlike `colorCell` and `colorAll`, the RGB and level8 commands intentionally
change LED output state. Values are clamped to 0–255 by both mlr and serialosc.

### Mode 2: 16×16 arrangement and phrase editor

Grid positions below are one-based. The top grid row is row 1. This workspace is
opt-in: until a target is selected, the existing main and mode-2 controls behave
exactly as before.

On a 16×16 grid, hold mode-2 row 1 column 14 to open the target chooser:

- Row 1, columns 1–8 select groups 1–8.
- Column 16, rows 2–16 select tracks 1–15.
- The chooser owns those cells only while column 14 is held, so target selection
  cannot mute a group or toggle a track's reverse state.
- Keep holding column 14 to change targets quickly. Selecting the current target
  cancels it; releasing column 14 always hides the chooser.
- A selection is silent and persists when switching between mode 2 and the main
  page. Press row 16 column 16 in the editor to exit completely.

The lower half has two views. Row 16 column 1 selects **Sequence**, column 2
selects **Setup**, and column 16 exits.

#### Sequence view

| Grid cells | Function |
|------------|----------|
| Rows 9–12 | Viewed bar: steps 1–16, 17–32, 33–48, and 49–64 |
| Row 13, columns 1–4 | Hold to set viewed-bar length to 16 / 32 / 48 / 64 |
| Row 13, columns 5–12 | Tap to select/add a bar; hold bar N to set the pattern to N active bars |
| Row 13, columns 13–14 | Previous / next bar |
| Row 13, column 15 | Add and select a bar, up to eight |
| Row 13, column 16 | Remove the viewed bar; press twice within 1.2 seconds |
| Row 14, column 1 | Group target: Run/Stop. Track target: one-shot Preview/Stop |
| Row 14, column 2 | Tap to latch/unlatch parameter-lock recording |
| Row 14, column 3 | Restart at step 1; also starts playback when stopped |
| Row 14, column 4 | Deliberately stop this pattern/phrase and release its runtime locks |
| Row 14, column 16 | Clear the viewed bar; press twice within 1.2 seconds |
| Row 15 | Playable 16-slice lane for the selected/current track; the bright cell follows live position |
| Row 16, column 12 | Hold Shift: steps set an exact 1–64 length; row 14 columns 1–9 select pattern rate |
| Row 16, column 13 | Open/close the split sample browser while leaving ṛta available below |
| Row 16, column 14 | Jump group → current/last track, or track → its assigned group |

The row-15 lane uses the ordinary MLR track input plus the immediate player
trigger, so it auditions reliably before Run is engaged and in a freshly opened
editor. Running Sequence64 cuts instead arm the native audio bridge and are
released on the following raw clock boundary. Its predicted marker replaces any stale
playback position immediately, then the normal DSP callback takes over. Tap row
14 column 2 to latch Record, then play the lane to write each cut into the
Sequence64 step currently under the playhead. Tap Record again to stop. For a
group target, the cut stores the exact resolved track as well as the slice.

A new group pattern stays empty, but resolves a playable default track without
prefilling any steps. It uses the group's current active track first, then its
last active track, then the lowest-numbered track assigned to the group. If the
group has no assigned tracks, its steps and live lane report that they are
waiting for a track. Cuts whose Track value is inherited follow the saved group
default; cuts with an explicit Track play only while that track is still
assigned to the group.

The Sequence clock receives one phase-locked `sequence64_pulse` per step from
`time.maxpat`. It uses `rate~ 0.125 @sync lock` and both ramp edges to produce
16 steps per quarter note (64 per 4/4 bar). This is 16 times the quarter-note
`tr_pulse`; JavaScript no longer schedules or catches up intermediate steps.
Because Max V8 always runs at low priority, `grid_router.js` only arms a cut.
`sequence64_audio_bridge.maxpat` stores one pending cut per group and the next
raw audio-derived pulse performs track press → player trigger → release with
native Max objects. Manual and live-lane cuts remain immediate. Its four
16-step parts are already visible together on rows 9–12; those rows are four
quarters of one bar, not four independent pattern passes.

Every group pattern and track phrase defaults to the same 1× clock. Merely
opening or switching the editor target cannot change another pattern's phase or
rate. To choose a saved per-pattern rate, hold Shift at row 16 column 12 and tap
row 14 columns 1–9 for 1/4×, 1/3×, 1/2×, 2/3×, 1×, 3/2×, 2×, 3×, or 4×. A live
rate change preserves the current playhead; faster rates service every crossed
step rather than skipping events. Parameter shapes follow the owning pattern's
rate.

Group patterns are the looping arrangement and start with one 64-step bar.
Track patterns are reusable sound-design phrases: they start empty at 16 steps
and run once whenever that track is cut from its group pattern. Up to eight bars
can still be added to either kind of pattern. The selected bar button is
bright; while Run is active, a different playing bar is shown at an intermediate
level. Tap an existing bar to view it, or tap the first inactive bar to add it.
Hold any of the eight buttons for about 350 ms to set the total active length to
that many bars. Shortening parks trailing bars instead of erasing them, so
holding a longer length later restores their data. Changing the viewed bar does
not interrupt playback. Changing a bar's step length, adding/removing a bar, or
changing the active bar count also leaves Run and current audio alone. If the
playing bar and step still exist, mlr rebases that pattern's local phase so its
playhead stays put. If the edit removes the playing bar or shortens it behind
the playhead, that pattern restarts immediately at step 1. Other patterns keep
their own phase. The four row-13 length controls remain quick 16/32/48/64
presets. For an exact endpoint, hold Shift and tap any step in rows 9–12 to set
the viewed bar to 1–64 steps. Existing single-bar patterns remain bar 1.

MIDI- or CV-addressable pattern trigger targets are a future extension only;
this release does not add routing or change existing MIDI/CV behavior.

On mode 2, the group Run row and track Run column are red. Tap one of these
shortcuts to toggle that pattern; hold it for about 350 ms to open that exact
group or track in Sequence64 without changing its Run state.

Tap and release a step to add or remove its cut trigger. Hold a step for about
350 ms to open its lock editor; the editor stays open after release. Click the
selected step again to close it, or click another active step to edit that one.
Clicking an empty step while the editor is open enables its default cut and
moves the editor there. The selected parameter remains latched while moving
between steps, making repeated edits to the same parameter immediate.
The live track-position lane yields to these popup controls while the editor is
open. A slice choice is stored as a lock over the recorded/default cut slice;
clearing that lock reveals the original slice again. Group-pattern Slice values
are absolute. Track-phrase Slice values are offsets added modulo 16 to the group
cut that launched the phrase; during standalone Preview they are offsets from
the track's current slice. Offset 0 preserves the root slice.
The controls are centered on rows 13–15:

| Lock row | Columns |
|----------|---------|
| Row 13 | 5 slice, 6 probability, 7 volume, 8 future filter, 9 reverse, 10 Transpose, 11 loop division, 12 gate length; group patterns show 13 Track and 14 Condition, while track phrases show 13 Condition |
| Row 14 | Value; slice/probability/volume/filter use columns 1–16; for Transpose, columns 1/2 subtract/add a 12-semitone octave inside the selected step lock and columns 3–16 select its −6 through +7 semitone component; division uses 1–8, gate length and Track use positions 1–16; Condition uses Every 2–9 on columns 1–8 and Skip 2–9 on columns 9–16 |
| Row 15 | For volume/filter: 6 Set, 7 Glide, 8 Pluck, 9 Swell, 10 Gate, 11 Pulse; column 16 clears the selected lock |

On the group-only Track row, only tracks currently assigned to the selected
group are lit and selectable. The bright position is the step's explicit Track
or its inherited group default. Choosing a Track creates a default cut if the
step does not already have one. Clearing Track preserves the cut and returns it
to inherited-default behavior. Track patterns remain fixed to their selected
track and do not show this parameter.

Condition is an occurrence lock shared by group patterns and track phrases.
**Every N** plays the step only on visits N, 2N, 3N, and so on; **Skip N** plays
all visits except those multiples. Restart begins again at visit 1. A phrase
launched by a group inherits the parent's visit number, and a failed condition
skips probability, parameter locks, and the cut together. Clearing Condition
returns the step to unconditional playback without changing its other data.
The playhead flashes orange/red for Condition play/skip and yellow/violet for
Probability play/skip. These transient colors also appear in the HUD and are
editable as `rta.conditionPlay`, `rta.conditionSkip`, `rta.probabilityPlay`, and
`rta.probabilitySkip` on the Colors page.

Turning off a cyan/green trigger preserves its parameter locks. A resulting
amber cell is a valid triggerless lock, not a stale LED; a step with neither a
trigger nor locks returns to the neutral color.

Trigger cuts and Set locks are latched. Exiting the editor leaves group Run
latched. A group cut starts that track's phrase at phrase step 1; locks on that
first phrase step modify the same hit, while its Slice offset moves relative to
the group's slice without producing a second hit. Later phrase cuts can
retrigger relative slices. A group retrigger restarts the phrase, and selecting
another track in the same group replaces the previous child phrase because both
share the group player. Track Run controls audition the phrase once and return
to stopped.

A target owns a group player only when it supplied that player's latest
Sequence64 cut. Stopping the owning group halts the player and cancels its child
phrase; stopping an older target, or one superseded by a manual or live-lane
cut, leaves current audio alone. Manual cuts also cancel the child phrase so it
cannot move the live playhead back.

Stop cancels Set, Glide, Pluck, Swell, Gate, and Pulse runtime modulation and
restores the preceding Sequence64 writer or the underlying manual/original
value. Manual edits become the new underlying value. Programmed cuts,
probability, Track choices, shapes, and locks remain saved. `Restore Start
State` additionally returns playback position and supported controls to the
snapshot captured at Run. Reloading the JavaScript or disabling/changing the
editor layout stops all Sequence64 targets as a safety boundary.

Volume locks use the existing per-channel `[gatefx]level` multiplier, leaving
the normal channel-volume control intact. Filter locks already emit the parallel
`N[filterfx]level value ramp-ms` bus. They now close the group channel-strip
low-pass filter while its HUD cutoff remains a manual ceiling. Stopping a target
restores the prior automation owner or manual setting without erasing the lock.

#### Live recording and Setup

With a target selected, return to the main page and hold row 1 column 14 while
performing cuts. The first accepted, quantized `chRowPos` starts a take;
releasing column 14 ends it. The elapsed time is rounded to the nearest 16-step
beat, with a one-beat minimum. mlr automatically creates full 64-step bars plus
a 16/32/48/64-step final bar, up to eight bars. For example, a six-beat take
becomes one 64-step bar followed by a 32-step bar.

The finalized take replaces the target's previous cut triggers while preserving
probability, parameter locks, and gate length at newly recorded positions. A
recorded slice replaces an older slice edit at that position. The take remains
aligned to the global sequence clock, and Run remains explicitly opt-in. A
track target accepts only that track; a group target accepts tracks assigned to
that group and stores the exact played track/slice. A cut sent while record was
held may still commit after release when its quantized position arrives. If no
matching cut arrives during the gesture, the saved pattern is unchanged.

The Setup view consolidates direct controls:

| Row | Function |
|-----|----------|
| 9 | Group assignment/indicator |
| 10 | Channel volume |
| 11 | Pitch: with Record latched, columns 1/2 subtract/add a step-lock octave and columns 3–16 select its −6 through +7 semitone component; without Record, these edit the track-wide octave and Transpose baseline |
| 12 | Columns 1/2 reverse/random offset; columns 3–10 loop division 1/4 through 1/48 |
| 13 | Loop start |
| 14 | Loop end |
| 15 | Columns 1–4 loop on/off, channel latch, timestretch, mute; column 5 Clear Motion; column 6 Restore Start State |

Tap Sequence row 14 column 2 to latch Record, switch to Setup, and move a
supported control to write a Set lock at the current step. While recording, the
volume row previews and records the modulation multiplier instead of moving the
base channel fader; with Record off it remains the ordinary channel-volume
control. Return to Sequence and tap Record again to stop. A group target follows
its saved default track for inherited steps; a live-recorded group cut stores
the exact track played.

The renderer uses non-clearing `beginupdate` transactions for cell diffs. The
feature is unavailable on 8×8 and 16×8 grids. Send `extendedEditors 0|1` to
disable/enable it. `clearEditorTargetData` resets the selected target and
`clearEditorAllData` resets all targets. `editorLayout legacy` temporarily
restores the saved six-page prototype; `editorLayout sequence64` returns to the
new default. Legacy 16-step data is copied once into the first 16 new steps and
is never deleted by migration.

MechaTrellis private OSC is disabled by default. Send `mechatrellis 1` to
`s gridrouter` only when a MechaTrellis is connected; send `mechatrellis 0`
before switching back to a normal monome. The final OSC bridge blocks every
private color, RGB, 8-bit, and preset command while this hardware mode is off,
but standard 0–15 levels continue normally.

Semantic MechaTrellis editor color is enabled with hardware mode. It can also
be changed with `editorColors 0|1`; the older `editorBrightnessColors` name
remains an alias. Brightness still communicates state through the standard
0–15 levels, while hue communicates function:

| Color family | Editor meaning |
|--------------|----------------|
| Cyan / green / amber / magenta | Trigger / gated trigger / lock / trigger+lock |
| Blue-violet / white / lime / orange | Gate tail / sequence playhead / track position / held step |
| Green / pink / red | Run or Add / Record / destructive action or Exit |
| Blue / amber | Sequence and bar navigation / Setup |

Lock parameters and predefined shapes each have stable colors. Setup uses group
colors plus dedicated families for volume, octave/transpose, reverse, randomization,
division, loop bounds, latch, timestretch, and mute. Full editor palettes use
4×4 maps; subsequent state and color-only changes use single-cell diffs. This
keeps one-cell playheads and navigation feedback responsive without repainting
a tile. Standard levels remain authoritative, so monochrome Grid Zero behavior
is identical. The option defaults off to avoid private OSC traffic on non-color
hardware.

For a permanent per-workstation setting, copy `mlr.local.example.json` to
`mlr.local.json` and set `mechatrellis` and `editorColors`. The local file is
ignored by Git and omitted from handoff ZIPs. With no local file, MLR starts in
ordinary-monome-safe mode. This lets one workstation enable color automatically
without sending private RGB commands on somebody else's grid.

### Mode 2: Sequence64 Run controls and columns 10–12

Mode-2 row 5, columns 1–8 toggle Run/Stop for group patterns 1–8. These
buttons replace the older channel short-loop latch row. A running group key
briefly dips on each audio trigger, then returns to its bright latched state.

Mode-2 physical column 9 retains the old Max randomizer while also opening the
sample browser: tap a track row to browse for that track, or hold it for about
450 ms to send the original `N[box]rnd` message. The top-row Randomize All key
remains immediate. Automation records only the resolved long-press Randomize
action; a short browser tap is never captured as musical automation.

| Column | Rows | Function |
|--------|------|----------|
| 10 | 2 play/stop; 3 loop; 4–7 length 1/2/4/8 bars; 8 arm/stop record | Clocked grid-button automation |
| 11 | 2–6 = 1/32, 1/16, 1/8, 1/4, 1/2 | Global input quantize |
| 12 | 2 onward, one row per track | Preview/Stop that track's one-shot phrase; flashes when the phrase triggers |

### Portable sample bank

`sample-bank.json` replaces the old workstation-specific `def.list` workflow
for a session's initial choices. Put audio in the ignored `samples/` directory,
list paths relative to that directory, and optionally assign the initial sample
for each of the 16 tracks:

```json
{
  "version": 1,
  "root": "samples",
  "samples": ["drums/kick.wav", "loops/blue.aif"],
  "trackAssignments": [0, 1, 0, 1]
}
```

Sample and assignment indices are zero-based. Missing assignments fall back to
a deterministic round-robin choice, so the same bank opens the same way on
another computer. MLR loads the manifest automatically through its existing
file-list and buffer machinery. The front-page Randomize buttons then choose
only among active bank entries. Send `reload` to `s sample_bank` after editing
the manifest, or `read path/to/another-bank.json` to load another manifest. The
old drag/drop and saved `_flist` paths remain available.

The HUD's **Open Bank/List…** control accepts either the portable JSON format
or an existing Max `.list`/text bank. Legacy imports skip recorder entries,
deduplicate WAVE/AIFF paths, preserve absolute volume paths, and remain
runtime-only—the source list is never rewritten. This provides a direct bridge
from the old front-page workflow while a portable JSON bank is being assembled.

**Scan Folder…** builds a runtime bank directly from a sample directory. The
scan is recursive but bounded to 240 audio files—three compact physical-grid
pages—and visits the folder tree in small scheduled
batches so playback is not held up. It recognizes WAV/AIFF files, sorts them
into filename/path-derived instrument families, and gives each normalized
series a stable semantic color. This first organizer is local and deterministic;
it does not upload audio or perform content analysis. Reload rescans the folder,
and the source directory is never modified.

### Max 9 HUD

In Max 9, press **HUD** near the upper-right of MLR to open the responsive
720×480 standalone-style display. Its seven tabs are:

- **Live Grid** — a read-only 16×16 mirror of the composed varibright levels
  and semantic colors, plus the active track, sample, slice, and editor state.
  **Capture + Reinit Grid** records the current display layers and color queue,
  rebuilds device-local levels and palettes, then records the settled state.
- **ṛta** — synchronized group/track and bar selection, a four-row
  pattern/phrase view, a read-only step inspector, and ownership-aware Run, Stop,
  and Restart buttons.
- **Strip** — one channel strip per group, with the working low-pass filter,
  resonance, compressor engine A/B, threshold, ratio, timing, knee, parallel
  mix, makeup, saturation drive, trim, and selected-group meters. **Clean** is a
  custom stereo-linked Gen compressor; **OMX** is Max's `omx.comp~` character;
  **Bypass** plus fully open filter, zero drive, and zero trim is the exact-dry
  compatibility default. The **Rack** sub-tab adds four serial VST3/Audio Unit
  effect slots after the built-in strip and before the group fader. Each slot
  has click-safe load, bypass, editor, clear, and reorder controls; reported
  per-slot/group latency is displayed without automatic compensation. The
  chooser's **Refresh** button rereads Max's existing plug-in cache without a
  potentially long third-party rescan. The list request deliberately does not
  use `vstscan`'s optional `effect` filter: older valid Max cache records often
  lack its newer category field and would otherwise disappear. Instruments and
  zero-input entries are still rejected dry when selected. Large inventories reach the HUD in
  paced atomic chunks, so the last complete list remains usable while it
  refreshes. Use Max's Plug-in Browser **Full Scan** only when a newly installed
  effect is absent from that cache.
- **Samples** — sixteen runtime track assignments, a paged bank browser,
  metadata, and cached mono/stereo waveforms read from existing named buffers.
  A click selects and auditions through a private preview player; **Assign** or
  a double-click commits the selection. **Stop Preview** silences auditioning.
- **Colors** — a runtime color lab for Main/Mod page roles, all eight groups,
  and ṛta's semantic roles. RGB can be changed in 16 coarse steps with ±1 fine
  adjustment, with per-role and global reset. It never writes configuration.
- **Session** — New, Open, Save, Save As, and Relink for versioned
  `.mlr-session` bundles, including dirty prompts, progress, and missing-file
  notices. The obsolete preset interface is hidden and disconnected.
- **Help** — mode-following grid diagrams and hover descriptions for Main,
  Mod, Groups, ṛta, lock editing, and the sample-grid page.

The Live virtual keys and Pattern steps never trigger audio. Pattern target and
bar controls do synchronize the physical Sequence64 editor, and its transport
buttons call the same centralized ownership/lock-restoration routines as the
grid. Sample assignments affect only the current session and never rewrite
`sample-bank.json`. **Grid Browse** opens a split physical-grid browser without
covering ṛta. Row 1 selects one of 16 tracks, rows 2–7 show 96 samples at a
time, and row 8 is the browser footer: columns 1/2 move pages, columns 5–7 jump
directly among the three pages, and column 16 closes. Rows 9–16 retain normal
ṛta drawing and input ownership. Row 16 column 13 is another persistent
open/close shortcut in both Sequence and Setup. Tap a sample once to audition
it, then tap the same sample again to assign it to the selected track. Holding
the selected track key also closes the browser. Track keys use their group
colors; sample keys use stable colors derived from their normalized filename
family. This internal overlay introduces no new serialosc or MechaTrellis
protocol messages.

`hud_model.js` is the Max-independent reducer and protocol model. `hud.js`
contains only V8UI/mgraphics drawing and pointer behavior, while
`hud_bridge.js` adapts MLR, Sequence64, and named audio buffers. Opening or
recompiling the HUD requests a complete snapshot, then consumes incremental
`mlr_hud_state` updates. Version one of the HUD requires Max 9/V8UI; its state
model and zero-based event protocol are kept independent of Max APIs.

### Modern sessions and plugin racks

A session is a folder named `Name.mlr-session`. `session.json` stores transport,
bank/catalog ordering, all 16 tracks, eight groups and strips, four rack slots
per group, ṛta programming, router automation, and Color Lab roles. Plugin
states live in `plugins/g01-s01.maxsnap`-style sidecars. Ordinary samples remain
referenced in place; only live recording buffers actually assigned to tracks
are copied into `recordings/` as float32 WAV files. Saving is refused while the
live recorder is active.

Save uses a temporary staging bundle and installs it only after the JSON and
sidecars validate. Open preflights the complete schema, stops all playback and
runtime ownership, restores durable state, and remains stopped. Missing plugins
and samples retain their descriptors/assignments and pass dry or stay silent.
Relink first tries the original bank-relative suffix, then a unique exact
filename. Hardware layout, serialosc/MechaTrellis settings, display caches,
diagnostics, and transient playheads are deliberately not session data.

The plugin racks accept effects only: VST2, instruments, and zero-input plugins
are rejected dry. MLR BPM and global Start/Stop are mirrored to Max Global
Transport in 4/4 for tempo-aware plugins; stopping an individual ṛta target does
not stop that shared transport. Rack loads use `vst~`'s format-specific
`plug_vst3` and `plug_au` messages rather than the generic resolver. Since
`vst~` hosts third-party code in the Max process, a plugin whose constructor
itself never returns can still stall Max before an in-patch timeout can fire;
after restarting, try the other cached format or remove that plugin from the
rack/session descriptor.

### Crash diagnostics

Playback diagnostics are enabled by default and written as newline-delimited JSON
to `/tmp/mlr-diagnostic.log`. The log records sample triggers, rate-limited
playback-position and phrase-clock callbacks, buffer-load requests (including path, channel count, duration, and
sample rate), track state changes, loop messages, Run state, and the latched
Record state. It is capped at 8 MB and resets itself when the cap is reached.
Because each event occupies one complete line, all earlier events remain readable
if Max crashes during playback.

Send these messages to `gridrouter` when needed:

- `diagnosticMark <label>` adds a recognizable marker before a test.
- `diagnosticStatus` prints the path and current state in the Max console.
- `diagnosticLogging 0` disables logging; `diagnosticLogging 1` enables it again.

After a crash, copy `/tmp/mlr-diagnostic.log` before reopening and testing again
if you want to preserve that exact session separately.

Display recovery incidents are stored separately as before/after JSON records
in `/tmp/mlr-display-incidents.jsonl` and cross-referenced from the main log.
They include stable foreground/background, transient animation level/mask,
composite and semantic-color hashes, palette hashes, pending color commands,
page/editor state, and outgoing packet counters. These are Max-side
observations, not firmware acknowledgements.

MLR is configured as one logical 16×16/edition-256 surface. A pair of physical
128 panels is combined downstream by `grid_composite_2x128`; the matrix bridge
itself remains in single-256 mode. Router startup and **Capture + Reinit Grid**
both reassert this layout, preventing a stale 16×8 Global value from making the
HUD publish only the top half.

Grid flashes and fades use transient level and transparency-mask byte arrays
owned by the display bridge. The animation engine sends explicit overlay
updates and never binds or writes a named Jitter matrix. It may temporarily
render brighter or darker than a key's base level; when a flash ends, its mask
disappears and the current underlying page state is revealed. This
prevents the legacy row and metronome fades from gradually clearing the HUD and
physical grid during an unattended performance.

Short-loop range, division, and channel latch remain together in the Sequence64
Setup view. Triggering a track on a latched channel still reapplies its selected
short loop at the new playback position.

To test automation, remain on mode 2: select a short length, press column 10
row 8 to arm, then press a non-automation control such as mute or random
offset. The first such press starts recording. Press the arm pad again to stop
early, or let the selected length expire. With loop off, press column 10 row 2
to play the capture once. Automation currently records press-down events and
stores grid coordinates rather than page identity, so changing pages during
recording or playback is not supported.

### Compact `.maxpat` Analysis

Use the local analyzer to strip UI/layout noise and summarize object topology:

```bash
python3 scripts/analyze_maxpat.py grid_router_io.maxpat --no-comments --depth 1
python3 scripts/analyze_maxpat.py _mlr.maxpat --no-comments --sends-only
```

This is useful when reviewing large patches with an LLM because it preserves:

- objects and connections
- subpatcher hierarchy
- send/receive topology
- bpatcher and JS/V8 references

### Codex MCP Server

This repo includes a local stdio MCP server for Codex:

```bash
python3 scripts/maxpat_mcp_server.py
```

It exposes static patch-analysis tools:

- `list_maxpat_files`
- `analyze_maxpat`
- `analyze_maxpat_batch`
- `max_bridge_status`

It also adapts the existing Max Socket.IO bridge on `127.0.0.1:5002` into live MCP tools for:

- patch object/patch-cord inspection
- selection inspection and expansion
- object attribute reads
- object creation, connection, and message/attribute edits

Requirements:

- `python-socketio` installed in the Python interpreter used to launch the server
- Max running with `_mlr.maxpat` open and the `MaxMSP_Agent` bridge active

Optional docs support:

- if `/Users/jm/Projects/MaxMSP-MCP-Server/docs.json` is present, the server also exposes `list_all_objects` and `get_object_doc`

## File Reference

### Main Patch

| File | Purpose |
|------|---------|
| `_mlr.maxpat` | Main application — open this in Max 8 |

### Audio Engine Patches

| File | Purpose |
|------|---------|
| `pl.maxpat` | Playback engine — `groove~`, fade, built-in strip, four-slot serial plugin rack, then the legacy group fader/routing. |
| `channel_strip.maxpat` | Per-group filter, clean/OMX compressor A/B, parallel mix, saturation, trim, HUD state, and selected-group metering. |
| `mlr_plugin_rack.maxpat` | Four serial dry-safe stereo effect slots per group. |
| `mlr_plugin_slot.maxpat` | One click-safe `vst~` host with validation, bypass CPU disable, snapshots, and latency query. |
| `mlr_plugin_service.maxpat` | VST3/AU inventory, rack state, commands, and HUD publication. |
| `mlr_plugin_transport.maxpat` | Mirrors MLR BPM and global Start/Stop to Max Global Transport. |
| `mlr_filter.maxpat` | Stereo Gen state-variable low-pass; combines manual cutoff and ṛta modulation with an exact-open bypass. |
| `mlr_compressor.maxpat` | Custom zero-lookahead, stereo-linked Gen peak compressor used by the Clean engine. |
| `mlr_saturator.maxpat` | Stereo Gen soft saturation stage with exact bypass at zero drive. |
| `output.maxpat` | Per-channel output routing — volume, mute, metering. Routes to main out (dac 1-2) and monitor (dac 3-4). |
| `mon.maxpat` | Monitor output bus — receives `mon1`/`mon2` signals, applies gain, outputs to dac 3-4. |
| `chmon.maxpat` | Channel monitor routing — gates individual channels between main and monitor buses. |
| `ch.maxpat` | Channel interface and routing control. |

### Timing System

| File | Purpose |
|------|---------|
| `time.maxpat` | Master clock — generates tempo pulses, BPM, phase signals. Sends `tr_pulse`, the phase-locked `sequence64_pulse`, `tr_tempo`, and `box/led`. |
| `sequence64_audio_bridge.maxpat` | Native one-shot cut registers released by `sequence64_pulse`, keeping sequenced player onsets out of V8's low-priority thread. |
| `clock.maxpat` | Clock source selection (internal/external/beat clock), swing, MIDI device routing. |
| `clock2.maxpat` | Secondary clock — beat clock distribution, MIDI tempo sync. Sends `gome_pulse`, `gome_tempo`. |

### Pattern and Sequencing

| File | Purpose |
|------|---------|
| `pattern.maxpat` | Pattern recording/playback — records key sequences via `seq~`, syncs to clock, loops. |

### Effects

| File | Purpose |
|------|---------|
| `djfxxx-0.2.maxpat` | DJ effects rack — delay, filter, ringmod, flanger, scratch, granular, stutter. Large patch with LED feedback. |
| `djio.maxpat` | DJ effects I/O interface — handles state and LED updates for the effects page. |

### Interface and Grid

| File | Purpose |
|------|---------|
| `wcell.maxpat` | Grid cell with "weird" modulation factor. Sends to `#1[weird]`. |
| `wcellg.maxpat` | Grid cell variant — receives from `#1[weird]`. |
| `64notemute.abs.maxpat` | MIDI note-to-mute mapping via `coll midi_settings`. |

### Preset and File Management

| File | Purpose |
|------|---------|
| `preset.maxpat` | Preset save/recall system — stores row configs via `coll`, keyboard navigation. |
| `file_list.maxpat` | Sample file browser/manager — loads audio files, uses `file.abs` abstraction. |
| `sample_bank.js` / `sample-bank.json` | Portable relative-path bank and deterministic track assignments. |

### Live Abstractions (Binary, .mxb)

These are old-format Max binary abstractions still used by the patches. They cannot be
version-controlled meaningfully (binary diffs). Converting to `.maxpat` format in Max would
make them inspectable and diffable.

| File | Used By |
|------|---------|
| `64button.abs.mxb` | `_mlr.maxpat` (8 bpatcher instances) |
| `64midi.abs.mxb` | `_mlr.maxpat` (9 bpatcher instances) |
| `64note.abs.mxb` | `_mlr.maxpat` (16 bpatcher instances) |
| `64num.abs.mxb` | `_mlr.maxpat`, `64notemute.abs.maxpat` |
| `fade.mxb` | `pl.maxpat`, `output.maxpat`, `_mlr.maxpat` |

### Hidden Abstractions (no file extension)

These extensionless files are actually Max binary abstractions loaded via the search path.
Do not rename, move, or delete them.

| File | Used By |
|------|---------|
| `showMeter` | `_mlr.maxpat` — meter display components |
| `agate` | `djfxxx-0.2.maxpat` — gate effect |
| `session` | `_mlr.maxpat` — session state bpatcher |
| `file.abs` | `file_list.maxpat` — per-file abstraction (hundreds of instances) |

### Data and Config Files

| File | Purpose |
|------|---------|
| `midi_settings` | MIDI control mapping — saved/loaded by `coll midi_settings` |
| `mlr.local.example.json` | Template for ignored per-workstation grid/color settings |
| `sample-bank.json` | Portable relative sample list and initial track assignments |
| `_save.txt` | Saved button mapping state |
| `rec.pat` | Pattern recorder state (bpatcher in `_mlr.maxpat`) |
| `rec_b.pat` | Pattern recorder state (dependency) |

### Preset/Pattern Files (User Data)

These are user-created data files loaded via file dialogs. Not hardcoded into the patches
(except `dope-preset` which has a legacy hardcoded path).

| File | Purpose |
|------|---------|
| `default pattern` | Default pattern sequence data |
| `default pattern 2` | Default pattern sequence data |
| `dope-preset` / `dope-preset_flist` | User preset + file list |
| `myfirstpreset` / `myfirstpreset_flist` | User preset + file list |

### Documentation

| File | Purpose |
|------|---------|
| `mlr_info.txt` | Modification changelog and full operation docs (loaded by patch) |
| `license_mlr.txt` | GPL v2 license text (loaded by patch) |
| `documentation.rtf` | **Note:** This is documentation for polygome 256, not mlr. Kept for reference. |

### Images

| File | Purpose |
|------|---------|
| `mlr.png` | Logo displayed in main patch UI |
| `logo.png` | Not referenced by patches |
| `step.png` | Not referenced by patches |

## Architecture

### Signal Flow

```
Grid 256 (serialosc)
  |
  v
_mlr.maxpat (main orchestrator)
  |
  +---> time.maxpat / clock.maxpat -----> tr_pulse, tr_tempo, [time]phase
  |                                           |
  +---> pl.maxpat (per-group)  <-------------+  (tempo sync)
  |       |   groove~ -> fade -> filter -> compressor -> color/trim -> 4-slot rack
  |       v   -> existing volume/lock stage
  +---> djfxxx-0.2.maxpat (effects) -----> output.maxpat (per-channel)
  |                                             |
  +---> pattern.maxpat (records key sequences)  +---> dac~ 1 2 (main)
  |                                             +---> mon.maxpat ---> dac~ 3 4 (monitor)
  +---> mlr_session_service.maxpat (modern staged save/load)
  +---> file_list.maxpat (sample browser)
```

### Messaging Protocol

Inter-patch communication uses Max `send`/`receive` with namespaced names.
The `#1` prefix is a Max argument placeholder — it becomes the channel number (1-8)
when the patch is instantiated.

**Clock namespace (`[time]`):**
- `[time]bpm` — current BPM
- `[time]ms` — milliseconds per beat
- `[time]phase` — sync phasor signal (audio rate via `send~`/`receive~`)
- `[time]preset` — tempo preset recall
- `tr_pulse` — clock tick
- `tr_tempo` — tempo value
- `tr_pulse_duration` — pulse width

**Playback namespace (`[pl]`, `[box]`):**
- `#1[pl]stop` — stop playback for channel #1
- `#1[pl]on` — playback active flag
- `#1[box]mute` — mute channel #1
- `#1[box]rev` — reverse playback for channel #1
- `#1[box]rowPos` — current row position (3 ints: row, col, state)
- `[box]output` — output routing

**Volume:**
- `#1vol` — volume level for channel #1
- `#1vol_add` — increment/decrement volume
- `raw_volume` / `raw_mute` — raw control values

**Pattern:**
- `pattern_in` / `pattern_out` — pattern data bus

**Grid LEDs:**
- `box/led` — LED update messages (col, row, level)
- `_box/led` — secondary LED bus (used by djio)

**Global control:**
- `kmod` — grid page state (1=Main, 2=Mod/Sequence64, 3=Groups)
- `[mlr]start` / `[mlr]stop` / `[mlr]reset` — transport control
- `[mlr]q` — quantize setting
- `randoggu` — random pattern trigger

**Monitor:**
- `mon1` / `mon2` — monitor audio bus (signal rate)
- `monvol` — monitor volume
- `#1chmon` — per-channel monitor enable

**Effects:**
- `#1[weird]` — weird modulation factor
- `weirdoffset` — weird offset signal (audio rate)
- `#1djfxsel` — DJ effect selection
- `#1mlrdjstat` — DJ effect status

## Untracked / Work-in-Progress Files

The following files exist in the working directory but are **not referenced by any patch**
and are not tracked in git. They may be works-in-progress or experiments:

- `routers.js` — grid input routing logic (similar to the `p routers` subpatcher in `_mlr.maxpat`)
- `buttonseq.js` — step sequencer recorder
- `groupsproc.js` — group processing (subset of routers.js logic; contains a bug where `muted` is used as scalar instead of array)
- `groupsproc` (no extension) — tiny code fragment, same logic as groupsproc.js

## Packaging a handoff

Create a tested, versioned ZIP containing the Max runtime project without Git
metadata, test tooling, MCP helpers, editor settings, or `node_modules`:

```sh
./scripts/package_release.sh
```

The ZIP and its SHA-256 checksum are written to `release/`. Packaging requires
all tracked changes to be committed, so the handoff always identifies the exact
source revision from which it was created.
