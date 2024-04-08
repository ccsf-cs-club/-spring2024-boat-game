extends Control
class_name WelcomeScreen

@export var main_menu : VBoxContainer
@export var settings : VBoxContainer
@export var player : Player
@export var camera : Camera2D
@export var audio_bus : AudioBusLayout


func _on_start_game_button_up():
	visible = false


func _on_settings_button_up():
	main_menu.visible = false
	settings.visible = true


func _on_button_button_up():
	main_menu.visible = true
	settings.visible = false


func _on_spin_camera_pressed():
	camera.ignore_rotation = !camera.ignore_rotation


func _on_ambient_volume_value_changed(value):
	audio_bus.set
