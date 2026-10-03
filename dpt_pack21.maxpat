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
                    "id": "in",
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
                    "id": "scale",
                    "maxclass": "newobj",
                    "text": "scale #1 #2 0. 2097151.",
                    "patching_rect": [
                        20,
                        46,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "clip",
                    "maxclass": "newobj",
                    "text": "clip 0. 2097151.",
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
                    "id": "round",
                    "maxclass": "newobj",
                    "text": "+ 0.5",
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
                    "id": "order",
                    "maxclass": "newobj",
                    "text": "t i i i",
                    "patching_rect": [
                        20,
                        124,
                        300,
                        22
                    ]
                }
            },
            {
                "box": {
                    "id": "hi",
                    "maxclass": "newobj",
                    "text": "expr ($i1 >> 14) & 127",
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
                    "id": "mid",
                    "maxclass": "newobj",
                    "text": "expr ($i1 >> 7) & 127",
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
                    "id": "lo",
                    "maxclass": "newobj",
                    "text": "expr $i1 & 127",
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
                    "id": "pack",
                    "maxclass": "newobj",
                    "text": "pack 0 0 0",
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
                    "id": "out",
                    "maxclass": "outlet",
                    "patching_rect": [
                        20,
                        254,
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
                        "in",
                        0
                    ],
                    "destination": [
                        "scale",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "scale",
                        0
                    ],
                    "destination": [
                        "clip",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "clip",
                        0
                    ],
                    "destination": [
                        "round",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "round",
                        0
                    ],
                    "destination": [
                        "order",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "order",
                        0
                    ],
                    "destination": [
                        "hi",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "hi",
                        0
                    ],
                    "destination": [
                        "pack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "order",
                        1
                    ],
                    "destination": [
                        "mid",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mid",
                        0
                    ],
                    "destination": [
                        "pack",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "order",
                        2
                    ],
                    "destination": [
                        "lo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "lo",
                        0
                    ],
                    "destination": [
                        "pack",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "pack",
                        0
                    ],
                    "destination": [
                        "out",
                        0
                    ]
                }
            }
        ]
    }
}
