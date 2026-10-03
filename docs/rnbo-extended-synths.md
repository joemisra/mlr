# Tom, Rim, Bell and FM Bass

Open `rnbo_drum_lab.maxpat` for all eight voices, or open one individual lab alongside MLR. Save your session and any lab edits, then reopen MLR and the combined lab to load the new native trigger branches and output interlocks. Avoid loading standalone labs together with their combined-lab instances.

| Engine | Visible track | Character | Starting sounds |
| --- | --- | --- | --- |
| Tom | 11 | Pitch-swept sine membrane, FM, second shell mode and noise strike | Floor, Rack, Laser |
| Rim | 10 | Two shell modes with a short resonant noise strike | Rim, Wood, Clave |
| Bell | 9 | Decaying FM, independently decaying inharmonic modes and strike | Glass, Metal, Mallet |
| FM Bass | 8 | Tuned FM with feedback, sub oscillator, attack and pitch bend | Round, Rubber, Wire |

Leave the associated sample slots empty to hear only the synths. Existing kick/snare/hat/clap assignments remain 15/14/13/12. These are original engines, not emulations of a particular hardware machine.

Each voice has twelve controls on three pages. Select its track, enter the instrument editor with row 13 column 16, then use row 13 columns 10–12 for the pages. Group patterns follow the instrument triggered by the selected step. The existing lock/base editing, live recording and fine adjustment controls work for the new voices. Step locks return to the track baseline on the next unlocked hit. Setup row 15 columns 8–15 provides eight session sound slots per engine: tap to recall, Shift + tap to store.

| Engine | Page 1 | Page 2 | Page 3 |
| --- | --- | --- | --- |
| Tom | Pitch, Decay, Bend, Bend decay | FM amount, FM ratio, Shell ratio, Shell level | Noise level, Noise decay, Drive, Level |
| Rim | Pitch, Decay, Shell ratio, Shell level | Click, Strike decay, Strike filter, Strike Q | FM amount, FM ratio, Drive, Level |
| Bell | Pitch, Decay, FM ratio, FM index | FM decay, Inharmonicity, Mode level, Mode decay | Strike, Brightness, Drive, Level |
| FM Bass | Note, Decay, Attack, Bend | FM index, FM ratio, FM decay, Feedback | Sub level, Brightness, Drive, Level |

Bass Note is an integer MIDI note number (36 is C2 under middle-C=60/C4 naming). It is independent of the sample transpose control. The bass is a one-shot voice: attack and decay shape each hit; there is no held-note sustain or legato yet. Each engine is monophonic: retriggering it restarts its envelope, while hits on other tracks leave its tail alone. All twelve values are captured at the audio-rate trigger, so later edits leave an existing tail unchanged.

Scroll down within each lab for Min/Max grid spans and the Max range-preset object. These ranges affect grid editing only; physical limits are larger and defined in `synth_engine_catalog.js`. Sound presets live in MLR sessions; range presets use the lab's write/read controls. Extreme FM settings can produce deliberately rough, aliased tones. Default sounds are starting points for listening and range tuning.

The combined output selector offers Stereo, 6mix · 4, and ES-9 · 8. Four-voice mode routes the original drums externally and leaves the new voices on stereo. Eight-voice mode adds Tom/Rim/Bell/FM Bass on ES-9 jacks 5/6/7/8 (Max outputs 13/14/15/16). CV pulses are suppressed only on the occupied output banks, including during fade-out. External routing is workstation state, not session state.

## Development and verification

The readable `rnbo_*_voice.genexpr` files contain the DSP. `scripts/build_rnbo_synth_labs.js` builds the four new host/core adapters from their catalog and the clap adapter structure. Regeneration overwrites the four generated labs, models and range scripts: preserve embedded user range presets before running it. It does not rebuild older engines.

Tests execute the scalar DSP equations at 44.1/48/96 kHz, check finite bounded output and decay, verify per-hit parameter capture, and inspect packet order, grid locks, session presets and output interlocks. These checks do not compile RNBO or verify Max's audio driver, embedded scrolling, or physical ES-9 outputs. The user confirmed on September 30, 2026 that all four new engines work in Max. DPT compilation and hardware playback remain unverified.
