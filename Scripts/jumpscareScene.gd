extends Node

@onready var timer = $Timer

var scene_changing = false

func _ready():
	UDPManager.message_received.connect(_on_message_received)

func start_horror_event():
	print("scare")

	var scare = preload("res://Scenes/JumpScare.tscn").instantiate()

	$Player/XROrigin3D/XRCamera3D.add_child(scare)

func _on_timer_timeout() -> void:
	start_horror_event()

func _on_message_received(message):

	print("MESSAGE RECEIVED:", message)

	if scene_changing:
		print("ALREADY CHANGING")
		return

	if message == "OPEN":

		print("OPEN DETECTED")

		scene_changing = true

		SceneManager.between_text = """
		Take a moment to reflect on how the previous environment made you feel.

		Stress and uncertainty can influence the way we perceive our surroundings.
		"""
		SceneManager.next_scene = "res://Scenes/NatureScene.tscn"

		print("TEXT SET")
		print("NEXT SET:", SceneManager.next_scene)

		SceneManager.after_transition_scene = "res://Scenes/BetweenScene.tscn"

		get_tree().change_scene_to_file(
			"res://Scenes/TransitionScene.tscn"
		)

		print("CHANGE SCENE FINISHED")

	if scene_changing:
		return

		if message == "OPEN":

			scene_changing = true

			SceneManager.between_text = """
		Take a moment to reflect on how the previous environment made you feel.

		Stress and uncertainty can influence the way we perceive our surroundings.
		"""

			SceneManager.next_scene = "res://Scenes/NatureScene.tscn"

			print("JUMPSCARE TEXT:")
			print(SceneManager.between_text)

			print("JUMPSCARE NEXT:")
			print(SceneManager.next_scene)

			await FadeCanvas.change_scene(
				"res://Scenes/BetweenScene.tscn"
			)
