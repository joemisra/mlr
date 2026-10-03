# RNBO snare laboratory

Open `rnbo_snare.maxpat`, let RNBO compile, enable Max audio, and use **TRIGGER**, **Repeat**, the named `rnbo_snare_trigger` bus, or visible **Track 14** in MLR. Audio leaves outputs 1–2 and the `rnbo_snare_left` / `rnbo_snare_right` signal buses.

Track 14 still operates its normal sample player. Leave its sample slot empty to hear only the snare. The adapter listens to `15input`, the native input bus for visible Track 14, and triggers only on a press. Track and group patterns assigned to Track 14 therefore fire the snare through the existing audio-timed action path. Other tracks do not choke its tail; another snare hit restarts the monophonic voice.

The voice combines a two-mode pitched body with brief pitch bend and decaying FM, plus a state-variable bandpass driven by a lightweight noise source. A short high-frequency noise transient supplies the snap. The **Tight**, **Wood**, and **Trash** buttons are starting points rather than protected factory sounds.

## Controls

| Page | Controls |
| --- | --- |
| Body | Body pitch, Body decay, Body bend, Body FM |
| Noise | Noise decay, Noise frequency, Noise Q, Snap |
| Mix / output | Body level, Noise level, Drive, Level |

All twelve values are captured when a hit starts. Editing a control during a ringing hit does not reshape that tail; the new value applies to the next hit. A new snare hit restarts this monophonic laboratory voice.

| Parameter | Engine limits | Default grid span |
| --- | --- | --- |
| Body pitch | 40–1200 Hz | 90–320 Hz |
| Body decay | 5–5000 ms | 30–900 ms |
| Body bend | 0–1200 Hz | 0–500 Hz |
| Body FM | 0–16 | 0–4 |
| Noise decay | 5–10000 ms | 30–1800 ms |
| Noise frequency | 100–18000 Hz | 800–12000 Hz |
| Noise Q | 0.5–20 | 0.5–10 |
| Snap | 0–1 | 0–1 |
| Body level | 0–1 | 0–1 |
| Noise level | 0–1 | 0–1 |
| Drive | 0.25–8 | 0.25–8 |
| Level | 0–1 | 0–1 |

## Grid controls

Coordinates are one-based on the 16×16 logical grid.

1. Open **Track 14**, or select a **group-pattern step assigned to Track 14**.
2. **Row 13, column 16** toggles between sample and snare controls.
3. **Row 13, columns 10–12** select Body, Noise, or Mix/output.
4. **Row 13, columns 5–8** select one of that page's four parameters.
5. Select a step in **rows 9–12** and set its value on **row 14**.

**Row 15:** column 2 is Live Write; column 3 toggles baseline editing; columns 4–5 make fine −/+ adjustments; column 16 clears the selected step lock. Editing a value does not create a trigger. The HUD shows the full name, value, step, and editing layer. Parameter and page selections briefly show bitmap labels on the upper grid.

The group page stores group-pattern overrides and the track page stores reusable Track 14 phrase locks. A group override wins on the first merged hit only. Later phrase hits use their own locks, and an unlocked hit uses the manual baseline. All twelve effective values travel with the scheduled hit, before the native Track 14 press, so returning to baseline does not alter the preceding hit or its tail.

## Ranges and saved state

Eight snare sound presets occupy **Setup row 15, columns 8–15**.
Tap to recall; hold **Shift (row 16, column 12)** and tap to store or overwrite.
The bank saves twelve manual baselines per slot with the MLR session and is
independent of the kick bank. A bright slot matches the current sound; edits
dim it. HUD notices name the slot and the grid flashes SP1–SP8. Recall does not
record step locks when Live Write is enabled.

The range fields scale future row-14 grid edits and their Max preset bank stores those 24 Min/Max values. They do not scale the standalone numeric sound controls or rewrite existing locks. Shift-click a range-preset slot to store it, click to recall it, and save the patch to retain embedded slots.

MLR sessions and Track Slots store all twelve manual snare baselines and all programmed snare locks. Grid mapping ranges remain separate lab settings, and the selected page is transient UI state.

## Named control

- `rnbo_snare_trigger`: bang starts a hit.
- `rnbo_snare_param`: named edits such as `bodyHz 190`, `noiseHz 6000`, or `snap 0.8`.
- `rnbo_snare_repeat`: 0/1 controls the 750 ms audition clock.
- `rnbo_snare_left` / `rnbo_snare_right`: dual-mono signal buses.

`snare_instrument_model.js` defines the physical limits, grid ranges, nonlinear mappings, and three pages. Controller adapters can send `instrumentManual 14 snareDrive 2.5` to `gridrouter`. `rnbo_snare_voice.genexpr` is the readable DSP source mirrored into the RNBO codebox in `rnbo_snare_voice.rnbopat`.

## Current validation boundary

Automated checks cover all three grid pages, twelve-value queued actions, group and track ownership, session persistence and old-session defaults, range mapping, native Track 14 press filtering, cache and trigger order, per-hit capture, silent UI feedback, and stable RNBO audio outlet metadata. The standalone patch was opened in Max, RNBO compiled, Repeat drove the voice, and both output meters showed signal. The integrated host was reopened and sent a twelve-value packet followed by native Track 14 press/release messages; listening from the real sequencer and physical grid remains the next playing check. Mixer routing, configurable track assignment, choke behavior, and DPT export remain future work.
