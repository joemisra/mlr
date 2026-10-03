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
        "rect": [ 100.0, 100.0, 1050.0, 620.0 ],
        "boxes": [
            {
                "box": {
                    "comment": "",
                    "id": "mode",
                    "index": 1,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 20.0, 20.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "",
                    "id": "level",
                    "index": 2,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 20.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "id": "mode-clip",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 65.0, 190.0, 22.0 ],
                    "text": "clip 0 2"
                }
            },
            {
                "box": {
                    "id": "mode-signal",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 20.0, 100.0, 190.0, 22.0 ],
                    "text": "sig~ 0."
                }
            },
            {
                "box": {
                    "id": "reservation",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 135.0, 190.0, 22.0 ],
                    "text": "s~ mlr_drum_es9_active"
                }
            },
            {
                "box": {
                    "id": "mode-smooth",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 20.0, 175.0, 190.0, 22.0 ],
                    "text": "rampsmooth~ 960 960"
                }
            },
            {
                "box": {
                    "id": "level-clip",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 65.0, 190.0, 22.0 ],
                    "text": "clip 0. 1."
                }
            },
            {
                "box": {
                    "id": "level-pack",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 100.0, 190.0, 22.0 ],
                    "text": "pack 0.5 20"
                }
            },
            {
                "box": {
                    "id": "level-signal",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "bang" ],
                    "patching_rect": [ 260.0, 135.0, 190.0, 22.0 ],
                    "text": "line~ 0.5"
                }
            },
            {
                "box": {
                    "id": "send-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 260.0, 175.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "dac",
                    "maxclass": "newobj",
                    "numinlets": 8,
                    "numoutlets": 0,
                    "patching_rect": [ 200.0, 540.0, 190.0, 22.0 ],
                    "text": "dac~ 9 10 11 12 13 14 15 16"
                }
            },
            {
                "box": {
                    "id": "kick-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 20.0, 260.0, 190.0, 22.0 ],
                    "text": "r~ rnbo_kick_left"
                }
            },
            {
                "box": {
                    "id": "kick-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 20.0, 320.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "snare-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 270.0, 260.0, 190.0, 22.0 ],
                    "text": "r~ rnbo_snare_left"
                }
            },
            {
                "box": {
                    "id": "snare-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 270.0, 320.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "hat-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 520.0, 260.0, 190.0, 22.0 ],
                    "text": "r~ rnbo_hat_left"
                }
            },
            {
                "box": {
                    "id": "hat-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 520.0, 320.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "clap-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 770.0, 260.0, 190.0, 22.0 ],
                    "text": "r~ rnbo_clap_left"
                }
            },
            {
                "box": {
                    "id": "clap-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 770.0, 320.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "reserved-max",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 100.0, 150.0, 22.0 ],
                    "text": "maximum~"
                }
            },
            {
                "box": {
                    "id": "reserved-active",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 135.0, 150.0, 22.0 ],
                    "text": ">~ 0."
                }
            },
            {
                "box": {
                    "id": "mode-enabled",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 500.0, 565.0, 180.0, 22.0 ],
                    "text": "> 0"
                }
            },
            {
                "box": {
                    "id": "upper-enabled",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 500.0, 590.0, 180.0, 22.0 ],
                    "text": "== 2"
                }
            },
            {
                "box": {
                    "id": "upper-signal",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 615.0, 180.0, 22.0 ],
                    "text": "sig~ 0."
                }
            },
            {
                "box": {
                    "id": "upper-smooth",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 640.0, 180.0, 22.0 ],
                    "text": "rampsmooth~ 960 960"
                }
            },
            {
                "box": {
                    "id": "upper-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 665.0, 180.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "upper-max",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 690.0, 180.0, 22.0 ],
                    "text": "maximum~"
                }
            },
            {
                "box": {
                    "id": "upper-active",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 715.0, 180.0, 22.0 ],
                    "text": ">~ 0."
                }
            },
            {
                "box": {
                    "id": "upper-reservation",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 500.0, 740.0, 180.0, 22.0 ],
                    "text": "s~ mlr_synth_es9_active"
                }
            },
            {
                "box": {
                    "id": "tom-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 765.0, 180.0, 22.0 ],
                    "text": "r~ rnbo_tom_left"
                }
            },
            {
                "box": {
                    "id": "tom-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 765.0, 180.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "rim-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 815.0, 180.0, 22.0 ],
                    "text": "r~ rnbo_rim_left"
                }
            },
            {
                "box": {
                    "id": "rim-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 815.0, 180.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "bell-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 865.0, 180.0, 22.0 ],
                    "text": "r~ rnbo_bell_left"
                }
            },
            {
                "box": {
                    "id": "bell-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 865.0, 180.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "bass-in",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 915.0, 180.0, 22.0 ],
                    "text": "r~ rnbo_bass_left"
                }
            },
            {
                "box": {
                    "id": "bass-gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 915.0, 180.0, 22.0 ],
                    "text": "*~"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "dac", 7 ],
                    "source": [ "bass-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-gain", 0 ],
                    "source": [ "bass-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 6 ],
                    "source": [ "bell-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bell-gain", 0 ],
                    "source": [ "bell-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 3 ],
                    "source": [ "clap-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "clap-gain", 0 ],
                    "source": [ "clap-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 2 ],
                    "source": [ "hat-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "hat-gain", 0 ],
                    "source": [ "hat-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 0 ],
                    "source": [ "kick-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "kick-gain", 0 ],
                    "source": [ "kick-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "level-clip", 0 ],
                    "source": [ "level", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "level-pack", 0 ],
                    "source": [ "level-clip", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "level-signal", 0 ],
                    "source": [ "level-pack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "send-gain", 0 ],
                    "order": 1,
                    "source": [ "level-signal", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-gain", 0 ],
                    "order": 0,
                    "source": [ "level-signal", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mode-clip", 0 ],
                    "source": [ "mode", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mode-enabled", 0 ],
                    "order": 1,
                    "source": [ "mode-clip", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-enabled", 0 ],
                    "order": 0,
                    "source": [ "mode-clip", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mode-signal", 0 ],
                    "source": [ "mode-enabled", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mode-smooth", 0 ],
                    "order": 1,
                    "source": [ "mode-signal", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "reserved-max", 0 ],
                    "order": 0,
                    "source": [ "mode-signal", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "reserved-max", 1 ],
                    "order": 0,
                    "source": [ "mode-smooth", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "send-gain", 1 ],
                    "order": 1,
                    "source": [ "mode-smooth", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "reservation", 0 ],
                    "source": [ "reserved-active", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "reserved-active", 0 ],
                    "source": [ "reserved-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 5 ],
                    "source": [ "rim-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-gain", 0 ],
                    "source": [ "rim-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "clap-gain", 1 ],
                    "order": 0,
                    "source": [ "send-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "hat-gain", 1 ],
                    "order": 1,
                    "source": [ "send-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "kick-gain", 1 ],
                    "order": 3,
                    "source": [ "send-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-gain", 1 ],
                    "order": 2,
                    "source": [ "send-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 1 ],
                    "source": [ "snare-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-gain", 0 ],
                    "source": [ "snare-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 4 ],
                    "source": [ "tom-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-gain", 0 ],
                    "source": [ "tom-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-reservation", 0 ],
                    "source": [ "upper-active", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-signal", 0 ],
                    "source": [ "upper-enabled", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-gain", 1 ],
                    "order": 0,
                    "source": [ "upper-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bell-gain", 1 ],
                    "order": 1,
                    "source": [ "upper-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-gain", 1 ],
                    "order": 2,
                    "source": [ "upper-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-gain", 1 ],
                    "order": 3,
                    "source": [ "upper-gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-active", 0 ],
                    "source": [ "upper-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-max", 0 ],
                    "order": 0,
                    "source": [ "upper-signal", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-smooth", 0 ],
                    "order": 1,
                    "source": [ "upper-signal", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-gain", 1 ],
                    "order": 1,
                    "source": [ "upper-smooth", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "upper-max", 1 ],
                    "order": 0,
                    "source": [ "upper-smooth", 0 ]
                }
            }
        ]
    }
}