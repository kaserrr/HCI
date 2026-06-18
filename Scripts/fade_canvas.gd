extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	color_rect.visible = true

	var c = color_rect.color
	c.a = 0
	color_rect.color = c

	visible = false

	print("FadeCanvas ready")

func fade_out():
	print("fade_out")

	visible = true

	var tween = create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, 1.0)

	await tween.finished

func fade_in():
	print("fade_in")

	var tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, 1.0)

	await tween.finished

	visible = false

	print("fade_in finished")
	
func change_scene(scene_path: String):
	await fade_out()

	get_tree().change_scene_to_file(scene_path)

	await get_tree().process_frame

	await fade_in()
