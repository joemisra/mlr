{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 1, "revision": 5, "architecture": "arm64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [ 70.0, 100.0, 510.0, 235.0 ],
    "openinpresentation": 0,
    "boxes": [
      { "box": { "id": "obj-in", "maxclass": "newobj", "text": "r mlr_session_recording_export", "patching_rect": [ 24.0, 25.0, 185.0, 22.0 ], "numinlets": 0, "numoutlets": 1, "outlettype": [ "" ] } },
      { "box": { "id": "obj-js", "maxclass": "newobj", "text": "js mlr_recording_export.js", "patching_rect": [ 24.0, 72.0, 175.0, 22.0 ], "numinlets": 2, "numoutlets": 2, "outlettype": [ "", "" ] } },
      { "box": { "id": "obj-buffer", "maxclass": "newobj", "text": "buffer~ mlr_session_export 1 2", "patching_rect": [ 24.0, 121.0, 190.0, 22.0 ], "numinlets": 1, "numoutlets": 2, "outlettype": [ "bang", "int" ] } },
      { "box": { "id": "obj-status", "maxclass": "newobj", "text": "s mlr_session_recording_status", "patching_rect": [ 245.0, 121.0, 190.0, 22.0 ], "numinlets": 1, "numoutlets": 0 } },
      { "box": { "id": "obj-note", "maxclass": "comment", "text": "Exports referenced 1file–7file recording buffers one at a time as float32 WAV.", "patching_rect": [ 24.0, 174.0, 430.0, 20.0 ] } }
    ],
    "lines": [
      { "patchline": { "source": [ "obj-in", 0 ], "destination": [ "obj-js", 0 ] } },
      { "patchline": { "source": [ "obj-js", 0 ], "destination": [ "obj-buffer", 0 ] } },
      { "patchline": { "source": [ "obj-buffer", 0 ], "destination": [ "obj-js", 1 ] } },
      { "patchline": { "source": [ "obj-js", 1 ], "destination": [ "obj-status", 0 ] } }
    ]
  }
}
