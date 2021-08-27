{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 49.0, 44.0, 494.0, 750.0 ],
		"bglocked" : 0,
		"defrect" : [ 49.0, 44.0, 494.0, 750.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "number",
					"outlettype" : [ "int", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"fontsize" : 9.0,
					"triangle" : 0,
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"patching_rect" : [ 104.0, 296.0, 35.0, 17.0 ],
					"bordercolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"id" : "obj-1",
					"numinlets" : 1,
					"fontname" : "Arial",
					"triscale" : 0.9,
					"numoutlets" : 2,
					"hbgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"cantchange" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r [file]number",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 176.0, 205.0, 72.0, 17.0 ],
					"id" : "obj-2",
					"numinlets" : 0,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "loaded:",
					"fontsize" : 9.0,
					"patching_rect" : [ 68.0, 298.0, 42.0, 17.0 ],
					"id" : "obj-3",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "gate",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 199.0, 490.0, 29.0, 17.0 ],
					"id" : "obj-4",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "> 8",
					"outlettype" : [ "int" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 257.0, 470.0, 27.0, 17.0 ],
					"id" : "obj-5",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b b 8",
					"outlettype" : [ "bang", "bang", "int" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 286.0, 464.0, 40.0, 17.0 ],
					"id" : "obj-6",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 3
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"outlettype" : [ "bang" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 212.0, 34.0, 48.0, 17.0 ],
					"id" : "obj-7",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "uzi 8",
					"outlettype" : [ "bang", "bang", "int" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 212.0, 58.0, 40.0, 17.0 ],
					"id" : "obj-8",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 3
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sprintf %s rec 1000. %s_rec",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 212.0, 88.0, 143.0, 17.0 ],
					"id" : "obj-9",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "clear, append input_1, append input_2, append input_3, append input_4, append input_5, append input_6, append input_7, append input_8",
					"linecount" : 2,
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 18.0, 602.0, 334.0, 25.0 ],
					"id" : "obj-10",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r file_list_write",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 330.0, 317.0, 85.0, 17.0 ],
					"id" : "obj-11",
					"numinlets" : 0,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 1.0, 0.890196, 0.090196, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r file_list_read",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 212.0, 316.0, 80.0, 17.0 ],
					"id" : "obj-12",
					"numinlets" : 0,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 1.0, 0.890196, 0.090196, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend write",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 308.0, 367.0, 73.0, 17.0 ],
					"id" : "obj-13",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 1.0, 0.890196, 0.090196, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend read",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 221.0, 360.0, 68.0, 17.0 ],
					"id" : "obj-14",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 1.0, 0.890196, 0.090196, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"outlettype" : [ "bang" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 41.0, 536.0, 48.0, 17.0 ],
					"id" : "obj-15",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadmess 8",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 370.0, 462.0, 60.0, 17.0 ],
					"id" : "obj-16",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s [file]number",
					"fontsize" : 9.0,
					"patching_rect" : [ 371.0, 493.0, 74.0, 17.0 ],
					"id" : "obj-17",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s [file]list",
					"fontsize" : 9.0,
					"patching_rect" : [ 49.0, 662.0, 56.0, 17.0 ],
					"id" : "obj-18",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s [file]list",
					"fontsize" : 9.0,
					"patching_rect" : [ 356.0, 602.0, 56.0, 17.0 ],
					"id" : "obj-19",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend append",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 354.0, 577.0, 78.0, 17.0 ],
					"id" : "obj-20",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "unpack path 1. file",
					"outlettype" : [ "", "float", "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 271.0, 552.0, 92.0, 17.0 ],
					"id" : "obj-21",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 3
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r [file]update",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 272.0, 526.0, 70.0, 17.0 ],
					"id" : "obj-22",
					"numinlets" : 0,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "path length name",
					"fontsize" : 9.0,
					"patching_rect" : [ 323.0, 270.0, 101.0, 17.0 ],
					"id" : "obj-23",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "dump",
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 219.0, 418.0, 31.0, 15.0 ],
					"id" : "obj-24",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "coll [file]info 1",
					"outlettype" : [ "", "", "", "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 271.0, 418.0, 78.0, 17.0 ],
					"id" : "obj-25",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 4,
					"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
					"saved_object_attributes" : 					{
						"embed" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p filelist",
					"fontsize" : 9.0,
					"patching_rect" : [ 275.0, 267.0, 45.0, 17.0 ],
					"id" : "obj-26",
					"numinlets" : 0,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"color" : [ 0.611765, 0.701961, 1.0, 1.0 ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 40.0, 55.0, 344.0, 746.0 ],
						"bglocked" : 0,
						"defrect" : [ 40.0, 55.0, 344.0, 746.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 200",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 365.0, 64.0, 17.0 ],
									"id" : "obj-1",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 243",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1553.0, 64.0, 17.0 ],
									"id" : "obj-2",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 244",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1535.0, 64.0, 17.0 ],
									"id" : "obj-3",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 245",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1517.0, 64.0, 17.0 ],
									"id" : "obj-4",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 246",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1499.0, 64.0, 17.0 ],
									"id" : "obj-5",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 247",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1481.0, 64.0, 17.0 ],
									"id" : "obj-6",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 248",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1463.0, 64.0, 17.0 ],
									"id" : "obj-7",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 249",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1445.0, 64.0, 17.0 ],
									"id" : "obj-8",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 250",
									"fontsize" : 9.0,
									"patching_rect" : [ 162.0, 1427.0, 64.0, 17.0 ],
									"id" : "obj-9",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 201",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2308.0, 64.0, 17.0 ],
									"id" : "obj-10",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 202",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2290.0, 64.0, 17.0 ],
									"id" : "obj-11",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 203",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2272.0, 64.0, 17.0 ],
									"id" : "obj-12",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 204",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2254.0, 64.0, 17.0 ],
									"id" : "obj-13",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 205",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2236.0, 64.0, 17.0 ],
									"id" : "obj-14",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 206",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2218.0, 64.0, 17.0 ],
									"id" : "obj-15",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 207",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2200.0, 64.0, 17.0 ],
									"id" : "obj-16",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 208",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2182.0, 64.0, 17.0 ],
									"id" : "obj-17",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 209",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2164.0, 64.0, 17.0 ],
									"id" : "obj-18",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 210",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2146.0, 64.0, 17.0 ],
									"id" : "obj-19",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 211",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2128.0, 64.0, 17.0 ],
									"id" : "obj-20",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 212",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2110.0, 64.0, 17.0 ],
									"id" : "obj-21",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 213",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2092.0, 64.0, 17.0 ],
									"id" : "obj-22",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 214",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2074.0, 64.0, 17.0 ],
									"id" : "obj-23",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 215",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2056.0, 64.0, 17.0 ],
									"id" : "obj-24",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 216",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2038.0, 64.0, 17.0 ],
									"id" : "obj-25",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 217",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2020.0, 64.0, 17.0 ],
									"id" : "obj-26",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 218",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 2002.0, 64.0, 17.0 ],
									"id" : "obj-27",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 219",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1984.0, 64.0, 17.0 ],
									"id" : "obj-28",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 220",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1966.0, 64.0, 17.0 ],
									"id" : "obj-29",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 221",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1948.0, 64.0, 17.0 ],
									"id" : "obj-30",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 222",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1930.0, 64.0, 17.0 ],
									"id" : "obj-31",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 223",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1912.0, 64.0, 17.0 ],
									"id" : "obj-32",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 224",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1894.0, 64.0, 17.0 ],
									"id" : "obj-33",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 225",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1876.0, 64.0, 17.0 ],
									"id" : "obj-34",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 226",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1858.0, 64.0, 17.0 ],
									"id" : "obj-35",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 227",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1840.0, 64.0, 17.0 ],
									"id" : "obj-36",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 228",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1822.0, 64.0, 17.0 ],
									"id" : "obj-37",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 229",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1804.0, 64.0, 17.0 ],
									"id" : "obj-38",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 230",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1786.0, 64.0, 17.0 ],
									"id" : "obj-39",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 231",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1768.0, 64.0, 17.0 ],
									"id" : "obj-40",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 232",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1750.0, 64.0, 17.0 ],
									"id" : "obj-41",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 233",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1732.0, 64.0, 17.0 ],
									"id" : "obj-42",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 234",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1714.0, 64.0, 17.0 ],
									"id" : "obj-43",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 235",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1696.0, 64.0, 17.0 ],
									"id" : "obj-44",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 236",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1678.0, 64.0, 17.0 ],
									"id" : "obj-45",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 237",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1660.0, 64.0, 17.0 ],
									"id" : "obj-46",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 238",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1642.0, 64.0, 17.0 ],
									"id" : "obj-47",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 239",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1624.0, 64.0, 17.0 ],
									"id" : "obj-48",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 240",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1606.0, 64.0, 17.0 ],
									"id" : "obj-49",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 241",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1588.0, 64.0, 17.0 ],
									"id" : "obj-50",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 242",
									"fontsize" : 9.0,
									"patching_rect" : [ 161.0, 1570.0, 64.0, 17.0 ],
									"id" : "obj-51",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 129",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1648.0, 62.0, 17.0 ],
									"id" : "obj-52",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 130",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1630.0, 62.0, 17.0 ],
									"id" : "obj-53",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 131",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1612.0, 62.0, 17.0 ],
									"id" : "obj-54",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 132",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1594.0, 62.0, 17.0 ],
									"id" : "obj-55",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 133",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1576.0, 62.0, 17.0 ],
									"id" : "obj-56",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 134",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1558.0, 62.0, 17.0 ],
									"id" : "obj-57",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 135",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1540.0, 62.0, 17.0 ],
									"id" : "obj-58",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 136",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1522.0, 62.0, 17.0 ],
									"id" : "obj-59",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 137",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1504.0, 62.0, 17.0 ],
									"id" : "obj-60",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 138",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1486.0, 62.0, 17.0 ],
									"id" : "obj-61",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 139",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1468.0, 62.0, 17.0 ],
									"id" : "obj-62",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 140",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1450.0, 62.0, 17.0 ],
									"id" : "obj-63",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 141",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1432.0, 62.0, 17.0 ],
									"id" : "obj-64",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 142",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1414.0, 62.0, 17.0 ],
									"id" : "obj-65",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 143",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1396.0, 62.0, 17.0 ],
									"id" : "obj-66",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 144",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1378.0, 62.0, 17.0 ],
									"id" : "obj-67",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 145",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1360.0, 62.0, 17.0 ],
									"id" : "obj-68",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 146",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1342.0, 62.0, 17.0 ],
									"id" : "obj-69",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 147",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1324.0, 62.0, 17.0 ],
									"id" : "obj-70",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 148",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1306.0, 62.0, 17.0 ],
									"id" : "obj-71",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 149",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1288.0, 62.0, 17.0 ],
									"id" : "obj-72",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 150",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1270.0, 62.0, 17.0 ],
									"id" : "obj-73",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 151",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1252.0, 62.0, 17.0 ],
									"id" : "obj-74",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 152",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1234.0, 62.0, 17.0 ],
									"id" : "obj-75",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 153",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1216.0, 62.0, 17.0 ],
									"id" : "obj-76",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 154",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1198.0, 62.0, 17.0 ],
									"id" : "obj-77",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 155",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1180.0, 62.0, 17.0 ],
									"id" : "obj-78",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 156",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1162.0, 62.0, 17.0 ],
									"id" : "obj-79",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 157",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1144.0, 62.0, 17.0 ],
									"id" : "obj-80",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 158",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1126.0, 62.0, 17.0 ],
									"id" : "obj-81",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 159",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1108.0, 62.0, 17.0 ],
									"id" : "obj-82",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 160",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1090.0, 62.0, 17.0 ],
									"id" : "obj-83",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 161",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1072.0, 62.0, 17.0 ],
									"id" : "obj-84",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 162",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1054.0, 62.0, 17.0 ],
									"id" : "obj-85",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 163",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1036.0, 62.0, 17.0 ],
									"id" : "obj-86",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 164",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1018.0, 62.0, 17.0 ],
									"id" : "obj-87",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 165",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 1000.0, 62.0, 17.0 ],
									"id" : "obj-88",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 166",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 982.0, 62.0, 17.0 ],
									"id" : "obj-89",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 167",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 964.0, 62.0, 17.0 ],
									"id" : "obj-90",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 168",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 946.0, 62.0, 17.0 ],
									"id" : "obj-91",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 169",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 928.0, 62.0, 17.0 ],
									"id" : "obj-92",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 170",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 910.0, 62.0, 17.0 ],
									"id" : "obj-93",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 171",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 892.0, 62.0, 17.0 ],
									"id" : "obj-94",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 172",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 874.0, 62.0, 17.0 ],
									"id" : "obj-95",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 173",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 856.0, 62.0, 17.0 ],
									"id" : "obj-96",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 174",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 838.0, 62.0, 17.0 ],
									"id" : "obj-97",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 175",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 820.0, 62.0, 17.0 ],
									"id" : "obj-98",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 176",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 802.0, 62.0, 17.0 ],
									"id" : "obj-99",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 177",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 784.0, 62.0, 17.0 ],
									"id" : "obj-100",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 178",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 766.0, 62.0, 17.0 ],
									"id" : "obj-101",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 179",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 748.0, 62.0, 17.0 ],
									"id" : "obj-102",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 180",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 730.0, 62.0, 17.0 ],
									"id" : "obj-103",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 181",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 712.0, 62.0, 17.0 ],
									"id" : "obj-104",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 182",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 694.0, 62.0, 17.0 ],
									"id" : "obj-105",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 183",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 676.0, 62.0, 17.0 ],
									"id" : "obj-106",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 184",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 658.0, 62.0, 17.0 ],
									"id" : "obj-107",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 185",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 640.0, 62.0, 17.0 ],
									"id" : "obj-108",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 186",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 622.0, 62.0, 17.0 ],
									"id" : "obj-109",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 187",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 604.0, 62.0, 17.0 ],
									"id" : "obj-110",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 188",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 586.0, 62.0, 17.0 ],
									"id" : "obj-111",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 189",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 568.0, 62.0, 17.0 ],
									"id" : "obj-112",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 190",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 550.0, 62.0, 17.0 ],
									"id" : "obj-113",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 191",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 532.0, 62.0, 17.0 ],
									"id" : "obj-114",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 192",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 514.0, 62.0, 17.0 ],
									"id" : "obj-115",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 193",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 496.0, 62.0, 17.0 ],
									"id" : "obj-116",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 194",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 478.0, 62.0, 17.0 ],
									"id" : "obj-117",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 195",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 460.0, 62.0, 17.0 ],
									"id" : "obj-118",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 196",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 442.0, 62.0, 17.0 ],
									"id" : "obj-119",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 197",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 424.0, 62.0, 17.0 ],
									"id" : "obj-120",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 198",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 406.0, 62.0, 17.0 ],
									"id" : "obj-121",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 199",
									"fontsize" : 9.0,
									"patching_rect" : [ 95.0, 388.0, 62.0, 17.0 ],
									"id" : "obj-122",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r 0load",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 130.0, 75.0, 40.0, 17.0 ],
									"id" : "obj-123",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "buffer~ 0file 1000. 2",
									"outlettype" : [ "float", "bang" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 176.0, 75.0, 105.0, 17.0 ],
									"id" : "obj-124",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 1",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2308.0, 59.0, 17.0 ],
									"id" : "obj-125",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 2",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2290.0, 59.0, 17.0 ],
									"id" : "obj-126",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 3",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2272.0, 59.0, 17.0 ],
									"id" : "obj-127",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 4",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2254.0, 59.0, 17.0 ],
									"id" : "obj-128",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 5",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2236.0, 59.0, 17.0 ],
									"id" : "obj-129",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 6",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2218.0, 59.0, 17.0 ],
									"id" : "obj-130",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 7",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2200.0, 59.0, 17.0 ],
									"id" : "obj-131",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 8",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2182.0, 59.0, 17.0 ],
									"id" : "obj-132",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 9",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2164.0, 59.0, 17.0 ],
									"id" : "obj-133",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 10",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2146.0, 59.0, 17.0 ],
									"id" : "obj-134",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 11",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2128.0, 59.0, 17.0 ],
									"id" : "obj-135",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 12",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2110.0, 59.0, 17.0 ],
									"id" : "obj-136",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 13",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2092.0, 59.0, 17.0 ],
									"id" : "obj-137",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 14",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2074.0, 59.0, 17.0 ],
									"id" : "obj-138",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 15",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2056.0, 59.0, 17.0 ],
									"id" : "obj-139",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 16",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2038.0, 59.0, 17.0 ],
									"id" : "obj-140",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 17",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2020.0, 59.0, 17.0 ],
									"id" : "obj-141",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 18",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 2002.0, 59.0, 17.0 ],
									"id" : "obj-142",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 19",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1984.0, 59.0, 17.0 ],
									"id" : "obj-143",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 20",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1966.0, 59.0, 17.0 ],
									"id" : "obj-144",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 21",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1948.0, 59.0, 17.0 ],
									"id" : "obj-145",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 22",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1930.0, 59.0, 17.0 ],
									"id" : "obj-146",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 23",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1912.0, 59.0, 17.0 ],
									"id" : "obj-147",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 24",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1894.0, 59.0, 17.0 ],
									"id" : "obj-148",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 25",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1876.0, 59.0, 17.0 ],
									"id" : "obj-149",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 26",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1858.0, 59.0, 17.0 ],
									"id" : "obj-150",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 27",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1840.0, 59.0, 17.0 ],
									"id" : "obj-151",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 28",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1822.0, 59.0, 17.0 ],
									"id" : "obj-152",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 29",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1804.0, 59.0, 17.0 ],
									"id" : "obj-153",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 30",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1786.0, 59.0, 17.0 ],
									"id" : "obj-154",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 31",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1768.0, 59.0, 17.0 ],
									"id" : "obj-155",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 32",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1750.0, 59.0, 17.0 ],
									"id" : "obj-156",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 33",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1732.0, 59.0, 17.0 ],
									"id" : "obj-157",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 34",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1714.0, 59.0, 17.0 ],
									"id" : "obj-158",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 35",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1696.0, 59.0, 17.0 ],
									"id" : "obj-159",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 36",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1678.0, 59.0, 17.0 ],
									"id" : "obj-160",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 37",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1660.0, 59.0, 17.0 ],
									"id" : "obj-161",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 38",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1642.0, 59.0, 17.0 ],
									"id" : "obj-162",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 39",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1624.0, 59.0, 17.0 ],
									"id" : "obj-163",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 40",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1606.0, 59.0, 17.0 ],
									"id" : "obj-164",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 41",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1588.0, 59.0, 17.0 ],
									"id" : "obj-165",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 42",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1570.0, 59.0, 17.0 ],
									"id" : "obj-166",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 43",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1552.0, 59.0, 17.0 ],
									"id" : "obj-167",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 44",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1534.0, 59.0, 17.0 ],
									"id" : "obj-168",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 45",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1516.0, 59.0, 17.0 ],
									"id" : "obj-169",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 46",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1498.0, 59.0, 17.0 ],
									"id" : "obj-170",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 47",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1480.0, 59.0, 17.0 ],
									"id" : "obj-171",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 48",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1462.0, 59.0, 17.0 ],
									"id" : "obj-172",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 49",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1444.0, 59.0, 17.0 ],
									"id" : "obj-173",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 50",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1426.0, 59.0, 17.0 ],
									"id" : "obj-174",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 51",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1408.0, 59.0, 17.0 ],
									"id" : "obj-175",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 52",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1390.0, 59.0, 17.0 ],
									"id" : "obj-176",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 53",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1372.0, 59.0, 17.0 ],
									"id" : "obj-177",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 54",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1354.0, 59.0, 17.0 ],
									"id" : "obj-178",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 55",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1336.0, 59.0, 17.0 ],
									"id" : "obj-179",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 56",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1318.0, 59.0, 17.0 ],
									"id" : "obj-180",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 57",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1300.0, 59.0, 17.0 ],
									"id" : "obj-181",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 58",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1282.0, 59.0, 17.0 ],
									"id" : "obj-182",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 59",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1264.0, 59.0, 17.0 ],
									"id" : "obj-183",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 60",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1246.0, 59.0, 17.0 ],
									"id" : "obj-184",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 61",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1228.0, 59.0, 17.0 ],
									"id" : "obj-185",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 62",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1210.0, 59.0, 17.0 ],
									"id" : "obj-186",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 63",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1192.0, 59.0, 17.0 ],
									"id" : "obj-187",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 64",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1174.0, 59.0, 17.0 ],
									"id" : "obj-188",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 65",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1156.0, 59.0, 17.0 ],
									"id" : "obj-189",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 66",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1138.0, 59.0, 17.0 ],
									"id" : "obj-190",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 67",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1120.0, 59.0, 17.0 ],
									"id" : "obj-191",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 68",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1102.0, 59.0, 17.0 ],
									"id" : "obj-192",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 69",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1084.0, 59.0, 17.0 ],
									"id" : "obj-193",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 70",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1066.0, 59.0, 17.0 ],
									"id" : "obj-194",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 71",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1048.0, 59.0, 17.0 ],
									"id" : "obj-195",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 72",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1030.0, 59.0, 17.0 ],
									"id" : "obj-196",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 73",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 1012.0, 59.0, 17.0 ],
									"id" : "obj-197",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 74",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 994.0, 59.0, 17.0 ],
									"id" : "obj-198",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 75",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 976.0, 59.0, 17.0 ],
									"id" : "obj-199",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 76",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 958.0, 59.0, 17.0 ],
									"id" : "obj-200",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 77",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 940.0, 59.0, 17.0 ],
									"id" : "obj-201",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 78",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 922.0, 59.0, 17.0 ],
									"id" : "obj-202",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 79",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 904.0, 59.0, 17.0 ],
									"id" : "obj-203",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 80",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 886.0, 59.0, 17.0 ],
									"id" : "obj-204",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 81",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 868.0, 59.0, 17.0 ],
									"id" : "obj-205",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 82",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 850.0, 59.0, 17.0 ],
									"id" : "obj-206",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 83",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 832.0, 59.0, 17.0 ],
									"id" : "obj-207",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 84",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 814.0, 59.0, 17.0 ],
									"id" : "obj-208",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 85",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 796.0, 59.0, 17.0 ],
									"id" : "obj-209",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 86",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 778.0, 59.0, 17.0 ],
									"id" : "obj-210",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 87",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 760.0, 59.0, 17.0 ],
									"id" : "obj-211",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 88",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 742.0, 59.0, 17.0 ],
									"id" : "obj-212",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 89",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 724.0, 59.0, 17.0 ],
									"id" : "obj-213",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 90",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 706.0, 59.0, 17.0 ],
									"id" : "obj-214",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 91",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 688.0, 59.0, 17.0 ],
									"id" : "obj-215",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 92",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 670.0, 59.0, 17.0 ],
									"id" : "obj-216",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 93",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 652.0, 59.0, 17.0 ],
									"id" : "obj-217",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 94",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 634.0, 59.0, 17.0 ],
									"id" : "obj-218",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 95",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 616.0, 59.0, 17.0 ],
									"id" : "obj-219",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 96",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 598.0, 59.0, 17.0 ],
									"id" : "obj-220",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 97",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 580.0, 59.0, 17.0 ],
									"id" : "obj-221",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 98",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 562.0, 59.0, 17.0 ],
									"id" : "obj-222",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 99",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 544.0, 59.0, 17.0 ],
									"id" : "obj-223",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 100",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 526.0, 59.0, 17.0 ],
									"id" : "obj-224",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 101",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 508.0, 59.0, 17.0 ],
									"id" : "obj-225",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 102",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 490.0, 59.0, 17.0 ],
									"id" : "obj-226",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 103",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 472.0, 59.0, 17.0 ],
									"id" : "obj-227",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 104",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 454.0, 59.0, 17.0 ],
									"id" : "obj-228",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 105",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 436.0, 59.0, 17.0 ],
									"id" : "obj-229",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 106",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 418.0, 59.0, 17.0 ],
									"id" : "obj-230",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 107",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 400.0, 59.0, 17.0 ],
									"id" : "obj-231",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 108",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 382.0, 59.0, 17.0 ],
									"id" : "obj-232",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 109",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 364.0, 59.0, 17.0 ],
									"id" : "obj-233",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 110",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 346.0, 59.0, 17.0 ],
									"id" : "obj-234",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 111",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 328.0, 59.0, 17.0 ],
									"id" : "obj-235",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 112",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 310.0, 59.0, 17.0 ],
									"id" : "obj-236",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 113",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 292.0, 59.0, 17.0 ],
									"id" : "obj-237",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 114",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 274.0, 59.0, 17.0 ],
									"id" : "obj-238",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 115",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 256.0, 59.0, 17.0 ],
									"id" : "obj-239",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 116",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 238.0, 59.0, 17.0 ],
									"id" : "obj-240",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 117",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 220.0, 59.0, 17.0 ],
									"id" : "obj-241",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 118",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 202.0, 59.0, 17.0 ],
									"id" : "obj-242",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 119",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 184.0, 59.0, 17.0 ],
									"id" : "obj-243",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 120",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 166.0, 59.0, 17.0 ],
									"id" : "obj-244",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 121",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 148.0, 59.0, 17.0 ],
									"id" : "obj-245",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 122",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 130.0, 59.0, 17.0 ],
									"id" : "obj-246",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 123",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 112.0, 59.0, 17.0 ],
									"id" : "obj-247",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 124",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 94.0, 59.0, 17.0 ],
									"id" : "obj-248",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 125",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 76.0, 59.0, 17.0 ],
									"id" : "obj-249",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 126",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 58.0, 59.0, 17.0 ],
									"id" : "obj-250",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 127",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 40.0, 59.0, 17.0 ],
									"id" : "obj-251",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "file.abs 128",
									"fontsize" : 9.0,
									"patching_rect" : [ 23.0, 22.0, 59.0, 17.0 ],
									"id" : "obj-252",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 0
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-123", 0 ],
									"destination" : [ "obj-124", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0,
						"globalpatchername" : ""
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "dropfile",
					"outlettype" : [ "", "" ],
					"rounded" : 0.0,
					"ignoreclick" : 1,
					"border" : 0.0,
					"patching_rect" : [ 68.0, 182.0, 96.0, 129.0 ],
					"id" : "obj-27",
					"numinlets" : 1,
					"numoutlets" : 2,
					"types" : [  ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "coll [file]info 1",
					"outlettype" : [ "", "", "", "" ],
					"fontsize" : 9.0,
					"patching_rect" : [ 215.0, 121.0, 78.0, 17.0 ],
					"id" : "obj-28",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 4,
					"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
					"saved_object_attributes" : 					{
						"embed" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p file.read",
					"fontsize" : 9.0,
					"patching_rect" : [ 101.0, 510.0, 66.0, 17.0 ],
					"id" : "obj-29",
					"numinlets" : 3,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"color" : [ 0.611765, 0.701961, 1.0, 1.0 ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 171.0, 44.0, 477.0, 678.0 ],
						"bglocked" : 0,
						"defrect" : [ 171.0, 44.0, 477.0, 678.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "print read:",
									"fontsize" : 9.0,
									"patching_rect" : [ 175.0, 326.0, 59.0, 17.0 ],
									"id" : "obj-1",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 1",
									"outlettype" : [ "int" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 67.0, 255.0, 27.0, 17.0 ],
									"id" : "obj-2",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s [file]update",
									"fontsize" : 9.0,
									"patching_rect" : [ 55.0, 479.0, 70.0, 17.0 ],
									"id" : "obj-3",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "print not-enough-space",
									"fontsize" : 9.0,
									"patching_rect" : [ 15.0, 326.0, 114.0, 17.0 ],
									"id" : "obj-4",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 94.0, 87.0, 15.0, 15.0 ],
									"id" : "obj-5",
									"numinlets" : 1,
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t i i",
									"outlettype" : [ "int", "int" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 183.0, 486.0, 27.0, 17.0 ],
									"id" : "obj-6",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 1 s",
									"outlettype" : [ "int", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 109.0, 539.0, 55.0, 17.0 ],
									"id" : "obj-7",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend symbol",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 110.0, 562.0, 78.0, 17.0 ],
									"id" : "obj-8",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "tosymbol",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 207.0, 135.0, 49.0, 17.0 ],
									"id" : "obj-9",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack s 100.",
									"outlettype" : [ "", "float" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 213.0, 96.0, 70.0, 17.0 ],
									"id" : "obj-10",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"outlettype" : [ "" ],
									"patching_rect" : [ 224.0, 37.0, 15.0, 15.0 ],
									"id" : "obj-11",
									"numinlets" : 0,
									"numoutlets" : 1,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : ";\r12load replace $1",
									"linecount" : 2,
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 117.0, 590.0, 227.0, 25.0 ],
									"id" : "obj-12",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf set \\; %iload replace \\$1",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 287.0, 548.0, 159.0, 17.0 ],
									"id" : "obj-13",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "< 5000",
									"outlettype" : [ "int" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 55.0, 220.0, 38.0, 17.0 ],
									"id" : "obj-14",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r [file]number",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 24.0, 194.0, 72.0, 17.0 ],
									"id" : "obj-15",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 1,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "gate 2",
									"outlettype" : [ "", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 134.0, 288.0, 38.0, 17.0 ],
									"id" : "obj-16",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 462.0, 16.0, 15.0 ],
									"id" : "obj-17",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r [file]number",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 255.0, 429.0, 72.0, 17.0 ],
									"id" : "obj-18",
									"numinlets" : 0,
									"fontname" : "Arial",
									"numoutlets" : 1,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 1",
									"outlettype" : [ "int" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 219.0, 462.0, 27.0, 17.0 ],
									"id" : "obj-19",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s [file]number",
									"fontsize" : 9.0,
									"patching_rect" : [ 250.0, 491.0, 72.0, 17.0 ],
									"id" : "obj-20",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t l b l",
									"outlettype" : [ "", "bang", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 140.0, 438.0, 40.0, 17.0 ],
									"id" : "obj-21",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 3
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "2",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 39.0, 115.0, 16.0, 15.0 ],
									"id" : "obj-22",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 72.0, 114.0, 16.0, 15.0 ],
									"id" : "obj-23",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "gate 2",
									"outlettype" : [ "", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 118.0, 166.0, 35.0, 17.0 ],
									"id" : "obj-24",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sel fold AIFF WAVE",
									"outlettype" : [ "bang", "bang", "bang", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 63.0, 92.0, 17.0 ],
									"id" : "obj-25",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 4
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 34.0, 15.0, 15.0 ],
									"id" : "obj-26",
									"numinlets" : 0,
									"numoutlets" : 1,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "pack path 1. file",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 139.0, 414.0, 80.0, 17.0 ],
									"id" : "obj-27",
									"numinlets" : 3,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend open",
									"outlettype" : [ "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 167.0, 365.0, 65.0, 17.0 ],
									"id" : "obj-28",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sfinfo~",
									"outlettype" : [ "int", "int", "float", "float", "", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 167.0, 385.0, 79.0, 17.0 ],
									"id" : "obj-29",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 6
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t s s",
									"outlettype" : [ "", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 135.0, 328.0, 28.0, 17.0 ],
									"id" : "obj-30",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl join",
									"outlettype" : [ "", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 142.0, 516.0, 35.0, 17.0 ],
									"id" : "obj-31",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "coll [file]info 1",
									"outlettype" : [ "", "", "", "" ],
									"fontsize" : 9.0,
									"patching_rect" : [ 186.0, 539.0, 78.0, 17.0 ],
									"id" : "obj-32",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 4,
									"color" : [ 0.8, 0.611765, 0.380392, 1.0 ],
									"saved_object_attributes" : 									{
										"embed" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"outlettype" : [ "" ],
									"patching_rect" : [ 156.0, 32.0, 15.0, 15.0 ],
									"id" : "obj-33",
									"numinlets" : 0,
									"numoutlets" : 1,
									"comment" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-15", 0 ],
									"destination" : [ "obj-14", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 1 ],
									"destination" : [ "obj-13", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 0 ],
									"destination" : [ "obj-20", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-19", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-17", 0 ],
									"destination" : [ "obj-19", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-11", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-29", 5 ],
									"destination" : [ "obj-27", 2 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-21", 1 ],
									"destination" : [ "obj-17", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 0 ],
									"destination" : [ "obj-32", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 1 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-29", 3 ],
									"destination" : [ "obj-27", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-21", 2 ],
									"destination" : [ "obj-31", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-28", 0 ],
									"destination" : [ "obj-29", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 1 ],
									"destination" : [ "obj-28", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-16", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-16", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-33", 0 ],
									"destination" : [ "obj-24", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-31", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-27", 0 ],
									"destination" : [ "obj-21", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 0 ],
									"destination" : [ "obj-27", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 1 ],
									"destination" : [ "obj-30", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-22", 0 ],
									"destination" : [ "obj-24", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-23", 0 ],
									"destination" : [ "obj-24", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-13", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 1 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 3 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-23", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 2 ],
									"destination" : [ "obj-23", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 1 ],
									"destination" : [ "obj-23", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-21", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 0 ],
									"destination" : [ "obj-22", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-26", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0,
						"globalpatchername" : ""
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "panel",
					"rounded" : 0,
					"bgcolor" : [ 0.941176, 0.941176, 0.941176, 1.0 ],
					"border" : 1,
					"patching_rect" : [ 68.0, 182.0, 96.0, 129.0 ],
					"id" : "obj-30",
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-6", 2 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 2 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 2 ],
					"destination" : [ "obj-9", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 2 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 1 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-4", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 2 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-29", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-29", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 1 ],
					"destination" : [ "obj-29", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 1 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
