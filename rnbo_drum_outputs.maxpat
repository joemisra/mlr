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
            100,
            100,
            1050,
            620
        ],
        "boxes": [
            {
                "box": {
                    "id": "mode",
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        20,
                        30,
                        30
                    ],
                    "index": 1
                }
            },
            {
                "box": {
                    "id": "level",
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        260,
                        20,
                        30,
                        30
                    ],
                    "index": 2
                }
            },
            {
                "box": {
                    "id": "mode-clip",
                    "maxclass": "newobj",
                    "text": "clip 0 2",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        65,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "mode-signal",
                    "maxclass": "newobj",
                    "text": "sig~ 0.",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        100,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "reservation",
                    "maxclass": "newobj",
                    "text": "s~ mlr_drum_es9_active",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        135,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "mode-smooth",
                    "maxclass": "newobj",
                    "text": "rampsmooth~ 960 960",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        175,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "level-clip",
                    "maxclass": "newobj",
                    "text": "clip 0. 1.",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        260,
                        65,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "level-pack",
                    "maxclass": "newobj",
                    "text": "pack 0.5 20",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        260,
                        100,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "level-signal",
                    "maxclass": "newobj",
                    "text": "line~ 0.5",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        260,
                        135,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "send-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        260,
                        175,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dac",
                    "maxclass": "newobj",
                    "text": "dac~ 9 10 11 12 13 14 15 16",
                    "numinlets": 8,
                    "numoutlets": 0,
                    "patching_rect": [
                        200,
                        540,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "kick-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_kick_left",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        260,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "kick-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        320,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "snare-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_snare_left",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        270,
                        260,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "snare-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        270,
                        320,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "hat-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_hat_left",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        520,
                        260,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "hat-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        520,
                        320,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "clap-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_clap_left",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        770,
                        260,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "clap-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        770,
                        320,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "reserved-max",
                    "maxclass": "newobj",
                    "text": "maximum~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        500,
                        100,
                        150,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "reserved-active",
                    "maxclass": "newobj",
                    "text": ">~ 0.",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        500,
                        135,
                        150,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "mode-enabled",
                    "maxclass": "newobj",
                    "text": "> 0",
                    "patching_rect": [
                        500,
                        565,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-enabled",
                    "maxclass": "newobj",
                    "text": "== 2",
                    "patching_rect": [
                        500,
                        590,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-signal",
                    "maxclass": "newobj",
                    "text": "sig~ 0.",
                    "patching_rect": [
                        500,
                        615,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-smooth",
                    "maxclass": "newobj",
                    "text": "rampsmooth~ 960 960",
                    "patching_rect": [
                        500,
                        640,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        500,
                        665,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-max",
                    "maxclass": "newobj",
                    "text": "maximum~",
                    "patching_rect": [
                        500,
                        690,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-active",
                    "maxclass": "newobj",
                    "text": ">~ 0.",
                    "patching_rect": [
                        500,
                        715,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "upper-reservation",
                    "maxclass": "newobj",
                    "text": "s~ mlr_synth_es9_active",
                    "patching_rect": [
                        500,
                        740,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "tom-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_tom_left",
                    "patching_rect": [
                        500,
                        765,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "tom-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        500,
                        765,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "rim-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_rim_left",
                    "patching_rect": [
                        500,
                        815,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "rim-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        500,
                        815,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bell-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_bell_left",
                    "patching_rect": [
                        500,
                        865,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bell-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        500,
                        865,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bass-in",
                    "maxclass": "newobj",
                    "text": "r~ rnbo_bass_left",
                    "patching_rect": [
                        500,
                        915,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bass-gain",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        500,
                        915,
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
                        "mode",
                        0
                    ],
                    "destination": [
                        "mode-clip",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-signal",
                        0
                    ],
                    "destination": [
                        "mode-smooth",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "level",
                        0
                    ],
                    "destination": [
                        "level-clip",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "level-clip",
                        0
                    ],
                    "destination": [
                        "level-pack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "level-pack",
                        0
                    ],
                    "destination": [
                        "level-signal",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "level-signal",
                        0
                    ],
                    "destination": [
                        "send-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-smooth",
                        0
                    ],
                    "destination": [
                        "send-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "kick-in",
                        0
                    ],
                    "destination": [
                        "kick-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "send-gain",
                        0
                    ],
                    "destination": [
                        "kick-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "kick-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-in",
                        0
                    ],
                    "destination": [
                        "snare-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "send-gain",
                        0
                    ],
                    "destination": [
                        "snare-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-in",
                        0
                    ],
                    "destination": [
                        "hat-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "send-gain",
                        0
                    ],
                    "destination": [
                        "hat-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-in",
                        0
                    ],
                    "destination": [
                        "clap-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "send-gain",
                        0
                    ],
                    "destination": [
                        "clap-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-signal",
                        0
                    ],
                    "destination": [
                        "reserved-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-smooth",
                        0
                    ],
                    "destination": [
                        "reserved-max",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "reserved-max",
                        0
                    ],
                    "destination": [
                        "reserved-active",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "reserved-active",
                        0
                    ],
                    "destination": [
                        "reservation",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-clip",
                        0
                    ],
                    "destination": [
                        "mode-enabled",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-enabled",
                        0
                    ],
                    "destination": [
                        "mode-signal",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-clip",
                        0
                    ],
                    "destination": [
                        "upper-enabled",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-enabled",
                        0
                    ],
                    "destination": [
                        "upper-signal",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-signal",
                        0
                    ],
                    "destination": [
                        "upper-smooth",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-signal",
                        0
                    ],
                    "destination": [
                        "upper-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-smooth",
                        0
                    ],
                    "destination": [
                        "upper-max",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-max",
                        0
                    ],
                    "destination": [
                        "upper-active",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-active",
                        0
                    ],
                    "destination": [
                        "upper-reservation",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "level-signal",
                        0
                    ],
                    "destination": [
                        "upper-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-smooth",
                        0
                    ],
                    "destination": [
                        "upper-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "tom-in",
                        0
                    ],
                    "destination": [
                        "tom-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-gain",
                        0
                    ],
                    "destination": [
                        "tom-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "tom-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-in",
                        0
                    ],
                    "destination": [
                        "rim-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-gain",
                        0
                    ],
                    "destination": [
                        "rim-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bell-in",
                        0
                    ],
                    "destination": [
                        "bell-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-gain",
                        0
                    ],
                    "destination": [
                        "bell-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bell-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-in",
                        0
                    ],
                    "destination": [
                        "bass-gain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "upper-gain",
                        0
                    ],
                    "destination": [
                        "bass-gain",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-gain",
                        0
                    ],
                    "destination": [
                        "dac",
                        7
                    ]
                }
            }
        ]
    }
}
