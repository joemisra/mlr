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
    "rect": [
      100,
      100,
      730,
      300
    ],
    "boxes": [
      {
        "box": {
          "id": "note",
          "maxclass": "comment",
          "text": "DPT kick export — silent harness. Exports on open; no hardware flashing.",
          "patching_rect": [
            30,
            25,
            660,
            22
          ]
        }
      },
      {
        "box": {
          "autosave": 1,
          "id": "engine",
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
            "title": "mlr-kick",
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
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "in_rnbo-in",
                  "text": "inport hit"
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
                  "text": "p kick_core",
                  "patcher": {
                    "fileversion": 1,
                    "appversion": {
                      "major": 9,
                      "minor": 1,
                      "revision": 4,
                      "architecture": "x64",
                      "modernui": 1
                    },
                    "classnamespace": "rnbo",
                    "rect": [
                      80,
                      80,
                      980,
                      620
                    ],
                    "default_fontname": "Lato",
                    "default_fontsize": 12,
                    "title": "MLR RNBO Kick Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR kick core — pitch sweep + FM body + impulse-excited resonant bandpass",
                          "patching_rect": [
                            30,
                            20,
                            520,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-in",
                          "maxclass": "newobj",
                          "text": "in 1",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            30,
                            70,
                            40,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-in",
                          "rnbo_extra_attributes": {
                            "comment": "trigger",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-click",
                          "maxclass": "newobj",
                          "text": "click~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            30,
                            115,
                            48,
                            23
                          ],
                          "rnbo_classname": "click~",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "click~_obj-click"
                        }
                      },
                      {
                        "box": {
                          "id": "obj-base",
                          "maxclass": "newobj",
                          "text": "in 2",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            70,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-base",
                          "rnbo_extra_attributes": {
                            "comment": "base frequency",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-pitchamount",
                          "maxclass": "newobj",
                          "text": "in 3",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            105,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-pitchamount",
                          "rnbo_extra_attributes": {
                            "comment": "pitch sweep amount",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-pitchdecay",
                          "maxclass": "newobj",
                          "text": "in 4",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            140,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-pitchdecay",
                          "rnbo_extra_attributes": {
                            "comment": "pitch sweep decay",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-ampdecay",
                          "maxclass": "newobj",
                          "text": "in 5",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            175,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-ampdecay",
                          "rnbo_extra_attributes": {
                            "comment": "amplitude decay",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-fmindex",
                          "maxclass": "newobj",
                          "text": "in 6",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            210,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-fmindex",
                          "rnbo_extra_attributes": {
                            "comment": "FM index",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-fmratio",
                          "maxclass": "newobj",
                          "text": "in 7",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            245,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-fmratio",
                          "rnbo_extra_attributes": {
                            "comment": "FM ratio",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-resmix",
                          "maxclass": "newobj",
                          "text": "in 8",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            280,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-resmix",
                          "rnbo_extra_attributes": {
                            "comment": "resonator mix",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-reshz",
                          "maxclass": "newobj",
                          "text": "in 9",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            315,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-reshz",
                          "rnbo_extra_attributes": {
                            "comment": "resonator frequency",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-resq",
                          "maxclass": "newobj",
                          "text": "in 10",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            350,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-resq",
                          "rnbo_extra_attributes": {
                            "comment": "resonator Q",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-clicklevel",
                          "maxclass": "newobj",
                          "text": "in 11",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            385,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-clicklevel",
                          "rnbo_extra_attributes": {
                            "comment": "click level",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-drive",
                          "maxclass": "newobj",
                          "text": "in 12",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            420,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-drive",
                          "rnbo_extra_attributes": {
                            "comment": "drive",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-level",
                          "maxclass": "newobj",
                          "text": "in 13",
                          "numinlets": 0,
                          "numoutlets": 1,
                          "outlettype": [
                            ""
                          ],
                          "patching_rect": [
                            120,
                            455,
                            45,
                            23
                          ],
                          "rnbo_classname": "in",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "in_obj-level",
                          "rnbo_extra_attributes": {
                            "comment": "output level",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-dsp",
                          "maxclass": "codebox~",
                          "numinlets": 13,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            460,
                            70,
                            480,
                            410
                          ],
                          "rnbo_classname": "codebox~",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "codebox~_obj-dsp",
                          "rnbo_extra_attributes": {
                            "safemath": 1,
                            "nocache": 0,
                            "expr": "",
                            "code": "@state hitSweep = 150;\r\n@state hitSweepDecay = 32;\r\n@state hitFMRatio = 1.5;\r\n@state hitResMix = 0.22;\r\n@state hitResHz = 58;\r\n@state hitResQ = 8;\r\n@state hitClick = 0.08;\r\n@state hitDrive = 1.8;\r\n@state hitLevel = 0.5;\r\n@state hitBase = 48;\r\n@state hitDecay = 620;\r\n@state hitFM = 0.15;\r\n@state carrierPhase = 0;\r\n@state modPhase = 0;\r\n@state ampEnv = 0;\r\n@state pitchEnv = 0;\r\n@state svfLow = 0;\r\n@state svfBand = 0;\r\n\r\nlet trig = in1;\r\nlet sr = samplerate();\r\n\r\nif (trig > 0) {\r\n    hitBase = in2;\r\n    hitDecay = in5;\r\n    hitFM = in6;\r\n    hitSweep = in3;\r\n    hitSweepDecay = in4;\r\n    hitFMRatio = in7;\r\n    hitResMix = in8;\r\n    hitResHz = in9;\r\n    hitResQ = in10;\r\n    hitClick = in11;\r\n    hitDrive = in12;\r\n    hitLevel = in13;\r\n    ampEnv = 1;\r\n    pitchEnv = 1;\r\n    carrierPhase = 0;\r\n    modPhase = 0;\r\n    svfLow = 0;\r\n    svfBand = 0;\r\n}\r\n\r\nlet ampCoef = exp(-6.907755 / (maximum(1, hitDecay) * 0.001 * sr));\r\nlet pitchCoef = exp(-6.907755 / (maximum(1, hitSweepDecay) * 0.001 * sr));\r\nampEnv *= ampCoef;\r\npitchEnv *= pitchCoef;\r\n\r\nlet base = maximum(10, hitBase);\r\nlet swept = base + maximum(0, hitSweep) * pitchEnv;\r\nlet modFreq = swept * maximum(0.125, hitFMRatio);\r\nmodPhase = wrap(modPhase + modFreq / sr, 0, 1);\r\nlet fm = sin(modPhase * 6.283185307179586) * swept * maximum(0, hitFM) * pitchEnv;\r\nlet carrierFreq = clamp(swept + fm, 5, sr * 0.45);\r\ncarrierPhase = wrap(carrierPhase + carrierFreq / sr, 0, 1);\r\nlet body = sin(carrierPhase * 6.283185307179586) * ampEnv;\r\n\r\nlet resonHz = clamp(hitResHz, 20, sr * 0.2);\r\nlet f = 2 * sin(3.141592653589793 * resonHz / sr);\r\nlet damping = 1 / maximum(0.5, hitResQ);\r\nlet resonInput = trig * 0.25 / maximum(f, 0.000001);\r\nlet high = resonInput - svfLow - damping * svfBand;\r\nsvfBand += f * high;\r\nsvfLow += f * svfBand;\r\n\r\nlet mix = clamp(hitResMix, 0, 1);\r\nlet click = trig * clamp(hitClick, 0, 1);\r\nlet raw = body * (1 - mix) + svfBand * mix * 4 + click;\r\nlet drive = maximum(0.01, hitDrive);\r\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
                          },
                          "code": "@state hitSweep = 150;\r\n@state hitSweepDecay = 32;\r\n@state hitFMRatio = 1.5;\r\n@state hitResMix = 0.22;\r\n@state hitResHz = 58;\r\n@state hitResQ = 8;\r\n@state hitClick = 0.08;\r\n@state hitDrive = 1.8;\r\n@state hitLevel = 0.5;\r\n@state hitBase = 48;\r\n@state hitDecay = 620;\r\n@state hitFM = 0.15;\r\n@state carrierPhase = 0;\r\n@state modPhase = 0;\r\n@state ampEnv = 0;\r\n@state pitchEnv = 0;\r\n@state svfLow = 0;\r\n@state svfBand = 0;\r\n\r\nlet trig = in1;\r\nlet sr = samplerate();\r\n\r\nif (trig > 0) {\r\n    hitBase = in2;\r\n    hitDecay = in5;\r\n    hitFM = in6;\r\n    hitSweep = in3;\r\n    hitSweepDecay = in4;\r\n    hitFMRatio = in7;\r\n    hitResMix = in8;\r\n    hitResHz = in9;\r\n    hitResQ = in10;\r\n    hitClick = in11;\r\n    hitDrive = in12;\r\n    hitLevel = in13;\r\n    ampEnv = 1;\r\n    pitchEnv = 1;\r\n    carrierPhase = 0;\r\n    modPhase = 0;\r\n    svfLow = 0;\r\n    svfBand = 0;\r\n}\r\n\r\nlet ampCoef = exp(-6.907755 / (maximum(1, hitDecay) * 0.001 * sr));\r\nlet pitchCoef = exp(-6.907755 / (maximum(1, hitSweepDecay) * 0.001 * sr));\r\nampEnv *= ampCoef;\r\npitchEnv *= pitchCoef;\r\n\r\nlet base = maximum(10, hitBase);\r\nlet swept = base + maximum(0, hitSweep) * pitchEnv;\r\nlet modFreq = swept * maximum(0.125, hitFMRatio);\r\nmodPhase = wrap(modPhase + modFreq / sr, 0, 1);\r\nlet fm = sin(modPhase * 6.283185307179586) * swept * maximum(0, hitFM) * pitchEnv;\r\nlet carrierFreq = clamp(swept + fm, 5, sr * 0.45);\r\ncarrierPhase = wrap(carrierPhase + carrierFreq / sr, 0, 1);\r\nlet body = sin(carrierPhase * 6.283185307179586) * ampEnv;\r\n\r\nlet resonHz = clamp(hitResHz, 20, sr * 0.2);\r\nlet f = 2 * sin(3.141592653589793 * resonHz / sr);\r\nlet damping = 1 / maximum(0.5, hitResQ);\r\nlet resonInput = trig * 0.25 / maximum(f, 0.000001);\r\nlet high = resonInput - svfLow - damping * svfBand;\r\nsvfBand += f * high;\r\nsvfLow += f * svfBand;\r\n\r\nlet mix = clamp(hitResMix, 0, 1);\r\nlet click = trig * clamp(hitClick, 0, 1);\r\nlet raw = body * (1 - mix) + svfBand * mix * 4 + click;\r\nlet drive = maximum(0.01, hitDrive);\r\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
                        }
                      },
                      {
                        "box": {
                          "id": "obj-gain",
                          "maxclass": "newobj",
                          "text": "*~ 1",
                          "numinlets": 2,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            575,
                            505,
                            38,
                            23
                          ],
                          "rnbo_classname": "*~",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "*~_obj-gain"
                        }
                      },
                      {
                        "box": {
                          "id": "obj-out1",
                          "maxclass": "newobj",
                          "text": "out~ 1",
                          "numinlets": 1,
                          "numoutlets": 0,
                          "patching_rect": [
                            540,
                            555,
                            48,
                            23
                          ],
                          "rnbo_classname": "out~",
                          "rnbo_serial": 1,
                          "rnbo_uniqueid": "out~_obj-out1",
                          "rnbo_extra_attributes": {
                            "comment": "left",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-out2",
                          "maxclass": "newobj",
                          "text": "out~ 2",
                          "numinlets": 1,
                          "numoutlets": 0,
                          "patching_rect": [
                            630,
                            555,
                            48,
                            23
                          ],
                          "rnbo_classname": "out~",
                          "rnbo_serial": 2,
                          "rnbo_uniqueid": "out~_obj-out2",
                          "rnbo_extra_attributes": {
                            "comment": "right",
                            "meta": ""
                          }
                        }
                      },
                      {
                        "box": {
                          "id": "obj-base-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            602,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-pitchamount-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            630,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-pitchdecay-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            658,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-ampdecay-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            686,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-fmindex-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            714,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-fmratio-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            742,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-resmix-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            770,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-reshz-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            798,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-resq-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            826,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-clicklevel-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            854,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-drive-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            882,
                            45,
                            23
                          ]
                        }
                      },
                      {
                        "box": {
                          "id": "obj-level-signal",
                          "maxclass": "newobj",
                          "text": "sig~",
                          "numinlets": 1,
                          "numoutlets": 1,
                          "outlettype": [
                            "signal"
                          ],
                          "patching_rect": [
                            200,
                            910,
                            45,
                            23
                          ]
                        }
                      }
                    ],
                    "lines": [
                      {
                        "patchline": {
                          "source": [
                            "obj-in",
                            0
                          ],
                          "destination": [
                            "obj-click",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-click",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-base-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            1
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-pitchamount-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            2
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-pitchdecay-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            3
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-ampdecay-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            4
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-fmindex-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            5
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-fmratio-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            6
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-resmix-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            7
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-reshz-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            8
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-resq-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            9
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-clicklevel-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            10
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-drive-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            11
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-dsp",
                            0
                          ],
                          "destination": [
                            "obj-gain",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-gain",
                            0
                          ],
                          "destination": [
                            "obj-out1",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-gain",
                            0
                          ],
                          "destination": [
                            "obj-out2",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-base",
                            0
                          ],
                          "destination": [
                            "obj-base-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-pitchamount",
                            0
                          ],
                          "destination": [
                            "obj-pitchamount-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-pitchdecay",
                            0
                          ],
                          "destination": [
                            "obj-pitchdecay-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-ampdecay",
                            0
                          ],
                          "destination": [
                            "obj-ampdecay-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-fmindex",
                            0
                          ],
                          "destination": [
                            "obj-fmindex-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-fmratio",
                            0
                          ],
                          "destination": [
                            "obj-fmratio-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-resmix",
                            0
                          ],
                          "destination": [
                            "obj-resmix-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-reshz",
                            0
                          ],
                          "destination": [
                            "obj-reshz-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-resq",
                            0
                          ],
                          "destination": [
                            "obj-resq-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-clicklevel",
                            0
                          ],
                          "destination": [
                            "obj-clicklevel-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-drive",
                            0
                          ],
                          "destination": [
                            "obj-drive-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-level",
                            0
                          ],
                          "destination": [
                            "obj-level-signal",
                            0
                          ]
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-level-signal",
                            0
                          ],
                          "destination": [
                            "obj-dsp",
                            12
                          ]
                        }
                      }
                    ]
                  }
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
                  "text": "Exported params live here; reusable DSP core lives in rnbo_kick_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-baseHz",
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
                  "rnbo_uniqueid": "baseHz",
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
                  "text": "param baseHz 48 @min 10 @max 2000 @unit Hz",
                  "varname": "baseHz"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-pitchAmount",
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
                  "rnbo_uniqueid": "pitchAmount",
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
                  "text": "param pitchAmount 150 @min 0 @max 600 @unit Hz",
                  "varname": "pitchAmount"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-pitchDecayMs",
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
                  "rnbo_uniqueid": "pitchDecayMs",
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
                  "text": "param pitchDecayMs 32 @min 1 @max 300 @unit ms",
                  "varname": "pitchDecayMs"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-ampDecayMs",
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
                  "rnbo_uniqueid": "ampDecayMs",
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
                  "text": "param ampDecayMs 620 @min 1 @max 30000 @unit ms",
                  "varname": "ampDecayMs"
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
                    "unit": "",
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
                  "text": "param fmIndex 0.15 @min 0 @max 32",
                  "varname": "fmIndex"
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
                  "text": "param fmRatio 1.5 @min 0.125 @max 8",
                  "varname": "fmRatio"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-resonMix",
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
                  "rnbo_uniqueid": "resonMix",
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
                  "text": "param resonMix 0.22 @min 0 @max 1",
                  "varname": "resonMix"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-resonHz",
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
                  "rnbo_uniqueid": "resonHz",
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
                  "text": "param resonHz 58 @min 25 @max 400 @unit Hz",
                  "varname": "resonHz"
                }
              },
              {
                "box": {
                  "id": "rnbo-param-resonQ",
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
                  "rnbo_uniqueid": "resonQ",
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
                  "text": "param resonQ 8 @min 0.5 @max 24",
                  "varname": "resonQ"
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
                  "text": "param clickLevel 0.08 @min 0 @max 1",
                  "varname": "clickLevel"
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
                  "text": "param drive 1.8 @min 0.25 @max 8",
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
                    "rnbo-param-ampDecayMs",
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
                    "rnbo-param-baseHz",
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
                    "rnbo-param-clickLevel",
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
                    "rnbo-param-fmRatio",
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
                    "rnbo-param-pitchAmount",
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
                    "rnbo-param-pitchDecayMs",
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
                    "rnbo-param-resonHz",
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
                    "rnbo-param-resonMix",
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
                    "rnbo-param-resonQ",
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
            30,
            140,
            220,
            22
          ],
          "rnboattrcache": {
            "pitchDecayMs": {
              "label": "pitchDecayMs",
              "isEnum": 0,
              "parsestring": ""
            },
            "resonQ": {
              "label": "resonQ",
              "isEnum": 0,
              "parsestring": ""
            },
            "level": {
              "label": "level",
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
            "resonHz": {
              "label": "resonHz",
              "isEnum": 0,
              "parsestring": ""
            },
            "drive": {
              "label": "drive",
              "isEnum": 0,
              "parsestring": ""
            },
            "pitchAmount": {
              "label": "pitchAmount",
              "isEnum": 0,
              "parsestring": ""
            },
            "clickLevel": {
              "label": "clickLevel",
              "isEnum": 0,
              "parsestring": ""
            },
            "ampDecayMs": {
              "label": "ampDecayMs",
              "isEnum": 0,
              "parsestring": ""
            },
            "resonMix": {
              "label": "resonMix",
              "isEnum": 0,
              "parsestring": ""
            },
            "baseHz": {
              "label": "baseHz",
              "isEnum": 0,
              "parsestring": ""
            }
          },
          "rnboversion": "1.4.5",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_invisible": 1,
              "parameter_longname": "kick_rnbo",
              "parameter_modmode": 0,
              "parameter_shortname": "kick_rnbo",
              "parameter_type": 3
            }
          },
          "saved_object_attributes": {
            "optimization": "O1",
            "parameter_enable": 1,
            "uuid": "9dd03d93-a123-442b-8f19-7022d7bd1131"
          },
          "text": "rnbo~ @dumpoutlet 1",
          "varname": "dpt_export_engine"
        }
      },
      {
        "box": {
          "id": "script",
          "maxclass": "newobj",
          "text": "v8 dpt_export.js",
          "patching_rect": [
            30,
            90,
            350,
            22
          ]
        }
      },
      {
        "box": {
          "id": "load",
          "maxclass": "newobj",
          "text": "loadbang",
          "patching_rect": [
            400,
            90,
            350,
            22
          ]
        }
      },
      {
        "box": {
          "id": "again",
          "maxclass": "message",
          "text": "bang",
          "patching_rect": [
            400,
            130,
            60,
            22
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "load",
            0
          ],
          "destination": [
            "script",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "again",
            0
          ],
          "destination": [
            "script",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "script",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            3
          ],
          "destination": [
            "script",
            0
          ]
        }
      }
    ]
  }
}
