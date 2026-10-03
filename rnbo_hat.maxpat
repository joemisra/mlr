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
                    "text": "RNBO hat laboratory"
                }
            },
            {
                "box": {
                    "id": "obj-note",
                    "linecount": 3,
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
                    "text": "Track 13 triggers the hat. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "hat_trigger"
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
                    "text": "r 14input"
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
                    "text": "r rnbo_hat_trigger"
                }
            },
            {
                "box": {
                    "id": "obj-deep",
                    "linecount": 2,
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
                    "text": "metalHz 700, decayMs 120, spread 1, inharmonicity 0.65, noiseDecayMs 85, filterHz 6500, attack 0.4, drive 1.4, metalLevel 0.7, noiseLevel 0.55, filterQ 0.8, level 0.4",
                    "varname": "hat_preset_deep"
                }
            },
            {
                "box": {
                    "id": "obj-knock",
                    "linecount": 2,
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
                    "text": "metalHz 700, decayMs 1100, spread 1, inharmonicity 0.65, noiseDecayMs 800, filterHz 7200, attack 0.25, drive 1.4, metalLevel 0.7, noiseLevel 0.55, filterQ 0.8, level 0.4",
                    "varname": "hat_preset_knock"
                }
            },
            {
                "box": {
                    "id": "obj-hollow",
                    "linecount": 2,
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
                    "text": "metalHz 1100, decayMs 1900, spread 1, inharmonicity 0.9, noiseDecayMs 350, filterHz 6500, attack 0.4, drive 1.4, metalLevel 0.9, noiseLevel 0.2, filterQ 3, level 0.4",
                    "varname": "hat_preset_hollow"
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
                    "text": "starting sounds: closed / open / ring"
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
                    "text": "r rnbo_hat_param"
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
                    "text": "parameter bus format: metalHz 700"
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
                        "title": "mlr-hat",
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
                                                "displayName": "drive",
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
                                    "text": "p @file rnbo_hat_voice"
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
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        245,
                                        255,
                                        300,
                                        35
                                    ],
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_hat_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-metalHz",
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
                                    "rnbo_uniqueid": "metalHz",
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
                                    "text": "param metalHz 700 @min 100 @max 6000 @unit Hz",
                                    "varname": "metalHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-inharmonicity",
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
                                    "rnbo_uniqueid": "inharmonicity",
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
                                    "text": "param inharmonicity 0.65 @min 0 @max 1",
                                    "varname": "inharmonicity"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-noiseDecayMs",
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
                                    "rnbo_uniqueid": "noiseDecayMs",
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
                                    "text": "param noiseDecayMs 85 @min 5 @max 10000 @unit ms",
                                    "varname": "noiseDecayMs"
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
                                    "text": "param decayMs 120 @min 5 @max 10000 @unit ms",
                                    "varname": "decayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-spread",
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
                                    "rnbo_uniqueid": "spread",
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
                                    "text": "param spread 1 @min 0.1 @max 4",
                                    "varname": "spread"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-filterHz",
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
                                    "rnbo_uniqueid": "filterHz",
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
                                    "text": "param filterHz 6500 @min 100 @max 18000 @unit Hz",
                                    "varname": "filterHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-metalLevel",
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
                                    "rnbo_uniqueid": "metalLevel",
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
                                    "text": "param metalLevel 0.7 @min 0 @max 1",
                                    "varname": "metalLevel"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-noiseLevel",
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
                                    "rnbo_uniqueid": "noiseLevel",
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
                                    "text": "param noiseLevel 0.55 @min 0 @max 1",
                                    "varname": "noiseLevel"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-filterQ",
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
                                    "rnbo_uniqueid": "filterQ",
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
                                    "text": "param filterQ 0.8 @min 0.5 @max 20",
                                    "varname": "filterQ"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-attack",
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
                                    "rnbo_uniqueid": "attack",
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
                                    "text": "param attack 0.4 @min 0 @max 1",
                                    "varname": "attack"
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
                                    "text": "param level 0.4 @min 0 @max 1",
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
                                        4
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
                                        "rnbo-param-metalHz",
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
                                        "rnbo-param-attack",
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
                                        "rnbo-voice",
                                        5
                                    ],
                                    "source": [
                                        "rnbo-param-spread",
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
                                        "rnbo-param-filterHz",
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
                                        2
                                    ],
                                    "source": [
                                        "rnbo-param-inharmonicity",
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
                                        "rnbo-param-noiseDecayMs",
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
                                        "rnbo-param-noiseLevel",
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
                                        "rnbo-param-metalLevel",
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
                                        "rnbo-param-filterQ",
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
                        "noiseDecayMs": {
                            "label": "noiseDecayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 85
                        },
                        "filterQ": {
                            "label": "filterQ",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.8
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.4
                        },
                        "spread": {
                            "label": "spread",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1
                        },
                        "filterHz": {
                            "label": "filterHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 6500
                        },
                        "noiseLevel": {
                            "label": "noiseLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.55
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.4
                        },
                        "inharmonicity": {
                            "label": "inharmonicity",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.65
                        },
                        "attack": {
                            "label": "attack",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.4
                        },
                        "decayMs": {
                            "label": "decayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 120
                        },
                        "metalLevel": {
                            "label": "metalLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.7
                        },
                        "metalHz": {
                            "label": "metalHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 700
                        }
                    },
                    "rnboversion": "1.4.5",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "hat_rnbo",
                            "parameter_modmode": 0,
                            "parameter_shortname": "hat_rnbo",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "optimization": "O1",
                        "parameter_enable": 1,
                        "uuid": "25b53ec3-bc87-419e-9c7a-36155457aa41"
                    },
                    "text": "rnbo~ @title mlr-hat @dumpoutlet 1",
                    "varname": "hat_rnbo"
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
                    "text": "s~ rnbo_hat_left"
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
                    "text": "s~ rnbo_hat_right"
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
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500,
                        360,
                        300,
                        33
                    ],
                    "text": "Audio buses stay active; combined lab selects Stereo or 6mix."
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
                    "text": "Closed"
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
                    "text": "Open"
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
                    "text": "Ring"
                }
            },
            {
                "box": {
                    "id": "label-metalHz",
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
                    "text": "Metal pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "control-metalHz",
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
                    "varname": "hat_sound_metalHz",
                    "minimum": 100,
                    "maximum": 6000
                }
            },
            {
                "box": {
                    "id": "label-inharmonicity",
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
                        25,
                        356,
                        245,
                        20
                    ],
                    "text": "Inharmonicity"
                }
            },
            {
                "box": {
                    "id": "control-inharmonicity",
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
                        25,
                        379,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hat_sound_inharmonicity"
                }
            },
            {
                "box": {
                    "id": "label-noiseDecayMs",
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
                        288,
                        245,
                        20
                    ],
                    "text": "Noise decay · ms"
                }
            },
            {
                "box": {
                    "id": "control-noiseDecayMs",
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
                        311,
                        245,
                        22
                    ],
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "hat_sound_noiseDecayMs"
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
                        305,
                        220,
                        245,
                        20
                    ],
                    "text": "Metal decay · ms"
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
                        305,
                        243,
                        245,
                        22
                    ],
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "hat_sound_decayMs"
                }
            },
            {
                "box": {
                    "id": "label-spread",
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
                        25,
                        288,
                        245,
                        20
                    ],
                    "text": "Spread"
                }
            },
            {
                "box": {
                    "id": "control-spread",
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
                        25,
                        311,
                        245,
                        22
                    ],
                    "minimum": 0.1,
                    "maximum": 4,
                    "varname": "hat_sound_spread"
                }
            },
            {
                "box": {
                    "id": "label-filterHz",
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
                        585,
                        220,
                        245,
                        20
                    ],
                    "text": "Filter frequency · Hz"
                }
            },
            {
                "box": {
                    "id": "control-filterHz",
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
                        585,
                        243,
                        245,
                        22
                    ],
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "hat_sound_filterHz"
                }
            },
            {
                "box": {
                    "id": "label-metalLevel",
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
                        424,
                        245,
                        20
                    ],
                    "text": "Metal level"
                }
            },
            {
                "box": {
                    "id": "control-metalLevel",
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
                        447,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hat_sound_metalLevel"
                }
            },
            {
                "box": {
                    "id": "label-noiseLevel",
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
                        305,
                        424,
                        245,
                        20
                    ],
                    "text": "Noise level"
                }
            },
            {
                "box": {
                    "id": "control-noiseLevel",
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
                        305,
                        447,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hat_sound_noiseLevel"
                }
            },
            {
                "box": {
                    "id": "label-filterQ",
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
                        288,
                        245,
                        20
                    ],
                    "text": "Filter Q"
                }
            },
            {
                "box": {
                    "id": "control-filterQ",
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
                        311,
                        245,
                        22
                    ],
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "hat_sound_filterQ"
                }
            },
            {
                "box": {
                    "id": "label-attack",
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
                        305,
                        356,
                        245,
                        20
                    ],
                    "text": "Attack"
                }
            },
            {
                "box": {
                    "id": "control-attack",
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
                        305,
                        379,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hat_sound_attack"
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
                        170,
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
                        192,
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
                    "varname": "hat_sound_drive"
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
                    "varname": "hat_sound_level"
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
                    "text": "r rnbo_hat_repeat"
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
                    "linecount": 2,
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
                    "presentation_linecount": 2,
                    "presentation_rect": [
                        82,
                        532,
                        327,
                        33
                    ],
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_hat_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "hat-manual",
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
                    "id": "hat-manual-echo",
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
                    "text": "prepend hatManual"
                }
            },
            {
                "box": {
                    "id": "hat-router",
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
                    "id": "hat-route",
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
                    "text": "route metalHz decayMs spread inharmonicity noiseDecayMs filterHz attack drive metalLevel noiseLevel filterQ level"
                }
            },
            {
                "box": {
                    "id": "hat-cache",
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
                    "text": "pak 700.0 120.0 1.0 0.65 85.0 6500.0 0.4 1.4 0.7 0.55 0.8 0.4"
                }
            },
            {
                "box": {
                    "id": "hat-unpack",
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
                    "id": "hat-pitch",
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
                    "text": "prepend metalHz"
                }
            },
            {
                "box": {
                    "id": "hat-decay",
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
                    "id": "hat-fm",
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
                    "text": "prepend spread"
                }
            },
            {
                "box": {
                    "id": "hat-owned",
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
                    "text": "r rnbo_hat_owned_param"
                }
            },
            {
                "box": {
                    "id": "hat-step",
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
                    "text": "r rnbo_hat_step"
                }
            },
            {
                "box": {
                    "id": "hat-step-unpack",
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
                    "id": "hat-fire",
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
                    "id": "hat-load",
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
                    "id": "hat-defer",
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
                    "id": "hat-sync",
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
                    "text": "hatSync"
                }
            },
            {
                "box": {
                    "id": "hat-values",
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
                    "text": "Grid mapping ranges · all twelve hat parameters"
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
                    "filename": "hat_lab_ranges.js",
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
                    "text": "v8 hat_lab_ranges.js",
                    "textfile": {
                        "filename": "hat_lab_ranges.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "hatPitch-range-label",
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
                    "text": "Metal pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "hatPitch-min-label",
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
                    "id": "hatPitch-min",
                    "maxclass": "flonum",
                    "maximum": 6000,
                    "minimum": 100,
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
                    "varname": "hatPitch-min"
                }
            },
            {
                "box": {
                    "id": "hatPitch-min-pre",
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
                    "text": "prepend setrange hatPitch min"
                }
            },
            {
                "box": {
                    "id": "hatPitch-max-label",
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
                    "id": "hatPitch-max",
                    "maxclass": "flonum",
                    "maximum": 6000,
                    "minimum": 100,
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
                    "varname": "hatPitch-max"
                }
            },
            {
                "box": {
                    "id": "hatPitch-max-pre",
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
                    "text": "prepend setrange hatPitch max"
                }
            },
            {
                "box": {
                    "id": "hatDecay-range-label",
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
                    "text": "Metal decay · ms"
                }
            },
            {
                "box": {
                    "id": "hatDecay-min-label",
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
                    "id": "hatDecay-min",
                    "maxclass": "flonum",
                    "maximum": 10000,
                    "minimum": 5,
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
                    "varname": "hatDecay-min"
                }
            },
            {
                "box": {
                    "id": "hatDecay-min-pre",
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
                    "text": "prepend setrange hatDecay min"
                }
            },
            {
                "box": {
                    "id": "hatDecay-max-label",
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
                    "id": "hatDecay-max",
                    "maxclass": "flonum",
                    "maximum": 10000,
                    "minimum": 5,
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
                    "varname": "hatDecay-max"
                }
            },
            {
                "box": {
                    "id": "hatDecay-max-pre",
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
                    "text": "prepend setrange hatDecay max"
                }
            },
            {
                "box": {
                    "id": "hatSpread-range-label",
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
                    "text": "Spread"
                }
            },
            {
                "box": {
                    "id": "hatSpread-min-label",
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
                    "id": "hatSpread-min",
                    "maxclass": "flonum",
                    "maximum": 4,
                    "minimum": 0.1,
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
                    "varname": "hatSpread-min"
                }
            },
            {
                "box": {
                    "id": "hatSpread-min-pre",
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
                    "text": "prepend setrange hatSpread min"
                }
            },
            {
                "box": {
                    "id": "hatSpread-max-label",
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
                    "id": "hatSpread-max",
                    "maxclass": "flonum",
                    "maximum": 4,
                    "minimum": 0.1,
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
                    "varname": "hatSpread-max"
                }
            },
            {
                "box": {
                    "id": "hatSpread-max-pre",
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
                    "text": "prepend setrange hatSpread max"
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
                    "text": "route hatPitch-min hatPitch-max hatDecay-min hatDecay-max hatSpread-min hatSpread-max hatInharmonicity-min hatInharmonicity-max hatNoiseDecay-min hatNoiseDecay-max hatFilterHz-min hatFilterHz-max hatAttack-min hatAttack-max hatDrive-min hatDrive-max hatMetalLevel-min hatMetalLevel-max hatNoiseLevel-min hatNoiseLevel-max hatFilterQ-min hatFilterQ-max hatLevel-min hatLevel-max"
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
                    "varname": "hat_grid_range_presets"
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
                    "id": "hat-param-hatInharmonicity",
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
                    "text": "prepend inharmonicity"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatNoiseDecay",
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
                    "text": "prepend noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatFilterHz",
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
                    "text": "prepend filterHz"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatAttack",
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
                    "text": "prepend attack"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatDrive",
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
                    "text": "prepend drive"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatMetalLevel",
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
                    "text": "prepend metalLevel"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatNoiseLevel",
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
                    "text": "prepend noiseLevel"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatFilterQ",
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
                    "text": "prepend filterQ"
                }
            },
            {
                "box": {
                    "id": "hat-param-hatLevel",
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
                    "id": "hatInharmonicity-range-label",
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
                    "text": "Inharmonicity"
                }
            },
            {
                "box": {
                    "id": "hatInharmonicity-min-label",
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
                    "id": "hatInharmonicity-min",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hatInharmonicity-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatInharmonicity-min-pre",
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
                    "text": "prepend setrange hatInharmonicity min"
                }
            },
            {
                "box": {
                    "id": "hatInharmonicity-max-label",
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
                    "id": "hatInharmonicity-max",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hatInharmonicity-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatInharmonicity-max-pre",
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
                    "text": "prepend setrange hatInharmonicity max"
                }
            },
            {
                "box": {
                    "id": "hatNoiseDecay-range-label",
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
                    "text": "Noise decay · ms"
                }
            },
            {
                "box": {
                    "id": "hatNoiseDecay-min-label",
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
                    "id": "hatNoiseDecay-min",
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
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "hatNoiseDecay-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatNoiseDecay-min-pre",
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
                    "text": "prepend setrange hatNoiseDecay min"
                }
            },
            {
                "box": {
                    "id": "hatNoiseDecay-max-label",
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
                    "id": "hatNoiseDecay-max",
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
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "hatNoiseDecay-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatNoiseDecay-max-pre",
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
                    "text": "prepend setrange hatNoiseDecay max"
                }
            },
            {
                "box": {
                    "id": "hatFilterHz-range-label",
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
                    "text": "Filter frequency · Hz"
                }
            },
            {
                "box": {
                    "id": "hatFilterHz-min-label",
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
                    "id": "hatFilterHz-min",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "hatFilterHz-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatFilterHz-min-pre",
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
                    "text": "prepend setrange hatFilterHz min"
                }
            },
            {
                "box": {
                    "id": "hatFilterHz-max-label",
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
                    "id": "hatFilterHz-max",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "hatFilterHz-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatFilterHz-max-pre",
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
                    "text": "prepend setrange hatFilterHz max"
                }
            },
            {
                "box": {
                    "id": "hatAttack-range-label",
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
                    "text": "Attack"
                }
            },
            {
                "box": {
                    "id": "hatAttack-min-label",
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
                    "id": "hatAttack-min",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hatAttack-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatAttack-min-pre",
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
                    "text": "prepend setrange hatAttack min"
                }
            },
            {
                "box": {
                    "id": "hatAttack-max-label",
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
                    "id": "hatAttack-max",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hatAttack-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatAttack-max-pre",
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
                    "text": "prepend setrange hatAttack max"
                }
            },
            {
                "box": {
                    "id": "hatDrive-range-label",
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
                    "id": "hatDrive-min-label",
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
                    "id": "hatDrive-min",
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
                    "varname": "hatDrive-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatDrive-min-pre",
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
                    "text": "prepend setrange hatDrive min"
                }
            },
            {
                "box": {
                    "id": "hatDrive-max-label",
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
                    "id": "hatDrive-max",
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
                    "varname": "hatDrive-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatDrive-max-pre",
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
                    "text": "prepend setrange hatDrive max"
                }
            },
            {
                "box": {
                    "id": "hatMetalLevel-range-label",
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
                    "text": "Metal level"
                }
            },
            {
                "box": {
                    "id": "hatMetalLevel-min-label",
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
                    "id": "hatMetalLevel-min",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hatMetalLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatMetalLevel-min-pre",
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
                    "text": "prepend setrange hatMetalLevel min"
                }
            },
            {
                "box": {
                    "id": "hatMetalLevel-max-label",
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
                    "id": "hatMetalLevel-max",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "hatMetalLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatMetalLevel-max-pre",
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
                    "text": "prepend setrange hatMetalLevel max"
                }
            },
            {
                "box": {
                    "id": "hatNoiseLevel-range-label",
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
                    "text": "Noise level"
                }
            },
            {
                "box": {
                    "id": "hatNoiseLevel-min-label",
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
                    "id": "hatNoiseLevel-min",
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
                    "maximum": 1,
                    "varname": "hatNoiseLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatNoiseLevel-min-pre",
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
                    "text": "prepend setrange hatNoiseLevel min"
                }
            },
            {
                "box": {
                    "id": "hatNoiseLevel-max-label",
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
                    "id": "hatNoiseLevel-max",
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
                    "maximum": 1,
                    "varname": "hatNoiseLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatNoiseLevel-max-pre",
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
                    "text": "prepend setrange hatNoiseLevel max"
                }
            },
            {
                "box": {
                    "id": "hatFilterQ-range-label",
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
                    "text": "Filter Q"
                }
            },
            {
                "box": {
                    "id": "hatFilterQ-min-label",
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
                    "id": "hatFilterQ-min",
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
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "hatFilterQ-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatFilterQ-min-pre",
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
                    "text": "prepend setrange hatFilterQ min"
                }
            },
            {
                "box": {
                    "id": "hatFilterQ-max-label",
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
                    "id": "hatFilterQ-max",
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
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "hatFilterQ-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatFilterQ-max-pre",
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
                    "text": "prepend setrange hatFilterQ max"
                }
            },
            {
                "box": {
                    "id": "hatLevel-range-label",
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
                    "id": "hatLevel-min-label",
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
                    "id": "hatLevel-min",
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
                    "varname": "hatLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatLevel-min-pre",
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
                    "text": "prepend setrange hatLevel min"
                }
            },
            {
                "box": {
                    "id": "hatLevel-max-label",
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
                    "id": "hatLevel-max",
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
                    "varname": "hatLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "hatLevel-max-pre",
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
                    "text": "prepend setrange hatLevel max"
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
                    "text": "Metal"
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
                    "text": "Shape"
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
                    "text": "Filter / output"
                }
            },
            {
                "box": {
                    "id": "control-metalHz-pre",
                    "maxclass": "newobj",
                    "text": "prepend metalHz",
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
                    "id": "control-metalHz-set",
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
                    "id": "control-spread-pre",
                    "maxclass": "newobj",
                    "text": "prepend spread",
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
                    "id": "control-spread-set",
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
                    "id": "control-inharmonicity-pre",
                    "maxclass": "newobj",
                    "text": "prepend inharmonicity",
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
                    "id": "control-inharmonicity-set",
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
                    "id": "control-noiseDecayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend noiseDecayMs",
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
                    "id": "control-noiseDecayMs-set",
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
                    "id": "control-filterHz-pre",
                    "maxclass": "newobj",
                    "text": "prepend filterHz",
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
                    "id": "control-filterHz-set",
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
                    "id": "control-attack-pre",
                    "maxclass": "newobj",
                    "text": "prepend attack",
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
                    "id": "control-attack-set",
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
                    "id": "control-drive-pre",
                    "maxclass": "newobj",
                    "text": "prepend drive",
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
                    "id": "control-drive-set",
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
                    "id": "control-metalLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend metalLevel",
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
                    "id": "control-metalLevel-set",
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
                    "id": "control-noiseLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend noiseLevel",
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
                    "id": "control-noiseLevel-set",
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
                    "id": "control-filterQ-pre",
                    "maxclass": "newobj",
                    "text": "prepend filterQ",
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
                    "id": "control-filterQ-set",
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
                    "id": "hat-ui-unpack",
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
                    "text": "r~ mlr_drum_es9_active",
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
                    "text": "dpt_hat_midi",
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
                        "hat-owned",
                        0
                    ],
                    "destination": [
                        "hat-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step",
                        0
                    ],
                    "destination": [
                        "hat-step-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        0
                    ],
                    "destination": [
                        "hat-cache",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        1
                    ],
                    "destination": [
                        "hat-cache",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        2
                    ],
                    "destination": [
                        "hat-cache",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        3
                    ],
                    "destination": [
                        "hat-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        4
                    ],
                    "destination": [
                        "hat-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        5
                    ],
                    "destination": [
                        "hat-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        6
                    ],
                    "destination": [
                        "hat-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        7
                    ],
                    "destination": [
                        "hat-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        8
                    ],
                    "destination": [
                        "hat-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        9
                    ],
                    "destination": [
                        "hat-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        10
                    ],
                    "destination": [
                        "hat-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-step-unpack",
                        11
                    ],
                    "destination": [
                        "hat-cache",
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
                        "hat-values",
                        1
                    ],
                    "source": [
                        "hat-cache",
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
                        "hat-decay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-sync",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "hat-defer",
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
                        "hat-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-values",
                        0
                    ],
                    "source": [
                        "hat-fire",
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
                        "hat-fire",
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
                        "hat-fm",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-cache",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "hat-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-defer",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "hat-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-manual-echo",
                        0
                    ],
                    "source": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-route",
                        0
                    ],
                    "source": [
                        "hat-manual",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-router",
                        0
                    ],
                    "source": [
                        "hat-manual-echo",
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
                        "hat-pitch",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-cache",
                        2
                    ],
                    "source": [
                        "hat-route",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-cache",
                        1
                    ],
                    "source": [
                        "hat-route",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-cache",
                        0
                    ],
                    "source": [
                        "hat-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-router",
                        0
                    ],
                    "source": [
                        "hat-sync",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-decay",
                        0
                    ],
                    "source": [
                        "hat-unpack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-fm",
                        0
                    ],
                    "source": [
                        "hat-unpack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-pitch",
                        0
                    ],
                    "source": [
                        "hat-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-unpack",
                        0
                    ],
                    "source": [
                        "hat-values",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hatDecay-max-pre",
                        0
                    ],
                    "source": [
                        "hatDecay-max",
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
                        "hatDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hatDecay-min-pre",
                        0
                    ],
                    "source": [
                        "hatDecay-min",
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
                        "hatDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hatSpread-max-pre",
                        0
                    ],
                    "source": [
                        "hatSpread-max",
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
                        "hatSpread-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hatSpread-min-pre",
                        0
                    ],
                    "source": [
                        "hatSpread-min",
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
                        "hatSpread-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hatPitch-max-pre",
                        0
                    ],
                    "source": [
                        "hatPitch-max",
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
                        "hatPitch-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hatPitch-min-pre",
                        0
                    ],
                    "source": [
                        "hatPitch-min",
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
                        "hatPitch-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "hat-manual",
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
                        "hat-manual",
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
                        "hat-manual",
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
                        "hat-manual",
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
                        "hat-fire",
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
                        "hatDecay-max",
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
                        "hatDecay-min",
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
                        "hatSpread-max",
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
                        "hatSpread-min",
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
                        "hatPitch-max",
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
                        "hatPitch-min",
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
                        "hatDecay-max",
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
                        "hatDecay-min",
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
                        "hatSpread-max",
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
                        "hatSpread-min",
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
                        "hatPitch-max",
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
                        "hatPitch-min",
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
                        "hat-route",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-route",
                        3
                    ],
                    "destination": [
                        "hat-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        3
                    ],
                    "destination": [
                        "hat-param-hatInharmonicity",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatInharmonicity",
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
                        "hat-route",
                        4
                    ],
                    "destination": [
                        "hat-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        4
                    ],
                    "destination": [
                        "hat-param-hatNoiseDecay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatNoiseDecay",
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
                        "hat-route",
                        5
                    ],
                    "destination": [
                        "hat-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        5
                    ],
                    "destination": [
                        "hat-param-hatFilterHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatFilterHz",
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
                        "hat-route",
                        6
                    ],
                    "destination": [
                        "hat-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        6
                    ],
                    "destination": [
                        "hat-param-hatAttack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatAttack",
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
                        "hat-route",
                        7
                    ],
                    "destination": [
                        "hat-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        7
                    ],
                    "destination": [
                        "hat-param-hatDrive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatDrive",
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
                        "hat-route",
                        8
                    ],
                    "destination": [
                        "hat-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        8
                    ],
                    "destination": [
                        "hat-param-hatMetalLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatMetalLevel",
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
                        "hat-route",
                        9
                    ],
                    "destination": [
                        "hat-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        9
                    ],
                    "destination": [
                        "hat-param-hatNoiseLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatNoiseLevel",
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
                        "hat-route",
                        10
                    ],
                    "destination": [
                        "hat-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        10
                    ],
                    "destination": [
                        "hat-param-hatFilterQ",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatFilterQ",
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
                        "hat-route",
                        11
                    ],
                    "destination": [
                        "hat-cache",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-unpack",
                        11
                    ],
                    "destination": [
                        "hat-param-hatLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-param-hatLevel",
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
                        "hatInharmonicity-min",
                        0
                    ],
                    "destination": [
                        "hatInharmonicity-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatInharmonicity-min-pre",
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
                        "hatInharmonicity-min",
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
                        "hatInharmonicity-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatInharmonicity-max",
                        0
                    ],
                    "destination": [
                        "hatInharmonicity-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatInharmonicity-max-pre",
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
                        "hatInharmonicity-max",
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
                        "hatInharmonicity-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseDecay-min",
                        0
                    ],
                    "destination": [
                        "hatNoiseDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseDecay-min-pre",
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
                        "hatNoiseDecay-min",
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
                        "hatNoiseDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseDecay-max",
                        0
                    ],
                    "destination": [
                        "hatNoiseDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseDecay-max-pre",
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
                        "hatNoiseDecay-max",
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
                        "hatNoiseDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterHz-min",
                        0
                    ],
                    "destination": [
                        "hatFilterHz-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterHz-min-pre",
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
                        "hatFilterHz-min",
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
                        "hatFilterHz-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterHz-max",
                        0
                    ],
                    "destination": [
                        "hatFilterHz-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterHz-max-pre",
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
                        "hatFilterHz-max",
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
                        "hatFilterHz-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatAttack-min",
                        0
                    ],
                    "destination": [
                        "hatAttack-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatAttack-min-pre",
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
                        "hatAttack-min",
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
                        "hatAttack-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatAttack-max",
                        0
                    ],
                    "destination": [
                        "hatAttack-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatAttack-max-pre",
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
                        "hatAttack-max",
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
                        "hatAttack-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatDrive-min",
                        0
                    ],
                    "destination": [
                        "hatDrive-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatDrive-min-pre",
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
                        "hatDrive-min",
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
                        "hatDrive-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatDrive-max",
                        0
                    ],
                    "destination": [
                        "hatDrive-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatDrive-max-pre",
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
                        "hatDrive-max",
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
                        "hatDrive-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatMetalLevel-min",
                        0
                    ],
                    "destination": [
                        "hatMetalLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatMetalLevel-min-pre",
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
                        "hatMetalLevel-min",
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
                        "hatMetalLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatMetalLevel-max",
                        0
                    ],
                    "destination": [
                        "hatMetalLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatMetalLevel-max-pre",
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
                        "hatMetalLevel-max",
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
                        "hatMetalLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseLevel-min",
                        0
                    ],
                    "destination": [
                        "hatNoiseLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseLevel-min-pre",
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
                        "hatNoiseLevel-min",
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
                        "hatNoiseLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseLevel-max",
                        0
                    ],
                    "destination": [
                        "hatNoiseLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatNoiseLevel-max-pre",
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
                        "hatNoiseLevel-max",
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
                        "hatNoiseLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterQ-min",
                        0
                    ],
                    "destination": [
                        "hatFilterQ-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterQ-min-pre",
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
                        "hatFilterQ-min",
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
                        "hatFilterQ-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterQ-max",
                        0
                    ],
                    "destination": [
                        "hatFilterQ-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatFilterQ-max-pre",
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
                        "hatFilterQ-max",
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
                        "hatFilterQ-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatLevel-min",
                        0
                    ],
                    "destination": [
                        "hatLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatLevel-min-pre",
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
                        "hatLevel-min",
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
                        "hatLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatLevel-max",
                        0
                    ],
                    "destination": [
                        "hatLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hatLevel-max-pre",
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
                        "hatLevel-max",
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
                        "hatLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-metalHz",
                        0
                    ],
                    "destination": [
                        "control-metalHz-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-metalHz-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        0
                    ],
                    "destination": [
                        "control-metalHz-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-metalHz-set",
                        0
                    ],
                    "destination": [
                        "control-metalHz",
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
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
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
                        "control-spread",
                        0
                    ],
                    "destination": [
                        "control-spread-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-spread-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        2
                    ],
                    "destination": [
                        "control-spread-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-spread-set",
                        0
                    ],
                    "destination": [
                        "control-spread",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-inharmonicity",
                        0
                    ],
                    "destination": [
                        "control-inharmonicity-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-inharmonicity-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        3
                    ],
                    "destination": [
                        "control-inharmonicity-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-inharmonicity-set",
                        0
                    ],
                    "destination": [
                        "control-inharmonicity",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseDecayMs",
                        0
                    ],
                    "destination": [
                        "control-noiseDecayMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseDecayMs-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        4
                    ],
                    "destination": [
                        "control-noiseDecayMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseDecayMs-set",
                        0
                    ],
                    "destination": [
                        "control-noiseDecayMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-filterHz",
                        0
                    ],
                    "destination": [
                        "control-filterHz-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-filterHz-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        5
                    ],
                    "destination": [
                        "control-filterHz-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-filterHz-set",
                        0
                    ],
                    "destination": [
                        "control-filterHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-attack",
                        0
                    ],
                    "destination": [
                        "control-attack-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-attack-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        6
                    ],
                    "destination": [
                        "control-attack-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-attack-set",
                        0
                    ],
                    "destination": [
                        "control-attack",
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
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        7
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
                        "control-metalLevel",
                        0
                    ],
                    "destination": [
                        "control-metalLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-metalLevel-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        8
                    ],
                    "destination": [
                        "control-metalLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-metalLevel-set",
                        0
                    ],
                    "destination": [
                        "control-metalLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseLevel",
                        0
                    ],
                    "destination": [
                        "control-noiseLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseLevel-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        9
                    ],
                    "destination": [
                        "control-noiseLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseLevel-set",
                        0
                    ],
                    "destination": [
                        "control-noiseLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-filterQ",
                        0
                    ],
                    "destination": [
                        "control-filterQ-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-filterQ-pre",
                        0
                    ],
                    "destination": [
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
                        10
                    ],
                    "destination": [
                        "control-filterQ-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-filterQ-set",
                        0
                    ],
                    "destination": [
                        "control-filterQ",
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
                        "hat-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hat-ui-unpack",
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
                        "hat-cache",
                        0
                    ],
                    "destination": [
                        "hat-ui-unpack",
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
                        "hat-manual",
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
                        "hat-owned",
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
                        "hat-values",
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
                        "hat-cache",
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
                "hat_rnbo",
                "hat_rnbo",
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
