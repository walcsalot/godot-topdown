extends CharacterBody2D

var MAX_SPEED = 400
const RUN = 150

func _process(delta):
	var running = Input.get_action_strength("running")
	var input_vector = Input.get_vector("left","right","up","down")
	var direction = input_vector.normalized()
	
	if(running != 0):
		MAX_SPEED = RUN
	else:
		MAX_SPEED = 100
	velocity = direction * MAX_SPEED
	move_and_slide()
