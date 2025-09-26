extends CharacterBody2D

var MAX_SPEED = 400
const WALK = 100  # Default walking speed
const RUN = 150   # Running speed
var animated_sprite: AnimatedSprite2D  # Reference to the AnimatedSprite2D node

func _ready():
	# Grab the AnimatedSprite2D node (make sure it's named correctly in the scene)
	animated_sprite = $AnimatedSprite2D

func _process(delta):
	# Get the running state (if holding the "running" input action)
	var running = Input.get_action_strength("running")
	
	# Get the movement input vector
	var input_vector = Input.get_vector("left", "right", "up", "down")
	var direction = input_vector.normalized()

	# Adjust MAX_SPEED based on whether the player is running or walking
	if running != 0:
		MAX_SPEED = RUN
	else:
		MAX_SPEED = WALK

	# Update velocity based on direction and speed
	velocity = direction * MAX_SPEED

	# Handle animation based on the movement direction
	if direction.length() > 0:
		# If there is movement, play the appropriate walk animation
		if direction.y < 0:
			animated_sprite.play("walk_up")  # Play walking up animation
		elif direction.y > 0:
			animated_sprite.play("walk_down")  # Play walking down animation
		elif direction.x < 0:
			animated_sprite.play("walk_left")  # Play walking left animation
		elif direction.x > 0:
			animated_sprite.play("walk_right")  # Play walking right animation
	else:
		# If there is no movement, stop the walking animation and play idle animation based on direction
		animated_sprite.stop()  # Stop the walking animation
		
		if direction.y < 0:
			animated_sprite.play("idle_up")  # Play idle up animation
		elif direction.y > 0:
			animated_sprite.play("idle_down")  # Play idle down animation
		elif direction.x < 0:
			animated_sprite.play("idle_left")  # Play idle left animation
		elif direction.x > 0:
			animated_sprite.play("idle_right")  # Play idle right animation

	# Move the character
	move_and_slide()


func _on_button_pressed() -> void:
	pass # Replace with function body.
