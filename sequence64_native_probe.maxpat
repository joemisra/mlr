{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 1,
      "revision": 3,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      100,
      100,
      1100,
      740
    ],
    "boxes": [
      {"box":{"id":"keys","maxclass":"newobj","text":"key","patching_rect":[40,700,40,22]}},
      {"box":{"id":"key-select","maxclass":"newobj","text":"sel 114 115 100 97 122 119","patching_rect":[100,700,240,22]}},
      {"box":{"id":"run-one","maxclass":"message","text":"1","patching_rect":[360,700,30,22]}},
      {"box":{"id":"run-zero","maxclass":"message","text":"0","patching_rect":[400,700,30,22]}},
      {"box":{"id":"dsp-one","maxclass":"message","text":"1","patching_rect":[440,700,30,22]}},
      {"box":{"id":"stall-one","maxclass":"message","text":"1","patching_rect":[480,700,30,22]}},
      {"box":{"id":"stall-zero","maxclass":"message","text":"0","patching_rect":[520,700,30,22]}},
      {
        "box": {
          "id": "title",
          "maxclass": "comment",
          "text": "Native timing probe — six simultaneous click signals, no hardware audio or MLR buses",
          "patching_rect": [
            30,
            20,
            950,
            42
          ]
        }
      },
      {
        "box": {
          "id": "note",
          "maxclass": "comment",
          "text": "Fixture uploads on load; playback stays stopped. Keys: d DSP on, r Record/Run, a Stall V8, z end stall, s Stop, w write WAV. Stall blocks V8 for 750 ms each second. No hardware audio output.",
          "patching_rect": [
            30,
            65,
            950,
            42
          ]
        }
      },
      {
        "box": {
          "id": "run",
          "maxclass": "toggle",
          "patching_rect": [
            40,
            135,
            24,
            22
          ]
        }
      },
      {
        "box": {
          "id": "runlabel",
          "maxclass": "comment",
          "text": "Record / Run",
          "patching_rect": [
            75,
            130,
            150,
            42
          ]
        }
      },
      {
        "box": {
          "id": "runorder",
          "maxclass": "newobj",
          "text": "t i i",
          "patching_rect": [
            40,
            185,
            50,
            22
          ]
        }
      },
      {
        "box": {
          "id": "runsel",
          "maxclass": "newobj",
          "text": "sel 1 0",
          "patching_rect": [
            40,
            225,
            60,
            22
          ]
        }
      },
      {
        "box": {
          "id": "start",
          "maxclass": "message",
          "text": "start 1",
          "patching_rect": [
            40,
            265,
            70,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stop",
          "maxclass": "message",
          "text": "stop",
          "patching_rect": [
            130,
            265,
            70,
            22
          ]
        }
      },
      {
        "box": {
          "id": "player",
          "maxclass": "newobj",
          "text": "mlr.sequence_player",
          "patching_rect": [
            390,
            295,
            210,
            22
          ]
        }
      },
      {
        "box": {
          "id": "report",
          "maxclass": "newobj",
          "text": "print native_probe_status",
          "patching_rect": [
            660,
            295,
            210,
            22
          ]
        }
      },
      {
        "box": {
          "id": "load",
          "maxclass": "newobj",
          "text": "loadbang",
          "patching_rect": [
            390,
            130,
            75,
            22
          ]
        }
      },
      {
        "box": {
          "id": "fixture",
          "maxclass": "message",
          "text": "begin 1 1 4, event 1 1 0 1 16 0 1 1 1 1 1 1 1 1 1 1 1 1, event 1 1 0 2 15 0 1 1 1 1 1 1 1 1 1 1 1 1, event 1 1 0 3 14 0 1 1 1 1 1 1 1 1 1 1 1 1, event 1 1 0 4 13 0 1 1 1 1 1 1 1 1 1 1 1 1, event 1 1 0 5 12 0 1 1 1 1 1 1 1 1 1 1 1 1, event 1 1 0 6 11 0 1 1 1 1 1 1 1 1 1 1 1 1, commit 1 1",
          "patching_rect": [
            300,
            185,
            700,
            22
          ]
        }
      },
      {
        "box": {
          "id": "phase",
          "maxclass": "newobj",
          "text": "phasor~ 16.",
          "patching_rect": [
            30,
            335,
            95,
            22
          ]
        }
      },
      {
        "box": {
          "id": "half",
          "maxclass": "newobj",
          "text": ">=~ 0.5",
          "patching_rect": [
            30,
            375,
            95,
            22
          ]
        }
      },
      {
        "box": {
          "id": "edge",
          "maxclass": "newobj",
          "text": "edge~",
          "patching_rect": [
            30,
            415,
            95,
            22
          ]
        }
      },
      {
        "box": {
          "id": "dsp",
          "maxclass": "toggle",
          "patching_rect": [
            30,
            465,
            24,
            22
          ]
        }
      },
      {
        "box": {
          "id": "dsplabel",
          "maxclass": "comment",
          "text": "DSP",
          "patching_rect": [
            65,
            460,
            80,
            42
          ]
        }
      },
      {
        "box": {
          "id": "dspcontrol",
          "maxclass": "newobj",
          "text": "adstatus switch",
          "patching_rect": [
            30,
            505,
            115,
            22
          ]
        }
      },
      {
        "box": {
          "id": "route",
          "maxclass": "newobj",
          "text": "route 1 2 3 4 5 6",
          "patching_rect": [
            290,
            355,
            530,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hit0",
          "maxclass": "newobj",
          "text": "t b",
          "patching_rect": [
            290,
            405,
            42,
            22
          ]
        }
      },
      {
        "box": {
          "id": "click0",
          "maxclass": "newobj",
          "text": "click~",
          "patching_rect": [
            290,
            450,
            65,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hit1",
          "maxclass": "newobj",
          "text": "t b",
          "patching_rect": [
            380,
            405,
            42,
            22
          ]
        }
      },
      {
        "box": {
          "id": "click1",
          "maxclass": "newobj",
          "text": "click~",
          "patching_rect": [
            380,
            450,
            65,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hit2",
          "maxclass": "newobj",
          "text": "t b",
          "patching_rect": [
            470,
            405,
            42,
            22
          ]
        }
      },
      {
        "box": {
          "id": "click2",
          "maxclass": "newobj",
          "text": "click~",
          "patching_rect": [
            470,
            450,
            65,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hit3",
          "maxclass": "newobj",
          "text": "t b",
          "patching_rect": [
            560,
            405,
            42,
            22
          ]
        }
      },
      {
        "box": {
          "id": "click3",
          "maxclass": "newobj",
          "text": "click~",
          "patching_rect": [
            560,
            450,
            65,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hit4",
          "maxclass": "newobj",
          "text": "t b",
          "patching_rect": [
            650,
            405,
            42,
            22
          ]
        }
      },
      {
        "box": {
          "id": "click4",
          "maxclass": "newobj",
          "text": "click~",
          "patching_rect": [
            650,
            450,
            65,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hit5",
          "maxclass": "newobj",
          "text": "t b",
          "patching_rect": [
            740,
            405,
            42,
            22
          ]
        }
      },
      {
        "box": {
          "id": "click5",
          "maxclass": "newobj",
          "text": "click~",
          "patching_rect": [
            740,
            450,
            65,
            22
          ]
        }
      },
      {
        "box": {
          "id": "record",
          "maxclass": "newobj",
          "text": "record~ #0native_probe 6",
          "patching_rect": [
            330,
            510,
            460,
            22
          ]
        }
      },
      {
        "box": {
          "id": "buffer",
          "maxclass": "newobj",
          "text": "buffer~ #0native_probe 10000 6",
          "patching_rect": [
            330,
            550,
            270,
            22
          ]
        }
      },
      {
        "box": {
          "id": "write",
          "maxclass": "message",
          "text": "writewave /tmp/mlr-native-probe.wav",
          "patching_rect": [
            330,
            595,
            340,
            22
          ]
        }
      },
      {
        "box": {
          "id": "writenote",
          "maxclass": "comment",
          "text": "Write after recording. Analyze onset alignment in all six channels. This measures click paths, not RNBO voice onsets.",
          "patching_rect": [
            330,
            630,
            620,
            42
          ]
        }
      },
      {
        "box": {
          "id": "stall",
          "maxclass": "toggle",
          "patching_rect": [
            805,
            130,
            24,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stalllabel",
          "maxclass": "comment",
          "text": "Stall V8",
          "patching_rect": [
            840,
            125,
            150,
            42
          ]
        }
      },
      {
        "box": {
          "id": "stallclock",
          "maxclass": "newobj",
          "text": "qmetro 1000",
          "patching_rect": [
            805,
            265,
            130,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stallscript",
          "maxclass": "newobj",
          "text": "v8 sequence64_native_probe_stall.js @autowatch 0",
          "patching_rect": [
            800,
            450,
            220,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stallreport",
          "maxclass": "newobj",
          "text": "print native_probe_stall",
          "patching_rect": [
            800,
            505,
            185,
            22
          ]
        }
      }
    ],
    "lines": [
      {"patchline":{"source":["keys",0],"destination":["key-select",0]}},
      {"patchline":{"source":["key-select",0],"destination":["run-one",0]}},
      {"patchline":{"source":["key-select",1],"destination":["run-zero",0]}},
      {"patchline":{"source":["key-select",1],"destination":["stall-zero",0]}},
      {"patchline":{"source":["key-select",2],"destination":["dsp-one",0]}},
      {"patchline":{"source":["key-select",3],"destination":["stall-one",0]}},
      {"patchline":{"source":["key-select",4],"destination":["stall-zero",0]}},
      {"patchline":{"source":["key-select",5],"destination":["write",0]}},
      {"patchline":{"source":["run-one",0],"destination":["run",0]}},
      {"patchline":{"source":["run-zero",0],"destination":["run",0]}},
      {"patchline":{"source":["dsp-one",0],"destination":["dsp",0]}},
      {"patchline":{"source":["stall-one",0],"destination":["stall",0]}},
      {"patchline":{"source":["stall-zero",0],"destination":["stall",0]}},
      {
        "patchline": {
          "source": [
            "route",
            0
          ],
          "destination": [
            "hit0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hit0",
            0
          ],
          "destination": [
            "click0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route",
            1
          ],
          "destination": [
            "hit1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hit1",
            0
          ],
          "destination": [
            "click1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route",
            2
          ],
          "destination": [
            "hit2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hit2",
            0
          ],
          "destination": [
            "click2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route",
            3
          ],
          "destination": [
            "hit3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hit3",
            0
          ],
          "destination": [
            "click3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route",
            4
          ],
          "destination": [
            "hit4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hit4",
            0
          ],
          "destination": [
            "click4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route",
            5
          ],
          "destination": [
            "hit5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hit5",
            0
          ],
          "destination": [
            "click5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "run",
            0
          ],
          "destination": [
            "runorder",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "runorder",
            1
          ],
          "destination": [
            "record",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "runorder",
            0
          ],
          "destination": [
            "runsel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "runsel",
            0
          ],
          "destination": [
            "start",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "runsel",
            1
          ],
          "destination": [
            "stop",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "start",
            0
          ],
          "destination": [
            "player",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop",
            0
          ],
          "destination": [
            "player",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load",
            0
          ],
          "destination": [
            "fixture",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "fixture",
            0
          ],
          "destination": [
            "player",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "player",
            1
          ],
          "destination": [
            "report",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "player",
            0
          ],
          "destination": [
            "route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "phase",
            0
          ],
          "destination": [
            "half",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "half",
            0
          ],
          "destination": [
            "edge",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "edge",
            0
          ],
          "destination": [
            "player",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "dsp",
            0
          ],
          "destination": [
            "dspcontrol",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stall",
            0
          ],
          "destination": [
            "stallclock",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stallclock",
            0
          ],
          "destination": [
            "stallscript",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stallscript",
            0
          ],
          "destination": [
            "stallreport",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "click0",
            0
          ],
          "destination": [
            "record",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "click1",
            0
          ],
          "destination": [
            "record",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "click2",
            0
          ],
          "destination": [
            "record",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "click3",
            0
          ],
          "destination": [
            "record",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "click4",
            0
          ],
          "destination": [
            "record",
            4
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "click5",
            0
          ],
          "destination": [
            "record",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "write",
            0
          ],
          "destination": [
            "buffer",
            0
          ]
        }
      }
    ],
    "dependency_cache": [
      {
        "name": "mlr.sequence_player.mxo",
        "patcherrelativepath": ".",
        "type": "iLaX",
        "implicit": 1
      },
      {
        "name": "sequence64_native_probe_stall.js",
        "patcherrelativepath": ".",
        "type": "TEXT",
        "implicit": 1
      }
    ]
  }
}
