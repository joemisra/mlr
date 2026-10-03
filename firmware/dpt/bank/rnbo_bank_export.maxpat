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
      760,
      260
    ],
    "boxes": [
      {
        "box": {
          "id": "engine",
          "maxclass": "newobj",
          "text": "rnbo~ @dumpoutlet 1",
          "numinlets": 1,
          "numoutlets": 10,
          "outlettype": [
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "list",
            ""
          ],
          "patching_rect": [
            30,
            130,
            250,
            22
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
            "boxes": [
              {
                "box": {
                  "id": "kick-rnbo-in",
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
                  "rnbo_uniqueid": "kick_in_rnbo-in",
                  "text": "inport hit_kick"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-voice",
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
                  "rnbo_uniqueid": "kick_p_rnbo-voice",
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
                  "id": "kick-rnbo-out1",
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
                  "rnbo_uniqueid": "kick_out~_rnbo-out1",
                  "text": "out~ 1"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-comment",
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
                  "id": "kick-rnbo-param-baseHz",
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
                  "rnbo_uniqueid": "kick_baseHz",
                  "text": "param kick_baseHz 48 @min 10 @max 2000 @unit Hz",
                  "varname": "kick_baseHz"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-pitchAmount",
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
                  "rnbo_uniqueid": "kick_pitchAmount",
                  "text": "param kick_pitchAmount 150 @min 0 @max 600 @unit Hz",
                  "varname": "kick_pitchAmount"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-pitchDecayMs",
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
                  "rnbo_uniqueid": "kick_pitchDecayMs",
                  "text": "param kick_pitchDecayMs 32 @min 1 @max 300 @unit ms",
                  "varname": "kick_pitchDecayMs"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-ampDecayMs",
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
                  "rnbo_uniqueid": "kick_ampDecayMs",
                  "text": "param kick_ampDecayMs 620 @min 1 @max 30000 @unit ms",
                  "varname": "kick_ampDecayMs"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-fmIndex",
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
                  "rnbo_uniqueid": "kick_fmIndex",
                  "text": "param kick_fmIndex 0.15 @min 0 @max 32",
                  "varname": "kick_fmIndex"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-fmRatio",
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
                  "rnbo_uniqueid": "kick_fmRatio",
                  "text": "param kick_fmRatio 1.5 @min 0.125 @max 8",
                  "varname": "kick_fmRatio"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-resonMix",
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
                  "rnbo_uniqueid": "kick_resonMix",
                  "text": "param kick_resonMix 0.22 @min 0 @max 1",
                  "varname": "kick_resonMix"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-resonHz",
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
                  "rnbo_uniqueid": "kick_resonHz",
                  "text": "param kick_resonHz 58 @min 25 @max 400 @unit Hz",
                  "varname": "kick_resonHz"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-resonQ",
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
                  "rnbo_uniqueid": "kick_resonQ",
                  "text": "param kick_resonQ 8 @min 0.5 @max 24",
                  "varname": "kick_resonQ"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-clickLevel",
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
                  "rnbo_uniqueid": "kick_clickLevel",
                  "text": "param kick_clickLevel 0.08 @min 0 @max 1",
                  "varname": "kick_clickLevel"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-drive",
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
                  "rnbo_uniqueid": "kick_drive",
                  "text": "param kick_drive 1.8 @min 0.25 @max 8",
                  "varname": "kick_drive"
                }
              },
              {
                "box": {
                  "id": "kick-rnbo-param-level",
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
                  "rnbo_uniqueid": "kick_level",
                  "text": "param kick_level 0.5 @min 0 @max 1",
                  "varname": "kick_level"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    945,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "snare_in_rnbo-in",
                  "text": "inport hit_snare"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    945,
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
                  "rnbo_uniqueid": "snare_p_rnbo-voice",
                  "text": "p snare_core",
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
                    "title": "MLR RNBO Snare Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR snare core — pitched shell + filtered noise wires",
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
                            "code": "// Twelve controls are sampled only when trig is positive. A parameter change\n// between hits therefore cannot reshape either the body or noise tail.\n@state hitBodyHz = 180;\n@state hitBodyDecay = 180;\n@state hitBodyBend = 90;\n@state hitBodyFM = 0.35;\n@state hitNoiseDecay = 260;\n@state hitNoiseHz = 3500;\n@state hitNoiseQ = 1.1;\n@state hitSnap = 0.45;\n@state hitBodyLevel = 0.65;\n@state hitNoiseLevel = 0.72;\n@state hitDrive = 1.7;\n@state hitLevel = 0.45;\n\n@state bodyEnv = 0;\n@state noiseEnv = 0;\n@state bendEnv = 0;\n@state snapEnv = 0;\n@state bodyPhase = 0;\n@state modePhase = 0;\n@state modPhase = 0;\n@state noiseState = 0.17320508;\n@state svfIc1 = 0;\n@state svfIc2 = 0;\n\nlet trig = in1;\nlet sr = samplerate();\n\nif (trig > 0) {\n    hitBodyHz = in2;\n    hitBodyBend = in3;\n    hitNoiseDecay = in4;\n    hitBodyDecay = in5;\n    hitBodyFM = in6;\n    hitNoiseHz = in7;\n    hitBodyLevel = in8;\n    hitNoiseLevel = in9;\n    hitNoiseQ = in10;\n    hitSnap = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n    bodyEnv = 1;\n    noiseEnv = 1;\n    bendEnv = 1;\n    snapEnv = 1;\n    bodyPhase = 0;\n    modePhase = 0;\n    modPhase = 0;\n    svfIc1 = 0;\n    svfIc2 = 0;\n}\n\nlet bodyCoef = exp(-6.907755 / (maximum(5, hitBodyDecay) * 0.001 * sr));\nlet noiseCoef = exp(-6.907755 / (maximum(5, hitNoiseDecay) * 0.001 * sr));\nlet bendCoef = exp(-6.907755 / (0.022 * sr));\nlet snapCoef = exp(-6.907755 / (0.014 * sr));\nbodyEnv *= bodyCoef;\nnoiseEnv *= noiseCoef;\nbendEnv *= bendCoef;\nsnapEnv *= snapCoef;\n\nlet bodyHz = maximum(20, hitBodyHz) + maximum(0, hitBodyBend) * bendEnv;\nmodPhase = wrap(modPhase + bodyHz * 1.61803399 / sr, 0, 1);\nlet bodyFM = sin(modPhase * 6.283185307179586) * bodyHz * maximum(0, hitBodyFM) * bodyEnv;\nlet bodyFreq = clamp(bodyHz + bodyFM, 10, sr * 0.45);\nbodyPhase = wrap(bodyPhase + bodyFreq / sr, 0, 1);\nmodePhase = wrap(modePhase + bodyFreq * 1.472 / sr, 0, 1);\nlet body = (sin(bodyPhase * 6.283185307179586) + 0.32 * sin(modePhase * 6.283185307179586)) * bodyEnv;\n\n// A bounded irrational recurrence supplies a lightweight noise source without\n// relying on a host-specific random operator.\nnoiseState = wrap(noiseState * 1.324717957 + 0.1234567, 0, 1);\nlet white = noiseState * 2 - 1;\nlet filterHz = clamp(hitNoiseHz, 40, sr * 0.45);\nlet g = tan(3.141592653589793 * filterHz / sr);\nlet k = 1 / maximum(0.5, hitNoiseQ);\nlet a1 = 1 / (1 + g * (g + k));\nlet a2 = g * a1;\nlet a3 = g * a2;\nlet v3 = white - svfIc2;\nlet band = a1 * svfIc1 + a2 * v3;\nlet low = svfIc2 + a2 * svfIc1 + a3 * v3;\nsvfIc1 = 2 * band - svfIc1;\nsvfIc2 = 2 * low - svfIc2;\nlet high = white - k * band - low;\nlet snap = clamp(hitSnap, 0, 1);\nlet wires = band * 2.4 * noiseEnv;\nlet attack = high * 0.9 * snapEnv + trig * 0.12;\n\nlet raw = body * clamp(hitBodyLevel, 0, 1) +\n    (wires * (1 - snap * 0.25) + attack * snap) * clamp(hitNoiseLevel, 0, 1);\nlet drive = maximum(0.01, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
                          },
                          "code": "// Twelve controls are sampled only when trig is positive. A parameter change\n// between hits therefore cannot reshape either the body or noise tail.\n@state hitBodyHz = 180;\n@state hitBodyDecay = 180;\n@state hitBodyBend = 90;\n@state hitBodyFM = 0.35;\n@state hitNoiseDecay = 260;\n@state hitNoiseHz = 3500;\n@state hitNoiseQ = 1.1;\n@state hitSnap = 0.45;\n@state hitBodyLevel = 0.65;\n@state hitNoiseLevel = 0.72;\n@state hitDrive = 1.7;\n@state hitLevel = 0.45;\n\n@state bodyEnv = 0;\n@state noiseEnv = 0;\n@state bendEnv = 0;\n@state snapEnv = 0;\n@state bodyPhase = 0;\n@state modePhase = 0;\n@state modPhase = 0;\n@state noiseState = 0.17320508;\n@state svfIc1 = 0;\n@state svfIc2 = 0;\n\nlet trig = in1;\nlet sr = samplerate();\n\nif (trig > 0) {\n    hitBodyHz = in2;\n    hitBodyBend = in3;\n    hitNoiseDecay = in4;\n    hitBodyDecay = in5;\n    hitBodyFM = in6;\n    hitNoiseHz = in7;\n    hitBodyLevel = in8;\n    hitNoiseLevel = in9;\n    hitNoiseQ = in10;\n    hitSnap = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n    bodyEnv = 1;\n    noiseEnv = 1;\n    bendEnv = 1;\n    snapEnv = 1;\n    bodyPhase = 0;\n    modePhase = 0;\n    modPhase = 0;\n    svfIc1 = 0;\n    svfIc2 = 0;\n}\n\nlet bodyCoef = exp(-6.907755 / (maximum(5, hitBodyDecay) * 0.001 * sr));\nlet noiseCoef = exp(-6.907755 / (maximum(5, hitNoiseDecay) * 0.001 * sr));\nlet bendCoef = exp(-6.907755 / (0.022 * sr));\nlet snapCoef = exp(-6.907755 / (0.014 * sr));\nbodyEnv *= bodyCoef;\nnoiseEnv *= noiseCoef;\nbendEnv *= bendCoef;\nsnapEnv *= snapCoef;\n\nlet bodyHz = maximum(20, hitBodyHz) + maximum(0, hitBodyBend) * bendEnv;\nmodPhase = wrap(modPhase + bodyHz * 1.61803399 / sr, 0, 1);\nlet bodyFM = sin(modPhase * 6.283185307179586) * bodyHz * maximum(0, hitBodyFM) * bodyEnv;\nlet bodyFreq = clamp(bodyHz + bodyFM, 10, sr * 0.45);\nbodyPhase = wrap(bodyPhase + bodyFreq / sr, 0, 1);\nmodePhase = wrap(modePhase + bodyFreq * 1.472 / sr, 0, 1);\nlet body = (sin(bodyPhase * 6.283185307179586) + 0.32 * sin(modePhase * 6.283185307179586)) * bodyEnv;\n\n// A bounded irrational recurrence supplies a lightweight noise source without\n// relying on a host-specific random operator.\nnoiseState = wrap(noiseState * 1.324717957 + 0.1234567, 0, 1);\nlet white = noiseState * 2 - 1;\nlet filterHz = clamp(hitNoiseHz, 40, sr * 0.45);\nlet g = tan(3.141592653589793 * filterHz / sr);\nlet k = 1 / maximum(0.5, hitNoiseQ);\nlet a1 = 1 / (1 + g * (g + k));\nlet a2 = g * a1;\nlet a3 = g * a2;\nlet v3 = white - svfIc2;\nlet band = a1 * svfIc1 + a2 * v3;\nlet low = svfIc2 + a2 * svfIc1 + a3 * v3;\nsvfIc1 = 2 * band - svfIc1;\nsvfIc2 = 2 * low - svfIc2;\nlet high = white - k * band - low;\nlet snap = clamp(hitSnap, 0, 1);\nlet wires = band * 2.4 * noiseEnv;\nlet attack = high * 0.9 * snapEnv + trig * 0.12;\n\nlet raw = body * clamp(hitBodyLevel, 0, 1) +\n    (wires * (1 - snap * 0.25) + attack * snap) * clamp(hitNoiseLevel, 0, 1);\nlet drive = maximum(0.01, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
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
                  "id": "snare-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    945,
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
                  "rnbo_uniqueid": "snare_out~_rnbo-out1",
                  "text": "out~ 2"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-comment",
                  "linecount": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    945,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_snare_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-bodyHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    725,
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
                  "rnbo_uniqueid": "snare_bodyHz",
                  "text": "param snare_bodyHz 180 @min 40 @max 1200 @unit Hz",
                  "varname": "snare_bodyHz"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-bodyBend",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    725,
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
                  "rnbo_uniqueid": "snare_bodyBend",
                  "text": "param snare_bodyBend 90 @min 0 @max 1200 @unit Hz",
                  "varname": "snare_bodyBend"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-noiseDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    725,
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
                  "rnbo_uniqueid": "snare_noiseDecayMs",
                  "text": "param snare_noiseDecayMs 260 @min 5 @max 10000 @unit ms",
                  "varname": "snare_noiseDecayMs"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-bodyDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    725,
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
                  "rnbo_uniqueid": "snare_bodyDecayMs",
                  "text": "param snare_bodyDecayMs 180 @min 5 @max 5000 @unit ms",
                  "varname": "snare_bodyDecayMs"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-bodyFM",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    725,
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
                  "rnbo_uniqueid": "snare_bodyFM",
                  "text": "param snare_bodyFM 0.35 @min 0 @max 16",
                  "varname": "snare_bodyFM"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-noiseHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    725,
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
                  "rnbo_uniqueid": "snare_noiseHz",
                  "text": "param snare_noiseHz 3500 @min 100 @max 18000 @unit Hz",
                  "varname": "snare_noiseHz"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-bodyLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1170,
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
                  "rnbo_uniqueid": "snare_bodyLevel",
                  "text": "param snare_bodyLevel 0.65 @min 0 @max 1",
                  "varname": "snare_bodyLevel"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-noiseLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1170,
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
                  "rnbo_uniqueid": "snare_noiseLevel",
                  "text": "param snare_noiseLevel 0.72 @min 0 @max 1",
                  "varname": "snare_noiseLevel"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-noiseQ",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1170,
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
                  "rnbo_uniqueid": "snare_noiseQ",
                  "text": "param snare_noiseQ 1.1 @min 0.5 @max 20",
                  "varname": "snare_noiseQ"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-snap",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1170,
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
                  "rnbo_uniqueid": "snare_snap",
                  "text": "param snare_snap 0.45 @min 0 @max 1",
                  "varname": "snare_snap"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1170,
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
                  "rnbo_uniqueid": "snare_drive",
                  "text": "param snare_drive 1.7 @min 0.25 @max 8",
                  "varname": "snare_drive"
                }
              },
              {
                "box": {
                  "id": "snare-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1170,
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
                  "rnbo_uniqueid": "snare_level",
                  "text": "param snare_level 0.45 @min 0 @max 1",
                  "varname": "snare_level"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    1645,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "hat_in_rnbo-in",
                  "text": "inport hit_hat"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    1645,
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
                  "rnbo_uniqueid": "hat_p_rnbo-voice",
                  "text": "p hat_core",
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
                    "title": "MLR RNBO Hat Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR hat core — inharmonic metal + filtered noise",
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
                            "code": "// All controls latch at the hit: later edits do not reshape the ringing tail.\n@state hitPitch = 700;\n@state hitInharmonicity = 0.65;\n@state hitNoiseDecay = 85;\n@state hitDecay = 120;\n@state hitSpread = 1;\n@state hitFilterHz = 6500;\n@state hitMetalLevel = 0.7;\n@state hitNoiseLevel = 0.55;\n@state hitFilterQ = 0.8;\n@state hitAttack = 0.4;\n@state hitDrive = 1.4;\n@state hitLevel = 0.4;\n@state metalEnv = 0;\n@state noiseEnv = 0;\n@state attackEnv = 0;\n@state phase1 = 0;\n@state phase2 = 0;\n@state phase3 = 0;\n@state phase4 = 0;\n@state phase5 = 0;\n@state phase6 = 0;\n@state noiseState = 12344;\n@state svfIc1 = 0;\n@state svfIc2 = 0;\n\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitch = in2;\n    hitInharmonicity = in3;\n    hitNoiseDecay = in4;\n    hitDecay = in5;\n    hitSpread = in6;\n    hitFilterHz = in7;\n    hitMetalLevel = in8;\n    hitNoiseLevel = in9;\n    hitFilterQ = in10;\n    hitAttack = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n    metalEnv = 1;\n    noiseEnv = 1;\n    attackEnv = 1;\n    svfIc1 = 0;\n    svfIc2 = 0;\n}\nmetalEnv *= exp(-6.907755 / (maximum(5, hitDecay) * 0.001 * sr));\nnoiseEnv *= exp(-6.907755 / (maximum(5, hitNoiseDecay) * 0.001 * sr));\nattackEnv *= exp(-6.907755 / (0.008 * sr));\n\n// Six free-running sine modes, paired ring modulation and a small direct mix.\n// Each mode stays below 0.22 sr so pairwise sum frequencies remain below Nyquist.\nlet pitch = maximum(100, hitPitch);\nlet spread = clamp(hitSpread, 0.1, 4);\nlet inh = clamp(hitInharmonicity, 0, 1);\nphase1 = wrap(phase1 + minimum(pitch, sr * 0.22) / sr, 0, 1);\nphase2 = wrap(phase2 + minimum(pitch * (1 + spread * (1 - 0.658 * inh)), sr * 0.22) / sr, 0, 1);\nphase3 = wrap(phase3 + minimum(pitch * (1 + spread * (2 - 1.231 * inh)), sr * 0.22) / sr, 0, 1);\nphase4 = wrap(phase4 + minimum(pitch * (1 + spread * (3 - 1.587 * inh)), sr * 0.22) / sr, 0, 1);\nphase5 = wrap(phase5 + minimum(pitch * (1 + spread * (4 - 1.858 * inh)), sr * 0.22) / sr, 0, 1);\nphase6 = wrap(phase6 + minimum(pitch * (1 + spread * (5 - 1.827 * inh)), sr * 0.22) / sr, 0, 1);\nlet m1 = sin(phase1 * 6.283185307179586);\nlet m2 = sin(phase2 * 6.283185307179586);\nlet m3 = sin(phase3 * 6.283185307179586);\nlet m4 = sin(phase4 * 6.283185307179586);\nlet m5 = sin(phase5 * 6.283185307179586);\nlet m6 = sin(phase6 * 6.283185307179586);\nlet metal = (m1 * m4 + m2 * m5 + m3 * m6) * 0.55 + (m2 + m4 + m6) * 0.12;\n\n// Multiplicative congruential generator: integer arithmetic stays exact in doubles.\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet excitation = metal * metalEnv * clamp(hitMetalLevel, 0, 1) +\n    white * (noiseEnv + attackEnv * clamp(hitAttack, 0, 1)) * clamp(hitNoiseLevel, 0, 1);\n// TPT state-variable filter: band and high outputs keep the source bright.\nlet g = tan(3.141592653589793 * clamp(hitFilterHz, 100, sr * 0.45) / sr);\nlet k = 1 / maximum(0.5, hitFilterQ);\nlet a1 = 1 / (1 + g * (g + k));\nlet a2 = g * a1;\nlet a3 = g * a2;\nlet v3 = excitation - svfIc2;\nlet band = a1 * svfIc1 + a2 * v3;\nlet low = svfIc2 + a2 * svfIc1 + a3 * v3;\nsvfIc1 = 2 * band - svfIc1;\nsvfIc2 = 2 * low - svfIc2;\nlet high = excitation - k * band - low;\nlet raw = high * 0.7 + band * k * 0.8;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
                          },
                          "code": "// All controls latch at the hit: later edits do not reshape the ringing tail.\n@state hitPitch = 700;\n@state hitInharmonicity = 0.65;\n@state hitNoiseDecay = 85;\n@state hitDecay = 120;\n@state hitSpread = 1;\n@state hitFilterHz = 6500;\n@state hitMetalLevel = 0.7;\n@state hitNoiseLevel = 0.55;\n@state hitFilterQ = 0.8;\n@state hitAttack = 0.4;\n@state hitDrive = 1.4;\n@state hitLevel = 0.4;\n@state metalEnv = 0;\n@state noiseEnv = 0;\n@state attackEnv = 0;\n@state phase1 = 0;\n@state phase2 = 0;\n@state phase3 = 0;\n@state phase4 = 0;\n@state phase5 = 0;\n@state phase6 = 0;\n@state noiseState = 12344;\n@state svfIc1 = 0;\n@state svfIc2 = 0;\n\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitch = in2;\n    hitInharmonicity = in3;\n    hitNoiseDecay = in4;\n    hitDecay = in5;\n    hitSpread = in6;\n    hitFilterHz = in7;\n    hitMetalLevel = in8;\n    hitNoiseLevel = in9;\n    hitFilterQ = in10;\n    hitAttack = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n    metalEnv = 1;\n    noiseEnv = 1;\n    attackEnv = 1;\n    svfIc1 = 0;\n    svfIc2 = 0;\n}\nmetalEnv *= exp(-6.907755 / (maximum(5, hitDecay) * 0.001 * sr));\nnoiseEnv *= exp(-6.907755 / (maximum(5, hitNoiseDecay) * 0.001 * sr));\nattackEnv *= exp(-6.907755 / (0.008 * sr));\n\n// Six free-running sine modes, paired ring modulation and a small direct mix.\n// Each mode stays below 0.22 sr so pairwise sum frequencies remain below Nyquist.\nlet pitch = maximum(100, hitPitch);\nlet spread = clamp(hitSpread, 0.1, 4);\nlet inh = clamp(hitInharmonicity, 0, 1);\nphase1 = wrap(phase1 + minimum(pitch, sr * 0.22) / sr, 0, 1);\nphase2 = wrap(phase2 + minimum(pitch * (1 + spread * (1 - 0.658 * inh)), sr * 0.22) / sr, 0, 1);\nphase3 = wrap(phase3 + minimum(pitch * (1 + spread * (2 - 1.231 * inh)), sr * 0.22) / sr, 0, 1);\nphase4 = wrap(phase4 + minimum(pitch * (1 + spread * (3 - 1.587 * inh)), sr * 0.22) / sr, 0, 1);\nphase5 = wrap(phase5 + minimum(pitch * (1 + spread * (4 - 1.858 * inh)), sr * 0.22) / sr, 0, 1);\nphase6 = wrap(phase6 + minimum(pitch * (1 + spread * (5 - 1.827 * inh)), sr * 0.22) / sr, 0, 1);\nlet m1 = sin(phase1 * 6.283185307179586);\nlet m2 = sin(phase2 * 6.283185307179586);\nlet m3 = sin(phase3 * 6.283185307179586);\nlet m4 = sin(phase4 * 6.283185307179586);\nlet m5 = sin(phase5 * 6.283185307179586);\nlet m6 = sin(phase6 * 6.283185307179586);\nlet metal = (m1 * m4 + m2 * m5 + m3 * m6) * 0.55 + (m2 + m4 + m6) * 0.12;\n\n// Multiplicative congruential generator: integer arithmetic stays exact in doubles.\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet excitation = metal * metalEnv * clamp(hitMetalLevel, 0, 1) +\n    white * (noiseEnv + attackEnv * clamp(hitAttack, 0, 1)) * clamp(hitNoiseLevel, 0, 1);\n// TPT state-variable filter: band and high outputs keep the source bright.\nlet g = tan(3.141592653589793 * clamp(hitFilterHz, 100, sr * 0.45) / sr);\nlet k = 1 / maximum(0.5, hitFilterQ);\nlet a1 = 1 / (1 + g * (g + k));\nlet a2 = g * a1;\nlet a3 = g * a2;\nlet v3 = excitation - svfIc2;\nlet band = a1 * svfIc1 + a2 * v3;\nlet low = svfIc2 + a2 * svfIc1 + a3 * v3;\nsvfIc1 = 2 * band - svfIc1;\nsvfIc2 = 2 * low - svfIc2;\nlet high = excitation - k * band - low;\nlet raw = high * 0.7 + band * k * 0.8;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
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
                  "id": "hat-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1645,
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
                  "rnbo_uniqueid": "hat_out~_rnbo-out1",
                  "text": "out~ 3"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-comment",
                  "linecount": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1645,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_hat_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-metalHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1425,
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
                  "rnbo_uniqueid": "hat_metalHz",
                  "text": "param hat_metalHz 700 @min 100 @max 6000 @unit Hz",
                  "varname": "hat_metalHz"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-inharmonicity",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1425,
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
                  "rnbo_uniqueid": "hat_inharmonicity",
                  "text": "param hat_inharmonicity 0.65 @min 0 @max 1",
                  "varname": "hat_inharmonicity"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-noiseDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1425,
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
                  "rnbo_uniqueid": "hat_noiseDecayMs",
                  "text": "param hat_noiseDecayMs 85 @min 5 @max 10000 @unit ms",
                  "varname": "hat_noiseDecayMs"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-decayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1425,
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
                  "rnbo_uniqueid": "hat_decayMs",
                  "text": "param hat_decayMs 120 @min 5 @max 10000 @unit ms",
                  "varname": "hat_decayMs"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-spread",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1425,
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
                  "rnbo_uniqueid": "hat_spread",
                  "text": "param hat_spread 1 @min 0.1 @max 4",
                  "varname": "hat_spread"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-filterHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1425,
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
                  "rnbo_uniqueid": "hat_filterHz",
                  "text": "param hat_filterHz 6500 @min 100 @max 18000 @unit Hz",
                  "varname": "hat_filterHz"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-metalLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1870,
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
                  "rnbo_uniqueid": "hat_metalLevel",
                  "text": "param hat_metalLevel 0.7 @min 0 @max 1",
                  "varname": "hat_metalLevel"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-noiseLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1870,
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
                  "rnbo_uniqueid": "hat_noiseLevel",
                  "text": "param hat_noiseLevel 0.55 @min 0 @max 1",
                  "varname": "hat_noiseLevel"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-filterQ",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1870,
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
                  "rnbo_uniqueid": "hat_filterQ",
                  "text": "param hat_filterQ 0.8 @min 0.5 @max 20",
                  "varname": "hat_filterQ"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-attack",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1870,
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
                  "rnbo_uniqueid": "hat_attack",
                  "text": "param hat_attack 0.4 @min 0 @max 1",
                  "varname": "hat_attack"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1870,
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
                  "rnbo_uniqueid": "hat_drive",
                  "text": "param hat_drive 1.4 @min 0.25 @max 8",
                  "varname": "hat_drive"
                }
              },
              {
                "box": {
                  "id": "hat-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1870,
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
                  "rnbo_uniqueid": "hat_level",
                  "text": "param hat_level 0.4 @min 0 @max 1",
                  "varname": "hat_level"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    2345,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "clap_in_rnbo-in",
                  "text": "inport hit_clap"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    2345,
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
                  "rnbo_uniqueid": "clap_p_rnbo-voice",
                  "text": "p clap_core",
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
                    "title": "MLR RNBO Clap Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR clap core — scattered noise bursts + diffuse tail",
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
                            "code": "// Controls are captured once per hit; the burst train runs at audio rate.\n@state hitCount = 3;\n@state hitScatter = 0.15;\n@state hitTailDecay = 280;\n@state hitBurstDecay = 10;\n@state hitSpacing = 12;\n@state hitFilterHz = 1600;\n@state hitBalance = 0.45;\n@state hitTailLevel = 0.65;\n@state hitFilterQ = 1.1;\n@state hitBrightness = 0.2;\n@state hitDrive = 1.5;\n@state hitLevel = 0.5;\n@state burstsLeft = 0;\n@state countdown = 0;\n@state burstEnv = 0;\n@state tailEnv = 0;\n@state tailRise = 0;\n@state noiseState = 12344;\n@state scatterState = 54320;\n@state svfIc1 = 0;\n@state svfIc2 = 0;\n\nlet trig = in1;\nlet sr = samplerate();\nlet burstPulse = 0;\nif (trig > 0) {\n    hitCount = in2;\n    hitScatter = in3;\n    hitTailDecay = in4;\n    hitBurstDecay = in5;\n    hitSpacing = in6;\n    hitFilterHz = in7;\n    hitBalance = in8;\n    hitTailLevel = in9;\n    hitFilterQ = in10;\n    hitBrightness = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n    burstsLeft = floor(clamp(hitCount, 1, 8) + 0.5) - 1;\n    burstPulse = 1;\n    burstEnv = 0;\n    tailEnv = 0;\n    tailRise = 0;\n    svfIc1 = 0;\n    svfIc2 = 0;\n} else if (burstsLeft > 0) {\n    countdown -= 1;\n    if (countdown <= 0) {\n        burstsLeft -= 1;\n        burstPulse = 1;\n    }\n}\nif (burstPulse > 0) {\n    burstEnv = 1;\n    if (burstsLeft > 0) {\n        // Independent PRNG: scatter does not depend on sample rate or audio noise.\n        scatterState = wrap((scatterState + 1) * 16807, 0, 2147483647) - 1;\n        let jitter = (scatterState + 1) / 1073741823.5 - 1;\n        let interval = maximum(2, hitSpacing) * (1 + jitter * clamp(hitScatter, 0, 1) * 0.45);\n        countdown = maximum(1, floor(interval * 0.001 * sr + 0.5));\n    } else {\n        // The diffuse tail blooms after the last clap, including one-burst hits.\n        tailEnv = 1;\n        tailRise = 0;\n    }\n}\nburstEnv *= exp(-6.907755 / (maximum(1, hitBurstDecay) * 0.001 * sr));\ntailEnv *= exp(-6.907755 / (maximum(5, hitTailDecay) * 0.001 * sr));\ntailRise = 1 - (1 - tailRise) * exp(-1 / (0.003 * sr));\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet balance = clamp(hitBalance, 0, 1);\nlet excitation = white * (burstEnv * (1 - balance) + tailEnv * tailRise * clamp(hitTailLevel, 0, 1) * balance) * 1.8;\n\n// TPT bandpass plus adjustable high-frequency noise supplies the clap's tone.\nlet g = tan(3.141592653589793 * clamp(hitFilterHz, 100, sr * 0.45) / sr);\nlet k = 1 / maximum(0.5, hitFilterQ);\nlet a1 = 1 / (1 + g * (g + k));\nlet a2 = g * a1;\nlet a3 = g * a2;\nlet v3 = excitation - svfIc2;\nlet band = a1 * svfIc1 + a2 * v3;\nlet low = svfIc2 + a2 * svfIc1 + a3 * v3;\nsvfIc1 = 2 * band - svfIc1;\nsvfIc2 = 2 * low - svfIc2;\nlet high = excitation - k * band - low;\nlet brightness = clamp(hitBrightness, 0, 1);\nlet raw = band * k * (1 - brightness * 0.4) + high * brightness * 0.65;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
                          },
                          "code": "// Controls are captured once per hit; the burst train runs at audio rate.\n@state hitCount = 3;\n@state hitScatter = 0.15;\n@state hitTailDecay = 280;\n@state hitBurstDecay = 10;\n@state hitSpacing = 12;\n@state hitFilterHz = 1600;\n@state hitBalance = 0.45;\n@state hitTailLevel = 0.65;\n@state hitFilterQ = 1.1;\n@state hitBrightness = 0.2;\n@state hitDrive = 1.5;\n@state hitLevel = 0.5;\n@state burstsLeft = 0;\n@state countdown = 0;\n@state burstEnv = 0;\n@state tailEnv = 0;\n@state tailRise = 0;\n@state noiseState = 12344;\n@state scatterState = 54320;\n@state svfIc1 = 0;\n@state svfIc2 = 0;\n\nlet trig = in1;\nlet sr = samplerate();\nlet burstPulse = 0;\nif (trig > 0) {\n    hitCount = in2;\n    hitScatter = in3;\n    hitTailDecay = in4;\n    hitBurstDecay = in5;\n    hitSpacing = in6;\n    hitFilterHz = in7;\n    hitBalance = in8;\n    hitTailLevel = in9;\n    hitFilterQ = in10;\n    hitBrightness = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n    burstsLeft = floor(clamp(hitCount, 1, 8) + 0.5) - 1;\n    burstPulse = 1;\n    burstEnv = 0;\n    tailEnv = 0;\n    tailRise = 0;\n    svfIc1 = 0;\n    svfIc2 = 0;\n} else if (burstsLeft > 0) {\n    countdown -= 1;\n    if (countdown <= 0) {\n        burstsLeft -= 1;\n        burstPulse = 1;\n    }\n}\nif (burstPulse > 0) {\n    burstEnv = 1;\n    if (burstsLeft > 0) {\n        // Independent PRNG: scatter does not depend on sample rate or audio noise.\n        scatterState = wrap((scatterState + 1) * 16807, 0, 2147483647) - 1;\n        let jitter = (scatterState + 1) / 1073741823.5 - 1;\n        let interval = maximum(2, hitSpacing) * (1 + jitter * clamp(hitScatter, 0, 1) * 0.45);\n        countdown = maximum(1, floor(interval * 0.001 * sr + 0.5));\n    } else {\n        // The diffuse tail blooms after the last clap, including one-burst hits.\n        tailEnv = 1;\n        tailRise = 0;\n    }\n}\nburstEnv *= exp(-6.907755 / (maximum(1, hitBurstDecay) * 0.001 * sr));\ntailEnv *= exp(-6.907755 / (maximum(5, hitTailDecay) * 0.001 * sr));\ntailRise = 1 - (1 - tailRise) * exp(-1 / (0.003 * sr));\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet balance = clamp(hitBalance, 0, 1);\nlet excitation = white * (burstEnv * (1 - balance) + tailEnv * tailRise * clamp(hitTailLevel, 0, 1) * balance) * 1.8;\n\n// TPT bandpass plus adjustable high-frequency noise supplies the clap's tone.\nlet g = tan(3.141592653589793 * clamp(hitFilterHz, 100, sr * 0.45) / sr);\nlet k = 1 / maximum(0.5, hitFilterQ);\nlet a1 = 1 / (1 + g * (g + k));\nlet a2 = g * a1;\nlet a3 = g * a2;\nlet v3 = excitation - svfIc2;\nlet band = a1 * svfIc1 + a2 * v3;\nlet low = svfIc2 + a2 * svfIc1 + a3 * v3;\nsvfIc1 = 2 * band - svfIc1;\nsvfIc2 = 2 * low - svfIc2;\nlet high = excitation - k * band - low;\nlet brightness = clamp(hitBrightness, 0, 1);\nlet raw = band * k * (1 - brightness * 0.4) + high * brightness * 0.65;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);"
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
                  "id": "clap-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    2345,
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
                  "rnbo_uniqueid": "clap_out~_rnbo-out1",
                  "text": "out~ 4"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-comment",
                  "linecount": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    2345,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_clap_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-count",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2125,
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
                  "rnbo_uniqueid": "clap_count",
                  "text": "param clap_count 3 @min 1 @max 8",
                  "varname": "clap_count"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-scatter",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2125,
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
                  "rnbo_uniqueid": "clap_scatter",
                  "text": "param clap_scatter 0.15 @min 0 @max 1",
                  "varname": "clap_scatter"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-tailDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2125,
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
                  "rnbo_uniqueid": "clap_tailDecayMs",
                  "text": "param clap_tailDecayMs 280 @min 5 @max 10000 @unit ms",
                  "varname": "clap_tailDecayMs"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-burstDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2125,
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
                  "rnbo_uniqueid": "clap_burstDecayMs",
                  "text": "param clap_burstDecayMs 10 @min 1 @max 200 @unit ms",
                  "varname": "clap_burstDecayMs"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-spacingMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2125,
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
                  "rnbo_uniqueid": "clap_spacingMs",
                  "text": "param clap_spacingMs 12 @min 2 @max 100 @unit ms",
                  "varname": "clap_spacingMs"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-filterHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2125,
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
                  "rnbo_uniqueid": "clap_filterHz",
                  "text": "param clap_filterHz 1600 @min 100 @max 18000 @unit Hz",
                  "varname": "clap_filterHz"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-balance",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2570,
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
                  "rnbo_uniqueid": "clap_balance",
                  "text": "param clap_balance 0.45 @min 0 @max 1",
                  "varname": "clap_balance"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-tailLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2570,
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
                  "rnbo_uniqueid": "clap_tailLevel",
                  "text": "param clap_tailLevel 0.65 @min 0 @max 1",
                  "varname": "clap_tailLevel"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-filterQ",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2570,
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
                  "rnbo_uniqueid": "clap_filterQ",
                  "text": "param clap_filterQ 1.1 @min 0.5 @max 20",
                  "varname": "clap_filterQ"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-brightness",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2570,
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
                  "rnbo_uniqueid": "clap_brightness",
                  "text": "param clap_brightness 0.2 @min 0 @max 1",
                  "varname": "clap_brightness"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2570,
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
                  "rnbo_uniqueid": "clap_drive",
                  "text": "param clap_drive 1.5 @min 0.25 @max 8",
                  "varname": "clap_drive"
                }
              },
              {
                "box": {
                  "id": "clap-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2570,
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
                  "rnbo_uniqueid": "clap_level",
                  "text": "param clap_level 0.5 @min 0 @max 1",
                  "varname": "clap_level"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    3045,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "tom_in_rnbo-in",
                  "text": "inport hit_tom"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    3045,
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
                  "rnbo_uniqueid": "tom_p_rnbo-voice",
                  "text": "p tom_core",
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
                    "title": "MLR RNBO Clap Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR Tom core",
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
                            "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitPitchHz = 140;\n@state hitDecayMs = 450;\n@state hitBendHz = 160;\n@state hitBendDecayMs = 35;\n@state hitFmAmount = 0.5;\n@state hitFmRatio = 1.5;\n@state hitModeRatio = 1.59;\n@state hitModeLevel = 0.25;\n@state hitNoiseLevel = 0.08;\n@state hitNoiseDecayMs = 12;\n@state hitDrive = 1.3;\n@state hitLevel = 0.5;\n@state active = 0;\n@state env = 0;\n@state bendEnv = 0;\n@state noiseEnv = 0;\n@state envCoef = 0;\n@state bendCoef = 0;\n@state noiseCoef = 0;\n@state phase = 0;\n@state modePhase = 0;\n@state modPhase = 0;\n@state noiseState = 12344;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitchHz = in2;\n    hitDecayMs = in3;\n    hitBendHz = in4;\n    hitBendDecayMs = in5;\n    hitFmAmount = in6;\n    hitFmRatio = in7;\n    hitModeRatio = in8;\n    hitModeLevel = in9;\n    hitNoiseLevel = in10;\n    hitNoiseDecayMs = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; bendEnv = 1; noiseEnv = 1;\n    phase = 0; modePhase = 0; modPhase = 0;\n    envCoef = exp(-6.907755 / (maximum(10, hitDecayMs) * 0.001 * sr));\n    bendCoef = exp(-6.907755 / (maximum(1, hitBendDecayMs) * 0.001 * sr));\n    noiseCoef = exp(-6.907755 / (maximum(1, hitNoiseDecayMs) * 0.001 * sr));\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; bendEnv *= bendCoef; noiseEnv *= noiseCoef;\nlet hz = clamp(hitPitchHz + hitBendHz * bendEnv, 20, sr * 0.2);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nphase = wrap(phase + hz / sr, 0, 1);\nmodePhase = wrap(modePhase + minimum(hz * hitModeRatio, sr * 0.45) / sr, 0, 1);\nlet membrane = sin(phase * 6.283185307179586 + sin(modPhase * 6.283185307179586) * hitFmAmount * env);\nlet shell = sin(modePhase * 6.283185307179586) * env * env;\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet raw = membrane * env * 0.8 + shell * hitModeLevel * 0.6 + white * noiseEnv * hitNoiseLevel * 0.4;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && noiseEnv < 0.0000001) active = 0;\n}"
                          },
                          "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitPitchHz = 140;\n@state hitDecayMs = 450;\n@state hitBendHz = 160;\n@state hitBendDecayMs = 35;\n@state hitFmAmount = 0.5;\n@state hitFmRatio = 1.5;\n@state hitModeRatio = 1.59;\n@state hitModeLevel = 0.25;\n@state hitNoiseLevel = 0.08;\n@state hitNoiseDecayMs = 12;\n@state hitDrive = 1.3;\n@state hitLevel = 0.5;\n@state active = 0;\n@state env = 0;\n@state bendEnv = 0;\n@state noiseEnv = 0;\n@state envCoef = 0;\n@state bendCoef = 0;\n@state noiseCoef = 0;\n@state phase = 0;\n@state modePhase = 0;\n@state modPhase = 0;\n@state noiseState = 12344;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitchHz = in2;\n    hitDecayMs = in3;\n    hitBendHz = in4;\n    hitBendDecayMs = in5;\n    hitFmAmount = in6;\n    hitFmRatio = in7;\n    hitModeRatio = in8;\n    hitModeLevel = in9;\n    hitNoiseLevel = in10;\n    hitNoiseDecayMs = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; bendEnv = 1; noiseEnv = 1;\n    phase = 0; modePhase = 0; modPhase = 0;\n    envCoef = exp(-6.907755 / (maximum(10, hitDecayMs) * 0.001 * sr));\n    bendCoef = exp(-6.907755 / (maximum(1, hitBendDecayMs) * 0.001 * sr));\n    noiseCoef = exp(-6.907755 / (maximum(1, hitNoiseDecayMs) * 0.001 * sr));\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; bendEnv *= bendCoef; noiseEnv *= noiseCoef;\nlet hz = clamp(hitPitchHz + hitBendHz * bendEnv, 20, sr * 0.2);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nphase = wrap(phase + hz / sr, 0, 1);\nmodePhase = wrap(modePhase + minimum(hz * hitModeRatio, sr * 0.45) / sr, 0, 1);\nlet membrane = sin(phase * 6.283185307179586 + sin(modPhase * 6.283185307179586) * hitFmAmount * env);\nlet shell = sin(modePhase * 6.283185307179586) * env * env;\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet raw = membrane * env * 0.8 + shell * hitModeLevel * 0.6 + white * noiseEnv * hitNoiseLevel * 0.4;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && noiseEnv < 0.0000001) active = 0;\n}"
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
                  "id": "tom-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    3045,
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
                  "rnbo_uniqueid": "tom_out~_rnbo-out1",
                  "text": "out~ 5"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-comment",
                  "linepitchHz": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    3045,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_tom_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-pitchHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2825,
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
                  "rnbo_uniqueid": "tom_pitchHz",
                  "text": "param tom_pitchHz 140 @min 30 @max 1600 @unit Hz",
                  "varname": "tom_pitchHz"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-bendDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2825,
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
                  "rnbo_uniqueid": "tom_bendDecayMs",
                  "text": "param tom_bendDecayMs 35 @min 1 @max 500 @unit ms",
                  "varname": "tom_bendDecayMs"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-fmAmount",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2825,
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
                  "rnbo_uniqueid": "tom_fmAmount",
                  "text": "param tom_fmAmount 0.5 @min 0 @max 10",
                  "varname": "tom_fmAmount"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-decayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2825,
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
                  "rnbo_uniqueid": "tom_decayMs",
                  "text": "param tom_decayMs 450 @min 10 @max 6000 @unit ms",
                  "varname": "tom_decayMs"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-bendHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2825,
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
                  "rnbo_uniqueid": "tom_bendHz",
                  "text": "param tom_bendHz 160 @min 0 @max 1200 @unit Hz",
                  "varname": "tom_bendHz"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-fmRatio",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    2825,
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
                  "rnbo_uniqueid": "tom_fmRatio",
                  "text": "param tom_fmRatio 1.5 @min 0.25 @max 8",
                  "varname": "tom_fmRatio"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-noiseLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3270,
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
                  "rnbo_uniqueid": "tom_noiseLevel",
                  "text": "param tom_noiseLevel 0.08 @min 0 @max 1",
                  "varname": "tom_noiseLevel"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-noiseDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3270,
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
                  "rnbo_uniqueid": "tom_noiseDecayMs",
                  "text": "param tom_noiseDecayMs 12 @min 1 @max 500 @unit ms",
                  "varname": "tom_noiseDecayMs"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3270,
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
                  "rnbo_uniqueid": "tom_drive",
                  "text": "param tom_drive 1.3 @min 0.25 @max 8",
                  "varname": "tom_drive"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-modeRatio",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3270,
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
                  "rnbo_uniqueid": "tom_modeRatio",
                  "text": "param tom_modeRatio 1.59 @min 1 @max 5",
                  "varname": "tom_modeRatio"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-modeLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3270,
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
                  "rnbo_uniqueid": "tom_modeLevel",
                  "text": "param tom_modeLevel 0.25 @min 0 @max 1",
                  "varname": "tom_modeLevel"
                }
              },
              {
                "box": {
                  "id": "tom-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3270,
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
                  "rnbo_uniqueid": "tom_level",
                  "text": "param tom_level 0.5 @min 0 @max 1",
                  "varname": "tom_level"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    3745,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "rim_in_rnbo-in",
                  "text": "inport hit_rim"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    3745,
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
                  "rnbo_uniqueid": "rim_p_rnbo-voice",
                  "text": "p rim_core",
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
                    "title": "MLR RNBO Clap Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR Rim core",
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
                            "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitPitchHz = 850;\n@state hitDecayMs = 65;\n@state hitModeRatio = 2.73;\n@state hitModeLevel = 0.65;\n@state hitClickLevel = 0.6;\n@state hitNoiseDecayMs = 4;\n@state hitFilterHz = 4200;\n@state hitFilterQ = 1.2;\n@state hitFmAmount = 0.2;\n@state hitFmRatio = 2;\n@state hitDrive = 1.8;\n@state hitLevel = 0.45;\n@state active = 0;\n@state env = 0;\n@state noiseEnv = 0;\n@state envCoef = 0;\n@state noiseCoef = 0;\n@state phase = 0;\n@state modePhase = 0;\n@state modPhase = 0;\n@state noiseState = 23455;\n@state ic1 = 0;\n@state ic2 = 0;\n@state k = 1;\n@state a1 = 1;\n@state a2 = 0;\n@state a3 = 0;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitchHz = in2;\n    hitDecayMs = in3;\n    hitModeRatio = in4;\n    hitModeLevel = in5;\n    hitClickLevel = in6;\n    hitNoiseDecayMs = in7;\n    hitFilterHz = in8;\n    hitFilterQ = in9;\n    hitFmAmount = in10;\n    hitFmRatio = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; noiseEnv = 1; phase = 0; modePhase = 0; modPhase = 0;\n    ic1 = 0; ic2 = 0;\n    envCoef = exp(-6.907755 / (maximum(1, hitDecayMs) * 0.001 * sr));\n    noiseCoef = exp(-6.907755 / (maximum(0.5, hitNoiseDecayMs) * 0.001 * sr));\n    let g = tan(3.141592653589793 * clamp(hitFilterHz, 200, sr * 0.45) / sr);\n    k = 1 / maximum(0.5, hitFilterQ);\n    a1 = 1 / (1 + g * (g + k)); a2 = g * a1; a3 = g * a2;\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; noiseEnv *= noiseCoef;\nlet hz = clamp(hitPitchHz, 100, sr * 0.2);\nphase = wrap(phase + hz / sr, 0, 1);\nmodePhase = wrap(modePhase + minimum(hz * hitModeRatio, sr * 0.45) / sr, 0, 1);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nlet body = sin(phase * 6.283185307179586 + sin(modPhase * 6.283185307179586) * hitFmAmount * env);\nlet shell = sin(modePhase * 6.283185307179586);\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet excitation = white * noiseEnv;\nlet v3 = excitation - ic2;\nlet band = a1 * ic1 + a2 * v3;\nlet low = ic2 + a2 * ic1 + a3 * v3;\nic1 = 2 * band - ic1; ic2 = 2 * low - ic2;\nlet high = excitation - k * band - low;\nlet raw = (body * 0.65 + shell * hitModeLevel * 0.6) * env + (band * k + high * 0.2) * hitClickLevel;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && noiseEnv < 0.0000001 && abs(ic1) + abs(ic2) < 0.0000001) active = 0;\n}"
                          },
                          "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitPitchHz = 850;\n@state hitDecayMs = 65;\n@state hitModeRatio = 2.73;\n@state hitModeLevel = 0.65;\n@state hitClickLevel = 0.6;\n@state hitNoiseDecayMs = 4;\n@state hitFilterHz = 4200;\n@state hitFilterQ = 1.2;\n@state hitFmAmount = 0.2;\n@state hitFmRatio = 2;\n@state hitDrive = 1.8;\n@state hitLevel = 0.45;\n@state active = 0;\n@state env = 0;\n@state noiseEnv = 0;\n@state envCoef = 0;\n@state noiseCoef = 0;\n@state phase = 0;\n@state modePhase = 0;\n@state modPhase = 0;\n@state noiseState = 23455;\n@state ic1 = 0;\n@state ic2 = 0;\n@state k = 1;\n@state a1 = 1;\n@state a2 = 0;\n@state a3 = 0;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitchHz = in2;\n    hitDecayMs = in3;\n    hitModeRatio = in4;\n    hitModeLevel = in5;\n    hitClickLevel = in6;\n    hitNoiseDecayMs = in7;\n    hitFilterHz = in8;\n    hitFilterQ = in9;\n    hitFmAmount = in10;\n    hitFmRatio = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; noiseEnv = 1; phase = 0; modePhase = 0; modPhase = 0;\n    ic1 = 0; ic2 = 0;\n    envCoef = exp(-6.907755 / (maximum(1, hitDecayMs) * 0.001 * sr));\n    noiseCoef = exp(-6.907755 / (maximum(0.5, hitNoiseDecayMs) * 0.001 * sr));\n    let g = tan(3.141592653589793 * clamp(hitFilterHz, 200, sr * 0.45) / sr);\n    k = 1 / maximum(0.5, hitFilterQ);\n    a1 = 1 / (1 + g * (g + k)); a2 = g * a1; a3 = g * a2;\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; noiseEnv *= noiseCoef;\nlet hz = clamp(hitPitchHz, 100, sr * 0.2);\nphase = wrap(phase + hz / sr, 0, 1);\nmodePhase = wrap(modePhase + minimum(hz * hitModeRatio, sr * 0.45) / sr, 0, 1);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nlet body = sin(phase * 6.283185307179586 + sin(modPhase * 6.283185307179586) * hitFmAmount * env);\nlet shell = sin(modePhase * 6.283185307179586);\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet excitation = white * noiseEnv;\nlet v3 = excitation - ic2;\nlet band = a1 * ic1 + a2 * v3;\nlet low = ic2 + a2 * ic1 + a3 * v3;\nic1 = 2 * band - ic1; ic2 = 2 * low - ic2;\nlet high = excitation - k * band - low;\nlet raw = (body * 0.65 + shell * hitModeLevel * 0.6) * env + (band * k + high * 0.2) * hitClickLevel;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && noiseEnv < 0.0000001 && abs(ic1) + abs(ic2) < 0.0000001) active = 0;\n}"
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
                  "id": "rim-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    3745,
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
                  "rnbo_uniqueid": "rim_out~_rnbo-out1",
                  "text": "out~ 6"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-comment",
                  "linepitchHz": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    3745,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_rim_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-pitchHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3525,
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
                  "rnbo_uniqueid": "rim_pitchHz",
                  "text": "param rim_pitchHz 850 @min 100 @max 6000 @unit Hz",
                  "varname": "rim_pitchHz"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-modeLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3525,
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
                  "rnbo_uniqueid": "rim_modeLevel",
                  "text": "param rim_modeLevel 0.65 @min 0 @max 1",
                  "varname": "rim_modeLevel"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-clickLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3525,
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
                  "rnbo_uniqueid": "rim_clickLevel",
                  "text": "param rim_clickLevel 0.6 @min 0 @max 1",
                  "varname": "rim_clickLevel"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-decayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3525,
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
                  "rnbo_uniqueid": "rim_decayMs",
                  "text": "param rim_decayMs 65 @min 1 @max 2000 @unit ms",
                  "varname": "rim_decayMs"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-modeRatio",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3525,
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
                  "rnbo_uniqueid": "rim_modeRatio",
                  "text": "param rim_modeRatio 2.73 @min 1 @max 8",
                  "varname": "rim_modeRatio"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-noiseDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3525,
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
                  "rnbo_uniqueid": "rim_noiseDecayMs",
                  "text": "param rim_noiseDecayMs 4 @min 0.5 @max 300 @unit ms",
                  "varname": "rim_noiseDecayMs"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-fmAmount",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3970,
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
                  "rnbo_uniqueid": "rim_fmAmount",
                  "text": "param rim_fmAmount 0.2 @min 0 @max 8",
                  "varname": "rim_fmAmount"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-fmRatio",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3970,
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
                  "rnbo_uniqueid": "rim_fmRatio",
                  "text": "param rim_fmRatio 2 @min 0.25 @max 8",
                  "varname": "rim_fmRatio"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3970,
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
                  "rnbo_uniqueid": "rim_drive",
                  "text": "param rim_drive 1.8 @min 0.25 @max 8",
                  "varname": "rim_drive"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-filterHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3970,
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
                  "rnbo_uniqueid": "rim_filterHz",
                  "text": "param rim_filterHz 4200 @min 200 @max 18000 @unit Hz",
                  "varname": "rim_filterHz"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-filterQ",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3970,
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
                  "rnbo_uniqueid": "rim_filterQ",
                  "text": "param rim_filterQ 1.2 @min 0.5 @max 15",
                  "varname": "rim_filterQ"
                }
              },
              {
                "box": {
                  "id": "rim-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    3970,
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
                  "rnbo_uniqueid": "rim_level",
                  "text": "param rim_level 0.45 @min 0 @max 1",
                  "varname": "rim_level"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    4445,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "bell_in_rnbo-in",
                  "text": "inport hit_bell"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    4445,
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
                  "rnbo_uniqueid": "bell_p_rnbo-voice",
                  "text": "p bell_core",
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
                    "title": "MLR RNBO Clap Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR Bell core",
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
                            "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitPitchHz = 440;\n@state hitDecayMs = 1600;\n@state hitFmRatio = 2.71;\n@state hitFmIndex = 3;\n@state hitFmDecayMs = 700;\n@state hitInharmonicity = 0.4;\n@state hitModeLevel = 0.3;\n@state hitModeDecayMs = 900;\n@state hitStrike = 0.2;\n@state hitBrightness = 0.65;\n@state hitDrive = 1;\n@state hitLevel = 0.35;\n@state active = 0;\n@state env = 0;\n@state fmEnv = 0;\n@state modeEnv = 0;\n@state strikeEnv = 0;\n@state envCoef = 0;\n@state fmCoef = 0;\n@state modeCoef = 0;\n@state strikeCoef = 0;\n@state phase = 0;\n@state modPhase = 0;\n@state mode1 = 0;\n@state mode2 = 0;\n@state noiseState = 34566;\n@state low = 0;\n@state lowCoef = 0;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitchHz = in2;\n    hitDecayMs = in3;\n    hitFmRatio = in4;\n    hitFmIndex = in5;\n    hitFmDecayMs = in6;\n    hitInharmonicity = in7;\n    hitModeLevel = in8;\n    hitModeDecayMs = in9;\n    hitStrike = in10;\n    hitBrightness = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; fmEnv = 1; modeEnv = 1; strikeEnv = 1;\n    phase = 0; modPhase = 0; mode1 = 0; mode2 = 0; low = 0;\n    envCoef = exp(-6.907755 / (maximum(20, hitDecayMs) * 0.001 * sr));\n    fmCoef = exp(-6.907755 / (maximum(5, hitFmDecayMs) * 0.001 * sr));\n    modeCoef = exp(-6.907755 / (maximum(10, hitModeDecayMs) * 0.001 * sr));\n    strikeCoef = exp(-6.907755 / (0.006 * sr));\n    lowCoef = exp(-6.283185307179586 * minimum(500 + 17500 * hitBrightness * hitBrightness, sr * 0.45) / sr);\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; fmEnv *= fmCoef; modeEnv *= modeCoef; strikeEnv *= strikeCoef;\nlet hz = clamp(hitPitchHz, 40, sr * 0.18);\nphase = wrap(phase + hz / sr, 0, 1);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nmode1 = wrap(mode1 + minimum(hz * (2 + hitInharmonicity * 0.756), sr * 0.45) / sr, 0, 1);\nmode2 = wrap(mode2 + minimum(hz * (4 + hitInharmonicity * 1.404), sr * 0.45) / sr, 0, 1);\nlet bell = sin(phase * 6.283185307179586 + sin(modPhase * 6.283185307179586) * hitFmIndex * fmEnv);\nlet modes = sin(mode1 * 6.283185307179586) + sin(mode2 * 6.283185307179586) * 0.55;\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet source = bell * env * 0.7 + modes * modeEnv * hitModeLevel * 0.4 + white * strikeEnv * hitStrike * 0.5;\nlow = source * (1 - lowCoef) + low * lowCoef;\nlet raw = low;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && modeEnv < 0.0000001 && abs(low) < 0.0000001) active = 0;\n}"
                          },
                          "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitPitchHz = 440;\n@state hitDecayMs = 1600;\n@state hitFmRatio = 2.71;\n@state hitFmIndex = 3;\n@state hitFmDecayMs = 700;\n@state hitInharmonicity = 0.4;\n@state hitModeLevel = 0.3;\n@state hitModeDecayMs = 900;\n@state hitStrike = 0.2;\n@state hitBrightness = 0.65;\n@state hitDrive = 1;\n@state hitLevel = 0.35;\n@state active = 0;\n@state env = 0;\n@state fmEnv = 0;\n@state modeEnv = 0;\n@state strikeEnv = 0;\n@state envCoef = 0;\n@state fmCoef = 0;\n@state modeCoef = 0;\n@state strikeCoef = 0;\n@state phase = 0;\n@state modPhase = 0;\n@state mode1 = 0;\n@state mode2 = 0;\n@state noiseState = 34566;\n@state low = 0;\n@state lowCoef = 0;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitPitchHz = in2;\n    hitDecayMs = in3;\n    hitFmRatio = in4;\n    hitFmIndex = in5;\n    hitFmDecayMs = in6;\n    hitInharmonicity = in7;\n    hitModeLevel = in8;\n    hitModeDecayMs = in9;\n    hitStrike = in10;\n    hitBrightness = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; fmEnv = 1; modeEnv = 1; strikeEnv = 1;\n    phase = 0; modPhase = 0; mode1 = 0; mode2 = 0; low = 0;\n    envCoef = exp(-6.907755 / (maximum(20, hitDecayMs) * 0.001 * sr));\n    fmCoef = exp(-6.907755 / (maximum(5, hitFmDecayMs) * 0.001 * sr));\n    modeCoef = exp(-6.907755 / (maximum(10, hitModeDecayMs) * 0.001 * sr));\n    strikeCoef = exp(-6.907755 / (0.006 * sr));\n    lowCoef = exp(-6.283185307179586 * minimum(500 + 17500 * hitBrightness * hitBrightness, sr * 0.45) / sr);\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; fmEnv *= fmCoef; modeEnv *= modeCoef; strikeEnv *= strikeCoef;\nlet hz = clamp(hitPitchHz, 40, sr * 0.18);\nphase = wrap(phase + hz / sr, 0, 1);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nmode1 = wrap(mode1 + minimum(hz * (2 + hitInharmonicity * 0.756), sr * 0.45) / sr, 0, 1);\nmode2 = wrap(mode2 + minimum(hz * (4 + hitInharmonicity * 1.404), sr * 0.45) / sr, 0, 1);\nlet bell = sin(phase * 6.283185307179586 + sin(modPhase * 6.283185307179586) * hitFmIndex * fmEnv);\nlet modes = sin(mode1 * 6.283185307179586) + sin(mode2 * 6.283185307179586) * 0.55;\nnoiseState = wrap((noiseState + 1) * 16807, 0, 2147483647) - 1;\nlet white = (noiseState + 1) / 1073741823.5 - 1;\nlet source = bell * env * 0.7 + modes * modeEnv * hitModeLevel * 0.4 + white * strikeEnv * hitStrike * 0.5;\nlow = source * (1 - lowCoef) + low * lowCoef;\nlet raw = low;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && modeEnv < 0.0000001 && abs(low) < 0.0000001) active = 0;\n}"
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
                  "id": "bell-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    4445,
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
                  "rnbo_uniqueid": "bell_out~_rnbo-out1",
                  "text": "out~ 7"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-comment",
                  "linepitchHz": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    4445,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_bell_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-pitchHz",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4225,
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
                  "rnbo_uniqueid": "bell_pitchHz",
                  "text": "param bell_pitchHz 440 @min 40 @max 4000 @unit Hz",
                  "varname": "bell_pitchHz"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-fmIndex",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4225,
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
                  "rnbo_uniqueid": "bell_fmIndex",
                  "text": "param bell_fmIndex 3 @min 0 @max 16",
                  "varname": "bell_fmIndex"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-fmDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4225,
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
                  "rnbo_uniqueid": "bell_fmDecayMs",
                  "text": "param bell_fmDecayMs 700 @min 5 @max 15000 @unit ms",
                  "varname": "bell_fmDecayMs"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-decayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4225,
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
                  "rnbo_uniqueid": "bell_decayMs",
                  "text": "param bell_decayMs 1600 @min 20 @max 15000 @unit ms",
                  "varname": "bell_decayMs"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-fmRatio",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4225,
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
                  "rnbo_uniqueid": "bell_fmRatio",
                  "text": "param bell_fmRatio 2.71 @min 0.25 @max 12",
                  "varname": "bell_fmRatio"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-inharmonicity",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4225,
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
                  "rnbo_uniqueid": "bell_inharmonicity",
                  "text": "param bell_inharmonicity 0.4 @min 0 @max 1",
                  "varname": "bell_inharmonicity"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-strike",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4670,
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
                  "rnbo_uniqueid": "bell_strike",
                  "text": "param bell_strike 0.2 @min 0 @max 1",
                  "varname": "bell_strike"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-brightness",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4670,
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
                  "rnbo_uniqueid": "bell_brightness",
                  "text": "param bell_brightness 0.65 @min 0 @max 1",
                  "varname": "bell_brightness"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4670,
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
                  "rnbo_uniqueid": "bell_drive",
                  "text": "param bell_drive 1 @min 0.25 @max 6",
                  "varname": "bell_drive"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-modeLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4670,
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
                  "rnbo_uniqueid": "bell_modeLevel",
                  "text": "param bell_modeLevel 0.3 @min 0 @max 1",
                  "varname": "bell_modeLevel"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-modeDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4670,
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
                  "rnbo_uniqueid": "bell_modeDecayMs",
                  "text": "param bell_modeDecayMs 900 @min 10 @max 15000 @unit ms",
                  "varname": "bell_modeDecayMs"
                }
              },
              {
                "box": {
                  "id": "bell-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4670,
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
                  "rnbo_uniqueid": "bell_level",
                  "text": "param bell_level 0.35 @min 0 @max 1",
                  "varname": "bell_level"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-in",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    5145,
                    40,
                    40,
                    23
                  ],
                  "rnbo_classname": "inport",
                  "rnbo_serial": 1,
                  "rnbo_uniqueid": "bass_in_rnbo-in",
                  "text": "inport hit_bass"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-voice",
                  "maxclass": "newobj",
                  "numinlets": 13,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    5145,
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
                  "rnbo_uniqueid": "bass_p_rnbo-voice",
                  "text": "p bass_core",
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
                    "title": "MLR RNBO Clap Voice",
                    "boxes": [
                      {
                        "box": {
                          "id": "obj-title",
                          "maxclass": "comment",
                          "text": "MLR FM Bass core",
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
                            "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitNote = 36;\n@state hitDecayMs = 550;\n@state hitFmIndex = 1.2;\n@state hitFmRatio = 1;\n@state hitFmDecayMs = 220;\n@state hitFeedback = 0.15;\n@state hitSubLevel = 0.35;\n@state hitBrightness = 0.6;\n@state hitAttackMs = 2;\n@state hitBendSemitones = 0;\n@state hitDrive = 1.4;\n@state hitLevel = 0.45;\n@state active = 0;\n@state env = 0;\n@state fmEnv = 0;\n@state attackEnv = 0;\n@state bendEnv = 0;\n@state envCoef = 0;\n@state fmCoef = 0;\n@state attackCoef = 0;\n@state bendCoef = 0;\n@state phase = 0;\n@state modPhase = 0;\n@state subPhase = 0;\n@state modLast = 0;\n@state low = 0;\n@state lowCoef = 0;\n@state baseHz = 65.406;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitNote = in2;\n    hitDecayMs = in3;\n    hitFmIndex = in4;\n    hitFmRatio = in5;\n    hitFmDecayMs = in6;\n    hitFeedback = in7;\n    hitSubLevel = in8;\n    hitBrightness = in9;\n    hitAttackMs = in10;\n    hitBendSemitones = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; fmEnv = 1; attackEnv = 0; bendEnv = 1;\n    phase = 0; modPhase = 0; subPhase = 0; modLast = 0; low = 0;\n    baseHz = 440 * pow(2, (floor(clamp(hitNote, 12, 96) + 0.5) - 69) / 12);\n    envCoef = exp(-6.907755 / (maximum(10, hitDecayMs) * 0.001 * sr));\n    fmCoef = exp(-6.907755 / (maximum(5, hitFmDecayMs) * 0.001 * sr));\n    attackCoef = exp(-4.60517 / (maximum(0.2, hitAttackMs) * 0.001 * sr));\n    bendCoef = exp(-6.907755 / (0.04 * sr));\n    lowCoef = exp(-6.283185307179586 * minimum(150 + 14000 * hitBrightness * hitBrightness, sr * 0.45) / sr);\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; fmEnv *= fmCoef; bendEnv *= bendCoef;\nattackEnv = 1 - (1 - attackEnv) * attackCoef;\nlet hz = minimum(baseHz * pow(2, hitBendSemitones * bendEnv / 12), sr * 0.2);\nphase = wrap(phase + hz / sr, 0, 1);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nsubPhase = wrap(subPhase + hz * 0.5 / sr, 0, 1);\nlet modulator = sin(modPhase * 6.283185307179586 + modLast * clamp(hitFeedback, 0, 0.95) * 3);\nmodLast = modulator;\nlet carrier = sin(phase * 6.283185307179586 + modulator * hitFmIndex * fmEnv);\nlet sub = sin(subPhase * 6.283185307179586);\nlet source = (carrier * 0.75 + sub * hitSubLevel * 0.6) * env * attackEnv;\nlow = source * (1 - lowCoef) + low * lowCoef;\nlet raw = low;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && abs(low) < 0.0000001) active = 0;\n}"
                          },
                          "code": "// Per-hit controls and coefficients are latched in the audio thread.\n@state hitNote = 36;\n@state hitDecayMs = 550;\n@state hitFmIndex = 1.2;\n@state hitFmRatio = 1;\n@state hitFmDecayMs = 220;\n@state hitFeedback = 0.15;\n@state hitSubLevel = 0.35;\n@state hitBrightness = 0.6;\n@state hitAttackMs = 2;\n@state hitBendSemitones = 0;\n@state hitDrive = 1.4;\n@state hitLevel = 0.45;\n@state active = 0;\n@state env = 0;\n@state fmEnv = 0;\n@state attackEnv = 0;\n@state bendEnv = 0;\n@state envCoef = 0;\n@state fmCoef = 0;\n@state attackCoef = 0;\n@state bendCoef = 0;\n@state phase = 0;\n@state modPhase = 0;\n@state subPhase = 0;\n@state modLast = 0;\n@state low = 0;\n@state lowCoef = 0;\n@state baseHz = 65.406;\nlet trig = in1;\nlet sr = samplerate();\nif (trig > 0) {\n    hitNote = in2;\n    hitDecayMs = in3;\n    hitFmIndex = in4;\n    hitFmRatio = in5;\n    hitFmDecayMs = in6;\n    hitFeedback = in7;\n    hitSubLevel = in8;\n    hitBrightness = in9;\n    hitAttackMs = in10;\n    hitBendSemitones = in11;\n    hitDrive = in12;\n    hitLevel = in13;\n}\nif (trig > 0) {\n    active = 1;\n    env = 1; fmEnv = 1; attackEnv = 0; bendEnv = 1;\n    phase = 0; modPhase = 0; subPhase = 0; modLast = 0; low = 0;\n    baseHz = 440 * pow(2, (floor(clamp(hitNote, 12, 96) + 0.5) - 69) / 12);\n    envCoef = exp(-6.907755 / (maximum(10, hitDecayMs) * 0.001 * sr));\n    fmCoef = exp(-6.907755 / (maximum(5, hitFmDecayMs) * 0.001 * sr));\n    attackCoef = exp(-4.60517 / (maximum(0.2, hitAttackMs) * 0.001 * sr));\n    bendCoef = exp(-6.907755 / (0.04 * sr));\n    lowCoef = exp(-6.283185307179586 * minimum(150 + 14000 * hitBrightness * hitBrightness, sr * 0.45) / sr);\n}\nout1 = 0;\nif (active > 0) {\nenv *= envCoef; fmEnv *= fmCoef; bendEnv *= bendCoef;\nattackEnv = 1 - (1 - attackEnv) * attackCoef;\nlet hz = minimum(baseHz * pow(2, hitBendSemitones * bendEnv / 12), sr * 0.2);\nphase = wrap(phase + hz / sr, 0, 1);\nmodPhase = wrap(modPhase + minimum(hz * hitFmRatio, sr * 0.45) / sr, 0, 1);\nsubPhase = wrap(subPhase + hz * 0.5 / sr, 0, 1);\nlet modulator = sin(modPhase * 6.283185307179586 + modLast * clamp(hitFeedback, 0, 0.95) * 3);\nmodLast = modulator;\nlet carrier = sin(phase * 6.283185307179586 + modulator * hitFmIndex * fmEnv);\nlet sub = sin(subPhase * 6.283185307179586);\nlet source = (carrier * 0.75 + sub * hitSubLevel * 0.6) * env * attackEnv;\nlow = source * (1 - lowCoef) + low * lowCoef;\nlet raw = low;\nlet drive = maximum(0.25, hitDrive);\nout1 = tanh(raw * drive) / tanh(drive) * clamp(hitLevel, 0, 1);\nif (env < 0.0000001 && abs(low) < 0.0000001) active = 0;\n}"
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
                  "id": "bass-rnbo-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    5145,
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
                  "rnbo_uniqueid": "bass_out~_rnbo-out1",
                  "text": "out~ 8"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-comment",
                  "linenote": 2,
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    5145,
                    255,
                    300,
                    35
                  ],
                  "text": "Exported params live here; reusable DSP core lives in rnbo_bass_voice.rnbopat"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-note",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4925,
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
                  "rnbo_uniqueid": "bass_note",
                  "text": "param bass_note 36 @min 12 @max 96 @unit MIDI",
                  "varname": "bass_note"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-fmRatio",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4925,
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
                  "rnbo_uniqueid": "bass_fmRatio",
                  "text": "param bass_fmRatio 1 @min 0.25 @max 8",
                  "varname": "bass_fmRatio"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-fmDecayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4925,
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
                  "rnbo_uniqueid": "bass_fmDecayMs",
                  "text": "param bass_fmDecayMs 220 @min 5 @max 6000 @unit ms",
                  "varname": "bass_fmDecayMs"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-decayMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4925,
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
                  "rnbo_uniqueid": "bass_decayMs",
                  "text": "param bass_decayMs 550 @min 10 @max 12000 @unit ms",
                  "varname": "bass_decayMs"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-fmIndex",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4925,
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
                  "rnbo_uniqueid": "bass_fmIndex",
                  "text": "param bass_fmIndex 1.2 @min 0 @max 12",
                  "varname": "bass_fmIndex"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-feedback",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    4925,
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
                  "rnbo_uniqueid": "bass_feedback",
                  "text": "param bass_feedback 0.15 @min 0 @max 0.95",
                  "varname": "bass_feedback"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-attackMs",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    5370,
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
                  "rnbo_uniqueid": "bass_attackMs",
                  "text": "param bass_attackMs 2 @min 0.2 @max 1000 @unit ms",
                  "varname": "bass_attackMs"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-bendSemitones",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    5370,
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
                  "rnbo_uniqueid": "bass_bendSemitones",
                  "text": "param bass_bendSemitones 0 @min -24 @max 24 @unit st",
                  "varname": "bass_bendSemitones"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-drive",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    5370,
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
                  "rnbo_uniqueid": "bass_drive",
                  "text": "param bass_drive 1.4 @min 0.25 @max 8",
                  "varname": "bass_drive"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-subLevel",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    5370,
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
                  "rnbo_uniqueid": "bass_subLevel",
                  "text": "param bass_subLevel 0.35 @min 0 @max 1",
                  "varname": "bass_subLevel"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-brightness",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    5370,
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
                  "rnbo_uniqueid": "bass_brightness",
                  "text": "param bass_brightness 0.6 @min 0 @max 1",
                  "varname": "bass_brightness"
                }
              },
              {
                "box": {
                  "id": "bass-rnbo-param-level",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    5370,
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
                  "rnbo_uniqueid": "bass_level",
                  "text": "param bass_level 0.45 @min 0 @max 1",
                  "varname": "bass_level"
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    0
                  ],
                  "source": [
                    "kick-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    4
                  ],
                  "source": [
                    "kick-rnbo-param-ampDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    1
                  ],
                  "source": [
                    "kick-rnbo-param-baseHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    10
                  ],
                  "source": [
                    "kick-rnbo-param-clickLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    11
                  ],
                  "source": [
                    "kick-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    5
                  ],
                  "source": [
                    "kick-rnbo-param-fmIndex",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    6
                  ],
                  "source": [
                    "kick-rnbo-param-fmRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    12
                  ],
                  "source": [
                    "kick-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    2
                  ],
                  "source": [
                    "kick-rnbo-param-pitchAmount",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    3
                  ],
                  "source": [
                    "kick-rnbo-param-pitchDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    8
                  ],
                  "source": [
                    "kick-rnbo-param-resonHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    7
                  ],
                  "source": [
                    "kick-rnbo-param-resonMix",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-voice",
                    9
                  ],
                  "source": [
                    "kick-rnbo-param-resonQ",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "kick-rnbo-out1",
                    0
                  ],
                  "source": [
                    "kick-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    0
                  ],
                  "source": [
                    "snare-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    4
                  ],
                  "source": [
                    "snare-rnbo-param-bodyDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    1
                  ],
                  "source": [
                    "snare-rnbo-param-bodyHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    10
                  ],
                  "source": [
                    "snare-rnbo-param-snap",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    11
                  ],
                  "source": [
                    "snare-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    5
                  ],
                  "source": [
                    "snare-rnbo-param-bodyFM",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    6
                  ],
                  "source": [
                    "snare-rnbo-param-noiseHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    12
                  ],
                  "source": [
                    "snare-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    2
                  ],
                  "source": [
                    "snare-rnbo-param-bodyBend",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    3
                  ],
                  "source": [
                    "snare-rnbo-param-noiseDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    8
                  ],
                  "source": [
                    "snare-rnbo-param-noiseLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    7
                  ],
                  "source": [
                    "snare-rnbo-param-bodyLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-voice",
                    9
                  ],
                  "source": [
                    "snare-rnbo-param-noiseQ",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "snare-rnbo-out1",
                    0
                  ],
                  "source": [
                    "snare-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    0
                  ],
                  "source": [
                    "hat-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    4
                  ],
                  "source": [
                    "hat-rnbo-param-decayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    1
                  ],
                  "source": [
                    "hat-rnbo-param-metalHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    10
                  ],
                  "source": [
                    "hat-rnbo-param-attack",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    11
                  ],
                  "source": [
                    "hat-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    5
                  ],
                  "source": [
                    "hat-rnbo-param-spread",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    6
                  ],
                  "source": [
                    "hat-rnbo-param-filterHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    12
                  ],
                  "source": [
                    "hat-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    2
                  ],
                  "source": [
                    "hat-rnbo-param-inharmonicity",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    3
                  ],
                  "source": [
                    "hat-rnbo-param-noiseDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    8
                  ],
                  "source": [
                    "hat-rnbo-param-noiseLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    7
                  ],
                  "source": [
                    "hat-rnbo-param-metalLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-voice",
                    9
                  ],
                  "source": [
                    "hat-rnbo-param-filterQ",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "hat-rnbo-out1",
                    0
                  ],
                  "source": [
                    "hat-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    0
                  ],
                  "source": [
                    "clap-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    4
                  ],
                  "source": [
                    "clap-rnbo-param-burstDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    1
                  ],
                  "source": [
                    "clap-rnbo-param-count",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    10
                  ],
                  "source": [
                    "clap-rnbo-param-brightness",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    11
                  ],
                  "source": [
                    "clap-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    5
                  ],
                  "source": [
                    "clap-rnbo-param-spacingMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    6
                  ],
                  "source": [
                    "clap-rnbo-param-filterHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    12
                  ],
                  "source": [
                    "clap-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    2
                  ],
                  "source": [
                    "clap-rnbo-param-scatter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    3
                  ],
                  "source": [
                    "clap-rnbo-param-tailDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    8
                  ],
                  "source": [
                    "clap-rnbo-param-tailLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    7
                  ],
                  "source": [
                    "clap-rnbo-param-balance",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-voice",
                    9
                  ],
                  "source": [
                    "clap-rnbo-param-filterQ",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "clap-rnbo-out1",
                    0
                  ],
                  "source": [
                    "clap-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    0
                  ],
                  "source": [
                    "tom-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    2
                  ],
                  "source": [
                    "tom-rnbo-param-decayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    1
                  ],
                  "source": [
                    "tom-rnbo-param-pitchHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    7
                  ],
                  "source": [
                    "tom-rnbo-param-modeRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    8
                  ],
                  "source": [
                    "tom-rnbo-param-modeLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    3
                  ],
                  "source": [
                    "tom-rnbo-param-bendHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    6
                  ],
                  "source": [
                    "tom-rnbo-param-fmRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    12
                  ],
                  "source": [
                    "tom-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    4
                  ],
                  "source": [
                    "tom-rnbo-param-bendDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    5
                  ],
                  "source": [
                    "tom-rnbo-param-fmAmount",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    10
                  ],
                  "source": [
                    "tom-rnbo-param-noiseDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    9
                  ],
                  "source": [
                    "tom-rnbo-param-noiseLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-voice",
                    11
                  ],
                  "source": [
                    "tom-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "tom-rnbo-out1",
                    0
                  ],
                  "source": [
                    "tom-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    0
                  ],
                  "source": [
                    "rim-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    2
                  ],
                  "source": [
                    "rim-rnbo-param-decayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    1
                  ],
                  "source": [
                    "rim-rnbo-param-pitchHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    7
                  ],
                  "source": [
                    "rim-rnbo-param-filterHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    8
                  ],
                  "source": [
                    "rim-rnbo-param-filterQ",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    3
                  ],
                  "source": [
                    "rim-rnbo-param-modeRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    6
                  ],
                  "source": [
                    "rim-rnbo-param-noiseDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    12
                  ],
                  "source": [
                    "rim-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    4
                  ],
                  "source": [
                    "rim-rnbo-param-modeLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    5
                  ],
                  "source": [
                    "rim-rnbo-param-clickLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    10
                  ],
                  "source": [
                    "rim-rnbo-param-fmRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    9
                  ],
                  "source": [
                    "rim-rnbo-param-fmAmount",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-voice",
                    11
                  ],
                  "source": [
                    "rim-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "rim-rnbo-out1",
                    0
                  ],
                  "source": [
                    "rim-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    0
                  ],
                  "source": [
                    "bell-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    2
                  ],
                  "source": [
                    "bell-rnbo-param-decayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    1
                  ],
                  "source": [
                    "bell-rnbo-param-pitchHz",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    7
                  ],
                  "source": [
                    "bell-rnbo-param-modeLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    8
                  ],
                  "source": [
                    "bell-rnbo-param-modeDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    3
                  ],
                  "source": [
                    "bell-rnbo-param-fmRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    6
                  ],
                  "source": [
                    "bell-rnbo-param-inharmonicity",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    12
                  ],
                  "source": [
                    "bell-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    4
                  ],
                  "source": [
                    "bell-rnbo-param-fmIndex",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    5
                  ],
                  "source": [
                    "bell-rnbo-param-fmDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    10
                  ],
                  "source": [
                    "bell-rnbo-param-brightness",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    9
                  ],
                  "source": [
                    "bell-rnbo-param-strike",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-voice",
                    11
                  ],
                  "source": [
                    "bell-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bell-rnbo-out1",
                    0
                  ],
                  "source": [
                    "bell-rnbo-voice",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    0
                  ],
                  "source": [
                    "bass-rnbo-in",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    2
                  ],
                  "source": [
                    "bass-rnbo-param-decayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    1
                  ],
                  "source": [
                    "bass-rnbo-param-note",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    7
                  ],
                  "source": [
                    "bass-rnbo-param-subLevel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    8
                  ],
                  "source": [
                    "bass-rnbo-param-brightness",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    3
                  ],
                  "source": [
                    "bass-rnbo-param-fmIndex",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    6
                  ],
                  "source": [
                    "bass-rnbo-param-feedback",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    12
                  ],
                  "source": [
                    "bass-rnbo-param-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    4
                  ],
                  "source": [
                    "bass-rnbo-param-fmRatio",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    5
                  ],
                  "source": [
                    "bass-rnbo-param-fmDecayMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    10
                  ],
                  "source": [
                    "bass-rnbo-param-bendSemitones",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    9
                  ],
                  "source": [
                    "bass-rnbo-param-attackMs",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-voice",
                    11
                  ],
                  "source": [
                    "bass-rnbo-param-drive",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "bass-rnbo-out1",
                    0
                  ],
                  "source": [
                    "bass-rnbo-voice",
                    0
                  ]
                }
              }
            ]
          },
          "saved_object_attributes": {
            "uuid": "806fb0ac-cb97-491f-9b4d-f55a46dc2178",
            "optimization": "O1"
          }
        }
      },
      {
        "box": {
          "id": "script",
          "maxclass": "newobj",
          "text": "v8 bank_export.js",
          "patching_rect": [
            30,
            80,
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
            410,
            80,
            350,
            22
          ]
        }
      },
      {
        "box": {
          "id": "note",
          "maxclass": "comment",
          "text": "Eight-voice DPT export: silent harness, no MLR subscriptions or hardware flashing.",
          "patching_rect": [
            30,
            25,
            700,
            22
          ]
        }
      },
      {
        "box": {
          "id": "retry",
          "maxclass": "message",
          "text": "bang",
          "patching_rect": [
            410,
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
            "retry",
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
            9
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
