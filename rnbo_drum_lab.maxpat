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
            160,
            80,
            930,
            868
        ],
        "openinpresentation": 1,
        "default_fontsize": 12,
        "boxes": [
            {
                "box": {
                    "id": "knobs-open",
                    "maxclass": "textbutton",
                    "text": "Knobs…",
                    "patching_rect": [
                        755,
                        195,
                        145,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        755,
                        195,
                        145,
                        24
                    ]
                }
            },
            {
                "box": {
                    "id": "knobs-open-message",
                    "maxclass": "message",
                    "text": "open",
                    "patching_rect": [
                        755,
                        900,
                        50,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "knobs-window",
                    "maxclass": "newobj",
                    "text": "pcontrol",
                    "patching_rect": [
                        755,
                        935,
                        75,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "knobs",
                    "maxclass": "newobj",
                    "text": "mlr_knob_input",
                    "patching_rect": [
                        755,
                        970,
                        130,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "knobs-tab-focus",
                    "maxclass": "newobj",
                    "text": "prepend knobLabFocus",
                    "patching_rect": [
                        755,
                        1005,
                        180,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "knobs-focus-send",
                    "maxclass": "newobj",
                    "text": "s gridrouter",
                    "patching_rect": [
                        755,
                        1040,
                        100,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "patching_rect": [
                        20,
                        12,
                        880,
                        30
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        12,
                        880,
                        30
                    ],
                    "text": "RNBO drum lab",
                    "fontsize": 24,
                    "numinlets": 1,
                    "numoutlets": 0
                }
            },
            {
                "box": {
                    "id": "help",
                    "maxclass": "comment",
                    "patching_rect": [
                        20,
                        48,
                        880,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        48,
                        880,
                        22
                    ],
                    "text": "All eight voices stay loaded. Tabs change the view; scroll each page for its ranges.",
                    "numinlets": 1,
                    "numoutlets": 0
                }
            },
            {
                "box": {
                    "id": "tabs",
                    "maxclass": "tab",
                    "patching_rect": [
                        20,
                        80,
                        880,
                        34
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        80,
                        880,
                        34
                    ],
                    "tabs": [
                        "Kick · 15",
                        "Snare · 14",
                        "Hat · 13",
                        "Clap · 12",
                        "Tom · 11",
                        "Rim · 10",
                        "Bell · 9",
                        "FM · 8"
                    ],
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "varname": "drum_lab_tabs"
                }
            },
            {
                "box": {
                    "id": "lab-kick",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_kick.maxpat",
                    "varname": "lab_kick",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 0
                }
            },
            {
                "box": {
                    "id": "lab-snare",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_snare.maxpat",
                    "varname": "lab_snare",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "lab-hat",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_hat.maxpat",
                    "varname": "lab_hat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "lab-clap",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_clap.maxpat",
                    "varname": "lab_clap",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "footer",
                    "maxclass": "comment",
                    "patching_rect": [
                        20,
                        756,
                        880,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        824,
                        880,
                        22
                    ],
                    "text": "Use this window instead of separate lab instances. Save range-preset edits in the individual lab patch.",
                    "numinlets": 1,
                    "numoutlets": 0
                }
            },
            {
                "box": {
                    "id": "select",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        80,
                        120,
                        22
                    ],
                    "text": "sel 0 1 2 3 4 5 6 7",
                    "numinlets": 5,
                    "numoutlets": 9,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "window",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        340,
                        85,
                        22
                    ],
                    "text": "thispatcher",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "show-kick",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        130,
                        660,
                        35
                    ],
                    "text": "script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_kick",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "show-snare",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        175,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_snare",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "show-hat",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        220,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_hat",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "show-clap",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        265,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_clap",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "initial",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        390,
                        80,
                        22
                    ],
                    "text": "loadmess 0",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "defer",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        425,
                        70,
                        22
                    ],
                    "text": "deferlow",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "output-mode",
                    "maxclass": "tab",
                    "tabs": [
                        "Stereo",
                        "6mix · 4",
                        "ES-9 · 8"
                    ],
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        20,
                        125,
                        300,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        125,
                        300,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "output-level",
                    "maxclass": "flonum",
                    "minimum": 0,
                    "maximum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "patching_rect": [
                        460,
                        125,
                        75,
                        28
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        460,
                        125,
                        75,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "output-level-label",
                    "maxclass": "comment",
                    "text": "External send (0–1)",
                    "patching_rect": [
                        335,
                        128,
                        125,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        335,
                        128,
                        125,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "output-map",
                    "maxclass": "comment",
                    "text": "ES-9 1–4: Kick / Snare / Hat / Clap. All-eight mode adds 5–8: Tom / Rim / Bell / FM Bass.",
                    "patching_rect": [
                        20,
                        162,
                        880,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        162,
                        880,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "outputs",
                    "maxclass": "newobj",
                    "text": "rnbo_drum_outputs",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        950,
                        470,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "output-default",
                    "maxclass": "newobj",
                    "text": "loadmess 0",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        950,
                        510,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "level-default",
                    "maxclass": "newobj",
                    "text": "loadmess 0.5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        1150,
                        510,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "lab-tom",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_tom.maxpat",
                    "varname": "lab_tom",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "show-tom",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        265,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_tom",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "lab-rim",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_rim.maxpat",
                    "varname": "lab_rim",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "show-rim",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        265,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_bell, script hide lab_bass, script show lab_rim",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "lab-bell",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_bell.maxpat",
                    "varname": "lab_bell",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "show-bell",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        265,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bass, script show lab_bell",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "lab-bass",
                    "maxclass": "bpatcher",
                    "patching_rect": [
                        20,
                        195,
                        880,
                        550
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        263,
                        880,
                        550
                    ],
                    "name": "rnbo_bass.maxpat",
                    "varname": "lab_bass",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "args": [],
                    "offset": [
                        0,
                        0
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "viewvisibility": 1,
                    "hidden": 1
                }
            },
            {
                "box": {
                    "id": "show-bass",
                    "maxclass": "message",
                    "patching_rect": [
                        950,
                        265,
                        660,
                        35
                    ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script show lab_bass",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-destination",
                    "maxclass": "tab",
                    "patching_rect": [
                        20,
                        826,
                        300,
                        22
                    ],
                    "tabs": [
                        "Local RNBO",
                        "DPT USB MIDI"
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        193,
                        270,
                        28
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-enable-send",
                    "maxclass": "newobj",
                    "text": "s dpt_enabled",
                    "patching_rect": [
                        20,
                        852,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-default",
                    "maxclass": "newobj",
                    "text": "loadmess 0",
                    "patching_rect": [
                        20,
                        878,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-port",
                    "maxclass": "umenu",
                    "patching_rect": [
                        20,
                        904,
                        300,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310,
                        195,
                        300,
                        24
                    ],
                    "items": [
                        "Choose DPT MIDI port"
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-refresh",
                    "maxclass": "textbutton",
                    "text": "Refresh ports",
                    "patching_rect": [
                        20,
                        930,
                        300,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        625,
                        195,
                        115,
                        24
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-refresh-bang",
                    "maxclass": "newobj",
                    "text": "t b",
                    "patching_rect": [
                        20,
                        956,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-midiinfo",
                    "maxclass": "newobj",
                    "text": "midiinfo",
                    "patching_rect": [
                        20,
                        982,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-load",
                    "maxclass": "newobj",
                    "text": "loadbang",
                    "patching_rect": [
                        20,
                        1008,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-port-prefix",
                    "maxclass": "newobj",
                    "text": "prepend port",
                    "patching_rect": [
                        20,
                        1034,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-out",
                    "maxclass": "newobj",
                    "text": "midiout none @matchport 1",
                    "patching_rect": [
                        20,
                        1060,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-data",
                    "maxclass": "newobj",
                    "text": "r dpt_midi_bytes",
                    "patching_rect": [
                        20,
                        1086,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-note",
                    "maxclass": "comment",
                    "text": "Choose the Daisy MIDI port, then DPT USB MIDI. Controls + locks go to DPT; listen to its audio outputs.",
                    "patching_rect": [
                        20,
                        1112,
                        300,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        230,
                        880,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-sync-send",
                    "maxclass": "newobj",
                    "text": "s dpt_sync",
                    "patching_rect": [
                        20,
                        1138,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-port-order",
                    "maxclass": "newobj",
                    "text": "t b s",
                    "patching_rect": [
                        20,
                        1164,
                        300,
                        22
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "knobs-open",
                        0
                    ],
                    "destination": [
                        "knobs-open-message",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "knobs-open-message",
                        0
                    ],
                    "destination": [
                        "knobs-window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "knobs-window",
                        0
                    ],
                    "destination": [
                        "knobs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "tabs",
                        0
                    ],
                    "destination": [
                        "knobs-tab-focus",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "knobs-tab-focus",
                        0
                    ],
                    "destination": [
                        "knobs-focus-send",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        0
                    ],
                    "destination": [
                        "show-kick",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-kick",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        1
                    ],
                    "destination": [
                        "show-snare",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-snare",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        2
                    ],
                    "destination": [
                        "show-hat",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-hat",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        3
                    ],
                    "destination": [
                        "show-clap",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-clap",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "initial",
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
                        "tabs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "tabs",
                        0
                    ],
                    "destination": [
                        "select",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "output-mode",
                        0
                    ],
                    "destination": [
                        "outputs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "output-level",
                        0
                    ],
                    "destination": [
                        "outputs",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "output-default",
                        0
                    ],
                    "destination": [
                        "output-mode",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "level-default",
                        0
                    ],
                    "destination": [
                        "output-level",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        4
                    ],
                    "destination": [
                        "show-tom",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-tom",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        5
                    ],
                    "destination": [
                        "show-rim",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-rim",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        6
                    ],
                    "destination": [
                        "show-bell",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-bell",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "select",
                        7
                    ],
                    "destination": [
                        "show-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "show-bass",
                        0
                    ],
                    "destination": [
                        "window",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-destination",
                        0
                    ],
                    "destination": [
                        "dpt-enable-send",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-default",
                        0
                    ],
                    "destination": [
                        "dpt-destination",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-refresh",
                        0
                    ],
                    "destination": [
                        "dpt-refresh-bang",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-refresh-bang",
                        0
                    ],
                    "destination": [
                        "dpt-midiinfo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-load",
                        0
                    ],
                    "destination": [
                        "dpt-midiinfo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-midiinfo",
                        0
                    ],
                    "destination": [
                        "dpt-port",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-port-prefix",
                        0
                    ],
                    "destination": [
                        "dpt-out",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-data",
                        0
                    ],
                    "destination": [
                        "dpt-out",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-port",
                        1
                    ],
                    "destination": [
                        "dpt-port-order",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-port-order",
                        0
                    ],
                    "destination": [
                        "dpt-sync-send",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-port-order",
                        1
                    ],
                    "destination": [
                        "dpt-port-prefix",
                        0
                    ]
                }
            }
        ],
        "autosave": 0
    }
}
