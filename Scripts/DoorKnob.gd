extends Node

var udp := PacketPeerUDP.new()

func _ready():
	var error = udp.bind(4242)

	if error == OK:
		print("Listening on port 4242")
	else:
		print("Failed to bind port")

func _process(_delta):
	while udp.get_available_packet_count() > 0:
		var packet = udp.get_packet()
		var message = packet.get_string_from_utf8()

		print("Received: ", message)

		match message:
			"OPEN":
				open_door()

			"CLOSE":
				close_door()

var scene_changing = false

func open_door():
	if scene_changing:
		return

	scene_changing = true

	print("Door opened")

	await FadeCanvas.change_scene(
		"res://Scenes/NatureScene.tscn"
)

func close_door():
	print("Door closed")
	await FadeCanvas.change_scene(
		"res://Scenes/PartyScene.tscn"
	)
