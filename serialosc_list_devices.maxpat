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
        "rect": [ 40.0, 100.0, 720.0, 520.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "comment": "",
                    "id": "obj-3",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 277.0, 147.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "",
                    "id": "obj-2",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 265.0, 471.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "comment": "",
                    "id": "obj-1",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 182.0, 471.0, 30.0, 30.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-title",
                    "linecount": 8,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 12.0, 12.0, 656.0, 114.0 ],
                    "text": "serialosc_list_devices — query serialosc for connected grids (monome.org/docs/serialosc/osc/).\n\n1) Set “reply UDP port” (must match what you send in /serialosc/list). Change it if 57888 is busy.\n2) Click “Query”. Max window lists each device; int boxes show UDP ports for [grid_composite_2x128 portTop portBottom].\n3) serialosc listens on port 12002 by default — edit [udpsend] below if your install differs.\n\nOrder: first device → outlet 1 (top 128), second → outlet 2 (bottom). Swap args if stacked wrong."
                }
            },
            {
                "box": {
                    "id": "obj-nb-reply",
                    "maxclass": "number",
                    "maximum": 65535,
                    "minimum": 1024,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 48.0, 152.0, 72.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-lb-reply",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 48.0, 120.0, 60.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-lm-reply",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 130.0, 120.0, 50.0, 22.0 ],
                    "text": "57888"
                }
            },
            {
                "box": {
                    "id": "obj-c-reply",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 130.0, 152.0, 120.0, 20.0 ],
                    "text": "reply UDP port"
                }
            },
            {
                "box": {
                    "id": "obj-t-split",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 48.0, 188.0, 40.0, 22.0 ],
                    "text": "t i i"
                }
            },
            {
                "box": {
                    "id": "obj-msg-port",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 12.0, 218.0, 50.0, 22.0 ],
                    "text": "port $1"
                }
            },
            {
                "box": {
                    "id": "obj-udprecv",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 12.0, 258.0, 93.0, 22.0 ],
                    "text": "udpreceive"
                }
            },
            {
                "box": {
                    "filename": "serialosc_list_devices.js",
                    "id": "obj-js",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 200.0, 258.0, 233.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 serialosc_list_devices.js @autowatch 1",
                    "textfile": {
                        "filename": "serialosc_list_devices.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-bang-q",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 280.0, 228.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 2.0, 1.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-c-q",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 308.0, 200.0, 88.0, 20.0 ],
                    "text": "Query devices"
                }
            },
            {
                "box": {
                    "id": "obj-udpsend",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 200.0, 308.0, 145.0, 22.0 ],
                    "text": "udpsend 127.0.0.1 12002"
                }
            },
            {
                "box": {
                    "id": "obj-nb-p1",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 200.0, 340.0, 72.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 34.0, 2.0, 72.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-nb-p2",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 288.0, 340.0, 72.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 122.0, 2.0, 72.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-c-p1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 200.0, 364.0, 72.0, 20.0 ],
                    "text": "port top"
                }
            },
            {
                "box": {
                    "id": "obj-c-p2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 288.0, 364.0, 96.0, 20.0 ],
                    "text": "port bottom"
                }
            },
            {
                "box": {
                    "id": "obj-c-doc",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 12.0, 400.0, 680.0, 33.0 ],
                    "text": "Docs: https://monome.org/docs/serialosc/osc/ — /serialosc/list <host> <replyPort> asks serialosc to send /serialosc/device <id> <type> <devicePort> to your reply port."
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-bang-q", 0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-js", 1 ],
                    "source": [ "obj-bang-q", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-nb-p1", 0 ],
                    "source": [ "obj-js", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-nb-p2", 0 ],
                    "source": [ "obj-js", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-udpsend", 0 ],
                    "source": [ "obj-js", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-lm-reply", 0 ],
                    "source": [ "obj-lb-reply", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-nb-reply", 0 ],
                    "source": [ "obj-lm-reply", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-udprecv", 0 ],
                    "source": [ "obj-msg-port", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-nb-p1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "obj-nb-p2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-t-split", 0 ],
                    "source": [ "obj-nb-reply", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-js", 1 ],
                    "source": [ "obj-t-split", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-msg-port", 0 ],
                    "source": [ "obj-t-split", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-js", 0 ],
                    "source": [ "obj-udprecv", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}