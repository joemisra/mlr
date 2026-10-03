# RNBO hat laboratory

Open `rnbo_hat.maxpat` alongside MLR. Enable audio and use **TRIGGER**, **Repeat**, or visible **Track 13**. Leave that track's sample slot empty for the synth alone. The adapter listens to native `14input` press messages; releases and other tracks do not stop the tail. Audio leaves the first two RNBO outlets, goes directly to outputs 1–2, and is also available on `rnbo_hat_left` / `rnbo_hat_right`.

The original voice combines six inharmonic sine modes and paired ring modulation with noise, followed by a resonant state-variable filter and saturation. **Closed**, **Open**, and **Ring** are editable starting sounds. Metal and noise have separate decays, allowing short ticks, open hats, and longer metallic percussion on one track.

| Grid page | Four controls |
| --- | --- |
| Metal | Metal pitch, Spread, Inharmonicity, Metal level |
| Shape | Metal decay, Noise decay, Attack, Noise level |
| Filter / output | Filter frequency, Filter Q, Drive, Level |

Decay is the approximate time to −60 dB. Attack adds an 8 ms noise transient; it is an amount, not an attack-time control. Inharmonicity moves oscillator ratios away from harmonic spacing, and Spread changes their separation. Filter frequency shapes both metal and noise. Drive adds saturation; extreme settings can introduce aliasing.

All twelve controls latch at each hit. Editing settings during a tail affects the next hit. A new hat hit restarts the monophonic envelopes and filter, so a short locked hit can cut off an open hat. Independent overlapping hat voices and a separate choke group are not implemented.

## Grid use

Coordinates are one-based from the top left of the logical 16×16 grid.

- Open Track 13's pattern editor, or select a group step assigned to Track 13.
- Row 13, column 16 switches to hat parameters.
- Row 13, columns 10–12 select the page; columns 5–8 select a parameter.
- Select a step and set its lock on row 14. Row 15, column 3 switches to baseline editing; column 2 is Live Write.
- Setup row 15, columns 8–15 holds eight independent hat sound presets. Tap to recall; hold Shift (bottom row, column 12) and tap to store. The grid flashes HP1–HP8.

Unlocked hits return to the manual baseline. Group overrides win on the merged hit without changing stored phrase locks. Sessions and Track Slots retain baselines and locks; the session also saves the hat preset bank. Preset recall remains manual and does not write locks.

The lab's Min/Max fields define the grid span for each control. The Max preset object stores these 24 range fields separately from sound presets. `hat_instrument_model.js` defines physical limits, defaults, and scaling. `rnbo_hat_voice.genexpr` is mirrored into the RNBO codebox in `rnbo_hat_voice.rnbopat`.

## Loading and validation

Save any current work before reopening the main patch to load the updated native audio bridge; V8 router code can autowatch, but that does not reload Max patch wiring. Keep the hat lab open while sequencing it.

Automated tests cover control mapping, pages and popups, per-hit packets and baseline restoration, sound-bank/session persistence, cache-before-trigger wiring, ranges, and RNBO audio outlet metadata. A JavaScript evaluation of the DSP equations checks finite bounded output at 44.1/48/96 kHz, tail decay, and parameter capture. This is not an RNBO compiler or hardware test. Live compilation and listening remain unverified: Max's file chooser did not respond to automation during development.

Named buses: `rnbo_hat_trigger` (bang), `rnbo_hat_param` (e.g. `metalHz 900`), `rnbo_hat_repeat` (0/1), and the stereo signal buses above. Controllers may send `instrumentManual 13 hatDecay 900` to `gridrouter`.
