extends Node3D

@onready var balloon = $"../Balloon"
@onready var pop_sound = $"../Balloon/PopSound"
@onready var confetti = $"../Confetti"

@onready var characters = [
	$"../Character1",
	$"../Character2",
	$"../Character3"
]

var pumps := 0
var max_pumps := 15
var popped := false

var base_scale : Vector3
var target_scale : Vector3

func _ready():
	randomize()

	base_scale = balloon.scale
	target_scale = base_scale

	for character in characters:
		character.visible = false

func _process(delta):
	if not popped:
		balloon.scale = balloon.scale.lerp(target_scale, delta * 5)

		# Laat ballon schudden als hij bijna knapt
		if pumps > max_pumps * 0.8:
			balloon.rotation.z = randf_range(-0.05, 0.05)

func _input(event):
	if popped:
		return

	if event.is_action_pressed("Pump"):
		pumps += 1

		var multiplier = 1.0 + pumps * 0.1
		target_scale = base_scale * multiplier
		
		print("Balloon scale:", balloon.scale)
		print("Target scale:", target_scale)

		print("Pumps: ", pumps)

		if pumps >= max_pumps:
			pop_balloon()

func pop_balloon():
	popped = true

	print("POP!")

	# Verberg ballon
	balloon.visible = false

	# Speel knalgeluid af
	if pop_sound:
		pop_sound.play()

	# Start confetti
	if confetti:
		confetti.restart()
		confetti.emitting = true

	# Kies willekeurig karakter
	if characters.size() > 0:
		var chosen = characters[randi() % characters.size()]
		chosen.visible = true
