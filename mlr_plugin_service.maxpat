{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [100.0, 100.0, 720.0, 400.0],
    "boxes": [
      { "box": { "id": "obj-command", "maxclass": "newobj", "text": "r mlr_rack_cmd", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [40.0, 40.0, 102.0, 22.0] } },
      { "box": { "id": "obj-status", "maxclass": "newobj", "text": "r mlr_rack_status", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [40.0, 80.0, 110.0, 22.0] } },
      { "box": { "id": "obj-session", "maxclass": "newobj", "text": "r mlr_rack_session", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [40.0, 120.0, 118.0, 22.0] } },
      { "box": { "id": "obj-rate", "maxclass": "newobj", "text": "r mlr_plugin_sample_rate", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [40.0, 160.0, 148.0, 22.0] } },
      { "box": { "id": "obj-prepend-rate", "maxclass": "newobj", "text": "prepend sample_rate", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [210.0, 160.0, 128.0, 22.0] } },
      { "box": { "id": "obj-controller", "maxclass": "newobj", "text": "v8 mlr_plugin_rack_controller.js @autowatch 1", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [230.0, 80.0, 262.0, 22.0] } },
      { "box": { "id": "obj-scan", "maxclass": "newobj", "text": "vstscan", "numinlets": 1, "numoutlets": 2, "outlettype": ["", ""], "patching_rect": [560.0, 80.0, 52.0, 22.0] } }
    ],
    "lines": [
      { "patchline": { "source": ["obj-command", 0], "destination": ["obj-controller", 0] } },
      { "patchline": { "source": ["obj-status", 0], "destination": ["obj-controller", 0] } },
      { "patchline": { "source": ["obj-session", 0], "destination": ["obj-controller", 0] } },
      { "patchline": { "source": ["obj-rate", 0], "destination": ["obj-prepend-rate", 0] } },
      { "patchline": { "source": ["obj-prepend-rate", 0], "destination": ["obj-controller", 0] } },
      { "patchline": { "source": ["obj-controller", 0], "destination": ["obj-scan", 0] } },
      { "patchline": { "source": ["obj-scan", 0], "destination": ["obj-controller", 0] } }
    ]
  }
}
