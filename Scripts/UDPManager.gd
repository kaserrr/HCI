extends Node

signal message_received(message)

func _ready():
	print("UDPManager READY")

func _input(event):

	if event is InputEventKey and event.pressed:

		print("KEY:", event.keycode)

		if event.keycode == 48:
			print("OPEN TEST")
			message_received.emit("OPEN")
