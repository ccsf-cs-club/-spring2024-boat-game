extends Node2D
class_name main

@export var player: Player
@export var ui: UI

func _ready():
	if !player.speed_change.is_connected(ui._on_speed_change):
		player.speed_change.connect(ui._on_speed_change)
