# Grid color math and atomic MechaTrellis OSC

Status: Max compositor plus the private MechaTrellis v2 firmware, libmonome,
serialosc, and MLR encoders implemented 2026-08-16. Brightness-only Scene/Group
behavior was baselined first. Capability negotiation and broader palette tuning
remain deferred.

## The useful part of the SNES model

The SNES did not provide a general stack of modern alpha-blended layers. It
resolved a main-screen pixel, selected either a sub-screen pixel or one fixed
color, and applied a small set of per-channel operations: saturating add,
half-add, saturating subtract, or half-subtract. Masks selected which main-screen
layers and window regions participated. H-DMA could change the fixed color or
settings during display, creating rich effects from a deliberately small system.

That constraint is the relevant inspiration for MLR:

- keep only a few named visual layers;
- give each layer a small, predictable set of math operations;
- use masks and strength animation instead of inventing a final RGB color for
  every compound state;
- compose once into an authoritative output frame.

MLR may add multiply because it is particularly useful for dimming and tinting,
but multiply is an MLR extension rather than an SNES color-math operation.

Primary reference: the translated *SNES Development Manual*, Book I, sections
7.1–7.3 and the CGSWSEL/CGADSUB/COLDATA register descriptions:
<https://floating.muncher.se/bot/manual/book1_text.pdf>.

## Non-negotiable MLR rules

1. Every cell has one canonical brightness value from 0–15. That brightness
   frame must completely communicate available, stored, selected, active,
   queued, held, destructive, and unavailable states.
2. Semantic color decorates that state. Changing a theme or disabling color
   cannot change grid behavior or make a control ambiguous.
3. The HUD and physical grid should be projections of the same composed frame,
   not independently rendered approximations.
4. Hardware capabilities and color preferences are workstation-local. They do
   not belong in session documents.
5. Musical launch/step timing remains on the audio-derived/native paths. This
   system concerns display composition and transport only.

## Three visual layers

Use exactly three conceptual layers rather than the current collection of
mostly final, compound colors.

### 1. Role

The stable identity of the cell: group, navigation, continuous value, time/rate,
record, destructive action, sample, trigger, or neutral data. Role supplies the
base RGB color. It does not decide whether the cell is selected or moving.

Hue should normally answer “what kind of thing is this?” Group hues remain
stable anywhere group identity is useful.

### 2. State

A durable modifier such as selected, stored, locked, armed, disabled, borrowed,
or shared. State applies one color-math operation and a strength to the Role
color. Brightness still carries the durable state for a monochrome grid.

### 3. Motion

A transient modifier such as pressed, auditioning, playhead, queued, triggered,
confirmation, or error. Motion has the highest visual priority. Its strength can
be keyframed to create flashes, pulses, and fades without replacing the cell's
role identity.

This gives a cell a compact description:

```text
level: 0..15                 canonical and sufficient on its own
role: RGB                    stable meaning
state: op + RGB + amount     optional durable modifier
motion: op + RGB + amount    optional transient modifier
```

## Small color-math vocabulary

Operate independently on R, G, and B, clamp every result, then interpolate from
the input toward the operation result by `amount` (0–255).

```text
replace(a, b)  = b
add(a, b)      = min(255, a + b)
half_add(a, b) = floor((a + b) / 2)
sub(a, b)      = max(0, a - b)
half_sub(a, b) = floor(max(0, a - b) / 2)
mul(a, b)      = round(a * b / 255)       # MLR extension
```

The first experimental modifier vocabulary should stay small:

| Modifier | Suggested treatment | Brightness-only companion |
|---|---|---|
| Selected/current | half-add white | selected level |
| Locked/shared | add a restrained violet/blue operand | lock level/pattern |
| Unavailable | multiply by a dim neutral | unavailable level |
| Queued | animate add-amber strength | existing 15 ↔ 3 flash |
| Playhead/triggered | short add-cyan or half-add-white pulse | existing pulse |
| Held/audition | half-add white | held level |
| Confirm/error | alternate add-white and subtract-red | confirmation flash |

These are starting rules, not a final palette. They should be tuned on the real
LEDs through the Color Lab after the state vocabulary is stable. Theme colors
remain 8-bit for compatibility with current sessions and controls. Optional
5-bit quantization can later be offered as an aesthetic, but is not part of the
wire protocol or state model.

## One composed frame

The matrix bridge should become the final display compositor because it already
owns foreground/background levels, transient animation masks, hardware sizing,
dual-grid routing, HUD snapshots, and outgoing OSC.

The first migration should preserve the existing level equation exactly:

```text
baseLevel = max(foregroundLevel, backgroundLevel)
finalLevel = motionMask ? motionLevel : baseLevel
```

Color composition happens alongside it:

```text
stateRGB = apply(roleRGB, stateModifier)
finalRGB = apply(stateRGB, motionModifier)
finalCell = { level: finalLevel, rgb: finalRGB }
```

The bridge publishes `finalCell` to the HUD and chooses a hardware encoder only
after composition. This prevents color and brightness caches from describing
different moments.

The pure math, clamping, modifier priority, and frame-diff logic lives in
`grid_color_math.js` rather than being duplicated across the router, bridge,
animation engine, and HUD.

## Atomic MechaTrellis protocol v2

Standard serialosc already defines 0–15 single-cell and 8×8 level-map messages.
Those messages remain untouched. The private MechaTrellis v2 extension adds
combined state commands under distinct paths:

```text
<prefix>/grid/led/state/set
    x y level r g b

<prefix>/grid/led/state/map
    x y (level r g b) × 16            # row-major 4×4 block
```

`state/set` makes a sparse cell update indivisible. `state/map` replaces the
current separate 4×4 color map and later 8×8 brightness map with one 4×4 update
whose RGB and level values become visible together.

Whole-page changes need a staged framebuffer to prevent tearing between the
sixteen 4×4 blocks:

```text
<prefix>/grid/led/frame/begin  frameId width height
<prefix>/grid/led/frame/map    frameId x y (level r g b) × 16
<prefix>/grid/led/frame/commit frameId
<prefix>/grid/led/frame/abort  frameId
```

`begin` seeds staging arrays from the visible frame. Valid maps update only the
staged state. `commit` copies a complete frame into the firmware's authoritative
visible arrays; unknown, incomplete, stale, or aborted frame IDs do nothing.
Physical NeoTrellis tiles are still refreshed sequentially over I2C on the next
firmware display pass, so the guarantee is transaction visibility at the device
state boundary, not a physically simultaneous sixteen-tile bus write.

For two physical 128 grids, each device can commit its own half atomically, but
there is no honest claim of a simultaneous cross-device swap. Send both commits
back-to-back and document that boundary.

## Capability negotiation and fallbacks

The private extension remains write-only and manually enabled. A future
query/reply should report at least:

- protocol version;
- combined `state/set` support;
- combined 4×4 `state/map` support;
- staged framebuffer support;
- maximum block dimensions or payload size;
- firmware/device identifier for diagnostics.

MLR then chooses one of three local runtime backends:

1. **classic** — emit only standard serialosc 0–15 level messages;
2. **MechaTrellis v1** — retain the existing separate color and level packets
   as a temporary compatibility path;
3. **MechaTrellis v2** — emit combined sparse updates or staged frames.

The safe default is classic. The ignored workstation configuration may
deliberately select v1 or the matched v2 firmware/host pair. Unknown private
messages are never sent speculatively to a normal grid.

The standard serialosc reference is:
<https://monome.org/docs/serialosc/osc/>.

## Classic-grid projection

Classic compatibility should not be calculated from RGB luminance. Doing that
would make a theme edit silently change the interface state. Instead:

- `finalLevel` is authoritative and is sent unchanged through standard
  `/grid/led/level/map`;
- RGB role/state/motion data is discarded by the classic encoder;
- every animated color modifier has an explicit brightness animation companion;
- tests compare brightness-frame hashes with color enabled and disabled.

Thus the same compositor can drive both devices while preserving the current
brightness contract. Kero checkpoints remain `mechatrellis 0` and
`editorColors 0` until a separate optional-color test pass.

## Relationship to Scene and Group work

Scene view is the best proving ground. Its write-through interaction model uses
brightness for exact active (15), selected (10), stored, empty, shared Track
Slot (8), and queued states. Color can add group identity, Track Slot role, and
motion without redefining those states.

In particular:

- group hue should survive selected/queued/playhead modifiers;
- shared Track Slot provenance remains visible at level 8 before color decorates it;
- queued Scene and pattern flashes keep their existing 15 ↔ 3 behavior;
- global transport and destructive actions retain recognizable role families
  across Sequence, Setup, and Scene views.

## Current Role / State / Motion assignment

The first migrated surface is Scene. Sequence and Setup retain their existing
semantic final-color renderer until the same vocabulary is proven live.

| Surface | Role | State | Motion |
|---|---|---|---|
| Scene row | Scene/sequence cyan | selected and active half-add white | queued add amber |
| Group pattern rows | stable hue for that group | selected half-add white | queued add amber |
| Group Run | stable hue for that group | running half-add white | — |
| Track Slots | restore blue | shared add violet; active half-add white | queued add amber |
| Global transport | Run green, Stop orange, Reset white | current Start/Stop half-add white | — |
| Embedded steps | neutral, trigger cyan, gated green, gate-tail blue | locks add amber/violet; edit cursor half-add white | playhead half-add white; held orange; decisions replace with their outcome color |
| Navigation | stable Sequence/Setup/Shift/Exit roles | selected view remains brightness-authoritative | — |

`grid_color_math.js` now owns the pure operators, modifier interpolation, and
Role → State → Motion priority. `grid_matrix_bridge.js` stores those three
layers, composes the RGB projected to the HUD and optional hardware path, and
derives a temporary Motion modifier from the existing animation mask. Router
level transactions remain unchanged; color layer changes received inside the
same `beginupdate` are held until `endupdate`.

MechaTrellis v1 still receives the two legacy packet families. Explicit v2 uses
combined sparse packets and complete staged frames. A 16×16 page is 18 serial
packets and 1,094 bytes; the matched POSIX host writer retries partial writes
and bounded `EAGAIN`/`EWOULDBLOCK` waits so the burst remains ordered.

## Recommended implementation order

1. **Complete:** finish and baseline-test Scene/Group behaviors with color off.
2. **In progress:** assign Role, State, and Motion across the editor. Scene is
   migrated; Sequence and Setup still need conversion from compound colors.
3. **Complete:** specify and implement v2 serial IDs `0xAA`–`0xAF`, combined
   state packets, a 1,024-byte 16×16 staging budget, and host packet tests.
4. **Complete:** add the pure color-math module and bridge-side three-layer
   compositor while leaving the separate v1 hardware output intact.
5. **Complete:** add combined `state/set` and `state/map` through firmware,
   libmonome, serialosc, and the MLR bridge.
6. **Complete for one 16×16 device:** add begin/map/commit/abort, complete-frame
   validation, explicit workstation enablement, and page-switch burst exercise.
   Reconnect recovery and two-device live testing remain separate gates.
7. Migrate the animation engine to Motion modifiers and tune the palette on
   hardware through Color Lab.
8. Keep v1 for one release, then decide whether its visible split updates are
   worth maintaining.

## Verification gates

- Pure tests for every color operator, clamp boundary, strength, and priority.
- Existing level-frame tests remain byte-for-byte unchanged.
- With color enabled and disabled, all canonical level hashes are equal.
- Combined packets carry the same level/RGB pairs published to the HUD.
- A staged frame cannot commit until all declared blocks are valid.
- Dropped, duplicated, reordered, stale, and aborted frame IDs do not expose a
  partially new page.
- Hot-plug/recovery resends one authoritative composed frame without recalling
  volatile device state.
- Live Max tests distinguish one-grid MechaTrellis v2, two-grid routing, legacy
  MechaTrellis v1, and ordinary serialosc hardware.

## Deferred decisions

- Exact default RGB palette and LED gamma/calibration curve.
- Whether 5-bit quantization is useful as an optional visual mode.
- Capability query/reply and automatic backend selection.
- Whether device-side procedural animation is useful. Version 2 should send
  final composed state first; do not put semantic UI logic in firmware unless
  bandwidth measurements later justify a separate, optional facility.
