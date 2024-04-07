extends CanvasLayer
class_name UI

@onready var speed_label = %Speed

var speed = 0:
	set(new_speed):
		speed = new_speed
		_update_speed_label()

func _ready():
	_update_speed_label()

func _update_speed_label():
	speed_label.text = "%.f" % speed

func _on_speed_change(speed_update) -> void:
	speed = speed_update
