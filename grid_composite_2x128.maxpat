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
            1474.0,
            100.0,
            780.0,
            520.0
        ],
        "boxes": [
            {
                "box": {
                    "id": "obj-title",
                    "linecount": 12,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        12.0,
                        12.0,
                        560.0,
                        170.0
                    ],
                    "text": "grid_composite_2x128 -- two 128s as one logical 256\n\nArgs #1 #2 = serialosc DEVICE ports.\nOn load: sends /sys/host, /sys/port, /sys/prefix /box to each device.\nLED: inlet splits /grid/led/level/map by oy (top/bottom) -> udpsend to each device port.\nKeys: internal udpreceive 58901/58902 -> JS merges bottom y+=8 -> outlet.\n\nBridge: dual128 0, edition 256, prefix /box."
                }
            },
            {
                "box": {
                    "comment": "LED + passthrough in",
                    "id": "obj-in",
                    "index": 1,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        48.0,
                        200.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "OSC out (was monome out 0)",
                    "id": "obj-out",
                    "index": 1,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        48.0,
                        380.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-udprx0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        200.0,
                        100.0,
                        22.0
                    ],
                    "text": "udpreceive 58901"
                }
            },
            {
                "box": {
                    "id": "obj-udprx1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        236.0,
                        100.0,
                        22.0
                    ],
                    "text": "udpreceive 58902"
                }
            },
            {
                "box": {
                    "id": "obj-udps0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        520.0,
                        200.0,
                        145.0,
                        22.0
                    ],
                    "text": "udpsend 127.0.0.1 #1"
                }
            },
            {
                "box": {
                    "id": "obj-udps1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        520.0,
                        320.0,
                        144.0,
                        22.0
                    ],
                    "text": "udpsend 127.0.0.1 #2"
                }
            },
            {
                "box": {
                    "filename": "grid_composite_2x128.js",
                    "id": "obj-js",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        48.0,
                        292.0,
                        237.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 grid_composite_2x128.js @autowatch 1",
                    "textfile": {
                        "filename": "grid_composite_2x128.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
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
                        520.0,
                        12.0,
                        60.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-del",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        520.0,
                        44.0,
                        55.0,
                        22.0
                    ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "obj-tinit",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 6,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        520.0,
                        80.0,
                        74.0,
                        22.0
                    ],
                    "text": "t b b b b b b"
                }
            },
            {
                "box": {
                    "id": "obj-m0",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        112.0,
                        137.0,
                        22.0
                    ],
                    "text": "/sys/host 127.0.0.1"
                }
            },
            {
                "box": {
                    "id": "obj-m1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        144.0,
                        85.0,
                        22.0
                    ],
                    "text": "/sys/port 58901"
                }
            },
            {
                "box": {
                    "id": "obj-m2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        176.0,
                        120.0,
                        22.0
                    ],
                    "text": "/sys/prefix /box"
                }
            },
            {
                "box": {
                    "id": "obj-m3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        232.0,
                        137.0,
                        22.0
                    ],
                    "text": "/sys/host 127.0.0.1"
                }
            },
            {
                "box": {
                    "id": "obj-m4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        264.0,
                        85.0,
                        22.0
                    ],
                    "text": "/sys/port 58902"
                }
            },
            {
                "box": {
                    "id": "obj-m5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        296.0,
                        120.0,
                        22.0
                    ],
                    "text": "/sys/prefix /box"
                }
            },
            {
                "box": {
                    "id": "obj-c-init",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        600.0,
                        44.0,
                        280.0,
                        33.0
                    ],
                    "text": "Tell each grid where to send keys (required without monome-device)."
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-js",
                        0
                    ],
                    "source": [
                        "obj-in",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-js",
                        1
                    ],
                    "source": [
                        "obj-udprx0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-js",
                        2
                    ],
                    "source": [
                        "obj-udprx1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps0",
                        0
                    ],
                    "source": [
                        "obj-js",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps1",
                        0
                    ],
                    "source": [
                        "obj-js",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-out",
                        0
                    ],
                    "source": [
                        "obj-js",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-del",
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
                        "obj-tinit",
                        0
                    ],
                    "source": [
                        "obj-del",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-m0",
                        0
                    ],
                    "source": [
                        "obj-tinit",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-m1",
                        0
                    ],
                    "source": [
                        "obj-tinit",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-m2",
                        0
                    ],
                    "source": [
                        "obj-tinit",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-m3",
                        0
                    ],
                    "source": [
                        "obj-tinit",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-m4",
                        0
                    ],
                    "source": [
                        "obj-tinit",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-m5",
                        0
                    ],
                    "source": [
                        "obj-tinit",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps0",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        138.0,
                        510.0,
                        138.0,
                        510.0,
                        195.0,
                        529.5,
                        195.0
                    ],
                    "source": [
                        "obj-m0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps0",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        170.0,
                        510.0,
                        170.0,
                        510.0,
                        195.0,
                        529.5,
                        195.0
                    ],
                    "source": [
                        "obj-m1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps0",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        202.0,
                        510.0,
                        202.0,
                        510.0,
                        195.0,
                        529.5,
                        195.0
                    ],
                    "source": [
                        "obj-m2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps1",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        258.0,
                        510.0,
                        258.0,
                        510.0,
                        315.0,
                        529.5,
                        315.0
                    ],
                    "source": [
                        "obj-m3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps1",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        290.0,
                        510.0,
                        290.0,
                        510.0,
                        315.0,
                        529.5,
                        315.0
                    ],
                    "source": [
                        "obj-m4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-udps1",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        322.0,
                        510.0,
                        322.0,
                        510.0,
                        315.0,
                        529.5,
                        315.0
                    ],
                    "source": [
                        "obj-m5",
                        0
                    ]
                }
            }
        ]
    }
}
