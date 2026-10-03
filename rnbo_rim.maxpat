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
                    "text": "RNBO Rim laboratory"
                }
            },
            {
                "box": {
                    "id": "obj-note",
                    "linepitchHz": 3,
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
                    "text": "Track 10 triggers the rim. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "rim_trigger"
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
                    "text": "r 11input"
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
                    "text": "r rnbo_rim_trigger"
                }
            },
            {
                "box": {
                    "id": "obj-deep",
                    "linepitchHz": 2,
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
                    "text": "pitchHz 850, decayMs 65, modeRatio 2.73, modeLevel 0.65, clickLevel 0.6, noiseDecayMs 4, filterHz 4200, filterQ 1.2, fmAmount 0.2, fmRatio 2, drive 1.8, level 0.45",
                    "varname": "rim_preset_deep"
                }
            },
            {
                "box": {
                    "id": "obj-knock",
                    "linepitchHz": 2,
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
                    "text": "pitchHz 570, decayMs 140, modeRatio 1.48, modeLevel 0.65, clickLevel 0.18, noiseDecayMs 4, filterHz 4200, filterQ 1.2, fmAmount 0, fmRatio 2, drive 1.1, level 0.45",
                    "varname": "rim_preset_knock"
                }
            },
            {
                "box": {
                    "id": "obj-hollow",
                    "linepitchHz": 2,
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
                    "text": "pitchHz 1650, decayMs 85, modeRatio 2.1, modeLevel 0.2, clickLevel 0.12, noiseDecayMs 4, filterHz 4200, filterQ 1.2, fmAmount 0, fmRatio 2, drive 1.8, level 0.45",
                    "varname": "rim_preset_hollow"
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
                    "text": "starting sounds: Rim / Wood / Clave"
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
                    "text": "r rnbo_rim_param"
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
                    "text": "parameter bus: pitchHz 850"
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
                        "title": "mlr-rim",
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
                                                "displayName": "filterQ",
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
                                    "text": "p @file rnbo_rim_voice"
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
                                    "linepitchHz": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        245,
                                        255,
                                        300,
                                        35
                                    ],
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_rim_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-pitchHz",
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
                                    "rnbo_uniqueid": "pitchHz",
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
                                    "text": "param pitchHz 850 @min 100 @max 6000 @unit Hz",
                                    "varname": "pitchHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-modeLevel",
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
                                    "rnbo_uniqueid": "modeLevel",
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
                                    "text": "param modeLevel 0.65 @min 0 @max 1",
                                    "varname": "modeLevel"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-clickLevel",
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
                                    "rnbo_uniqueid": "clickLevel",
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
                                    "text": "param clickLevel 0.6 @min 0 @max 1",
                                    "varname": "clickLevel"
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
                                    "text": "param decayMs 65 @min 1 @max 2000 @unit ms",
                                    "varname": "decayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-modeRatio",
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
                                    "rnbo_uniqueid": "modeRatio",
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
                                    "text": "param modeRatio 2.73 @min 1 @max 8",
                                    "varname": "modeRatio"
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
                                    "text": "param noiseDecayMs 4 @min 0.5 @max 300 @unit ms",
                                    "varname": "noiseDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-fmAmount",
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
                                    "rnbo_uniqueid": "fmAmount",
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
                                    "text": "param fmAmount 0.2 @min 0 @max 8",
                                    "varname": "fmAmount"
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
                                    "text": "param fmRatio 2 @min 0.25 @max 8",
                                    "varname": "fmRatio"
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
                                    "text": "param drive 1.8 @min 0.25 @max 8",
                                    "varname": "drive"
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
                                    "text": "param filterHz 4200 @min 200 @max 18000 @unit Hz",
                                    "varname": "filterHz"
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
                                    "text": "param filterQ 1.2 @min 0.5 @max 15",
                                    "varname": "filterQ"
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
                                        "rnbo-param-pitchHz",
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
                                        "rnbo-param-filterHz",
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
                                        "rnbo-param-filterQ",
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
                                        "rnbo-param-modeRatio",
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
                                        "rnbo-param-noiseDecayMs",
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
                                        "rnbo-param-modeLevel",
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
                                        "rnbo-param-clickLevel",
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
                                        "rnbo-param-fmRatio",
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
                                        "rnbo-param-fmAmount",
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
                        "clickLevel": {
                            "label": "clickLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.6
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.8
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.45
                        },
                        "modeRatio": {
                            "label": "modeRatio",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 2.73
                        },
                        "noiseDecayMs": {
                            "label": "noiseDecayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 4
                        },
                        "fmRatio": {
                            "label": "fmRatio",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 2
                        },
                        "filterQ": {
                            "label": "filterQ",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.2
                        },
                        "modeLevel": {
                            "label": "modeLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.65
                        },
                        "filterHz": {
                            "label": "filterHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 4200
                        },
                        "decayMs": {
                            "label": "decayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 65
                        },
                        "fmAmount": {
                            "label": "fmAmount",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.2
                        },
                        "pitchHz": {
                            "label": "pitchHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 850
                        }
                    },
                    "rnboversion": "1.4.5",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "rim_rnbo",
                            "parameter_modmode": 0,
                            "parameter_shortname": "rim_rnbo",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "optimization": "O1",
                        "parameter_enable": 1,
                        "uuid": "d1f3358e-fdc7-7843-1f23-07186f6095c0"
                    },
                    "text": "rnbo~ @title mlr-rim @dumpoutlet 1",
                    "varname": "rim_rnbo"
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
                    "text": "s~ rnbo_rim_left"
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
                    "text": "s~ rnbo_rim_right"
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
                    "linepitchHz": 2,
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
                    "text": "Rim"
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
                    "text": "Wood"
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
                    "text": "Clave"
                }
            },
            {
                "box": {
                    "id": "label-pitchHz",
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
                    "text": "Pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "control-pitchHz",
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
                    "varname": "rim_sound_pitchHz",
                    "minimum": 100,
                    "maximum": 6000
                }
            },
            {
                "box": {
                    "id": "label-modeLevel",
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
                        424,
                        245,
                        20
                    ],
                    "text": "Shell level"
                }
            },
            {
                "box": {
                    "id": "control-modeLevel",
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
                        447,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "rim_sound_modeLevel"
                }
            },
            {
                "box": {
                    "id": "label-clickLevel",
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
                        220,
                        245,
                        20
                    ],
                    "text": "Click level"
                }
            },
            {
                "box": {
                    "id": "control-clickLevel",
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
                        243,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "rim_sound_clickLevel"
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
                    "minimum": 1,
                    "maximum": 2000,
                    "varname": "rim_sound_decayMs"
                }
            },
            {
                "box": {
                    "id": "label-modeRatio",
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
                        356,
                        245,
                        20
                    ],
                    "text": "Shell ratio"
                }
            },
            {
                "box": {
                    "id": "control-modeRatio",
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
                        379,
                        245,
                        22
                    ],
                    "minimum": 1,
                    "maximum": 8,
                    "varname": "rim_sound_modeRatio"
                }
            },
            {
                "box": {
                    "id": "label-noiseDecayMs",
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
                        288,
                        245,
                        20
                    ],
                    "text": "Strike decay · ms"
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
                        1160,
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
                    "minimum": 0.5,
                    "maximum": 300,
                    "varname": "rim_sound_noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-fmAmount",
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
                        585,
                        220,
                        245,
                        20
                    ],
                    "text": "FM amount"
                }
            },
            {
                "box": {
                    "id": "control-fmAmount",
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
                        585,
                        243,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 8,
                    "varname": "rim_sound_fmAmount"
                }
            },
            {
                "box": {
                    "id": "label-fmRatio",
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
                        585,
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
                        1160,
                        262,
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
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "rim_sound_fmRatio"
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
                    "varname": "rim_sound_drive"
                }
            },
            {
                "box": {
                    "id": "label-filterHz",
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
                    "text": "Strike filter · Hz"
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
                    "minimum": 200,
                    "maximum": 18000,
                    "varname": "rim_sound_filterHz"
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
                        170,
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
                    "text": "Strike Q"
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
                        192,
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
                    "minimum": 0.5,
                    "maximum": 15,
                    "varname": "rim_sound_filterQ"
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
                    "varname": "rim_sound_level"
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
                    "text": "r rnbo_rim_repeat"
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
                    "linepitchHz": 2,
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
                    "presentation_linepitchHz": 2,
                    "presentation_rect": [
                        82,
                        532,
                        327,
                        33
                    ],
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_rim_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "rim-manual",
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
                    "id": "rim-manual-echo",
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
                    "text": "prepend rimManual"
                }
            },
            {
                "box": {
                    "id": "rim-router",
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
                    "id": "rim-route",
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
                    "text": "route pitchHz decayMs modeRatio modeLevel clickLevel noiseDecayMs filterHz filterQ fmAmount fmRatio drive level"
                }
            },
            {
                "box": {
                    "id": "rim-cache",
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
                    "text": "pak 850.0 65.0 2.73 0.65 0.6 4.0 4200.0 1.2 0.2 2.0 1.8 0.45"
                }
            },
            {
                "box": {
                    "id": "rim-unpack",
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
                    "id": "rim-pitch",
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
                    "text": "prepend pitchHz"
                }
            },
            {
                "box": {
                    "id": "rim-decay",
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
                    "id": "rim-fm",
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
                    "text": "prepend modeRatio"
                }
            },
            {
                "box": {
                    "id": "rim-owned",
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
                    "text": "r rnbo_rim_owned_param"
                }
            },
            {
                "box": {
                    "id": "rim-step",
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
                    "text": "r rnbo_rim_step"
                }
            },
            {
                "box": {
                    "id": "rim-step-unpack",
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
                    "id": "rim-fire",
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
                    "id": "rim-load",
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
                    "id": "rim-defer",
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
                    "id": "rim-sync",
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
                    "text": "rimSync"
                }
            },
            {
                "box": {
                    "id": "rim-values",
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
                    "text": "Grid mapping ranges · all twelve rim parameters"
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
                    "filename": "rim_lab_ranges.js",
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
                    "text": "v8 rim_lab_ranges.js",
                    "textfile": {
                        "filename": "rim_lab_ranges.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "rimPitch-range-label",
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
                    "text": "Pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "rimPitch-min-label",
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
                    "id": "rimPitch-min",
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
                    "varname": "rimPitch-min"
                }
            },
            {
                "box": {
                    "id": "rimPitch-min-pre",
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
                    "text": "prepend setrange rimPitch min"
                }
            },
            {
                "box": {
                    "id": "rimPitch-max-label",
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
                    "id": "rimPitch-max",
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
                    "varname": "rimPitch-max"
                }
            },
            {
                "box": {
                    "id": "rimPitch-max-pre",
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
                    "text": "prepend setrange rimPitch max"
                }
            },
            {
                "box": {
                    "id": "rimDecay-range-label",
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
                    "id": "rimDecay-min-label",
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
                    "id": "rimDecay-min",
                    "maxclass": "flonum",
                    "maximum": 2000,
                    "minimum": 1,
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
                    "varname": "rimDecay-min"
                }
            },
            {
                "box": {
                    "id": "rimDecay-min-pre",
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
                    "text": "prepend setrange rimDecay min"
                }
            },
            {
                "box": {
                    "id": "rimDecay-max-label",
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
                    "id": "rimDecay-max",
                    "maxclass": "flonum",
                    "maximum": 2000,
                    "minimum": 1,
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
                    "varname": "rimDecay-max"
                }
            },
            {
                "box": {
                    "id": "rimDecay-max-pre",
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
                    "text": "prepend setrange rimDecay max"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                    "text": "Shell ratio"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                    "format": 6,
                    "id": "rimModeRatio-min",
                    "maxclass": "flonum",
                    "maximum": 8,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
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
                    "varname": "rimModeRatio-min"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-min-pre",
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
                    "text": "prepend setrange rimModeRatio min"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                    "format": 6,
                    "id": "rimModeRatio-max",
                    "maxclass": "flonum",
                    "maximum": 8,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
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
                    "varname": "rimModeRatio-max"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-max-pre",
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
                    "text": "prepend setrange rimModeRatio max"
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
                    "text": "route rimPitch-min rimPitch-max rimDecay-min rimDecay-max rimModeRatio-min rimModeRatio-max rimModeLevel-min rimModeLevel-max rimClick-min rimClick-max rimNoiseDecay-min rimNoiseDecay-max rimFilterHz-min rimFilterHz-max rimFilterQ-min rimFilterQ-max rimFM-min rimFM-max rimRatio-min rimRatio-max rimDrive-min rimDrive-max rimLevel-min rimLevel-max"
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
                    "varname": "rim_grid_range_presets"
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
                    "id": "rim-param-rimModeLevel",
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
                    "text": "prepend modeLevel"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimClick",
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
                    "text": "prepend clickLevel"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimNoiseDecay",
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
                    "text": "prepend noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimFilterHz",
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
                    "text": "prepend filterHz"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimFilterQ",
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
                    "text": "prepend filterQ"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimFM",
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
                    "text": "prepend fmAmount"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimRatio",
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
                    "text": "prepend fmRatio"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimDrive",
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
                    "id": "rim-param-rimLevel",
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
                    "id": "rimModeLevel-range-label",
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
                    "text": "Shell level"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-min-label",
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
                    "id": "rimModeLevel-min",
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
                    "varname": "rimModeLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-min-pre",
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
                    "text": "prepend setrange rimModeLevel min"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-max-label",
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
                    "id": "rimModeLevel-max",
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
                    "varname": "rimModeLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-max-pre",
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
                    "text": "prepend setrange rimModeLevel max"
                }
            },
            {
                "box": {
                    "id": "rimClick-range-label",
                    "maxclass": "comment",
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
                    "text": "Click level"
                }
            },
            {
                "box": {
                    "id": "rimClick-min-label",
                    "maxclass": "comment",
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
                    "id": "rimClick-min",
                    "maxclass": "flonum",
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
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "rimClick-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimClick-min-pre",
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
                    "text": "prepend setrange rimClick min"
                }
            },
            {
                "box": {
                    "id": "rimClick-max-label",
                    "maxclass": "comment",
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
                    "id": "rimClick-max",
                    "maxclass": "flonum",
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
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "rimClick-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimClick-max-pre",
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
                    "text": "prepend setrange rimClick max"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-range-label",
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
                    "text": "Strike decay · ms"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-min-label",
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
                    "id": "rimNoiseDecay-min",
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
                    "minimum": 0.5,
                    "maximum": 300,
                    "varname": "rimNoiseDecay-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-min-pre",
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
                    "text": "prepend setrange rimNoiseDecay min"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-max-label",
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
                    "id": "rimNoiseDecay-max",
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
                    "minimum": 0.5,
                    "maximum": 300,
                    "varname": "rimNoiseDecay-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-max-pre",
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
                    "text": "prepend setrange rimNoiseDecay max"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-range-label",
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
                    "text": "Strike filter · Hz"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-min-label",
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
                    "id": "rimFilterHz-min",
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
                    "minimum": 200,
                    "maximum": 18000,
                    "varname": "rimFilterHz-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-min-pre",
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
                    "text": "prepend setrange rimFilterHz min"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-max-label",
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
                    "id": "rimFilterHz-max",
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
                    "minimum": 200,
                    "maximum": 18000,
                    "varname": "rimFilterHz-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-max-pre",
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
                    "text": "prepend setrange rimFilterHz max"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-range-label",
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
                    "text": "Strike Q"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-min-label",
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
                    "id": "rimFilterQ-min",
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
                    "minimum": 0.5,
                    "maximum": 15,
                    "varname": "rimFilterQ-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-min-pre",
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
                    "text": "prepend setrange rimFilterQ min"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-max-label",
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
                    "id": "rimFilterQ-max",
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
                    "minimum": 0.5,
                    "maximum": 15,
                    "varname": "rimFilterQ-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-max-pre",
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
                    "text": "prepend setrange rimFilterQ max"
                }
            },
            {
                "box": {
                    "id": "rimFM-range-label",
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
                    "text": "FM amount"
                }
            },
            {
                "box": {
                    "id": "rimFM-min-label",
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
                    "id": "rimFM-min",
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
                    "maximum": 8,
                    "varname": "rimFM-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimFM-min-pre",
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
                    "text": "prepend setrange rimFM min"
                }
            },
            {
                "box": {
                    "id": "rimFM-max-label",
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
                    "id": "rimFM-max",
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
                    "maximum": 8,
                    "varname": "rimFM-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimFM-max-pre",
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
                    "text": "prepend setrange rimFM max"
                }
            },
            {
                "box": {
                    "id": "rimRatio-range-label",
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
                    "text": "FM ratio"
                }
            },
            {
                "box": {
                    "id": "rimRatio-min-label",
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
                    "id": "rimRatio-min",
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
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "rimRatio-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimRatio-min-pre",
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
                    "text": "prepend setrange rimRatio min"
                }
            },
            {
                "box": {
                    "id": "rimRatio-max-label",
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
                    "id": "rimRatio-max",
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
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "rimRatio-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimRatio-max-pre",
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
                    "text": "prepend setrange rimRatio max"
                }
            },
            {
                "box": {
                    "id": "rimDrive-range-label",
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
                    "id": "rimDrive-min-label",
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
                    "id": "rimDrive-min",
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
                    "varname": "rimDrive-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimDrive-min-pre",
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
                    "text": "prepend setrange rimDrive min"
                }
            },
            {
                "box": {
                    "id": "rimDrive-max-label",
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
                    "id": "rimDrive-max",
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
                    "varname": "rimDrive-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimDrive-max-pre",
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
                    "text": "prepend setrange rimDrive max"
                }
            },
            {
                "box": {
                    "id": "rimLevel-range-label",
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
                    "id": "rimLevel-min-label",
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
                    "id": "rimLevel-min",
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
                    "varname": "rimLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimLevel-min-pre",
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
                    "text": "prepend setrange rimLevel min"
                }
            },
            {
                "box": {
                    "id": "rimLevel-max-label",
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
                    "id": "rimLevel-max",
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
                    "varname": "rimLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "rimLevel-max-pre",
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
                    "text": "prepend setrange rimLevel max"
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
                    "text": "Shell"
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
                    "text": "Strike"
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
                    "text": "Color / output"
                }
            },
            {
                "box": {
                    "id": "control-pitchHz-pre",
                    "maxclass": "newobj",
                    "text": "prepend pitchHz",
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
                    "id": "control-pitchHz-set",
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
                    "id": "control-modeRatio-pre",
                    "maxclass": "newobj",
                    "text": "prepend modeRatio",
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
                    "id": "control-modeRatio-set",
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
                    "id": "control-modeLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend modeLevel",
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
                    "id": "control-modeLevel-set",
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
                    "id": "control-clickLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend clickLevel",
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
                    "id": "control-clickLevel-set",
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
                    "id": "control-noiseDecayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend noiseDecayMs",
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
                    "id": "control-noiseDecayMs-set",
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
                    "id": "control-filterHz-pre",
                    "maxclass": "newobj",
                    "text": "prepend filterHz",
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
                    "id": "control-filterHz-set",
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
                    "id": "control-filterQ-pre",
                    "maxclass": "newobj",
                    "text": "prepend filterQ",
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
                    "id": "control-filterQ-set",
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
                    "id": "control-fmAmount-pre",
                    "maxclass": "newobj",
                    "text": "prepend fmAmount",
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
                    "id": "control-fmAmount-set",
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
                    "id": "control-fmRatio-pre",
                    "maxclass": "newobj",
                    "text": "prepend fmRatio",
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
                    "id": "control-fmRatio-set",
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
                    "id": "rim-ui-unpack",
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
                    "text": "dpt_rim_midi",
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
                        "rim-owned",
                        0
                    ],
                    "destination": [
                        "rim-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step",
                        0
                    ],
                    "destination": [
                        "rim-step-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        0
                    ],
                    "destination": [
                        "rim-cache",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        1
                    ],
                    "destination": [
                        "rim-cache",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        2
                    ],
                    "destination": [
                        "rim-cache",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        3
                    ],
                    "destination": [
                        "rim-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        4
                    ],
                    "destination": [
                        "rim-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        5
                    ],
                    "destination": [
                        "rim-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        6
                    ],
                    "destination": [
                        "rim-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        7
                    ],
                    "destination": [
                        "rim-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        8
                    ],
                    "destination": [
                        "rim-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        9
                    ],
                    "destination": [
                        "rim-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        10
                    ],
                    "destination": [
                        "rim-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-step-unpack",
                        11
                    ],
                    "destination": [
                        "rim-cache",
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
                        "rim-values",
                        1
                    ],
                    "source": [
                        "rim-cache",
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
                        "rim-decay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-sync",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "rim-defer",
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
                        "rim-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-values",
                        0
                    ],
                    "source": [
                        "rim-fire",
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
                        "rim-fire",
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
                        "rim-fm",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-cache",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "rim-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-defer",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "rim-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-manual-echo",
                        0
                    ],
                    "source": [
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-route",
                        0
                    ],
                    "source": [
                        "rim-manual",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-router",
                        0
                    ],
                    "source": [
                        "rim-manual-echo",
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
                        "rim-pitch",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-cache",
                        2
                    ],
                    "source": [
                        "rim-route",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-cache",
                        1
                    ],
                    "source": [
                        "rim-route",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-cache",
                        0
                    ],
                    "source": [
                        "rim-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-router",
                        0
                    ],
                    "source": [
                        "rim-sync",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-decay",
                        0
                    ],
                    "source": [
                        "rim-unpack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-fm",
                        0
                    ],
                    "source": [
                        "rim-unpack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-pitch",
                        0
                    ],
                    "source": [
                        "rim-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-unpack",
                        0
                    ],
                    "source": [
                        "rim-values",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rimDecay-max-pre",
                        0
                    ],
                    "source": [
                        "rimDecay-max",
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
                        "rimDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rimDecay-min-pre",
                        0
                    ],
                    "source": [
                        "rimDecay-min",
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
                        "rimDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rimModeRatio-max-pre",
                        0
                    ],
                    "source": [
                        "rimModeRatio-max",
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
                        "rimModeRatio-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rimModeRatio-min-pre",
                        0
                    ],
                    "source": [
                        "rimModeRatio-min",
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
                        "rimModeRatio-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rimPitch-max-pre",
                        0
                    ],
                    "source": [
                        "rimPitch-max",
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
                        "rimPitch-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rimPitch-min-pre",
                        0
                    ],
                    "source": [
                        "rimPitch-min",
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
                        "rimPitch-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "rim-manual",
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
                        "rim-manual",
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
                        "rim-manual",
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
                        "rim-manual",
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
                        "rim-fire",
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
                        "rimDecay-max",
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
                        "rimDecay-min",
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
                        "rimModeRatio-max",
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
                        "rimModeRatio-min",
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
                        "rimPitch-max",
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
                        "rimPitch-min",
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
                        "rimDecay-max",
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
                        "rimDecay-min",
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
                        "rimModeRatio-max",
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
                        "rimModeRatio-min",
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
                        "rimPitch-max",
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
                        "rimPitch-min",
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
                        "rim-route",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-route",
                        3
                    ],
                    "destination": [
                        "rim-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        3
                    ],
                    "destination": [
                        "rim-param-rimModeLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimModeLevel",
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
                        "rim-route",
                        4
                    ],
                    "destination": [
                        "rim-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        4
                    ],
                    "destination": [
                        "rim-param-rimClick",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimClick",
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
                        "rim-route",
                        5
                    ],
                    "destination": [
                        "rim-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        5
                    ],
                    "destination": [
                        "rim-param-rimNoiseDecay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimNoiseDecay",
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
                        "rim-route",
                        6
                    ],
                    "destination": [
                        "rim-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        6
                    ],
                    "destination": [
                        "rim-param-rimFilterHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimFilterHz",
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
                        "rim-route",
                        7
                    ],
                    "destination": [
                        "rim-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        7
                    ],
                    "destination": [
                        "rim-param-rimFilterQ",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimFilterQ",
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
                        "rim-route",
                        8
                    ],
                    "destination": [
                        "rim-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        8
                    ],
                    "destination": [
                        "rim-param-rimFM",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimFM",
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
                        "rim-route",
                        9
                    ],
                    "destination": [
                        "rim-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        9
                    ],
                    "destination": [
                        "rim-param-rimRatio",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimRatio",
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
                        "rim-route",
                        10
                    ],
                    "destination": [
                        "rim-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        10
                    ],
                    "destination": [
                        "rim-param-rimDrive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimDrive",
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
                        "rim-route",
                        11
                    ],
                    "destination": [
                        "rim-cache",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-unpack",
                        11
                    ],
                    "destination": [
                        "rim-param-rimLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-param-rimLevel",
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
                        "rimModeLevel-min",
                        0
                    ],
                    "destination": [
                        "rimModeLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimModeLevel-min-pre",
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
                        "rimModeLevel-min",
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
                        "rimModeLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimModeLevel-max",
                        0
                    ],
                    "destination": [
                        "rimModeLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimModeLevel-max-pre",
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
                        "rimModeLevel-max",
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
                        "rimModeLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimClick-min",
                        0
                    ],
                    "destination": [
                        "rimClick-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimClick-min-pre",
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
                        "rimClick-min",
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
                        "rimClick-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimClick-max",
                        0
                    ],
                    "destination": [
                        "rimClick-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimClick-max-pre",
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
                        "rimClick-max",
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
                        "rimClick-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimNoiseDecay-min",
                        0
                    ],
                    "destination": [
                        "rimNoiseDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimNoiseDecay-min-pre",
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
                        "rimNoiseDecay-min",
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
                        "rimNoiseDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimNoiseDecay-max",
                        0
                    ],
                    "destination": [
                        "rimNoiseDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimNoiseDecay-max-pre",
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
                        "rimNoiseDecay-max",
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
                        "rimNoiseDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterHz-min",
                        0
                    ],
                    "destination": [
                        "rimFilterHz-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterHz-min-pre",
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
                        "rimFilterHz-min",
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
                        "rimFilterHz-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterHz-max",
                        0
                    ],
                    "destination": [
                        "rimFilterHz-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterHz-max-pre",
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
                        "rimFilterHz-max",
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
                        "rimFilterHz-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterQ-min",
                        0
                    ],
                    "destination": [
                        "rimFilterQ-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterQ-min-pre",
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
                        "rimFilterQ-min",
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
                        "rimFilterQ-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterQ-max",
                        0
                    ],
                    "destination": [
                        "rimFilterQ-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFilterQ-max-pre",
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
                        "rimFilterQ-max",
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
                        "rimFilterQ-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFM-min",
                        0
                    ],
                    "destination": [
                        "rimFM-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFM-min-pre",
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
                        "rimFM-min",
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
                        "rimFM-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFM-max",
                        0
                    ],
                    "destination": [
                        "rimFM-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimFM-max-pre",
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
                        "rimFM-max",
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
                        "rimFM-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimRatio-min",
                        0
                    ],
                    "destination": [
                        "rimRatio-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimRatio-min-pre",
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
                        "rimRatio-min",
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
                        "rimRatio-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimRatio-max",
                        0
                    ],
                    "destination": [
                        "rimRatio-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimRatio-max-pre",
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
                        "rimRatio-max",
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
                        "rimRatio-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimDrive-min",
                        0
                    ],
                    "destination": [
                        "rimDrive-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimDrive-min-pre",
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
                        "rimDrive-min",
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
                        "rimDrive-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimDrive-max",
                        0
                    ],
                    "destination": [
                        "rimDrive-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimDrive-max-pre",
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
                        "rimDrive-max",
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
                        "rimDrive-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimLevel-min",
                        0
                    ],
                    "destination": [
                        "rimLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimLevel-min-pre",
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
                        "rimLevel-min",
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
                        "rimLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimLevel-max",
                        0
                    ],
                    "destination": [
                        "rimLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rimLevel-max-pre",
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
                        "rimLevel-max",
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
                        "rimLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-pitchHz",
                        0
                    ],
                    "destination": [
                        "control-pitchHz-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-pitchHz-pre",
                        0
                    ],
                    "destination": [
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        0
                    ],
                    "destination": [
                        "control-pitchHz-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-pitchHz-set",
                        0
                    ],
                    "destination": [
                        "control-pitchHz",
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
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
                        "control-modeRatio",
                        0
                    ],
                    "destination": [
                        "control-modeRatio-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-modeRatio-pre",
                        0
                    ],
                    "destination": [
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        2
                    ],
                    "destination": [
                        "control-modeRatio-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-modeRatio-set",
                        0
                    ],
                    "destination": [
                        "control-modeRatio",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-modeLevel",
                        0
                    ],
                    "destination": [
                        "control-modeLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-modeLevel-pre",
                        0
                    ],
                    "destination": [
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        3
                    ],
                    "destination": [
                        "control-modeLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-modeLevel-set",
                        0
                    ],
                    "destination": [
                        "control-modeLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-clickLevel",
                        0
                    ],
                    "destination": [
                        "control-clickLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-clickLevel-pre",
                        0
                    ],
                    "destination": [
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        4
                    ],
                    "destination": [
                        "control-clickLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-clickLevel-set",
                        0
                    ],
                    "destination": [
                        "control-clickLevel",
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        5
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        6
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        7
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
                        "control-fmAmount",
                        0
                    ],
                    "destination": [
                        "control-fmAmount-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmAmount-pre",
                        0
                    ],
                    "destination": [
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        8
                    ],
                    "destination": [
                        "control-fmAmount-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-fmAmount-set",
                        0
                    ],
                    "destination": [
                        "control-fmAmount",
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
                        9
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
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
                        "rim-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rim-ui-unpack",
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
                        "rim-cache",
                        0
                    ],
                    "destination": [
                        "rim-ui-unpack",
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
                        "rim-manual",
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
                        "rim-owned",
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
                        "rim-values",
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
                        "rim-cache",
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
                "rim_rnbo",
                "rim_rnbo",
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
