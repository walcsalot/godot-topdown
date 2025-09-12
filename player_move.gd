extends CharacterBody2D

var MAX_SPEED = 240
const RUN = 400

func process(delta):
	var running = Input.get_action_strength("running")
	var input_vector = Input.get_vector("left","right","up","down")	
	velocity = input_vector * MAX_SPEED
	move_and_slide()
