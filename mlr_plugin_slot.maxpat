{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [80.0, 80.0, 760.0, 430.0],
    "boxes": [
      { "box": { "id": "obj-in-l", "maxclass": "inlet", "index": 1, "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [40.0, 38.0, 24.0, 24.0] } },
      { "box": { "id": "obj-in-r", "maxclass": "inlet", "index": 2, "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [120.0, 38.0, 24.0, 24.0] } },
      { "box": { "id": "obj-command", "maxclass": "newobj", "text": "r mlr_rack_slot_cmd", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [360.0, 38.0, 128.0, 22.0] } },
      { "box": { "id": "obj-controller", "maxclass": "newobj", "text": "js mlr_plugin_slot.js #1 #2", "numinlets": 2, "numoutlets": 3, "outlettype": ["", "", ""], "patching_rect": [360.0, 82.0, 154.0, 22.0] } },
      { "box": { "id": "obj-vst", "maxclass": "newobj", "text": "vst~ 2 2 @autosave 0 @legacytransport 0", "numinlets": 2, "numoutlets": 8, "outlettype": ["signal", "signal", "", "list", "int", "", "", ""], "patching_rect": [190.0, 142.0, 245.0, 22.0] } },
      { "box": { "id": "obj-dry-line", "maxclass": "newobj", "text": "line~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [490.0, 142.0, 40.0, 22.0] } },
      { "box": { "id": "obj-wet-line", "maxclass": "newobj", "text": "line~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [550.0, 142.0, 40.0, 22.0] } },
      { "box": { "id": "obj-dry-l", "maxclass": "newobj", "text": "*~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [40.0, 220.0, 34.0, 22.0] } },
      { "box": { "id": "obj-dry-r", "maxclass": "newobj", "text": "*~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [120.0, 220.0, 34.0, 22.0] } },
      { "box": { "id": "obj-wet-l", "maxclass": "newobj", "text": "*~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [220.0, 220.0, 34.0, 22.0] } },
      { "box": { "id": "obj-wet-r", "maxclass": "newobj", "text": "*~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [300.0, 220.0, 34.0, 22.0] } },
      { "box": { "id": "obj-sum-l", "maxclass": "newobj", "text": "+~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [90.0, 286.0, 34.0, 22.0] } },
      { "box": { "id": "obj-sum-r", "maxclass": "newobj", "text": "+~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [220.0, 286.0, 34.0, 22.0] } },
      { "box": { "id": "obj-out-l", "maxclass": "outlet", "index": 1, "numinlets": 1, "numoutlets": 0, "patching_rect": [90.0, 352.0, 24.0, 24.0] } },
      { "box": { "id": "obj-out-r", "maxclass": "outlet", "index": 2, "numinlets": 1, "numoutlets": 0, "patching_rect": [220.0, 352.0, 24.0, 24.0] } }
    ],
    "lines": [
      { "patchline": { "source": ["obj-command", 0], "destination": ["obj-controller", 0] } },
      { "patchline": { "source": ["obj-controller", 0], "destination": ["obj-vst", 0] } },
      { "patchline": { "source": ["obj-controller", 1], "destination": ["obj-dry-line", 0] } },
      { "patchline": { "source": ["obj-controller", 2], "destination": ["obj-wet-line", 0] } },
      { "patchline": { "source": ["obj-vst", 3], "destination": ["obj-controller", 1] } },
      { "patchline": { "source": ["obj-in-l", 0], "destination": ["obj-vst", 0] } },
      { "patchline": { "source": ["obj-in-r", 0], "destination": ["obj-vst", 1] } },
      { "patchline": { "source": ["obj-in-l", 0], "destination": ["obj-dry-l", 0] } },
      { "patchline": { "source": ["obj-in-r", 0], "destination": ["obj-dry-r", 0] } },
      { "patchline": { "source": ["obj-dry-line", 0], "destination": ["obj-dry-l", 1] } },
      { "patchline": { "source": ["obj-dry-line", 0], "destination": ["obj-dry-r", 1] } },
      { "patchline": { "source": ["obj-vst", 0], "destination": ["obj-wet-l", 0] } },
      { "patchline": { "source": ["obj-vst", 1], "destination": ["obj-wet-r", 0] } },
      { "patchline": { "source": ["obj-wet-line", 0], "destination": ["obj-wet-l", 1] } },
      { "patchline": { "source": ["obj-wet-line", 0], "destination": ["obj-wet-r", 1] } },
      { "patchline": { "source": ["obj-dry-l", 0], "destination": ["obj-sum-l", 0] } },
      { "patchline": { "source": ["obj-wet-l", 0], "destination": ["obj-sum-l", 1] } },
      { "patchline": { "source": ["obj-dry-r", 0], "destination": ["obj-sum-r", 0] } },
      { "patchline": { "source": ["obj-wet-r", 0], "destination": ["obj-sum-r", 1] } },
      { "patchline": { "source": ["obj-sum-l", 0], "destination": ["obj-out-l", 0] } },
      { "patchline": { "source": ["obj-sum-r", 0], "destination": ["obj-out-r", 0] } }
    ]
  }
}
