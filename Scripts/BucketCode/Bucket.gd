extends Node3D

@export_enum("red")
var bucket_color = "red"

func _on_body_entered(body):
	print("Object entered:", body.name)

	if "ball_color" in body:
		print("Ball color:", body.ball_color)

		if body.ball_color == bucket_color:
			print("Correct!")
		else:
			print("Wrong!")
