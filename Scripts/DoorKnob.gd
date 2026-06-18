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

func open_door():
	print("Door opened")
	get_tree().change_scene_to_file("res://Scenes/OpenDoorScene.tscn")

func close_door():
	print("Door closed")
	get_tree().change_scene_to_file("res://Scenes/CloseDoorScene.tscn")
