{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 3,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 1692.0, 513.0, 920.0, 520.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 440.0, 419.0, 34.0, 22.0 ],
                    "text": "flush"
                }
            },
            {
                "box": {
                    "comment": "commands",
                    "id": "obj-3",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 551.0, 266.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "commands",
                    "id": "obj-2",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 439.0, 145.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "commands",
                    "id": "obj-1",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 58.0, 145.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-title",
                    "linecount": 6,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1.0, 0.0, 420.0, 87.0 ],
                    "text": "grid_matrix_io — varibright state in jit.matrix, bridge to /grid/led/level/map.\nMessages: edition 64|128|256, prefix /box, dual128 0|1, clear, flush, setcell x y v, fill v, fade_step.\nOut 0 = OSC to primary grid; out 1 = lower half when dual128 1 (stacked 2×128 as 256).\ngrid_anim_engine: kf x y t f …, line y x0 x1 …, tick (qmetro→flush when dirty). jit.matrix: grid_matrix_io_state."
                }
            },
            {
                "box": {
                    "comment": "commands",
                    "id": "obj-in",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 17.0, 145.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "OSC-style messages to serialosc",
                    "id": "obj-out",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 58.0, 421.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "2nd grid (dual128 1): lower 8 rows",
                    "id": "obj-out2",
                    "index": 1,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 100.0, 421.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-jm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "jit_matrix", "" ],
                    "patching_rect": [ 439.0, 84.0, 382.0, 22.0 ],
                    "text": "jit.matrix grid_matrix_io_state @planecount 1 @type char @dim 16 16"
                }
            },
            {
                "box": {
                    "filename": "grid_matrix_bridge.js",
                    "id": "obj-bridge",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 58.0, 374.0, 366.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 grid_matrix_bridge.js @args grid_matrix_io_state @autowatch 1",
                    "textfile": {
                        "filename": "grid_matrix_bridge.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-tgl",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 58.0, 188.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-metro",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 58.0, 231.0, 65.0, 22.0 ],
                    "text": "qmetro 33"
                }
            },
            {
                "box": {
                    "id": "obj-tb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patching_rect": [ 58.0, 287.0, 35.0, 22.0 ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "id": "obj-demo",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 142.0, 200.0, 33.0 ],
                    "text": "demo: toggle qmetro -> fade_step then flush"
                }
            },
            {
                "box": {
                    "id": "obj-flush",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 130.0, 321.0, 38.0, 22.0 ],
                    "text": "flush"
                }
            },
            {
                "box": {
                    "id": "obj-cm",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 605.0, 281.0, 280.0, 33.0 ],
                    "text": "grid_router is now in grid_router_io.maxpat (separate abstraction)"
                }
            },
            {
                "box": {
                    "filename": "grid_anim_engine.js",
                    "id": "obj-anim",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 438.0, 374.0, 362.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 grid_anim_engine.js @args grid_matrix_io_state @autowatch 1",
                    "textfile": {
                        "filename": "grid_anim_engine.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-tglanim",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 389.0, 212.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-metroanim",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 389.0, 255.0, 65.0, 22.0 ],
                    "text": "qmetro 16"
                }
            },
            {
                "box": {
                    "id": "obj-msgtick",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 438.0, 331.0, 32.0, 22.0 ],
                    "text": "tick"
                }
            },
            {
                "box": {
                    "id": "obj-msgkf",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 559.0, 180.0, 120.0, 22.0 ],
                    "text": "kf 3 4 15 0 0 4"
                }
            },
            {
                "box": {
                    "id": "obj-canim",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 559.0, 220.0, 303.0, 33.0 ],
                    "text": "anim: click kf, enable toggle — 4 fade steps + idle ticks = no extra flush"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-tgl", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-msgtick", 0 ],
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-anim", 0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-bridge", 0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "source": [ "obj-anim", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-out", 0 ],
                    "source": [ "obj-bridge", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-out2", 0 ],
                    "source": [ "obj-bridge", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-bridge", 0 ],
                    "source": [ "obj-flush", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-bridge", 0 ],
                    "source": [ "obj-in", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-tb", 0 ],
                    "source": [ "obj-metro", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-anim", 0 ],
                    "source": [ "obj-msgkf", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-anim", 0 ],
                    "source": [ "obj-msgtick", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-flush", 0 ],
                    "midpoints": [ 83.5, 316.65234375, 139.5, 316.65234375 ],
                    "source": [ "obj-tb", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-metro", 0 ],
                    "source": [ "obj-tgl", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-metroanim", 0 ],
                    "source": [ "obj-tglanim", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}