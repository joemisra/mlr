{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [100.0, 100.0, 520.0, 260.0],
    "boxes": [
      { "box": { "id": "obj-bpm", "maxclass": "newobj", "text": "r [time]bpm", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [40.0, 40.0, 78.0, 22.0] } },
      { "box": { "id": "obj-tempo", "maxclass": "newobj", "text": "prepend tempo", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 40.0, 96.0, 22.0] } },
      { "box": { "id": "obj-init", "maxclass": "newobj", "text": "loadmess timesig 4 4, 0", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [40.0, 92.0, 142.0, 22.0] } },
      { "box": { "id": "obj-start", "maxclass": "newobj", "text": "r [mlr]start", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [290.0, 118.0, 82.0, 22.0] } },
      { "box": { "id": "obj-start-one", "maxclass": "message", "text": "1", "numinlets": 2, "numoutlets": 1, "outlettype": [""], "patching_rect": [382.0, 118.0, 30.0, 22.0] } },
      { "box": { "id": "obj-stop", "maxclass": "newobj", "text": "r [mlr]stop", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [290.0, 153.0, 78.0, 22.0] } },
      { "box": { "id": "obj-stop-zero", "maxclass": "message", "text": "0", "numinlets": 2, "numoutlets": 1, "outlettype": [""], "patching_rect": [382.0, 153.0, 30.0, 22.0] } },
      { "box": { "id": "obj-transport", "maxclass": "newobj", "text": "transport", "numinlets": 1, "numoutlets": 9, "outlettype": ["", "", "", "", "", "", "", "", ""], "patching_rect": [290.0, 66.0, 66.0, 22.0] } },
      { "box": { "id": "obj-sr", "maxclass": "newobj", "text": "adstatus sr", "numinlets": 1, "numoutlets": 2, "outlettype": ["float", ""], "patching_rect": [40.0, 150.0, 74.0, 22.0] } },
      { "box": { "id": "obj-sr-load", "maxclass": "button", "numinlets": 1, "numoutlets": 1, "outlettype": ["bang"], "patching_rect": [15.0, 150.0, 20.0, 20.0] } },
      { "box": { "id": "obj-loadbang", "maxclass": "newobj", "text": "loadbang", "numinlets": 1, "numoutlets": 1, "outlettype": ["bang"], "patching_rect": [15.0, 120.0, 60.0, 22.0] } },
      { "box": { "id": "obj-sr-send", "maxclass": "newobj", "text": "s mlr_plugin_sample_rate", "numinlets": 1, "numoutlets": 0, "patching_rect": [150.0, 150.0, 152.0, 22.0] } }
    ],
    "lines": [
      { "patchline": { "source": ["obj-bpm", 0], "destination": ["obj-tempo", 0] } },
      { "patchline": { "source": ["obj-tempo", 0], "destination": ["obj-transport", 0] } },
      { "patchline": { "source": ["obj-init", 0], "destination": ["obj-transport", 0] } },
      { "patchline": { "source": ["obj-start", 0], "destination": ["obj-start-one", 0] } },
      { "patchline": { "source": ["obj-start-one", 0], "destination": ["obj-transport", 0] } },
      { "patchline": { "source": ["obj-stop", 0], "destination": ["obj-stop-zero", 0] } },
      { "patchline": { "source": ["obj-stop-zero", 0], "destination": ["obj-transport", 0] } },
      { "patchline": { "source": ["obj-loadbang", 0], "destination": ["obj-sr-load", 0] } },
      { "patchline": { "source": ["obj-sr-load", 0], "destination": ["obj-sr", 0] } },
      { "patchline": { "source": ["obj-sr", 0], "destination": ["obj-sr-send", 0] } }
    ]
  }
}
