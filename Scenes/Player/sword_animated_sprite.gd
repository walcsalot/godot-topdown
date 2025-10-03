extends AnimatedSprite2D
class_name SwordAnimatedSprite2D

func play_sword_animation(direction: Vector2) -> void:
	if direction.y < 0:
		play("sword_up")
	elif direction.y > 0:
		play("sword_down")
	elif direction.x < 0:
		play("sword_left")
	elif direction.x > 0:
		play("sword_right")
