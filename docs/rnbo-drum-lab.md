# Combined RNBO drum lab

Open `rnbo_drum_lab.maxpat` alongside MLR. It loads one instance each of kick, snare, hat, clap, tom, rim, bell, and FM bass. Tabs select **Kick · 15**, **Snare · 14**, **Hat · 13**, **Clap · 12**, **Tom · 11**, **Rim · 10**, **Bell · 9**, and **FM · 8**; the numbers are their visible sequencer tracks.

All eight voices remain loaded and can play together regardless of the selected tab. Switching tabs only changes visibility. It does not reload an engine, change parameters, trigger a hit, stop a tail, or change Repeat. Scroll inside the selected page to reach its Min/Max fields and range-preset controls. The tabs remain above the scrolling page.

Save any unsaved work in the separate lab windows, then close those windows before opening this combined lab. Keeping a separate lab open as well would create another instance listening to the same triggers and sending audio to the same outputs. The MLR main patch can stay open.

The combined patch references the original lab files rather than copying their DSP or controls. Existing named buses, track assignments, parameter locks, sound presets, and direct audio outputs are unchanged. The Audio switch in any page controls Max's shared audio state.

Grid sound presets continue to save in the MLR session. Range presets remain local to their individual lab: use the page's **write/read** controls to export/import range banks. Saving the combined parent patch does not embed edits into its referenced lab files; use the individual lab patch when saving embedded range slots.

The wrapper starts on Kick. Tab selection is navigation state and is not added to session documents. Structural tests check that exactly eight labs are loaded and that every tab emits visibility commands only. Live tab clicks and embedded scrolling still need a Max check; the existing running labs were not closed or replaced during this change.

The wrapper uses Max's documented [bpatcher presentation view](https://docs.cycling74.com/userguide/bpatchers/) and [thispatcher show/hide messages](https://docs.cycling74.com/reference/thispatcher/).

## 6mix test: individual ES-9 audio outputs

The output selector above the lab pages switches between **Stereo**, **6mix · 4**, and **ES-9 · 8**. It starts in Stereo each time the combined lab opens. **External send** is a shared 0–1 gain, initially 0.5, in addition to each engine's own Level control. Gain changes and audio switching are smoothed.

| Voice | Sequencer track | ES-9 mini-jack | Max device output |
| --- | --- | --- | --- |
| Kick | 15 | 1 | 9 |
| Snare | 14 | 2 | 10 |
| Hat | 13 | 3 | 11 |
| Clap | 12 | 4 | 12 |

This uses the same ES-9 mapping as the existing CV trigger patch. It assumes Max is using that device and its existing output mapping. Connect those four jacks to four 6mix audio inputs. These voices are currently dual mono, so the adapter takes one channel of each named signal bus without summing two identical channels.

In 6mix mode, the drum stereo feeds are muted and CV trigger pulses on jacks 1–4 are suppressed. Jacks 5–8 retain their original CV configuration. The CV interlock stays active through the drum output fade-out. Returning to Stereo restores the previous CV configuration; it does not change `mlr.local.json` or session state. Closing the combined lab removes its signal-bus reservation. Standalone lab instances remain unnecessary and would duplicate the named audio feeds.

**Before the first test, save your work and reload both the main MLR patch and the combined drum lab.** The main patch must load the revised `mlr_cv_outputs` interlock; an already-running old instance cannot suppress CV pulses just because the new lab is open.

This is direct per-voice routing for the external mixer experiment. It does not yet pass drums through MLR group channel strips, group effects, or the main stereo recorder. The 6mix return is not automatically routed back into MLR.

`rnbo_drum_outputs.maxpat` owns the eight device feeds and the temporary output reservation. Automated topology checks cover independent channel mapping, stereo muting, the CV interlock, startup mode, and level limiting/smoothing. Actual ES-9/6mix output levels, physical patching, and mode switching still need a live hardware test.

## Extended voices

See [Tom, Rim, Bell and FM Bass](rnbo-extended-synths.md) for their pages and starting sounds. In **6mix · 4**, the new voices remain on stereo. **ES-9 · 8** adds Tom, Rim, Bell and FM Bass on jacks 5–8 (Max outputs 13–16), mutes their stereo feeds and suppresses that bank’s CV pulses through fade-out. Reload the main patch as well as the lab to activate the upper-bank CV interlock.

## Hachi-ni knobs: focused sound and step locks

Click **Knobs…** in the combined lab, or open `mlr_knob_input.maxpat` directly alongside an already-running MLR. Use only one instance of that input patch. It starts disconnected: choose the hachi-ni **input** port and set its MIDI channel (1 by default). CC **32–47** maps to knobs 1–16. Changing the channel restores this sequential CC mapping. **Learn 16** is optional for other configurations: move each knob in physical order, once each. Learning consumes those messages without editing sounds; Cancel retains the previous mapping. Save map / Load map export/import only the CC/channel bindings, not sound values or ports.

Do not also select the hachi-ni in MLR's **legacy MIDI setup**. Its existing `midi_settings` has overlapping shortcuts, including CC 44/46 on channel 1 for previous/next preset and CC 35/36 on channel 2 for tap/audio. The new adapter does not disable or change those legacy mappings. Choose another device there before enabling this input, and use **Disconnect** in the knob window to stop its input when needed.

- **Grid focus** follows the selected ṛta track, or the instrument assigned to the selected group step. The grid must be on page 2 with an active editor target. The MLR parameter page also supports knobs, including sample tracks; its sequence view must be expanded.
- With no step held, turning a knob edits the instrument's baseline, including the active Track Slot's write-through state. Merely selecting a step does not turn subsequent knob movements into locks.
- **Hold a step + turn** writes a Set lock on that step without altering the baseline. An empty held step receives its normal default trigger when released. A held step takes priority over Live Write.
- **Live Write** records on the current playback step through the existing lock-recording path. Pickup follows the sound baseline rather than re-arming on every clock step. Values continue to update only while the knob sends MIDI; this is not a held-value automation recorder.
- **Lab tab focus** follows the combined lab's tab and edits the sound only. It does not change the grid target, launch a voice, or record grid locks. Opening only the standalone knob-input patch cannot observe tab changes in an older, already-open lab wrapper: save work and reopen the wrapper to install that connection.

Knobs **1–4**, **5–8**, and **9–12** follow the instrument's three four-parameter pages, left to right. This order stays fixed when the grid changes parameter page. For Kick: Pitch / Decay / Sweep / Sweep decay; FM / FM ratio / Click / Drive; Resonator mix / Resonator frequency / Resonator Q / Level. Knobs **13–16** are reserved, not silently assigned to unrelated controls.

On the **MLR parameter page**, knobs follow the visible parameter order: **1** Slice, **2** Probability, **3** Volume, **4** Filter, **5** Reverse, **6** Transpose, **7** Loop division, **8** Gate length. On track targets, **9** is Condition; on group targets, **9** is Track assignment and **10** is Condition. Remaining knobs are reserved. Track assignment chooses only members of the selected group. Reverse is off/on, loop division uses the existing eight choices, transpose covers −96 to +96 semitones, and condition includes Always followed by the positive and negative 2–9 choices.

Hold a step to write MLR locks without changing the current sound; Live Write records the incoming MIDI step and also updates the current playback controls. With neither active, Volume/Filter, Reverse, Transpose and Loop division change their current controls without creating locks. Slice, Probability, Gate length, Track assignment and Condition belong to the selected step and edit that step directly. Selecting the MLR or instrument parameter page changes the knob map and rearms pickup; holding/releasing a step also invalidates queued movements. MIDI/controller and physical-grid verification of this extension remains a separate live test.

Absolute pots use **soft pickup**: move toward the stored value until you reach or cross it. The knob window displays the parameter and pickup direction, then its edited value/layer. Focus, held-step, Track Slot, preset and external parameter changes re-arm pickup. Grid range Min/Max and nonlinear scaling also apply to knobs. If a sound/lock lies outside that span, the controller temporarily widens its own span to include the existing value instead of clipping it on pickup; the saved grid range is unchanged.

Controller mapping, focus source and physical knob/pickup positions are workstation state, never session data. Sound baselines and locks use the existing session schema. The MIDI adapter uses a device-filtered [ctlin](https://docs.cycling74.com/reference/ctlin/) and enumerates input ports via [midiinfo](https://docs.cycling74.com/reference/midiinfo/). Unit/topology tests cover routing and pickup; actual hachi-ni MIDI input, Max dialogs and grid gestures require a live test. No active Max patch was restarted for this implementation.

### MIDI flood protection

The adapter suppresses duplicate CC values and collects a bounded latest-value mailbox, flushed every **33 ms** while input is arriving (about 30 updates/second). It never replays a FIFO of old movements: each knob retains its first pickup endpoint and latest position, with at most 16 entries in a batch. Multiple knobs cannot overwrite each other. The final value flushes even after you stop turning; CC jitter that alternates values is rate-limited but is not deadband-filtered.

The router resolves focus once per batch, sends only the changed engine parameter, and redraws the grid/HUD and knob status once for the batch. Ordinary mouse/lab edits retain their existing full-sync behavior. Musical trigger/clock handling remains on its existing path; only human controller edits are sampled at this lower rate.

Focus changes, held-step press/release, preset recall, session reset and router reload invalidate pending batches. Live Write stamps the incoming adapter message with its playback bar/step so a later batch flush cannot write it into the next step. If the same knob moves again in a newer playback step before a flush, its newer destination/value replaces the older pending one. This is sampled parameter-lock recording, not a promise to record every MIDI value or every step at extreme playback rates.

These changes autowatch in place. Reselect the MIDI input and focus-source selector after a script reload if the controls stop responding; no Max/audio restart is needed. Stress/unit tests verify bounded batching and destinations; musical timing under a real hachi-ni flood still needs a live Max/grid test.
