extends Node3D

@onready var title: Label3D = $Title
@onready var progress_label: Label3D = $ProgressLabel

@onready var right_controller = $"../Player/XROrigin3D/XRController3D2"

const HOLD_TIME := 1.0

func _ready():
	title.visible = true
	title.modulate.a = 0.0

	progress_label.visible = false

	await fade_in(title, 1.0)
	await wait_for_hold()

	get_tree().quit()


func wait_for_hold():
	var hold_time := 0.0

	progress_label.visible = true

	while hold_time < HOLD_TIME:
		await get_tree().process_frame

		if right_controller.is_button_pressed("trigger_click"):
			hold_time += get_process_delta_time()
		else:
			hold_time = 0.0

		var percent := int((hold_time / HOLD_TIME) * 100.0)
		progress_label.text = str(percent) + "%"

	progress_label.visible = false


func fade_in(label: Label3D, duration: float):
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, duration)
	await tween.finished
