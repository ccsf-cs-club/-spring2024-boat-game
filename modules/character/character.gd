extends CharacterBody2D
class_name Player

signal speed_change(new_speed)
signal distance_to_change(new_dist_to)
signal position_change(position)

@onready var audio_player = $AudioStreamPlayer2D
@onready var shape_cast = $ShapeCast2D

# velocity is a default internal variable
var acceleration : float = 0
var max_speed : float = 200
var speed : float = 0
var friection: float = 500

var theta : float = 0
var direction : Vector2 = Vector2()

var collision_distance : float = 0

func read_input(delta):
	# Force stringName with & [[ returns -1, 0, or 1
	# Input.get_axis(&"down", &"left")
	
	if Input.is_action_pressed("up"):
		speed += 1
	else:
		speed -= 0.05
	
	if Input.is_action_pressed("down"):
		speed -= 3
	
	if Input.is_action_pressed("left"):
		theta += 0.03
	if Input.is_action_pressed("right"):
		theta -= 0.03
	
	# Direction
	direction = Vector2.from_angle(-theta)
	
	# Speed
	speed = clamp(speed, 0, 200)
	velocity = direction * speed
	
	speed_change.emit(velocity.length())
	position_change.emit(position)

	#print(direction, "\t", acceleration, "\t\t", velocity, "\t", theta)
# Called 60 times per sec (set in settings)
# Accurate
func _physics_process(delta):
	read_input(delta)
	
	audio_player.volume_db = remap(velocity.length(), 0, max_speed, -8, 5)
	
	# Accounts for jitters in frame rate in weird camera
	rotation = -theta * delta * 60
	
	var dist_to = 0
	if shape_cast.is_colliding():
		dist_to = global_position.distance_to(shape_cast.get_collision_point(0))
	
	distance_to_change.emit(dist_to)
	
	# moves based on internal variable velocity, returns collision
	var collided = move_and_slide()
	if collided:
		if speed >= 10.5:
			speed -= 5
		# print("collided!!!")
		


# Add clouds!!!
