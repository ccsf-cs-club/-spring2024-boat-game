extends CanvasLayer
class_name UI

@onready var speed_label = %Speed
@onready var distance_to_label = %DistanceTo
@onready var center_text = %CenterText

@onready var min_font_size = 12.0
@onready var max_font_size = 15.0

@onready var inventory_interface = $InventoryInterface


var dist_to = 0:
	set(new_dist):
		dist_to = new_dist
		_update_dist_to_label()

var speed = 0:
	set(new_speed):
		speed = new_speed
		_update_speed_label()
		# var font_size = lerp(min_font_size, max_font_size, new_speed / 50.0)
		
		var font_size = 24
		speed_label.add_theme_font_size_override("font_size", font_size)
		center_text.add_theme_font_size_override("font_size", font_size)

func _ready():
	_update_speed_label()

func _update_speed_label():
	speed_label.text = "%.f" %speed

func _on_speed_change(speed_update) -> void:
	speed = speed_update

func _update_dist_to_label():
	distance_to_label.text = "Collision in " + "%.f" %dist_to
	

func _on_distance_to_change(distance_to) -> void:
	dist_to = distance_to
