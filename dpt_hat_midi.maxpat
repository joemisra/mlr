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
            1000,
            750
        ],
        "boxes": [
            {
                "box": {
                    "id": "manual",
                    "maxclass": "inlet",
                    "patching_rect": [
                        20,
                        20,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "hit",
                    "maxclass": "inlet",
                    "patching_rect": [
                        350,
                        20,
                        40,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "route",
                    "maxclass": "newobj",
                    "text": "route metalHz decayMs spread inharmonicity noiseDecayMs filterHz attack drive metalLevel noiseLevel filterQ level",
                    "patching_rect": [
                        20,
                        72,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "unpack",
                    "maxclass": "newobj",
                    "text": "unpack f f f f f f f f f f f f",
                    "patching_rect": [
                        20,
                        98,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "sync",
                    "maxclass": "inlet",
                    "patching_rect": [
                        650,
                        20,
                        40,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "sync-order",
                    "maxclass": "newobj",
                    "text": "t l b",
                    "patching_rect": [
                        20,
                        150,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "hit-order",
                    "maxclass": "newobj",
                    "text": "t l b",
                    "patching_rect": [
                        20,
                        176,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "sync-op",
                    "maxclass": "message",
                    "text": "set list 3",
                    "patching_rect": [
                        20,
                        202,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "hit-op",
                    "maxclass": "message",
                    "text": "set list 2",
                    "patching_rect": [
                        20,
                        228,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "snapshot",
                    "maxclass": "newobj",
                    "text": "pack 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0",
                    "patching_rect": [
                        20,
                        254,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "opcode",
                    "maxclass": "newobj",
                    "text": "prepend list 2",
                    "patching_rect": [
                        20,
                        280,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "voice",
                    "maxclass": "newobj",
                    "text": "prepend list 2",
                    "patching_rect": [
                        20,
                        306,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "prefix",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1",
                    "patching_rect": [
                        20,
                        332,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "end",
                    "maxclass": "newobj",
                    "text": "append 247",
                    "patching_rect": [
                        20,
                        358,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "enabled",
                    "maxclass": "newobj",
                    "text": "r dpt_enabled",
                    "patching_rect": [
                        20,
                        384,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "gate",
                    "maxclass": "newobj",
                    "text": "gate 1 0",
                    "patching_rect": [
                        20,
                        410,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "send",
                    "maxclass": "newobj",
                    "text": "s dpt_midi_bytes",
                    "patching_rect": [
                        20,
                        436,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-0",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 100.00000000 6000.00000000",
                    "patching_rect": [
                        20,
                        462,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-0",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 0",
                    "patching_rect": [
                        20,
                        488,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-0",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 100.00000000 6000.00000000",
                    "patching_rect": [
                        20,
                        514,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-0",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        540,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-1",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 5.00000000 10000.00000000",
                    "patching_rect": [
                        20,
                        566,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-1",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 1",
                    "patching_rect": [
                        20,
                        592,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-1",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 5.00000000 10000.00000000",
                    "patching_rect": [
                        20,
                        618,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-1",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        644,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-2",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.10000000 4.00000000",
                    "patching_rect": [
                        20,
                        670,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-2",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 2",
                    "patching_rect": [
                        20,
                        696,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-2",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.10000000 4.00000000",
                    "patching_rect": [
                        20,
                        722,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-2",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        748,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-3",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        774,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-3",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 3",
                    "patching_rect": [
                        20,
                        800,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-3",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        826,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-3",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        852,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-4",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 5.00000000 10000.00000000",
                    "patching_rect": [
                        20,
                        878,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-4",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 4",
                    "patching_rect": [
                        20,
                        904,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-4",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 5.00000000 10000.00000000",
                    "patching_rect": [
                        20,
                        930,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-4",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        956,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-5",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 100.00000000 18000.00000000",
                    "patching_rect": [
                        20,
                        982,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-5",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 5",
                    "patching_rect": [
                        20,
                        1008,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-5",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 100.00000000 18000.00000000",
                    "patching_rect": [
                        20,
                        1034,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-5",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1060,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-6",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1086,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-6",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 6",
                    "patching_rect": [
                        20,
                        1112,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-6",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1138,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-6",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1164,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-7",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.25000000 8.00000000",
                    "patching_rect": [
                        20,
                        1190,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-7",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 7",
                    "patching_rect": [
                        20,
                        1216,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-7",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.25000000 8.00000000",
                    "patching_rect": [
                        20,
                        1242,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-7",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1268,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-8",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1294,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-8",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 8",
                    "patching_rect": [
                        20,
                        1320,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-8",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1346,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-8",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1372,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-9",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1398,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-9",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 9",
                    "patching_rect": [
                        20,
                        1424,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-9",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1450,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-9",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1476,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-10",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.50000000 20.00000000",
                    "patching_rect": [
                        20,
                        1502,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-10",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 10",
                    "patching_rect": [
                        20,
                        1528,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-10",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.50000000 20.00000000",
                    "patching_rect": [
                        20,
                        1554,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-10",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1580,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-11",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1606,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "edit-prefix-11",
                    "maxclass": "newobj",
                    "text": "prepend list 240 125 77 76 82 1 1 2 11",
                    "patching_rect": [
                        20,
                        1632,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "encode-11",
                    "maxclass": "newobj",
                    "text": "dpt_pack21 0.00000000 1.00000000",
                    "patching_rect": [
                        20,
                        1658,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "bytes-11",
                    "maxclass": "newobj",
                    "text": "unpack i i i",
                    "patching_rect": [
                        20,
                        1684,
                        300,
                        22
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "manual",
                        0
                    ],
                    "destination": [
                        "route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "sync",
                        0
                    ],
                    "destination": [
                        "sync-order",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "sync-order",
                        1
                    ],
                    "destination": [
                        "sync-op",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "sync-order",
                        0
                    ],
                    "destination": [
                        "unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hit",
                        0
                    ],
                    "destination": [
                        "hit-order",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hit-order",
                        1
                    ],
                    "destination": [
                        "hit-op",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hit-order",
                        0
                    ],
                    "destination": [
                        "unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hit-op",
                        0
                    ],
                    "destination": [
                        "opcode",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "sync-op",
                        0
                    ],
                    "destination": [
                        "opcode",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "snapshot",
                        0
                    ],
                    "destination": [
                        "voice",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "voice",
                        0
                    ],
                    "destination": [
                        "opcode",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "opcode",
                        0
                    ],
                    "destination": [
                        "prefix",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "prefix",
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
                        "enabled",
                        0
                    ],
                    "destination": [
                        "gate",
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
                        "gate",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "gate",
                        0
                    ],
                    "destination": [
                        "send",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        0
                    ],
                    "destination": [
                        "edit-0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-0",
                        0
                    ],
                    "destination": [
                        "edit-prefix-0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-0",
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
                        "unpack",
                        0
                    ],
                    "destination": [
                        "encode-0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-0",
                        0
                    ],
                    "destination": [
                        "bytes-0",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-0",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-0",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-0",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        1
                    ],
                    "destination": [
                        "edit-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-1",
                        0
                    ],
                    "destination": [
                        "edit-prefix-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-1",
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
                        "unpack",
                        1
                    ],
                    "destination": [
                        "encode-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-1",
                        0
                    ],
                    "destination": [
                        "bytes-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-1",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-1",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-1",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        2
                    ],
                    "destination": [
                        "edit-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-2",
                        0
                    ],
                    "destination": [
                        "edit-prefix-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-2",
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
                        "unpack",
                        2
                    ],
                    "destination": [
                        "encode-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-2",
                        0
                    ],
                    "destination": [
                        "bytes-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-2",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-2",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-2",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        3
                    ],
                    "destination": [
                        "edit-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-3",
                        0
                    ],
                    "destination": [
                        "edit-prefix-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-3",
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
                        "unpack",
                        3
                    ],
                    "destination": [
                        "encode-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-3",
                        0
                    ],
                    "destination": [
                        "bytes-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-3",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-3",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-3",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        4
                    ],
                    "destination": [
                        "edit-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-4",
                        0
                    ],
                    "destination": [
                        "edit-prefix-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-4",
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
                        "unpack",
                        4
                    ],
                    "destination": [
                        "encode-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-4",
                        0
                    ],
                    "destination": [
                        "bytes-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-4",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-4",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        13
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-4",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        14
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        5
                    ],
                    "destination": [
                        "edit-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-5",
                        0
                    ],
                    "destination": [
                        "edit-prefix-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-5",
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
                        "unpack",
                        5
                    ],
                    "destination": [
                        "encode-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-5",
                        0
                    ],
                    "destination": [
                        "bytes-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-5",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        15
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-5",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        16
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-5",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        17
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        6
                    ],
                    "destination": [
                        "edit-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-6",
                        0
                    ],
                    "destination": [
                        "edit-prefix-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-6",
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
                        "unpack",
                        6
                    ],
                    "destination": [
                        "encode-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-6",
                        0
                    ],
                    "destination": [
                        "bytes-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-6",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        18
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-6",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        19
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-6",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        20
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        7
                    ],
                    "destination": [
                        "edit-7",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-7",
                        0
                    ],
                    "destination": [
                        "edit-prefix-7",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-7",
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
                        "unpack",
                        7
                    ],
                    "destination": [
                        "encode-7",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-7",
                        0
                    ],
                    "destination": [
                        "bytes-7",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-7",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        21
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-7",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        22
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-7",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        23
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        8
                    ],
                    "destination": [
                        "edit-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-8",
                        0
                    ],
                    "destination": [
                        "edit-prefix-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-8",
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
                        "unpack",
                        8
                    ],
                    "destination": [
                        "encode-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-8",
                        0
                    ],
                    "destination": [
                        "bytes-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-8",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        24
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-8",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        25
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-8",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        26
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        9
                    ],
                    "destination": [
                        "edit-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-9",
                        0
                    ],
                    "destination": [
                        "edit-prefix-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-9",
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
                        "unpack",
                        9
                    ],
                    "destination": [
                        "encode-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-9",
                        0
                    ],
                    "destination": [
                        "bytes-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-9",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        27
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-9",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        28
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-9",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        29
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        10
                    ],
                    "destination": [
                        "edit-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-10",
                        0
                    ],
                    "destination": [
                        "edit-prefix-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-10",
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
                        "unpack",
                        10
                    ],
                    "destination": [
                        "encode-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-10",
                        0
                    ],
                    "destination": [
                        "bytes-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-10",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        30
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-10",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        31
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-10",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        32
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "route",
                        11
                    ],
                    "destination": [
                        "edit-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-11",
                        0
                    ],
                    "destination": [
                        "edit-prefix-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "edit-prefix-11",
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
                        "unpack",
                        11
                    ],
                    "destination": [
                        "encode-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "encode-11",
                        0
                    ],
                    "destination": [
                        "bytes-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-11",
                        0
                    ],
                    "destination": [
                        "snapshot",
                        33
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-11",
                        1
                    ],
                    "destination": [
                        "snapshot",
                        34
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bytes-11",
                        2
                    ],
                    "destination": [
                        "snapshot",
                        35
                    ]
                }
            }
        ]
    }
}
