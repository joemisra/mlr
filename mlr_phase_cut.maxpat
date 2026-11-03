{
  "patcher": {
    "fileversion": 1,
    "classnamespace": "box",
    "rect": [
      80,
      80,
      800,
      520
    ],
    "boxes": [
      {
        "box": {
          "id": "in1",
          "maxclass": "inlet",
          "index": 1,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            85,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "in2",
          "maxclass": "inlet",
          "index": 2,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            170,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "in3",
          "maxclass": "inlet",
          "index": 3,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            255,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "in4",
          "maxclass": "inlet",
          "index": 4,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            340,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "in5",
          "maxclass": "inlet",
          "index": 5,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            425,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "in6",
          "maxclass": "inlet",
          "index": 6,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            510,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "in7",
          "maxclass": "inlet",
          "index": 7,
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            595,
            30,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "gen",
          "maxclass": "newobj",
          "text": "gen~ @title mlr_phase_cut",
          "numinlets": 4,
          "numoutlets": 2,
          "patching_rect": [
            30,
            280,
            180,
            22
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "dsp.gen",
            "rect": [
              0,
              0,
              700,
              700
            ],
            "boxes": [
              {
                "box": {
                  "id": "in1",
                  "maxclass": "newobj",
                  "text": "in 1",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    100,
                    30,
                    180,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "in2",
                  "maxclass": "newobj",
                  "text": "in 2",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    200,
                    30,
                    180,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "in3",
                  "maxclass": "newobj",
                  "text": "in 3",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    300,
                    30,
                    180,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "in4",
                  "maxclass": "newobj",
                  "text": "in 4",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    400,
                    30,
                    180,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "code",
                  "maxclass": "codebox",
                  "numinlets": 4,
                  "numoutlets": 2,
                  "patching_rect": [
                    30,
                    80,
                    650,
                    560
                  ],
                  "code": "Buffer source(\"phasecut_unbound\");\nParam enabled(0); Param division(4); Param chance(0.35); Param range(4);\nParam repeat(0.25); Param reverse(0); Param wet(1); Param fade_ms(6); Param ramp(0);\nParam start_ms(0); Param end_ms(0); Param duration_ms(0); Param epoch(0);\nParam running(0); Param looping(1); Param stretching(0);\nHistory lastBase(0); History lastClock(0); History lastStep(-1); History lastEpoch(-1);\nHistory lastStart(0); History lastEnd(0); History lastEnabled(0);\nHistory head(0); History oldHead(0); History direction(1); History oldDirection(1);\nHistory active(0); History oldActive(0); History boundary(0);\nHistory repeatAnchor(0); History repeating(0); History transition(1); History amount(0);\nHistory progress(0); History oldProgress(0); History rampMode(0); History oldRampMode(0);\n// The groove~ transport keeps advancing; only these additional read heads change.\nbaseDelta = wrap(in3 - lastBase + 0.5, 0, 1) - 0.5;\nclockDelta = wrap(in4 - lastClock + 0.5, 0, 1) - 0.5;\nstep = floor(in4 * division);\nframes = dim(source);\nlo = clip(start_ms / max(duration_ms, 0.001), 0, 1);\nhi = clip(end_ms / max(duration_ms, 0.001), lo, 1);\nvalid = frames > 1 && hi > lo;\noperating = enabled && running && looping && !stretching && valid;\nseek = epoch != lastEpoch || start_ms != lastStart || end_ms != lastEnd || abs(baseDelta) > 0.05;\nhead = wrap(head + direction * baseDelta, 0, 1);\noldHead = wrap(oldHead + oldDirection * baseDelta, 0, 1);\nprogress = min(1, progress + abs(clockDelta) * division);\noldProgress = min(1, oldProgress + abs(clockDelta) * division);\nif (seek || (enabled > lastEnabled)) {\n head = in3; oldHead = in3; boundary = in3; repeatAnchor = in3;\n direction = 1; oldDirection = 1; active = 0; oldActive = 0; repeating = 0;\n transition = 1; progress = 0; oldProgress = 0; rampMode = ramp; oldRampMode = ramp;\n}\nif (step != lastStep && !seek) {\n oldHead = head; oldDirection = direction; oldActive = active;\n oldProgress = progress; oldRampMode = rampMode;\n progress = fract(in4 * division); rampMode = ramp;\n active = operating && ((noise() + 1) * 0.5 < chance);\n direction = active && ((noise() + 1) * 0.5 < reverse) ? -1 : 1;\n replay = active && ((noise() + 1) * 0.5 < repeat);\n jump = floor(((noise() + 1) * 0.5) * (2 * range + 1)) - range;\n // Consecutive repeat decisions replay the same segment; releasing follows base phase.\n if (replay && !repeating) repeatAnchor = boundary;\n if (!replay) repeatAnchor = wrap(in3 + (active ? jump / 16 : 0), 0, 1);\n head = replay ? repeatAnchor : wrap(in3 + (active ? jump / 16 : 0), 0, 1);\n repeating = replay; boundary = in3; transition = 0;\n}\n// Crossfade finishes before the next rhythmic decision, including fast tempi.\nfadeSamples = min(max(2, fade_ms) * samplerate / 1000, 0.45 / max(abs(clockDelta) * division, 0.000000001));\ntransition = min(1, transition + 1 / max(1, fadeSamples));\ntarget = operating * wet * (chance > 0);\namount = amount + clip(target - amount, -1 / (samplerate * 0.015), 1 / (samplerate * 0.015));\nout1 = in1; out2 = in2;\nif (amount > 0 && valid) {\n// Millisecond ratios respect the source file's sample rate and the active subloop.\nspan = max(0, (hi - lo) * frames - 1);\nindexA = lo * frames + head * span; indexB = lo * frames + oldHead * span;\nrightChannel = min(1, max(0, channels(source) - 1));\naL = peek(source, indexA, 0, interp=\"linear\", boundmode=\"clamp\");\naR = peek(source, indexA, rightChannel, interp=\"linear\", boundmode=\"clamp\");\nbL = peek(source, indexB, 0, interp=\"linear\", boundmode=\"clamp\");\nbR = peek(source, indexB, rightChannel, interp=\"linear\", boundmode=\"clamp\");\n// A short taper also makes wrap-around read discontinuities reach zero smoothly.\nedgeWidth = max(abs(baseDelta) * samplerate * 0.002, 1 / max(span, 1));\ngainA = clip(min(head, 1 - head) / edgeWidth, 0, 1);\ngainB = clip(min(oldHead, 1 - oldHead) / edgeWidth, 0, 1);\n// Each cut slice can rise or fall in volume; the outgoing slice keeps its envelope.\ngainA = gainA * (rampMode == 1 ? progress : rampMode == 2 ? 1 - progress : 1);\ngainB = gainB * (oldRampMode == 1 ? oldProgress : oldRampMode == 2 ? 1 - oldProgress : 1);\nnewL = mix(in1, aL * gainA, active); newR = mix(in2, aR * gainA, active);\noldL = mix(in1, bL * gainB, oldActive); oldR = mix(in2, bR * gainB, oldActive);\nout1 = mix(in1, mix(oldL, newL, transition), amount);\nout2 = mix(in2, mix(oldR, newR, transition), amount);\n}\nlastBase = in3; lastClock = in4; lastStep = step; lastEpoch = epoch;\nlastStart = start_ms; lastEnd = end_ms; lastEnabled = enabled;\n"
                }
              },
              {
                "box": {
                  "id": "out1",
                  "maxclass": "newobj",
                  "text": "out 1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    30,
                    660,
                    180,
                    22
                  ]
                }
              },
              {
                "box": {
                  "id": "out2",
                  "maxclass": "newobj",
                  "text": "out 2",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    30,
                    660,
                    180,
                    22
                  ]
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "in1",
                    0
                  ],
                  "destination": [
                    "code",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "in2",
                    0
                  ],
                  "destination": [
                    "code",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "in3",
                    0
                  ],
                  "destination": [
                    "code",
                    2
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "in4",
                    0
                  ],
                  "destination": [
                    "code",
                    3
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    0
                  ],
                  "destination": [
                    "out1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    1
                  ],
                  "destination": [
                    "out2",
                    0
                  ]
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "clock",
          "maxclass": "newobj",
          "text": "receive~ [time]phase",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            30,
            90,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "source",
          "maxclass": "newobj",
          "text": "prepend source",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            90,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "reset",
          "maxclass": "newobj",
          "text": "t b s",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            60,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "start",
          "maxclass": "newobj",
          "text": "prepend start_ms",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            120,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "end",
          "maxclass": "newobj",
          "text": "prepend end_ms",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            150,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "duration",
          "maxclass": "newobj",
          "text": "prepend duration_ms",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            180,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "controls",
          "maxclass": "newobj",
          "text": "r #1[phasecut]",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            30,
            210,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "running",
          "maxclass": "newobj",
          "text": "r #1[pl]on",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            30,
            350,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "runningparam",
          "maxclass": "newobj",
          "text": "prepend running",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            380,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "loop",
          "maxclass": "newobj",
          "text": "r #1[mlr]pl-playback-loop",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            30,
            350,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "loopparam",
          "maxclass": "newobj",
          "text": "prepend looping",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            380,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "route-loop",
          "maxclass": "newobj",
          "text": "route loop",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            30,
            370,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stretch",
          "maxclass": "newobj",
          "text": "r #1[ch]timestretch",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            30,
            350,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "stretchparam",
          "maxclass": "newobj",
          "text": "prepend stretching",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            30,
            380,
            180,
            22
          ]
        }
      },
      {
        "box": {
          "id": "out1",
          "maxclass": "outlet",
          "index": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            85,
            450,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "out2",
          "maxclass": "outlet",
          "index": 2,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            170,
            450,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "epoch",
          "maxclass": "newobj",
          "text": "counter",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            260,
            170,
            110,
            22
          ]
        }
      },
      {
        "box": {
          "id": "epoch-param",
          "maxclass": "newobj",
          "text": "prepend epoch",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            260,
            200,
            110,
            22
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "in1",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "in2",
            0
          ],
          "destination": [
            "gen",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "in3",
            0
          ],
          "destination": [
            "gen",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "clock",
            0
          ],
          "destination": [
            "gen",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "in4",
            0
          ],
          "destination": [
            "reset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reset",
            1
          ],
          "destination": [
            "source",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "source",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "in5",
            0
          ],
          "destination": [
            "start",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "in6",
            0
          ],
          "destination": [
            "end",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "in7",
            0
          ],
          "destination": [
            "duration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "start",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "end",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "duration",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "controls",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "running",
            0
          ],
          "destination": [
            "runningparam",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "runningparam",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "loop",
            0
          ],
          "destination": [
            "route-loop",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route-loop",
            0
          ],
          "destination": [
            "loopparam",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "loopparam",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stretch",
            0
          ],
          "destination": [
            "stretchparam",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stretchparam",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gen",
            0
          ],
          "destination": [
            "out1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gen",
            1
          ],
          "destination": [
            "out2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reset",
            0
          ],
          "destination": [
            "epoch",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "epoch",
            0
          ],
          "destination": [
            "epoch-param",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "epoch-param",
            0
          ],
          "destination": [
            "gen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "route-loop",
            1
          ],
          "destination": [
            "loopparam",
            0
          ]
        }
      }
    ]
  }
}
