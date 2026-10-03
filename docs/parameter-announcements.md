# Parameter announcements

The ṛta step inspector shares one parameter focus state with the HUD and a transient grid label. It covers the twelve kick parameters, twelve snare parameters, and the existing sample step parameters.

## HUD

Selecting a parameter shows its full name prominently, its value and unit, and Track/Group, Bar, Step, and editing layer. The banner remains until the parameter/context changes or the inspector closes. Values update without flashing the grid label again. Smaller HUD windows use a compact two-line banner.

- **Baseline**: editing the manual instrument value.
- **Track lock**: editing the selected step's reusable track-phrase lock.
- **Group override**: editing the selected group-pattern step's instrument override.
- **No step lock · current value**: the selected step has no explicit lock; the display shows the current effective property value, which may include an active Glide or another longer shape.
- **Step value / Step assignment**: properties stored directly on the step, such as probability or track assignment.

The banner describes the editor's selection, not a claim that its step is currently sounding. Live Write follows the playback step and identifies that mode. Lab edits update the banner when they affect the currently selected value; the lab's other controls do not switch the inspector's selection.

## Grid

On parameter selection, a centered 3×5 bitmap abbreviation appears in the upper eight rows. Four letters fit the logical 16-column grid. The label appears immediately, holds for 500 ms, and fades over 500 ms. Choosing another parameter replaces it; ordinary value edits and step movement do not restart it. Leaving parameter context cancels it.

Kick labels: **PCH** Pitch, **DEC** Decay, **SWP** Sweep, **SWD** Sweep decay, **FM** FM amount, **RAT** FM ratio, **CLK** Click, **DRV** Drive, **MIX** Resonator mix, **FRQ** Resonator frequency, **RQ** Resonance, **LVL** Level. Pressing kick page 1, 2, or 3 always shows **BODY**, **FMAT**, or **RES**, including reselecting the current page. The HUD shows the full selected parameter name alongside the page number and full page name. Entering the kick inspector initially announces its selected parameter.

Snare labels: **BHZ** Body pitch, **BDC** Body decay, **BND** Body bend, **BFM** Body FM, **NDC** Noise decay, **NFQ** Noise frequency, **NQ** Noise Q, **SNAP** Snap, **BLV** Body level, **NLV** Noise level, **DRV** Drive, **LVL** Level. Snare pages announce **BODY**, **NOIS**, and **MIX**. The HUD identifies the engine as Snare and gives its page number and full page name.

Other labels: **SLC**, **PROB**, **VOL**, **FILT**, **REV**, **NOTE**, **DIV**, **GATE**, **TRK**, and **COND**.

During the hold, glyph cells use brightness 15 and the surrounding upper-half cells use brightness 2 for contrast. Fading blends back to the latest underlying brightness. Optional glyph color blends toward white and back to the live role/state/motion color. Standard monochrome 0–15 brightness carries the complete label; the private color extension is unnecessary.

Rows 9–16 remain untouched. Key presses retain their normal meaning while text is visible. The overlay does not pause playback or take ownership of grid input.

## Implementation and verification

`grid_router.js` publishes `parameter_focus` to the HUD and sends `parameterLabel` / `parameterLabelClear` to the matrix bridge on selection/context transitions. Focus and page state remain transient and are excluded from session documents.

`grid_label.js` provides the bitmap font and pure fade/composition functions. `grid_matrix_bridge.js` owns a separate transient text layer above the existing base and animation layers. It never rewrites foreground, background, or animation masks. Fade ticks respect frame transactions, and dimension changes clear the label. Hardware frames, HUD grid previews, and diagnostic snapshots use the same final brightness compositor.

323 automated checks pass, including abbreviation bounds, hold/fade timing, latest-state restoration, replacement/cancellation, monochrome output, transaction boundaries, HUD rendering, momentary Set restoration, and kick/snare per-hit value capture. An isolated live Max preview verified the banner and bitmap together. Its real timer finished in approximately 1008 ms and restored base brightness 9 and animation brightness 12 that changed underneath it; the lower inspector remained unchanged. This was not a physical-grid test.

The V8 scripts autowatch. If an already-open HUD retains its cached model, close and reopen only the HUD to refresh it. The main MLR patch was not restarted during implementation. The physical grid still needs a playing check for abbreviation legibility and fade timing.
