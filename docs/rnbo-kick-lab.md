# RNBO kick laboratory

Open `rnbo_kick.maxpat` alongside MLR. Let RNBO compile, enable Max audio, then use **TRIGGER**, **Repeat**, or ṛta Track 15. **Deep**, **Knock**, and **Hollow** provide starting sounds. The twelve numeric controls edit the next hit and update the shared manual baselines.

Track 15 still operates its normal sample player. Leave its sample slot empty to hear just the kick. This adapter listens to `16input`, the native input bus for human Track 15, and triggers only on a press. Track assignment is provisional; Track 14 now hosts the companion snare engine.

## Sound and tails

The voice combines a swept sine oscillator, decaying FM, an impulse-excited resonant bandpass, click, and soft saturation. Sweep and amplitude decay specify time to approximately −60 dB, not a hard cutoff. The resonator decays according to its frequency and Q. Resonator mix zero isolates the oscillator, and one isolates the resonator; the click remains independent.

**All twelve parameters are captured at each hit**, including Level. Manual edits, locks, preset changes, and baseline restoration do not reshape a ringing hit. Other tracks do not choke this standalone voice. Another kick resets its phases, envelopes, and resonator, replacing the preceding hit. Stopping Repeat lets the tail decay.

## Grid controls

Coordinates below are one-based on the 16×16 logical grid.

1. Open **Track 15**, or select a **group-pattern step assigned to Track 15**.
2. **Row 13, column 16** toggles between sample and instrument controls.
3. **Row 13, columns 10–12** select the instrument page. The active page is brighter; the HUD names it.
4. **Row 13, columns 5–8** select one of the four parameters on that page.
5. Select a step in **rows 9–12** and choose its value on **row 14**.

| Page selector | Page | Parameters at columns 5, 6, 7, 8 |
| --- | --- | --- |
| Row 13, column 10 | Body | Pitch, Decay, Sweep amount, Sweep decay |
| Row 13, column 11 | FM / attack | FM amount, FM ratio, Click, Drive |
| Row 13, column 12 | Resonator / output | Resonator mix, Frequency, Q, Level |

**Row 15:** column 2 is Live Write; column 3 toggles baseline editing (bright = baseline, dim = step lock); columns 4–5 make fine −/+ adjustments; column 16 clears the selected step lock. Enabling Live Write exits baseline mode. Clear always removes the selected step lock, including while baseline mode is selected. Editing a parameter does not itself create a trigger; existing step-selection/trigger gestures still apply.

The group page edits the **group pattern’s locks**, and the track page edits its reusable **track phrase**. On the first merged hit, instrument group locks override track-phrase locks without rewriting the underlying track pattern. The lock belongs to that hit only. Later phrase hits use their own locks, and an unlocked hit uses the manual baseline. Because every hit captures its own values, returning to the baseline does not reshape the previous tail.

Selecting a sample-only step returns to sample controls. In Live Write or held Setup lock-record, the playback step’s resolved track determines whether a kick edit is recorded. No extra trigger is created.

## Ranges and saved state

Eight sound presets are available in **Setup row 15, columns 8–15**.
Tap to recall; hold **Shift (row 16, column 12)** and tap to store or overwrite.
These slots capture the twelve manual sound baselines and save with the MLR
session. A bright slot matches the current baseline; editing the sound dims it.
The HUD names the slot and the grid flashes KP1–KP8. Recall does not record
step locks, even with Live Write enabled. The Max range-preset bank below
remains the separate store for grid Min/Max mappings.

The **Grid mapping ranges** panel beneath the sound controls has Min/Max fields for every parameter, grouped into the same three pages. Scroll down if the preset bank is below the window. Ranges change future grid edits, not existing physical lock values or baselines. A value outside the current mapping displays at the nearest grid endpoint until edited. Fine adjustments stay within the chosen mapping. Invalid ranges restore the previous pair and display a notice.

| Parameter | Engine limits | Default grid span | Fine step |
| --- | --- | --- | --- |
| Pitch | 10–2000 Hz | 20–120 Hz | 0.5 Hz |
| Decay | 1–30000 ms | 20–2000 ms | 5 ms |
| Sweep amount | 0–600 Hz | 0–600 Hz | 1 Hz |
| Sweep decay | 1–300 ms | 1–300 ms | 1 ms |
| FM amount | 0–32 | 0–4 | 0.01 |
| FM ratio | 0.125–8 | 0.125–8 | 0.025 |
| Click | 0–1 | 0–1 | 0.01 |
| Drive | 0.25–8 | 0.25–8 | 0.05 |
| Resonator mix | 0–1 | 0–1 | 0.01 |
| Resonator frequency | 25–400 Hz | 25–400 Hz | 0.5 Hz |
| Resonator Q | 0.5–24 | 0.5–24 | 0.1 |
| Level | 0–1 | 0–1 | 0.01 |

Pitch, both decays, FM ratio, Drive, resonator frequency, and Q use logarithmic grid spacing. Sweep, FM amount, Click, and Level have finer spacing near zero. Resonator mix is linear. Numeric sound controls retain the full engine limits.

The dedicated **Max preset** bank stores the **24 range fields only**. Shift-click a slot to store, click to recall, and save the Kick Lab patch to preserve slots. **write / read** export and import a preset-bank file; click a slot after import to apply it. Existing six-field range presets still address their original fields; the other ranges retain their current values. Opening the lab starts with default mappings; recall a slot to apply your preferred mapping. Mapping presets do not store sound controls, Repeat, or audio on/off.

MLR sessions and Track Slots store **all twelve sound baselines** and their step locks. Older three-parameter sessions retain those values and initialize the other nine from the original Deep sound. Grid ranges remain separate lab settings. Instrument page selection is transient UI state.

## Routing and timing

- `rnbo_kick_trigger`: bang fires a hit.
- `rnbo_kick_param`: named manual edits such as `baseHz 55`, `resonQ 12`, or `level 0.4`.
- `rnbo_kick_repeat`: 0/1 controls the independent 750 ms audition clock.
- `rnbo_kick_left` / `rnbo_kick_right`: stereo signal buses, currently dual mono.
- Audio also goes directly to outputs 1–2 with 0.7 host gain. It bypasses MLR’s mixer, effects, mutes, and master level.

`instrument_model.js` defines parameter IDs, units, bounds, default grid ranges, and pages. Controller adapters can send `instrumentManual 15 kickDrive 2.5` to `gridrouter`; the twelve IDs are exported as `KICK_LOCKS`. Manual lab edits and preset sounds use this same baseline path. Numeric displays receive silent cache updates, which cannot record themselves as new locks.

Each sequenced hit queues all twelve effective values with its native action. `sequence64_audio_bridge.maxpat` delivers them before the Track 15 press. The host flushes its native cache before the RNBO trigger, and the DSP captures all twelve at the hit. Cancellation discards the values with the hit. The final delivery/trigger ordering stays out of low-priority JavaScript. The first three packet positions remain Pitch, Decay, and FM for compatibility; the remaining nine follow the schema order.

The reusable `rnbo_kick_voice.rnbopat` has trigger plus twelve event inputs, with explicit `sig~` conversion. Keep the host RNBO object’s saved inlet/outlet metadata intact: audio uses outlet indices 0 and 1. Startup caches parameter values without sending them into an unfinished compile.

## Reload and validation

Save your working session, then reopen Kick Lab to load the updated host and DSP core. Reload the main MLR patch when convenient to ensure its cached parameter module is refreshed. Do not overwrite the newly edited patch file by saving an older already-open copy over it; save any wanted older patch edits to a separate file first.

Automated checks cover all three pages, twelve-value queued actions, complete session persistence, old-session defaults, group-over-track priority, native cache wiring, range mapping, and per-hit DSP capture. Isolated live Max recordings at 96 kHz confirmed nonzero audio, **zero recorded difference when all twelve RNBO parameters changed mid-tail**, and **zero difference between native queued and manual triggers with the same twelve values**. The expanded numeric and range panels were visually inspected in Max. Physical-grid/main-session validation remains separate.

The earlier six-field preset implementation was also exercised live through storage, recall, export, and import. The expanded 24-field bank uses the same mechanism and has topology coverage. Configurable track assignment, further drum voices, mixer/choke integration, DPT export, and hardware playback remain future work.

## Parameter identification

The selected parameter's full name, value, unit, step, and editing layer remain visible in a bold HUD banner. Selecting a parameter or instrument page also flashes a short bitmap label over the upper grid for roughly one second; the lower inspector and grid input remain active. Value edits update the HUD without restarting the label. See `docs/parameter-announcements.md` for abbreviations and behavior.
