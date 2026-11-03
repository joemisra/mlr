# Native Phase Cut trial

Phase Cut is a sample-buffer effect shared by MLR and ṛta. The musical decisions
and additional read heads run in gen~, before the existing player fade and group
strip. No external or plugin is required, and no rack slot is occupied.
The original groove~ transport and its grid playhead keep advancing. Bypass
returns to that original playback position with a 15 ms dry/wet fade.

## Try it

Save the active session and close its project before opening a fresh trial
project. Use one edition per Max process; the inherited buses are shared.
New patch topology requires a reload; script autowatch alone is insufficient.

In **HUD → Phase**, choose a group, select **NUDGE** or **SHUFFLE**, then turn
**ON**. **Mod row 6, columns 1–8** provide the same group toggles directly below
the group latch in MLR or pattern Run in ṛta. Grid coordinates are one-based.
Brightness 15 means enabled; 3 means off. Browser and scene overlays keep their
own key ownership. The existing per-track random-position toggle remains.

Factory recall keeps the current on/off state. NUDGE makes occasional small
jumps; SHUFFLE adds moderate jumps and repeats; STUTTER favors repeated segments;
FRACTURE adds wider jumps and occasional reverse playback. USER 1–4 recall a
stored setting; the adjacent SAVE buttons overwrite those slots for the selected
group. Settings and all four slots save in modern sessions. Older sessions open
with Phase Cut off. Session versions and stopped restore behavior are unchanged.

## Controls

| Control | Meaning |
| --- | --- |
| Rate | Decision interval: 1/4, 1/8, 1/16, 1/32 and 1/64 notes, plus 1/8T, 1/16T and 1/32T triplets, using the native shared beat phase. |
| Chance | Probability of applying a cut at each decision. Zero passes dry. |
| Jump /16 | Maximum random displacement in either direction, measured in sixteenths of the active loop. Zero disables jumps. |
| Repeat | Probability of replaying the previous rhythmic segment. Consecutive repeat decisions keep the same anchor. |
| Reverse | Probability of reversing the additional read head relative to the original playback direction. |
| Mix | Dry/wet blend; zero passes dry. |
| Slice ramp | Flat, Fade In or Fade Out over each processed slice. This is independent of the transition crossfade; dry playback is unaffected. |
| Fade ms | Crossfade between decisions, bounded to finish before the next decision. Wraps also receive a short taper. |

The first version supports looping sample playback, including subloops, pitched
playback, reversed base playback, and mono/stereo buffers. Stopped, one-shot,
and time-stretched playback pass dry. The shared beat phase controls decision
timing; the sample playhead supplies speed and position. Decisions are random
and are not persisted or reproduced exactly by a preset. Source and loop-bound
changes reset the additional heads without resetting parameters.

Direct RNBO instrument audio does not enter the sample player, so this prototype
does not process RNBO output. These limitations are deliberate for the initial
audition: native buffer reads cannot reproduce Max's stretched groove~ output.

## Verification

All 471 repository tests pass, covering group routing/toggles, presets, session
preflight/migration, HUD commands/layout, and both edition manifests/topologies.
Both self-contained editions build, and generated Max JSON is validated.

A private silent Max probe compiled the actual gen~ reader and recorded stereo
signals. Off, chance zero, mix zero, stopped, one-shot, and stretching each
matched the dry input exactly after the fade. Stutter, reverse/jumps, runtime
source rebinding, triplet/1/64 rates, and an active subloop produced finite, changed audio while
preserving the test signal's stereo relationship. The test used a private
phasor at 120 BPM in place of the shared beat receive. It did not open or restart
the active performance patch. The Phase page also rendered in the actual Max
v8ui. The user auditioned the first trial and confirmed it worked well.
The timing/ramp extension passed 16 private native signal scenarios; recorded
Fade In/Out gain followed the expected slice envelope, with mean absolute error
below 0.00002 in the sampled slice interiors. The additional ramps and rates
still need a musical audition.

Still audition musical feel and clicks with real loops, tempo changes, rapid
source/subloop changes, repeated toggles, multiple groups, CPU use, hardware
buttons, and saved-session reopen in each isolated edition. Silent signal and
unit checks do not establish listening quality or complete live behavior.
