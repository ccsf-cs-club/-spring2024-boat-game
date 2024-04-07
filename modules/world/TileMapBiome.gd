extends TileMap
class_name World

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var width = 8
var height = 8

var player_position : Vector2 = Vector2()

func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()

func _process(delta):
	print(player_position)
	generate_chunk(player_position)

func _on_possition_change(player_pos):
	# should generate infinitely!
	player_position = player_pos

func generate_chunk(position):
	print("chunk_generating")
	# Position from world cords to tile cords
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			# Centers generation around player!
			var gen_x = tile_pos.x - width/2 + x
			var gen_y = tile_pos.y - width/2 + y
			# 
			var moist = moisture.get_noise_2d(gen_x, gen_y)
			var temp = temperature.get_noise_2d(gen_x, gen_y)
			var alt = altitude.get_noise_2d(gen_x, gen_y)
			# tile_layer, position, image source id, atlas = cords of tile on sheet
			set_cell(0, Vector2i(gen_x, gen_y), 0, Vector2i(0, 1))







