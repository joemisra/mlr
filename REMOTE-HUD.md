# Phone HUD

1. Connect the computer and Galaxy to the same trusted Wi-Fi network. Guest
   networks may isolate clients. Audio stays on the computer.
2. Open one edition normally. Save any work before switching editions. Keep
   its normal HUD instance loaded; remote commands route through that bridge.
3. Open `remote_hud.maxpat` from that same project; its server starts automatically.
   Use **script start** to resume after **script stop**.
   The service listens on port 7350. Allow Max/Node incoming local-network
   access if the operating system asks.
4. On this Mac, open `http://MacBook-Pro.local:7350/` in Chrome on the Galaxy
   and bookmark it. The console prints the computer's actual `.local` name on
   other machines. Enter the eight-digit pairing code from Max once; the browser
   remembers it. If Android cannot resolve `.local` on your network, use the
   IP fallback printed in Max (that address can change with DHCP). Rotate the
   phone to landscape and tap **Full screen / stay awake**. If wake lock is
   unavailable, increase Android's screen timeout for the test.
5. Touch navigation and controls operate the running edition. The Live grid
   remains a monitor, just like the desktop HUD. File choosers and plug-in
   editor windows appear on the computer and require interaction there.
6. Click **script stop** when finished, or close the remote patch. The address
   and pairing credentials persist across service restarts and fresh builds.
   Keep the code private and use the service on trusted local Wi-Fi.

The phone has independent page navigation and follows the same live state as
Max. A disconnected banner disables new touch commands; reconnection requests
fresh state and preserves local navigation. Display and control use a
separate Node service, not the audio clock. A queued command already sent
before a connection failure may still execute.

Both editions include this optional patch, which is never started by the
normal entry patch. Product identity comes from the built edition's immutable
`mlr_product.js`. No remote settings enter session documents. No npm install
is required.

## First physical check

- Confirm Live grid brightness and selected parameter names/values follow
  hardware gestures, including a playing pattern.
- Select Strip, adjust one group level and confirm the desktop follows.
- Test Samples preview/stop and assignments at a safe listening level.
- Toggle phone Wi-Fi, confirm the disconnected banner, reconnect, and confirm
  current state returns. Check readability and target size on the Galaxy.
- Save before exercising session Open/New. Confirm restore remains stopped.

Automated HTTP/protocol and canvas-adapter tests cover authentication, state
streaming, command allowlisting, module loading and rendering every HUD page.
These do not establish Max Node integration, Android touch ergonomics, Wi-Fi
latency, or physical-grid/audio behavior; those require the check above.

## Telemetry load repair — October 27, 2026

The first remote patch forwarded every HUD message directly into Node for Max,
including while its script was stopped. That added per-event IPC during playback
and could send messages to a stopped script. This was a load defect in the
initial implementation; the user's audible stuttering has not yet been retested.

`remote_hud_batch.js` now gates telemetry before Node. The first connected phone
enables it; the last disconnect and the Stop button disable it. Updates are
coalesced by topic and object/cell into one batch every 50 ms. Plug-in inventory
begin/item/end messages retain their order. Commands stay immediate. The phone
receives one SSE event per batch rather than one per individual state message.

A silent native Max V8 probe sent 10,000 meter messages and received one batch
with one event containing the final value (9999), after 52 ms. This verifies
native V8/Task/output coalescing, not audio performance. All 476 automated tests
pass, including idle gating, burst reduction and first/last-client switching.
Both generated editions build and their patch JSON parses.

Use a fresh project build for this change: the remote patch topology and Node
service both changed. Stop the old server and close the old project before
opening the new one; starting it prints a new pairing URL. Test with the phone
connected, disconnected and the server stopped while the same session plays.

## Large-batch repair — October 27, 2026

The connected live test exposed JSON parse failures at character 32767 in Max's
console. A single serialized batch exceeded Max's symbol limit. Large batches
now travel in Unicode-safe fragments of at most 4096 UTF-16 units, with at most
four fragments per 50 ms flush. Node reassembles the complete payload before
parsing or publishing it. Ordinary small batches retain their single-message
path. Error reporting is rate-limited to avoid a console flood on corrupt input.

While a phone is connected, desktop telemetry redraws are also capped at about
6.7 Hz; mouse gestures remain immediate and the phone keeps its 20 Hz feed.
Disconnecting the last phone restores the desktop's original redraw interval.
This is transient display policy and does not enter session state.

The user's stutter persisted after switching the desktop to Help, so desktop
painting alone did not explain the problem. A live stack sample showed the Node
server below 1% process CPU, and the read-only DSP probe reported 34–37% DSP load,
512 I/O samples, 32 signal samples, 44.1 kHz, Overdrive on and Scheduler in Audio
Interrupt on. None of those settings were changed. Playback must be retested
with the large-batch repair before claiming the stutter is resolved.

## Browser path repair — October 27, 2026

The browser adapter originally began a new Canvas path on each rectangle and
move operation. The shared renderer batches same-appearance grid cells before
one fill/stroke, and all waveform bins for a channel before one stroke. That
adapter discarded all but the final rectangle/bin in each batch, making static
grid regions appear absent even when state updates arrived correctly.

The adapter now accumulates geometry and clears the path only after fill or
stroke, matching mgraphics. A path-aware Canvas regression verifies all 256
static grid cells and all 256 bins of each waveform channel. All 480 tests pass.
This repair changes only the browser asset; a browser reload picks it up from an
updated service directory without restarting Max or the Node service.

## Stable bookmark and pairing — October 28, 2026

The service stores a random access token and an eight-digit pairing code in
`~/.mlr/remote-hud.json` (owner-only file permissions). Credentials belong to
this workstation, outside sessions and generated editions. A paired browser
receives an HttpOnly, SameSite cookie valid for a year. It can then use the
short home-page URL, including scripts, state streaming and commands, without
a token in its bookmark. Existing token URLs remain compatible and also set
the cookie. Five incorrect code attempts per address are allowed per minute.

The `.local` hostname is independent of DHCP address changes, provided the
phone/network supports local multicast name resolution. Nothing changes the
Mac's hostname, router configuration or public-network exposure. Both editions
use the same workstation credentials and must still run one at a time.

All 482 automated tests pass, including short-URL pairing, cookie access,
restart persistence, cross-origin rejection and pairing attempt limits.

Opening the optional remote patch starts its service automatically. The normal
edition entry still does not start a network service.

## Pairing form origin repair — October 29, 2026

The original `Referrer-Policy: no-referrer` response caused Chrome form POSTs to
send `Origin: null`; the service correctly rejected that origin, so even the
correct code produced a blank 403. The pairing page now uses `same-origin`,
which preserves form provenance and suppresses referrers to other sites.
Origin comparisons use URL normalization (hostname case is immaterial), and
form/JSON content types accept charset parameters. Opaque `null` and unrelated
origins remain rejected. Reload the home page before submitting the same code.

All 483 automated tests pass, including browser-style form origin, hostname
capitalization and content-type charset cases.
