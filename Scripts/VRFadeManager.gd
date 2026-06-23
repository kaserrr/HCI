extends Node

var fade_sphere_scene = preload("res://Scenes/FadeSphere.tscn")
var current_fade_sphere = null

func fade_and_change_scene(camera, scene_path):

	current_fade_sphere = fade_sphere_scene.instantiate()

	camera.add_child(current_fade_sphere)

	current_fade_sphere.position = Vector3.ZERO

	var mesh = current_fade_sphere

	mesh.transparency = 1.0

	var tween = create_tween()

	tween.tween_property(
		mesh,
		"transparency",
		0.0,
		1.0
	)

	await tween.finished

	get_tree().change_scene_to_file(scene_path)
