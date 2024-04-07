extends Node2D

# layer 1

@export var layer = 1

@onready var player = $"../../CharacterBody2D"
@export var speed_offset = 0.1
var pos_offset : Vector2
@export var tile_size = 10


func _ready():
	pos_offset = position
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position * layer * speed_offset
	if position.x - player.position.x > tile_size:
		pos_offset.x -= (tile_size*2);
	pass
