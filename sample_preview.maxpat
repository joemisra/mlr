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
        "rect": [ 80.0, 100.0, 720.0, 380.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 16.0, 590.0, 20.0 ],
                    "text": "HUD sample audition: replace a private buffer, preview at safe gain, then expose its waveform."
                }
            },
            {
                "box": {
                    "id": "obj-receive",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 58.0, 129.0, 22.0 ],
                    "text": "r mlr_sample_preview"
                }
            },
            {
                "box": {
                    "id": "obj-route",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 20.0, 94.0, 112.0, 22.0 ],
                    "text": "route preview stop"
                }
            },
            {
                "box": {
                    "id": "obj-unpack",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "int" ],
                    "patching_rect": [ 20.0, 130.0, 71.0, 22.0 ],
                    "text": "unpack s i"
                }
            },
            {
                "box": {
                    "id": "obj-trigger-path",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "patching_rect": [ 20.0, 166.0, 41.0, 22.0 ],
                    "text": "t s b"
                }
            },
            {
                "box": {
                    "id": "obj-replace",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 82.0, 202.0, 96.0, 22.0 ],
                    "text": "prepend replace"
                }
            },
            {
                "box": {
                    "id": "obj-buffer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 82.0, 238.0, 205.0, 22.0 ],
                    "text": "buffer~ mlr_sample_preview 1000 2"
                }
            },
            {
                "box": {
                    "id": "obj-stop",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 202.0, 34.0, 22.0 ],
                    "text": "stop"
                }
            },
            {
                "box": {
                    "id": "obj-loaded",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patching_rect": [ 302.0, 238.0, 41.0, 22.0 ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "id": "obj-start",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 350.0, 274.0, 36.0, 22.0 ],
                    "text": "start"
                }
            },
            {
                "box": {
                    "id": "obj-id",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 244.0, 130.0, 29.0, 22.0 ],
                    "text": "i"
                }
            },
            {
                "box": {
                    "id": "obj-waveform-prepend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 244.0, 310.0, 150.0, 22.0 ],
                    "text": "prepend previewWaveform"
                }
            },
            {
                "box": {
                    "id": "obj-waveform-send",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 244.0, 344.0, 169.0, 22.0 ],
                    "text": "s mlr_hud_preview_ready"
                }
            },
            {
                "box": {
                    "id": "obj-play",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "signal", "signal", "bang" ],
                    "patching_rect": [ 430.0, 238.0, 157.0, 22.0 ],
                    "text": "play~ mlr_sample_preview 2"
                }
            },
            {
                "box": {
                    "id": "obj-gain-left",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 430.0, 274.0, 49.0, 22.0 ],
                    "text": "*~ 0.2"
                }
            },
            {
                "box": {
                    "id": "obj-gain-right",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 502.0, 274.0, 49.0, 22.0 ],
                    "text": "*~ 0.2"
                }
            },
            {
                "box": {
                    "id": "obj-send-left",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 310.0, 69.0, 22.0 ],
                    "text": "send~ dac1"
                }
            },
            {
                "box": {
                    "id": "obj-send-right",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 502.0, 310.0, 69.0, 22.0 ],
                    "text": "send~ dac2"
                }
            }
        ],
        "lines": [
            { "patchline": { "source": [ "obj-receive", 0 ], "destination": [ "obj-route", 0 ] } },
            { "patchline": { "source": [ "obj-route", 0 ], "destination": [ "obj-unpack", 0 ] } },
            { "patchline": { "source": [ "obj-route", 1 ], "destination": [ "obj-stop", 0 ] } },
            { "patchline": { "source": [ "obj-unpack", 0 ], "destination": [ "obj-trigger-path", 0 ] } },
            { "patchline": { "source": [ "obj-unpack", 1 ], "destination": [ "obj-id", 1 ] } },
            { "patchline": { "source": [ "obj-trigger-path", 1 ], "destination": [ "obj-stop", 0 ] } },
            { "patchline": { "source": [ "obj-trigger-path", 0 ], "destination": [ "obj-replace", 0 ] } },
            { "patchline": { "source": [ "obj-replace", 0 ], "destination": [ "obj-buffer", 0 ] } },
            { "patchline": { "source": [ "obj-buffer", 1 ], "destination": [ "obj-loaded", 0 ] } },
            { "patchline": { "source": [ "obj-loaded", 1 ], "destination": [ "obj-start", 0 ] } },
            { "patchline": { "source": [ "obj-loaded", 0 ], "destination": [ "obj-id", 0 ] } },
            { "patchline": { "source": [ "obj-start", 0 ], "destination": [ "obj-play", 0 ] } },
            { "patchline": { "source": [ "obj-stop", 0 ], "destination": [ "obj-play", 0 ] } },
            { "patchline": { "source": [ "obj-id", 0 ], "destination": [ "obj-waveform-prepend", 0 ] } },
            { "patchline": { "source": [ "obj-waveform-prepend", 0 ], "destination": [ "obj-waveform-send", 0 ] } },
            { "patchline": { "source": [ "obj-play", 0 ], "destination": [ "obj-gain-left", 0 ] } },
            { "patchline": { "source": [ "obj-play", 1 ], "destination": [ "obj-gain-right", 0 ] } },
            { "patchline": { "source": [ "obj-gain-left", 0 ], "destination": [ "obj-send-left", 0 ] } },
            { "patchline": { "source": [ "obj-gain-right", 0 ], "destination": [ "obj-send-right", 0 ] } }
        ],
        "autosave": 0
    }
}
