# BBCut-style insert investigation

Research date: 2026-10-04. Feasibility and source review only; no plugin was
installed, built, or exercised in Max, and no runtime topology was changed.

Follow-up: the user approved a LiveCut trial after this investigation. See
[the implementation and audition notes](livecut-trial.md) for the native build,
group toggle and current verification status. The findings below describe the
initial investigation, before that implementation.

## Recommendation

A toggleable, tempo-synchronised live cutter is feasible. Audition a modern
LiveCut VST3 build in the existing group rack first: it is a direct BBCut
descendant and the shortest route to judging the musical result. If that
behavior is useful, prototype a dedicated stereo Max/Gen insert with native
timing and a small phrase generator. Keep SuperCollider out of the production
audio path unless running BBCut2 itself becomes a specific requirement.

The current insert boundary is **per group**, not independently per sample
track. Tracks sharing a group would share the cutter and its captured history.
A true per-track implementation needs an explicit ownership/routing design;
the existing rack alone does not provide it.

## What makes BBCut interesting

BBCut models phrases containing blocks of repeated cuts. Cut duration and
repeat count depend on the procedure and musical context; phrase endings can
produce rolls/fills. This is the behavior worth retaining, beyond random
stuttering. LiveCut implements a subset of BBCut, not the whole BBCut2 system.
See the [LiveCut VST3 documentation](https://github.com/scheffle/Livecut).

BBCut2 also supports live input: its help shows `CutStream1` with an explicit
buffer and clock, as well as file-based cutting. The archived SuperCollider
quark describes event analysis and beat induction and requires sc3-plugins.
For an MLR insert, use MLR's existing tempo/phase initially; audio beat tracking
is unnecessary for already synchronised playback.
Sources: [BBCut2 help](https://github.com/nhthn/BBCut/blob/master/HelpSource/Classes/BBCut2.schelp),
[BBCut repository](https://github.com/nhthn/BBCut).

## Candidates

| Candidate | What it provides | Assessment for MLR |
| --- | --- | --- |
| [LiveCut VST3](https://github.com/scheffle/Livecut) | BBCut-derived live cutting in a VST3 port; documented CMake/VST SDK build | First audition candidate. Actual local build, native architecture, transport response and stability remain unverified. |
| [LiveCut DPF fork](https://github.com/eventual-recluse/LiveCut) | Another port, listing VST3 among its build targets | Alternative build route. Its macOS instructions say it should build; that is not a tested compatibility guarantee. |
| [LiveCut 64-bit build notes](https://github.com/mrbfrank/Livecut-64bit) | AU and VST3 fork build instructions, including an Apple Silicon/Intel universal AU recipe | Useful build references; do not mistake instructions for verified downloadable native binaries. |
| [Max `stutter~`](https://docs.cycling74.com/reference/stutter~/) | Input-history capture, signal-triggered copying into a playback buffer, phase-driven playback | Strong stock-object prototype option. Needs stereo coordination, envelopes, timing logic and phrase generation. |
| [LyonPotpourri](https://github.com/ericlyon/LyonPotpourri3.0-MaxMSP) `el.chopper~` / `el.stutter~` | Buffer playback chopping/stuttering | Relevant external building blocks, not documented BBCut phrase engines. Live capture and musical scheduling still need integration. |
| [karma~](https://cycling74.com/articles/get-the-karma-package-by-rodrigo-and-raja) | Varispeed live looper external | Useful if recording/overdubbing becomes central; the cited description does not establish BBCut-style phrase generation. |
| [softcut-msp](https://github.com/catfact/softcut-msp) | Max port of monome/norns softcut; source and test patch | Possible audio-engine reference. README uses Max SDK 8.0.3/Xcode; current native compatibility requires a build/test. |
| BBCut2 through SuperCollider | Original procedures and SC runtime | Useful reference/audition environment, but adds server lifecycle, clock coordination and audio routing to an otherwise self-contained Max insert. |

Eric Lyon's [download page](https://disis.music.vt.edu/eric/main/lyonpotpourri/)
lists an arm64 package dated August 2022. This is evidence of an Apple Silicon
build option, not verification of these objects on this workstation.

No ready-to-drop-in Max external implementing the full BBCut2 system was
established by this investigation. Existing loop engines still leave the
phrase-level decisions to us.

## Repository integration findings

The actual connections in `pl.maxpat` run:

```text
groove~ -> fade -> channel_strip #1 -> mlr_plugin_rack #1
        -> legacy group gain/mute/output routing
```

The rack has four serial slots per group. `mlr_plugin_slot.maxpat` uses
`vst~ 2 2 @autosave 0 @legacytransport 0`. The documented supported effect
formats are VST3/AU; legacy VST2 is rejected. Tempo and global Start/Stop are
mirrored to Max Global Transport in 4/4. This gives a LiveCut audition an
existing host, bypass control and plugin snapshot persistence, but does not
prove a particular fork follows transport correctly.

`mlr_plugin_slot.js` fades dry/wet and sends `disable 1` after bypass. A live
cutter cannot keep capturing while suspended. Re-enabling could expose old
history or require refill, depending on the plugin. Test this explicitly;
if necessary use a plugin's own transparent processing mode while leaving
the host active, provided that mode actually continues capture.

The legacy `djfxxx-0.2.maxpat` also contains a stutter subpatch and an incoming
stereo buffer. It is a local reference worth auditing separately, not evidence
that BBCut-like phrase logic is already present.

## Proposed native version

Start with one stereo group instance after the strip and before the plugin
rack, so later plugins can process its output. Keep the source player running:
the insert captures its output and changes what is heard, without seeking the
source or fighting manual/sequence cuts.

- Keep a bounded stereo history buffer, including while audibly bypassed.
  Maintain valid-history length; never read unwritten or overwritten material.
- Drive cut boundaries and read heads from native/audio-rate timing tied to
  MLR. JavaScript may prepare bounded phrase tables ahead of time, but must
  not schedule individual audible cuts. If a table arrives late, pass through
  until the next valid boundary.
- Use shared L/R cut decisions, protected playback regions or capture copies,
  and short overlapping envelopes to avoid discontinuities.
- Begin with phrase length, rhythmic subdivision, repeat probability/range,
  and phrase-end fill probability. Reverse and pitch changes can follow.
- Provide quantised enable and a short fade to exact dry on disable. Keep
  requested/armed/audible states distinct when history is not ready. A
  brightness-only grid indication must communicate these states.
- Specify whether a source-track change clears history (recommended default)
  or deliberately allows a cross-track tail. This is especially important for
  group-owned inserts.
- Stop/session open invalidates history and pending cuts. Restore durable
  controls and enable preference without starting playback; refill on resume.
  Do not serialize captured audio, read heads, or temporary phrase position.

A live insert can only reuse audio already received. Capturing history does
not inherently require delaying the dry path, but wet output intentionally
revisits the past. Warm-up, read/write safety and any actual algorithm latency
must be measured separately. Do not assume that reporting plugin latency
means MLR automatically compensates other groups.

## Audition and acceptance sequence

1. Build or obtain a native VST3/AU candidate and test it in an isolated Max
   patch before loading an active performance session. Preserve unsaved work.
2. Verify stereo input/output, BPM changes, transport restart and phrase
   alignment. Listen for the contextual repeats/fills that distinguish it
   from a conventional stutter.
3. Test rack bypass/re-enable after a long pause and after a different track
   plays through the group; check for stale audio and refill gaps.
4. Test clicks, wet/dry level, silence, buffer edges, sample-rate changes and
   several simultaneous instances. Measure timing and CPU under UI activity.
5. Confirm snapshot round trip and session open remain stopped; verify missing
   plugin fallback stays dry. Assess grid control separately from plugin UI.
6. If moving to native implementation, test phrase durations/repeat bounds and
   topology with the repository suite, then exercise actual audio and grid
   behavior in Max. Run `npm test`, `jq empty` on edited patches, and
   `git diff --check` as required by `AGENTS.md`.

This investigation only adds documentation. Runtime tests and hardware checks
have not been performed.
