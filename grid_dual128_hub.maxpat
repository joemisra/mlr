{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 0,
            "revision": 0,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            100.0,
            100.0,
            520.0,
            380.0
        ],
        "boxes": [
            {
                "box": {
                    "id": "obj-title",
                    "linecount": 10,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        12.0,
                        12.0,
                        490.0,
                        141.0
                    ],
                    "text": "grid_dual128_hub \u2014 two Monome 128s stacked = one logical 256 (16\u00d716).\n\n1) Primary grid keys already use [s box/press_a] \u2192 merged here \u2192 [s box/press_mlr].\nPorts: [serialosc_list_devices.maxpat] \u2192 Query.\nPreferred: [grid_composite_2x128 portTop portBottom] replaces [monome-device] \u2014 two UDP ports, no global r/s clashes. Matrix: dual128 0, edition 256.\n\nAlt merge path: 2) [grid_dual128_key_route] \u2192 [s box/press_b] (avoid a 2nd [monome-device]). 3) Matrix dual128 1 + right outlet to 2nd grid LEDs.\n\nUI: choose grid 256; hub dual128 1 only for the key-merge path. The dual128 toggle here does NOT affect the LED bridge \u2014 bridge dual128 mode is always 0 when using grid_composite_2x128 (the composite handles row splitting)."
                }
            },
            {
                "box": {
                    "id": "obj-ra",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        12.0,
                        200.0,
                        95.0,
                        22.0
                    ],
                    "text": "r box/press_a"
                }
            },
            {
                "box": {
                    "id": "obj-rb",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        12.0,
                        234.0,
                        95.0,
                        22.0
                    ],
                    "text": "r box/press_b"
                }
            },
            {
                "box": {
                    "id": "obj-merge",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        130.0,
                        216.0,
                        145.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 grid_dual128_merge.js @autowatch 1",
                    "textfile": {
                        "filename": "grid_dual128_merge.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-smlr",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        130.0,
                        268.0,
                        105.0,
                        22.0
                    ],
                    "text": "s box/press_mlr"
                }
            },
            {
                "box": {
                    "id": "obj-lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        300.0,
                        200.0,
                        60.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-lm0",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        234.0,
                        65.0,
                        22.0
                    ],
                    "text": "dual128 0"
                }
            },
            {
                "box": {
                    "id": "obj-msg-on",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        268.0,
                        65.0,
                        22.0
                    ],
                    "text": "dual128 1"
                }
            },
            {
                "box": {
                    "id": "obj-msg-off",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        268.0,
                        65.0,
                        22.0
                    ],
                    "text": "dual128 0"
                }
            },
            {
                "box": {
                    "id": "obj-smat",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        300.0,
                        308.0,
                        105.0,
                        22.0
                    ],
                    "text": "s togridmatrixio"
                }
            },
            {
                "box": {
                    "id": "obj-ed",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        234.0,
                        67.0,
                        22.0
                    ],
                    "text": "edition 256"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-merge",
                        0
                    ],
                    "source": [
                        "obj-ra",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-merge",
                        1
                    ],
                    "source": [
                        "obj-rb",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-smlr",
                        0
                    ],
                    "source": [
                        "obj-merge",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-lm0",
                        0
                    ],
                    "source": [
                        "obj-lb",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-merge",
                        0
                    ],
                    "midpoints": [
                        309.5,
                        262.0,
                        285.0,
                        262.0,
                        285.0,
                        205.0,
                        139.5,
                        205.0
                    ],
                    "source": [
                        "obj-lm0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-merge",
                        0
                    ],
                    "midpoints": [
                        309.5,
                        295.0,
                        285.0,
                        295.0,
                        285.0,
                        205.0,
                        139.5,
                        205.0
                    ],
                    "source": [
                        "obj-msg-on",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-merge",
                        0
                    ],
                    "midpoints": [
                        389.5,
                        295.0,
                        285.0,
                        295.0,
                        285.0,
                        205.0,
                        139.5,
                        205.0
                    ],
                    "source": [
                        "obj-msg-off",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-smat",
                        0
                    ],
                    "source": [
                        "obj-ed",
                        0
                    ]
                }
            }
        ]
    }
}
