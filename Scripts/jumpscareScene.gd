extends Node

@onready var timer = $Timer

func start_horror_event():
	print("scare")
	var scare = preload("res://Scenes/JumpScare.tscn").instantiate()
	$Player/XROrigin3D/XRCamera3D.add_child(scare)


func _on_timer_timeout() -> void:
	start_horror_event()
