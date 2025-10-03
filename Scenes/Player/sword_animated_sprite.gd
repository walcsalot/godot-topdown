extends AnimatedSprite2D
class_name SwordAnimatedSprite2D

func play_sword_animation(direction: Vector2) -> void:
	# Set z_index based on direction
	if direction.y < 0:
		play("sword_up")
		z_index = -1  # Behind player
	elif direction.y > 0:
		play("sword_down")
		z_index = 1   # In front of player
	elif direction.x < 0:
		play("sword_left")
		z_index = -1  # Behind player
	elif direction.x > 0:
		play("sword_right")
		z_index = -1  # Behind player

	# Optional: make sure z_index is relative to parent (good practice)
	z_as_relative = true
