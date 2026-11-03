# Eight-voice drum instrument — Max + DPT

Open `Drum Instrument.maxproj`, then `Drum Instrument.maxpat` if the front panel
doesn't open automatically. This is a standalone development handoff, separate
from MLR and ṛta. Use Max 9 with RNBO available. No grid, serialosc externals,
Node service, samples, or main MLR/ṛta patch is required.

Run one instrument instance in a Max process. Close other MLR/ṛta/lab instances
first, after saving their state: the inherited sound-control buses are shared.

## Hear it in Max

1. Choose the MIDI input at the top. `from Max 1` receives messages another
   application sends to the corresponding Max virtual MIDI destination. For
   another patch in the same Max process, the named input below is simpler.
2. Leave the embedded lab on **Local RNBO**, enable **Local audio**, and choose
   the desired interface in Max's Audio Status. Audio goes to outputs 1 and 2.
3. Send nonzero-velocity notes on channels 1–8. Any note triggers percussion;
   Bass follows note pitch, clamped to MIDI notes 12–96. Note Off and velocity
   zero do not choke tails. Velocity scales Level for that hit only.
4. Use the eight tabs to edit sounds. Local level starts at 0.25; raise it as
   needed. The page's trigger button also auditions the selected voice.

| MIDI channel | Voice | Parameters, in CC 20 → 31 order |
|---|---|---|
| 1 | Kick | Pitch, Decay, FM, Sweep, Sweep decay, FM ratio, Click, Drive, Resonator mix, Resonator Hz, Resonator Q, Level |
| 2 | Snare | Body Hz, Body decay, Body FM, Body bend, Noise decay, Noise Hz, Snap, Drive, Body level, Noise level, Noise Q, Level |
| 3 | Hat | Metal Hz, Decay, Spread, Inharmonicity, Noise decay, Filter Hz, Attack, Drive, Metal level, Noise level, Filter Q, Level |
| 4 | Clap | Count, Burst decay, Spacing, Scatter, Tail decay, Filter Hz, Brightness, Drive, Balance, Tail level, Filter Q, Level |
| 5 | Tom | Pitch, Decay, Bend, Bend decay, FM amount, FM ratio, Mode ratio, Mode level, Noise level, Noise decay, Drive, Level |
| 6 | Rim | Pitch, Decay, Mode ratio, Mode level, Click, Noise decay, Filter Hz, Filter Q, FM amount, FM ratio, Drive, Level |
| 7 | Bell | Pitch, Decay, FM ratio, FM index, FM decay, Inharmonicity, Mode level, Mode decay, Strike, Brightness, Drive, Level |
| 8 | Bass | Note, Decay, FM index, FM ratio, FM decay, Feedback, Sub level, Brightness, Attack, Bend semitones, Drive, Level |

CC 0–127 uses each engine's original grid range and curve, matching the DPT
firmware. It does not remap itself when the lab's editable min/max fields change.
`DPT/midi-map.json` gives the precise ranges, physical units, defaults and curves.
Lab controls use physical units and can reach the broader internal limits.

Each voice is monophonic. Retriggering replaces that voice's envelope; release
does not cut its decay. This is not a polyphonic sampler or synth.

## Connect an algorithmic sequencer patch

Use `[makenote]` / `[noteout]` to send ordinary MIDI to the selected input port.
For direct communication in the same Max process, send raw MIDI bytes to:

```
[s drumkit_midi_in]
```

It accepts single bytes or lists. Examples (decimal bytes):

```
144 36 100    kick, channel 1, velocity 100
146 42 90     hat, channel 3, velocity 90
151 48 100    bass, channel 8, note 48
176 20 64     channel 1, CC 20 (kick pitch), value 64
```

The top-level patch also has one raw-MIDI inlet if instantiated as an abstraction.
Note/CC decoding and triggering use native Max objects, with no JavaScript
scheduler in the incoming MIDI path. The V8 scripts maintain the lab range UI.

## Use the DPT

In the embedded lab, refresh ports, choose **Daisy Seed Built In** (or the MIDI
interface wired to DPT DIN input), then select **DPT USB MIDI**. Despite the mode
label, the chosen destination can be USB or DIN. Incoming MIDI is relayed to that
port; local note generation is disabled by default. Enable **Also monitor local
audio in DPT mode** (and Local audio) to hear both destinations together. Lab edits and audition buttons also
send to the hardware. Listen to DPT audio outputs 1–2; it produces dual mono.

You can instead have your sequencer send ordinary MIDI directly to DPT. Channels
and CCs are identical. Avoid routing DPT input back into itself through a MIDI
loop. Switching destination does not replay old notes. Returning to local uses
its existing local sound settings; there is no hardware-to-editor state readback.

DPT panel controls 1–8 follow the voice order above. The first 75% of travel
fades the channel to unity; the final 25% adds up to 4× soft drive. At zero the
channel is muted. For an initial test, set all eight to about 75%. These act on
top of sound parameters and affect ringing tails. Gate 1 triggers Kick; Gate 2
triggers Snare. MIDI hits also pulse Gate Out 1 for 10 ms.

## Firmware included

`DPT/mlr_rnbo_bank_sram.bin` is the exact previously installed, flash-readback-
verified eight-engine image, including USB/DIN MIDI and the channel level/drive
knobs. It is 272,248 bytes. `DPT/firmware-info.json` and `SHA256SUMS.txt` identify
it. This handoff copies that binary; it does not rebuild or flash the hardware.

This image is for the custom DPT v2.11 / Daisy Patch SM configuration, at 48 kHz
with 48-sample blocks. It is not generic Daisy Seed firmware.

**Application storage is external QSPI at `0x90040000`; execution is SRAM at
`0x24000000`. Do not flash this application at internal flash `0x08000000`.**
The configured board uses Daisy bootloader v6.4 with internal USB DFU and a
2000 ms window. Its bootloader binary is included separately as
`DPT/dsy_bootloader_v6_4-intdfu-2000ms.bin`. The bootloader and application are
different images with different destinations. Keep the working bootloader on an
already configured DPT; installing a bootloader can erase existing internal
firmware. Back up a new board first and confirm the hardware configuration.

The known installation used an ST-Link RAM helper to write the application to
QSPI, followed by an exact readback comparison and reset. Earlier USB DFU uploads
had unreliable readback, so a reported successful upload alone is insufficient.
The bundle includes the exact helper binary and its source under `DPT/ST-Link/`;
this is an advanced recovery aid, not an automatic installer. It must be loaded
and run in SRAM by a debugger, never programmed into internal flash. Its
`flash_go` variable deliberately defaults to zero so loading it does not erase
anything. Configure a proper installation session before setting that variable.

The firmware C++ source and exported RNBO runtime are in `DPT/source/`.
Building additionally requires the compatible Oopsy DPT driver, libDaisy and ARM
compiler; those large vendor dependencies are not bundled. `build-inputs.json`
records the source/dependency hashes from the verified build. `build.py` builds
only; it never flashes hardware. The generated C++ is included for inspection;
the Max patches contain the editable RNBO engines.

## Validation and scope

This bundle is generated from the working source checkout, including uncommitted
work, and is labelled a development snapshot in `SOURCE.json`. It is not a
versioned MLR or ṛta release. The handoff builder checks firmware identity and
ships only instrument dependencies. Source tests and patch topology checks do
not replace a listening test in an isolated Max process or a hardware test.
