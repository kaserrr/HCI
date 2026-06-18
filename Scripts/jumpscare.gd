extends Node3D

func _ready():
	$AudioStreamPlayer3D.play()
	$AnimationPlayer.play("JumpscareAnimation")

	await get_tree().create_timer(2.0).timeout

	queue_free()
