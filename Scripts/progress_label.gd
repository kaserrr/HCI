@onready var progress_label = $ProgressLabel

func wait_for_hold():
	var hold_time := 0.0
	var required_time := 1.0

	progress_label.visible = true

	while hold_time < required_time:
		await get_tree().process_frame

		if right_controller.is_button_pressed("trigger_click"):
			hold_time += get_process_delta_time()
		else:
			hold_time = 0.0

		var percent = round((hold_time / required_time) * 100)
		progress_label.text = str(percent) + "%"

	progress_label.visible = false
