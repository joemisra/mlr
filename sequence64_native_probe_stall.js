// Isolated probe only. Never loaded by _mlr or the production grid router.
inlets = 1;
outlets = 1;
autowatch = 0;
function bang() {
    var start = Date.now();
    while (Date.now() - start < 750) { /* deliberately starve low-priority V8 */ }
    outlet(0, "stalled_ms", Date.now() - start);
}
