extends CharacterBody2D

# velocity is a default internal variable
var direction : Vector2 = Vector2()

func read_input():
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)
	
	# Normalizes magnitude if 2 are pressed
	# Diaganals aren't twice as fast
	velocity = velocity.normalized() * 50
	
	

# Called 60 times per sec (set in settings)
# Accurate
func _physics_process(delta):
	read_input()
	# moves based on internal variable velocity, returns collision
	var collided = move_and_slide()
