extends Label3D

func show_action(action: String):
	text = action

	await get_tree().create_timer(3.0).timeout

	if text == action:
		text = ""
