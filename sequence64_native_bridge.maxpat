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
      80,
      80,
      950,
      650
    ],
    "boxes": [
      {
        "box": {
          "id": "title",
          "maxclass": "comment",
          "text": "Experimental native cache bridge \u2014 open one instance alongside MLR and the drum lab.",
          "patching_rect": [
            30,
            20,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "note",
          "maxclass": "comment",
          "text": "No autoplay. Control via nativeSequence64Groups 1 ... on gridrouter; the full cache must be acknowledged first.",
          "patching_rect": [
            30,
            50,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "control",
          "maxclass": "newobj",
          "text": "r sequence64_native_control",
          "patching_rect": [
            30,
            100,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "player",
          "maxclass": "newobj",
          "text": "mlr.sequence_player production",
          "patching_rect": [
            30,
            180,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "pulse",
          "maxclass": "newobj",
          "text": "r sequence64_pulse",
          "patching_rect": [
            330,
            100,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "frame",
          "maxclass": "newobj",
          "text": "s sequence64_native_frame",
          "patching_rect": [
            30,
            230,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "report-prefix",
          "maxclass": "newobj",
          "text": "prepend nativeSequence64Report",
          "patching_rect": [
            330,
            230,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "report-defer",
          "maxclass": "newobj",
          "text": "deferlow",
          "patching_rect": [
            330,
            270,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "report",
          "maxclass": "newobj",
          "text": "s gridrouter",
          "patching_rect": [
            330,
            310,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "cancel",
          "maxclass": "newobj",
          "text": "r sequence64_audio_cancel",
          "patching_rect": [
            30,
            360,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "cancel-prefix",
          "maxclass": "newobj",
          "text": "prepend cancelcurrent",
          "patching_rect": [
            30,
            400,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stop-receive",
          "maxclass": "newobj",
          "text": "r [mlr]stop",
          "patching_rect": [
            330,
            360,
            260,
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
            330,
            400,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "closing",
          "maxclass": "newobj",
          "text": "freebang",
          "patching_rect": [
            30,
            460,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "closing-order",
          "maxclass": "newobj",
          "text": "t b b",
          "patching_rect": [
            30,
            500,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "offline",
          "maxclass": "message",
          "text": "nativeSequence64Report offline",
          "patching_rect": [
            30,
            540,
            260,
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
            600,
            100,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "reset",
          "maxclass": "message",
          "text": "reset",
          "patching_rect": [
            600,
            140,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "safety",
          "maxclass": "comment",
          "text": "Raw transport stop and channel cancellation reach C++ directly; only acknowledgements are deferred to V8.",
          "patching_rect": [
            30,
            590,
            260,
            22
          ]
        }
      },
      {
        "box": {
          "id": "observe-on",
          "maxclass": "message",
          "text": "1",
          "patching_rect": [
            600,
            210,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "observe-clock",
          "maxclass": "newobj",
          "text": "qmetro 33",
          "patching_rect": [
            600,
            250,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "observe",
          "maxclass": "message",
          "text": "observe",
          "patching_rect": [
            600,
            290,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hello-route",
          "maxclass": "newobj",
          "text": "route hello",
          "patching_rect": [
            600,
            340,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hello-unpack",
          "maxclass": "newobj",
          "text": "unpack i i i",
          "patching_rect": [
            600,
            380,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "hello-version",
          "maxclass": "newobj",
          "text": "sel 1",
          "patching_rect": [
            600,
            420,
            180,
            22
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "control",
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
            "pulse",
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
            "player",
            0
          ],
          "destination": [
            "frame",
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
            "report-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "report-prefix",
            0
          ],
          "destination": [
            "report-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "report-defer",
            0
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
            "cancel",
            0
          ],
          "destination": [
            "cancel-prefix",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "cancel-prefix",
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
            "stop-receive",
            0
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
            "closing",
            0
          ],
          "destination": [
            "closing-order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "closing-order",
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
            "closing-order",
            0
          ],
          "destination": [
            "offline",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "offline",
            0
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
            "load",
            0
          ],
          "destination": [
            "reset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reset",
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
            "observe-on",
            0
          ],
          "destination": [
            "observe-clock",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "observe-clock",
            0
          ],
          "destination": [
            "observe",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "observe",
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
            "hello-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hello-route",
            0
          ],
          "destination": [
            "hello-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hello-unpack",
            2
          ],
          "destination": [
            "hello-version",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hello-version",
            0
          ],
          "destination": [
            "observe-on",
            0
          ]
        }
      }
    ],
    "dependency_cache": [
      {
        "name": "mlr.sequence_player.mxo",
        "type": "iLaX"
      }
    ]
  }
}
