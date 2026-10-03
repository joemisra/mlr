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
                    "text": "RNBO clap laboratory"
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
                    "text": "Track 12 triggers the clap. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "clap_trigger"
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
                    "text": "r 13input"
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
                    "text": "r rnbo_clap_trigger"
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
                    "text": "count 3, burstDecayMs 10, spacingMs 12, scatter 0, tailDecayMs 160, filterHz 1600, brightness 0.2, drive 1.5, balance 0.45, tailLevel 0.65, filterQ 1.1, level 0.5",
                    "varname": "clap_preset_deep"
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
                    "text": "count 5, burstDecayMs 16, spacingMs 17, scatter 0.65, tailDecayMs 450, filterHz 1200, brightness 0.2, drive 1.5, balance 0.45, tailLevel 0.65, filterQ 1.1, level 0.5",
                    "varname": "clap_preset_knock"
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
                    "text": "count 4, burstDecayMs 10, spacingMs 28, scatter 0.15, tailDecayMs 1800, filterHz 2600, brightness 0.45, drive 1.5, balance 0.75, tailLevel 0.9, filterQ 1.1, level 0.5",
                    "varname": "clap_preset_hollow"
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
                    "text": "starting sounds: tight / hands / wash"
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
                    "text": "r rnbo_clap_param"
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
                    "text": "parameter bus format: spacingMs 15"
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
                        "title": "mlr-clap",
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
                                    "text": "p @file rnbo_clap_voice"
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
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_clap_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-count",
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
                                    "rnbo_uniqueid": "count",
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
                                    "text": "param count 3 @min 1 @max 8",
                                    "varname": "count"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-scatter",
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
                                    "rnbo_uniqueid": "scatter",
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
                                    "text": "param scatter 0.15 @min 0 @max 1",
                                    "varname": "scatter"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-tailDecayMs",
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
                                    "rnbo_uniqueid": "tailDecayMs",
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
                                    "text": "param tailDecayMs 280 @min 5 @max 10000 @unit ms",
                                    "varname": "tailDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-burstDecayMs",
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
                                    "rnbo_uniqueid": "burstDecayMs",
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
                                    "text": "param burstDecayMs 10 @min 1 @max 200 @unit ms",
                                    "varname": "burstDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-spacingMs",
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
                                    "rnbo_uniqueid": "spacingMs",
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
                                    "text": "param spacingMs 12 @min 2 @max 100 @unit ms",
                                    "varname": "spacingMs"
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
                                    "text": "param filterHz 1600 @min 100 @max 18000 @unit Hz",
                                    "varname": "filterHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-balance",
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
                                    "rnbo_uniqueid": "balance",
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
                                    "text": "param balance 0.45 @min 0 @max 1",
                                    "varname": "balance"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-tailLevel",
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
                                    "rnbo_uniqueid": "tailLevel",
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
                                    "text": "param tailLevel 0.65 @min 0 @max 1",
                                    "varname": "tailLevel"
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
                                    "text": "param filterQ 1.1 @min 0.5 @max 20",
                                    "varname": "filterQ"
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
                                    "text": "param brightness 0.2 @min 0 @max 1",
                                    "varname": "brightness"
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
                                    "text": "param drive 1.5 @min 0.25 @max 8",
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
                                    "text": "param level 0.5 @min 0 @max 1",
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
                                        "rnbo-param-burstDecayMs",
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
                                        "rnbo-param-count",
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
                                        "rnbo-param-brightness",
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
                                        "rnbo-param-spacingMs",
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
                                        "rnbo-param-scatter",
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
                                        "rnbo-param-tailDecayMs",
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
                                        "rnbo-param-tailLevel",
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
                                        "rnbo-param-balance",
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
                        "tailDecayMs": {
                            "label": "tailDecayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 280
                        },
                        "filterQ": {
                            "label": "filterQ",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.1
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.5
                        },
                        "spacingMs": {
                            "label": "spacingMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 12
                        },
                        "filterHz": {
                            "label": "filterHz",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1600
                        },
                        "tailLevel": {
                            "label": "tailLevel",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.65
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 1.5
                        },
                        "scatter": {
                            "label": "scatter",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.15
                        },
                        "brightness": {
                            "label": "brightness",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.2
                        },
                        "burstDecayMs": {
                            "label": "burstDecayMs",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 10
                        },
                        "balance": {
                            "label": "balance",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 0.45
                        },
                        "count": {
                            "label": "count",
                            "isEnum": 0,
                            "parsestring": "",
                            "value": 3
                        }
                    },
                    "rnboversion": "1.4.5",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "clap_rnbo",
                            "parameter_modmode": 0,
                            "parameter_shortname": "clap_rnbo",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "optimization": "O1",
                        "parameter_enable": 1,
                        "uuid": "03acda11-5f90-4019-ab52-3880723b8b39"
                    },
                    "text": "rnbo~ @title mlr-clap @dumpoutlet 1",
                    "varname": "clap_rnbo"
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
                    "text": "s~ rnbo_clap_left"
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
                    "text": "s~ rnbo_clap_right"
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
                    "text": "Hands"
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
                    "text": "Wash"
                }
            },
            {
                "box": {
                    "id": "label-count",
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
                    "text": "Burst count"
                }
            },
            {
                "box": {
                    "id": "control-count",
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
                    "varname": "clap_sound_count",
                    "minimum": 1,
                    "maximum": 8
                }
            },
            {
                "box": {
                    "id": "label-scatter",
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
                    "text": "Timing scatter"
                }
            },
            {
                "box": {
                    "id": "control-scatter",
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
                    "varname": "clap_sound_scatter"
                }
            },
            {
                "box": {
                    "id": "label-tailDecayMs",
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
                        585,
                        220,
                        245,
                        20
                    ],
                    "text": "Tail decay · ms"
                }
            },
            {
                "box": {
                    "id": "control-tailDecayMs",
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
                        585,
                        243,
                        245,
                        22
                    ],
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "clap_sound_tailDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-burstDecayMs",
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
                        356,
                        245,
                        20
                    ],
                    "text": "Burst decay · ms"
                }
            },
            {
                "box": {
                    "id": "control-burstDecayMs",
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
                        379,
                        245,
                        22
                    ],
                    "minimum": 1,
                    "maximum": 200,
                    "varname": "clap_sound_burstDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-spacingMs",
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
                    "text": "Burst spacing · ms"
                }
            },
            {
                "box": {
                    "id": "control-spacingMs",
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
                    "minimum": 2,
                    "maximum": 100,
                    "varname": "clap_sound_spacingMs"
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
                        305,
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
                        305,
                        243,
                        245,
                        22
                    ],
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "clap_sound_filterHz"
                }
            },
            {
                "box": {
                    "id": "label-balance",
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
                        356,
                        245,
                        20
                    ],
                    "text": "Burst / tail balance"
                }
            },
            {
                "box": {
                    "id": "control-balance",
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
                        379,
                        245,
                        22
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "clap_sound_balance"
                }
            },
            {
                "box": {
                    "id": "label-tailLevel",
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
                    "text": "Tail level"
                }
            },
            {
                "box": {
                    "id": "control-tailLevel",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "clap_sound_tailLevel"
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
                        305,
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
                        305,
                        311,
                        245,
                        22
                    ],
                    "minimum": 0.5,
                    "maximum": 20,
                    "varname": "clap_sound_filterQ"
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
                    "varname": "clap_sound_brightness"
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
                        305,
                        424,
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
                        305,
                        447,
                        245,
                        22
                    ],
                    "minimum": 0.25,
                    "maximum": 8,
                    "varname": "clap_sound_drive"
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
                    "varname": "clap_sound_level"
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
                    "text": "r rnbo_clap_repeat"
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
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_clap_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "clap-manual",
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
                    "id": "clap-manual-echo",
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
                    "text": "prepend clapManual"
                }
            },
            {
                "box": {
                    "id": "clap-router",
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
                    "id": "clap-route",
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
                    "text": "route count burstDecayMs spacingMs scatter tailDecayMs filterHz brightness drive balance tailLevel filterQ level"
                }
            },
            {
                "box": {
                    "id": "clap-cache",
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
                    "text": "pak 3.0 10.0 12.0 0.15 280.0 1600.0 0.2 1.5 0.45 0.65 1.1 0.5"
                }
            },
            {
                "box": {
                    "id": "clap-unpack",
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
                    "id": "clap-pitch",
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
                    "text": "prepend count"
                }
            },
            {
                "box": {
                    "id": "clap-decay",
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
                    "text": "prepend burstDecayMs"
                }
            },
            {
                "box": {
                    "id": "clap-fm",
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
                    "text": "prepend spacingMs"
                }
            },
            {
                "box": {
                    "id": "clap-owned",
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
                    "text": "r rnbo_clap_owned_param"
                }
            },
            {
                "box": {
                    "id": "clap-step",
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
                    "text": "r rnbo_clap_step"
                }
            },
            {
                "box": {
                    "id": "clap-step-unpack",
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
                    "id": "clap-fire",
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
                    "id": "clap-load",
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
                    "id": "clap-defer",
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
                    "id": "clap-sync",
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
                    "text": "clapSync"
                }
            },
            {
                "box": {
                    "id": "clap-values",
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
                    "text": "Grid mapping ranges · all twelve clap parameters"
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
                    "filename": "clap_lab_ranges.js",
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
                    "text": "v8 clap_lab_ranges.js",
                    "textfile": {
                        "filename": "clap_lab_ranges.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "clapCount-range-label",
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
                    "text": "Burst count"
                }
            },
            {
                "box": {
                    "id": "clapCount-min-label",
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
                    "id": "clapCount-min",
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
                    "varname": "clapCount-min"
                }
            },
            {
                "box": {
                    "id": "clapCount-min-pre",
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
                    "text": "prepend setrange clapCount min"
                }
            },
            {
                "box": {
                    "id": "clapCount-max-label",
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
                    "id": "clapCount-max",
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
                    "varname": "clapCount-max"
                }
            },
            {
                "box": {
                    "id": "clapCount-max-pre",
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
                    "text": "prepend setrange clapCount max"
                }
            },
            {
                "box": {
                    "id": "clapBurstDecay-range-label",
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
                    "text": "Burst decay · ms"
                }
            },
            {
                "box": {
                    "id": "clapBurstDecay-min-label",
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
                    "id": "clapBurstDecay-min",
                    "maxclass": "flonum",
                    "maximum": 200,
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
                    "varname": "clapBurstDecay-min"
                }
            },
            {
                "box": {
                    "id": "clapBurstDecay-min-pre",
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
                    "text": "prepend setrange clapBurstDecay min"
                }
            },
            {
                "box": {
                    "id": "clapBurstDecay-max-label",
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
                    "id": "clapBurstDecay-max",
                    "maxclass": "flonum",
                    "maximum": 200,
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
                    "varname": "clapBurstDecay-max"
                }
            },
            {
                "box": {
                    "id": "clapBurstDecay-max-pre",
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
                    "text": "prepend setrange clapBurstDecay max"
                }
            },
            {
                "box": {
                    "id": "clapSpacing-range-label",
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
                    "text": "Burst spacing · ms"
                }
            },
            {
                "box": {
                    "id": "clapSpacing-min-label",
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
                    "id": "clapSpacing-min",
                    "maxclass": "flonum",
                    "maximum": 100,
                    "minimum": 2,
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
                    "varname": "clapSpacing-min"
                }
            },
            {
                "box": {
                    "id": "clapSpacing-min-pre",
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
                    "text": "prepend setrange clapSpacing min"
                }
            },
            {
                "box": {
                    "id": "clapSpacing-max-label",
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
                    "id": "clapSpacing-max",
                    "maxclass": "flonum",
                    "maximum": 100,
                    "minimum": 2,
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
                    "varname": "clapSpacing-max"
                }
            },
            {
                "box": {
                    "id": "clapSpacing-max-pre",
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
                    "text": "prepend setrange clapSpacing max"
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
                    "text": "route clapCount-min clapCount-max clapBurstDecay-min clapBurstDecay-max clapSpacing-min clapSpacing-max clapScatter-min clapScatter-max clapTailDecay-min clapTailDecay-max clapFilterHz-min clapFilterHz-max clapBrightness-min clapBrightness-max clapDrive-min clapDrive-max clapBalance-min clapBalance-max clapTailLevel-min clapTailLevel-max clapFilterQ-min clapFilterQ-max clapLevel-min clapLevel-max"
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
                    "varname": "clap_grid_range_presets"
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
                    "id": "clap-param-clapScatter",
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
                    "text": "prepend scatter"
                }
            },
            {
                "box": {
                    "id": "clap-param-clapTailDecay",
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
                    "text": "prepend tailDecayMs"
                }
            },
            {
                "box": {
                    "id": "clap-param-clapFilterHz",
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
                    "id": "clap-param-clapBrightness",
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
                    "text": "prepend brightness"
                }
            },
            {
                "box": {
                    "id": "clap-param-clapDrive",
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
                    "id": "clap-param-clapBalance",
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
                    "text": "prepend balance"
                }
            },
            {
                "box": {
                    "id": "clap-param-clapTailLevel",
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
                    "text": "prepend tailLevel"
                }
            },
            {
                "box": {
                    "id": "clap-param-clapFilterQ",
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
                    "id": "clap-param-clapLevel",
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
                    "id": "clapScatter-range-label",
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
                    "text": "Timing scatter"
                }
            },
            {
                "box": {
                    "id": "clapScatter-min-label",
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
                    "id": "clapScatter-min",
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
                    "varname": "clapScatter-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapScatter-min-pre",
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
                    "text": "prepend setrange clapScatter min"
                }
            },
            {
                "box": {
                    "id": "clapScatter-max-label",
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
                    "id": "clapScatter-max",
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
                    "varname": "clapScatter-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapScatter-max-pre",
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
                    "text": "prepend setrange clapScatter max"
                }
            },
            {
                "box": {
                    "id": "clapTailDecay-range-label",
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
                    "text": "Tail decay · ms"
                }
            },
            {
                "box": {
                    "id": "clapTailDecay-min-label",
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
                    "id": "clapTailDecay-min",
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
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "clapTailDecay-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapTailDecay-min-pre",
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
                    "text": "prepend setrange clapTailDecay min"
                }
            },
            {
                "box": {
                    "id": "clapTailDecay-max-label",
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
                    "id": "clapTailDecay-max",
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
                    "minimum": 5,
                    "maximum": 10000,
                    "varname": "clapTailDecay-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapTailDecay-max-pre",
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
                    "text": "prepend setrange clapTailDecay max"
                }
            },
            {
                "box": {
                    "id": "clapFilterHz-range-label",
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
                    "text": "Filter frequency · Hz"
                }
            },
            {
                "box": {
                    "id": "clapFilterHz-min-label",
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
                    "id": "clapFilterHz-min",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "clapFilterHz-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapFilterHz-min-pre",
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
                    "text": "prepend setrange clapFilterHz min"
                }
            },
            {
                "box": {
                    "id": "clapFilterHz-max-label",
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
                    "id": "clapFilterHz-max",
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
                    "minimum": 100,
                    "maximum": 18000,
                    "varname": "clapFilterHz-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapFilterHz-max-pre",
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
                    "text": "prepend setrange clapFilterHz max"
                }
            },
            {
                "box": {
                    "id": "clapBrightness-range-label",
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
                    "text": "Brightness"
                }
            },
            {
                "box": {
                    "id": "clapBrightness-min-label",
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
                    "id": "clapBrightness-min",
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
                    "varname": "clapBrightness-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapBrightness-min-pre",
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
                    "text": "prepend setrange clapBrightness min"
                }
            },
            {
                "box": {
                    "id": "clapBrightness-max-label",
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
                    "id": "clapBrightness-max",
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
                    "varname": "clapBrightness-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapBrightness-max-pre",
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
                    "text": "prepend setrange clapBrightness max"
                }
            },
            {
                "box": {
                    "id": "clapDrive-range-label",
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
                    "id": "clapDrive-min-label",
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
                    "id": "clapDrive-min",
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
                    "varname": "clapDrive-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapDrive-min-pre",
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
                    "text": "prepend setrange clapDrive min"
                }
            },
            {
                "box": {
                    "id": "clapDrive-max-label",
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
                    "id": "clapDrive-max",
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
                    "varname": "clapDrive-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapDrive-max-pre",
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
                    "text": "prepend setrange clapDrive max"
                }
            },
            {
                "box": {
                    "id": "clapBalance-range-label",
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
                    "text": "Burst / tail balance"
                }
            },
            {
                "box": {
                    "id": "clapBalance-min-label",
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
                    "id": "clapBalance-min",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "clapBalance-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapBalance-min-pre",
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
                    "text": "prepend setrange clapBalance min"
                }
            },
            {
                "box": {
                    "id": "clapBalance-max-label",
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
                    "id": "clapBalance-max",
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
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "clapBalance-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapBalance-max-pre",
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
                    "text": "prepend setrange clapBalance max"
                }
            },
            {
                "box": {
                    "id": "clapTailLevel-range-label",
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
                    "text": "Tail level"
                }
            },
            {
                "box": {
                    "id": "clapTailLevel-min-label",
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
                    "id": "clapTailLevel-min",
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
                    "varname": "clapTailLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapTailLevel-min-pre",
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
                    "text": "prepend setrange clapTailLevel min"
                }
            },
            {
                "box": {
                    "id": "clapTailLevel-max-label",
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
                    "id": "clapTailLevel-max",
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
                    "varname": "clapTailLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapTailLevel-max-pre",
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
                    "text": "prepend setrange clapTailLevel max"
                }
            },
            {
                "box": {
                    "id": "clapFilterQ-range-label",
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
                    "text": "Filter Q"
                }
            },
            {
                "box": {
                    "id": "clapFilterQ-min-label",
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
                    "id": "clapFilterQ-min",
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
                    "maximum": 20,
                    "varname": "clapFilterQ-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapFilterQ-min-pre",
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
                    "text": "prepend setrange clapFilterQ min"
                }
            },
            {
                "box": {
                    "id": "clapFilterQ-max-label",
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
                    "id": "clapFilterQ-max",
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
                    "maximum": 20,
                    "varname": "clapFilterQ-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapFilterQ-max-pre",
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
                    "text": "prepend setrange clapFilterQ max"
                }
            },
            {
                "box": {
                    "id": "clapLevel-range-label",
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
                    "id": "clapLevel-min-label",
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
                    "id": "clapLevel-min",
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
                    "varname": "clapLevel-min",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapLevel-min-pre",
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
                    "text": "prepend setrange clapLevel min"
                }
            },
            {
                "box": {
                    "id": "clapLevel-max-label",
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
                    "id": "clapLevel-max",
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
                    "varname": "clapLevel-max",
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "clapLevel-max-pre",
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
                    "text": "prepend setrange clapLevel max"
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
                    "text": "Claps"
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
                    "text": "Tone"
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
                    "text": "Tail / output"
                }
            },
            {
                "box": {
                    "id": "control-count-pre",
                    "maxclass": "newobj",
                    "text": "prepend count",
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
                    "id": "control-count-set",
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
                    "id": "control-burstDecayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend burstDecayMs",
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
                    "id": "control-burstDecayMs-set",
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
                    "id": "control-spacingMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend spacingMs",
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
                    "id": "control-spacingMs-set",
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
                    "id": "control-scatter-pre",
                    "maxclass": "newobj",
                    "text": "prepend scatter",
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
                    "id": "control-scatter-set",
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
                    "id": "control-tailDecayMs-pre",
                    "maxclass": "newobj",
                    "text": "prepend tailDecayMs",
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
                    "id": "control-tailDecayMs-set",
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
                    "id": "control-brightness-pre",
                    "maxclass": "newobj",
                    "text": "prepend brightness",
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
                    "id": "control-brightness-set",
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
                    "id": "control-balance-pre",
                    "maxclass": "newobj",
                    "text": "prepend balance",
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
                    "id": "control-balance-set",
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
                    "id": "control-tailLevel-pre",
                    "maxclass": "newobj",
                    "text": "prepend tailLevel",
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
                    "id": "control-tailLevel-set",
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
                    "id": "clap-ui-unpack",
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
                    "text": "dpt_clap_midi",
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
                        "clap-owned",
                        0
                    ],
                    "destination": [
                        "clap-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step",
                        0
                    ],
                    "destination": [
                        "clap-step-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        0
                    ],
                    "destination": [
                        "clap-cache",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        1
                    ],
                    "destination": [
                        "clap-cache",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        2
                    ],
                    "destination": [
                        "clap-cache",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        3
                    ],
                    "destination": [
                        "clap-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        4
                    ],
                    "destination": [
                        "clap-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        5
                    ],
                    "destination": [
                        "clap-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        6
                    ],
                    "destination": [
                        "clap-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        7
                    ],
                    "destination": [
                        "clap-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        8
                    ],
                    "destination": [
                        "clap-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        9
                    ],
                    "destination": [
                        "clap-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        10
                    ],
                    "destination": [
                        "clap-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-step-unpack",
                        11
                    ],
                    "destination": [
                        "clap-cache",
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
                        "clap-values",
                        1
                    ],
                    "source": [
                        "clap-cache",
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
                        "clap-decay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-sync",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "clap-defer",
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
                        "clap-defer",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-values",
                        0
                    ],
                    "source": [
                        "clap-fire",
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
                        "clap-fire",
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
                        "clap-fm",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-cache",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "clap-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-defer",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "clap-load",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-manual-echo",
                        0
                    ],
                    "source": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-route",
                        0
                    ],
                    "source": [
                        "clap-manual",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-router",
                        0
                    ],
                    "source": [
                        "clap-manual-echo",
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
                        "clap-pitch",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-cache",
                        2
                    ],
                    "source": [
                        "clap-route",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-cache",
                        1
                    ],
                    "source": [
                        "clap-route",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-cache",
                        0
                    ],
                    "source": [
                        "clap-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-router",
                        0
                    ],
                    "source": [
                        "clap-sync",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-decay",
                        0
                    ],
                    "source": [
                        "clap-unpack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-fm",
                        0
                    ],
                    "source": [
                        "clap-unpack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-pitch",
                        0
                    ],
                    "source": [
                        "clap-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-unpack",
                        0
                    ],
                    "source": [
                        "clap-values",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clapBurstDecay-max-pre",
                        0
                    ],
                    "source": [
                        "clapBurstDecay-max",
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
                        "clapBurstDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clapBurstDecay-min-pre",
                        0
                    ],
                    "source": [
                        "clapBurstDecay-min",
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
                        "clapBurstDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clapSpacing-max-pre",
                        0
                    ],
                    "source": [
                        "clapSpacing-max",
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
                        "clapSpacing-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clapSpacing-min-pre",
                        0
                    ],
                    "source": [
                        "clapSpacing-min",
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
                        "clapSpacing-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clapCount-max-pre",
                        0
                    ],
                    "source": [
                        "clapCount-max",
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
                        "clapCount-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clapCount-min-pre",
                        0
                    ],
                    "source": [
                        "clapCount-min",
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
                        "clapCount-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "clap-manual",
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
                        "clap-manual",
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
                        "clap-manual",
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
                        "clap-manual",
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
                        "clap-fire",
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
                        "clapBurstDecay-max",
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
                        "clapBurstDecay-min",
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
                        "clapSpacing-max",
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
                        "clapSpacing-min",
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
                        "clapCount-max",
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
                        "clapCount-min",
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
                        "clapBurstDecay-max",
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
                        "clapBurstDecay-min",
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
                        "clapSpacing-max",
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
                        "clapSpacing-min",
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
                        "clapCount-max",
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
                        "clapCount-min",
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
                        "clap-route",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-route",
                        3
                    ],
                    "destination": [
                        "clap-cache",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        3
                    ],
                    "destination": [
                        "clap-param-clapScatter",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapScatter",
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
                        "clap-route",
                        4
                    ],
                    "destination": [
                        "clap-cache",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        4
                    ],
                    "destination": [
                        "clap-param-clapTailDecay",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapTailDecay",
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
                        "clap-route",
                        5
                    ],
                    "destination": [
                        "clap-cache",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        5
                    ],
                    "destination": [
                        "clap-param-clapFilterHz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapFilterHz",
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
                        "clap-route",
                        6
                    ],
                    "destination": [
                        "clap-cache",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        6
                    ],
                    "destination": [
                        "clap-param-clapBrightness",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapBrightness",
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
                        "clap-route",
                        7
                    ],
                    "destination": [
                        "clap-cache",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        7
                    ],
                    "destination": [
                        "clap-param-clapDrive",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapDrive",
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
                        "clap-route",
                        8
                    ],
                    "destination": [
                        "clap-cache",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        8
                    ],
                    "destination": [
                        "clap-param-clapBalance",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapBalance",
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
                        "clap-route",
                        9
                    ],
                    "destination": [
                        "clap-cache",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        9
                    ],
                    "destination": [
                        "clap-param-clapTailLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapTailLevel",
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
                        "clap-route",
                        10
                    ],
                    "destination": [
                        "clap-cache",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        10
                    ],
                    "destination": [
                        "clap-param-clapFilterQ",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapFilterQ",
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
                        "clap-route",
                        11
                    ],
                    "destination": [
                        "clap-cache",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-unpack",
                        11
                    ],
                    "destination": [
                        "clap-param-clapLevel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-param-clapLevel",
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
                        "clapScatter-min",
                        0
                    ],
                    "destination": [
                        "clapScatter-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapScatter-min-pre",
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
                        "clapScatter-min",
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
                        "clapScatter-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapScatter-max",
                        0
                    ],
                    "destination": [
                        "clapScatter-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapScatter-max-pre",
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
                        "clapScatter-max",
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
                        "clapScatter-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailDecay-min",
                        0
                    ],
                    "destination": [
                        "clapTailDecay-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailDecay-min-pre",
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
                        "clapTailDecay-min",
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
                        "clapTailDecay-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailDecay-max",
                        0
                    ],
                    "destination": [
                        "clapTailDecay-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailDecay-max-pre",
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
                        "clapTailDecay-max",
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
                        "clapTailDecay-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterHz-min",
                        0
                    ],
                    "destination": [
                        "clapFilterHz-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterHz-min-pre",
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
                        "clapFilterHz-min",
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
                        "clapFilterHz-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterHz-max",
                        0
                    ],
                    "destination": [
                        "clapFilterHz-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterHz-max-pre",
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
                        "clapFilterHz-max",
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
                        "clapFilterHz-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBrightness-min",
                        0
                    ],
                    "destination": [
                        "clapBrightness-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBrightness-min-pre",
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
                        "clapBrightness-min",
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
                        "clapBrightness-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBrightness-max",
                        0
                    ],
                    "destination": [
                        "clapBrightness-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBrightness-max-pre",
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
                        "clapBrightness-max",
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
                        "clapBrightness-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapDrive-min",
                        0
                    ],
                    "destination": [
                        "clapDrive-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapDrive-min-pre",
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
                        "clapDrive-min",
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
                        "clapDrive-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapDrive-max",
                        0
                    ],
                    "destination": [
                        "clapDrive-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapDrive-max-pre",
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
                        "clapDrive-max",
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
                        "clapDrive-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBalance-min",
                        0
                    ],
                    "destination": [
                        "clapBalance-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBalance-min-pre",
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
                        "clapBalance-min",
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
                        "clapBalance-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBalance-max",
                        0
                    ],
                    "destination": [
                        "clapBalance-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapBalance-max-pre",
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
                        "clapBalance-max",
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
                        "clapBalance-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailLevel-min",
                        0
                    ],
                    "destination": [
                        "clapTailLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailLevel-min-pre",
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
                        "clapTailLevel-min",
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
                        "clapTailLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailLevel-max",
                        0
                    ],
                    "destination": [
                        "clapTailLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapTailLevel-max-pre",
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
                        "clapTailLevel-max",
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
                        "clapTailLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterQ-min",
                        0
                    ],
                    "destination": [
                        "clapFilterQ-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterQ-min-pre",
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
                        "clapFilterQ-min",
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
                        "clapFilterQ-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterQ-max",
                        0
                    ],
                    "destination": [
                        "clapFilterQ-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapFilterQ-max-pre",
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
                        "clapFilterQ-max",
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
                        "clapFilterQ-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapLevel-min",
                        0
                    ],
                    "destination": [
                        "clapLevel-min-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapLevel-min-pre",
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
                        "clapLevel-min",
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
                        "clapLevel-min",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapLevel-max",
                        0
                    ],
                    "destination": [
                        "clapLevel-max-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clapLevel-max-pre",
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
                        "clapLevel-max",
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
                        "clapLevel-max",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-count",
                        0
                    ],
                    "destination": [
                        "control-count-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-count-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        0
                    ],
                    "destination": [
                        "control-count-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-count-set",
                        0
                    ],
                    "destination": [
                        "control-count",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-burstDecayMs",
                        0
                    ],
                    "destination": [
                        "control-burstDecayMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-burstDecayMs-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        1
                    ],
                    "destination": [
                        "control-burstDecayMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-burstDecayMs-set",
                        0
                    ],
                    "destination": [
                        "control-burstDecayMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-spacingMs",
                        0
                    ],
                    "destination": [
                        "control-spacingMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-spacingMs-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        2
                    ],
                    "destination": [
                        "control-spacingMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-spacingMs-set",
                        0
                    ],
                    "destination": [
                        "control-spacingMs",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-scatter",
                        0
                    ],
                    "destination": [
                        "control-scatter-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-scatter-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        3
                    ],
                    "destination": [
                        "control-scatter-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-scatter-set",
                        0
                    ],
                    "destination": [
                        "control-scatter",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-tailDecayMs",
                        0
                    ],
                    "destination": [
                        "control-tailDecayMs-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-tailDecayMs-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        4
                    ],
                    "destination": [
                        "control-tailDecayMs-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-tailDecayMs-set",
                        0
                    ],
                    "destination": [
                        "control-tailDecayMs",
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
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
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
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        6
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
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
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
                        "control-balance",
                        0
                    ],
                    "destination": [
                        "control-balance-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-balance-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        8
                    ],
                    "destination": [
                        "control-balance-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-balance-set",
                        0
                    ],
                    "destination": [
                        "control-balance",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-tailLevel",
                        0
                    ],
                    "destination": [
                        "control-tailLevel-pre",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-tailLevel-pre",
                        0
                    ],
                    "destination": [
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
                        9
                    ],
                    "destination": [
                        "control-tailLevel-set",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "control-tailLevel-set",
                        0
                    ],
                    "destination": [
                        "control-tailLevel",
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
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
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
                        "clap-manual",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clap-ui-unpack",
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
                        "clap-cache",
                        0
                    ],
                    "destination": [
                        "clap-ui-unpack",
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
                        "clap-manual",
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
                        "clap-owned",
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
                        "clap-values",
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
                        "clap-cache",
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
                "clap_rnbo",
                "clap_rnbo",
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
