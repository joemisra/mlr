# MLR Modulation Roadmap

Updated 2026-08-11. This is a parallel project plan, not a promise to fold the
whole Crow runtime into the sequencer at once.

## Current implementation status

The persistence portion of M0 is complete after live clean-restart Save/Save As
verification; the final Kero archive and interaction pass remain. The M1
vertical-slice code is implemented: session-version migration, a portable
four-source route model, native per-group LFO/ADSR/AR generation, signed Filter
depth, hit/release/Stop triggers, HUD route feedback, and a brightness-first
inline Filter source/depth controls in the persistent inspector. The native
objects load successfully in Max; a clean root-patch reload and audible filter
smoke test are still required before calling M1 complete. M2 remains open for
source-rate and envelope-time controls on the grid, an exact-zero gesture, live
source activity feedback, and extended play testing before more destinations
are added.

Extended step-editor feedback led to a persistent contextual inspector rather
than a hold-only modulation overlay. The implemented interaction and remaining
hardware checks are captured in
[persistent-step-inspector-plan.md](persistent-step-inspector-plan.md).

## Order of work

1. Stabilize full-session save/load and run a real Max round trip.
2. Make a brightness-only build for Kero and collect interaction feedback.
3. Add a small native modulation bank and one end-to-end destination: Filter.
4. Add the grid modulation matrix and persist it in sessions.
5. Prototype an ASL compatibility layer as an isolated research track.

This order keeps Kero's test build understandable and gives ASL a stable target
API instead of making it responsible for inventing the modulation engine too.

## Kero checkpoint

The first handoff should use standard 0–15 brightness as the complete visual
state. Leave `editorColors 0` and the private MechaTrellis color extension off.
The HUD can remain available; it is useful for seeing state that the grid cannot
explain on its own.

Before packaging:

- Save As to a path containing spaces and confirm a `Name.mlr-session` folder
  contains `session.json` plus any referenced recording/plugin sidecars.
- Change BPM, one track assignment, one group strip value, and one ṛta pattern;
  open the saved session and verify all four restore with transport stopped.
- Confirm New/Open dirty prompts and a missing-sample warning.
- Exercise Main, Mod, Groups, Sequence, Setup, and the split sample browser with
  semantic colors disabled.
- Run the existing complete test suite and package only after the live round
  trip passes.

## Standard modulation bank (first useful slice)

Start with four target-local sources:

| Source | Initial controls | Trigger behavior |
| --- | --- | --- |
| LFO 1 | rate, shape, phase, bipolar/unipolar | free or transport-reset |
| LFO 2 | rate, shape, phase, bipolar/unipolar | free or transport-reset |
| ADSR | attack, decay, sustain, release | gate from a track/group hit |
| Envelope/AR | attack, release, curve | retrigger from a step or live cut |

The internal contract should be independent of the UI and scripting language:

```text
source value: -1..1 (bipolar) or 0..1 (unipolar)
route: { scope, targetId, parameterId, sourceId, amount: -1..1 }
result: clamp(base + sum(source * amount), parameter range)
```

Use the existing per-group `#1[filterfx]level` ramp as the first destination.
It already reaches the fourth inlet of `mlr_filter` and proves the matrix
without changing every DSP stage. Configuration belongs in the router/session
model; continuous generation should live in native Max/MSP objects rather than
low-priority JavaScript callbacks. After Filter works, add Volume, Pan (if/when
the strip has it), Drive, Trim, compressor controls, and plug-in parameters
through explicit adapters.

Precedence must be deterministic:

1. durable base value;
2. persistent sequencer Set lock;
3. active one-shot/Gate shape;
4. modulation-matrix sum;
5. parameter clamp and smoothing.

Stop should release triggered envelopes and one-shot shapes. Free-running LFOs
may continue unless the source is configured for transport reset. Restoring a
session must restore routes but leave triggered sources stopped.

## Grid modulation matrix

The first routing slice now reuses the persistent selected-parameter context in
ṛta instead of adding another page:

- A normal parameter tap continues to select/edit the step lock.
- Filter exposes LFO 1, LFO 2, ADSR, and AR on row 15 columns 12–15.
- Selecting a source temporarily makes row 14 the signed amount lane: columns
  1–8 are negative and columns 9–16 are positive.
- Pressing the lit amount or Delete + source clears the route; pressing the
  selected source again returns row 14 to the step value.
- Source rate/time, activity, polarity, retrigger mode, and an exact-zero
  gesture remain the next control pass without changing the saved step.

The first implementation should make routes target-wide (track or group), not
per-step. A step chooses when an envelope is triggered, while the matrix says
where that source goes and by how much. Per-step matrix overrides can be added
later only if playing the target-wide version shows a real musical need.

Brightness remains authoritative: selected source is bright, configured routes
are medium, zero/clear is dim, and a short pulse shows the live source value.
Optional semantic colors can decorate this but cannot encode unique state.

Suggested saved shape:

```json
{
  "modulation": {
    "sources": { "track:3:lfo1": { "type": "lfo", "rate": [1, 4], "shape": "sine" } },
    "routes": [
      { "scope": "track", "targetId": 3, "parameterId": "filter", "sourceId": "lfo1", "amount": 0.4 }
    ]
  }
}
```

Add this with a session-version migration. Unknown source or destination IDs
must be retained but disabled, just as missing plug-in descriptors are retained.

## Crow ASL compatibility project

ASL is a particularly good fit because it describes journeys rather than a
hardware-specific oscillator. Its reusable core is a small set of segments and
combinators: `to(destination, time, shape)`, sequences, `loop`, `held`, `lock`,
`times`, and dynamic values. Crow's predefined `lfo`, `ramp`, `ar`, and `adsr`
actions are built from that vocabulary.

The reusable center should be a portable C++ library, not a Max-only patch or
external. Embed Lua and expose a deliberately small ASL environment; do not
write a new general-purpose Lua parser. Max and VCV Rack should be thin hosts
around the same engine:

```text
asl-core (C++ + embedded Lua)
    |- deterministic ASL compiler/runtime and curve tests
    |- normalized virtual inputs/outputs and trigger directives
    |- no Max SDK, Rack SDK, UI, USB, or audio-device dependency
    |
    |- Max external: messages/signals, dictionaries, transport, parameter buses
    `- VCV Rack module: ports, params, lights, sample-rate process callback
```

The project should not begin by porting Crow's physical `input`, `output`, `ii`,
USB, or CV calibration APIs. Instead:

```text
ASL/Lua expression
    -> validated neutral shape IR
    -> MLR virtual modulation voice
    -> ordinary modulation route
    -> Filter/Volume/etc. adapter
```

Map `output[n]` to a named virtual source. Calling it with `true`, `false`, or
`release` becomes a trigger/release directive; assigning volts becomes a
normalized destination after an explicit range conversion. Keep seconds as the
compatible default and add MLR beat/rational durations as an extension rather
than changing ASL meaning.

There is a bundled `jit.gl.lua` object in the installed Max distribution, and
Cycling '74 documents it as usable for general-purpose Lua as well as graphics.
It remains useful for a disposable semantics spike, but production code should
embed Lua in `asl-core` so that Max and Rack execute the same language and tests.
The safer milestone is:

1. Run unmodified declarative examples such as `loop{to(1,1),to(-1,1)}`.
2. Compile them to the neutral IR and compare sampled output against fixtures.
3. Implement all nine Crow transition shapes.
4. Add held/release, lock, times, and dynamic variables.
5. Load a small real Crow script after sandboxing or stubbing hardware globals.
6. Expose four ASL voices beside the standard bank in the same matrix UI.
7. Build the same fixtures through a minimal VCV Rack host before expanding the
   hardware compatibility surface.

Acceptance is behavioral compatibility for the supported ASL subset, not the
claim that arbitrary Crow scripts run unchanged. Scripts that depend on `ii`,
physical inputs, calibration, coroutines, or Crow timing internals should fail
with a clear unsupported-capability report.

Primary references:

- Monome Crow scripting/ASL reference: https://monome.org/docs/crow/reference/
- Monome Crow Max integration: https://monome.org/docs/crow/max-m4l/
- Cycling '74 Lua in Max: https://docs.cycling74.com/max8/vignettes/lua_in_max_topic

Before copying implementation code from Crow, inspect and record the exact
license and attribution requirements of the source revision used. Keep the
portable core in a separable directory/repository with its own documentation,
examples, fixtures, and license so it can become a useful public project rather
than an MLR-only implementation detail.

## Milestones and exit criteria

### M0 — persistence + Kero build

Live save/open round trip succeeds twice, brightness-only workflows remain
readable, and the handoff archive opens without local developer paths.

### M1 — Filter modulation vertical slice

One LFO and one ADSR can modulate Filter with signed depth, visible feedback,
clean Stop behavior, unit tests, and session persistence.

### M2 — usable matrix

All four standard sources are configurable from the grid, routes survive
target/page changes, and no matrix gesture creates or erases a step lock.

### M3 — ASL compiler prototype

The supported declarative subset compiles to neutral IR and passes curve,
directive, looping, cancellation, and dynamic-value fixtures without hardware.

### M4 — integrated ASL voices

ASL voices appear as ordinary sources, use the same routing and persistence,
and can be replaced or stopped without leaving parameter ownership behind.

### M5 — portable public hosts

The same core and conformance fixtures build in a Max external and a minimal
VCV Rack module. Host-specific code contains no duplicated ASL semantics.
