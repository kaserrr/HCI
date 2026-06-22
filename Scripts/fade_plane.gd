extends MeshInstance3D

func _ready():
	visible = false

func fade_out():
	visible = true

	var tween = create_tween()
	tween.tween_property(
		get_active_material(0),
		"albedo_color:a",
		1.0,
		1.0
	)

	await tween.finished

func fade_in():
	var tween = create_tween()
	tween.tween_property(
		get_active_material(0),
		"albedo_color:a",
		0.0,
		1.0
	)

	await tween.finished

	visible = false
