extends CanvasLayer
class_name UI

@onready var speed_label = %Speed
@onready var center_text = %CenterText

@onready var min_font_size = 10
@onready var max_font_size = 20


var speed = 0:
	set(new_speed):
		speed = new_speed
		_update_speed_label()
		# var font_size = lerp(min_font_size, max_font_size, new_speed / 50.0)
		var font_size = 24
		speed_label.add_theme_font_size_override("font_size", font_size)
		center_text.add_theme_font_size_override("font_size", font_size)
		
		
		

func _ready():
	speed_label.add_theme_font_override("font",load("res://FontRoboto/Roboto-Black.ttf"))
	center_text.add_theme_font_override("font",load("res://FontRoboto/Roboto-Black.ttf"))
	_update_speed_label()
	
	

func _update_speed_label():
	speed_label.text = "%.f" % speed

func _on_speed_change(speed_update) -> void:
	speed = speed_update
