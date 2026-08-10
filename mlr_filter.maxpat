{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [ 80.0, 80.0, 760.0, 420.0 ],
    "boxes": [
      { "box": { "id": "in-l", "maxclass": "inlet", "index": 1, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 30.0, 45.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-r", "maxclass": "inlet", "index": 2, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 100.0, 45.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-base", "maxclass": "inlet", "index": 3, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 210.0, 45.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-mod", "maxclass": "inlet", "index": 4, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 280.0, 45.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-res", "maxclass": "inlet", "index": 5, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 350.0, 45.0, 30.0, 30.0 ] } },
      {
        "box": {
          "id": "gen-filter",
          "maxclass": "newobj",
          "text": "gen~ @title mlr_filter",
          "numinlets": 5,
          "numoutlets": 2,
          "outlettype": [ "signal", "signal" ],
          "patching_rect": [ 30.0, 135.0, 126.0, 22.0 ],
          "patcher": {
            "fileversion": 1,
            "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
            "rect": [ 100.0, 100.0, 850.0, 590.0 ],
            "boxes": [
              { "box": { "id": "gin1", "maxclass": "newobj", "text": "in 1 @comment left", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 30.0, 30.0, 115.0, 22.0 ] } },
              { "box": { "id": "gin2", "maxclass": "newobj", "text": "in 2 @comment right", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 170.0, 30.0, 120.0, 22.0 ] } },
              { "box": { "id": "gin3", "maxclass": "newobj", "text": "in 3 @comment base", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 310.0, 30.0, 115.0, 22.0 ] } },
              { "box": { "id": "gin4", "maxclass": "newobj", "text": "in 4 @comment modulation", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 450.0, 30.0, 150.0, 22.0 ] } },
              { "box": { "id": "gin5", "maxclass": "newobj", "text": "in 5 @comment resonance", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 625.0, 30.0, 145.0, 22.0 ] } },
              {
                "box": {
                  "id": "code",
                  "maxclass": "codebox",
                  "numinlets": 5,
                  "numoutlets": 2,
                  "outlettype": [ "", "" ],
                  "patching_rect": [ 30.0, 85.0, 740.0, 390.0 ],
                  "code": "// Stereo topology-preserving state-variable low-pass.\r\n// Base cutoff is a manual ceiling; the rta lane can only close it.\r\nHistory ic1L(0), ic2L(0), ic1R(0), ic2R(0);\r\nbaseCutoff = clip(in3, 0, 1);\r\nmodCutoff = clip(in4, 0, 1);\r\ncutoff = min(baseCutoff, modCutoff);\r\nresonance = clip(in5, 0, 1);\r\nmaxFreq = min(18000, samplerate * 0.45);\r\nfreq = exp(log(35) + cutoff * log(maxFreq / 35));\r\ng = tan(pi * freq / samplerate);\r\nQ = 0.55 + resonance * 9.45;\r\nk = 1 / Q;\r\na1 = 1 / (1 + g * (g + k));\r\na2 = g * a1;\r\na3 = g * a2;\r\n\r\nv3L = in1 - ic2L;\r\nv1L = a1 * ic1L + a2 * v3L;\r\nv2L = ic2L + a2 * ic1L + a3 * v3L;\r\nic1L = 2 * v1L - ic1L;\r\nic2L = 2 * v2L - ic2L;\r\n\r\nv3R = in2 - ic2R;\r\nv1R = a1 * ic1R + a2 * v3R;\r\nv2R = ic2R + a2 * ic1R + a3 * v3R;\r\nic1R = 2 * v1R - ic1R;\r\nic2R = 2 * v2R - ic2R;\r\n\r\n// The final four percent crossfades to the real dry input. At 1.0 the\r\n// stage is bit-for-bit bypassed instead of being merely a very high filter.\r\nopenMix = clip((cutoff - 0.96) / 0.04, 0, 1);\r\nopenMix = openMix * openMix * (3 - 2 * openMix);\r\nout1 = mix(v2L, in1, openMix);\r\nout2 = mix(v2R, in2, openMix);"
                }
              },
              { "box": { "id": "gout1", "maxclass": "newobj", "text": "out 1 @comment left", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 30.0, 510.0, 126.0, 22.0 ] } },
              { "box": { "id": "gout2", "maxclass": "newobj", "text": "out 2 @comment right", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 170.0, 510.0, 132.0, 22.0 ] } }
            ],
            "lines": [
              { "patchline": { "source": [ "gin1", 0 ], "destination": [ "code", 0 ] } },
              { "patchline": { "source": [ "gin2", 0 ], "destination": [ "code", 1 ] } },
              { "patchline": { "source": [ "gin3", 0 ], "destination": [ "code", 2 ] } },
              { "patchline": { "source": [ "gin4", 0 ], "destination": [ "code", 3 ] } },
              { "patchline": { "source": [ "gin5", 0 ], "destination": [ "code", 4 ] } },
              { "patchline": { "source": [ "code", 0 ], "destination": [ "gout1", 0 ] } },
              { "patchline": { "source": [ "code", 1 ], "destination": [ "gout2", 0 ] } }
            ]
          }
        }
      },
      { "box": { "id": "out-l", "maxclass": "outlet", "index": 1, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 30.0, 235.0, 30.0, 30.0 ] } },
      { "box": { "id": "out-r", "maxclass": "outlet", "index": 2, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 100.0, 235.0, 30.0, 30.0 ] } },
      { "box": { "id": "note", "maxclass": "comment", "text": "cutoff 1 + modulation 1 = exact dry; normalized controls are already ramped by channel_strip", "patching_rect": [ 210.0, 235.0, 500.0, 22.0 ] } }
    ],
    "lines": [
      { "patchline": { "source": [ "in-l", 0 ], "destination": [ "gen-filter", 0 ] } },
      { "patchline": { "source": [ "in-r", 0 ], "destination": [ "gen-filter", 1 ] } },
      { "patchline": { "source": [ "in-base", 0 ], "destination": [ "gen-filter", 2 ] } },
      { "patchline": { "source": [ "in-mod", 0 ], "destination": [ "gen-filter", 3 ] } },
      { "patchline": { "source": [ "in-res", 0 ], "destination": [ "gen-filter", 4 ] } },
      { "patchline": { "source": [ "gen-filter", 0 ], "destination": [ "out-l", 0 ] } },
      { "patchline": { "source": [ "gen-filter", 1 ], "destination": [ "out-r", 0 ] } }
    ]
  }
}
