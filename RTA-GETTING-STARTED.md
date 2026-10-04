# ṛta: getting started from MLR

**For Kero · October 2026**

ṛta keeps MLR's sample cutting, groups, and four original pattern recorders,
then adds editable step patterns, instrument tracks, per-step parameter locks,
and Scenes. Start with your usual MLR playing, then add one group pattern.

This guide assumes an ordinary **16×16 grid**. Color is optional: brightness
carries the controls and their state. The step editor uses the bottom eight
rows, so an 8×8 grid does not provide this full physical editor layout.
The HUD is the on-screen companion: it shows the selected group/track, bar,
step, parameter name, value, and playback state.

**All coordinates below are one-based: row 1 is the top, column 1 is the left.**
A *track* is an MLR sample/instrument row. A *group* is the shared player that
tracks are assigned to. A *step* is a position in a ṛta pattern.

## 1. Open it and play something familiar

1. Save and close the MLR patch, any older ṛta build, and any separate drum labs.
   Open one build at a time: multiple instances share controls and can make a
   single page-button press toggle back immediately.
2. Unzip the whole build folder. Open `rta.maxproj`, then `_rta.maxpat` if the
   entry window did not open. Use Max 9 with V8, Node for Max, and RNBO available.
3. Connect the grid through serialosc as usual. Leave **GRID COLOR OFF** on the
   HUD's **Live** page for a normal monome. This is the startup default.
4. Set tempo, raise the master, and switch **Audio** on in the top panel.
   Audio starts off. For samples, check the group's volume and mute in
   **Strip** too.
5. Open **Samples** in the HUD. Use **ADD FOLDER…**, select a sample and track,
   and use **ASSIGN**. A single sample click auditions it; a double-click also
   assigns it. Repeat for a few rows.
6. Play cuts on the Main grid as you would in MLR. Physical rows 2–16 are
   visible tracks 1–15; the columns choose slices. The familiar four pattern
   recorder buttons are still on row 1, columns 9–12.

The HUD's **Live** grid is a monitor, not a clickable replacement for hardware.
Hover over it for control descriptions. **Help** gives another view of the grid
controls. Choosing a parameter also puts a brief monochrome abbreviation on the
upper grid and its full name/value in the HUD.

## 2. Make a first kick pattern

The instrument tracks are already loaded. Use **open** above *Instrument
controls* to show their window; choose **Stereo** output for a first test and
check the voice's Level if needed. Opening a second drum-lab file creates
duplicate voices, so use this button.

These are the startup assignments; an opened session restores its own mapping:

| Sound | Visible track | Default group |
| --- | ---: | ---: |
| Kick | 15 | 1 |
| Snare | 14 | 2 |
| Hat | 13 | 3 |
| Clap | 12 | 4 |
| Tom | 11 | 5 |
| Rim | 10 | 6 |
| Bell | 9 | 7 |
| FM bass | 8 | 8 |

Sample tracks 1–7 keep their MLR group defaults. A sample track and an instrument
can share a group, so check the Track choice before building a pattern there.

1. From Main, tap **row 1, column 16** to open Mod/page 2.
2. Hold **row 5, column 1** briefly, about 350 ms, to open **Group 1**.
   A short tap here toggles that group's Run instead. Alternatively, choose
   **Group 1** on the HUD's **ṛta** page. Selecting a target does not start it.
3. Tap **row 16, column 1** if needed to show **Sequence**. If the view is
   already open, tapping this button collapses it; tap again to reopen.
4. Tap these four empty cells: **r9 c1, r10 c1, r11 c1, r12 c1**.
   Each creates a hit on slice 1. On the fresh default mapping, Group 1 uses Kick.
5. Tap **r13 c15** for **Pattern** controls, then **r15 c1** for **Run**.
   This starts transport automatically. **r15 c4** stops this pattern;
   **r15 c3** restarts it from step 1 and starts it if stopped.

**Timing:** one default bar has 64 steps, with 16 steps per beat in 4/4.
The first cell of each step row is a quarter-note position:

| Physical row | Steps, left to right | Quarter-note hit |
| --- | --- | --- |
| 9 | 1–16 | Column 1: beat 1 |
| 10 | 17–32 | Column 1: beat 2 |
| 11 | 33–48 | Column 1: beat 3 |
| 12 | 49–64 | Column 1: beat 4 |

To add a backbeat, open **Group 2**, put hits at **r10 c1** and **r12 c1**,
then use Pattern → Run. Group patterns can run together. Once an editor is
open, the shortcut buttons in the upper half remain useful; the lower half is
now the editor rather than ordinary track controls.

## 3. Change a step without losing it

Tapping an **empty** step adds a hit. Tapping an **existing** step selects it;
it does not delete the hit. The HUD follows that selection.

With the sample/MLR parameter page visible, row 13 chooses what to edit:

| Column | Parameter |
| ---: | --- |
| 5 | Slice |
| 6 | Probability |
| 7 | Volume |
| 8 | Filter |
| 9 | Reverse |
| 10 | Transpose |
| 11 | Loop division |
| 12 | Gate length |
| 13 | Track, for group patterns |
| 14 | Condition, for group patterns |
| 15 | Pattern controls |

**Try a sample variation:** select a step, choose **Slice** at **r13 c5**,
then choose its slice on row 14. That value is saved for that step and the slice
auditions while pressed. Choose **Volume** at **r13 c7** and a value on row 14
to make one hit quieter. This is a *parameter lock*: a saved change at that
position in the pattern.

**If a group has several tracks:** select a step, choose **Track** at **r13 c13**,
then press the desired track position on row 14. Only tracks assigned to the
group are available. Newly added steps remember your last chosen track in that
pattern, including after save/open; earlier steps retain their assignments.
Track phrases omit Track and put Condition at column 13 instead.

For an instrument target, **r13 c16** switches between sample/MLR parameters
and the instrument parameter page. Instrument pages change the parameter
buttons, so read the HUD's full names and values instead of using the table
above while that page is active. With a configured knob controller, Grid focus
follows the current parameter page; holding a step writes its locks. Let the
HUD's editing-layer label tell you whether you are changing a baseline or a lock.

To remove only the hit, return to parameter context and tap **r15 c1**
(*Trigger*). Its locks remain. To erase the whole step, hold **r16 c15**
(*Delete*) and tap the step. **r15 c1 is Run in Pattern context and Trigger
in parameter context**—check the selected context first.

## 4. Three views, then Scenes

These view buttons stay at the bottom left on Mod/page 2:

| Button | View | Purpose |
| --- | --- | --- |
| r16 c1 | Sequence | Enter hits, edit locks, bars and timing |
| r16 c2 | Setup | Track/group assignment, volume, pitch, reverse and loops |
| r16 c3 | Scene | Combine group patterns and track setups |
| r16 c16 | Exit ṛta editor | Return the lower rows to normal controls |

A **group pattern** loops and can choose among that group's tracks. A **track
phrase** plays once; a group cut can launch it. Begin with group patterns and
leave phrases for later.

When the first patterns are comfortable, open **Scene**. This view uses the
whole grid:

- **Row 1:** Scenes. Tap an empty slot to capture the current combination;
  tap a stored Scene to launch it.
- **Rows 2–9:** one row per group. Columns 1–12 choose that group's pattern;
  column 13 runs/stops it. An empty pattern slot copies the current pattern so
  you can make a variation.
- **Row 10:** Track Slots. Each stores the tracks' sample/group assignments,
  playback settings and phrases. An empty slot clones the current setup.
- **Row 11, columns 1–3:** global Start / Stop / Reset. Global Stop pauses the
  sequencer while retaining the groups' Run choices; Start resumes them.
- **Rows 12–15:** the focused group's 64 steps. Touching a group pattern row
  focuses that group. The step area is here, rather than rows 9–12.

Scene changes wait for a bar boundary during running group playback. While
stopped they apply immediately. Edits write into the selected pattern/Track
Slot as you make them; save the session to preserve them on disk. Scenes can
share a pattern or Track Slot, so editing a shared item affects its other uses.

## 5. Save and pick it up later

Use **Session → SAVE AS** for your first save, then **SAVE** as you work.
Keep the complete `.mlr-session` folder together. Session open restores the
patterns, assignments and settings **stopped**; deliberately start playback
after opening.

ṛta can import modern base-MLR session bundles. Use **SAVE AS** when importing
one: saving from ṛta produces a ṛta session that base MLR cannot reopen.
The old MLR preset controls and four gesture recorders remain separate from
this new Session workflow.

## If something looks wrong

| Symptom | First check |
| --- | --- |
| Page button seems stuck or immediately returns | Close other MLR/ṛta builds after saving. One instance per Max process. |
| Grid has brightness but no color | Normal on a standard grid. Leave GRID COLOR OFF; it does not remove any controls. |
| No sound | Audio on, correct output device, sample assigned, group unmuted/volume up for samples; instrument Level and Stereo output for drums. |
| Wrong sound in a group pattern | Check the step's Track assignment and that the track belongs to the group. |
| A step stays lit after removing its hit | It may still contain locks. Delete + step clears the complete step. |
| Pattern does not run | Check the selected group/track and use Pattern → Run. A track phrase Preview plays once. |
| Display looks stale after reconnecting | Live → CAPTURE + REINIT GRID. This refreshes the display; it does not fix duplicate patch instances. |

For the full gesture map, see [the editor reference](sequence64_editor_reference.md).
