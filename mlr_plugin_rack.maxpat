{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [100.0, 100.0, 620.0, 360.0],
    "boxes": [
      { "box": { "id": "obj-in-l", "maxclass": "inlet", "index": 1, "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [45.0, 35.0, 24.0, 24.0] } },
      { "box": { "id": "obj-in-r", "maxclass": "inlet", "index": 2, "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [115.0, 35.0, 24.0, 24.0] } },
      { "box": { "id": "obj-slot-1", "maxclass": "newobj", "text": "mlr_plugin_slot #1 1", "numinlets": 2, "numoutlets": 2, "outlettype": ["signal", "signal"], "patching_rect": [45.0, 92.0, 128.0, 22.0] } },
      { "box": { "id": "obj-slot-2", "maxclass": "newobj", "text": "mlr_plugin_slot #1 2", "numinlets": 2, "numoutlets": 2, "outlettype": ["signal", "signal"], "patching_rect": [45.0, 142.0, 128.0, 22.0] } },
      { "box": { "id": "obj-slot-3", "maxclass": "newobj", "text": "mlr_plugin_slot #1 3", "numinlets": 2, "numoutlets": 2, "outlettype": ["signal", "signal"], "patching_rect": [45.0, 192.0, 128.0, 22.0] } },
      { "box": { "id": "obj-slot-4", "maxclass": "newobj", "text": "mlr_plugin_slot #1 4", "numinlets": 2, "numoutlets": 2, "outlettype": ["signal", "signal"], "patching_rect": [45.0, 242.0, 128.0, 22.0] } },
      { "box": { "id": "obj-out-l", "maxclass": "outlet", "index": 1, "numinlets": 1, "numoutlets": 0, "patching_rect": [45.0, 302.0, 24.0, 24.0] } },
      { "box": { "id": "obj-out-r", "maxclass": "outlet", "index": 2, "numinlets": 1, "numoutlets": 0, "patching_rect": [115.0, 302.0, 24.0, 24.0] } }
    ],
    "lines": [
      { "patchline": { "source": ["obj-in-l", 0], "destination": ["obj-slot-1", 0] } },
      { "patchline": { "source": ["obj-in-r", 0], "destination": ["obj-slot-1", 1] } },
      { "patchline": { "source": ["obj-slot-1", 0], "destination": ["obj-slot-2", 0] } },
      { "patchline": { "source": ["obj-slot-1", 1], "destination": ["obj-slot-2", 1] } },
      { "patchline": { "source": ["obj-slot-2", 0], "destination": ["obj-slot-3", 0] } },
      { "patchline": { "source": ["obj-slot-2", 1], "destination": ["obj-slot-3", 1] } },
      { "patchline": { "source": ["obj-slot-3", 0], "destination": ["obj-slot-4", 0] } },
      { "patchline": { "source": ["obj-slot-3", 1], "destination": ["obj-slot-4", 1] } },
      { "patchline": { "source": ["obj-slot-4", 0], "destination": ["obj-out-l", 0] } },
      { "patchline": { "source": ["obj-slot-4", 1], "destination": ["obj-out-r", 0] } }
    ]
  }
}
