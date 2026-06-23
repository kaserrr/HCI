extends Node3D

var scene_changing = false

func _ready() -> void:
	await FadeCanvas.fade_in()

	UDPManager.message_received.connect(_on_message_received)


func _on_message_received(message):

	print("MESSAGE RECEIVED:", message)

	if scene_changing:
		return

	if message == "OPEN":

		scene_changing = true

		SceneManager.between_text = """
The previous environment was designed to create a sense of calm.

Take a moment to reflect on how this environment made you feel before con0tinuing.
"""

		SceneManager.next_scene = "res://Scenes/PartyScene.tscn"

		print("SET TEXT:", SceneManager.between_text)
		print("SET NEXT:", SceneManager.next_scene)

		await FadeCanvas.change_scene(
			"res://Scenes/BetweenScene.tscn"
		)
