extends CharacterBody2D
class_name Player

signal speed_change(new_speed)
signal position_change(position)

@onready var audio_player = $AudioStreamPlayer2D

# velocity is a default internal variable
var acceleration = 0
var max_speed = 200
var speed = 200
var friection = 500

var theta : float = 0
var direction : Vector2 = Vector2()

var inputDirection : Vector2 = Vector2()

func read_input():
	# Makes you stop after moving!
	# velocity = Vector2(0,0)
	
	
	if Input.is_action_pressed("up"):
		acceleration += 1
		inputDirection = Vector2(0, -1)
	else:
		acceleration -= 0.05
	
	if Input.is_action_pressed("down"):
		acceleration -= 3
		inputDirection = Vector2(0, 1)
	
	if Input.is_action_pressed("left"):
		theta += 0.03
		inputDirection = Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		theta -= 0.03
		inputDirection = Vector2(1, 0)
	
	acceleration = clamp(acceleration, 0, 200)
	
	direction.x = cos(theta)
	direction.y = -1*sin(theta)
	
	velocity.x = direction.x * acceleration
	velocity.y = direction.y * acceleration
	
	speed_change.emit(velocity.length())
	position_change.emit(position)

	#print(direction, "\t", acceleration, "\t\t", velocity, "\t", theta)
# Called 60 times per sec (set in settings)
# Accurate
func _physics_process(delta):
	read_input()
	
	audio_player.volume_db = remap(velocity.length(), 0, max_speed, -8, 5)
	
	rotation = -1*(theta)
	
	# moves based on internal variable velocity, returns collision
	var collided = move_and_slide()
	if collided:
		# print("collided!!!")
