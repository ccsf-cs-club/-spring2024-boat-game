extends Label

func set_player_node(player_node_path: NodePath):
	var player_node = get_node_or_null(player_node_path)
	if player_node:
		player_node.connect("speed_changed", Callable(self, "_on_speed_change"))
	else:
		print("Player node not found.")

func _ready():
	text = ""
	# Font for Size
	var font = FontFile.new()
	font = load("res://assets/FontRoboto/Roboto-Black.ttf")

	# These functions aren't documented, finding them was hell.
	# https://docs.godotengine.org/en/stable/classes/class_control.html
	# https://docs.godotengine.org/en/stable/classes/class_label.html#theme-property-descriptions
	add_theme_font_override("font", font)
	add_theme_font_size_override("font_size", 52)
	
	# Button Counter node
	
func _on_speed_change(new_speed):
	text = str(new_speed)
