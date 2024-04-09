extends Node

var audio_players: Array[AudioStreamPlayer]
var current_player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Audio array making")
	for audio_node in get_children():
		if audio_node is AudioStreamPlayer:
			print("Added ", audio_node)
			audio_players.append(audio_node)
			audio_node.finished.connect(_on_stream_finished)
	
	play_random_track()

# get a random one
func play_random_track():
	current_player = audio_players[randi() % audio_players.size()]
	print("New trackies momen: ", current_player)
	current_player.play()

# when one's finished pick new random one
func _on_stream_finished():
	print("Raaa audio finished")
	play_random_track()
