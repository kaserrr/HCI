extends Node3D
@onready var timer = $Timer


func _ready():
	var xr = XRServer.find_interface("OpenXR")

	if xr and xr.initialize():
		get_viewport().use_xr = true
		print("OpenXR gestart")
	else:
		print("OpenXR niet gestart")


func start_horror_event():
	print("scare")
	var scare = preload("res://Scenes/JumpScare.tscn").instantiate()
	$XROrigin3D/XRCamera3D.add_child(scare)


func _on_timer_timeout() -> void:
	start_horror_event()
