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
                    "patching_rect": [ 30.0, 55.0, 318.0, 47.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 58.0, 825.0, 20.0 ],
                    "text": "Track 14 triggers the snare. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "snare_trigger"
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
                    "text": "r 15input"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 125.0, 520.0, 35.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 160.0, 522.0, 35.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 195.0, 521.0, 35.0 ],
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
                    "patching_rect": [ 340.0, 100.0, 220.0, 20.0 ],
                    "text": "presets: tight / wood / trash"
                }
            },
            {
                "box": {
                    "id": "obj-paramreceive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 340.0, 235.0, 117.0, 22.0 ],
                    "text": "r rnbo_snare_param"
                }
            },
            {
                "box": {
                    "id": "obj-paramnote",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 465.0, 237.0, 300.0, 20.0 ],
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
                        "title": "mlr-snare",
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
                                                "displayName": "drive",
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
                                    "text": "p @file rnbo_snare_voice"
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
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_snare_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyHz",
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
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                    "text": "param bodyDecayMs 180 @min 5 @max 5000 @unit ms",
                                    "varname": "bodyDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bodyFM",
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
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                    "destination": [ "rnbo-voice", 2 ],
                                    "source": [ "rnbo-param-bodyBend", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 4 ],
                                    "source": [ "rnbo-param-bodyDecayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 5 ],
                                    "source": [ "rnbo-param-bodyFM", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 1 ],
                                    "source": [ "rnbo-param-bodyHz", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 7 ],
                                    "source": [ "rnbo-param-bodyLevel", 0 ]
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
                                    "destination": [ "rnbo-voice", 12 ],
                                    "source": [ "rnbo-param-level", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 3 ],
                                    "source": [ "rnbo-param-noiseDecayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 6 ],
                                    "source": [ "rnbo-param-noiseHz", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 8 ],
                                    "source": [ "rnbo-param-noiseLevel", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 9 ],
                                    "source": [ "rnbo-param-noiseQ", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 10 ],
                                    "source": [ "rnbo-param-snap", 0 ]
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
                        "bodyFM": {
                            "label": "bodyFM",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "bodyLevel": {
                            "label": "bodyLevel",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "noiseDecayMs": {
                            "label": "noiseDecayMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "bodyBend": {
                            "label": "bodyBend",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "snap": {
                            "label": "snap",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "level": {
                            "label": "level",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "drive": {
                            "label": "drive",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "noiseHz": {
                            "label": "noiseHz",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "bodyHz": {
                            "label": "bodyHz",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "noiseQ": {
                            "label": "noiseQ",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "bodyDecayMs": {
                            "label": "bodyDecayMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "noiseLevel": {
                            "label": "noiseLevel",
                            "isEnum": 0,
                            "parsestring": ""
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
                            "noiseQ": {
                                "value": 1.1
                            },
                            "__presetid": "mlr-snare",
                            "bodyHz": {
                                "value": 180.0
                            },
                            "noiseLevel": {
                                "value": 0.72
                            },
                            "bodyLevel": {
                                "value": 0.65
                            },
                            "noiseHz": {
                                "value": 3500.0
                            },
                            "bodyDecayMs": {
                                "value": 180.0
                            },
                            "snap": {
                                "value": 0.45
                            },
                            "noiseDecayMs": {
                                "value": 260.0
                            },
                            "__sps": {
                                "p_rnbo-voice": {                                }
                            },
                            "bodyBend": {
                                "value": 90.0
                            },
                            "bodyFM": {
                                "value": 0.35
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
                                    "embed": 1,
                                    "snapshot": {
                                        "level": {
                                            "value": 0.45
                                        },
                                        "drive": {
                                            "value": 1.7
                                        },
                                        "noiseQ": {
                                            "value": 1.1
                                        },
                                        "__presetid": "mlr-snare",
                                        "bodyHz": {
                                            "value": 180.0
                                        },
                                        "noiseLevel": {
                                            "value": 0.72
                                        },
                                        "bodyLevel": {
                                            "value": 0.65
                                        },
                                        "noiseHz": {
                                            "value": 3500.0
                                        },
                                        "bodyDecayMs": {
                                            "value": 180.0
                                        },
                                        "snap": {
                                            "value": 0.45
                                        },
                                        "noiseDecayMs": {
                                            "value": 260.0
                                        },
                                        "__sps": {
                                            "p_rnbo-voice": {                                            }
                                        },
                                        "bodyBend": {
                                            "value": 90.0
                                        },
                                        "bodyFM": {
                                            "value": 0.35
                                        }
                                    },
                                    "fileref": {
                                        "name": "mlr-snare",
                                        "filename": "mlr-snare.maxsnap",
                                        "filepath": "~/Projects/mlr/New Project/data",
                                        "filepos": -1,
                                        "snapshotfileid": "dd9c2799f69199b3eb32b322cad05b5b"
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
                    "text": "s~ rnbo_snare_left"
                }
            },
            {
                "box": {
                    "id": "obj-sendright",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 470.0, 420.0, 120.0, 22.0 ],
                    "text": "s~ rnbo_snare_right"
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
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 500.0, 360.0, 300.0, 33.0 ],
                    "text": "Audio buses stay active; combined lab selects Stereo or 6mix."
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
                    "text": "Tight"
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
                    "text": "Trash"
                }
            },
            {
                "box": {
                    "id": "label-bodyHz",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 220.0, 245.0, 20.0 ],
                    "text": "Body Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bodyHz",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 40.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 243.0, 245.0, 22.0 ],
                    "varname": "snare_sound_bodyHz"
                }
            },
            {
                "box": {
                    "id": "label-bodyBend",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 288.0, 245.0, 20.0 ],
                    "text": "Body bend Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bodyBend",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 311.0, 245.0, 22.0 ],
                    "varname": "snare_sound_bodyBend"
                }
            },
            {
                "box": {
                    "id": "label-noiseDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 356.0, 245.0, 20.0 ],
                    "text": "Noise decay ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-noiseDecayMs",
                    "maxclass": "flonum",
                    "maximum": 10000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 379.0, 245.0, 22.0 ],
                    "varname": "snare_sound_noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-bodyDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 424.0, 245.0, 20.0 ],
                    "text": "Body decay ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bodyDecayMs",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 447.0, 245.0, 22.0 ],
                    "varname": "snare_sound_bodyDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-bodyFM",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 220.0, 245.0, 20.0 ],
                    "text": "Body FM"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bodyFM",
                    "maxclass": "flonum",
                    "maximum": 16.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 243.0, 245.0, 22.0 ],
                    "varname": "snare_sound_bodyFM"
                }
            },
            {
                "box": {
                    "id": "label-noiseHz",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 288.0, 245.0, 20.0 ],
                    "text": "Noise filter Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-noiseHz",
                    "maxclass": "flonum",
                    "maximum": 18000.0,
                    "minimum": 100.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 311.0, 245.0, 22.0 ],
                    "varname": "snare_sound_noiseHz"
                }
            },
            {
                "box": {
                    "id": "label-bodyLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 356.0, 245.0, 20.0 ],
                    "text": "Body level"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bodyLevel",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 379.0, 245.0, 22.0 ],
                    "varname": "snare_sound_bodyLevel"
                }
            },
            {
                "box": {
                    "id": "label-noiseLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 424.0, 245.0, 20.0 ],
                    "text": "Noise level"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-noiseLevel",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 447.0, 245.0, 22.0 ],
                    "varname": "snare_sound_noiseLevel"
                }
            },
            {
                "box": {
                    "id": "label-noiseQ",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 220.0, 245.0, 20.0 ],
                    "text": "Noise Q"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-noiseQ",
                    "maxclass": "flonum",
                    "maximum": 20.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 243.0, 245.0, 22.0 ],
                    "varname": "snare_sound_noiseQ"
                }
            },
            {
                "box": {
                    "id": "label-snap",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 288.0, 245.0, 20.0 ],
                    "text": "Snap"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-snap",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 311.0, 245.0, 22.0 ],
                    "varname": "snare_sound_snap"
                }
            },
            {
                "box": {
                    "id": "label-drive",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 170.0, 240.0, 20.0 ],
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
                    "patching_rect": [ 1420.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 379.0, 245.0, 22.0 ],
                    "varname": "snare_sound_drive"
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
                    "varname": "snare_sound_level"
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
                    "text": "r rnbo_snare_repeat"
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
                    "patching_rect": [ 80.0, 480.0, 313.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 82.0, 532.0, 313.0, 33.0 ],
                    "text": "Global audio on/off. Combined lab selects Stereo or 6mix."
                }
            },
            {
                "box": {
                    "id": "snare-manual",
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
                    "id": "snare-manual-echo",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 800.0, 210.0, 22.0 ],
                    "text": "prepend snareManual"
                }
            },
            {
                "box": {
                    "id": "snare-router",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 840.0, 210.0, 22.0 ],
                    "text": "s gridrouter"
                }
            },
            {
                "box": {
                    "id": "snare-route",
                    "linecount": 4,
                    "maxclass": "newobj",
                    "numinlets": 13,
                    "numoutlets": 13,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 260.0, 800.0, 210.0, 62.0 ],
                    "text": "route bodyHz bodyDecayMs bodyFM bodyBend noiseDecayMs noiseHz snap drive bodyLevel noiseLevel noiseQ level"
                }
            },
            {
                "box": {
                    "id": "snare-cache",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 850.0, 335.0, 22.0 ],
                    "text": "pak 180. 180. 0.35 90. 260. 3500. 0.45 1.7 0.65 0.72 1.1 0.45"
                }
            },
            {
                "box": {
                    "id": "snare-unpack",
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
                    "id": "snare-pitch",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend bodyHz"
                }
            },
            {
                "box": {
                    "id": "snare-decay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend bodyDecayMs"
                }
            },
            {
                "box": {
                    "id": "snare-fm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend bodyFM"
                }
            },
            {
                "box": {
                    "id": "snare-owned",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_snare_owned_param"
                }
            },
            {
                "box": {
                    "id": "snare-step",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_snare_step"
                }
            },
            {
                "box": {
                    "id": "snare-step-unpack",
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
                    "id": "snare-fire",
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
                    "id": "snare-load",
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
                    "id": "snare-defer",
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
                    "id": "snare-sync",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 970.0, 210.0, 22.0 ],
                    "text": "snareSync"
                }
            },
            {
                "box": {
                    "id": "snare-values",
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
                    "text": "Grid mapping ranges · all twelve snare parameters"
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
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 20.0, 1120.0, 185.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 703.0, 245.0, 20.0 ],
                    "text": "Body pitch · Hz"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-min-label",
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
                    "id": "snareBodyHz-min",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 40.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "varname": "snareBodyHz-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange snareBodyHz min"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-max-label",
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
                    "id": "snareBodyHz-max",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 40.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "varname": "snareBodyHz-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyHz-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange snareBodyHz max"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 763.0, 245.0, 20.0 ],
                    "text": "Body decay · ms"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-min-label",
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
                    "id": "snareBodyDecay-min",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "varname": "snareBodyDecay-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 305.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange snareBodyDecay min"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-max-label",
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
                    "id": "snareBodyDecay-max",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "varname": "snareBodyDecay-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 430.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange snareBodyDecay max"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "text": "Body FM"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-min-label",
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
                    "id": "snareBodyFM-min",
                    "maxclass": "flonum",
                    "maximum": 16.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "varname": "snareBodyFM-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 585.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange snareBodyFM min"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-max-label",
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
                    "id": "snareBodyFM-max",
                    "maxclass": "flonum",
                    "maximum": 16.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "varname": "snareBodyFM-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyFM-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 710.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange snareBodyFM max"
                }
            },
            {
                "box": {
                    "id": "range-route",
                    "linecount": 4,
                    "maxclass": "newobj",
                    "numinlets": 25,
                    "numoutlets": 25,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 260.0, 1120.0, 780.0, 62.0 ],
                    "text": "route snareBodyHz-min snareBodyHz-max snareBodyDecay-min snareBodyDecay-max snareBodyFM-min snareBodyFM-max snareBodyBend-min snareBodyBend-max snareNoiseDecay-min snareNoiseDecay-max snareNoiseHz-min snareNoiseHz-max snareSnap-min snareSnap-max snareDrive-min snareDrive-max snareBodyLevel-min snareBodyLevel-max snareNoiseLevel-min snareNoiseLevel-max snareNoiseQ-min snareNoiseQ-max snareLevel-min snareLevel-max"
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
                    "varname": "snare_grid_range_presets"
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
                    "id": "snare-param-snareBodyBend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1330.0, 210.0, 22.0 ],
                    "text": "prepend bodyBend"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareNoiseDecay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareNoiseHz",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend noiseHz"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareSnap",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend snap"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareDrive",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend drive"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareBodyLevel",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend bodyLevel"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareNoiseLevel",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend noiseLevel"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareNoiseQ",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend noiseQ"
                }
            },
            {
                "box": {
                    "id": "snare-param-snareLevel",
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
                    "id": "snareBodyBend-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "text": "Body bend · Hz"
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-min-label",
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
                    "id": "snareBodyBend-min",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 845.0, 80.0, 22.0 ],
                    "varname": "snareBodyBend-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareBodyBend min"
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-max-label",
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
                    "id": "snareBodyBend-max",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 845.0, 80.0, 22.0 ],
                    "varname": "snareBodyBend-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyBend-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareBodyBend max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "text": "Noise decay · ms"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-min-label",
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
                    "id": "snareNoiseDecay-min",
                    "maxclass": "flonum",
                    "maximum": 10000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "varname": "snareNoiseDecay-min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseDecay min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-max-label",
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
                    "id": "snareNoiseDecay-max",
                    "maxclass": "flonum",
                    "maximum": 10000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "varname": "snareNoiseDecay-max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseDecay max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 763.0, 245.0, 20.0 ],
                    "text": "Noise frequency · Hz"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-min-label",
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
                    "id": "snareNoiseHz-min",
                    "maxclass": "flonum",
                    "maximum": 18000.0,
                    "minimum": 100.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 785.0, 80.0, 22.0 ],
                    "varname": "snareNoiseHz-min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseHz min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-max-label",
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
                    "id": "snareNoiseHz-max",
                    "maxclass": "flonum",
                    "maximum": 18000.0,
                    "minimum": 100.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 785.0, 80.0, 22.0 ],
                    "varname": "snareNoiseHz-max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseHz-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseHz max"
                }
            },
            {
                "box": {
                    "id": "snareSnap-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "text": "Snap"
                }
            },
            {
                "box": {
                    "id": "snareSnap-min-label",
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
                    "id": "snareSnap-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "varname": "snareSnap-min"
                }
            },
            {
                "box": {
                    "id": "snareSnap-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareSnap min"
                }
            },
            {
                "box": {
                    "id": "snareSnap-max-label",
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
                    "id": "snareSnap-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "varname": "snareSnap-max"
                }
            },
            {
                "box": {
                    "id": "snareSnap-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareSnap max"
                }
            },
            {
                "box": {
                    "id": "snareDrive-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "text": "Drive"
                }
            },
            {
                "box": {
                    "id": "snareDrive-min-label",
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
                    "id": "snareDrive-min",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "varname": "snareDrive-min"
                }
            },
            {
                "box": {
                    "id": "snareDrive-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareDrive min"
                }
            },
            {
                "box": {
                    "id": "snareDrive-max-label",
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
                    "id": "snareDrive-max",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "varname": "snareDrive-max"
                }
            },
            {
                "box": {
                    "id": "snareDrive-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareDrive max"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "text": "Body level"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-min-label",
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
                    "id": "snareBodyLevel-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 725.0, 80.0, 22.0 ],
                    "varname": "snareBodyLevel-min"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareBodyLevel min"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-max-label",
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
                    "id": "snareBodyLevel-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 725.0, 80.0, 22.0 ],
                    "varname": "snareBodyLevel-max"
                }
            },
            {
                "box": {
                    "id": "snareBodyLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareBodyLevel max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "text": "Noise level"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-min-label",
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
                    "id": "snareNoiseLevel-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 785.0, 80.0, 22.0 ],
                    "varname": "snareNoiseLevel-min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseLevel min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-max-label",
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
                    "id": "snareNoiseLevel-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 785.0, 80.0, 22.0 ],
                    "varname": "snareNoiseLevel-max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseLevel max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 823.0, 245.0, 20.0 ],
                    "text": "Noise Q"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-min-label",
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
                    "id": "snareNoiseQ-min",
                    "maxclass": "flonum",
                    "maximum": 20.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 845.0, 80.0, 22.0 ],
                    "varname": "snareNoiseQ-min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseQ min"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-max-label",
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
                    "id": "snareNoiseQ-max",
                    "maxclass": "flonum",
                    "maximum": 20.0,
                    "minimum": 0.5,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 845.0, 80.0, 22.0 ],
                    "varname": "snareNoiseQ-max"
                }
            },
            {
                "box": {
                    "id": "snareNoiseQ-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareNoiseQ max"
                }
            },
            {
                "box": {
                    "id": "snareLevel-range-label",
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
                    "id": "snareLevel-min-label",
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
                    "id": "snareLevel-min",
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
                    "varname": "snareLevel-min"
                }
            },
            {
                "box": {
                    "id": "snareLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareLevel min"
                }
            },
            {
                "box": {
                    "id": "snareLevel-max-label",
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
                    "id": "snareLevel-max",
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
                    "varname": "snareLevel-max"
                }
            },
            {
                "box": {
                    "id": "snareLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange snareLevel max"
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
                    "text": "Body"
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
                    "text": "Noise"
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
                    "text": "Mix / output"
                }
            },
            {
                "box": {
                    "id": "control-bodyHz-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend bodyHz"
                }
            },
            {
                "box": {
                    "id": "control-bodyHz-set",
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
                    "id": "control-bodyDecayMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend bodyDecayMs"
                }
            },
            {
                "box": {
                    "id": "control-bodyDecayMs-set",
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
                    "id": "control-bodyFM-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend bodyFM"
                }
            },
            {
                "box": {
                    "id": "control-bodyFM-set",
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
                    "id": "control-bodyBend-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend bodyBend"
                }
            },
            {
                "box": {
                    "id": "control-bodyBend-set",
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
                    "id": "control-noiseDecayMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1770.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 1800.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-noiseHz-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend noiseHz"
                }
            },
            {
                "box": {
                    "id": "control-noiseHz-set",
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
                    "id": "control-snap-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend snap"
                }
            },
            {
                "box": {
                    "id": "control-snap-set",
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
                    "id": "control-drive-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1770.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 745.0, 1800.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-bodyLevel-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend bodyLevel"
                }
            },
            {
                "box": {
                    "id": "control-bodyLevel-set",
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
                    "id": "control-noiseLevel-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend noiseLevel"
                }
            },
            {
                "box": {
                    "id": "control-noiseLevel-set",
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
                    "id": "control-noiseQ-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend noiseQ"
                }
            },
            {
                "box": {
                    "id": "control-noiseQ-set",
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
                    "id": "snare-ui-unpack",
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
                    "text": "r~ mlr_drum_es9_active"
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
                    "destination": [ "control-bodyBend-pre", 0 ],
                    "source": [ "control-bodyBend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-bodyBend-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyBend", 0 ],
                    "source": [ "control-bodyBend-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyDecayMs-pre", 0 ],
                    "source": [ "control-bodyDecayMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-bodyDecayMs-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyDecayMs", 0 ],
                    "source": [ "control-bodyDecayMs-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyFM-pre", 0 ],
                    "source": [ "control-bodyFM", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-bodyFM-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyFM", 0 ],
                    "source": [ "control-bodyFM-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyHz-pre", 0 ],
                    "source": [ "control-bodyHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-bodyHz-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyHz", 0 ],
                    "source": [ "control-bodyHz-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyLevel-pre", 0 ],
                    "source": [ "control-bodyLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-bodyLevel-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyLevel", 0 ],
                    "source": [ "control-bodyLevel-set", 0 ]
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
                    "destination": [ "snare-manual", 0 ],
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
                    "destination": [ "control-level-pre", 0 ],
                    "source": [ "control-level", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
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
                    "destination": [ "control-noiseDecayMs-pre", 0 ],
                    "source": [ "control-noiseDecayMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
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
                    "destination": [ "control-noiseHz-pre", 0 ],
                    "source": [ "control-noiseHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-noiseHz-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseHz", 0 ],
                    "source": [ "control-noiseHz-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseLevel-pre", 0 ],
                    "source": [ "control-noiseLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-noiseLevel-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseLevel", 0 ],
                    "source": [ "control-noiseLevel-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseQ-pre", 0 ],
                    "source": [ "control-noiseQ", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-noiseQ-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseQ", 0 ],
                    "source": [ "control-noiseQ-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-snap-pre", 0 ],
                    "source": [ "control-snap", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "control-snap-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-snap", 0 ],
                    "source": [ "control-snap-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
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
                    "destination": [ "snare-manual", 0 ],
                    "source": [ "obj-hollow", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual", 0 ],
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
                    "destination": [ "snare-manual", 0 ],
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
                    "destination": [ "snare-fire", 0 ],
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
                    "destination": [ "snareBodyBend-max", 0 ],
                    "order": 17,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyBend-min", 0 ],
                    "order": 21,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyDecay-max", 0 ],
                    "order": 18,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyDecay-min", 0 ],
                    "order": 22,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyFM-max", 0 ],
                    "order": 11,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyFM-min", 0 ],
                    "order": 15,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyHz-max", 0 ],
                    "order": 19,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyHz-min", 0 ],
                    "order": 23,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyLevel-max", 0 ],
                    "order": 3,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyLevel-min", 0 ],
                    "order": 7,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareDrive-max", 0 ],
                    "order": 8,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareDrive-min", 0 ],
                    "order": 12,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareLevel-max", 0 ],
                    "order": 0,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareLevel-min", 0 ],
                    "order": 4,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseDecay-max", 0 ],
                    "order": 16,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseDecay-min", 0 ],
                    "order": 20,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseHz-max", 0 ],
                    "order": 10,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseHz-min", 0 ],
                    "order": 14,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseLevel-max", 0 ],
                    "order": 2,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseLevel-min", 0 ],
                    "order": 6,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseQ-max", 0 ],
                    "order": 1,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseQ-min", 0 ],
                    "order": 5,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareSnap-max", 0 ],
                    "order": 9,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareSnap-min", 0 ],
                    "order": 13,
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
                    "destination": [ "snareBodyBend-max", 0 ],
                    "source": [ "range-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyBend-min", 0 ],
                    "source": [ "range-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyDecay-max", 0 ],
                    "source": [ "range-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyDecay-min", 0 ],
                    "source": [ "range-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyFM-max", 0 ],
                    "source": [ "range-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyFM-min", 0 ],
                    "source": [ "range-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyHz-max", 0 ],
                    "source": [ "range-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyHz-min", 0 ],
                    "source": [ "range-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyLevel-max", 0 ],
                    "source": [ "range-route", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyLevel-min", 0 ],
                    "source": [ "range-route", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareDrive-max", 0 ],
                    "source": [ "range-route", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareDrive-min", 0 ],
                    "source": [ "range-route", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareLevel-max", 0 ],
                    "source": [ "range-route", 23 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareLevel-min", 0 ],
                    "source": [ "range-route", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseDecay-max", 0 ],
                    "source": [ "range-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseDecay-min", 0 ],
                    "source": [ "range-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseHz-max", 0 ],
                    "source": [ "range-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseHz-min", 0 ],
                    "source": [ "range-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseLevel-max", 0 ],
                    "source": [ "range-route", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseLevel-min", 0 ],
                    "source": [ "range-route", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseQ-max", 0 ],
                    "source": [ "range-route", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseQ-min", 0 ],
                    "source": [ "range-route", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareSnap-max", 0 ],
                    "source": [ "range-route", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareSnap-min", 0 ],
                    "source": [ "range-route", 12 ]
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
            },
            {
                "patchline": {
                    "destination": [ "snare-ui-unpack", 0 ],
                    "order": 1,
                    "source": [ "snare-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-values", 1 ],
                    "order": 0,
                    "source": [ "snare-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-decay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "order": 0,
                    "source": [ "snare-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-sync", 0 ],
                    "order": 1,
                    "source": [ "snare-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-fire", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-values", 0 ],
                    "source": [ "snare-fire", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-fm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 0 ],
                    "order": 0,
                    "source": [ "snare-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-defer", 0 ],
                    "order": 1,
                    "source": [ "snare-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-manual-echo", 0 ],
                    "source": [ "snare-manual", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-route", 0 ],
                    "source": [ "snare-manual", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-router", 0 ],
                    "source": [ "snare-manual-echo", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-route", 0 ],
                    "source": [ "snare-owned", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareBodyBend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareBodyLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareDrive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareNoiseDecay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareNoiseHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareNoiseLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareNoiseQ", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-param-snareSnap", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-pitch", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "snare-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 11 ],
                    "source": [ "snare-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 10 ],
                    "source": [ "snare-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 9 ],
                    "source": [ "snare-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 8 ],
                    "source": [ "snare-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 7 ],
                    "source": [ "snare-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 6 ],
                    "source": [ "snare-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 5 ],
                    "source": [ "snare-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 4 ],
                    "source": [ "snare-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 3 ],
                    "source": [ "snare-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 2 ],
                    "source": [ "snare-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 1 ],
                    "source": [ "snare-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 0 ],
                    "source": [ "snare-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-step-unpack", 0 ],
                    "source": [ "snare-step", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 11 ],
                    "source": [ "snare-step-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 10 ],
                    "source": [ "snare-step-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 9 ],
                    "source": [ "snare-step-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 8 ],
                    "source": [ "snare-step-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 7 ],
                    "source": [ "snare-step-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 6 ],
                    "source": [ "snare-step-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 5 ],
                    "source": [ "snare-step-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 4 ],
                    "source": [ "snare-step-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 3 ],
                    "source": [ "snare-step-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 2 ],
                    "source": [ "snare-step-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 1 ],
                    "source": [ "snare-step-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-cache", 0 ],
                    "source": [ "snare-step-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-router", 0 ],
                    "source": [ "snare-sync", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyBend-set", 0 ],
                    "source": [ "snare-ui-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyDecayMs-set", 0 ],
                    "source": [ "snare-ui-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyFM-set", 0 ],
                    "source": [ "snare-ui-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyHz-set", 0 ],
                    "source": [ "snare-ui-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bodyLevel-set", 0 ],
                    "source": [ "snare-ui-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-drive-set", 0 ],
                    "source": [ "snare-ui-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-level-set", 0 ],
                    "source": [ "snare-ui-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseDecayMs-set", 0 ],
                    "source": [ "snare-ui-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseHz-set", 0 ],
                    "source": [ "snare-ui-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseLevel-set", 0 ],
                    "source": [ "snare-ui-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseQ-set", 0 ],
                    "source": [ "snare-ui-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-snap-set", 0 ],
                    "source": [ "snare-ui-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-decay", 0 ],
                    "source": [ "snare-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-fm", 0 ],
                    "source": [ "snare-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareBodyBend", 0 ],
                    "source": [ "snare-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareBodyLevel", 0 ],
                    "source": [ "snare-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareDrive", 0 ],
                    "source": [ "snare-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareLevel", 0 ],
                    "source": [ "snare-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareNoiseDecay", 0 ],
                    "source": [ "snare-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareNoiseHz", 0 ],
                    "source": [ "snare-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareNoiseLevel", 0 ],
                    "source": [ "snare-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareNoiseQ", 0 ],
                    "source": [ "snare-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-param-snareSnap", 0 ],
                    "source": [ "snare-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-pitch", 0 ],
                    "source": [ "snare-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snare-unpack", 0 ],
                    "source": [ "snare-values", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyBend-max-pre", 0 ],
                    "source": [ "snareBodyBend-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyBend-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyBend-min-pre", 0 ],
                    "source": [ "snareBodyBend-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyBend-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyDecay-max-pre", 0 ],
                    "source": [ "snareBodyDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyDecay-min-pre", 0 ],
                    "source": [ "snareBodyDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyFM-max-pre", 0 ],
                    "source": [ "snareBodyFM-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyFM-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyFM-min-pre", 0 ],
                    "source": [ "snareBodyFM-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyFM-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyHz-max-pre", 0 ],
                    "source": [ "snareBodyHz-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyHz-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyHz-min-pre", 0 ],
                    "source": [ "snareBodyHz-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyHz-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyLevel-max-pre", 0 ],
                    "source": [ "snareBodyLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareBodyLevel-min-pre", 0 ],
                    "source": [ "snareBodyLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareBodyLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareDrive-max-pre", 0 ],
                    "source": [ "snareDrive-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareDrive-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareDrive-min-pre", 0 ],
                    "source": [ "snareDrive-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareDrive-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareLevel-max-pre", 0 ],
                    "source": [ "snareLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareLevel-min-pre", 0 ],
                    "source": [ "snareLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseDecay-max-pre", 0 ],
                    "source": [ "snareNoiseDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseDecay-min-pre", 0 ],
                    "source": [ "snareNoiseDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseHz-max-pre", 0 ],
                    "source": [ "snareNoiseHz-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseHz-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseHz-min-pre", 0 ],
                    "source": [ "snareNoiseHz-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseHz-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseLevel-max-pre", 0 ],
                    "source": [ "snareNoiseLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseLevel-min-pre", 0 ],
                    "source": [ "snareNoiseLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseQ-max-pre", 0 ],
                    "source": [ "snareNoiseQ-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseQ-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareNoiseQ-min-pre", 0 ],
                    "source": [ "snareNoiseQ-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareNoiseQ-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareSnap-max-pre", 0 ],
                    "source": [ "snareSnap-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareSnap-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snareSnap-min-pre", 0 ],
                    "source": [ "snareSnap-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "snareSnap-min-pre", 0 ]
                }
            }
        ]
    }
}