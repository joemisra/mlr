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
            562,
            140,
            930,
            1080
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontsize": 20,
                    "id": "obj-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        20,
                        250,
                        29
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        20,
                        500,
                        29
                    ],
                    "text": "RNBO FM Bass laboratory"
                }
            },
            {
                "box": {
                    "id": "obj-note",
                    "linenote": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        55,
                        418,
                        47
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        58,
                        825,
                        20
                    ],
                    "text": "Track 8 triggers the bass. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
                }
            },
            {
                "box": {
                    "id": "obj-trigger-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        130,
                        65,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        82,
                        130,
                        70,
                        20
                    ],
                    "text": "TRIGGER"
                }
            },
            {
                "box": {
                    "id": "obj-trigger",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        95,
                        125,
                        32,
                        32
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30,
                        120,
                        40,
                        40
                    ],
                    "varname": "bass_trigger"
                }
            },
            {
                "box": {
                    "id": "obj-trackreceive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        185,
                        65,
                        22
                    ],
                    "text": "r 9input"
                }
            },
            {
                "box": {
                    "id": "obj-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        115,
                        185,
                        75,
                        22
                    ],
                    "text": "unpack i i"
                }
            },
            {
                "box": {
                    "id": "obj-selectpress",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        210,
                        185,
                        45,
                        22
                    ],
                    "text": "sel 1"
                }
            },
            {
                "box": {
                    "id": "obj-globaltrigger",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        225,
                        125,
                        22
                    ],
                    "text": "r rnbo_bass_trigger"
                }
            },
            {
                "box": {
                    "id": "obj-deep",
                    "linenote": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        340,
                        125,
                        520,
                        35
                    ],
                    "text": "note 36, decayMs 550, fmIndex 0.45, fmRatio 1, fmDecayMs 220, feedback 0.05, subLevel 0.65, brightness 0.4, attackMs 2, bendSemitones 0, drive 1.4, level 0.45",
                    "varname": "bass_preset_deep"
                }
            },
            {
                "box": {
                    "id": "obj-knock",
                    "linenote": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        340,
                        160,
                        522,
                        35
                    ],
                    "text": "note 36, decayMs 450, fmIndex 2.8, fmRatio 1, fmDecayMs 160, feedback 0.15, subLevel 0.35, brightness 0.6, attackMs 2, bendSemitones 7, drive 1.4, level 0.45",
                    "varname": "bass_preset_knock"
                }
            },
            {
                "box": {
                    "id": "obj-hollow",
                    "linenote": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        340,
                        195,
                        520,
                        35
                    ],
                    "text": "note 48, decayMs 1000, fmIndex 4, fmRatio 2, fmDecayMs 220, feedback 0.6, subLevel 0.1, brightness 0.85, attackMs 2, bendSemitones 0, drive 1.4, level 0.45",
                    "varname": "bass_preset_hollow"
                }
            },
            {
                "box": {
                    "id": "obj-presets",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        340,
                        100,
                        220,
                        20
                    ],
                    "text": "starting sounds: Round / Rubber / Wire"
                }
            },
            {
                "box": {
                    "id": "obj-paramreceive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        340,
                        235,
                        115,
                        22
                    ],
                    "text": "r rnbo_bass_param"
                }
            },
            {
                "box": {
                    "id": "obj-paramnote",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        465,
                        237,
                        300,
                        20
                    ],
                    "text": "parameter bus: note 36"
                }
            },
            {
                "box": {
                    "autosave": 1,
                    "id": "obj-rnbo",
                    "inletInfo": {
                        "IOInfo": [
                            {
                                "type": "event",
                                "index": 1,
                                "tag": "in1",
                                "comment": "trigger"
                            }
                        ]
                    },
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outletInfo": {
                        "IOInfo": [
                            {
                                "type": "signal",
                                "index": 1,
                                "tag": "out1",
                                "comment": "left"
                            },
                            {
                                "type": "signal",
                                "index": 2,
                                "tag": "out2",
                                "comment": "right"
                            }
                        ]
                    },
                    "outlettype": [
                        "signal",
                        "signal",
                        "list",
                        ""
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "rnbo",
                        "rect": [
                            268,
                            150,
                            900,
                            600
                        ],
                        "default_fontname": "Lato",
                        "title": "mlr-bass",
                        "boxes": [
                            {
                                "box": {
                                    "id": "rnbo-in",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        245,
                                        40,
                                        40,
                                        23
                                    ],
                                    "rnbo_classname": "in",
                                    "rnbo_extra_attributes": {
                                        "meta": "",
                                        "comment": "trigger"
                                    },
                                    "rnbo_serial": 1,
                                    "rnbo_uniqueid": "in_rnbo-in",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "index": {
                                                "attrOrProp": 2,
                                                "digest": "inlet number",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "mandatory": 1
                                            },
                                            "comment": {
                                                "attrOrProp": 2,
                                                "digest": "mouse over comment",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol"
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 3
                                            }
                                        },
                                        "inputs": [],
                                        "outputs": [
                                            {
                                                "name": "out1",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "value from inlet with index 1",
                                                "displayName": "trigger",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "in",
                                        "aliasOf": "in",
                                        "classname": "in",
                                        "operator": 0,
                                        "versionId": 475235762,
                                        "changesPatcherIO": 1
                                    },
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-voice",
                                    "maxclass": "newobj",
                                    "numinlets": 13,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        245,
                                        290,
                                        185,
                                        23
                                    ],
                                    "rnbo_classname": "p",
                                    "rnbo_extra_attributes": {
                                        "polyphony": -1,
                                        "receivemode": "local",
                                        "voicecontrol": "midi",
                                        "notecontroller": 0,
                                        "exposevoiceparams": 0,
                                        "args": [],
                                        "uidstyle": "auto"
                                    },
                                    "rnbo_serial": 1,
                                    "rnbo_uniqueid": "p_rnbo-voice",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "target": {
                                                "attrOrProp": 1,
                                                "digest": "target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 0,
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0"
                                            },
                                            "mute": {
                                                "attrOrProp": 1,
                                                "digest": "mute",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number"
                                            },
                                            "__probingout1": {
                                                "attrOrProp": 1,
                                                "digest": "__probingout1",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "signal"
                                            },
                                            "out1": {
                                                "attrOrProp": 1,
                                                "digest": "out1",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "signal"
                                            },
                                            "out2": {
                                                "attrOrProp": 1,
                                                "digest": "out2",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "signal"
                                            },
                                            "polyphony": {
                                                "attrOrProp": 2,
                                                "digest": "Polyphony of the subpatcher.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1"
                                            },
                                            "exposevoiceparams": {
                                                "attrOrProp": 2,
                                                "digest": "Expose per voice versions of the contained parameters (only valid in polyphonic subpatchers).",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "title": {
                                                "attrOrProp": 2,
                                                "digest": "Title of the subpatcher",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "doNotShowInMaxInspector": 1
                                            },
                                            "file": {
                                                "attrOrProp": 2,
                                                "digest": "rnbo file to load",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "doNotShowInMaxInspector": 1
                                            },
                                            "voicecontrol": {
                                                "attrOrProp": 2,
                                                "digest": "Chooses the way that polyphonic voices are controlled. 'simple' (or 'midi') will automatically allocate voices for \tincoming MIDI notes. Setting it to 'user' (or 'none') will switch off MIDI \tvoice allocation and start with all voices unmuted.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "enum": [
                                                    "simple",
                                                    "user"
                                                ],
                                                "type": "enum",
                                                "defaultValue": "simple"
                                            },
                                            "notecontroller": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED. Use voicecontrol instead.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "doNotShowInMaxInspector": 1
                                            },
                                            "receivemode": {
                                                "attrOrProp": 2,
                                                "digest": "Do receive~ objects get the signal from a send~ inside the patcher directly (without latency), or compensated (with latency, aligned with all other voices).",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "enum": [
                                                    "local",
                                                    "compensated"
                                                ],
                                                "type": "enum",
                                                "defaultValue": "local"
                                            },
                                            "args": {
                                                "attrOrProp": 2,
                                                "digest": "Replacement args for the subpatcher, everything named #1, #2 etc. will be replaced with the according argument.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "doNotShowInMaxInspector": 1
                                            },
                                            "uidstyle": {
                                                "attrOrProp": 2,
                                                "digest": "Behavior of #0 unique ID. auto (default) means abstractions get a local UID, local: start a new local UID, parent: use the one from the parent patcher",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "enum": [
                                                    "auto",
                                                    "local",
                                                    "parent",
                                                    "global"
                                                ],
                                                "type": "enum",
                                                "defaultValue": "auto"
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "in1",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in1",
                                                "displayName": "trigger",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in2",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in2",
                                                "displayName": "base frequency",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in3",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in3",
                                                "displayName": "pitch sweep amount",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in4",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in4",
                                                "displayName": "pitch sweep decay",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in5",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in5",
                                                "displayName": "amplitude decay",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in6",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in6",
                                                "displayName": "FM index",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in7",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in7",
                                                "displayName": "FM ratio",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in8",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in8",
                                                "displayName": "resonator mix",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in9",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in9",
                                                "displayName": "resonator frequency",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in10",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in10",
                                                "displayName": "resonator Q",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in11",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in11",
                                                "displayName": "click level",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in12",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in12",
                                                "displayName": "brightness",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in13",
                                                "type": [
                                                    "bang",
                                                    "number",
                                                    "list"
                                                ],
                                                "digest": "in13",
                                                "displayName": "output level",
                                                "hot": 1,
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "out1",
                                                "type": "signal",
                                                "digest": "out1",
                                                "displayName": "left",
                                                "docked": 0
                                            },
                                            {
                                                "name": "out2",
                                                "type": "signal",
                                                "digest": "out2",
                                                "displayName": "right",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "patcher",
                                        "aliasOf": "rnbo",
                                        "classname": "p",
                                        "operator": 0,
                                        "versionId": 426236520,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "p @file rnbo_bass_voice"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-out1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        245,
                                        345,
                                        48,
                                        23
                                    ],
                                    "rnbo_classname": "out~",
                                    "rnbo_extra_attributes": {
                                        "meta": "",
                                        "comment": "left"
                                    },
                                    "rnbo_serial": 1,
                                    "rnbo_uniqueid": "out~_rnbo-out1",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "in1": {
                                                "attrOrProp": 1,
                                                "digest": "signal sent to outlet with index 1",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 0,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "signal"
                                            },
                                            "index": {
                                                "attrOrProp": 2,
                                                "digest": "outlet number",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "mandatory": 1
                                            },
                                            "comment": {
                                                "attrOrProp": 2,
                                                "digest": "mouse over comment",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol"
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 3
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "in1",
                                                "type": "signal",
                                                "digest": "signal sent to outlet with index 1",
                                                "displayName": "left",
                                                "hot": 1,
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [],
                                        "helpname": "out~",
                                        "aliasOf": "out~",
                                        "classname": "out~",
                                        "operator": 0,
                                        "versionId": 1989326771,
                                        "changesPatcherIO": 1
                                    },
                                    "text": "out~ 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-out2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        380,
                                        345,
                                        48,
                                        23
                                    ],
                                    "rnbo_classname": "out~",
                                    "rnbo_extra_attributes": {
                                        "meta": "",
                                        "comment": "right"
                                    },
                                    "rnbo_serial": 2,
                                    "rnbo_uniqueid": "out~_rnbo-out2",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "in1": {
                                                "attrOrProp": 1,
                                                "digest": "signal sent to outlet with index 2",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 0,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "signal"
                                            },
                                            "index": {
                                                "attrOrProp": 2,
                                                "digest": "outlet number",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "mandatory": 1
                                            },
                                            "comment": {
                                                "attrOrProp": 2,
                                                "digest": "mouse over comment",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol"
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 3
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "in1",
                                                "type": "signal",
                                                "digest": "signal sent to outlet with index 2",
                                                "displayName": "right",
                                                "hot": 1,
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [],
                                        "helpname": "out~",
                                        "aliasOf": "out~",
                                        "classname": "out~",
                                        "operator": 0,
                                        "versionId": 1989326771,
                                        "changesPatcherIO": 1
                                    },
                                    "text": "out~ 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-comment",
                                    "linenote": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        245,
                                        255,
                                        300,
                                        35
                                    ],
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_bass_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-note",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        25,
                                        80,
                                        259,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 13,
                                    "rnbo_uniqueid": "note",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param note 36 @min 12 @max 96 @unit MIDI",
                                    "varname": "note"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-fmRatio",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        25,
                                        108,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 2,
                                    "rnbo_uniqueid": "fmRatio",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param fmRatio 1 @min 0.25 @max 8",
                                    "varname": "fmRatio"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-fmDecayMs",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        25,
                                        136,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 3,
                                    "rnbo_uniqueid": "fmDecayMs",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param fmDecayMs 220 @min 5 @max 6000 @unit ms",
                                    "varname": "fmDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-decayMs",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        25,
                                        164,
                                        307,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 15,
                                    "rnbo_uniqueid": "decayMs",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param decayMs 550 @min 10 @max 12000 @unit ms",
                                    "varname": "decayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-fmIndex",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        25,
                                        192,
                                        202,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 14,
                                    "rnbo_uniqueid": "fmIndex",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param fmIndex 1.2 @min 0 @max 12",
                                    "varname": "fmIndex"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-feedback",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        25,
                                        220,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 6,
                                    "rnbo_uniqueid": "feedback",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param feedback 0.15 @min 0 @max 0.95",
                                    "varname": "feedback"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-attackMs",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        470,
                                        80,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 7,
                                    "rnbo_uniqueid": "attackMs",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param attackMs 2 @min 0.2 @max 1000 @unit ms",
                                    "varname": "attackMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bendSemitones",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        470,
                                        108,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 8,
                                    "rnbo_uniqueid": "bendSemitones",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param bendSemitones 0 @min -24 @max 24 @unit st",
                                    "varname": "bendSemitones"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-drive",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        470,
                                        136,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 9,
                                    "rnbo_uniqueid": "drive",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param drive 1.4 @min 0.25 @max 8",
                                    "varname": "drive"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-subLevel",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        470,
                                        164,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 10,
                                    "rnbo_uniqueid": "subLevel",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param subLevel 0.35 @min 0 @max 1",
                                    "varname": "subLevel"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-brightness",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        470,
                                        192,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 11,
                                    "rnbo_uniqueid": "brightness",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param brightness 0.6 @min 0 @max 1",
                                    "varname": "brightness"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-level",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        470,
                                        220,
                                        430,
                                        23
                                    ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "fromnormalized": "",
                                        "order": "0",
                                        "enum": "",
                                        "steps": 0,
                                        "sendinit": 1,
                                        "ctlin": -1,
                                        "displayname": "",
                                        "exponent": 1,
                                        "meta": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 12,
                                    "rnbo_uniqueid": "level",
                                    "rnboinfo": {
                                        "needsInstanceInfo": 1,
                                        "argnames": {
                                            "value": {
                                                "attrOrProp": 2,
                                                "digest": "Set initial value",
                                                "defaultarg": 2,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Initial Value",
                                                "displayorder": 3
                                            },
                                            "normalizedvalue": {
                                                "attrOrProp": 1,
                                                "digest": "Set value normalized. ",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "inlet": 1,
                                                "type": "number"
                                            },
                                            "reset": {
                                                "attrOrProp": 1,
                                                "digest": "Reset param to initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 1,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bang"
                                            },
                                            "normalized": {
                                                "attrOrProp": 1,
                                                "digest": "Normalized parameter value.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "outlet": 1,
                                                "type": "number"
                                            },
                                            "name": {
                                                "attrOrProp": 2,
                                                "digest": "Name of the parameter",
                                                "defaultarg": 1,
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Parameter Name",
                                                "mandatory": 1
                                            },
                                            "enum": {
                                                "attrOrProp": 2,
                                                "digest": "Use an enumerated output",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "list",
                                                "label": "Enum Values",
                                                "displayorder": 6
                                            },
                                            "minimum": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "min"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "min": {
                                                "attrOrProp": 2,
                                                "digest": "Minimum value",
                                                "isalias": 1,
                                                "aliasOf": "minimum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Minimum",
                                                "displayorder": 1
                                            },
                                            "maximum": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 0,
                                                "aliases": [
                                                    "max"
                                                ],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "max": {
                                                "attrOrProp": 2,
                                                "digest": "Maximum value",
                                                "isalias": 1,
                                                "aliasOf": "maximum",
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Maximum",
                                                "displayorder": 2
                                            },
                                            "exponent": {
                                                "attrOrProp": 2,
                                                "digest": "Scale values exponentially",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "1",
                                                "label": "Exponent",
                                                "displayorder": 7
                                            },
                                            "steps": {
                                                "attrOrProp": 2,
                                                "digest": "Divide the output into a number of discrete steps",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "0",
                                                "label": "Steps",
                                                "displayorder": 8
                                            },
                                            "displayName": {
                                                "attrOrProp": 2,
                                                "digest": "DEPRECATED: Use the lower case 'displayname' instead",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "Display Name"
                                            },
                                            "displayname": {
                                                "attrOrProp": 2,
                                                "digest": "A more readable name for the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Display Name",
                                                "displayorder": 14
                                            },
                                            "unit": {
                                                "attrOrProp": 2,
                                                "digest": "A symbol to describe the unit of the parameter in an external RNBO target",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Unit",
                                                "displayorder": 15
                                            },
                                            "tonormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a real parameter value to its normalized form",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "To Normalized Expression",
                                                "displayorder": 10
                                            },
                                            "fromnormalized": {
                                                "attrOrProp": 2,
                                                "digest": "Converts a normalized parameter into its actual parameter value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "label": "From Normalized Expression",
                                                "displayorder": 9
                                            },
                                            "order": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which initial parameter values will be sent out on patcher load. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "0",
                                                "label": "Restore Order",
                                                "displayorder": 12
                                            },
                                            "displayorder": {
                                                "attrOrProp": 2,
                                                "digest": "Order in which parameters will show up in a list of all parameters. The order can be numeric or symbolic ('first' and 'last')",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "-",
                                                "label": "Display Order",
                                                "displayorder": 13
                                            },
                                            "sendinit": {
                                                "attrOrProp": 2,
                                                "digest": "Send initial value",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Send Init",
                                                "displayorder": 4
                                            },
                                            "ctlin": {
                                                "attrOrProp": 2,
                                                "digest": "MIDI controller number to control this parameter.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "number",
                                                "defaultValue": "-1",
                                                "label": "MIDI Controller Number.",
                                                "displayorder": 16
                                            },
                                            "meta": {
                                                "attrOrProp": 2,
                                                "digest": "A JSON formatted string containing metadata for use by the exported code",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "symbol",
                                                "defaultValue": "",
                                                "label": "Metadata",
                                                "displayorder": 17
                                            },
                                            "nopreset": {
                                                "attrOrProp": 2,
                                                "digest": "Do not add this value to the preset [DEPRECATED - USE @preset 0 instead].",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 1,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "false"
                                            },
                                            "preset": {
                                                "attrOrProp": 2,
                                                "digest": "Add this value to the preset.",
                                                "isalias": 0,
                                                "aliases": [],
                                                "settable": 1,
                                                "attachable": 0,
                                                "isparam": 0,
                                                "deprecated": 0,
                                                "touched": 0,
                                                "type": "bool",
                                                "defaultValue": "true",
                                                "label": "Include In Preset",
                                                "displayorder": 11
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalizedvalue",
                                                "type": "number",
                                                "digest": "Set value normalized. ",
                                                "docked": 0
                                            }
                                        ],
                                        "outputs": [
                                            {
                                                "name": "value",
                                                "type": "number",
                                                "digest": "Parameter value",
                                                "defaultarg": 2,
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "normalized",
                                                "type": "number",
                                                "digest": "Normalized parameter value.",
                                                "docked": 0
                                            }
                                        ],
                                        "helpname": "param",
                                        "aliasOf": "param",
                                        "classname": "param",
                                        "operator": 0,
                                        "versionId": -1093178486,
                                        "changesPatcherIO": 0
                                    },
                                    "text": "param level 0.45 @min 0 @max 1",
                                    "varname": "level"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        0
                                    ],
                                    "source": [
                                        "rnbo-in",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        2
                                    ],
                                    "source": [
                                        "rnbo-param-decayMs",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        1
                                    ],
                                    "source": [
                                        "rnbo-param-note",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        7
                                    ],
                                    "source": [
                                        "rnbo-param-subLevel",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        8
                                    ],
                                    "source": [
                                        "rnbo-param-brightness",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        3
                                    ],
                                    "source": [
                                        "rnbo-param-fmIndex",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        6
                                    ],
                                    "source": [
                                        "rnbo-param-feedback",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        12
                                    ],
                                    "source": [
                                        "rnbo-param-level",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        4
                                    ],
                                    "source": [
                                        "rnbo-param-fmRatio",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        5
                                    ],
                                    "source": [
                                        "rnbo-param-fmDecayMs",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        10
                                    ],
                                    "source": [
                                        "rnbo-param-bendSemitones",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        9
                                    ],
                                    "source": [
                                        "rnbo-param-attackMs",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-voice",
                                        11
                                    ],
                                    "source": [
                                        "rnbo-param-drive",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-out1",
                                        0
                                    ],
                                    "source": [
                                        "rnbo-voice",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "rnbo-out2",
                                        0
                                    ],
                                    "source": [
                                        "rnbo-voice",
                                        1
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        315.5,
                        278,
                        245,
                        22
                    ],
                    "rnboattrcache": {
                        "fmDecayMs": {
                            "label": "fmDecayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 220
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.4
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.45
                        },
                        "fmIndex": {
                            "label": "fmIndex",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.2
                        },
                        "feedback": {
                            "label": "feedback",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.15
                        },
                        "bendSemitones": {
                            "label": "bendSemitones",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0
                        },
                        "brightness": {
                            "label": "brightness",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.6
                        },
                        "fmRatio": {
                            "label": "fmRatio",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1
                        },
                        "subLevel": {
                            "label": "subLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.35
                        },
                        "decayMs": {
                            "label": "decayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 550
                        },
                        "attackMs": {
                            "label": "attackMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 2
                        },
                        "note": {
                            "label": "note",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 36
                        }
                    },
                    "rnboversion": "1.4.5",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "bass_rnbo",
                            "parameter_modmode": 0,
                            "parameter_shortname": "bass_rnbo",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "optimization": "O1",
                        "parameter_enable": 1,
                        "uuid": "037c1434-de39-683f-ad8e-fe46e1f7d119"
                    },
                    "text": "rnbo~ @title mlr-bass @dumpoutlet 1",
                    "varname": "bass_rnbo"
                }
            },
            {
                "box": {
                    "id": "obj-outputgain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        300,
                        360,
                        55,
                        22
                    ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "id": "obj-outputgain2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        395,
                        360,
                        55,
                        22
                    ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "id": "obj-sendleft",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        180,
                        420,
                        115,
                        22
                    ],
                    "text": "s~ rnbo_bass_left"
                }
            },
            {
                "box": {
                    "id": "obj-sendright",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        470,
                        420,
                        120,
                        22
                    ],
                    "text": "s~ rnbo_bass_right"
                }
            },
            {
                "box": {
                    "id": "obj-meter1",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        300,
                        410,
                        16,
                        80
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        795,
                        525,
                        18,
                        65
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-meter2",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        430,
                        410,
                        16,
                        80
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        824,
                        525,
                        18,
                        65
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-outputnote",
                    "linenote": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500,
                        360,
                        300,
                        33
                    ],
                    "text": "Audio buses stay active; combined lab selects stereo or eight external outputs."
                }
            },
            {
                "box": {
                    "id": "choose-obj-deep",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        700,
                        525,
                        100,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        380,
                        125,
                        115,
                        30
                    ],
                    "text": "Round"
                }
            },
            {
                "box": {
                    "id": "choose-obj-knock",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        700,
                        555,
                        100,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        510,
                        125,
                        115,
                        30
                    ],
                    "text": "Rubber"
                }
            },
            {
                "box": {
                    "id": "choose-obj-hollow",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        700,
                        585,
                        100,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        640,
                        125,
                        115,
                        30
                    ],
                    "text": "Wire"
                }
            },
            {
                "box": {
                    "id": "label-note",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        900,
                        30,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        220,
                        245,
                        20
                    ],
                    "text": "Note · MIDI"
                }
            },
            {
                "box": {
                    "id": "control-note",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        900,
                        52,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        243,
                        245,
                        22
                    ],
                    "varname": "bass_sound_note",
                    "minimum": 12,
                    "maximum": 96
                }
            },
            {
                "box": {
                    "id": "label-fmRatio",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        900,
                        100,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        288,
                        245,
                        20
                    ],
                    "text": "FM ratio"
                }
            },
            {
                "box": {
                    "id": "control-fmRatio",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        900,
                        122,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        311,
                        245,
                        22
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "bass_sound_fmRatio"
                }
            },
            {
                "box": {
                    "id": "label-fmDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        900,
                        170,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        356,
                        245,
                        20
                    ],
                    "text": "FM decay · ms"
                }
            },
            {
                "box": {
                    "id": "control-fmDecayMs",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        900,
                        192,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        379,
                        245,
                        22
                    ],
                    "minimum": 5,
                    "maximum": 6000,
                    "varname": "bass_sound_fmDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-decayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        900,
                        240,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        288,
                        245,
                        20
                    ],
                    "text": "Decay · ms"
                }
            },
            {
                "box": {
                    "id": "control-decayMs",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        900,
                        262,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        311,
                        245,
                        22
                    ],
                    "minimum": 10,
                    "maximum": 12000,
                    "varname": "bass_sound_decayMs"
                }
            },
            {
                "box": {
                    "id": "label-fmIndex",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1160,
                        30,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        220,
                        245,
                        20
                    ],
                    "text": "FM index"
                }
            },
            {
                "box": {
                    "id": "control-fmIndex",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1160,
                        52,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        243,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 12,
                    "varname": "bass_sound_fmIndex"
                }
            },
            {
                "box": {
                    "id": "label-feedback",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1160,
                        100,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        424,
                        245,
                        20
                    ],
                    "text": "Feedback"
                }
            },
            {
                "box": {
                    "id": "control-feedback",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1160,
                        122,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        447,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 0.95,
                    "varname": "bass_sound_feedback"
                }
            },
            {
                "box": {
                    "id": "label-attackMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1160,
                        170,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        356,
                        245,
                        20
                    ],
                    "text": "Attack · ms"
                }
            },
            {
                "box": {
                    "id": "control-attackMs",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1160,
                        192,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        379,
                        245,
                        22
                    ],
                    "minimum": 0.2,
                    "maximum": 1000,
                    "varname": "bass_sound_attackMs"
                }
            },
            {
                "box": {
                    "id": "label-bendSemitones",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1160,
                        240,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        424,
                        245,
                        20
                    ],
                    "text": "Pitch bend · st"
                }
            },
            {
                "box": {
                    "id": "control-bendSemitones",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1160,
                        262,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        447,
                        245,
                        22
                    ],
                    "minimum": -24,
                    "maximum": 24,
                    "varname": "bass_sound_bendSemitones"
                }
            },
            {
                "box": {
                    "id": "label-drive",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420,
                        30,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        356,
                        245,
                        20
                    ],
                    "text": "Drive"
                }
            },
            {
                "box": {
                    "id": "control-drive",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1420,
                        52,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        379,
                        245,
                        22
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "bass_sound_drive"
                }
            },
            {
                "box": {
                    "id": "label-subLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420,
                        100,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        220,
                        245,
                        20
                    ],
                    "text": "Sub level"
                }
            },
            {
                "box": {
                    "id": "control-subLevel",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1420,
                        122,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        243,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bass_sound_subLevel"
                }
            },
            {
                "box": {
                    "id": "label-brightness",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420,
                        170,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        288,
                        245,
                        20
                    ],
                    "text": "Brightness"
                }
            },
            {
                "box": {
                    "id": "control-brightness",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1420,
                        192,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        311,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bass_sound_brightness"
                }
            },
            {
                "box": {
                    "id": "label-level",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420,
                        240,
                        240,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        424,
                        245,
                        20
                    ],
                    "text": "Level"
                }
            },
            {
                "box": {
                    "id": "control-level",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1420,
                        262,
                        240,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        447,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bass_sound_level"
                }
            },
            {
                "box": {
                    "id": "repeat",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30,
                        280,
                        24,
                        24
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        170,
                        130,
                        24,
                        24
                    ]
                }
            },
            {
                "box": {
                    "id": "repeat-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        60,
                        280,
                        150,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203,
                        131,
                        150,
                        20
                    ],
                    "text": "Repeat (750 ms)"
                }
            },
            {
                "box": {
                    "id": "repeat-clock",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        30,
                        320,
                        95,
                        22
                    ],
                    "text": "metro 750"
                }
            },
            {
                "box": {
                    "id": "repeat-receive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        350,
                        160,
                        22
                    ],
                    "text": "r rnbo_bass_repeat"
                }
            },
            {
                "box": {
                    "id": "audio-switch",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        420,
                        45,
                        45
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        535,
                        45,
                        45
                    ]
                }
            },
            {
                "box": {
                    "id": "audio-label",
                    "linenote": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        80,
                        480,
                        327,
                        33
                    ],
                    "presentation": 1,
                    "presentation_linenote": 2,
                    "presentation_rect": [
                        82,
                        532,
                        327,
                        33
                    ],
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_bass_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "bass-manual",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        20,
                        760,
                        210,
                        22
                    ],
                    "text": "t l l"
                }
            },
            {
                "box": {
                    "id": "bass-manual-echo",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        800,
                        210,
                        22
                    ],
                    "text": "prepend bassManual"
                }
            },
            {
                "box": {
                    "id": "bass-router",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        840,
                        210,
                        22
                    ],
                    "text": "s gridrouter"
                }
            },
            {
                "box": {
                    "id": "bass-route",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 13,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        260,
                        800,
                        210,
                        22
                    ],
                    "text": "route note decayMs fmIndex fmRatio fmDecayMs feedback subLevel brightness attackMs bendSemitones drive level"
                }
            },
            {
                "box": {
                    "id": "bass-cache",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        260,
                        850,
                        210,
                        22
                    ],
                    "text": "pak 36.0 550.0 1.2 1.0 220.0 0.15 0.35 0.6 2.0 0.0 1.4 0.45"
                }
            },
            {
                "box": {
                    "id": "bass-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        260,
                        890,
                        210,
                        22
                    ],
                    "text": "unpack f f f f f f f f f f f f"
                }
            },
            {
                "box": {
                    "id": "bass-pitch",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        260,
                        930,
                        210,
                        22
                    ],
                    "text": "prepend note"
                }
            },
            {
                "box": {
                    "id": "bass-decay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        490,
                        930,
                        210,
                        22
                    ],
                    "text": "prepend decayMs"
                }
            },
            {
                "box": {
                    "id": "bass-fm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        720,
                        930,
                        210,
                        22
                    ],
                    "text": "prepend fmIndex"
                }
            },
            {
                "box": {
                    "id": "bass-owned",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        260,
                        760,
                        210,
                        22
                    ],
                    "text": "r rnbo_bass_owned_param"
                }
            },
            {
                "box": {
                    "id": "bass-step",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        520,
                        760,
                        210,
                        22
                    ],
                    "text": "r rnbo_bass_step"
                }
            },
            {
                "box": {
                    "id": "bass-step-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        520,
                        800,
                        210,
                        22
                    ],
                    "text": "unpack f f f f f f f f f f f f"
                }
            },
            {
                "box": {
                    "id": "bass-fire",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        740,
                        850,
                        210,
                        22
                    ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "id": "bass-load",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        20,
                        890,
                        210,
                        22
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "bass-defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        930,
                        210,
                        22
                    ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "bass-sync",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        970,
                        210,
                        22
                    ],
                    "text": "bassSync"
                }
            },
            {
                "box": {
                    "id": "bass-values",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        500,
                        850,
                        48,
                        22
                    ],
                    "text": "zl reg"
                }
            },
            {
                "box": {
                    "fontsize": 17,
                    "id": "range-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        615,
                        780,
                        25
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        615,
                        780,
                        25
                    ],
                    "text": "Grid mapping ranges · all twelve bass parameters"
                }
            },
            {
                "box": {
                    "id": "range-help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        645,
                        830,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        645,
                        830,
                        20
                    ],
                    "text": "Min / Max scales grid edits. Sound controls retain the full engine limits."
                }
            },
            {
                "box": {
                    "filename": "bass_lab_ranges.js",
                    "id": "range-script",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        20,
                        1120,
                        185,
                        22
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 bass_lab_ranges.js",
                    "textfile": {
                        "filename": "bass_lab_ranges.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "bassNote-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        703,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        703,
                        245,
                        20
                    ],
                    "text": "Note · MIDI"
                }
            },
            {
                "box": {
                    "id": "bassNote-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        725,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        725,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "bassNote-min",
                    "maxclass": "flonum",
                    "maximum": 96,
                    "minimum": 12,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        65,
                        725,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65,
                        725,
                        80,
                        22
                    ],
                    "varname": "bassNote-min"
                }
            },
            {
                "box": {
                    "id": "bassNote-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1170,
                        245,
                        22
                    ],
                    "text": "prepend setrange bassNote min"
                }
            },
            {
                "box": {
                    "id": "bassNote-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        150,
                        725,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150,
                        725,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "bassNote-max",
                    "maxclass": "flonum",
                    "maximum": 96,
                    "minimum": 12,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        190,
                        725,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        190,
                        725,
                        80,
                        22
                    ],
                    "varname": "bassNote-max"
                }
            },
            {
                "box": {
                    "id": "bassNote-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        150,
                        1170,
                        245,
                        22
                    ],
                    "text": "prepend setrange bassNote max"
                }
            },
            {
                "box": {
                    "id": "bassDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        763,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        763,
                        245,
                        20
                    ],
                    "text": "Decay · ms"
                }
            },
            {
                "box": {
                    "id": "bassDecay-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        785,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        785,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "bassDecay-min",
                    "maxclass": "flonum",
                    "maximum": 12000,
                    "minimum": 10,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        65,
                        785,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65,
                        785,
                        80,
                        22
                    ],
                    "varname": "bassDecay-min"
                }
            },
            {
                "box": {
                    "id": "bassDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        305,
                        1225,
                        245,
                        22
                    ],
                    "text": "prepend setrange bassDecay min"
                }
            },
            {
                "box": {
                    "id": "bassDecay-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        150,
                        785,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150,
                        785,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "bassDecay-max",
                    "maxclass": "flonum",
                    "maximum": 12000,
                    "minimum": 10,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        190,
                        785,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        190,
                        785,
                        80,
                        22
                    ],
                    "varname": "bassDecay-max"
                }
            },
            {
                "box": {
                    "id": "bassDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        430,
                        1225,
                        245,
                        22
                    ],
                    "text": "prepend setrange bassDecay max"
                }
            },
            {
                "box": {
                    "id": "bassFM-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        305,
                        703,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        703,
                        245,
                        20
                    ],
                    "text": "FM index"
                }
            },
            {
                "box": {
                    "id": "bassFM-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        305,
                        725,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        725,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "bassFM-min",
                    "maxclass": "flonum",
                    "maximum": 12,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        345,
                        725,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        345,
                        725,
                        80,
                        22
                    ],
                    "varname": "bassFM-min"
                }
            },
            {
                "box": {
                    "id": "bassFM-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        585,
                        1280,
                        245,
                        22
                    ],
                    "text": "prepend setrange bassFM min"
                }
            },
            {
                "box": {
                    "id": "bassFM-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        430,
                        725,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430,
                        725,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "bassFM-max",
                    "maxclass": "flonum",
                    "maximum": 12,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        470,
                        725,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470,
                        725,
                        80,
                        22
                    ],
                    "varname": "bassFM-max"
                }
            },
            {
                "box": {
                    "id": "bassFM-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        710,
                        1280,
                        245,
                        22
                    ],
                    "text": "prepend setrange bassFM max"
                }
            },
            {
                "box": {
                    "id": "range-route",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 25,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        260,
                        1120,
                        780,
                        22
                    ],
                    "text": "route bassNote-min bassNote-max bassDecay-min bassDecay-max bassFM-min bassFM-max bassRatio-min bassRatio-max bassFMDecay-min bassFMDecay-max bassFeedback-min bassFeedback-max bassSub-min bassSub-max bassBrightness-min bassBrightness-max bassAttack-min bassAttack-max bassBend-min bassBend-max bassDrive-min bassDrive-max bassLevel-min bassLevel-max"
                }
            },
            {
                "box": {
                    "id": "range-status",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        25,
                        945,
                        800,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        945,
                        800,
                        20
                    ],
                    "text": "Presets store all 24 range fields. Every sound control is captured at each hit."
                }
            },
            {
                "box": {
                    "bubblesize": 14,
                    "dirty": 1,
                    "id": "range-presets",
                    "maxclass": "preset",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "preset",
                        "int",
                        "preset",
                        "int",
                        ""
                    ],
                    "patching_rect": [
                        25,
                        980,
                        245,
                        38
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        980,
                        245,
                        38
                    ],
                    "varname": "bass_grid_range_presets"
                }
            },
            {
                "box": {
                    "id": "range-preset-help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        290,
                        980,
                        550,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290,
                        980,
                        550,
                        20
                    ],
                    "text": "Shift-click a slot to store · click to recall · save this patch to keep slots."
                }
            },
            {
                "box": {
                    "id": "range-write",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        290,
                        1020,
                        55,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290,
                        1020,
                        55,
                        22
                    ],
                    "text": "write"
                }
            },
            {
                "box": {
                    "id": "range-read",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        355,
                        1020,
                        55,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        355,
                        1020,
                        55,
                        22
                    ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "id": "range-file-help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        430,
                        1020,
                        340,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430,
                        1020,
                        340,
                        20
                    ],
                    "text": "Export / import range presets"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassRatio",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        1330,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend fmRatio"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassFMDecay",
                    "maxclass": "newobj",
                    "patching_rect": [
                        260,
                        1370,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend fmDecayMs"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassFeedback",
                    "maxclass": "newobj",
                    "patching_rect": [
                        490,
                        1370,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend feedback"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassSub",
                    "maxclass": "newobj",
                    "patching_rect": [
                        720,
                        1370,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend subLevel"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassBrightness",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        1370,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend brightness"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassAttack",
                    "maxclass": "newobj",
                    "patching_rect": [
                        260,
                        1410,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend attackMs"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassBend",
                    "maxclass": "newobj",
                    "patching_rect": [
                        490,
                        1410,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend bendSemitones"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassDrive",
                    "maxclass": "newobj",
                    "patching_rect": [
                        720,
                        1410,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend drive"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassLevel",
                    "maxclass": "newobj",
                    "patching_rect": [
                        950,
                        1410,
                        210,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend level"
                }
            },
            {
                "box": {
                    "id": "bassRatio-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        763,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        763,
                        245,
                        20
                    ],
                    "text": "FM ratio"
                }
            },
            {
                "box": {
                    "id": "bassRatio-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        785,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        785,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassRatio-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        345,
                        785,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        345,
                        785,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "bassRatio-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassRatio-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        115,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassRatio min"
                }
            },
            {
                "box": {
                    "id": "bassRatio-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        430,
                        785,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430,
                        785,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassRatio-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        470,
                        785,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470,
                        785,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "bassRatio-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassRatio-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        115,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassRatio max"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        823,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        823,
                        245,
                        20
                    ],
                    "text": "FM decay · ms"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        845,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        845,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        345,
                        845,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        345,
                        845,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 5,
                    "maximum": 6000,
                    "varname": "bassFMDecay-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        145,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassFMDecay min"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        430,
                        845,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430,
                        845,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        470,
                        845,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470,
                        845,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 5,
                    "maximum": 6000,
                    "varname": "bassFMDecay-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        145,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassFMDecay max"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        883,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        883,
                        245,
                        20
                    ],
                    "text": "Feedback"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        905,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        905,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        345,
                        905,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        345,
                        905,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 0.95,
                    "varname": "bassFeedback-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassFeedback-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        175,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassFeedback min"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        430,
                        905,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430,
                        905,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        470,
                        905,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470,
                        905,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 0.95,
                    "varname": "bassFeedback-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassFeedback-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        175,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassFeedback max"
                }
            },
            {
                "box": {
                    "id": "bassSub-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        703,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        703,
                        245,
                        20
                    ],
                    "text": "Sub level"
                }
            },
            {
                "box": {
                    "id": "bassSub-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        725,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        725,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassSub-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        625,
                        725,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        625,
                        725,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bassSub-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassSub-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        205,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassSub min"
                }
            },
            {
                "box": {
                    "id": "bassSub-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        710,
                        725,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        710,
                        725,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassSub-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        750,
                        725,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        750,
                        725,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bassSub-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassSub-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        205,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassSub max"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        763,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        763,
                        245,
                        20
                    ],
                    "text": "Brightness"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        785,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        785,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        625,
                        785,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        625,
                        785,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bassBrightness-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassBrightness-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        235,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassBrightness min"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        710,
                        785,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        710,
                        785,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        750,
                        785,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        750,
                        785,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bassBrightness-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassBrightness-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        235,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassBrightness max"
                }
            },
            {
                "box": {
                    "id": "bassAttack-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        25,
                        823,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        823,
                        245,
                        20
                    ],
                    "text": "Attack · ms"
                }
            },
            {
                "box": {
                    "id": "bassAttack-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        25,
                        845,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        845,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassAttack-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        65,
                        845,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65,
                        845,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.2,
                    "maximum": 1000,
                    "varname": "bassAttack-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassAttack-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        265,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassAttack min"
                }
            },
            {
                "box": {
                    "id": "bassAttack-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        150,
                        845,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150,
                        845,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassAttack-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        190,
                        845,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        190,
                        845,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.2,
                    "maximum": 1000,
                    "varname": "bassAttack-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassAttack-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        265,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassAttack max"
                }
            },
            {
                "box": {
                    "id": "bassBend-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        25,
                        883,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        883,
                        245,
                        20
                    ],
                    "text": "Pitch bend · st"
                }
            },
            {
                "box": {
                    "id": "bassBend-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        25,
                        905,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        905,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassBend-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        65,
                        905,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65,
                        905,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": -24,
                    "maximum": 24,
                    "varname": "bassBend-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassBend-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        295,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassBend min"
                }
            },
            {
                "box": {
                    "id": "bassBend-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        150,
                        905,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150,
                        905,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassBend-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        190,
                        905,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        190,
                        905,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": -24,
                    "maximum": 24,
                    "varname": "bassBend-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassBend-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        295,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassBend max"
                }
            },
            {
                "box": {
                    "id": "bassDrive-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        823,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        823,
                        245,
                        20
                    ],
                    "text": "Drive"
                }
            },
            {
                "box": {
                    "id": "bassDrive-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        845,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        845,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassDrive-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        625,
                        845,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        625,
                        845,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "bassDrive-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassDrive-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        325,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassDrive min"
                }
            },
            {
                "box": {
                    "id": "bassDrive-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        710,
                        845,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        710,
                        845,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassDrive-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        750,
                        845,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        750,
                        845,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "bassDrive-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassDrive-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        325,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassDrive max"
                }
            },
            {
                "box": {
                    "id": "bassLevel-range-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        883,
                        245,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        883,
                        245,
                        20
                    ],
                    "text": "Level"
                }
            },
            {
                "box": {
                    "id": "bassLevel-min-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        905,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        905,
                        40,
                        20
                    ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "id": "bassLevel-min",
                    "maxclass": "flonum",
                    "patching_rect": [
                        625,
                        905,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        625,
                        905,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bassLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassLevel-min-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        355,
                        1520,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassLevel min"
                }
            },
            {
                "box": {
                    "id": "bassLevel-max-label",
                    "maxclass": "comment",
                    "patching_rect": [
                        710,
                        905,
                        40,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        710,
                        905,
                        40,
                        20
                    ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "id": "bassLevel-max",
                    "maxclass": "flonum",
                    "patching_rect": [
                        750,
                        905,
                        80,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        750,
                        905,
                        80,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "bassLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "bassLevel-max-pre",
                    "maxclass": "newobj",
                    "patching_rect": [
                        355,
                        1555,
                        250,
                        22
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "text": "prepend setrange bassLevel max"
                }
            },
            {
                "box": {
                    "id": "range-page-0",
                    "maxclass": "comment",
                    "patching_rect": [
                        25,
                        673,
                        250,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25,
                        673,
                        250,
                        22
                    ],
                    "fontsize": 15,
                    "text": "Pitch / shape"
                }
            },
            {
                "box": {
                    "id": "range-page-1",
                    "maxclass": "comment",
                    "patching_rect": [
                        305,
                        673,
                        250,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305,
                        673,
                        250,
                        22
                    ],
                    "fontsize": 15,
                    "text": "FM"
                }
            },
            {
                "box": {
                    "id": "range-page-2",
                    "maxclass": "comment",
                    "patching_rect": [
                        585,
                        673,
                        250,
                        22
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585,
                        673,
                        250,
                        22
                    ],
                    "fontsize": 15,
                    "text": "Mix / output"
                }
            },
            {
                "box": {
                    "id": "control-note-pre",
                    "maxclass": "newobj",
                    "text": "prepend note",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1700,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-note-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1730,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-decayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend decayMs",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        265,
                        1700,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-decayMs-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        265,
                        1730,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-fmIndex-pre",
                    "maxclass": "newobj",
                    "text": "prepend fmIndex",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        505,
                        1700,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-fmIndex-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        505,
                        1730,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-fmRatio-pre",
                    "maxclass": "newobj",
                    "text": "prepend fmRatio",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        745,
                        1700,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-fmRatio-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        745,
                        1730,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-fmDecayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend fmDecayMs",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1770,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-fmDecayMs-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1800,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-feedback-pre",
                    "maxclass": "newobj",
                    "text": "prepend feedback",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        265,
                        1770,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-feedback-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        265,
                        1800,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-subLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend subLevel",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        505,
                        1770,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-subLevel-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        505,
                        1800,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-brightness-pre",
                    "maxclass": "newobj",
                    "text": "prepend brightness",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        745,
                        1770,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-brightness-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        745,
                        1800,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-attackMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend attackMs",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1840,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-attackMs-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        25,
                        1870,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-bendSemitones-pre",
                    "maxclass": "newobj",
                    "text": "prepend bendSemitones",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        265,
                        1840,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-bendSemitones-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        265,
                        1870,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-drive-pre",
                    "maxclass": "newobj",
                    "text": "prepend drive",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        505,
                        1840,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-drive-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        505,
                        1870,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-level-pre",
                    "maxclass": "newobj",
                    "text": "prepend level",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        745,
                        1840,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "control-level-set",
                    "maxclass": "newobj",
                    "text": "prepend set",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        745,
                        1870,
                        210,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bass-ui-unpack",
                    "maxclass": "newobj",
                    "text": "unpack f f f f f f f f f f f f",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        25,
                        1680,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "route-reserve",
                    "maxclass": "newobj",
                    "text": "r~ mlr_synth_es9_active",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        1940,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "route-stereo",
                    "maxclass": "newobj",
                    "text": "!-~ 1.",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        230,
                        1940,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "route-smooth",
                    "maxclass": "newobj",
                    "text": "rampsmooth~ 960 960",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        440,
                        1940,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "route-left",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        650,
                        1940,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "route-right",
                    "maxclass": "newobj",
                    "text": "*~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        650,
                        1980,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-bridge",
                    "maxclass": "newobj",
                    "text": "dpt_bass_midi",
                    "patching_rect": [
                        20,
                        5428,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-enabled",
                    "maxclass": "newobj",
                    "text": "r dpt_enabled",
                    "patching_rect": [
                        20,
                        5454,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-local",
                    "maxclass": "newobj",
                    "text": "!- 1",
                    "patching_rect": [
                        20,
                        5480,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-local-signal",
                    "maxclass": "newobj",
                    "text": "sig~ 1",
                    "patching_rect": [
                        20,
                        5506,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-local-smooth",
                    "maxclass": "newobj",
                    "text": "rampsmooth~ 240 240",
                    "patching_rect": [
                        20,
                        5532,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-mute-left",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        20,
                        5558,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-mute-right",
                    "maxclass": "newobj",
                    "text": "*~",
                    "patching_rect": [
                        20,
                        5584,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-sync-values",
                    "maxclass": "newobj",
                    "text": "zl reg",
                    "patching_rect": [
                        20,
                        5610,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-sync-enabled",
                    "maxclass": "newobj",
                    "text": "sel 1",
                    "patching_rect": [
                        20,
                        5636,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-sync-receive",
                    "maxclass": "newobj",
                    "text": "r dpt_sync",
                    "patching_rect": [
                        20,
                        5662,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-sync-gate",
                    "maxclass": "newobj",
                    "text": "gate 1 0",
                    "patching_rect": [
                        20,
                        5688,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "dpt-sync-defer",
                    "maxclass": "newobj",
                    "text": "deferlow",
                    "patching_rect": [
                        20,
                        5714,
                        300,
                        22
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-unpack",
                        0
                    ],
                    "source": [
                        "obj-trackreceive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-selectpress",
                        0
                    ],
                    "source": [
                        "obj-unpack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-trigger",
                        0
                    ],
                    "source": [
                        "obj-selectpress",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-owned",
                        0
                    ],
                    "destination": [
                        "bass-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step",
                        0
                    ],
                    "destination": [
                        "bass-step-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        0
                    ],
                    "destination": [
                        "bass-cache",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        1
                    ],
                    "destination": [
                        "bass-cache",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        2
                    ],
                    "destination": [
                        "bass-cache",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        3
                    ],
                    "destination": [
                        "bass-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        4
                    ],
                    "destination": [
                        "bass-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        5
                    ],
                    "destination": [
                        "bass-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        6
                    ],
                    "destination": [
                        "bass-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        7
                    ],
                    "destination": [
                        "bass-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        8
                    ],
                    "destination": [
                        "bass-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        9
                    ],
                    "destination": [
                        "bass-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        10
                    ],
                    "destination": [
                        "bass-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-step-unpack",
                        11
                    ],
                    "destination": [
                        "bass-cache",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-deep",
                        0
                    ],
                    "source": [
                        "choose-obj-deep",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-hollow",
                        0
                    ],
                    "source": [
                        "choose-obj-hollow",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-knock",
                        0
                    ],
                    "source": [
                        "choose-obj-knock",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-values",
                        1
                    ],
                    "source": [
                        "bass-cache",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-rnbo",
                        0
                    ],
                    "source": [
                        "bass-decay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-sync",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "bass-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "bass-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-values",
                        0
                    ],
                    "source": [
                        "bass-fire",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-rnbo",
                        0
                    ],
                    "source": [
                        "bass-fire",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-rnbo",
                        0
                    ],
                    "source": [
                        "bass-fm",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-cache",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "bass-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-defer",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "bass-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-manual-echo",
                        0
                    ],
                    "source": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-route",
                        0
                    ],
                    "source": [
                        "bass-manual",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-router",
                        0
                    ],
                    "source": [
                        "bass-manual-echo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-rnbo",
                        0
                    ],
                    "source": [
                        "bass-pitch",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-cache",
                        2
                    ],
                    "source": [
                        "bass-route",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-cache",
                        1
                    ],
                    "source": [
                        "bass-route",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-cache",
                        0
                    ],
                    "source": [
                        "bass-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-router",
                        0
                    ],
                    "source": [
                        "bass-sync",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-decay",
                        0
                    ],
                    "source": [
                        "bass-unpack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-fm",
                        0
                    ],
                    "source": [
                        "bass-unpack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-pitch",
                        0
                    ],
                    "source": [
                        "bass-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-unpack",
                        0
                    ],
                    "source": [
                        "bass-values",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassDecay-max-pre",
                        0
                    ],
                    "source": [
                        "bassDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "source": [
                        "bassDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassDecay-min-pre",
                        0
                    ],
                    "source": [
                        "bassDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "source": [
                        "bassDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassFM-max-pre",
                        0
                    ],
                    "source": [
                        "bassFM-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "source": [
                        "bassFM-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassFM-min-pre",
                        0
                    ],
                    "source": [
                        "bassFM-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "source": [
                        "bassFM-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassNote-max-pre",
                        0
                    ],
                    "source": [
                        "bassNote-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "source": [
                        "bassNote-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassNote-min-pre",
                        0
                    ],
                    "source": [
                        "bassNote-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-script",
                        0
                    ],
                    "source": [
                        "bassNote-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-manual",
                        0
                    ],
                    "source": [
                        "obj-deep",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-trigger",
                        0
                    ],
                    "source": [
                        "obj-globaltrigger",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-manual",
                        0
                    ],
                    "source": [
                        "obj-hollow",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-manual",
                        0
                    ],
                    "source": [
                        "obj-knock",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "route-left",
                        0
                    ],
                    "order": 2,
                    "source": [
                        "dpt-mute-left",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-meter1",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "dpt-mute-left",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-sendleft",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "dpt-mute-left",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "route-right",
                        0
                    ],
                    "order": 2,
                    "source": [
                        "dpt-mute-right",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-meter2",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "dpt-mute-right",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-sendright",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "dpt-mute-right",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-manual",
                        0
                    ],
                    "source": [
                        "obj-paramreceive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-outputgain",
                        0
                    ],
                    "source": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-outputgain2",
                        0
                    ],
                    "source": [
                        "obj-rnbo",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-outputnote",
                        0
                    ],
                    "source": [
                        "obj-rnbo",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bass-fire",
                        0
                    ],
                    "source": [
                        "obj-trigger",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassDecay-max",
                        0
                    ],
                    "order": 2,
                    "source": [
                        "range-presets",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassDecay-min",
                        0
                    ],
                    "order": 3,
                    "source": [
                        "range-presets",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassFM-max",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "range-presets",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassFM-min",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "range-presets",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassNote-max",
                        0
                    ],
                    "order": 4,
                    "source": [
                        "range-presets",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassNote-min",
                        0
                    ],
                    "order": 5,
                    "source": [
                        "range-presets",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-presets",
                        0
                    ],
                    "source": [
                        "range-read",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassDecay-max",
                        0
                    ],
                    "source": [
                        "range-route",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassDecay-min",
                        0
                    ],
                    "source": [
                        "range-route",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassFM-max",
                        0
                    ],
                    "source": [
                        "range-route",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassFM-min",
                        0
                    ],
                    "source": [
                        "range-route",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassNote-max",
                        0
                    ],
                    "source": [
                        "range-route",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "bassNote-min",
                        0
                    ],
                    "source": [
                        "range-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-route",
                        0
                    ],
                    "source": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-status",
                        0
                    ],
                    "source": [
                        "range-script",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "range-presets",
                        0
                    ],
                    "source": [
                        "range-write",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "repeat-clock",
                        0
                    ],
                    "source": [
                        "repeat",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-trigger",
                        0
                    ],
                    "source": [
                        "repeat-clock",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "repeat",
                        0
                    ],
                    "source": [
                        "repeat-receive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-rnbo",
                        0
                    ],
                    "source": [
                        "bass-route",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        3
                    ],
                    "destination": [
                        "bass-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        3
                    ],
                    "destination": [
                        "bass-param-bassRatio",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassRatio",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        4
                    ],
                    "destination": [
                        "bass-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        4
                    ],
                    "destination": [
                        "bass-param-bassFMDecay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassFMDecay",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        5
                    ],
                    "destination": [
                        "bass-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        5
                    ],
                    "destination": [
                        "bass-param-bassFeedback",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassFeedback",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        6
                    ],
                    "destination": [
                        "bass-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        6
                    ],
                    "destination": [
                        "bass-param-bassSub",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassSub",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        7
                    ],
                    "destination": [
                        "bass-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        7
                    ],
                    "destination": [
                        "bass-param-bassBrightness",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassBrightness",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        8
                    ],
                    "destination": [
                        "bass-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        8
                    ],
                    "destination": [
                        "bass-param-bassAttack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassAttack",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        9
                    ],
                    "destination": [
                        "bass-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        9
                    ],
                    "destination": [
                        "bass-param-bassBend",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassBend",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        10
                    ],
                    "destination": [
                        "bass-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        10
                    ],
                    "destination": [
                        "bass-param-bassDrive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassDrive",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-route",
                        11
                    ],
                    "destination": [
                        "bass-cache",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-unpack",
                        11
                    ],
                    "destination": [
                        "bass-param-bassLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-param-bassLevel",
                        0
                    ],
                    "destination": [
                        "obj-rnbo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassRatio-min",
                        0
                    ],
                    "destination": [
                        "bassRatio-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassRatio-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        6
                    ],
                    "destination": [
                        "bassRatio-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassRatio-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassRatio-max",
                        0
                    ],
                    "destination": [
                        "bassRatio-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassRatio-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        7
                    ],
                    "destination": [
                        "bassRatio-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassRatio-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFMDecay-min",
                        0
                    ],
                    "destination": [
                        "bassFMDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFMDecay-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        8
                    ],
                    "destination": [
                        "bassFMDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassFMDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFMDecay-max",
                        0
                    ],
                    "destination": [
                        "bassFMDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFMDecay-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        9
                    ],
                    "destination": [
                        "bassFMDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassFMDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFeedback-min",
                        0
                    ],
                    "destination": [
                        "bassFeedback-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFeedback-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        10
                    ],
                    "destination": [
                        "bassFeedback-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassFeedback-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFeedback-max",
                        0
                    ],
                    "destination": [
                        "bassFeedback-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassFeedback-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        11
                    ],
                    "destination": [
                        "bassFeedback-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassFeedback-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassSub-min",
                        0
                    ],
                    "destination": [
                        "bassSub-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassSub-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        12
                    ],
                    "destination": [
                        "bassSub-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassSub-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassSub-max",
                        0
                    ],
                    "destination": [
                        "bassSub-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassSub-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        13
                    ],
                    "destination": [
                        "bassSub-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassSub-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBrightness-min",
                        0
                    ],
                    "destination": [
                        "bassBrightness-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBrightness-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        14
                    ],
                    "destination": [
                        "bassBrightness-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassBrightness-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBrightness-max",
                        0
                    ],
                    "destination": [
                        "bassBrightness-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBrightness-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        15
                    ],
                    "destination": [
                        "bassBrightness-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassBrightness-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassAttack-min",
                        0
                    ],
                    "destination": [
                        "bassAttack-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassAttack-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        16
                    ],
                    "destination": [
                        "bassAttack-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassAttack-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassAttack-max",
                        0
                    ],
                    "destination": [
                        "bassAttack-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassAttack-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        17
                    ],
                    "destination": [
                        "bassAttack-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassAttack-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBend-min",
                        0
                    ],
                    "destination": [
                        "bassBend-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBend-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        18
                    ],
                    "destination": [
                        "bassBend-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassBend-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBend-max",
                        0
                    ],
                    "destination": [
                        "bassBend-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassBend-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        19
                    ],
                    "destination": [
                        "bassBend-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassBend-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassDrive-min",
                        0
                    ],
                    "destination": [
                        "bassDrive-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassDrive-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        20
                    ],
                    "destination": [
                        "bassDrive-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassDrive-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassDrive-max",
                        0
                    ],
                    "destination": [
                        "bassDrive-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassDrive-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        21
                    ],
                    "destination": [
                        "bassDrive-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassDrive-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassLevel-min",
                        0
                    ],
                    "destination": [
                        "bassLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassLevel-min-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        22
                    ],
                    "destination": [
                        "bassLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassLevel-max",
                        0
                    ],
                    "destination": [
                        "bassLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bassLevel-max-pre",
                        0
                    ],
                    "destination": [
                        "range-script",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-route",
                        23
                    ],
                    "destination": [
                        "bassLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "range-presets",
                        0
                    ],
                    "destination": [
                        "bassLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-note",
                        0
                    ],
                    "destination": [
                        "control-note-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-note-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        0
                    ],
                    "destination": [
                        "control-note-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-note-set",
                        0
                    ],
                    "destination": [
                        "control-note",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-decayMs",
                        0
                    ],
                    "destination": [
                        "control-decayMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-decayMs-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        1
                    ],
                    "destination": [
                        "control-decayMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-decayMs-set",
                        0
                    ],
                    "destination": [
                        "control-decayMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmIndex",
                        0
                    ],
                    "destination": [
                        "control-fmIndex-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmIndex-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        2
                    ],
                    "destination": [
                        "control-fmIndex-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmIndex-set",
                        0
                    ],
                    "destination": [
                        "control-fmIndex",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmRatio",
                        0
                    ],
                    "destination": [
                        "control-fmRatio-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmRatio-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        3
                    ],
                    "destination": [
                        "control-fmRatio-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmRatio-set",
                        0
                    ],
                    "destination": [
                        "control-fmRatio",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmDecayMs",
                        0
                    ],
                    "destination": [
                        "control-fmDecayMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmDecayMs-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        4
                    ],
                    "destination": [
                        "control-fmDecayMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmDecayMs-set",
                        0
                    ],
                    "destination": [
                        "control-fmDecayMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-feedback",
                        0
                    ],
                    "destination": [
                        "control-feedback-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-feedback-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        5
                    ],
                    "destination": [
                        "control-feedback-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-feedback-set",
                        0
                    ],
                    "destination": [
                        "control-feedback",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-subLevel",
                        0
                    ],
                    "destination": [
                        "control-subLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-subLevel-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        6
                    ],
                    "destination": [
                        "control-subLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-subLevel-set",
                        0
                    ],
                    "destination": [
                        "control-subLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-brightness",
                        0
                    ],
                    "destination": [
                        "control-brightness-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-brightness-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        7
                    ],
                    "destination": [
                        "control-brightness-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-brightness-set",
                        0
                    ],
                    "destination": [
                        "control-brightness",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-attackMs",
                        0
                    ],
                    "destination": [
                        "control-attackMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-attackMs-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        8
                    ],
                    "destination": [
                        "control-attackMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-attackMs-set",
                        0
                    ],
                    "destination": [
                        "control-attackMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bendSemitones",
                        0
                    ],
                    "destination": [
                        "control-bendSemitones-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bendSemitones-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        9
                    ],
                    "destination": [
                        "control-bendSemitones-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bendSemitones-set",
                        0
                    ],
                    "destination": [
                        "control-bendSemitones",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-drive",
                        0
                    ],
                    "destination": [
                        "control-drive-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-drive-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        10
                    ],
                    "destination": [
                        "control-drive-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-drive-set",
                        0
                    ],
                    "destination": [
                        "control-drive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-level",
                        0
                    ],
                    "destination": [
                        "control-level-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-level-pre",
                        0
                    ],
                    "destination": [
                        "bass-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-ui-unpack",
                        11
                    ],
                    "destination": [
                        "control-level-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-level-set",
                        0
                    ],
                    "destination": [
                        "control-level",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-cache",
                        0
                    ],
                    "destination": [
                        "bass-ui-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route-reserve",
                        0
                    ],
                    "destination": [
                        "route-stereo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route-stereo",
                        0
                    ],
                    "destination": [
                        "route-smooth",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route-smooth",
                        0
                    ],
                    "destination": [
                        "route-left",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route-smooth",
                        0
                    ],
                    "destination": [
                        "route-right",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route-left",
                        0
                    ],
                    "destination": [
                        "audio-switch",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route-right",
                        0
                    ],
                    "destination": [
                        "audio-switch",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-manual",
                        1
                    ],
                    "destination": [
                        "dpt-bridge",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-owned",
                        0
                    ],
                    "destination": [
                        "dpt-bridge",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-values",
                        0
                    ],
                    "destination": [
                        "dpt-bridge",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-enabled",
                        0
                    ],
                    "destination": [
                        "dpt-local",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-local",
                        0
                    ],
                    "destination": [
                        "dpt-local-signal",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-local-signal",
                        0
                    ],
                    "destination": [
                        "dpt-local-smooth",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-outputgain",
                        0
                    ],
                    "destination": [
                        "dpt-mute-left",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-local-smooth",
                        0
                    ],
                    "destination": [
                        "dpt-mute-left",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-outputgain2",
                        0
                    ],
                    "destination": [
                        "dpt-mute-right",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-local-smooth",
                        0
                    ],
                    "destination": [
                        "dpt-mute-right",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bass-cache",
                        0
                    ],
                    "destination": [
                        "dpt-sync-values",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-sync-values",
                        0
                    ],
                    "destination": [
                        "dpt-bridge",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-enabled",
                        0
                    ],
                    "destination": [
                        "dpt-sync-enabled",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-enabled",
                        0
                    ],
                    "destination": [
                        "dpt-sync-gate",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-sync-receive",
                        0
                    ],
                    "destination": [
                        "dpt-sync-gate",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-sync-gate",
                        0
                    ],
                    "destination": [
                        "dpt-sync-values",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-sync-enabled",
                        0
                    ],
                    "destination": [
                        "dpt-sync-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dpt-sync-defer",
                        0
                    ],
                    "destination": [
                        "dpt-sync-values",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-rnbo": [
                "bass_rnbo",
                "bass_rnbo",
                0
            ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ],
                    "buttons": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}
