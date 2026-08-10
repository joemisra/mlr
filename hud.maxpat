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
        "rect": [ 100.0, 100.0, 805.0, 586.0 ],
        "bglocked": 1,
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "comment": "dummy inlet for pcontrol",
                    "id": "obj-pcontrol-inlet",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 680.0, 520.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "border": 0,
                    "filename": "hud.js",
                    "id": "obj-hud-ui",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 0.0, 0.0, 720.0, 480.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 0.0, 0.0, 720.0, 480.0 ],
                    "textfile": {
                        "filename": "hud.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    },
                    "varname": "mlr_hud"
                }
            },
            {
                "box": {
                    "id": "obj-hud-state",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 520.0, 92.0, 22.0 ],
                    "text": "r mlr_hud_state"
                }
            },
            {
                "box": {
                    "filename": "hud_bridge.js",
                    "id": "obj-hud-bridge",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 190.0, 560.0, 198.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 hud_bridge.js @autowatch 1",
                    "textfile": {
                        "filename": "hud_bridge.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-bank-route",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 410.0, 560.0, 106.0, 22.0 ],
                    "text": "route bank_open bank_scan"
                }
            },
            {
                "box": {
                    "id": "obj-bank-dialog",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "patching_rect": [ 410.0, 594.0, 67.0, 22.0 ],
                    "text": "opendialog"
                }
            },
            {
                "box": {
                    "id": "obj-bank-read",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 410.0, 628.0, 113.0, 22.0 ],
                    "text": "prepend bank_read"
                }
            },
            {
                "box": {
                    "id": "obj-folder-dialog",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "patching_rect": [ 530.0, 594.0, 88.0, 22.0 ],
                    "text": "opendialog fold"
                }
            },
            {
                "box": {
                    "id": "obj-folder-read",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 530.0, 628.0, 126.0, 22.0 ],
                    "text": "prepend bank_folder"
                }
            },
            {
                "box": {
                    "id": "obj-preview-engine",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "patching_rect": [ 680.0, 520.0, 98.0, 22.0 ],
                    "text": "sample_preview"
                }
            },
            {
                "box": {
                    "id": "obj-preview-ready",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 680.0, 560.0, 166.0, 22.0 ],
                    "text": "r mlr_hud_preview_ready"
                }
            },
            {
                "box": {
                    "id": "obj-bpm",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 560.0, 72.0, 22.0 ],
                    "text": "r [time]bpm"
                }
            },
            {
                "box": {
                    "id": "obj-bpm-prepend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 594.0, 103.0, 22.0 ],
                    "text": "prepend hudBpm"
                }
            },
            {
                "box": {
                    "id": "obj-quantize",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 135.0, 520.0, 62.0, 22.0 ],
                    "text": "r [mlr]q"
                }
            },
            {
                "box": {
                    "id": "obj-quantize-prepend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 135.0, 594.0, 125.0, 22.0 ],
                    "text": "prepend hudQuantize"
                }
            },
            {
                "box": {
                    "id": "obj-mode",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 280.0, 520.0, 48.0, 22.0 ],
                    "text": "r kmod"
                }
            },
            {
                "box": {
                    "id": "obj-mode-prepend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 280.0, 594.0, 109.0, 22.0 ],
                    "text": "prepend hudMode"
                }
            },
            {
                "box": {
                    "id": "obj-press",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 350.0, 520.0, 91.0, 22.0 ],
                    "text": "r box/press_mlr"
                }
            },
            {
                "box": {
                    "id": "obj-press-prepend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 280.0, 628.0, 111.0, 22.0 ],
                    "text": "prepend hudPress"
                }
            },
            {
                "box": {
                    "id": "obj-bank-reset",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 535.0, 520.0, 129.0, 22.0 ],
                    "text": "r [samplebank]reset"
                }
            },
            {
                "box": {
                    "id": "obj-wave-cache-clear",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 535.0, 560.0, 136.0, 22.0 ],
                    "text": "clearWaveformCache"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-plugin-service",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "patching_rect": [ 680.0, 594.0, 115.0, 22.0 ],
                    "text": "mlr_plugin_service"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-plugin-transport",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "patching_rect": [ 680.0, 628.0, 126.0, 22.0 ],
                    "text": "mlr_plugin_transport"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-session-service",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "patching_rect": [ 680.0, 662.0, 126.0, 22.0 ],
                    "text": "mlr_session_service"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-bank-read", 0 ],
                    "source": [ "obj-bank-dialog", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-bank-read", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-wave-cache-clear", 0 ],
                    "source": [ "obj-bank-reset", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-bank-dialog", 0 ],
                    "source": [ "obj-bank-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-folder-dialog", 0 ],
                    "source": [ "obj-bank-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-folder-read", 0 ],
                    "source": [ "obj-folder-dialog", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-folder-read", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-preview-ready", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-bpm-prepend", 0 ],
                    "source": [ "obj-bpm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-bpm-prepend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-bank-route", 0 ],
                    "source": [ "obj-hud-bridge", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-ui", 0 ],
                    "source": [ "obj-hud-state", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-hud-ui", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-mode-prepend", 0 ],
                    "source": [ "obj-mode", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-mode-prepend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-press-prepend", 0 ],
                    "source": [ "obj-press", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-press-prepend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-quantize-prepend", 0 ],
                    "source": [ "obj-quantize", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-quantize-prepend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-hud-bridge", 0 ],
                    "source": [ "obj-wave-cache-clear", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}
