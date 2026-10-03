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
                    "text": "RNBO FM Bass laboratory"
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
                    "text": "Track 8 triggers the bass. Leave its sample slot empty to hear the synth alone; other tracks let the current tail decay."
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
                    "varname": "bass_trigger"
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
                    "text": "r 9input"
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
                    "text": "r rnbo_bass_trigger"
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
                    "text": "note 36, decayMs 550, fmIndex 0.45, fmRatio 1, fmDecayMs 220, feedback 0.05, subLevel 0.65, brightness 0.4, attackMs 2, bendSemitones 0, drive 1.4, level 0.45",
                    "varname": "bass_preset_deep"
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
                    "text": "note 36, decayMs 450, fmIndex 2.8, fmRatio 1, fmDecayMs 160, feedback 0.15, subLevel 0.35, brightness 0.6, attackMs 2, bendSemitones 7, drive 1.4, level 0.45",
                    "varname": "bass_preset_knock"
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
                    "patching_rect": [ 340.0, 100.0, 220.0, 20.0 ],
                    "text": "starting sounds: Round / Rubber / Wire"
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
                    "text": "r rnbo_bass_param"
                }
            },
            {
                "box": {
                    "id": "obj-paramnote",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 465.0, 237.0, 300.0, 20.0 ],
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
                        "title": "mlr-bass",
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
                                                "displayName": "brightness",
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
                                    "text": "p @file rnbo_bass_voice"
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
                                    "text": "Exported params live here; reusable DSP core lives in rnbo_bass_voice.rnbopat"
                                }
                            },
                            {
                                "box": {
                                    "id": "rnbo-param-note",
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
                                        "tonormalized": "",
                                        "preset": 1,
                                        "exponent": 1.0
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
                                    "destination": [ "rnbo-voice", 9 ],
                                    "source": [ "rnbo-param-attackMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 10 ],
                                    "source": [ "rnbo-param-bendSemitones", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 8 ],
                                    "source": [ "rnbo-param-brightness", 0 ]
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
                                    "destination": [ "rnbo-voice", 6 ],
                                    "source": [ "rnbo-param-feedback", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 5 ],
                                    "source": [ "rnbo-param-fmDecayMs", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 3 ],
                                    "source": [ "rnbo-param-fmIndex", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 4 ],
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
                                    "destination": [ "rnbo-voice", 1 ],
                                    "source": [ "rnbo-param-note", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "rnbo-voice", 7 ],
                                    "source": [ "rnbo-param-subLevel", 0 ]
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
                        "subLevel": {
                            "label": "subLevel",
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
                        "feedback": {
                            "label": "feedback",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "fmIndex": {
                            "label": "fmIndex",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "fmRatio": {
                            "label": "fmRatio",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "brightness": {
                            "label": "brightness",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "attackMs": {
                            "label": "attackMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "fmDecayMs": {
                            "label": "fmDecayMs",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "note": {
                            "label": "note",
                            "isEnum": 0,
                            "parsestring": ""
                        },
                        "bendSemitones": {
                            "label": "bendSemitones",
                            "isEnum": 0,
                            "parsestring": ""
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
                            "__sps": {
                                "p_rnbo-voice": {                                }
                            },
                            "brightness": {
                                "value": 0.6
                            },
                            "subLevel": {
                                "value": 0.35
                            },
                            "drive": {
                                "value": 1.4
                            },
                            "attackMs": {
                                "value": 2.0
                            },
                            "decayMs": {
                                "value": 550.0
                            },
                            "feedback": {
                                "value": 0.15
                            },
                            "fmRatio": {
                                "value": 1.0
                            },
                            "note": {
                                "value": 36.0
                            },
                            "fmIndex": {
                                "value": 1.2
                            },
                            "level": {
                                "value": 0.45
                            },
                            "fmDecayMs": {
                                "value": 220.0
                            },
                            "bendSemitones": {
                                "value": 0.0
                            },
                            "__presetid": "mlr-bass"
                        },
                        "snapshotlist": {
                            "current_snapshot": 0,
                            "entries": [
                                {
                                    "filetype": "C74Snapshot",
                                    "version": 2,
                                    "minorversion": 0,
                                    "name": "mlr-bass",
                                    "origin": "mlr-bass",
                                    "type": "rnbo",
                                    "subtype": "",
                                    "embed": 0,
                                    "snapshot": {
                                        "__sps": {
                                            "p_rnbo-voice": {                                            }
                                        },
                                        "brightness": {
                                            "value": 0.6
                                        },
                                        "subLevel": {
                                            "value": 0.35
                                        },
                                        "drive": {
                                            "value": 1.4
                                        },
                                        "attackMs": {
                                            "value": 2.0
                                        },
                                        "decayMs": {
                                            "value": 550.0
                                        },
                                        "feedback": {
                                            "value": 0.15
                                        },
                                        "fmRatio": {
                                            "value": 1.0
                                        },
                                        "note": {
                                            "value": 36.0
                                        },
                                        "fmIndex": {
                                            "value": 1.2
                                        },
                                        "level": {
                                            "value": 0.45
                                        },
                                        "fmDecayMs": {
                                            "value": 220.0
                                        },
                                        "bendSemitones": {
                                            "value": 0.0
                                        },
                                        "__presetid": "mlr-bass"
                                    },
                                    "fileref": {
                                        "name": "mlr-bass",
                                        "filename": "mlr-bass.maxsnap",
                                        "filepath": "~/Projects/mlr/New Project/data",
                                        "filepos": -1,
                                        "snapshotfileid": "8b32ad4ced27b9ae36eeb5127bd43f0a"
                                    }
                                }
                            ]
                        }
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
                    "text": "s~ rnbo_bass_left"
                }
            },
            {
                "box": {
                    "id": "obj-sendright",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 470.0, 420.0, 120.0, 22.0 ],
                    "text": "s~ rnbo_bass_right"
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
                    "text": "Round"
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
                    "text": "Rubber"
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
                    "text": "Wire"
                }
            },
            {
                "box": {
                    "id": "label-note",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 220.0, 245.0, 20.0 ],
                    "text": "Note · MIDI"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-note",
                    "maxclass": "flonum",
                    "maximum": 96.0,
                    "minimum": 12.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 243.0, 245.0, 22.0 ],
                    "varname": "bass_sound_note"
                }
            },
            {
                "box": {
                    "id": "label-fmRatio",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 100.0, 240.0, 20.0 ],
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
                    "patching_rect": [ 900.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 311.0, 245.0, 22.0 ],
                    "varname": "bass_sound_fmRatio"
                }
            },
            {
                "box": {
                    "id": "label-fmDecayMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 900.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 356.0, 245.0, 20.0 ],
                    "text": "FM decay · ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-fmDecayMs",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 379.0, 245.0, 22.0 ],
                    "varname": "bass_sound_fmDecayMs"
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
                    "maximum": 12000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 900.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 311.0, 245.0, 22.0 ],
                    "varname": "bass_sound_decayMs"
                }
            },
            {
                "box": {
                    "id": "label-fmIndex",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 30.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 220.0, 245.0, 20.0 ],
                    "text": "FM index"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-fmIndex",
                    "maxclass": "flonum",
                    "maximum": 12.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 52.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 243.0, 245.0, 22.0 ],
                    "varname": "bass_sound_fmIndex"
                }
            },
            {
                "box": {
                    "id": "label-feedback",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 424.0, 245.0, 20.0 ],
                    "text": "Feedback"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-feedback",
                    "maxclass": "flonum",
                    "maximum": 0.95,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 447.0, 245.0, 22.0 ],
                    "varname": "bass_sound_feedback"
                }
            },
            {
                "box": {
                    "id": "label-attackMs",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 356.0, 245.0, 20.0 ],
                    "text": "Attack · ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-attackMs",
                    "maxclass": "flonum",
                    "maximum": 1000.0,
                    "minimum": 0.2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 379.0, 245.0, 22.0 ],
                    "varname": "bass_sound_attackMs"
                }
            },
            {
                "box": {
                    "id": "label-bendSemitones",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1160.0, 240.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 424.0, 245.0, 20.0 ],
                    "text": "Pitch bend · st"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-bendSemitones",
                    "maxclass": "flonum",
                    "maximum": 24.0,
                    "minimum": -24.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1160.0, 262.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 447.0, 245.0, 22.0 ],
                    "varname": "bass_sound_bendSemitones"
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
                    "varname": "bass_sound_drive"
                }
            },
            {
                "box": {
                    "id": "label-subLevel",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 100.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 220.0, 245.0, 20.0 ],
                    "text": "Sub level"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-subLevel",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 122.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 243.0, 245.0, 22.0 ],
                    "varname": "bass_sound_subLevel"
                }
            },
            {
                "box": {
                    "id": "label-brightness",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1420.0, 170.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 288.0, 245.0, 20.0 ],
                    "text": "Brightness"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "control-brightness",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1420.0, 192.0, 240.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 311.0, 245.0, 22.0 ],
                    "varname": "bass_sound_brightness"
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
                    "varname": "bass_sound_level"
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
                    "text": "r rnbo_bass_repeat"
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
                    "patching_rect": [ 80.0, 480.0, 331.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 82.0, 532.0, 331.0, 33.0 ],
                    "text": "Audio on/off • also uses Max’s global audio state.\nOutputs 1–2, plus rnbo_bass_left/right for later mixer routing."
                }
            },
            {
                "box": {
                    "id": "bass-manual",
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
                    "id": "bass-manual-echo",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 800.0, 210.0, 22.0 ],
                    "text": "prepend bassManual"
                }
            },
            {
                "box": {
                    "id": "bass-router",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 840.0, 210.0, 22.0 ],
                    "text": "s gridrouter"
                }
            },
            {
                "box": {
                    "id": "bass-route",
                    "linecount": 4,
                    "maxclass": "newobj",
                    "numinlets": 13,
                    "numoutlets": 13,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 260.0, 800.0, 210.0, 62.0 ],
                    "text": "route note decayMs fmIndex fmRatio fmDecayMs feedback subLevel brightness attackMs bendSemitones drive level"
                }
            },
            {
                "box": {
                    "id": "bass-cache",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 850.0, 281.0, 22.0 ],
                    "text": "pak 36. 550. 1.2 1. 220. 0.15 0.35 0.6 2. 0. 1.4 0.45"
                }
            },
            {
                "box": {
                    "id": "bass-unpack",
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
                    "id": "bass-pitch",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend note"
                }
            },
            {
                "box": {
                    "id": "bass-decay",
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
                    "id": "bass-fm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 930.0, 210.0, 22.0 ],
                    "text": "prepend fmIndex"
                }
            },
            {
                "box": {
                    "id": "bass-owned",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_bass_owned_param"
                }
            },
            {
                "box": {
                    "id": "bass-step",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 760.0, 210.0, 22.0 ],
                    "text": "r rnbo_bass_step"
                }
            },
            {
                "box": {
                    "id": "bass-step-unpack",
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
                    "id": "bass-fire",
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
                    "id": "bass-load",
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
                    "id": "bass-defer",
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
                    "id": "bass-sync",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 970.0, 210.0, 22.0 ],
                    "text": "bassSync"
                }
            },
            {
                "box": {
                    "id": "bass-values",
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
                    "text": "Grid mapping ranges · all twelve bass parameters"
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
                    "filename": "bass_lab_ranges.js",
                    "id": "range-script",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 20.0, 1120.0, 185.0, 22.0 ],
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
                    "patching_rect": [ 25.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 703.0, 245.0, 20.0 ],
                    "text": "Note · MIDI"
                }
            },
            {
                "box": {
                    "id": "bassNote-min-label",
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
                    "id": "bassNote-min",
                    "maxclass": "flonum",
                    "maximum": 96.0,
                    "minimum": 12.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 725.0, 80.0, 22.0 ],
                    "varname": "bassNote-min"
                }
            },
            {
                "box": {
                    "id": "bassNote-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange bassNote min"
                }
            },
            {
                "box": {
                    "id": "bassNote-max-label",
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
                    "id": "bassNote-max",
                    "maxclass": "flonum",
                    "maximum": 96.0,
                    "minimum": 12.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 725.0, 80.0, 22.0 ],
                    "varname": "bassNote-max"
                }
            },
            {
                "box": {
                    "id": "bassNote-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 1170.0, 245.0, 22.0 ],
                    "text": "prepend setrange bassNote max"
                }
            },
            {
                "box": {
                    "id": "bassDecay-range-label",
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
                    "id": "bassDecay-min-label",
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
                    "id": "bassDecay-min",
                    "maxclass": "flonum",
                    "maximum": 12000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 785.0, 80.0, 22.0 ],
                    "varname": "bassDecay-min"
                }
            },
            {
                "box": {
                    "id": "bassDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 305.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange bassDecay min"
                }
            },
            {
                "box": {
                    "id": "bassDecay-max-label",
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
                    "id": "bassDecay-max",
                    "maxclass": "flonum",
                    "maximum": 12000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 785.0, 80.0, 22.0 ],
                    "varname": "bassDecay-max"
                }
            },
            {
                "box": {
                    "id": "bassDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 430.0, 1225.0, 245.0, 22.0 ],
                    "text": "prepend setrange bassDecay max"
                }
            },
            {
                "box": {
                    "id": "bassFM-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 703.0, 245.0, 20.0 ],
                    "text": "FM index"
                }
            },
            {
                "box": {
                    "id": "bassFM-min-label",
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
                    "id": "bassFM-min",
                    "maxclass": "flonum",
                    "maximum": 12.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 725.0, 80.0, 22.0 ],
                    "varname": "bassFM-min"
                }
            },
            {
                "box": {
                    "id": "bassFM-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 585.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange bassFM min"
                }
            },
            {
                "box": {
                    "id": "bassFM-max-label",
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
                    "id": "bassFM-max",
                    "maxclass": "flonum",
                    "maximum": 12.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 725.0, 80.0, 22.0 ],
                    "varname": "bassFM-max"
                }
            },
            {
                "box": {
                    "id": "bassFM-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 710.0, 1280.0, 245.0, 22.0 ],
                    "text": "prepend setrange bassFM max"
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
                    "text": "route bassNote-min bassNote-max bassDecay-min bassDecay-max bassFM-min bassFM-max bassRatio-min bassRatio-max bassFMDecay-min bassFMDecay-max bassFeedback-min bassFeedback-max bassSub-min bassSub-max bassBrightness-min bassBrightness-max bassAttack-min bassAttack-max bassBend-min bassBend-max bassDrive-min bassDrive-max bassLevel-min bassLevel-max"
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
                    "varname": "bass_grid_range_presets"
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
                    "id": "bass-param-bassRatio",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1330.0, 210.0, 22.0 ],
                    "text": "prepend fmRatio"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassFMDecay",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend fmDecayMs"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassFeedback",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend feedback"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassSub",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 720.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend subLevel"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassBrightness",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 1370.0, 210.0, 22.0 ],
                    "text": "prepend brightness"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassAttack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend attackMs"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassBend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 1410.0, 210.0, 22.0 ],
                    "text": "prepend bendSemitones"
                }
            },
            {
                "box": {
                    "id": "bass-param-bassDrive",
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
                    "id": "bass-param-bassLevel",
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
                    "id": "bassRatio-range-label",
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
                    "id": "bassRatio-min-label",
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
                    "id": "bassRatio-min",
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
                    "varname": "bassRatio-min"
                }
            },
            {
                "box": {
                    "id": "bassRatio-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassRatio min"
                }
            },
            {
                "box": {
                    "id": "bassRatio-max-label",
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
                    "id": "bassRatio-max",
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
                    "varname": "bassRatio-max"
                }
            },
            {
                "box": {
                    "id": "bassRatio-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassRatio max"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 823.0, 245.0, 20.0 ],
                    "text": "FM decay · ms"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-min-label",
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
                    "id": "bassFMDecay-min",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 845.0, 80.0, 22.0 ],
                    "varname": "bassFMDecay-min"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassFMDecay min"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-max-label",
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
                    "id": "bassFMDecay-max",
                    "maxclass": "flonum",
                    "maximum": 6000.0,
                    "minimum": 5.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 845.0, 80.0, 22.0 ],
                    "varname": "bassFMDecay-max"
                }
            },
            {
                "box": {
                    "id": "bassFMDecay-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 145.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassFMDecay max"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 305.0, 883.0, 245.0, 20.0 ],
                    "text": "Feedback"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-min-label",
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
                    "id": "bassFeedback-min",
                    "maxclass": "flonum",
                    "maximum": 0.95,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 345.0, 905.0, 80.0, 22.0 ],
                    "varname": "bassFeedback-min"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassFeedback min"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-max-label",
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
                    "id": "bassFeedback-max",
                    "maxclass": "flonum",
                    "maximum": 0.95,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 905.0, 80.0, 22.0 ],
                    "varname": "bassFeedback-max"
                }
            },
            {
                "box": {
                    "id": "bassFeedback-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 175.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassFeedback max"
                }
            },
            {
                "box": {
                    "id": "bassSub-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 703.0, 245.0, 20.0 ],
                    "text": "Sub level"
                }
            },
            {
                "box": {
                    "id": "bassSub-min-label",
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
                    "id": "bassSub-min",
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
                    "varname": "bassSub-min"
                }
            },
            {
                "box": {
                    "id": "bassSub-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassSub min"
                }
            },
            {
                "box": {
                    "id": "bassSub-max-label",
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
                    "id": "bassSub-max",
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
                    "varname": "bassSub-max"
                }
            },
            {
                "box": {
                    "id": "bassSub-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 205.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassSub max"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 585.0, 763.0, 245.0, 20.0 ],
                    "text": "Brightness"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-min-label",
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
                    "id": "bassBrightness-min",
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
                    "varname": "bassBrightness-min"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassBrightness min"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-max-label",
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
                    "id": "bassBrightness-max",
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
                    "varname": "bassBrightness-max"
                }
            },
            {
                "box": {
                    "id": "bassBrightness-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassBrightness max"
                }
            },
            {
                "box": {
                    "id": "bassAttack-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 823.0, 245.0, 20.0 ],
                    "text": "Attack · ms"
                }
            },
            {
                "box": {
                    "id": "bassAttack-min-label",
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
                    "id": "bassAttack-min",
                    "maxclass": "flonum",
                    "maximum": 1000.0,
                    "minimum": 0.2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 845.0, 80.0, 22.0 ],
                    "varname": "bassAttack-min"
                }
            },
            {
                "box": {
                    "id": "bassAttack-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassAttack min"
                }
            },
            {
                "box": {
                    "id": "bassAttack-max-label",
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
                    "id": "bassAttack-max",
                    "maxclass": "flonum",
                    "maximum": 1000.0,
                    "minimum": 0.2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 845.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 845.0, 80.0, 22.0 ],
                    "varname": "bassAttack-max"
                }
            },
            {
                "box": {
                    "id": "bassAttack-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassAttack max"
                }
            },
            {
                "box": {
                    "id": "bassBend-range-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 25.0, 883.0, 245.0, 20.0 ],
                    "text": "Pitch bend · st"
                }
            },
            {
                "box": {
                    "id": "bassBend-min-label",
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
                    "id": "bassBend-min",
                    "maxclass": "flonum",
                    "maximum": 24.0,
                    "minimum": -24.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 65.0, 905.0, 80.0, 22.0 ],
                    "varname": "bassBend-min"
                }
            },
            {
                "box": {
                    "id": "bassBend-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassBend min"
                }
            },
            {
                "box": {
                    "id": "bassBend-max-label",
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
                    "id": "bassBend-max",
                    "maxclass": "flonum",
                    "maximum": 24.0,
                    "minimum": -24.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 905.0, 80.0, 22.0 ],
                    "varname": "bassBend-max"
                }
            },
            {
                "box": {
                    "id": "bassBend-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 295.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassBend max"
                }
            },
            {
                "box": {
                    "id": "bassDrive-range-label",
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
                    "id": "bassDrive-min-label",
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
                    "id": "bassDrive-min",
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
                    "varname": "bassDrive-min"
                }
            },
            {
                "box": {
                    "id": "bassDrive-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassDrive min"
                }
            },
            {
                "box": {
                    "id": "bassDrive-max-label",
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
                    "id": "bassDrive-max",
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
                    "varname": "bassDrive-max"
                }
            },
            {
                "box": {
                    "id": "bassDrive-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 325.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassDrive max"
                }
            },
            {
                "box": {
                    "id": "bassLevel-range-label",
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
                    "id": "bassLevel-min-label",
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
                    "id": "bassLevel-min",
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
                    "varname": "bassLevel-min"
                }
            },
            {
                "box": {
                    "id": "bassLevel-min-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1520.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassLevel min"
                }
            },
            {
                "box": {
                    "id": "bassLevel-max-label",
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
                    "id": "bassLevel-max",
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
                    "varname": "bassLevel-max"
                }
            },
            {
                "box": {
                    "id": "bassLevel-max-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 355.0, 1555.0, 250.0, 22.0 ],
                    "text": "prepend setrange bassLevel max"
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
                    "text": "Pitch / shape"
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
                    "text": "FM"
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
                    "id": "control-note-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend note"
                }
            },
            {
                "box": {
                    "id": "control-note-set",
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
                    "id": "control-fmIndex-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1700.0, 210.0, 22.0 ],
                    "text": "prepend fmIndex"
                }
            },
            {
                "box": {
                    "id": "control-fmIndex-set",
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
                    "id": "control-fmRatio-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1700.0, 210.0, 22.0 ],
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
                    "patching_rect": [ 745.0, 1730.0, 210.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "control-fmDecayMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend fmDecayMs"
                }
            },
            {
                "box": {
                    "id": "control-fmDecayMs-set",
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
                    "id": "control-feedback-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend feedback"
                }
            },
            {
                "box": {
                    "id": "control-feedback-set",
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
                    "id": "control-subLevel-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 505.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend subLevel"
                }
            },
            {
                "box": {
                    "id": "control-subLevel-set",
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
                    "id": "control-brightness-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 745.0, 1770.0, 210.0, 22.0 ],
                    "text": "prepend brightness"
                }
            },
            {
                "box": {
                    "id": "control-brightness-set",
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
                    "id": "control-attackMs-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 25.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend attackMs"
                }
            },
            {
                "box": {
                    "id": "control-attackMs-set",
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
                    "id": "control-bendSemitones-pre",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 1840.0, 210.0, 22.0 ],
                    "text": "prepend bendSemitones"
                }
            },
            {
                "box": {
                    "id": "control-bendSemitones-set",
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
                    "id": "bass-ui-unpack",
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
                    "destination": [ "bass-ui-unpack", 0 ],
                    "order": 1,
                    "source": [ "bass-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-values", 1 ],
                    "order": 0,
                    "source": [ "bass-cache", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-decay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-sync", 0 ],
                    "order": 1,
                    "source": [ "bass-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "order": 0,
                    "source": [ "bass-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-values", 0 ],
                    "source": [ "bass-fire", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-fire", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-fm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 0 ],
                    "order": 0,
                    "source": [ "bass-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-defer", 0 ],
                    "order": 1,
                    "source": [ "bass-load", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual-echo", 0 ],
                    "source": [ "bass-manual", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-route", 0 ],
                    "source": [ "bass-manual", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-router", 0 ],
                    "source": [ "bass-manual-echo", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-route", 0 ],
                    "source": [ "bass-owned", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassAttack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassBend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassBrightness", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassDrive", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassFMDecay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassFeedback", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassRatio", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-param-bassSub", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-pitch", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 11 ],
                    "source": [ "bass-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 10 ],
                    "source": [ "bass-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 9 ],
                    "source": [ "bass-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 8 ],
                    "source": [ "bass-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 7 ],
                    "source": [ "bass-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 6 ],
                    "source": [ "bass-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 5 ],
                    "source": [ "bass-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 4 ],
                    "source": [ "bass-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 3 ],
                    "source": [ "bass-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 2 ],
                    "source": [ "bass-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 1 ],
                    "source": [ "bass-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 0 ],
                    "source": [ "bass-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-rnbo", 0 ],
                    "source": [ "bass-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-step-unpack", 0 ],
                    "source": [ "bass-step", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 11 ],
                    "source": [ "bass-step-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 10 ],
                    "source": [ "bass-step-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 9 ],
                    "source": [ "bass-step-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 8 ],
                    "source": [ "bass-step-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 7 ],
                    "source": [ "bass-step-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 6 ],
                    "source": [ "bass-step-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 5 ],
                    "source": [ "bass-step-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 4 ],
                    "source": [ "bass-step-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 3 ],
                    "source": [ "bass-step-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 2 ],
                    "source": [ "bass-step-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 1 ],
                    "source": [ "bass-step-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-cache", 0 ],
                    "source": [ "bass-step-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-router", 0 ],
                    "source": [ "bass-sync", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-attackMs-set", 0 ],
                    "source": [ "bass-ui-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendSemitones-set", 0 ],
                    "source": [ "bass-ui-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-brightness-set", 0 ],
                    "source": [ "bass-ui-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-decayMs-set", 0 ],
                    "source": [ "bass-ui-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-drive-set", 0 ],
                    "source": [ "bass-ui-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-feedback-set", 0 ],
                    "source": [ "bass-ui-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmDecayMs-set", 0 ],
                    "source": [ "bass-ui-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmIndex-set", 0 ],
                    "source": [ "bass-ui-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmRatio-set", 0 ],
                    "source": [ "bass-ui-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-level-set", 0 ],
                    "source": [ "bass-ui-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-note-set", 0 ],
                    "source": [ "bass-ui-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-subLevel-set", 0 ],
                    "source": [ "bass-ui-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-decay", 0 ],
                    "source": [ "bass-unpack", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-fm", 0 ],
                    "source": [ "bass-unpack", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassAttack", 0 ],
                    "source": [ "bass-unpack", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassBend", 0 ],
                    "source": [ "bass-unpack", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassBrightness", 0 ],
                    "source": [ "bass-unpack", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassDrive", 0 ],
                    "source": [ "bass-unpack", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassFMDecay", 0 ],
                    "source": [ "bass-unpack", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassFeedback", 0 ],
                    "source": [ "bass-unpack", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassLevel", 0 ],
                    "source": [ "bass-unpack", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassRatio", 0 ],
                    "source": [ "bass-unpack", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-param-bassSub", 0 ],
                    "source": [ "bass-unpack", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-pitch", 0 ],
                    "source": [ "bass-unpack", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-unpack", 0 ],
                    "source": [ "bass-values", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassAttack-max-pre", 0 ],
                    "source": [ "bassAttack-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassAttack-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassAttack-min-pre", 0 ],
                    "source": [ "bassAttack-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassAttack-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBend-max-pre", 0 ],
                    "source": [ "bassBend-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassBend-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBend-min-pre", 0 ],
                    "source": [ "bassBend-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassBend-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBrightness-max-pre", 0 ],
                    "source": [ "bassBrightness-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassBrightness-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBrightness-min-pre", 0 ],
                    "source": [ "bassBrightness-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassBrightness-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDecay-max-pre", 0 ],
                    "source": [ "bassDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDecay-min-pre", 0 ],
                    "source": [ "bassDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDrive-max-pre", 0 ],
                    "source": [ "bassDrive-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassDrive-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDrive-min-pre", 0 ],
                    "source": [ "bassDrive-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassDrive-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFM-max-pre", 0 ],
                    "source": [ "bassFM-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassFM-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFM-min-pre", 0 ],
                    "source": [ "bassFM-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassFM-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFMDecay-max-pre", 0 ],
                    "source": [ "bassFMDecay-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassFMDecay-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFMDecay-min-pre", 0 ],
                    "source": [ "bassFMDecay-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassFMDecay-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFeedback-max-pre", 0 ],
                    "source": [ "bassFeedback-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassFeedback-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFeedback-min-pre", 0 ],
                    "source": [ "bassFeedback-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassFeedback-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassLevel-max-pre", 0 ],
                    "source": [ "bassLevel-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassLevel-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassLevel-min-pre", 0 ],
                    "source": [ "bassLevel-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassLevel-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassNote-max-pre", 0 ],
                    "source": [ "bassNote-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassNote-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassNote-min-pre", 0 ],
                    "source": [ "bassNote-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassNote-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassRatio-max-pre", 0 ],
                    "source": [ "bassRatio-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassRatio-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassRatio-min-pre", 0 ],
                    "source": [ "bassRatio-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassRatio-min-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassSub-max-pre", 0 ],
                    "source": [ "bassSub-max", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassSub-max-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassSub-min-pre", 0 ],
                    "source": [ "bassSub-min", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "range-script", 0 ],
                    "source": [ "bassSub-min-pre", 0 ]
                }
            },
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
                    "destination": [ "control-attackMs-pre", 0 ],
                    "source": [ "control-attackMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-attackMs-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-attackMs", 0 ],
                    "source": [ "control-attackMs-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendSemitones-pre", 0 ],
                    "source": [ "control-bendSemitones", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-bendSemitones-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-bendSemitones", 0 ],
                    "source": [ "control-bendSemitones-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-brightness-pre", 0 ],
                    "source": [ "control-brightness", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-brightness-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-brightness", 0 ],
                    "source": [ "control-brightness-set", 0 ]
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
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "control-feedback-pre", 0 ],
                    "source": [ "control-feedback", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-feedback-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-feedback", 0 ],
                    "source": [ "control-feedback-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmDecayMs-pre", 0 ],
                    "source": [ "control-fmDecayMs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-fmDecayMs-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmDecayMs", 0 ],
                    "source": [ "control-fmDecayMs-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmIndex-pre", 0 ],
                    "source": [ "control-fmIndex", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-fmIndex-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-fmIndex", 0 ],
                    "source": [ "control-fmIndex-set", 0 ]
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
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "control-note-pre", 0 ],
                    "source": [ "control-note", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-note-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-note", 0 ],
                    "source": [ "control-note-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-subLevel-pre", 0 ],
                    "source": [ "control-subLevel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "control-subLevel-pre", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "control-subLevel", 0 ],
                    "source": [ "control-subLevel-set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "bass-manual", 0 ],
                    "source": [ "obj-hollow", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "bass-manual", 0 ],
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
                    "destination": [ "bass-fire", 0 ],
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
                    "destination": [ "bassAttack-max", 0 ],
                    "order": 17,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassAttack-min", 0 ],
                    "order": 21,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBend-max", 0 ],
                    "order": 16,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBend-min", 0 ],
                    "order": 20,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBrightness-max", 0 ],
                    "order": 2,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBrightness-min", 0 ],
                    "order": 6,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDecay-max", 0 ],
                    "order": 18,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDecay-min", 0 ],
                    "order": 22,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDrive-max", 0 ],
                    "order": 1,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDrive-min", 0 ],
                    "order": 5,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFM-max", 0 ],
                    "order": 11,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFM-min", 0 ],
                    "order": 15,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFMDecay-max", 0 ],
                    "order": 9,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFMDecay-min", 0 ],
                    "order": 13,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFeedback-max", 0 ],
                    "order": 8,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFeedback-min", 0 ],
                    "order": 12,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassLevel-max", 0 ],
                    "order": 0,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassLevel-min", 0 ],
                    "order": 4,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassNote-max", 0 ],
                    "order": 19,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassNote-min", 0 ],
                    "order": 23,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassRatio-max", 0 ],
                    "order": 10,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassRatio-min", 0 ],
                    "order": 14,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassSub-max", 0 ],
                    "order": 3,
                    "source": [ "range-presets", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassSub-min", 0 ],
                    "order": 7,
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
                    "destination": [ "bassAttack-max", 0 ],
                    "source": [ "range-route", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassAttack-min", 0 ],
                    "source": [ "range-route", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBend-max", 0 ],
                    "source": [ "range-route", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBend-min", 0 ],
                    "source": [ "range-route", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBrightness-max", 0 ],
                    "source": [ "range-route", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassBrightness-min", 0 ],
                    "source": [ "range-route", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDecay-max", 0 ],
                    "source": [ "range-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDecay-min", 0 ],
                    "source": [ "range-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDrive-max", 0 ],
                    "source": [ "range-route", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassDrive-min", 0 ],
                    "source": [ "range-route", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFM-max", 0 ],
                    "source": [ "range-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFM-min", 0 ],
                    "source": [ "range-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFMDecay-max", 0 ],
                    "source": [ "range-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFMDecay-min", 0 ],
                    "source": [ "range-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFeedback-max", 0 ],
                    "source": [ "range-route", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassFeedback-min", 0 ],
                    "source": [ "range-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassLevel-max", 0 ],
                    "source": [ "range-route", 23 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassLevel-min", 0 ],
                    "source": [ "range-route", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassNote-max", 0 ],
                    "source": [ "range-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassNote-min", 0 ],
                    "source": [ "range-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassRatio-max", 0 ],
                    "source": [ "range-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassRatio-min", 0 ],
                    "source": [ "range-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassSub-max", 0 ],
                    "source": [ "range-route", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bassSub-min", 0 ],
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
            }
        ]
    }
}