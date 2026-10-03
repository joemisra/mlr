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
                    "text": "RNBO snare laboratory"
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
                    "text": "Track 14 triggers the snare. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "snare_trigger"
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
                    "text": "r 15input"
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
                    "text": "r rnbo_snare_trigger"
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
                    "text": "bodyHz 205, bodyBend 80, noiseDecayMs 160, bodyDecayMs 120, bodyFM 0.25, noiseHz 5200, bodyLevel 0.6, noiseLevel 0.8, noiseQ 0.85, snap 0.75, drive 1.8, level 0.42",
                    "varname": "snare_preset_deep"
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
                    "text": "bodyHz 165, bodyBend 150, noiseDecayMs 210, bodyDecayMs 260, bodyFM 0.65, noiseHz 2500, bodyLevel 0.82, noiseLevel 0.48, noiseQ 2.5, snap 0.25, drive 2.2, level 0.42",
                    "varname": "snare_preset_knock"
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
                    "text": "bodyHz 120, bodyBend 60, noiseDecayMs 900, bodyDecayMs 500, bodyFM 3.2, noiseHz 7200, bodyLevel 0.35, noiseLevel 0.95, noiseQ 0.7, snap 0.85, drive 4, level 0.32",
                    "varname": "snare_preset_hollow"
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
                    "text": "presets: tight / wood / trash"
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
                    "text": "r rnbo_snare_param"
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
                    "text": "parameter bus format: bodyHz 180"
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
                        "title": "mlr-snare",
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
                                    "text": "p @file rnbo_snare_voice"
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
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_snare_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyHz",
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
                                    "rnbo_uniqueid": "bodyHz",
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
                                    "text": "param bodyHz 180 @min 40 @max 1200 @unit Hz",
                                    "varname": "bodyHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyBend",
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
                                    "rnbo_uniqueid": "bodyBend",
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
                                    "text": "param bodyBend 90 @min 0 @max 1200 @unit Hz",
                                    "varname": "bodyBend"
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
                                    "text": "param noiseDecayMs 260 @min 5 @max 10000 @unit ms",
                                    "varname": "noiseDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyDecayMs",
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
                                    "rnbo_uniqueid": "bodyDecayMs",
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
                                    "text": "param bodyDecayMs 180 @min 5 @max 5000 @unit ms",
                                    "varname": "bodyDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyFM",
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
                                        "unit": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 14,
                                    "rnbo_uniqueid": "bodyFM",
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
                                    "text": "param bodyFM 0.35 @min 0 @max 16",
                                    "varname": "bodyFM"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-noiseHz",
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
                                        "unit": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 6,
                                    "rnbo_uniqueid": "noiseHz",
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
                                    "text": "param noiseHz 3500 @min 100 @max 18000 @unit Hz",
                                    "varname": "noiseHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyLevel",
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
                                        "unit": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 7,
                                    "rnbo_uniqueid": "bodyLevel",
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
                                    "text": "param bodyLevel 0.65 @min 0 @max 1",
                                    "varname": "bodyLevel"
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
                                    "text": "param noiseLevel 0.72 @min 0 @max 1",
                                    "varname": "noiseLevel"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-noiseQ",
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
                                        "unit": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 9,
                                    "rnbo_uniqueid": "noiseQ",
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
                                    "text": "param noiseQ 1.1 @min 0.5 @max 20",
                                    "varname": "noiseQ"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-snap",
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
                                        "unit": "",
                                        "preset": 1,
                                        "displayorder": "-"
                                    },
                                    "rnbo_serial": 10,
                                    "rnbo_uniqueid": "snap",
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
                                    "text": "param snap 0.45 @min 0 @max 1",
                                    "varname": "snap"
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
                                        "unit": "",
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
                                    "text": "param drive 1.7 @min 0.25 @max 8",
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
                                        "unit": "",
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
                                        4
                                    ],
                                    "source": [
                                        "rnbo-param-bodyDecayMs",
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
                                        "rnbo-param-bodyHz",
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
                                        "rnbo-param-snap",
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
                                        "rnbo-param-bodyFM",
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
                                        "rnbo-param-noiseHz",
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
                                        "rnbo-param-bodyBend",
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
                                        "rnbo-param-bodyLevel",
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
                                        "rnbo-param-noiseQ",
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
                            "value": 260
                        },
                        "noiseQ": {
                            "label": "noiseQ",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.1
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.45
                        },
                        "bodyFM": {
                            "label": "bodyFM",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.35
                        },
                        "noiseHz": {
                            "label": "noiseHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 3500
                        },
                        "noiseLevel": {
                            "label": "noiseLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.72
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.7
                        },
                        "bodyBend": {
                            "label": "bodyBend",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 90
                        },
                        "snap": {
                            "label": "snap",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.45
                        },
                        "bodyDecayMs": {
                            "label": "bodyDecayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 180
                        },
                        "bodyLevel": {
                            "label": "bodyLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.65
                        },
                        "bodyHz": {
                            "label": "bodyHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 180
                        }
                    },
                    "rnboversion": "1.4.5",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "snare_rnbo",
                            "parameter_modmode": 0,
                            "parameter_shortname": "snare_rnbo",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "optimization": "O1",
                        "parameter_enable": 1,
                        "uuid": "4f2bd0ce-f5ac-4c0a-8d02-7ddd3fb4347f"
                    },
                    "snapshot": {
                        "filetype": "C74Snapshot",
                        "version": 2,
                        "minorversion": 0,
                        "name": "snapshotlist",
                        "origin": "rnbo~",
                        "type": "list",
                        "subtype": "Undefined",
                        "embed": 1,
                        "snapshot": {
                            "level": {
                                "value": 0.45
                            },
                            "drive": {
                                "value": 1.7
                            },
                            "bodyBend": {
                                "value": 90
                            },
                            "bodyLevel": {
                                "value": 0.65
                            },
                            "noiseHz": {
                                "value": 3500
                            },
                            "bodyFM": {
                                "value": 0.35
                            },
                            "bodyDecayMs": {
                                "value": 180
                            },
                            "snap": {
                                "value": 0.45
                            },
                            "noiseQ": {
                                "value": 1.1
                            },
                            "__presetid": "mlr-snare",
                            "noiseDecayMs": {
                                "value": 260
                            },
                            "__sps": {
                                "p_rnbo-voice": {}
                            },
                            "bodyHz": {
                                "value": 180
                            },
                            "noiseLevel": {
                                "value": 0.72
                            }
                        },
                        "snapshotlist": {
                            "current_snapshot": 0,
                            "entries": [
                                {
                                    "filetype": "C74Snapshot",
                                    "version": 2,
                                    "minorversion": 0,
                                    "name": "mlr-snare",
                                    "origin": "mlr-snare",
                                    "type": "rnbo",
                                    "subtype": "",
                                    "embed": 0,
                                    "snapshot": {
                                        "level": {
                                            "value": 0.45
                                        },
                                        "drive": {
                                            "value": 1.7
                                        },
                                        "bodyBend": {
                                            "value": 90
                                        },
                                        "bodyLevel": {
                                            "value": 0.65
                                        },
                                        "noiseHz": {
                                            "value": 3500
                                        },
                                        "bodyFM": {
                                            "value": 0.35
                                        },
                                        "bodyDecayMs": {
                                            "value": 180
                                        },
                                        "snap": {
                                            "value": 0.45
                                        },
                                        "noiseQ": {
                                            "value": 1.1
                                        },
                                        "__presetid": "mlr-snare",
                                        "noiseDecayMs": {
                                            "value": 260
                                        },
                                        "__sps": {
                                            "p_rnbo-voice": {}
                                        },
                                        "bodyHz": {
                                            "value": 180
                                        },
                                        "noiseLevel": {
                                            "value": 0.72
                                        }
                                    },
                                    "fileref": {
                                        "name": "mlr-snare",
                                        "filename": "mlr-snare.maxsnap",
                                        "filepath": "~/Music/Max 9/Snapshots",
                                        "filepos": -1,
                                        "snapshotfileid": "817b96de1ddf7d24b58b2be6231ba5ce"
                                    }
                                }
                            ]
                        }
                    },
                    "text": "rnbo~ @title mlr-snare @dumpoutlet 1",
                    "varname": "snare_rnbo"
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
                    "text": "s~ rnbo_snare_left"
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
                    "text": "s~ rnbo_snare_right"
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
                    "text": "Tight"
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
                    "text": "Trash"
                }
            },
            {
                "box": {
                    "id": "label-bodyHz",
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
                    "text": "Body Hz"
                }
            },
            {
                "box": {
                    "id": "control-bodyHz",
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
                    "varname": "snare_sound_bodyHz",
                    "minimum": 40,
                    "maximum": 1200
                }
            },
            {
                "box": {
                    "id": "label-bodyBend",
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
                        288,
                        245,
                        20
                    ],
                    "text": "Body bend Hz"
                }
            },
            {
                "box": {
                    "id": "control-bodyBend",
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
                        311,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1200,
                    "varname": "snare_sound_bodyBend"
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
                        25,
                        356,
                        245,
                        20
                    ],
                    "text": "Noise decay ms"
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
                        25,
                        379,
                        245,
                        22
                    ],
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "snare_sound_noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-bodyDecayMs",
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
                        424,
                        245,
                        20
                    ],
                    "text": "Body decay ms"
                }
            },
            {
                "box": {
                    "id": "control-bodyDecayMs",
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
                        447,
                        245,
                        22
                    ],
                    "minimum": 5,
                    "maximum": 5000,
                    "varname": "snare_sound_bodyDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-bodyFM",
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
                    "text": "Body FM"
                }
            },
            {
                "box": {
                    "id": "control-bodyFM",
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
                    "maximum": 16,
                    "varname": "snare_sound_bodyFM"
                }
            },
            {
                "box": {
                    "id": "label-noiseHz",
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
                    "text": "Noise filter Hz"
                }
            },
            {
                "box": {
                    "id": "control-noiseHz",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "snare_sound_noiseHz"
                }
            },
            {
                "box": {
                    "id": "label-bodyLevel",
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
                        305,
                        356,
                        245,
                        20
                    ],
                    "text": "Body level"
                }
            },
            {
                "box": {
                    "id": "control-bodyLevel",
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
                        305,
                        379,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "snare_sound_bodyLevel"
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
                    "varname": "snare_sound_noiseLevel"
                }
            },
            {
                "box": {
                    "id": "label-noiseQ",
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
                        220,
                        245,
                        20
                    ],
                    "text": "Noise Q"
                }
            },
            {
                "box": {
                    "id": "control-noiseQ",
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
                        243,
                        245,
                        22
                    ],
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "snare_sound_noiseQ"
                }
            },
            {
                "box": {
                    "id": "label-snap",
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
                        288,
                        245,
                        20
                    ],
                    "text": "Snap"
                }
            },
            {
                "box": {
                    "id": "control-snap",
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
                        311,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "snare_sound_snap"
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
                    "varname": "snare_sound_drive"
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
                    "varname": "snare_sound_level"
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
                    "text": "r rnbo_snare_repeat"
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
                    "text": "Global audio on/off. Combined lab selects Stereo or 6mix."
                }
            },
            {
                "box": {
                    "id": "snare-manual",
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
                    "id": "snare-manual-echo",
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
                    "text": "prepend snareManual"
                }
            },
            {
                "box": {
                    "id": "snare-router",
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
                    "id": "snare-route",
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
                    "text": "route bodyHz bodyDecayMs bodyFM bodyBend noiseDecayMs noiseHz snap drive bodyLevel noiseLevel noiseQ level"
                }
            },
            {
                "box": {
                    "id": "snare-cache",
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
                    "text": "pak 180.0 180.0 0.35 90.0 260.0 3500.0 0.45 1.7 0.65 0.72 1.1 0.45"
                }
            },
            {
                "box": {
                    "id": "snare-unpack",
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
                    "id": "snare-pitch",
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
                    "text": "prepend bodyHz"
                }
            },
            {
                "box": {
                    "id": "snare-decay",
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
                    "text": "prepend bodyDecayMs"
                }
            },
            {
                "box": {
                    "id": "snare-fm",
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
                    "text": "prepend bodyFM"
                }
            },
            {
                "box": {
                    "id": "snare-owned",
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
                    "text": "r rnbo_snare_owned_param"
                }
            },
            {
                "box": {
                    "id": "snare-step",
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
                    "text": "r rnbo_snare_step"
                }
            },
            {
                "box": {
                    "id": "snare-step-unpack",
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
                    "id": "snare-fire",
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
                    "id": "snare-load",
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
                    "id": "snare-defer",
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
                    "id": "snare-sync",
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
                    "text": "snareSync"
                }
            },
            {
                "box": {
                    "id": "snare-values",
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
                    "text": "Grid mapping ranges · all twelve snare parameters"
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
                    "text": "Min / Max prepares grid spans for later sequencer integration. Sound controls keep the full engine limits."
                }
            },
            {
                "box": {
                    "filename": "snare_lab_ranges.js",
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
                    "text": "v8 snare_lab_ranges.js",
                    "textfile": {
                        "filename": "snare_lab_ranges.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-range-label",
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
                    "text": "Body pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-min-label",
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
                    "id": "snareBodyHz-min",
                    "maxclass": "flonum",
                    "maximum": 1200,
                    "minimum": 40,
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
                    "varname": "snareBodyHz-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-min-pre",
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
                    "text": "prepend setrange snareBodyHz min"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-max-label",
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
                    "id": "snareBodyHz-max",
                    "maxclass": "flonum",
                    "maximum": 1200,
                    "minimum": 40,
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
                    "varname": "snareBodyHz-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-max-pre",
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
                    "text": "prepend setrange snareBodyHz max"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-range-label",
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
                    "text": "Body decay · ms"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-min-label",
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
                    "id": "snareBodyDecay-min",
                    "maxclass": "flonum",
                    "maximum": 5000,
                    "minimum": 5,
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
                    "varname": "snareBodyDecay-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-min-pre",
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
                    "text": "prepend setrange snareBodyDecay min"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-max-label",
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
                    "id": "snareBodyDecay-max",
                    "maxclass": "flonum",
                    "maximum": 5000,
                    "minimum": 5,
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
                    "varname": "snareBodyDecay-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-max-pre",
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
                    "text": "prepend setrange snareBodyDecay max"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-range-label",
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
                    "text": "Body FM"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-min-label",
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
                    "id": "snareBodyFM-min",
                    "maxclass": "flonum",
                    "maximum": 16,
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
                    "varname": "snareBodyFM-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-min-pre",
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
                    "text": "prepend setrange snareBodyFM min"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-max-label",
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
                    "id": "snareBodyFM-max",
                    "maxclass": "flonum",
                    "maximum": 16,
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
                    "varname": "snareBodyFM-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-max-pre",
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
                    "text": "prepend setrange snareBodyFM max"
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
                    "text": "route snareBodyHz-min snareBodyHz-max snareBodyDecay-min snareBodyDecay-max snareBodyFM-min snareBodyFM-max snareBodyBend-min snareBodyBend-max snareNoiseDecay-min snareNoiseDecay-max snareNoiseHz-min snareNoiseHz-max snareSnap-min snareSnap-max snareDrive-min snareDrive-max snareBodyLevel-min snareBodyLevel-max snareNoiseLevel-min snareNoiseLevel-max snareNoiseQ-min snareNoiseQ-max snareLevel-min snareLevel-max"
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
                    "varname": "snare_grid_range_presets"
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
                    "id": "snare-param-snareBodyBend",
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
                    "text": "prepend bodyBend"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareNoiseDecay",
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
                    "id": "snare-param-snareNoiseHz",
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
                    "text": "prepend noiseHz"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareSnap",
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
                    "text": "prepend snap"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareDrive",
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
                    "id": "snare-param-snareBodyLevel",
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
                    "text": "prepend bodyLevel"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareNoiseLevel",
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
                    "id": "snare-param-snareNoiseQ",
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
                    "text": "prepend noiseQ"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareLevel",
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
                    "id": "snareBodyBend-range-label",
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
                    "text": "Body bend · Hz"
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-min-label",
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
                    "id": "snareBodyBend-min",
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
                    "maximum": 1200,
                    "varname": "snareBodyBend-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-min-pre",
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
                    "text": "prepend setrange snareBodyBend min"
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-max-label",
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
                    "id": "snareBodyBend-max",
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
                    "maximum": 1200,
                    "varname": "snareBodyBend-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-max-pre",
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
                    "text": "prepend setrange snareBodyBend max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-range-label",
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
                    "text": "Noise decay · ms"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-min-label",
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
                    "id": "snareNoiseDecay-min",
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
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "snareNoiseDecay-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-min-pre",
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
                    "text": "prepend setrange snareNoiseDecay min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-max-label",
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
                    "id": "snareNoiseDecay-max",
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
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "snareNoiseDecay-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-max-pre",
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
                    "text": "prepend setrange snareNoiseDecay max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-range-label",
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
                    "text": "Noise frequency · Hz"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-min-label",
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
                    "id": "snareNoiseHz-min",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "snareNoiseHz-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-min-pre",
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
                    "text": "prepend setrange snareNoiseHz min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-max-label",
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
                    "id": "snareNoiseHz-max",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "snareNoiseHz-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-max-pre",
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
                    "text": "prepend setrange snareNoiseHz max"
                }
            },
            {
                "box": {
                    "id": "snareSnap-range-label",
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
                    "text": "Snap"
                }
            },
            {
                "box": {
                    "id": "snareSnap-min-label",
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
                    "id": "snareSnap-min",
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
                    "varname": "snareSnap-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareSnap-min-pre",
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
                    "text": "prepend setrange snareSnap min"
                }
            },
            {
                "box": {
                    "id": "snareSnap-max-label",
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
                    "id": "snareSnap-max",
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
                    "varname": "snareSnap-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareSnap-max-pre",
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
                    "text": "prepend setrange snareSnap max"
                }
            },
            {
                "box": {
                    "id": "snareDrive-range-label",
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
                    "text": "Drive"
                }
            },
            {
                "box": {
                    "id": "snareDrive-min-label",
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
                    "id": "snareDrive-min",
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
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "snareDrive-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareDrive-min-pre",
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
                    "text": "prepend setrange snareDrive min"
                }
            },
            {
                "box": {
                    "id": "snareDrive-max-label",
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
                    "id": "snareDrive-max",
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
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "snareDrive-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareDrive-max-pre",
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
                    "text": "prepend setrange snareDrive max"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-range-label",
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
                    "text": "Body level"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-min-label",
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
                    "id": "snareBodyLevel-min",
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
                    "varname": "snareBodyLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-min-pre",
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
                    "text": "prepend setrange snareBodyLevel min"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-max-label",
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
                    "id": "snareBodyLevel-max",
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
                    "varname": "snareBodyLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-max-pre",
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
                    "text": "prepend setrange snareBodyLevel max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-range-label",
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
                    "text": "Noise level"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-min-label",
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
                    "id": "snareNoiseLevel-min",
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
                    "varname": "snareNoiseLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-min-pre",
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
                    "text": "prepend setrange snareNoiseLevel min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-max-label",
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
                    "id": "snareNoiseLevel-max",
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
                    "varname": "snareNoiseLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-max-pre",
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
                    "text": "prepend setrange snareNoiseLevel max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-range-label",
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
                    "text": "Noise Q"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-min-label",
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
                    "id": "snareNoiseQ-min",
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
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "snareNoiseQ-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-min-pre",
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
                    "text": "prepend setrange snareNoiseQ min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-max-label",
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
                    "id": "snareNoiseQ-max",
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
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "snareNoiseQ-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-max-pre",
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
                    "text": "prepend setrange snareNoiseQ max"
                }
            },
            {
                "box": {
                    "id": "snareLevel-range-label",
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
                    "id": "snareLevel-min-label",
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
                    "id": "snareLevel-min",
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
                    "varname": "snareLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareLevel-min-pre",
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
                    "text": "prepend setrange snareLevel min"
                }
            },
            {
                "box": {
                    "id": "snareLevel-max-label",
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
                    "id": "snareLevel-max",
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
                    "varname": "snareLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "snareLevel-max-pre",
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
                    "text": "prepend setrange snareLevel max"
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
                    "text": "Body"
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
                    "text": "Noise"
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
                    "id": "control-bodyHz-pre",
                    "maxclass": "newobj",
                    "text": "prepend bodyHz",
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
                    "id": "control-bodyHz-set",
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
                    "id": "control-bodyDecayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend bodyDecayMs",
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
                    "id": "control-bodyDecayMs-set",
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
                    "id": "control-bodyFM-pre",
                    "maxclass": "newobj",
                    "text": "prepend bodyFM",
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
                    "id": "control-bodyFM-set",
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
                    "id": "control-bodyBend-pre",
                    "maxclass": "newobj",
                    "text": "prepend bodyBend",
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
                    "id": "control-bodyBend-set",
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
                    "id": "control-noiseHz-pre",
                    "maxclass": "newobj",
                    "text": "prepend noiseHz",
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
                    "id": "control-noiseHz-set",
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
                    "id": "control-snap-pre",
                    "maxclass": "newobj",
                    "text": "prepend snap",
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
                    "id": "control-snap-set",
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
                    "id": "control-bodyLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend bodyLevel",
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
                    "id": "control-bodyLevel-set",
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
                    "id": "control-noiseQ-pre",
                    "maxclass": "newobj",
                    "text": "prepend noiseQ",
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
                    "id": "control-noiseQ-set",
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
                    "id": "snare-ui-unpack",
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
                    "text": "dpt_snare_midi",
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
                        "snare-owned",
                        0
                    ],
                    "destination": [
                        "snare-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step",
                        0
                    ],
                    "destination": [
                        "snare-step-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        0
                    ],
                    "destination": [
                        "snare-cache",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        1
                    ],
                    "destination": [
                        "snare-cache",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        2
                    ],
                    "destination": [
                        "snare-cache",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        3
                    ],
                    "destination": [
                        "snare-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        4
                    ],
                    "destination": [
                        "snare-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        5
                    ],
                    "destination": [
                        "snare-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        6
                    ],
                    "destination": [
                        "snare-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        7
                    ],
                    "destination": [
                        "snare-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        8
                    ],
                    "destination": [
                        "snare-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        9
                    ],
                    "destination": [
                        "snare-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        10
                    ],
                    "destination": [
                        "snare-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-step-unpack",
                        11
                    ],
                    "destination": [
                        "snare-cache",
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
                        "snare-values",
                        1
                    ],
                    "source": [
                        "snare-cache",
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
                        "snare-decay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-sync",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "snare-defer",
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
                        "snare-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-values",
                        0
                    ],
                    "source": [
                        "snare-fire",
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
                        "snare-fire",
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
                        "snare-fm",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-cache",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "snare-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-defer",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "snare-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-manual-echo",
                        0
                    ],
                    "source": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-route",
                        0
                    ],
                    "source": [
                        "snare-manual",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-router",
                        0
                    ],
                    "source": [
                        "snare-manual-echo",
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
                        "snare-pitch",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-cache",
                        2
                    ],
                    "source": [
                        "snare-route",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-cache",
                        1
                    ],
                    "source": [
                        "snare-route",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-cache",
                        0
                    ],
                    "source": [
                        "snare-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-router",
                        0
                    ],
                    "source": [
                        "snare-sync",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-decay",
                        0
                    ],
                    "source": [
                        "snare-unpack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-fm",
                        0
                    ],
                    "source": [
                        "snare-unpack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-pitch",
                        0
                    ],
                    "source": [
                        "snare-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-unpack",
                        0
                    ],
                    "source": [
                        "snare-values",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snareBodyDecay-max-pre",
                        0
                    ],
                    "source": [
                        "snareBodyDecay-max",
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
                        "snareBodyDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snareBodyDecay-min-pre",
                        0
                    ],
                    "source": [
                        "snareBodyDecay-min",
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
                        "snareBodyDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snareBodyFM-max-pre",
                        0
                    ],
                    "source": [
                        "snareBodyFM-max",
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
                        "snareBodyFM-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snareBodyFM-min-pre",
                        0
                    ],
                    "source": [
                        "snareBodyFM-min",
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
                        "snareBodyFM-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snareBodyHz-max-pre",
                        0
                    ],
                    "source": [
                        "snareBodyHz-max",
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
                        "snareBodyHz-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snareBodyHz-min-pre",
                        0
                    ],
                    "source": [
                        "snareBodyHz-min",
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
                        "snareBodyHz-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "snare-manual",
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
                        "snare-manual",
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
                        "snare-manual",
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
                        "snare-manual",
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
                        "snare-fire",
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
                        "snareBodyDecay-max",
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
                        "snareBodyDecay-min",
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
                        "snareBodyFM-max",
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
                        "snareBodyFM-min",
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
                        "snareBodyHz-max",
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
                        "snareBodyHz-min",
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
                        "snareBodyDecay-max",
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
                        "snareBodyDecay-min",
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
                        "snareBodyFM-max",
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
                        "snareBodyFM-min",
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
                        "snareBodyHz-max",
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
                        "snareBodyHz-min",
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
                        "snare-route",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-route",
                        3
                    ],
                    "destination": [
                        "snare-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        3
                    ],
                    "destination": [
                        "snare-param-snareBodyBend",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareBodyBend",
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
                        "snare-route",
                        4
                    ],
                    "destination": [
                        "snare-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        4
                    ],
                    "destination": [
                        "snare-param-snareNoiseDecay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareNoiseDecay",
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
                        "snare-route",
                        5
                    ],
                    "destination": [
                        "snare-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        5
                    ],
                    "destination": [
                        "snare-param-snareNoiseHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareNoiseHz",
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
                        "snare-route",
                        6
                    ],
                    "destination": [
                        "snare-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        6
                    ],
                    "destination": [
                        "snare-param-snareSnap",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareSnap",
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
                        "snare-route",
                        7
                    ],
                    "destination": [
                        "snare-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        7
                    ],
                    "destination": [
                        "snare-param-snareDrive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareDrive",
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
                        "snare-route",
                        8
                    ],
                    "destination": [
                        "snare-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        8
                    ],
                    "destination": [
                        "snare-param-snareBodyLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareBodyLevel",
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
                        "snare-route",
                        9
                    ],
                    "destination": [
                        "snare-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        9
                    ],
                    "destination": [
                        "snare-param-snareNoiseLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareNoiseLevel",
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
                        "snare-route",
                        10
                    ],
                    "destination": [
                        "snare-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        10
                    ],
                    "destination": [
                        "snare-param-snareNoiseQ",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareNoiseQ",
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
                        "snare-route",
                        11
                    ],
                    "destination": [
                        "snare-cache",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-unpack",
                        11
                    ],
                    "destination": [
                        "snare-param-snareLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-param-snareLevel",
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
                        "snareBodyBend-min",
                        0
                    ],
                    "destination": [
                        "snareBodyBend-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyBend-min-pre",
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
                        "snareBodyBend-min",
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
                        "snareBodyBend-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyBend-max",
                        0
                    ],
                    "destination": [
                        "snareBodyBend-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyBend-max-pre",
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
                        "snareBodyBend-max",
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
                        "snareBodyBend-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseDecay-min",
                        0
                    ],
                    "destination": [
                        "snareNoiseDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseDecay-min-pre",
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
                        "snareNoiseDecay-min",
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
                        "snareNoiseDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseDecay-max",
                        0
                    ],
                    "destination": [
                        "snareNoiseDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseDecay-max-pre",
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
                        "snareNoiseDecay-max",
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
                        "snareNoiseDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseHz-min",
                        0
                    ],
                    "destination": [
                        "snareNoiseHz-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseHz-min-pre",
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
                        "snareNoiseHz-min",
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
                        "snareNoiseHz-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseHz-max",
                        0
                    ],
                    "destination": [
                        "snareNoiseHz-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseHz-max-pre",
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
                        "snareNoiseHz-max",
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
                        "snareNoiseHz-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareSnap-min",
                        0
                    ],
                    "destination": [
                        "snareSnap-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareSnap-min-pre",
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
                        "snareSnap-min",
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
                        "snareSnap-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareSnap-max",
                        0
                    ],
                    "destination": [
                        "snareSnap-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareSnap-max-pre",
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
                        "snareSnap-max",
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
                        "snareSnap-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareDrive-min",
                        0
                    ],
                    "destination": [
                        "snareDrive-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareDrive-min-pre",
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
                        "snareDrive-min",
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
                        "snareDrive-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareDrive-max",
                        0
                    ],
                    "destination": [
                        "snareDrive-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareDrive-max-pre",
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
                        "snareDrive-max",
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
                        "snareDrive-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyLevel-min",
                        0
                    ],
                    "destination": [
                        "snareBodyLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyLevel-min-pre",
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
                        "snareBodyLevel-min",
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
                        "snareBodyLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyLevel-max",
                        0
                    ],
                    "destination": [
                        "snareBodyLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareBodyLevel-max-pre",
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
                        "snareBodyLevel-max",
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
                        "snareBodyLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseLevel-min",
                        0
                    ],
                    "destination": [
                        "snareNoiseLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseLevel-min-pre",
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
                        "snareNoiseLevel-min",
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
                        "snareNoiseLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseLevel-max",
                        0
                    ],
                    "destination": [
                        "snareNoiseLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseLevel-max-pre",
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
                        "snareNoiseLevel-max",
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
                        "snareNoiseLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseQ-min",
                        0
                    ],
                    "destination": [
                        "snareNoiseQ-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseQ-min-pre",
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
                        "snareNoiseQ-min",
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
                        "snareNoiseQ-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseQ-max",
                        0
                    ],
                    "destination": [
                        "snareNoiseQ-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareNoiseQ-max-pre",
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
                        "snareNoiseQ-max",
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
                        "snareNoiseQ-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareLevel-min",
                        0
                    ],
                    "destination": [
                        "snareLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareLevel-min-pre",
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
                        "snareLevel-min",
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
                        "snareLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareLevel-max",
                        0
                    ],
                    "destination": [
                        "snareLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snareLevel-max-pre",
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
                        "snareLevel-max",
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
                        "snareLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyHz",
                        0
                    ],
                    "destination": [
                        "control-bodyHz-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyHz-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        0
                    ],
                    "destination": [
                        "control-bodyHz-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyHz-set",
                        0
                    ],
                    "destination": [
                        "control-bodyHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyDecayMs",
                        0
                    ],
                    "destination": [
                        "control-bodyDecayMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyDecayMs-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        1
                    ],
                    "destination": [
                        "control-bodyDecayMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyDecayMs-set",
                        0
                    ],
                    "destination": [
                        "control-bodyDecayMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyFM",
                        0
                    ],
                    "destination": [
                        "control-bodyFM-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyFM-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        2
                    ],
                    "destination": [
                        "control-bodyFM-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyFM-set",
                        0
                    ],
                    "destination": [
                        "control-bodyFM",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyBend",
                        0
                    ],
                    "destination": [
                        "control-bodyBend-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyBend-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        3
                    ],
                    "destination": [
                        "control-bodyBend-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyBend-set",
                        0
                    ],
                    "destination": [
                        "control-bodyBend",
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
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
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
                        "control-noiseHz",
                        0
                    ],
                    "destination": [
                        "control-noiseHz-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseHz-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        5
                    ],
                    "destination": [
                        "control-noiseHz-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseHz-set",
                        0
                    ],
                    "destination": [
                        "control-noiseHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-snap",
                        0
                    ],
                    "destination": [
                        "control-snap-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-snap-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        6
                    ],
                    "destination": [
                        "control-snap-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-snap-set",
                        0
                    ],
                    "destination": [
                        "control-snap",
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
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
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
                        "control-bodyLevel",
                        0
                    ],
                    "destination": [
                        "control-bodyLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyLevel-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        8
                    ],
                    "destination": [
                        "control-bodyLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-bodyLevel-set",
                        0
                    ],
                    "destination": [
                        "control-bodyLevel",
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
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
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
                        "control-noiseQ",
                        0
                    ],
                    "destination": [
                        "control-noiseQ-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseQ-pre",
                        0
                    ],
                    "destination": [
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
                        10
                    ],
                    "destination": [
                        "control-noiseQ-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-noiseQ-set",
                        0
                    ],
                    "destination": [
                        "control-noiseQ",
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
                        "snare-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snare-ui-unpack",
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
                        "snare-cache",
                        0
                    ],
                    "destination": [
                        "snare-ui-unpack",
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
                        "snare-manual",
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
                        "snare-owned",
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
                        "snare-values",
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
                        "snare-cache",
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
                "snare_rnbo",
                "snare_rnbo",
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
