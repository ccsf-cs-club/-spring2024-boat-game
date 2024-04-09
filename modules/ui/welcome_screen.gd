extends Control
class_name WelcomeScreen

@export var main_menu : VBoxContainer
@export var settings : VBoxContainer
@export var player : Player
@export var camera : Camera2D
@export var ambient_slider : HSlider


@export var bus_name: String = "music"
var bus_index: int


func _read():
	bus_index = AudioServer.get_bus_index(bus_name)

func _on_ambient_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_start_game_button_up():
	player.position = Vector2(0, 0)
	visible = false


func _on_settings_button_up():
	main_menu.visible = false
	settings.visible = true


func _on_button_button_up():
	main_menu.visible = true
	settings.visible = false


func _on_spin_camera_pressed():
	camera.ignore_rotation = !camera.ignore_rotation

func _on_smooth_camera_pressed():
	camera.position_smoothing_enabled = !camera.position_smoothing_enabled

func _input(event:InputEvent)->void:
	# checks just this frame
	if Input.is_action_just_pressed("openSettings"):
		print("Raaa")
		main_menu.visible = false
		visible = !visible
		settings.visible = true



