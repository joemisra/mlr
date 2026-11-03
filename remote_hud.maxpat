{
  "patcher": {
    "fileversion": 1,
    "rect": [
      100,
      100,
      680,
      380
    ],
    "boxes": [
      {
        "box": {
          "id": "note",
          "maxclass": "comment",
          "text": "Open alongside ONE running edition. Server starts here; bookmark and pairing code print in Max console.",
          "patching_rect": [
            20,
            20,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "start",
          "maxclass": "message",
          "text": "script start",
          "patching_rect": [
            20,
            65,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stop",
          "maxclass": "message",
          "text": "script stop",
          "patching_rect": [
            340,
            65,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "node",
          "maxclass": "newobj",
          "text": "node.script remote_hud_server.js @autostart 1",
          "patching_rect": [
            20,
            150,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "state",
          "maxclass": "newobj",
          "text": "r mlr_hud_state",
          "patching_rect": [
            20,
            105,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "commands",
          "maxclass": "newobj",
          "text": "s mlr_remote_hud_command",
          "patching_rect": [
            20,
            195,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "warning",
          "maxclass": "comment",
          "text": "File choosers and plug-in editors open on the computer. Stop server when finished.",
          "patching_rect": [
            20,
            325,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "batch",
          "maxclass": "newobj",
          "text": "v8 remote_hud_batch.js @autowatch 1",
          "patching_rect": [
            340,
            105,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "route",
          "maxclass": "newobj",
          "text": "route remote_stream",
          "patching_rect": [
            340,
            195,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "active",
          "maxclass": "newobj",
          "text": "prepend active",
          "patching_rect": [
            340,
            235,
            300,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stop-trigger",
          "maxclass": "newobj",
          "text": "t b l",
          "patching_rect": [
            340,
            275,
            60,
            22
          ]
        }
      },
      {
        "box": {
          "id": "disable",
          "maxclass": "message",
          "text": "active 0",
          "patching_rect": [
            440,
            275,
            80,
            22
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "start",
            0
          ],
          "destination": [
            "node",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state",
            0
          ],
          "destination": [
            "batch",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "batch",
            0
          ],
          "destination": [
            "node",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "node",
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
            "route",
            0
          ],
          "destination": [
            "active",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "active",
            0
          ],
          "destination": [
            "batch",
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
            "commands",
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
            "stop-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-trigger",
            1
          ],
          "destination": [
            "node",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-trigger",
            0
          ],
          "destination": [
            "disable",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "disable",
            0
          ],
          "destination": [
            "batch",
            0
          ]
        }
      }
    ]
  }
}
