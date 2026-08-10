{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [ 80.0, 80.0, 780.0, 440.0 ],
    "boxes": [
      { "box": { "id": "in-l", "maxclass": "inlet", "index": 1, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 30.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-r", "maxclass": "inlet", "index": 2, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 85.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-threshold", "maxclass": "inlet", "index": 3, "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 190.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-ratio", "maxclass": "inlet", "index": 4, "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 245.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-attack", "maxclass": "inlet", "index": 5, "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 300.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-release", "maxclass": "inlet", "index": 6, "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 355.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-knee", "maxclass": "inlet", "index": 7, "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 410.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "pre-threshold", "maxclass": "newobj", "text": "prepend threshold", "numinlets": 1, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 190.0, 85.0, 112.0, 22.0 ] } },
      { "box": { "id": "pre-ratio", "maxclass": "newobj", "text": "prepend ratio", "numinlets": 1, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 315.0, 85.0, 88.0, 22.0 ] } },
      { "box": { "id": "pre-attack", "maxclass": "newobj", "text": "prepend attack_ms", "numinlets": 1, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 415.0, 85.0, 115.0, 22.0 ] } },
      { "box": { "id": "pre-release", "maxclass": "newobj", "text": "prepend release_ms", "numinlets": 1, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 545.0, 85.0, 123.0, 22.0 ] } },
      { "box": { "id": "pre-knee", "maxclass": "newobj", "text": "prepend knee", "numinlets": 1, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 680.0, 85.0, 86.0, 22.0 ] } },
      {
        "box": {
          "id": "gen-comp",
          "maxclass": "newobj",
          "text": "gen~ @title mlr_clean_compressor",
          "numinlets": 2,
          "numoutlets": 3,
          "outlettype": [ "signal", "signal", "signal" ],
          "patching_rect": [ 30.0, 150.0, 195.0, 22.0 ],
          "patcher": {
            "fileversion": 1,
            "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
            "rect": [ 100.0, 100.0, 850.0, 590.0 ],
            "boxes": [
              { "box": { "id": "gin1", "maxclass": "newobj", "text": "in 1 @comment left", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 30.0, 30.0, 115.0, 22.0 ] } },
              { "box": { "id": "gin2", "maxclass": "newobj", "text": "in 2 @comment right", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 170.0, 30.0, 120.0, 22.0 ] } },
              {
                "box": {
                  "id": "code",
                  "maxclass": "codebox",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [ "", "", "" ],
                  "patching_rect": [ 30.0, 85.0, 740.0, 390.0 ],
	                  "code": "// Conventional zero-lookahead stereo-linked peak compressor.\r\nParam threshold(-18, min=-60, max=0);\r\nParam ratio(4, min=1, max=20);\r\nParam attack_ms(10, min=0.1, max=500);\r\nParam release_ms(120, min=5, max=5000);\r\nParam knee(6, min=0, max=24);\r\nHistory gain(1);\r\n\r\nlevel = max(abs(in1), abs(in2));\r\nlevelDb = 20 * log(max(level, 0.000000001)) / log(10);\r\nover = levelDb - threshold;\r\nslope = (1 / max(ratio, 1)) - 1;\r\nhalfKnee = max(knee, 0) * 0.5;\r\ngainDb = 0;\r\nbend = 0;\r\nif (knee > 0 && over > -halfKnee && over < halfKnee) {\r\n    bend = over + halfKnee;\r\n    gainDb = slope * bend * bend / (2 * knee);\r\n} else if (over >= halfKnee) {\r\n    gainDb = slope * over;\r\n}\r\ntarget = pow(10, gainDb / 20);\r\nattackCoeff = exp(-1 / (max(attack_ms, 0.1) * 0.001 * samplerate));\r\nreleaseCoeff = exp(-1 / (max(release_ms, 1) * 0.001 * samplerate));\r\ncoeff = target < gain ? attackCoeff : releaseCoeff;\r\ngain = target + coeff * (gain - target);\r\nout1 = in1 * gain;\r\nout2 = in2 * gain;\r\nout3 = max(0, -20 * log(max(gain, 0.000000001)) / log(10));"
                }
              },
              { "box": { "id": "gout1", "maxclass": "newobj", "text": "out 1 @comment left", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 30.0, 510.0, 126.0, 22.0 ] } },
              { "box": { "id": "gout2", "maxclass": "newobj", "text": "out 2 @comment right", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 170.0, 510.0, 132.0, 22.0 ] } },
              { "box": { "id": "gout3", "maxclass": "newobj", "text": "out 3 @comment reduction_db", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 315.0, 510.0, 170.0, 22.0 ] } }
            ],
            "lines": [
              { "patchline": { "source": [ "gin1", 0 ], "destination": [ "code", 0 ] } },
              { "patchline": { "source": [ "gin2", 0 ], "destination": [ "code", 1 ] } },
              { "patchline": { "source": [ "code", 0 ], "destination": [ "gout1", 0 ] } },
              { "patchline": { "source": [ "code", 1 ], "destination": [ "gout2", 0 ] } },
              { "patchline": { "source": [ "code", 2 ], "destination": [ "gout3", 0 ] } }
            ]
          }
        }
      },
      { "box": { "id": "out-l", "maxclass": "outlet", "index": 1, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 30.0, 245.0, 30.0, 30.0 ] } },
      { "box": { "id": "out-r", "maxclass": "outlet", "index": 2, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 85.0, 245.0, 30.0, 30.0 ] } },
      { "box": { "id": "out-gr", "maxclass": "outlet", "index": 3, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 140.0, 245.0, 30.0, 30.0 ] } }
    ],
    "lines": [
      { "patchline": { "source": [ "in-l", 0 ], "destination": [ "gen-comp", 0 ] } },
      { "patchline": { "source": [ "in-r", 0 ], "destination": [ "gen-comp", 1 ] } },
      { "patchline": { "source": [ "in-threshold", 0 ], "destination": [ "pre-threshold", 0 ] } },
      { "patchline": { "source": [ "in-ratio", 0 ], "destination": [ "pre-ratio", 0 ] } },
      { "patchline": { "source": [ "in-attack", 0 ], "destination": [ "pre-attack", 0 ] } },
      { "patchline": { "source": [ "in-release", 0 ], "destination": [ "pre-release", 0 ] } },
      { "patchline": { "source": [ "in-knee", 0 ], "destination": [ "pre-knee", 0 ] } },
      { "patchline": { "source": [ "pre-threshold", 0 ], "destination": [ "gen-comp", 0 ] } },
      { "patchline": { "source": [ "pre-ratio", 0 ], "destination": [ "gen-comp", 0 ] } },
      { "patchline": { "source": [ "pre-attack", 0 ], "destination": [ "gen-comp", 0 ] } },
      { "patchline": { "source": [ "pre-release", 0 ], "destination": [ "gen-comp", 0 ] } },
      { "patchline": { "source": [ "pre-knee", 0 ], "destination": [ "gen-comp", 0 ] } },
      { "patchline": { "source": [ "gen-comp", 0 ], "destination": [ "out-l", 0 ] } },
      { "patchline": { "source": [ "gen-comp", 1 ], "destination": [ "out-r", 0 ] } },
      { "patchline": { "source": [ "gen-comp", 2 ], "destination": [ "out-gr", 0 ] } }
    ]
  }
}
