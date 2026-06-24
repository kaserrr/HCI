extends Node3D

@onready var balloon = $"../Balloon"
@onready var confetti = $"../Confetti"
@onready var music = $"../PartyMusic"

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

var chosen_character = null
var bounce_time := 0.0
var character_base_y := 0.0

func _ready():
	randomize()

	base_scale = balloon.scale
	target_scale = base_scale

	for character in characters:
		character.visible = false

		if character.has_node("Frame1"):
			character.get_node("Frame1").visible = true

		if character.has_node("Frame2"):
			character.get_node("Frame2").visible = false

		if character.has_node("Frame3"):
			character.get_node("Frame3").visible = false


func _process(delta):
	if not popped:
		balloon.scale = balloon.scale.lerp(target_scale, delta * 5)

		if pumps > max_pumps * 0.8:
			balloon.rotation.z = randf_range(-0.05, 0.05)

	if chosen_character:
		bounce_time += delta

		# Op en neer bewegen
		chosen_character.position.y = (
			character_base_y
			+ sin(bounce_time * 6.0) * 0.03
		)

		# Klein pulse-effect
		var pulse = 1.0 + sin(bounce_time * 6.0) * 0.05
		chosen_character.scale = Vector3.ONE * pulse


func _input(event):
	if popped:
		return

	if event.is_action_pressed("Pump"):
		add_pump()


func add_pump():
	pumps += 1

	var multiplier = 1.0 + pumps * 0.1
	target_scale = base_scale * multiplier

	print("Pumps: ", pumps)

	if pumps >= max_pumps:
		pop_balloon()


func pop_balloon():
	popped = true

	print("POP!")

	balloon.visible = false

	if confetti:
		confetti.restart()
		confetti.emitting = true

	if music:
		music.play()

	show_character()


func show_character():
	# Voor nu altijd Character1
	chosen_character = $"../Character2"

	chosen_character.visible = true

	character_base_y = chosen_character.position.y

	# Verschijn-animatie
	chosen_character.scale = Vector3.ZERO

	var tween = create_tween()
	tween.tween_property(
		chosen_character,
		"scale",
		Vector3.ONE,
		0.5
	)

	start_animation()


func start_animation():
	while chosen_character:
		show_frame(1)
		await get_tree().create_timer(0.5).timeout

		show_frame(2)
		await get_tree().create_timer(0.5).timeout

		show_frame(3)
		await get_tree().create_timer(0.5).timeout


func show_frame(frame_number):
	var frame1 = chosen_character.get_node("Frame1")
	var frame2 = chosen_character.get_node("Frame2")
	var frame3 = chosen_character.get_node("Frame3")

	frame1.visible = false
	frame2.visible = false
	frame3.visible = false

	match frame_number:
		1:
			frame1.visible = true
		2:
			frame2.visible = true
		3:
			frame3.visible = true
