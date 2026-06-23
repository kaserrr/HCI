extends Node3D

var scene_changing = false

func _ready() -> void:

	await FadeCanvas.fade_in()

	UDPManager.message_received.connect(_on_message_received)

	print("SupriseScene Ready")


func _on_message_received(message):

	print("MESSAGE RECEIVED:", message)

	if scene_changing:
		return

	if message == "OPEN":

		scene_changing = true

		print("Loading EndScene")

		await FadeCanvas.change_scene(
			"res://Scenes/EndScene.tscn"
		)


# Tijdelijke testknop zolang Arduino niet werkt
func _input(event):

	if event is InputEventKey and event.pressed:

		if event.keycode == 48: # toets 0

			_on_message_received("OPEN")
