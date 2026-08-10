{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [ 80.0, 80.0, 600.0, 340.0 ],
    "boxes": [
      { "box": { "id": "in-l", "maxclass": "inlet", "index": 1, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 30.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-r", "maxclass": "inlet", "index": 2, "numinlets": 0, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 85.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "in-drive", "maxclass": "inlet", "index": 3, "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 170.0, 35.0, 30.0, 30.0 ] } },
      { "box": { "id": "pre-drive", "maxclass": "newobj", "text": "prepend drive_db", "numinlets": 1, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 170.0, 85.0, 110.0, 22.0 ] } },
      {
        "box": {
          "id": "gen-sat",
          "maxclass": "newobj",
          "text": "gen~ @title mlr_saturator",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [ "signal", "signal" ],
          "patching_rect": [ 30.0, 135.0, 150.0, 22.0 ],
          "patcher": {
            "fileversion": 1,
            "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
            "rect": [ 100.0, 100.0, 650.0, 420.0 ],
            "boxes": [
              { "box": { "id": "gin1", "maxclass": "newobj", "text": "in 1 @comment left", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 30.0, 30.0, 115.0, 22.0 ] } },
              { "box": { "id": "gin2", "maxclass": "newobj", "text": "in 2 @comment right", "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 170.0, 30.0, 120.0, 22.0 ] } },
              { "box": { "id": "code", "maxclass": "codebox", "numinlets": 2, "numoutlets": 2, "outlettype": [ "", "" ], "patching_rect": [ 30.0, 80.0, 520.0, 235.0 ], "code": "Param drive_db(0, min=0, max=12);\r\namount = clip(drive_db / 12, 0, 1);\r\ndrive = pow(10, drive_db / 40);\r\nnorm = max(tanh(drive), 0.000001);\r\nsatL = tanh(in1 * drive) / norm;\r\nsatR = tanh(in2 * drive) / norm;\r\n// Zero drive is an exact bypass; higher values progressively introduce the curve.\r\nout1 = mix(in1, satL, amount);\r\nout2 = mix(in2, satR, amount);" } },
              { "box": { "id": "gout1", "maxclass": "newobj", "text": "out 1 @comment left", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 30.0, 345.0, 126.0, 22.0 ] } },
              { "box": { "id": "gout2", "maxclass": "newobj", "text": "out 2 @comment right", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 170.0, 345.0, 132.0, 22.0 ] } }
            ],
            "lines": [
              { "patchline": { "source": [ "gin1", 0 ], "destination": [ "code", 0 ] } },
              { "patchline": { "source": [ "gin2", 0 ], "destination": [ "code", 1 ] } },
              { "patchline": { "source": [ "code", 0 ], "destination": [ "gout1", 0 ] } },
              { "patchline": { "source": [ "code", 1 ], "destination": [ "gout2", 0 ] } }
            ]
          }
        }
      },
      { "box": { "id": "out-l", "maxclass": "outlet", "index": 1, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 30.0, 220.0, 30.0, 30.0 ] } },
      { "box": { "id": "out-r", "maxclass": "outlet", "index": 2, "numinlets": 1, "numoutlets": 0, "patching_rect": [ 85.0, 220.0, 30.0, 30.0 ] } }
    ],
    "lines": [
      { "patchline": { "source": [ "in-l", 0 ], "destination": [ "gen-sat", 0 ] } },
      { "patchline": { "source": [ "in-r", 0 ], "destination": [ "gen-sat", 1 ] } },
      { "patchline": { "source": [ "in-drive", 0 ], "destination": [ "pre-drive", 0 ] } },
      { "patchline": { "source": [ "pre-drive", 0 ], "destination": [ "gen-sat", 0 ] } },
      { "patchline": { "source": [ "gen-sat", 0 ], "destination": [ "out-l", 0 ] } },
      { "patchline": { "source": [ "gen-sat", 1 ], "destination": [ "out-r", 0 ] } }
    ]
  }
}
