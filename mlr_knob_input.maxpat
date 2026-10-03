{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            180,
            120,
            710,
            330
        ],
        "openinpresentation": 1,
        "default_fontsize": 12,
        "boxes": [
            {
                "box": {
                    "id": "window-control-inlet",
                    "maxclass": "inlet",
                    "patching_rect": [640, 370, 30, 30]
                }
            },
            {
                "box": {
                    "id": "channel-default",
                    "maxclass": "newobj",
                    "text": "loadmess set 1",
                    "patching_rect": [
                        310,
                        475,
                        120,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "disconnect",
                    "maxclass": "textbutton",
                    "text": "Disconnect",
                    "patching_rect": [
                        565,
                        137,
                        110,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        565,
                        137,
                        110,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "disconnect-message",
                    "maxclass": "message",
                    "text": "port none",
                    "patching_rect": [
                        450,
                        475,
                        95,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "text": "Hachi-ni · focused sound / step locks",
                    "patching_rect": [
                        20,
                        12,
                        665,
                        30
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        12,
                        665,
                        30
                    ],
                    "fontsize": 22
                }
            },
            {
                "box": {
                    "id": "help",
                    "maxclass": "comment",
                    "text": "CC 32–47. Hold step + turn to lock; otherwise edit sound. Keep hachi-ni OFF the legacy MIDI setup.",
                    "patching_rect": [
                        20,
                        48,
                        665,
                        40
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        48,
                        665,
                        40
                    ]
                }
            },
            {
                "box": {
                    "id": "port",
                    "maxclass": "umenu",
                    "patching_rect": [
                        20,
                        95,
                        300,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        95,
                        300,
                        24
                    ],
                    "items": [
                        "Select controller input"
                    ]
                }
            },
            {
                "box": {
                    "id": "refresh",
                    "maxclass": "textbutton",
                    "text": "Refresh inputs",
                    "patching_rect": [
                        335,
                        95,
                        120,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        335,
                        95,
                        120,
                        24
                    ]
                }
            },
            {
                "box": {
                    "id": "channel-label",
                    "maxclass": "comment",
                    "text": "MIDI channel",
                    "patching_rect": [
                        470,
                        96,
                        100,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470,
                        96,
                        100,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "channel",
                    "maxclass": "number",
                    "patching_rect": [
                        580,
                        95,
                        55,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        580,
                        95,
                        55,
                        24
                    ],
                    "minimum": 1,
                    "maximum": 16
                }
            },
            {
                "box": {
                    "id": "source",
                    "maxclass": "tab",
                    "patching_rect": [
                        20,
                        137,
                        300,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        137,
                        300,
                        28
                    ],
                    "tabs": [
                        "Grid focus",
                        "Lab tab focus"
                    ]
                }
            },
            {
                "box": {
                    "id": "learn",
                    "maxclass": "textbutton",
                    "text": "Learn 16",
                    "patching_rect": [
                        335,
                        137,
                        100,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        335,
                        137,
                        100,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "cancel",
                    "maxclass": "textbutton",
                    "text": "Cancel learn",
                    "patching_rect": [
                        445,
                        137,
                        110,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        445,
                        137,
                        110,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "save",
                    "maxclass": "textbutton",
                    "text": "Save map",
                    "patching_rect": [
                        20,
                        181,
                        100,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        181,
                        100,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "load",
                    "maxclass": "textbutton",
                    "text": "Load map",
                    "patching_rect": [
                        130,
                        181,
                        100,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130,
                        181,
                        100,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "status",
                    "maxclass": "comment",
                    "text": "Select controller input. CC 32–47 uses channel 1 unless changed.",
                    "patching_rect": [
                        20,
                        222,
                        665,
                        42
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        222,
                        665,
                        42
                    ]
                }
            },
            {
                "box": {
                    "id": "map-note",
                    "maxclass": "comment",
                    "text": "Knobs 1–4 = page 1; 5–8 = page 2; 9–12 = page 3. Knobs 13–16 reserved. Pickup prevents jumps.",
                    "patching_rect": [
                        20,
                        274,
                        665,
                        40
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        274,
                        665,
                        40
                    ]
                }
            },
            {
                "box": {
                    "id": "script",
                    "maxclass": "newobj",
                    "text": "v8 mlr_knob_input.js",
                    "patching_rect": [
                        20,
                        370,
                        170,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "input",
                    "maxclass": "newobj",
                    "text": "ctlin none @matchport 1",
                    "patching_rect": [
                        20,
                        405,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "pack",
                    "maxclass": "newobj",
                    "text": "pack i i i",
                    "patching_rect": [
                        230,
                        405,
                        90,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "defer",
                    "maxclass": "newobj",
                    "text": "deferlow",
                    "patching_rect": [
                        340,
                        405,
                        90,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "cc",
                    "maxclass": "newobj",
                    "text": "prepend cc",
                    "patching_rect": [
                        450,
                        405,
                        90,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "port-prefix",
                    "maxclass": "newobj",
                    "text": "prepend port",
                    "patching_rect": [
                        230,
                        370,
                        110,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "info",
                    "maxclass": "newobj",
                    "text": "midiinfo",
                    "patching_rect": [
                        20,
                        440,
                        90,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "refresh-message",
                    "maxclass": "message",
                    "text": "-1",
                    "patching_rect": [
                        130,
                        440,
                        40,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "load-inputs",
                    "maxclass": "newobj",
                    "text": "loadmess -1",
                    "patching_rect": [
                        190,
                        440,
                        95,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "source-prefix",
                    "maxclass": "newobj",
                    "text": "prepend source",
                    "patching_rect": [
                        310,
                        440,
                        120,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "source-default",
                    "maxclass": "newobj",
                    "text": "loadmess 0",
                    "patching_rect": [
                        450,
                        440,
                        95,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "channel-prefix",
                    "maxclass": "newobj",
                    "text": "prepend channel",
                    "patching_rect": [
                        20,
                        475,
                        130,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "learn-message",
                    "maxclass": "message",
                    "text": "learn",
                    "patching_rect": [
                        180,
                        475,
                        70,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "cancel-message",
                    "maxclass": "message",
                    "text": "cancel",
                    "patching_rect": [
                        270,
                        475,
                        70,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "map",
                    "maxclass": "newobj",
                    "text": "dict mlr_knob_bindings @embed 0",
                    "patching_rect": [
                        20,
                        510,
                        245,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "save-message",
                    "maxclass": "message",
                    "text": "write",
                    "patching_rect": [
                        280,
                        510,
                        50,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "load-message",
                    "maxclass": "message",
                    "text": "read",
                    "patching_rect": [
                        350,
                        510,
                        50,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "status-receive",
                    "maxclass": "newobj",
                    "text": "r mlr_knob_status",
                    "patching_rect": [
                        20,
                        545,
                        150,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "status-prefix",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "patching_rect": [
                        190,
                        545,
                        100,
                        22
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "channel-default",
                        0
                    ],
                    "destination": [
                        "channel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "disconnect",
                        0
                    ],
                    "destination": [
                        "disconnect-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "disconnect-message",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "port",
                        1
                    ],
                    "destination": [
                        "port-prefix",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "port-prefix",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "script",
                        1
                    ],
                    "destination": [
                        "input",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "script",
                        0
                    ],
                    "destination": [
                        "status",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "input",
                        0
                    ],
                    "destination": [
                        "pack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "input",
                        1
                    ],
                    "destination": [
                        "pack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "input",
                        2
                    ],
                    "destination": [
                        "pack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "pack",
                        0
                    ],
                    "destination": [
                        "defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "defer",
                        0
                    ],
                    "destination": [
                        "cc",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "cc",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "refresh",
                        0
                    ],
                    "destination": [
                        "refresh-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "refresh-message",
                        0
                    ],
                    "destination": [
                        "info",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "load-inputs",
                        0
                    ],
                    "destination": [
                        "info",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "info",
                        0
                    ],
                    "destination": [
                        "port",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "source",
                        0
                    ],
                    "destination": [
                        "source-prefix",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "source-prefix",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "source-default",
                        0
                    ],
                    "destination": [
                        "source",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "channel",
                        0
                    ],
                    "destination": [
                        "channel-prefix",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "channel-prefix",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "learn",
                        0
                    ],
                    "destination": [
                        "learn-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "learn-message",
                        0
                    ],
                    "destination": [
                        "script",
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
                        "cancel-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "cancel-message",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "save",
                        0
                    ],
                    "destination": [
                        "save-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "save-message",
                        0
                    ],
                    "destination": [
                        "map",
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
                        "load-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "load-message",
                        0
                    ],
                    "destination": [
                        "map",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "map",
                        0
                    ],
                    "destination": [
                        "script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "status-receive",
                        0
                    ],
                    "destination": [
                        "status-prefix",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "status-prefix",
                        0
                    ],
                    "destination": [
                        "status",
                        0
                    ]
                }
            }
        ]
    }
}
