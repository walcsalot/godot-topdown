extends CharacterBody2D

var MAX_SPEED = 400
const WALK = 100
const RUN = 150
var animated_sprite: AnimatedSprite2D
var sword_sprite: SwordAnimatedSprite2D  # Reference to the sword sprite node

var is_attacking = false
var attack_direction = Vector2.ZERO
var attack_cooldown = 0.5  # Attack animation length (seconds)
var attack_timer = 0.0

var last_direction = Vector2.DOWN  # Track last movement/facing direction

func _ready():
	animated_sprite = $AnimatedSprite2D
	sword_sprite = $SwordAnimatedSprite2D
	sword_sprite.hide()  # Hide sword initially

func _process(delta):
	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			sword_sprite.hide()
	
	if not is_attacking:
		handle_movement_and_animation()

func handle_movement_and_animation():
	var running = Input.get_action_strength("running")
	var input_vector = Input.get_vector("left", "right", "up", "down")
	var direction = input_vector.normalized()
	
	if running != 0:
		MAX_SPEED = RUN
	else:
		MAX_SPEED = WALK
	
	velocity = direction * MAX_SPEED
	
	# Movement animations
	if direction.length() > 0:
		last_direction = direction  # Update last direction when moving

		if running != 0:
			if direction.y < 0:
				animated_sprite.play("run_up")
			elif direction.y > 0:
				animated_sprite.play("run_down")
			elif direction.x < 0:
				animated_sprite.play("run_left")
			elif direction.x > 0:
				animated_sprite.play("run_right")
		else:
			if direction.y < 0:
				animated_sprite.play("walk_up")
			elif direction.y > 0:
				animated_sprite.play("walk_down")
			elif direction.x < 0:
				animated_sprite.play("walk_left")
			elif direction.x > 0:
				animated_sprite.play("walk_right")
	else:
		animated_sprite.stop()
		# Use last_direction to choose correct idle animation
		if last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")
		elif last_direction.x < 0:
			animated_sprite.play("idle_left")
		elif last_direction.x > 0:
			animated_sprite.play("idle_right")
	
	move_and_slide()

func _input(event):
	if event.is_action_pressed("attack") and not is_attacking:
		var input_vector = Input.get_vector("left", "right", "up", "down")
		var direction = input_vector.normalized()
		
		# If no direction input, use last movement/facing direction
		if direction == Vector2.ZERO:
			direction = last_direction
		
		start_attack(direction)

func start_attack(direction: Vector2):
	is_attacking = true
	attack_timer = attack_cooldown
	attack_direction = direction
	last_direction = direction  # Optional: update facing direction when attacking
	
	# Play character attack animation
	if direction.y < 0:
		animated_sprite.play("attack_up")
		sword_sprite.position = Vector2(1, -7)  # Push sword upward
	elif direction.y > 0:
		animated_sprite.play("attack_down")
		sword_sprite.position = Vector2(-1, 7)   # Push sword downward
	elif direction.x < 0:
		animated_sprite.play("attack_left")
		sword_sprite.position = Vector2(-7, 0)  # Push sword left
	elif direction.x > 0:
		animated_sprite.play("attack_right")
		sword_sprite.position = Vector2(7, 0)   # Push sword right
	
	# Show and play sword animation
	sword_sprite.show()
	sword_sprite.play_sword_animation(direction)
