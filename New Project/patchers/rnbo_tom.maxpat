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
                    "text": "RNBO Tom laboratory"
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
                    "text": "Track 11 triggers the tom. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "tom_trigger"
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
                    "text": "r 12input"
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
                    "text": "r rnbo_tom_trigger"
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
                    "text": "pitchHz 90, decayMs 650, bendHz 110, bendDecayMs 35, fmAmount 0.25, fmRatio 1.5, modeRatio 1.59, modeLevel 0.25, noiseLevel 0.08, noiseDecayMs 12, drive 1.3, level 0.5",
                    "varname": "tom_preset_deep"
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
                    "text": "pitchHz 210, decayMs 280, bendHz 240, bendDecayMs 35, fmAmount 0.5, fmRatio 1.5, modeRatio 1.59, modeLevel 0.35, noiseLevel 0.08, noiseDecayMs 12, drive 1.3, level 0.5",
                    "varname": "tom_preset_knock"
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
                    "text": "pitchHz 75, decayMs 1100, bendHz 850, bendDecayMs 180, fmAmount 2.4, fmRatio 2.7, modeRatio 1.59, modeLevel 0.25, noiseLevel 0.08, noiseDecayMs 12, drive 1.3, level 0.5",
                    "varname": "tom_preset_hollow"
                }
            },
            {
                "box": {
                    "id": "obj-presets",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 340.0, 100.0, 220.0, 20.0 ],
                    "text": "starting sounds: Floor / Rack / Laser"
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
                    "text": "r rnbo_tom_param"
                }
            },
            {
                "box": {
                    "id": "obj-paramnote",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 465.0, 237.0, 300.0, 20.0 ],
                    "text": "parameter bus: pitchHz 140"
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
                        "title": "mlr-tom",
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
                                                "displayName": "modeLevel",
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
                                    "text": "p @file rnbo_tom_voice"
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
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_tom_voice.rnbopat"
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
                                    "text": "param pitchHz 140 @min 30 @max 1600 @unit Hz",
                                    "varname": "pitchHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bendDecayMs",
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
                                    "rnbo_uniqueid": "bendDecayMs",
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
                                    "text": "param bendDecayMs 35 @min 1 @max 500 @unit ms",
                                    "varname": "bendDecayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-fmAmount",
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
                                    "text": "param fmAmount 0.5 @min 0 @max 10",
                                    "varname": "fmAmount"
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
                                    "text": "param decayMs 450 @min 10 @max 6000 @unit ms",
                                    "varname": "decayMs"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-bendHz",
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
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
                                    },
                                    "rnbo_serial": 5,
                                    "rnbo_uniqueid": "bendHz",
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
                                    "text": "param bendHz 160 @min 0 @max 1200 @unit Hz",
                                    "varname": "bendHz"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-fmRatio",
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
                                        "unit": "",
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
                                    },
                                    "rnbo_serial": 6,
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
                                    "text": "param fmRatio 1.5 @min 0.25 @max 8",
                                    "varname": "fmRatio"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-noiseLevel",
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
                                    "text": "param noiseLevel 0.08 @min 0 @max 1",
                                    "varname": "noiseLevel"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-noiseDecayMs",
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
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
                                    },
                                    "rnbo_serial": 8,
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
                                    "text": "param noiseDecayMs 12 @min 1 @max 500 @unit ms",
                                    "varname": "noiseDecayMs"
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
                                    "text": "param drive 1.3 @min 0.25 @max 8",
                                    "varname": "drive"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-modeRatio",
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
                                    "text": "param modeRatio 1.59 @min 1 @max 5",
                                    "varname": "modeRatio"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-modeLevel",
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
                                    "text": "param modeLevel 0.25 @min 0 @max 1",
                                    "varname": "modeLevel"
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
                                    "text": "param level 0.5 @min 0 @max 1",
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
                                    "destination": [ "rnbo-voice", 4 ],
                                    "source": [ "rnbo-param-bendDecayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 3 ],
                                    "source": [ "rnbo-param-bendHz", 0 ]
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
                                    "destination": [ "rnbo-voice", 5 ],
                                    "source": [ "rnbo-param-fmAmount", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 6 ],
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
                                    "destination": [ "rnbo-voice", 8 ],
                                    "source": [ "rnbo-param-modeLevel", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 7 ],
                                    "source": [ "rnbo-param-modeRatio", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 10 ],
                                    "source": [ "rnbo-param-noiseDecayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 9 ],
                                    "source": [ "rnbo-param-noiseLevel", 0 ]
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
                        },
                        "bendDecayMs": {
                            "label": "bendDecayMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "noiseLevel": {
                            "label": "noiseLevel",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "bendHz": {
                            "label": "bendHz",
                            "isEnum": 0,
                            "parsestring": ""
                        }
                    },
                    "rnboversion": "1.4.5",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "tom_rnbo",
                            "parameter_modmode": 0,
                            "parameter_shortname": "tom_rnbo",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "optimization": "O1",
                        "parameter_enable": 1,
                        "uuid": "a4309f8a-c5a8-6c78-8c23-912c01af70da"
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
                                "value": 0.5
                            },
                            "modeLevel": {
                                "value": 0.25
                            },
                            "modeRatio": {
                                "value": 1.59
                            },
                            "drive": {
                                "value": 1.3
                            },
                            "__presetid": "mlr-tom",
                            "noiseLevel": {
                                "value": 0.08
                            },
                            "fmRatio": {
                                "value": 1.5
                            },
                            "bendHz": {
                                "value": 160.0
                            },
                            "decayMs": {
                                "value": 450.0
                            },
                            "fmAmount": {
                                "value": 0.5
                            },
                            "noiseDecayMs": {
                                "value": 12.0
                            },
                            "bendDecayMs": {
                                "value": 35.0
                            },
                            "__sps": {
                                "p_rnbo-voice": {                                }
                            },
                            "pitchHz": {
                                "value": 140.0
                            }
                        },
                        "snapshotlist": {
                            "current_snapshot": 0,
                            "entries": [
                                {
                                    "filetype": "C74Snapshot",
                                    "version": 2,
                                    "minorversion": 0,
                                    "name": "mlr-tom",
                                    "origin": "mlr-tom",
                                    "type": "rnbo",
                                    "subtype": "",
                                    "embed": 0,
                                    "snapshot": {
                                        "level": {
                                            "value": 0.5
                                        },
                                        "modeLevel": {
                                            "value": 0.25
                                        },
                                        "modeRatio": {
                                            "value": 1.59
                                        },
                                        "drive": {
                                            "value": 1.3
                                        },
                                        "__presetid": "mlr-tom",
                                        "noiseLevel": {
                                            "value": 0.08
                                        },
                                        "fmRatio": {
                                            "value": 1.5
                                        },
                                        "bendHz": {
                                            "value": 160.0
                                        },
                                        "decayMs": {
                                            "value": 450.0
                                        },
                                        "fmAmount": {
                                            "value": 0.5
                                        },
                                        "noiseDecayMs": {
                                            "value": 12.0
                                        },
                                        "bendDecayMs": {
                                            "value": 35.0
                                        },
                                        "__sps": {
                                            "p_rnbo-voice": {                                            }
                                        },
                                        "pitchHz": {
                                            "value": 140.0
                                        }
                                    },
                                    "fileref": {
                                        "name": "mlr-tom",
                                        "filename": "mlr-tom.maxsnap",
                                        "filepath": "~/Projects/mlr/New Project/data",
                                        "filepos": -1,
                                        "snapshotfileid": "5b82840feffdc429aafbe95b934962fd"
                                    }
                                }
                            ]
                        }
                    },
                    "text": "rnbo~ @title mlr-tom @dumpoutlet 1",
                    "varname": "tom_rnbo"
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
                    "text": "s~ rnbo_tom_left"
                }
            },
            {
                "box": {
                    "id": "obj-sendright",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 470.0, 420.0, 120.0, 22.0 ],
                    "text": "s~ rnbo_tom_right"
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
                    "text": "Floor"
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
                    "text": "Rack"
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
                    "text": "Laser"
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
                    "maximum": 1600.0,
                    "minimum": 30.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 243.0, 245.0, 22.0 ],
                    "varname": "tom_sound_pitchHz"
                }
            },
            {
                "box": {
                    "id": "label-bendDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 424.0, 245.0, 20.0 ],
                    "text": "Bend decay · ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bendDecayMs",
                    "maxclass": "flonum",
                    "maximum": 500.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 447.0, 245.0, 22.0 ],
                    "varname": "tom_sound_bendDecayMs"
                }
            },
            {
                "box": {
                    "id": "label-fmAmount",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 220.0, 245.0, 20.0 ],
                    "text": "FM amount"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-fmAmount",
                    "maxclass": "flonum",
                    "maximum": 10.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 243.0, 245.0, 22.0 ],
                    "varname": "tom_sound_fmAmount"
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
                    "maximum": 6000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 311.0, 245.0, 22.0 ],
                    "varname": "tom_sound_decayMs"
                }
            },
            {
                "box": {
                    "id": "label-bendHz",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 356.0, 245.0, 20.0 ],
                    "text": "Pitch bend · Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bendHz",
                    "maxclass": "flonum",
                    "maximum": 1200.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 379.0, 245.0, 22.0 ],
                    "varname": "tom_sound_bendHz"
                }
            },
            {
                "box": {
                    "id": "label-fmRatio",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 288.0, 245.0, 20.0 ],
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
                    "patching_rect": [ 1160.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 311.0, 245.0, 22.0 ],
                    "varname": "tom_sound_fmRatio"
                }
            },
            {
                "box": {
                    "id": "label-noiseLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 220.0, 245.0, 20.0 ],
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
                    "patching_rect": [ 1160.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 243.0, 245.0, 22.0 ],
                    "varname": "tom_sound_noiseLevel"
                }
            },
            {
                "box": {
                    "id": "label-noiseDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 288.0, 245.0, 20.0 ],
                    "text": "Noise decay · ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-noiseDecayMs",
                    "maxclass": "flonum",
                    "maximum": 500.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 311.0, 245.0, 22.0 ],
                    "varname": "tom_sound_noiseDecayMs"
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
                    "varname": "tom_sound_drive"
                }
            },
            {
                "box": {
                    "id": "label-modeRatio",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 356.0, 245.0, 20.0 ],
                    "text": "Shell ratio"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-modeRatio",
                    "maxclass": "flonum",
                    "maximum": 5.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 379.0, 245.0, 22.0 ],
                    "varname": "tom_sound_modeRatio"
                }
            },
            {
                "box": {
                    "id": "label-modeLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 424.0, 245.0, 20.0 ],
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
                    "patching_rect": [ 1420.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 447.0, 245.0, 22.0 ],
                    "varname": "tom_sound_modeLevel"
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
                    "varname": "tom_sound_level"
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
                    "text": "r rnbo_tom_repeat"
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
                    "patching_rect": [ 80.0, 480.0, 326.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 82.0, 532.0, 326.0, 33.0 ],
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_tom_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "tom-manual",
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
                    "id": "tom-manual-echo",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 800.0, 210.0, 22.0 ],
                    "text": "prepend tomManual"
                }
            },
            {
                "box": {
                    "id": "tom-router",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 840.0, 210.0, 22.0 ],
                    "text": "s gridrouter"
                }
            },
            {
                "box": {
                    "id": "tom-route",
                    "linecount": 4,
                    "maxclass": "newobj",
                    "numinlets": 13,
                    "numoutlets": 13,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 260.0, 800.0, 210.0, 62.0 ],
                    "text": "route pitchHz decayMs bendHz bendDecayMs fmAmount fmRatio modeRatio modeLevel noiseLevel noiseDecayMs drive level"
                }
            },
            {
                "box": {
                    "id": "tom-cache",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 850.0, 308.0, 22.0 ],
                    "text": "pak 140. 450. 160. 35. 0.5 1.5 1.59 0.25 0.08 12. 1.3 0.5"
                }
            },
            {
                "box": {
                    "id": "tom-unpack",
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
                    "id": "tom-pitch",
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
                    "id": "tom-decay",
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
                    "id": "tom-fm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend bendHz"
                }
            },
            {
                "box": {
                    "id": "tom-owned",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_tom_owned_param"
                }
            },
            {
                "box": {
                    "id": "tom-step",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_tom_step"
                }
            },
            {
                "box": {
                    "id": "tom-step-unpack",
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
                    "id": "tom-fire",
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
                    "id": "tom-load",
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
                    "id": "tom-defer",
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
                    "id": "tom-sync",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 970.0, 210.0, 22.0 ],
                    "text": "tomSync"
                }
            },
            {
                "box": {
                    "id": "tom-values",
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
                    "text": "Grid mapping ranges · all twelve tom parameters"
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
                    "filename": "tom_lab_ranges.js",
                    "id": "range-script",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 20.0, 1120.0, 185.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 tom_lab_ranges.js",
                    "textfile": {
                        "filename": "tom_lab_ranges.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "tomPitch-range-label",
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
                    "id": "tomPitch-min-label",
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
                    "id": "tomPitch-min",
                    "maxclass": "flonum",
                    "maximum": 1600.0,
                    "minimum": 30.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "varname": "tomPitch-min"
                }
            },
            {
                "box": {
                    "id": "tomPitch-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange tomPitch min"
                }
            },
            {
                "box": {
                    "id": "tomPitch-max-label",
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
                    "id": "tomPitch-max",
                    "maxclass": "flonum",
                    "maximum": 1600.0,
                    "minimum": 30.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "varname": "tomPitch-max"
                }
            },
            {
                "box": {
                    "id": "tomPitch-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange tomPitch max"
                }
            },
            {
                "box": {
                    "id": "tomDecay-range-label",
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
                    "id": "tomDecay-min-label",
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
                    "id": "tomDecay-min",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "varname": "tomDecay-min"
                }
            },
            {
                "box": {
                    "id": "tomDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 305.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange tomDecay min"
                }
            },
            {
                "box": {
                    "id": "tomDecay-max-label",
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
                    "id": "tomDecay-max",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "varname": "tomDecay-max"
                }
            },
            {
                "box": {
                    "id": "tomDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 430.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange tomDecay max"
                }
            },
            {
                "box": {
                    "id": "tomBend-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "text": "Pitch bend · Hz"
                }
            },
            {
                "box": {
                    "id": "tomBend-min-label",
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
                    "id": "tomBend-min",
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
                    "varname": "tomBend-min"
                }
            },
            {
                "box": {
                    "id": "tomBend-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 585.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange tomBend min"
                }
            },
            {
                "box": {
                    "id": "tomBend-max-label",
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
                    "id": "tomBend-max",
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
                    "varname": "tomBend-max"
                }
            },
            {
                "box": {
                    "id": "tomBend-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 710.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange tomBend max"
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
                    "text": "route tomPitch-min tomPitch-max tomDecay-min tomDecay-max tomBend-min tomBend-max tomBendDecay-min tomBendDecay-max tomFM-min tomFM-max tomRatio-min tomRatio-max tomModeRatio-min tomModeRatio-max tomModeLevel-min tomModeLevel-max tomNoise-min tomNoise-max tomNoiseDecay-min tomNoiseDecay-max tomDrive-min tomDrive-max tomLevel-min tomLevel-max"
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
                    "varname": "tom_grid_range_presets"
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
                    "id": "tom-param-tomBendDecay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1330.0, 210.0, 22.0 ],
                    "text": "prepend bendDecayMs"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomFM",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend fmAmount"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomRatio",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend fmRatio"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomModeRatio",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend modeRatio"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomModeLevel",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend modeLevel"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomNoise",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend noiseLevel"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomNoiseDecay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend noiseDecayMs"
                }
            },
            {
                "box": {
                    "id": "tom-param-tomDrive",
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
                    "id": "tom-param-tomLevel",
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
                    "id": "tomBendDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "text": "Bend decay · ms"
                }
            },
            {
                "box": {
                    "id": "tomBendDecay-min-label",
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
                    "id": "tomBendDecay-min",
                    "maxclass": "flonum",
                    "maximum": 500.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "varname": "tomBendDecay-min"
                }
            },
            {
                "box": {
                    "id": "tomBendDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomBendDecay min"
                }
            },
            {
                "box": {
                    "id": "tomBendDecay-max-label",
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
                    "id": "tomBendDecay-max",
                    "maxclass": "flonum",
                    "maximum": 500.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "varname": "tomBendDecay-max"
                }
            },
            {
                "box": {
                    "id": "tomBendDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomBendDecay max"
                }
            },
            {
                "box": {
                    "id": "tomFM-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "text": "FM amount"
                }
            },
            {
                "box": {
                    "id": "tomFM-min-label",
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
                    "id": "tomFM-min",
                    "maxclass": "flonum",
                    "maximum": 10.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "varname": "tomFM-min"
                }
            },
            {
                "box": {
                    "id": "tomFM-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomFM min"
                }
            },
            {
                "box": {
                    "id": "tomFM-max-label",
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
                    "id": "tomFM-max",
                    "maxclass": "flonum",
                    "maximum": 10.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "varname": "tomFM-max"
                }
            },
            {
                "box": {
                    "id": "tomFM-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomFM max"
                }
            },
            {
                "box": {
                    "id": "tomRatio-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 763.0, 245.0, 20.0 ],
                    "text": "FM ratio"
                }
            },
            {
                "box": {
                    "id": "tomRatio-min-label",
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
                    "id": "tomRatio-min",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 785.0, 80.0, 22.0 ],
                    "varname": "tomRatio-min"
                }
            },
            {
                "box": {
                    "id": "tomRatio-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomRatio min"
                }
            },
            {
                "box": {
                    "id": "tomRatio-max-label",
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
                    "id": "tomRatio-max",
                    "maxclass": "flonum",
                    "maximum": 8.0,
                    "minimum": 0.25,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 785.0, 80.0, 22.0 ],
                    "varname": "tomRatio-max"
                }
            },
            {
                "box": {
                    "id": "tomRatio-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomRatio max"
                }
            },
            {
                "box": {
                    "id": "tomModeRatio-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "text": "Shell ratio"
                }
            },
            {
                "box": {
                    "id": "tomModeRatio-min-label",
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
                    "id": "tomModeRatio-min",
                    "maxclass": "flonum",
                    "maximum": 5.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "varname": "tomModeRatio-min"
                }
            },
            {
                "box": {
                    "id": "tomModeRatio-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomModeRatio min"
                }
            },
            {
                "box": {
                    "id": "tomModeRatio-max-label",
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
                    "id": "tomModeRatio-max",
                    "maxclass": "flonum",
                    "maximum": 5.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "varname": "tomModeRatio-max"
                }
            },
            {
                "box": {
                    "id": "tomModeRatio-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomModeRatio max"
                }
            },
            {
                "box": {
                    "id": "tomModeLevel-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "text": "Shell level"
                }
            },
            {
                "box": {
                    "id": "tomModeLevel-min-label",
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
                    "id": "tomModeLevel-min",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "varname": "tomModeLevel-min"
                }
            },
            {
                "box": {
                    "id": "tomModeLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomModeLevel min"
                }
            },
            {
                "box": {
                    "id": "tomModeLevel-max-label",
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
                    "id": "tomModeLevel-max",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "varname": "tomModeLevel-max"
                }
            },
            {
                "box": {
                    "id": "tomModeLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomModeLevel max"
                }
            },
            {
                "box": {
                    "id": "tomNoise-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "text": "Noise level"
                }
            },
            {
                "box": {
                    "id": "tomNoise-min-label",
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
                    "id": "tomNoise-min",
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
                    "varname": "tomNoise-min"
                }
            },
            {
                "box": {
                    "id": "tomNoise-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomNoise min"
                }
            },
            {
                "box": {
                    "id": "tomNoise-max-label",
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
                    "id": "tomNoise-max",
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
                    "varname": "tomNoise-max"
                }
            },
            {
                "box": {
                    "id": "tomNoise-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomNoise max"
                }
            },
            {
                "box": {
                    "id": "tomNoiseDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "text": "Noise decay · ms"
                }
            },
            {
                "box": {
                    "id": "tomNoiseDecay-min-label",
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
                    "id": "tomNoiseDecay-min",
                    "maxclass": "flonum",
                    "maximum": 500.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 625.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 625.0, 785.0, 80.0, 22.0 ],
                    "varname": "tomNoiseDecay-min"
                }
            },
            {
                "box": {
                    "id": "tomNoiseDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomNoiseDecay min"
                }
            },
            {
                "box": {
                    "id": "tomNoiseDecay-max-label",
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
                    "id": "tomNoiseDecay-max",
                    "maxclass": "flonum",
                    "maximum": 500.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 750.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 750.0, 785.0, 80.0, 22.0 ],
                    "varname": "tomNoiseDecay-max"
                }
            },
            {
                "box": {
                    "id": "tomNoiseDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomNoiseDecay max"
                }
            },
            {
                "box": {
                    "id": "tomDrive-range-label",
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
                    "id": "tomDrive-min-label",
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
                    "id": "tomDrive-min",
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
                    "varname": "tomDrive-min"
                }
            },
            {
                "box": {
                    "id": "tomDrive-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomDrive min"
                }
            },
            {
                "box": {
                    "id": "tomDrive-max-label",
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
                    "id": "tomDrive-max",
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
                    "varname": "tomDrive-max"
                }
            },
            {
                "box": {
                    "id": "tomDrive-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomDrive max"
                }
            },
            {
                "box": {
                    "id": "tomLevel-range-label",
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
                    "id": "tomLevel-min-label",
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
                    "id": "tomLevel-min",
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
                    "varname": "tomLevel-min"
                }
            },
            {
                "box": {
                    "id": "tomLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomLevel min"
                }
            },
            {
                "box": {
                    "id": "tomLevel-max-label",
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
                    "id": "tomLevel-max",
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
                    "varname": "tomLevel-max"
                }
            },
            {
                "box": {
                    "id": "tomLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange tomLevel max"
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
                    "text": "Shell"
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
                    "id": "control-bendHz-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend bendHz"
                }
            },
            {
                "box": {
                    "id": "control-bendHz-set",
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
                    "id": "control-bendDecayMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend bendDecayMs"
                }
            },
            {
                "box": {
                    "id": "control-bendDecayMs-set",
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
                    "id": "control-fmAmount-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1770.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 1800.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 265.0, 1770.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 265.0, 1800.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 505.0, 1770.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 505.0, 1800.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 745.0, 1770.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 745.0, 1800.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 1840.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 1870.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 265.0, 1840.0, 210.0, 22.0 ],
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
                    "id": "tom-ui-unpack",
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
                    "destination": [ "control-bendDecayMs-pre", 0 ],
                    "source": [ "control-bendDecayMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual", 0 ],
                    "source": [ "control-bendDecayMs-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendDecayMs", 0 ],
                    "source": [ "control-bendDecayMs-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendHz-pre", 0 ],
                    "source": [ "control-bendHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual", 0 ],
                    "source": [ "control-bendHz-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendHz", 0 ],
                    "source": [ "control-bendHz-set", 0 ]
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "control-fmAmount-pre", 0 ],
                    "source": [ "control-fmAmount", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "control-noiseLevel-pre", 0 ],
                    "source": [ "control-noiseLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "control-pitchHz-pre", 0 ],
                    "source": [ "control-pitchHz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
                    "source": [ "obj-hollow", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-manual", 0 ],
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
                    "destination": [ "tom-fire", 0 ],
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
                    "destination": [ "tomBend-max", 0 ],
                    "order": 17,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBend-min", 0 ],
                    "order": 21,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBendDecay-max", 0 ],
                    "order": 16,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBendDecay-min", 0 ],
                    "order": 20,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDecay-max", 0 ],
                    "order": 18,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDecay-min", 0 ],
                    "order": 22,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDrive-max", 0 ],
                    "order": 1,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDrive-min", 0 ],
                    "order": 5,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomFM-max", 0 ],
                    "order": 11,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomFM-min", 0 ],
                    "order": 15,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomLevel-max", 0 ],
                    "order": 0,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomLevel-min", 0 ],
                    "order": 4,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeLevel-max", 0 ],
                    "order": 8,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeLevel-min", 0 ],
                    "order": 12,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeRatio-max", 0 ],
                    "order": 9,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeRatio-min", 0 ],
                    "order": 13,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoise-max", 0 ],
                    "order": 3,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoise-min", 0 ],
                    "order": 7,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoiseDecay-max", 0 ],
                    "order": 2,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoiseDecay-min", 0 ],
                    "order": 6,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomPitch-max", 0 ],
                    "order": 19,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomPitch-min", 0 ],
                    "order": 23,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomRatio-max", 0 ],
                    "order": 10,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomRatio-min", 0 ],
                    "order": 14,
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
                    "destination": [ "tomBend-max", 0 ],
                    "source": [ "range-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBend-min", 0 ],
                    "source": [ "range-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBendDecay-max", 0 ],
                    "source": [ "range-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBendDecay-min", 0 ],
                    "source": [ "range-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDecay-max", 0 ],
                    "source": [ "range-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDecay-min", 0 ],
                    "source": [ "range-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDrive-max", 0 ],
                    "source": [ "range-route", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDrive-min", 0 ],
                    "source": [ "range-route", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomFM-max", 0 ],
                    "source": [ "range-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomFM-min", 0 ],
                    "source": [ "range-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomLevel-max", 0 ],
                    "source": [ "range-route", 23 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomLevel-min", 0 ],
                    "source": [ "range-route", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeLevel-max", 0 ],
                    "source": [ "range-route", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeLevel-min", 0 ],
                    "source": [ "range-route", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeRatio-max", 0 ],
                    "source": [ "range-route", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeRatio-min", 0 ],
                    "source": [ "range-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoise-max", 0 ],
                    "source": [ "range-route", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoise-min", 0 ],
                    "source": [ "range-route", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoiseDecay-max", 0 ],
                    "source": [ "range-route", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoiseDecay-min", 0 ],
                    "source": [ "range-route", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomPitch-max", 0 ],
                    "source": [ "range-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomPitch-min", 0 ],
                    "source": [ "range-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomRatio-max", 0 ],
                    "source": [ "range-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomRatio-min", 0 ],
                    "source": [ "range-route", 10 ]
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
                    "destination": [ "tom-ui-unpack", 0 ],
                    "order": 1,
                    "source": [ "tom-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-values", 1 ],
                    "order": 0,
                    "source": [ "tom-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-decay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "order": 0,
                    "source": [ "tom-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-sync", 0 ],
                    "order": 1,
                    "source": [ "tom-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-fire", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-values", 0 ],
                    "source": [ "tom-fire", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-fm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 0 ],
                    "order": 0,
                    "source": [ "tom-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-defer", 0 ],
                    "order": 1,
                    "source": [ "tom-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-manual-echo", 0 ],
                    "source": [ "tom-manual", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-route", 0 ],
                    "source": [ "tom-manual", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-router", 0 ],
                    "source": [ "tom-manual-echo", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-route", 0 ],
                    "source": [ "tom-owned", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomBendDecay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomDrive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomFM", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomModeLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomModeRatio", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomNoise", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomNoiseDecay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-param-tomRatio", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-pitch", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "tom-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 11 ],
                    "source": [ "tom-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 10 ],
                    "source": [ "tom-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 9 ],
                    "source": [ "tom-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 8 ],
                    "source": [ "tom-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 7 ],
                    "source": [ "tom-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 6 ],
                    "source": [ "tom-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 5 ],
                    "source": [ "tom-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 4 ],
                    "source": [ "tom-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 3 ],
                    "source": [ "tom-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 2 ],
                    "source": [ "tom-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 1 ],
                    "source": [ "tom-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 0 ],
                    "source": [ "tom-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-step-unpack", 0 ],
                    "source": [ "tom-step", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 11 ],
                    "source": [ "tom-step-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 10 ],
                    "source": [ "tom-step-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 9 ],
                    "source": [ "tom-step-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 8 ],
                    "source": [ "tom-step-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 7 ],
                    "source": [ "tom-step-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 6 ],
                    "source": [ "tom-step-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 5 ],
                    "source": [ "tom-step-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 4 ],
                    "source": [ "tom-step-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 3 ],
                    "source": [ "tom-step-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 2 ],
                    "source": [ "tom-step-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 1 ],
                    "source": [ "tom-step-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-cache", 0 ],
                    "source": [ "tom-step-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-router", 0 ],
                    "source": [ "tom-sync", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendDecayMs-set", 0 ],
                    "source": [ "tom-ui-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendHz-set", 0 ],
                    "source": [ "tom-ui-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-decayMs-set", 0 ],
                    "source": [ "tom-ui-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-drive-set", 0 ],
                    "source": [ "tom-ui-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmAmount-set", 0 ],
                    "source": [ "tom-ui-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmRatio-set", 0 ],
                    "source": [ "tom-ui-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-level-set", 0 ],
                    "source": [ "tom-ui-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeLevel-set", 0 ],
                    "source": [ "tom-ui-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-modeRatio-set", 0 ],
                    "source": [ "tom-ui-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseDecayMs-set", 0 ],
                    "source": [ "tom-ui-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-noiseLevel-set", 0 ],
                    "source": [ "tom-ui-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-pitchHz-set", 0 ],
                    "source": [ "tom-ui-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-decay", 0 ],
                    "source": [ "tom-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-fm", 0 ],
                    "source": [ "tom-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomBendDecay", 0 ],
                    "source": [ "tom-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomDrive", 0 ],
                    "source": [ "tom-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomFM", 0 ],
                    "source": [ "tom-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomLevel", 0 ],
                    "source": [ "tom-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomModeLevel", 0 ],
                    "source": [ "tom-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomModeRatio", 0 ],
                    "source": [ "tom-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomNoise", 0 ],
                    "source": [ "tom-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomNoiseDecay", 0 ],
                    "source": [ "tom-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-param-tomRatio", 0 ],
                    "source": [ "tom-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-pitch", 0 ],
                    "source": [ "tom-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tom-unpack", 0 ],
                    "source": [ "tom-values", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBend-max-pre", 0 ],
                    "source": [ "tomBend-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomBend-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBend-min-pre", 0 ],
                    "source": [ "tomBend-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomBend-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBendDecay-max-pre", 0 ],
                    "source": [ "tomBendDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomBendDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomBendDecay-min-pre", 0 ],
                    "source": [ "tomBendDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomBendDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDecay-max-pre", 0 ],
                    "source": [ "tomDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDecay-min-pre", 0 ],
                    "source": [ "tomDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDrive-max-pre", 0 ],
                    "source": [ "tomDrive-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomDrive-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomDrive-min-pre", 0 ],
                    "source": [ "tomDrive-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomDrive-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomFM-max-pre", 0 ],
                    "source": [ "tomFM-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomFM-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomFM-min-pre", 0 ],
                    "source": [ "tomFM-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomFM-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomLevel-max-pre", 0 ],
                    "source": [ "tomLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomLevel-min-pre", 0 ],
                    "source": [ "tomLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeLevel-max-pre", 0 ],
                    "source": [ "tomModeLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomModeLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeLevel-min-pre", 0 ],
                    "source": [ "tomModeLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomModeLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeRatio-max-pre", 0 ],
                    "source": [ "tomModeRatio-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomModeRatio-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomModeRatio-min-pre", 0 ],
                    "source": [ "tomModeRatio-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomModeRatio-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoise-max-pre", 0 ],
                    "source": [ "tomNoise-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomNoise-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoise-min-pre", 0 ],
                    "source": [ "tomNoise-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomNoise-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoiseDecay-max-pre", 0 ],
                    "source": [ "tomNoiseDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomNoiseDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomNoiseDecay-min-pre", 0 ],
                    "source": [ "tomNoiseDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomNoiseDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomPitch-max-pre", 0 ],
                    "source": [ "tomPitch-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomPitch-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomPitch-min-pre", 0 ],
                    "source": [ "tomPitch-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomPitch-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomRatio-max-pre", 0 ],
                    "source": [ "tomRatio-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomRatio-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tomRatio-min-pre", 0 ],
                    "source": [ "tomRatio-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "tomRatio-min-pre", 0 ]
                }
            }
        ]
    }
}