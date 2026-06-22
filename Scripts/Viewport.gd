extends Node3D

func _ready():
	var xr = XRServer.find_interface("OpenXR")

	if xr and xr.initialize():
		get_viewport().use_xr = true
		get_viewport().transparent_bg = true

		xr.start_passthrough()

		print("OpenXR gestart")
	else:
		print("OpenXR niet gestart")
