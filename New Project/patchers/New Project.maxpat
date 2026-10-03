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
        "rect": [ 268.0, 164.0, 930.0, 800.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontsize": 24.0,
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 12.0, 880.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 12.0, 880.0, 33.0 ],
                    "text": "RNBO drum lab"
                }
            },
            {
                "box": {
                    "id": "help",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 48.0, 880.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 48.0, 880.0, 20.0 ],
                    "text": "All eight voices stay loaded. Tabs change the view; scroll each page for its ranges."
                }
            },
            {
                "box": {
                    "id": "tabs",
                    "maxclass": "tab",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 20.0, 80.0, 880.0, 34.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 80.0, 880.0, 34.0 ],
                    "tabs": [ "Kick · 15", "Snare · 14", "Hat · 13", "Clap · 12", "Tom · 11", "Rim · 10", "Bell · 9", "FM · 8" ],
                    "varname": "drum_lab_tabs"
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "id": "lab-kick",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_kick.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_kick",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-snare",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_snare.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_snare",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-hat",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_hat.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_hat",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-clap",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_clap.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_clap",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "footer",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 756.0, 880.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 756.0, 880.0, 20.0 ],
                    "text": "Use this window instead of separate lab instances. Save range-preset edits in the individual lab patch."
                }
            },
            {
                "box": {
                    "id": "select",
                    "maxclass": "newobj",
                    "numinlets": 9,
                    "numoutlets": 9,
                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "" ],
                    "patching_rect": [ 950.0, 80.0, 120.0, 22.0 ],
                    "text": "sel 0 1 2 3 4 5 6 7"
                }
            },
            {
                "box": {
                    "id": "window",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 950.0, 340.0, 85.0, 22.0 ],
                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                    "text": "thispatcher"
                }
            },
            {
                "box": {
                    "id": "show-kick",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 130.0, 876.0, 22.0 ],
                    "text": "script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_kick"
                }
            },
            {
                "box": {
                    "id": "show-snare",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 175.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_snare"
                }
            },
            {
                "box": {
                    "id": "show-hat",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 220.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_hat"
                }
            },
            {
                "box": {
                    "id": "show-clap",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 265.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_tom, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_clap"
                }
            },
            {
                "box": {
                    "id": "initial",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 390.0, 80.0, 22.0 ],
                    "text": "loadmess 0"
                }
            },
            {
                "box": {
                    "id": "defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 425.0, 70.0, 22.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "output-mode",
                    "maxclass": "tab",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 20.0, 125.0, 300.0, 28.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 125.0, 300.0, 28.0 ],
                    "tabs": [ "Stereo", "6mix · 4", "ES-9 · 8" ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "output-level",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 460.0, 125.0, 75.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 460.0, 125.0, 75.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "output-level-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 335.0, 128.0, 125.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 335.0, 128.0, 125.0, 20.0 ],
                    "text": "External send (0–1)"
                }
            },
            {
                "box": {
                    "id": "output-map",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 20.0, 162.0, 880.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 162.0, 880.0, 20.0 ],
                    "text": "ES-9 1–4: Kick / Snare / Hat / Clap. All-eight mode adds 5–8: Tom / Rim / Bell / FM Bass."
                }
            },
            {
                "box": {
                    "id": "outputs",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 950.0, 470.0, 190.0, 22.0 ],
                    "text": "rnbo_drum_outputs"
                }
            },
            {
                "box": {
                    "id": "output-default",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 510.0, 190.0, 22.0 ],
                    "text": "loadmess 0"
                }
            },
            {
                "box": {
                    "id": "level-default",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1150.0, 510.0, 190.0, 22.0 ],
                    "text": "loadmess 0.5"
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-tom",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_tom.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_tom",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "show-tom",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 265.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_rim, script hide lab_bell, script hide lab_bass, script show lab_tom"
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-rim",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_rim.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_rim",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "show-rim",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 265.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_bell, script hide lab_bass, script show lab_rim"
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-bell",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_bell.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_bell",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "show-bell",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 265.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bass, script show lab_bell"
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 1,
                    "hidden": 1,
                    "id": "lab-bass",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "rnbo_bass.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 195.0, 880.0, 550.0 ],
                    "varname": "lab_bass",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "show-bass",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 950.0, 265.0, 876.0, 22.0 ],
                    "text": "script hide lab_kick, script hide lab_snare, script hide lab_hat, script hide lab_clap, script hide lab_tom, script hide lab_rim, script hide lab_bell, script show lab_bass"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "tabs", 0 ],
                    "source": [ "defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "defer", 0 ],
                    "source": [ "initial", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "output-level", 0 ],
                    "source": [ "level-default", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "output-mode", 0 ],
                    "source": [ "output-default", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "outputs", 1 ],
                    "source": [ "output-level", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "outputs", 0 ],
                    "source": [ "output-mode", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-bass", 0 ],
                    "source": [ "select", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-bell", 0 ],
                    "source": [ "select", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-clap", 0 ],
                    "source": [ "select", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-hat", 0 ],
                    "source": [ "select", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-kick", 0 ],
                    "source": [ "select", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-rim", 0 ],
                    "source": [ "select", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-snare", 0 ],
                    "source": [ "select", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "show-tom", 0 ],
                    "source": [ "select", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-bass", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-bell", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-clap", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-hat", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-kick", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-rim", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-snare", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "window", 0 ],
                    "source": [ "show-tom", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "select", 0 ],
                    "source": [ "tabs", 0 ]
                }
            }
        ],
        "parameters": {
            "lab-bass::obj-rnbo": [ "bass_rnbo", "bass_rnbo", 0 ],
            "lab-bell::obj-rnbo": [ "bell_rnbo", "bell_rnbo", 0 ],
            "lab-clap::obj-rnbo": [ "clap_rnbo", "clap_rnbo", 0 ],
            "lab-hat::obj-rnbo": [ "hat_rnbo", "hat_rnbo", 0 ],
            "lab-kick::obj-rnbo": [ "kick_rnbo", "kick_rnbo", 0 ],
            "lab-rim::obj-rnbo": [ "rim_rnbo", "rim_rnbo", 0 ],
            "lab-snare::obj-rnbo": [ "snare_rnbo", "snare_rnbo", 0 ],
            "lab-tom::obj-rnbo": [ "tom_rnbo", "tom_rnbo", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}