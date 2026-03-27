{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 9,
			"minor": 0,
			"revision": 0,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [ 80.0, 100.0, 420.0, 240.0 ],
		"boxes": [
			{
				"box": {
					"id": "obj-c",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [ 8.0, 8.0, 400.0, 47.0 ],
					"text": "Optional helper if you split keys without [grid_composite_2x128].\nPrefer [grid_composite_2x128] — one virtual device, two UDP ports, no 2nd [monome-device].\nThis patch: inlet from an OSC stream → [s box/press_b]. Adjust OSC-route if prefix differs."
				}
			},
			{
				"box": {
					"comment": "",
					"id": "obj-in",
					"index": 0,
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [ "" ],
					"patching_rect": [ 48.0, 100.0, 30.0, 30.0 ]
				}
			},
			{
				"box": {
					"id": "obj-osc",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [ "", "", "" ],
					"patching_rect": [ 48.0, 140.0, 280.0, 22.0 ],
					"text": "OSC-route /box/grid/key /monome/grid/key"
				}
			},
			{
				"box": {
					"id": "obj-s",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [ 48.0, 188.0, 95.0, 22.0 ],
					"text": "s box/press_b"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [ "obj-osc", 0 ],
					"source": [ "obj-in", 0 ]
				}
			},
			{
				"patchline": {
					"destination": [ "obj-s", 0 ],
					"source": [ "obj-osc", 0 ]
				}
			},
			{
				"patchline": {
					"destination": [ "obj-s", 0 ],
					"source": [ "obj-osc", 1 ]
				}
			}
		]
	}
}
