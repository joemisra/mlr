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
        "rect": [ 562.0, 140.0, 930.0, 1080.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontsize": 20.0,
                    "id": "obj-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 250.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 20.0, 500.0, 29.0 ],
                    "text": "RNBO Rim laboratory"
                }
            },
            {
                "box": {
                    "id": "obj-note",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 55.0, 418.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 58.0, 825.0, 20.0 ],
                    "text": "Track 10 triggers the rim. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
                }
            },
            {
                "box": {
                    "id": "obj-trigger-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 130.0, 65.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 82.0, 130.0, 70.0, 20.0 ],
                    "text": "TRIGGER"
                }
            },
            {
                "box": {
                    "id": "obj-trigger",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 95.0, 125.0, 32.0, 32.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 30.0, 120.0, 40.0, 40.0 ],
                    "varname": "rim_trigger"
                }
            },
            {
                "box": {
                    "id": "obj-trackreceive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 185.0, 65.0, 22.0 ],
                    "text": "r 11input"
                }
            },
            {
                "box": {
                    "id": "obj-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 115.0, 185.0, 75.0, 22.0 ],
                    "text": "unpack i i"
                }
            },
            {
                "box": {
                    "id": "obj-selectpress",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 210.0, 185.0, 45.0, 22.0 ],
                    "text": "sel 1"
                }
            },
            {
                "box": {
                    "id": "obj-globaltrigger",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 225.0, 125.0, 22.0 ],
                    "text": "r rnbo_rim_trigger"
                }
            },
            {
                "box": {
                    "id": "obj-deep",
                    "linecount": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 125.0, 520.0, 35.0 ],
                    "text": "pitchHz 850, decayMs 65, modeRatio 2.73, modeLevel 0.65, clickLevel 0.6, noiseDecayMs 4, filterHz 4200, filterQ 1.2, fmAmount 0.2, fmRatio 2, drive 1.8, level 0.45",
                    "varname": "rim_preset_deep"
                }
            },
            {
                "box": {
                    "id": "obj-knock",
                    "linecount": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 160.0, 522.0, 35.0 ],
                    "text": "pitchHz 570, decayMs 140, modeRatio 1.48, modeLevel 0.65, clickLevel 0.18, noiseDecayMs 4, filterHz 4200, filterQ 1.2, fmAmount 0, fmRatio 2, drive 1.1, level 0.45",
                    "varname": "rim_preset_knock"
                }
            },
            {
                "box": {
                    "id": "obj-hollow",
                    "linecount": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 195.0, 520.0, 35.0 ],
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
                    "patching_rect": [ 340.0, 100.0, 220.0, 20.0 ],
                    "text": "starting sounds: Rim / Wood / Clave"
                }
            },
            {
                "box": {
                    "id": "obj-paramreceive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 235.0, 115.0, 22.0 ],
                    "text": "r rnbo_rim_param"
                }
            },
            {
                "box": {
                    "id": "obj-paramnote",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 465.0, 237.0, 300.0, 20.0 ],
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
                    "outlettype": [ "signal", "signal", "list", "" ],
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
                        "rect": [ 268.0, 150.0, 900.0, 600.0 ],
                        "default_fontname": "Lato",
                        "title": "mlr-rim",
                        "boxes": [
                            {
                                "box": {
                                    "id": "rnbo-in",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 245.0, 40.0, 40.0, 23.0 ],
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
                                                "type": [ "bang", "number", "list" ],
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
                                    "outlettype": [ "signal", "signal" ],
                                    "patching_rect": [ 245.0, 290.0, 185.0, 23.0 ],
                                    "rnbo_classname": "p",
                                    "rnbo_extra_attributes": {
                                        "args": [],
                                        "receivemode": "local",
                                        "voicecontrol": "midi",
                                        "polyphony": -1.0,
                                        "notecontroller": 0,
                                        "exposevoiceparams": 0,
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
                                                "enum": [ "simple", "user" ],
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
                                                "enum": [ "local", "compensated" ],
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
                                                "enum": [ "auto", "local", "parent", "global" ],
                                                "type": "enum",
                                                "defaultValue": "auto"
                                            }
                                        },
                                        "inputs": [
                                            {
                                                "name": "in1",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in1",
                                                "displayName": "trigger",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in2",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in2",
                                                "displayName": "base frequency",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in3",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in3",
                                                "displayName": "pitch sweep amount",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in4",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in4",
                                                "displayName": "pitch sweep decay",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in5",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in5",
                                                "displayName": "amplitude decay",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in6",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in6",
                                                "displayName": "FM index",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in7",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in7",
                                                "displayName": "FM ratio",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in8",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in8",
                                                "displayName": "resonator mix",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in9",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in9",
                                                "displayName": "resonator frequency",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in10",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in10",
                                                "displayName": "resonator Q",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in11",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in11",
                                                "displayName": "click level",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in12",
                                                "type": [ "bang", "number", "list" ],
                                                "digest": "in12",
                                                "displayName": "filterQ",
                                                "hot": 1,
                                                "docked": 0
                                            },
                                            {
                                                "name": "in13",
                                                "type": [ "bang", "number", "list" ],
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
                                    "patching_rect": [ 245.0, 345.0, 48.0, 23.0 ],
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
                                    "patching_rect": [ 380.0, 345.0, 48.0, 23.0 ],
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
                                    "patching_rect": [ 245.0, 255.0, 300.0, 35.0 ],
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_rim_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-pitchHz",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 80.0, 259.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
                                    },
                                    "rnbo_serial": 1,
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 108.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 136.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 164.0, 307.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
                                    },
                                    "rnbo_serial": 4,
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 192.0, 202.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
                                    },
                                    "rnbo_serial": 5,
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 220.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 470.0, 80.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 470.0, 108.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 470.0, 136.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 470.0, 164.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 470.0, 192.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 470.0, 220.0, 430.0, 23.0 ],
                                    "rnbo_classname": "param",
                                    "rnbo_extra_attributes": {
                                        "order": "0",
                                        "fromnormalized": "",
                                        "displayorder": "-",
                                        "ctlin": -1.0,
                                        "sendinit": 1,
                                        "steps": 0.0,
                                        "enum": "",
                                        "meta": "",
                                        "displayname": "",
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                                "aliases": [ "min" ],
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
                                                "aliases": [ "max" ],
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
                                    "destination": [ "rnbo-voice", 0 ],
                                    "source": [ "rnbo-in", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 5 ],
                                    "source": [ "rnbo-param-clickLevel", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 2 ],
                                    "source": [ "rnbo-param-decayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 11 ],
                                    "source": [ "rnbo-param-drive", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 7 ],
                                    "source": [ "rnbo-param-filterHz", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 8 ],
                                    "source": [ "rnbo-param-filterQ", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 9 ],
                                    "source": [ "rnbo-param-fmAmount", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 10 ],
                                    "source": [ "rnbo-param-fmRatio", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 12 ],
                                    "source": [ "rnbo-param-level", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 4 ],
                                    "source": [ "rnbo-param-modeLevel", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 3 ],
                                    "source": [ "rnbo-param-modeRatio", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 6 ],
                                    "source": [ "rnbo-param-noiseDecayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 1 ],
                                    "source": [ "rnbo-param-pitchHz", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-out1", 0 ],
                                    "source": [ "rnbo-voice", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-out2", 0 ],
                                    "source": [ "rnbo-voice", 1 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 315.5, 278.0, 245.0, 22.0 ],
                    "rnboattrcache": {
                        "filterQ": {
                            "label": "filterQ",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "clickLevel": {
                            "label": "clickLevel",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "modeRatio": {
                            "label": "modeRatio",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "noiseDecayMs": {
                            "label": "noiseDecayMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "decayMs": {
                            "label": "decayMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "modeLevel": {
                            "label": "modeLevel",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "filterHz": {
                            "label": "filterHz",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "fmRatio": {
                            "label": "fmRatio",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "fmAmount": {
                            "label": "fmAmount",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "pitchHz": {
                            "label": "pitchHz",
                            "isEnum": 0,
                            "parsestring": ""
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
                            "filterHz": {
                                "value": 4200.0
                            },
                            "drive": {
                                "value": 1.8
                            },
                            "fmRatio": {
                                "value": 2.0
                            },
                            "fmAmount": {
                                "value": 0.2
                            },
                            "noiseDecayMs": {
                                "value": 4.0
                            },
                            "decayMs": {
                                "value": 65.0
                            },
                            "modeRatio": {
                                "value": 2.73
                            },
                            "modeLevel": {
                                "value": 0.65
                            },
                            "clickLevel": {
                                "value": 0.6
                            },
                            "__sps": {
                                "p_rnbo-voice": {                                }
                            },
                            "filterQ": {
                                "value": 1.2
                            },
                            "pitchHz": {
                                "value": 850.0
                            },
                            "__presetid": "mlr-rim"
                        },
                        "snapshotlist": {
                            "current_snapshot": 0,
                            "entries": [
                                {
                                    "filetype": "C74Snapshot",
                                    "version": 2,
                                    "minorversion": 0,
                                    "name": "mlr-rim",
                                    "origin": "mlr-rim",
                                    "type": "rnbo",
                                    "subtype": "",
                                    "embed": 0,
                                    "snapshot": {
                                        "level": {
                                            "value": 0.45
                                        },
                                        "filterHz": {
                                            "value": 4200.0
                                        },
                                        "drive": {
                                            "value": 1.8
                                        },
                                        "fmRatio": {
                                            "value": 2.0
                                        },
                                        "fmAmount": {
                                            "value": 0.2
                                        },
                                        "noiseDecayMs": {
                                            "value": 4.0
                                        },
                                        "decayMs": {
                                            "value": 65.0
                                        },
                                        "modeRatio": {
                                            "value": 2.73
                                        },
                                        "modeLevel": {
                                            "value": 0.65
                                        },
                                        "clickLevel": {
                                            "value": 0.6
                                        },
                                        "__sps": {
                                            "p_rnbo-voice": {                                            }
                                        },
                                        "filterQ": {
                                            "value": 1.2
                                        },
                                        "pitchHz": {
                                            "value": 850.0
                                        },
                                        "__presetid": "mlr-rim"
                                    },
                                    "fileref": {
                                        "name": "mlr-rim",
                                        "filename": "mlr-rim.maxsnap",
                                        "filepath": "~/Projects/mlr/New Project/data",
                                        "filepos": -1,
                                        "snapshotfileid": "baccc1116e14ed8a67cd0108535f5f5d"
                                    }
                                }
                            ]
                        }
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 300.0, 360.0, 55.0, 22.0 ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "id": "obj-outputgain2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 395.0, 360.0, 55.0, 22.0 ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "id": "obj-sendleft",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 180.0, 420.0, 115.0, 22.0 ],
                    "text": "s~ rnbo_rim_left"
                }
            },
            {
                "box": {
                    "id": "obj-sendright",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 470.0, 420.0, 120.0, 22.0 ],
                    "text": "s~ rnbo_rim_right"
                }
            },
            {
                "box": {
                    "id": "obj-meter1",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 300.0, 410.0, 16.0, 80.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 795.0, 525.0, 18.0, 65.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-meter2",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 430.0, 410.0, 16.0, 80.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 824.0, 525.0, 18.0, 65.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-outputnote",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 500.0, 360.0, 425.0, 20.0 ],
                    "text": "Audio buses stay active; combined lab selects stereo or eight external outputs."
                }
            },
            {
                "box": {
                    "id": "choose-obj-deep",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 700.0, 525.0, 100.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 380.0, 125.0, 115.0, 30.0 ],
                    "text": "Rim"
                }
            },
            {
                "box": {
                    "id": "choose-obj-knock",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 700.0, 555.0, 100.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 510.0, 125.0, 115.0, 30.0 ],
                    "text": "Wood"
                }
            },
            {
                "box": {
                    "id": "choose-obj-hollow",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 700.0, 585.0, 100.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 640.0, 125.0, 115.0, 30.0 ],
                    "text": "Clave"
                }
            },
            {
                "box": {
                    "id": "label-pitchHz",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 220.0, 245.0, 20.0 ],
                    "text": "Pitch · Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-pitchHz",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 100.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 243.0, 245.0, 22.0 ],
                    "varname": "rim_sound_pitchHz"
                }
            },
            {
                "box": {
                    "id": "label-modeLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 424.0, 245.0, 20.0 ],
                    "text": "Shell level"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-modeLevel",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 447.0, 245.0, 22.0 ],
                    "varname": "rim_sound_modeLevel"
                }
            },
            {
                "box": {
                    "id": "label-clickLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 220.0, 245.0, 20.0 ],
                    "text": "Click level"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-clickLevel",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 243.0, 245.0, 22.0 ],
                    "varname": "rim_sound_clickLevel"
                }
            },
            {
                "box": {
                    "id": "label-decayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 288.0, 245.0, 20.0 ],
                    "text": "Decay · ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-decayMs",
                    "maxclass": "flonum",
                    "maximum": 2000.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 311.0, 245.0, 22.0 ],
                    "varname": "rim_sound_decayMs"
                }
            },
            {
                "box": {
                    "id": "label-modeRatio",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 356.0, 245.0, 20.0 ],
                    "text": "Shell ratio"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-modeRatio",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 379.0, 245.0, 22.0 ],
                    "varname": "rim_sound_modeRatio"
                }
            },
            {
                "box": {
                    "id": "label-noiseDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 288.0, 245.0, 20.0 ],
                    "text": "Strike decay · ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-noiseDecayMs",
                    "maxclass": "flonum",
                    "maximum": 300.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 311.0, 245.0, 22.0 ],
                    "varname": "rim_sound_noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-fmAmount",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 220.0, 245.0, 20.0 ],
                    "text": "FM amount"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-fmAmount",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 243.0, 245.0, 22.0 ],
                    "varname": "rim_sound_fmAmount"
                }
            },
            {
                "box": {
                    "id": "label-fmRatio",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 288.0, 245.0, 20.0 ],
                    "text": "FM ratio"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-fmRatio",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 311.0, 245.0, 22.0 ],
                    "varname": "rim_sound_fmRatio"
                }
            },
            {
                "box": {
                    "id": "label-drive",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 356.0, 245.0, 20.0 ],
                    "text": "Drive"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-drive",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 379.0, 245.0, 22.0 ],
                    "varname": "rim_sound_drive"
                }
            },
            {
                "box": {
                    "id": "label-filterHz",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 356.0, 245.0, 20.0 ],
                    "text": "Strike filter · Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-filterHz",
                    "maxclass": "flonum",
                    "maximum": 18000.0,
                    "minimum": 200.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 379.0, 245.0, 22.0 ],
                    "varname": "rim_sound_filterHz"
                }
            },
            {
                "box": {
                    "id": "label-filterQ",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 424.0, 245.0, 20.0 ],
                    "text": "Strike Q"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-filterQ",
                    "maxclass": "flonum",
                    "maximum": 15.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 447.0, 245.0, 22.0 ],
                    "varname": "rim_sound_filterQ"
                }
            },
            {
                "box": {
                    "id": "label-level",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 424.0, 245.0, 20.0 ],
                    "text": "Level"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-level",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 447.0, 245.0, 22.0 ],
                    "varname": "rim_sound_level"
                }
            },
            {
                "box": {
                    "id": "repeat",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 280.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 170.0, 130.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "repeat-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 60.0, 280.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 131.0, 150.0, 20.0 ],
                    "text": "Repeat (750 ms)"
                }
            },
            {
                "box": {
                    "id": "repeat-clock",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 320.0, 95.0, 22.0 ],
                    "text": "metro 750"
                }
            },
            {
                "box": {
                    "id": "repeat-receive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 350.0, 160.0, 22.0 ],
                    "text": "r rnbo_rim_repeat"
                }
            },
            {
                "box": {
                    "id": "audio-switch",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 420.0, 45.0, 45.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 535.0, 45.0, 45.0 ]
                }
            },
            {
                "box": {
                    "id": "audio-label",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 80.0, 480.0, 323.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 82.0, 532.0, 323.0, 33.0 ],
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_rim_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "rim-manual",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 20.0, 760.0, 210.0, 22.0 ],
                    "text": "t l l"
                }
            },
            {
                "box": {
                    "id": "rim-manual-echo",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 800.0, 210.0, 22.0 ],
                    "text": "prepend rimManual"
                }
            },
            {
                "box": {
                    "id": "rim-router",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 840.0, 210.0, 22.0 ],
                    "text": "s gridrouter"
                }
            },
            {
                "box": {
                    "id": "rim-route",
                    "linecount": 4,
                    "maxclass": "newobj",
                    "numinlets": 13,
                    "numoutlets": 13,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 260.0, 800.0, 210.0, 62.0 ],
                    "text": "route pitchHz decayMs modeRatio modeLevel clickLevel noiseDecayMs filterHz filterQ fmAmount fmRatio drive level"
                }
            },
            {
                "box": {
                    "id": "rim-cache",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 850.0, 295.0, 22.0 ],
                    "text": "pak 850. 65. 2.73 0.65 0.6 4. 4200. 1.2 0.2 2. 1.8 0.45"
                }
            },
            {
                "box": {
                    "id": "rim-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [ "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float" ],
                    "patching_rect": [ 260.0, 890.0, 210.0, 22.0 ],
                    "text": "unpack f f f f f f f f f f f f"
                }
            },
            {
                "box": {
                    "id": "rim-pitch",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend pitchHz"
                }
            },
            {
                "box": {
                    "id": "rim-decay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend decayMs"
                }
            },
            {
                "box": {
                    "id": "rim-fm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend modeRatio"
                }
            },
            {
                "box": {
                    "id": "rim-owned",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_rim_owned_param"
                }
            },
            {
                "box": {
                    "id": "rim-step",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_rim_step"
                }
            },
            {
                "box": {
                    "id": "rim-step-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [ "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float" ],
                    "patching_rect": [ 520.0, 800.0, 210.0, 22.0 ],
                    "text": "unpack f f f f f f f f f f f f"
                }
            },
            {
                "box": {
                    "id": "rim-fire",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patching_rect": [ 740.0, 850.0, 210.0, 22.0 ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "id": "rim-load",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 20.0, 890.0, 210.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "rim-defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 930.0, 210.0, 22.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "rim-sync",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 970.0, 210.0, 22.0 ],
                    "text": "rimSync"
                }
            },
            {
                "box": {
                    "id": "rim-values",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 500.0, 850.0, 48.0, 22.0 ],
                    "text": "zl reg"
                }
            },
            {
                "box": {
                    "fontsize": 17.0,
                    "id": "range-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 615.0, 780.0, 25.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 615.0, 780.0, 25.0 ],
                    "text": "Grid mapping ranges · all twelve rim parameters"
                }
            },
            {
                "box": {
                    "id": "range-help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 645.0, 830.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 645.0, 830.0, 20.0 ],
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
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 20.0, 1120.0, 185.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 703.0, 245.0, 20.0 ],
                    "text": "Pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "rimPitch-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 725.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 725.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimPitch-min",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 100.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "varname": "rimPitch-min"
                }
            },
            {
                "box": {
                    "id": "rimPitch-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange rimPitch min"
                }
            },
            {
                "box": {
                    "id": "rimPitch-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 150.0, 725.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 725.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimPitch-max",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 100.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "varname": "rimPitch-max"
                }
            },
            {
                "box": {
                    "id": "rimPitch-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange rimPitch max"
                }
            },
            {
                "box": {
                    "id": "rimDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 763.0, 245.0, 20.0 ],
                    "text": "Decay · ms"
                }
            },
            {
                "box": {
                    "id": "rimDecay-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 785.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 785.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimDecay-min",
                    "maxclass": "flonum",
                    "maximum": 2000.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "varname": "rimDecay-min"
                }
            },
            {
                "box": {
                    "id": "rimDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 305.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange rimDecay min"
                }
            },
            {
                "box": {
                    "id": "rimDecay-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 150.0, 785.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 785.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimDecay-max",
                    "maxclass": "flonum",
                    "maximum": 2000.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "varname": "rimDecay-max"
                }
            },
            {
                "box": {
                    "id": "rimDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 430.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange rimDecay max"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "text": "Shell ratio"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 845.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 845.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimModeRatio-min",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 845.0, 80.0, 22.0 ],
                    "varname": "rimModeRatio-min"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 585.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange rimModeRatio min"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 150.0, 845.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 845.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimModeRatio-max",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 845.0, 80.0, 22.0 ],
                    "varname": "rimModeRatio-max"
                }
            },
            {
                "box": {
                    "id": "rimModeRatio-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 710.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange rimModeRatio max"
                }
            },
            {
                "box": {
                    "id": "range-route",
                    "linecount": 3,
                    "maxclass": "newobj",
                    "numinlets": 25,
                    "numoutlets": 25,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 260.0, 1120.0, 780.0, 49.0 ],
                    "text": "route rimPitch-min rimPitch-max rimDecay-min rimDecay-max rimModeRatio-min rimModeRatio-max rimModeLevel-min rimModeLevel-max rimClick-min rimClick-max rimNoiseDecay-min rimNoiseDecay-max rimFilterHz-min rimFilterHz-max rimFilterQ-min rimFilterQ-max rimFM-min rimFM-max rimRatio-min rimRatio-max rimDrive-min rimDrive-max rimLevel-min rimLevel-max"
                }
            },
            {
                "box": {
                    "id": "range-status",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 945.0, 800.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 945.0, 800.0, 20.0 ],
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
                    "outlettype": [ "preset", "int", "preset", "int", "" ],
                    "patching_rect": [ 25.0, 980.0, 245.0, 38.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 980.0, 245.0, 38.0 ],
                    "varname": "rim_grid_range_presets"
                }
            },
            {
                "box": {
                    "id": "range-preset-help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 290.0, 980.0, 550.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 290.0, 980.0, 550.0, 20.0 ],
                    "text": "Shift-click a slot to store · click to recall · save this patch to keep slots."
                }
            },
            {
                "box": {
                    "id": "range-write",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 290.0, 1020.0, 55.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 290.0, 1020.0, 55.0, 22.0 ],
                    "text": "write"
                }
            },
            {
                "box": {
                    "id": "range-read",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1020.0, 55.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 355.0, 1020.0, 55.0, 22.0 ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "id": "range-file-help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 1020.0, 340.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 430.0, 1020.0, 340.0, 20.0 ],
                    "text": "Export / import range presets"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimModeLevel",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1330.0, 210.0, 22.0 ],
                    "text": "prepend modeLevel"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimClick",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend clickLevel"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimNoiseDecay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimFilterHz",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend filterHz"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimFilterQ",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend filterQ"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimFM",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend fmAmount"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimRatio",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend fmRatio"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimDrive",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend drive"
                }
            },
            {
                "box": {
                    "id": "rim-param-rimLevel",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend level"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "text": "Shell level"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 905.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 905.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimModeLevel-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "varname": "rimModeLevel-min"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimModeLevel min"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 150.0, 905.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 905.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimModeLevel-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "varname": "rimModeLevel-max"
                }
            },
            {
                "box": {
                    "id": "rimModeLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimModeLevel max"
                }
            },
            {
                "box": {
                    "id": "rimClick-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "text": "Click level"
                }
            },
            {
                "box": {
                    "id": "rimClick-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 725.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 725.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimClick-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "varname": "rimClick-min"
                }
            },
            {
                "box": {
                    "id": "rimClick-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimClick min"
                }
            },
            {
                "box": {
                    "id": "rimClick-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 725.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 430.0, 725.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimClick-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "varname": "rimClick-max"
                }
            },
            {
                "box": {
                    "id": "rimClick-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimClick max"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 763.0, 245.0, 20.0 ],
                    "text": "Strike decay · ms"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 785.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 785.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimNoiseDecay-min",
                    "maxclass": "flonum",
                    "maximum": 300.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 785.0, 80.0, 22.0 ],
                    "varname": "rimNoiseDecay-min"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimNoiseDecay min"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 785.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 430.0, 785.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimNoiseDecay-max",
                    "maxclass": "flonum",
                    "maximum": 300.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 785.0, 80.0, 22.0 ],
                    "varname": "rimNoiseDecay-max"
                }
            },
            {
                "box": {
                    "id": "rimNoiseDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimNoiseDecay max"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "text": "Strike filter · Hz"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 845.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 845.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimFilterHz-min",
                    "maxclass": "flonum",
                    "maximum": 18000.0,
                    "minimum": 200.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "varname": "rimFilterHz-min"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimFilterHz min"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 845.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 430.0, 845.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimFilterHz-max",
                    "maxclass": "flonum",
                    "maximum": 18000.0,
                    "minimum": 200.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "varname": "rimFilterHz-max"
                }
            },
            {
                "box": {
                    "id": "rimFilterHz-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimFilterHz max"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "text": "Strike Q"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 905.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 905.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimFilterQ-min",
                    "maxclass": "flonum",
                    "maximum": 15.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "varname": "rimFilterQ-min"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimFilterQ min"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 905.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 430.0, 905.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimFilterQ-max",
                    "maxclass": "flonum",
                    "maximum": 15.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "varname": "rimFilterQ-max"
                }
            },
            {
                "box": {
                    "id": "rimFilterQ-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimFilterQ max"
                }
            },
            {
                "box": {
                    "id": "rimFM-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "text": "FM amount"
                }
            },
            {
                "box": {
                    "id": "rimFM-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 725.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 725.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimFM-min",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 725.0, 80.0, 22.0 ],
                    "varname": "rimFM-min"
                }
            },
            {
                "box": {
                    "id": "rimFM-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimFM min"
                }
            },
            {
                "box": {
                    "id": "rimFM-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 710.0, 725.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 710.0, 725.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimFM-max",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 725.0, 80.0, 22.0 ],
                    "varname": "rimFM-max"
                }
            },
            {
                "box": {
                    "id": "rimFM-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimFM max"
                }
            },
            {
                "box": {
                    "id": "rimRatio-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "text": "FM ratio"
                }
            },
            {
                "box": {
                    "id": "rimRatio-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 785.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 785.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimRatio-min",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 785.0, 80.0, 22.0 ],
                    "varname": "rimRatio-min"
                }
            },
            {
                "box": {
                    "id": "rimRatio-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimRatio min"
                }
            },
            {
                "box": {
                    "id": "rimRatio-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 710.0, 785.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 710.0, 785.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimRatio-max",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 785.0, 80.0, 22.0 ],
                    "varname": "rimRatio-max"
                }
            },
            {
                "box": {
                    "id": "rimRatio-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimRatio max"
                }
            },
            {
                "box": {
                    "id": "rimDrive-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 823.0, 245.0, 20.0 ],
                    "text": "Drive"
                }
            },
            {
                "box": {
                    "id": "rimDrive-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 845.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 845.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimDrive-min",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 845.0, 80.0, 22.0 ],
                    "varname": "rimDrive-min"
                }
            },
            {
                "box": {
                    "id": "rimDrive-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimDrive min"
                }
            },
            {
                "box": {
                    "id": "rimDrive-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 710.0, 845.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 710.0, 845.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimDrive-max",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 845.0, 80.0, 22.0 ],
                    "varname": "rimDrive-max"
                }
            },
            {
                "box": {
                    "id": "rimDrive-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimDrive max"
                }
            },
            {
                "box": {
                    "id": "rimLevel-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 883.0, 245.0, 20.0 ],
                    "text": "Level"
                }
            },
            {
                "box": {
                    "id": "rimLevel-min-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 905.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 905.0, 40.0, 20.0 ],
                    "text": "Min"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimLevel-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 905.0, 80.0, 22.0 ],
                    "varname": "rimLevel-min"
                }
            },
            {
                "box": {
                    "id": "rimLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimLevel min"
                }
            },
            {
                "box": {
                    "id": "rimLevel-max-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 710.0, 905.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 710.0, 905.0, 40.0, 20.0 ],
                    "text": "Max"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "rimLevel-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 905.0, 80.0, 22.0 ],
                    "varname": "rimLevel-max"
                }
            },
            {
                "box": {
                    "id": "rimLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange rimLevel max"
                }
            },
            {
                "box": {
                    "fontsize": 15.0,
                    "id": "range-page-0",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 673.0, 250.0, 23.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 673.0, 250.0, 23.0 ],
                    "text": "Shell"
                }
            },
            {
                "box": {
                    "fontsize": 15.0,
                    "id": "range-page-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 673.0, 250.0, 23.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 673.0, 250.0, 23.0 ],
                    "text": "Strike"
                }
            },
            {
                "box": {
                    "fontsize": 15.0,
                    "id": "range-page-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 673.0, 250.0, 23.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 673.0, 250.0, 23.0 ],
                    "text": "Color / output"
                }
            },
            {
                "box": {
                    "id": "control-pitchHz-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend pitchHz"
                }
            },
            {
                "box": {
                    "id": "control-pitchHz-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1730.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-decayMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend decayMs"
                }
            },
            {
                "box": {
                    "id": "control-decayMs-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1730.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-modeRatio-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend modeRatio"
                }
            },
            {
                "box": {
                    "id": "control-modeRatio-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1730.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-modeLevel-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend modeLevel"
                }
            },
            {
                "box": {
                    "id": "control-modeLevel-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1730.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-clickLevel-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend clickLevel"
                }
            },
            {
                "box": {
                    "id": "control-clickLevel-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1800.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-noiseDecayMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "control-noiseDecayMs-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1800.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-filterHz-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend filterHz"
                }
            },
            {
                "box": {
                    "id": "control-filterHz-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1800.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-filterQ-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend filterQ"
                }
            },
            {
                "box": {
                    "id": "control-filterQ-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1800.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-fmAmount-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend fmAmount"
                }
            },
            {
                "box": {
                    "id": "control-fmAmount-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1870.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-fmRatio-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend fmRatio"
                }
            },
            {
                "box": {
                    "id": "control-fmRatio-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1870.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-drive-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend drive"
                }
            },
            {
                "box": {
                    "id": "control-drive-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1870.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-level-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend level"
                }
            },
            {
                "box": {
                    "id": "control-level-set",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1870.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "rim-ui-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [ "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float" ],
                    "patching_rect": [ 25.0, 1680.0, 300.0, 22.0 ],
                    "text": "unpack f f f f f f f f f f f f"
                }
            },
            {
                "box": {
                    "id": "route-reserve",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 20.0, 1940.0, 190.0, 22.0 ],
                    "text": "r~ mlr_synth_es9_active"
                }
            },
            {
                "box": {
                    "id": "route-stereo",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 230.0, 1940.0, 190.0, 22.0 ],
                    "text": "!-~ 1."
                }
            },
            {
                "box": {
                    "id": "route-smooth",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 440.0, 1940.0, 190.0, 22.0 ],
                    "text": "rampsmooth~ 960 960"
                }
            },
            {
                "box": {
                    "id": "route-left",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 650.0, 1940.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "route-right",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 650.0, 1980.0, 190.0, 22.0 ],
                    "text": "*~"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-deep", 0 ],
                    "source": [ "choose-obj-deep", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hollow", 0 ],
                    "source": [ "choose-obj-hollow", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-knock", 0 ],
                    "source": [ "choose-obj-knock", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-clickLevel-pre", 0 ],
                    "source": [ "control-clickLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-clickLevel-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-clickLevel", 0 ],
                    "source": [ "control-clickLevel-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-decayMs-pre", 0 ],
                    "source": [ "control-decayMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-decayMs-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-decayMs", 0 ],
                    "source": [ "control-decayMs-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-drive-pre", 0 ],
                    "source": [ "control-drive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-drive-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-drive", 0 ],
                    "source": [ "control-drive-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-filterHz-pre", 0 ],
                    "source": [ "control-filterHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-filterHz-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-filterHz", 0 ],
                    "source": [ "control-filterHz-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-filterQ-pre", 0 ],
                    "source": [ "control-filterQ", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-filterQ-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-filterQ", 0 ],
                    "source": [ "control-filterQ-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmAmount-pre", 0 ],
                    "source": [ "control-fmAmount", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-fmAmount-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmAmount", 0 ],
                    "source": [ "control-fmAmount-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmRatio-pre", 0 ],
                    "source": [ "control-fmRatio", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-fmRatio-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmRatio", 0 ],
                    "source": [ "control-fmRatio-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-level-pre", 0 ],
                    "source": [ "control-level", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-level-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-level", 0 ],
                    "source": [ "control-level-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeLevel-pre", 0 ],
                    "source": [ "control-modeLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-modeLevel-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeLevel", 0 ],
                    "source": [ "control-modeLevel-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeRatio-pre", 0 ],
                    "source": [ "control-modeRatio", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-modeRatio-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeRatio", 0 ],
                    "source": [ "control-modeRatio-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseDecayMs-pre", 0 ],
                    "source": [ "control-noiseDecayMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-noiseDecayMs-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseDecayMs", 0 ],
                    "source": [ "control-noiseDecayMs-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-pitchHz-pre", 0 ],
                    "source": [ "control-pitchHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "control-pitchHz-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-pitchHz", 0 ],
                    "source": [ "control-pitchHz-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "obj-deep", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-trigger", 0 ],
                    "source": [ "obj-globaltrigger", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "obj-hollow", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "obj-knock", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-meter1", 0 ],
                    "order": 1,
                    "source": [ "obj-outputgain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-sendleft", 0 ],
                    "order": 2,
                    "source": [ "obj-outputgain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "route-left", 0 ],
                    "order": 0,
                    "source": [ "obj-outputgain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-meter2", 0 ],
                    "order": 2,
                    "source": [ "obj-outputgain2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-sendright", 0 ],
                    "order": 1,
                    "source": [ "obj-outputgain2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "route-right", 0 ],
                    "order": 0,
                    "source": [ "obj-outputgain2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual", 0 ],
                    "source": [ "obj-paramreceive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-outputgain", 0 ],
                    "source": [ "obj-rnbo", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-outputgain2", 0 ],
                    "source": [ "obj-rnbo", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-outputnote", 0 ],
                    "source": [ "obj-rnbo", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-trigger", 0 ],
                    "source": [ "obj-selectpress", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-unpack", 0 ],
                    "source": [ "obj-trackreceive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-fire", 0 ],
                    "source": [ "obj-trigger", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-selectpress", 0 ],
                    "source": [ "obj-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimClick-max", 0 ],
                    "order": 11,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimClick-min", 0 ],
                    "order": 15,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDecay-max", 0 ],
                    "order": 18,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDecay-min", 0 ],
                    "order": 22,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDrive-max", 0 ],
                    "order": 1,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDrive-min", 0 ],
                    "order": 5,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFM-max", 0 ],
                    "order": 3,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFM-min", 0 ],
                    "order": 7,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterHz-max", 0 ],
                    "order": 9,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterHz-min", 0 ],
                    "order": 13,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterQ-max", 0 ],
                    "order": 8,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterQ-min", 0 ],
                    "order": 12,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimLevel-max", 0 ],
                    "order": 0,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimLevel-min", 0 ],
                    "order": 4,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeLevel-max", 0 ],
                    "order": 16,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeLevel-min", 0 ],
                    "order": 20,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeRatio-max", 0 ],
                    "order": 17,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeRatio-min", 0 ],
                    "order": 21,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimNoiseDecay-max", 0 ],
                    "order": 10,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimNoiseDecay-min", 0 ],
                    "order": 14,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimPitch-max", 0 ],
                    "order": 19,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimPitch-min", 0 ],
                    "order": 23,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimRatio-max", 0 ],
                    "order": 2,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimRatio-min", 0 ],
                    "order": 6,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-presets", 0 ],
                    "source": [ "range-read", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimClick-max", 0 ],
                    "source": [ "range-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimClick-min", 0 ],
                    "source": [ "range-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDecay-max", 0 ],
                    "source": [ "range-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDecay-min", 0 ],
                    "source": [ "range-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDrive-max", 0 ],
                    "source": [ "range-route", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDrive-min", 0 ],
                    "source": [ "range-route", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFM-max", 0 ],
                    "source": [ "range-route", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFM-min", 0 ],
                    "source": [ "range-route", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterHz-max", 0 ],
                    "source": [ "range-route", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterHz-min", 0 ],
                    "source": [ "range-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterQ-max", 0 ],
                    "source": [ "range-route", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterQ-min", 0 ],
                    "source": [ "range-route", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimLevel-max", 0 ],
                    "source": [ "range-route", 23 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimLevel-min", 0 ],
                    "source": [ "range-route", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeLevel-max", 0 ],
                    "source": [ "range-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeLevel-min", 0 ],
                    "source": [ "range-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeRatio-max", 0 ],
                    "source": [ "range-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeRatio-min", 0 ],
                    "source": [ "range-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimNoiseDecay-max", 0 ],
                    "source": [ "range-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimNoiseDecay-min", 0 ],
                    "source": [ "range-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimPitch-max", 0 ],
                    "source": [ "range-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimPitch-min", 0 ],
                    "source": [ "range-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimRatio-max", 0 ],
                    "source": [ "range-route", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimRatio-min", 0 ],
                    "source": [ "range-route", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-route", 0 ],
                    "source": [ "range-script", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-status", 0 ],
                    "source": [ "range-script", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-presets", 0 ],
                    "source": [ "range-write", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "repeat-clock", 0 ],
                    "source": [ "repeat", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-trigger", 0 ],
                    "source": [ "repeat-clock", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "repeat", 0 ],
                    "source": [ "repeat-receive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-ui-unpack", 0 ],
                    "order": 1,
                    "source": [ "rim-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-values", 1 ],
                    "order": 0,
                    "source": [ "rim-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-decay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "order": 0,
                    "source": [ "rim-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-sync", 0 ],
                    "order": 1,
                    "source": [ "rim-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-fire", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-values", 0 ],
                    "source": [ "rim-fire", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-fm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 0 ],
                    "order": 0,
                    "source": [ "rim-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-defer", 0 ],
                    "order": 1,
                    "source": [ "rim-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-manual-echo", 0 ],
                    "source": [ "rim-manual", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-route", 0 ],
                    "source": [ "rim-manual", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-router", 0 ],
                    "source": [ "rim-manual-echo", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-route", 0 ],
                    "source": [ "rim-owned", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimClick", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimDrive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimFM", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimFilterHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimFilterQ", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimModeLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimNoiseDecay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-param-rimRatio", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-pitch", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "rim-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 11 ],
                    "source": [ "rim-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 10 ],
                    "source": [ "rim-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 9 ],
                    "source": [ "rim-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 8 ],
                    "source": [ "rim-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 7 ],
                    "source": [ "rim-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 6 ],
                    "source": [ "rim-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 5 ],
                    "source": [ "rim-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 4 ],
                    "source": [ "rim-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 3 ],
                    "source": [ "rim-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 2 ],
                    "source": [ "rim-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 1 ],
                    "source": [ "rim-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 0 ],
                    "source": [ "rim-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-step-unpack", 0 ],
                    "source": [ "rim-step", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 11 ],
                    "source": [ "rim-step-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 10 ],
                    "source": [ "rim-step-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 9 ],
                    "source": [ "rim-step-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 8 ],
                    "source": [ "rim-step-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 7 ],
                    "source": [ "rim-step-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 6 ],
                    "source": [ "rim-step-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 5 ],
                    "source": [ "rim-step-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 4 ],
                    "source": [ "rim-step-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 3 ],
                    "source": [ "rim-step-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 2 ],
                    "source": [ "rim-step-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 1 ],
                    "source": [ "rim-step-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-cache", 0 ],
                    "source": [ "rim-step-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-router", 0 ],
                    "source": [ "rim-sync", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-clickLevel-set", 0 ],
                    "source": [ "rim-ui-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-decayMs-set", 0 ],
                    "source": [ "rim-ui-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-drive-set", 0 ],
                    "source": [ "rim-ui-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-filterHz-set", 0 ],
                    "source": [ "rim-ui-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-filterQ-set", 0 ],
                    "source": [ "rim-ui-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmAmount-set", 0 ],
                    "source": [ "rim-ui-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmRatio-set", 0 ],
                    "source": [ "rim-ui-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-level-set", 0 ],
                    "source": [ "rim-ui-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeLevel-set", 0 ],
                    "source": [ "rim-ui-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeRatio-set", 0 ],
                    "source": [ "rim-ui-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseDecayMs-set", 0 ],
                    "source": [ "rim-ui-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-pitchHz-set", 0 ],
                    "source": [ "rim-ui-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-decay", 0 ],
                    "source": [ "rim-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-fm", 0 ],
                    "source": [ "rim-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimClick", 0 ],
                    "source": [ "rim-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimDrive", 0 ],
                    "source": [ "rim-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimFM", 0 ],
                    "source": [ "rim-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimFilterHz", 0 ],
                    "source": [ "rim-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimFilterQ", 0 ],
                    "source": [ "rim-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimLevel", 0 ],
                    "source": [ "rim-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimModeLevel", 0 ],
                    "source": [ "rim-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimNoiseDecay", 0 ],
                    "source": [ "rim-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-param-rimRatio", 0 ],
                    "source": [ "rim-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-pitch", 0 ],
                    "source": [ "rim-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rim-unpack", 0 ],
                    "source": [ "rim-values", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimClick-max-pre", 0 ],
                    "source": [ "rimClick-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimClick-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimClick-min-pre", 0 ],
                    "source": [ "rimClick-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimClick-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDecay-max-pre", 0 ],
                    "source": [ "rimDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDecay-min-pre", 0 ],
                    "source": [ "rimDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDrive-max-pre", 0 ],
                    "source": [ "rimDrive-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimDrive-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimDrive-min-pre", 0 ],
                    "source": [ "rimDrive-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimDrive-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFM-max-pre", 0 ],
                    "source": [ "rimFM-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimFM-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFM-min-pre", 0 ],
                    "source": [ "rimFM-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimFM-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterHz-max-pre", 0 ],
                    "source": [ "rimFilterHz-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimFilterHz-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterHz-min-pre", 0 ],
                    "source": [ "rimFilterHz-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimFilterHz-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterQ-max-pre", 0 ],
                    "source": [ "rimFilterQ-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimFilterQ-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimFilterQ-min-pre", 0 ],
                    "source": [ "rimFilterQ-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimFilterQ-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimLevel-max-pre", 0 ],
                    "source": [ "rimLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimLevel-min-pre", 0 ],
                    "source": [ "rimLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeLevel-max-pre", 0 ],
                    "source": [ "rimModeLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimModeLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeLevel-min-pre", 0 ],
                    "source": [ "rimModeLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimModeLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeRatio-max-pre", 0 ],
                    "source": [ "rimModeRatio-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimModeRatio-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimModeRatio-min-pre", 0 ],
                    "source": [ "rimModeRatio-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimModeRatio-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimNoiseDecay-max-pre", 0 ],
                    "source": [ "rimNoiseDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimNoiseDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimNoiseDecay-min-pre", 0 ],
                    "source": [ "rimNoiseDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimNoiseDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimPitch-max-pre", 0 ],
                    "source": [ "rimPitch-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimPitch-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimPitch-min-pre", 0 ],
                    "source": [ "rimPitch-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimPitch-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimRatio-max-pre", 0 ],
                    "source": [ "rimRatio-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimRatio-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rimRatio-min-pre", 0 ],
                    "source": [ "rimRatio-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "rimRatio-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "audio-switch", 0 ],
                    "source": [ "route-left", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "route-stereo", 0 ],
                    "source": [ "route-reserve", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "audio-switch", 1 ],
                    "source": [ "route-right", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "route-left", 1 ],
                    "order": 1,
                    "source": [ "route-smooth", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "route-right", 1 ],
                    "order": 0,
                    "source": [ "route-smooth", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "route-smooth", 0 ],
                    "source": [ "route-stereo", 0 ]
                }
            }
        ]
    }
}