#!/usr/bin/env python3
"""Measure six-channel PCM click captures; no third-party dependencies."""
import argparse
import array
import json
import sys
import wave


def analyze(path, hit_hz=4):
    with wave.open(str(path), "rb") as capture:
        channels = capture.getnchannels()
        rate = capture.getframerate()
        frames = capture.getnframes()
        if channels != 6 or capture.getsampwidth() != 2:
            raise ValueError("expected six-channel 16-bit PCM WAV")
        samples = array.array("h", capture.readframes(frames))
    if sys.byteorder != "little":
        samples.byteswap()
    expected = rate / hit_hz
    onsets = []
    for channel in range(channels):
        signal = samples[channel::channels]
        onsets.append([i for i, value in enumerate(signal)
                       if abs(value) > 1000 and
                       (i == 0 or abs(signal[i - 1]) <= 1000)])
    counts = [len(hits) for hits in onsets]
    intervals = [[b - a for a, b in zip(hits, hits[1:])] for hits in onsets]
    aligned = all(hits == onsets[0] for hits in onsets)
    # A passing capture must span essentially the full buffer, not a few hits
    # followed by silence. Phase at record start can omit one boundary hit.
    enough = min(counts) >= int(frames / expected) - 1 and min(counts) >= 2
    exact = all(delta == expected for channel in intervals for delta in channel)
    return {"sample_rate": rate, "channels": channels, "frames": frames,
            "duration_seconds": frames / rate, "hits_per_channel": counts,
            "first_onset_samples": [hits[0] if hits else None for hits in onsets],
            "interval_samples_per_channel": [sorted(set(values)) for values in intervals],
            "expected_interval_samples": expected, "all_onsets_aligned": aligned,
            "passed": enough and aligned and exact,
            "scope": "native trigger-to-click paths; excludes RNBO voices and hardware"}


def analyze_rnbo(path):
    """Measure the fixed short-tail, 1 Hz seven-channel RNBO probe fixture."""
    with wave.open(str(path), "rb") as capture:
        if capture.getnchannels() != 7 or capture.getsampwidth() != 2:
            raise ValueError("expected seven-channel 16-bit PCM RNBO probe WAV")
        rate, frames = capture.getframerate(), capture.getnframes()
        samples = array.array("h", capture.readframes(frames))
    if sys.byteorder != "little":
        samples.byteswap()
    reference = samples[6::7]
    hits = [i for i, value in enumerate(reference) if abs(value) > 1000 and
            (i == 0 or abs(reference[i - 1]) <= 1000)]
    offsets, quiet, peaks = [], [], []
    for channel in range(6):
        signal = samples[channel::7]
        offsets.append([next((i - hit for i in range(hit, min(hit + int(rate * .1), frames))
                              if abs(signal[i]) > 50), None) for hit in hits])
        quiet.append(all(abs(signal[i]) <= 50 for hit in hits for i in
                         range(max(0, hit - int(rate * .05)), hit)))
        peaks.append(max(map(abs, signal), default=0))
    intervals = [b - a for a, b in zip(hits, hits[1:])]
    enough = len(hits) >= max(2, int(frames / rate) - 1)
    aligned = enough and all(offset == 0 for channel in offsets for offset in channel)
    return {"sample_rate": rate, "frames": frames, "duration_seconds": frames / rate,
            "voice_order": ["kick", "snare", "hat", "clap", "tom", "rim"],
            "reference_hits": len(hits), "reference_onset_samples": hits,
            "reference_interval_samples": sorted(set(intervals)),
            "voice_onset_offsets_samples": offsets, "quiet_before_hits": quiet,
            "voice_peak_pcm16": peaks,
            "passed": enough and aligned and all(quiet) and all(value == rate for value in intervals),
            "scope": "fixed short-tail RNBO fixture and internal Max dispatch; excludes hardware"}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("wav")
    parser.add_argument("--hit-hz", type=float, default=4)
    parser.add_argument("--rnbo", action="store_true", help="analyze the seven-channel 1 Hz RNBO fixture")
    args = parser.parse_args()
    if args.hit_hz <= 0:
        parser.error("--hit-hz must be positive")
    result = analyze_rnbo(args.wav) if args.rnbo else analyze(args.wav, args.hit_hz)
    print(json.dumps(result, indent=2))
    sys.exit(0 if result["passed"] else 1)
