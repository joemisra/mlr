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
        "rect": [ 100.0, 100.0, 900.0, 600.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-title",
                    "linecount": 7,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 10.0, 10.0, 500.0, 100.0 ],
                    "text": "grid_router_io — central grid routing hub for mlr.\nInlet 0 = grid (col row state) from parent [r box/press_mlr] (see grid_dual128_hub).\nInlet 1 = optional commands. Internal: [r kmod] [r tr_pulse].\nOutlet 0 → [s grid_router_playback]. Outlet 1 setcell → [s togridmatrixio]. Outlet 2 status. See grid_router.js."
                }
            },
            {
                "box": {
                    "id": "obj-rpress",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 140.0, 30.0, 30.0 ],
                    "comment": "col row state (from r box/press_mlr)"
                }
            },
            {
                "box": {
                    "id": "obj-rkmod",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 300.0, 140.0, 48.0, 22.0 ],
                    "text": "r kmod"
                }
            },
            {
                "box": {
                    "id": "obj-rpulse",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 500.0, 140.0, 60.0, 22.0 ],
                    "text": "r tr_pulse"
                }
            },
            {
                "box": {
                    "id": "obj-in0",
                    "index": 1,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 650.0, 140.0, 30.0, 30.0 ],
                    "comment": "commands (edition, volumeUpdate, clear_automation)"
                }
            },
            {
                "box": {
                    "filename": "grid_router.js",
                    "id": "obj-router",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 30.0, 240.0, 500.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 grid_router.js @autowatch 1",
                    "textfile": {
                        "filename": "grid_router.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-sledmatrix",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 280.0, 340.0, 100.0, 22.0 ],
                    "text": "s togridmatrixio"
                }
            },
            {
                "box": {
                    "id": "obj-out0",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 340.0, 30.0, 30.0 ],
                    "comment": "sample-cutting pass-through (col row state)"
                }
            },
            {
                "box": {
                    "id": "obj-out1",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 340.0, 30.0, 30.0 ],
                    "comment": "status / automation events"
                }
            },
            {
                "box": {
                    "id": "obj-c1",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 380.0, 260.0, 33.0 ],
                    "text": "outlet 0: normal-mode presses (col row state)\nfor sample-cutting / p chnls"
                }
            },
            {
                "box": {
                    "id": "obj-c2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 280.0, 370.0, 220.0, 22.0 ],
                    "text": "LED setcell → grid_matrix_io bridge"
                }
            },
            {
                "box": {
                    "id": "obj-c3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 380.0, 200.0, 22.0 ],
                    "text": "outlet 1: automation / pattern status"
                }
            },
            {
                "box": {
                    "id": "obj-print",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 700.0, 340.0, 86.0, 22.0 ],
                    "text": "print grid_router"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-router", 0 ],
                    "source": [ "obj-rpress", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-router", 1 ],
                    "source": [ "obj-rkmod", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-router", 2 ],
                    "source": [ "obj-rpulse", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-router", 0 ],
                    "source": [ "obj-in0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-out0", 0 ],
                    "source": [ "obj-router", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-sledmatrix", 0 ],
                    "source": [ "obj-router", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-out1", 0 ],
                    "source": [ "obj-router", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-print", 0 ],
                    "source": [ "obj-router", 2 ]
                }
            }
        ],
        "autosave": 0
    }
}
