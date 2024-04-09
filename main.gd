extends Node2D
class_name Main

@export var player: Player
@export var ui: UI
@export var world: World

func _ready():
	if !player.speed_change.is_connected(ui._on_speed_change):
		player.speed_change.connect(ui._on_speed_change)
	if !player.distance_to_change.is_connected(ui._on_distance_to_change):
		player.distance_to_change.connect(ui._on_distance_to_change)
	if !player.position_change.is_connected(world._on_possition_change):
		player.position_change.connect(world._on_possition_change)


# F1 is search documentation!!! (Class, methods, properties)
# Or ctrl click! (Pull up documentation or what u made)
