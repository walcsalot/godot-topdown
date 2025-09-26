extends Node2D

@onready var player = $Player

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print(body)
		body.scale *= 0.5

func _on_button_pressed() -> void:
	player.scale *= 1.5
