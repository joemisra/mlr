# RNBO clap laboratory

Open `rnbo_clap.maxpat` alongside MLR, enable audio, and use **TRIGGER**, **Repeat**, or visible **Track 12**. Leave Track 12's sample slot empty to hear the clap alone. Its adapter listens to native `13input` presses. Releases and other tracks let the tail decay. Audio goes directly to outputs 1–2 and is also available on `rnbo_clap_left` / `rnbo_clap_right`; MLR mixer routing remains future work.

This original engine combines a train of filtered noise bursts with a separate, smoothly rising noise tail. **Tight**, **Hands**, and **Wash** are editable starting sounds. The complete burst train is scheduled inside RNBO at audio rate; Max/JavaScript does not schedule the individual bursts.

| Grid page | Controls |
| --- | --- |
| Claps | Burst count, Burst spacing, Burst decay, Timing scatter |
| Tone | Filter frequency, Filter Q, Brightness, Drive |
| Tail / output | Tail decay, Tail level, Burst / tail balance, Level |

Burst count rounds to 1–8. Spacing is the nominal interval between bursts. Scatter varies each interval by up to ±45% at its maximum setting. Burst and tail decays are approximately the time to −60 dB. The tail starts on the final burst, with a 3 ms rise time constant. Brightness blends high-frequency noise into the bandpass sound. Balance moves from bursts only (0) to tail only (1); Tail level adjusts the tail independently. Drive adds saturation.

The twelve values are captured at each hit. Parameter edits and later sequencer steps do not reshape a ringing hit. A new clap hit restarts this monophonic voice and cancels any remaining bursts from the previous hit. It does not overlap independent clap voices. Tail-only sounds begin after the selected burst train's delay.

## Grid and presets

Coordinates are one-based from the top-left corner of the 16×16 logical grid.

- Open Track 12's pattern editor, or select a group step assigned to Track 12.
- Row 13, column 16 switches to clap parameters.
- Row 13, columns 10–12 select Claps, Tone, or Tail/output. The grid announces CLAP, TONE, or TAIL.
- Row 13, columns 5–8 select one of the page's four controls. Select a step and set its value on row 14.
- Row 15, column 3 toggles baseline editing; column 2 is Live Write; columns 4–5 make fine adjustments; column 16 clears the selected lock.
- Setup row 15, columns 8–15 holds eight clap sound presets. Tap to recall; hold Shift (bottom row, column 12) and tap to store. The grid announces CP1–CP8.

Unlocked hits use the manual baseline. Group locks override phrase locks on their merged hit only. Presets save the twelve baseline values, remain independent of the other drum banks, and persist with the session. Recall is manual and does not write step locks with Live Write enabled. Track Slots and sessions retain clap baselines and locks.

The lab's Min/Max fields scale future grid edits without changing existing sounds or locks. Its Max preset object stores these 24 range fields separately from the grid sound bank. Shift-click a range slot to store, click to recall, and save the lab patch to retain it.

## Loading and testing

Save any current work before reopening the main patch to load the updated native audio bridge. The router can autowatch; Max patch wiring requires reloading. Keep the clap lab open while sequencing it.

Automated checks cover all controls and pages, preset/session round-trips, native packet routing and cache-before-trigger order, unlocked-hit restoration, integer burst count, range fields, and stable audio outlet metadata. Numerical execution of the DSP equations at 44.1/48/96 kHz checks bounded output, burst timing, scatter bounds, tail decay, retrigger cancellation, and per-hit parameter capture. These checks do not establish RNBO compilation or live Max/grid behavior. UI automation timed out while opening the lab, so compilation and listening remain to be checked in Max.

Named control buses: `rnbo_clap_trigger` (bang), `rnbo_clap_param` (e.g. `spacingMs 18`), and `rnbo_clap_repeat` (0/1). Controllers can send `instrumentManual 12 clapCount 4` to `gridrouter`. Physical definitions live in `clap_instrument_model.js`; readable DSP in `rnbo_clap_voice.genexpr` is mirrored into `rnbo_clap_voice.rnbopat`.

## Limits and grid spans

| Parameter | Engine limits | Default grid span |
| --- | --- | --- |
| Burst count | 1–8  | 1–6  |
| Burst spacing | 2–100 ms | 5–35 ms |
| Burst decay | 1–200 ms | 3–35 ms |
| Timing scatter | 0–1  | 0–1  |
| Filter frequency | 100–18000 Hz | 500–6000 Hz |
| Filter Q | 0.5–20  | 0.5–8  |
| Brightness | 0–1  | 0–1  |
| Drive | 0.25–8  | 0.25–6  |
| Tail decay | 5–10000 ms | 40–2000 ms |
| Tail level | 0–1  | 0–1  |
| Burst / tail balance | 0–1  | 0–1  |
| Level | 0–1  | 0–1  |
