extends TileMap
class_name World

var chunk_size = Vector2(32, 32)
var loaded_chunks = {} # dictionary

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var cell_size = 8

var player_position : Vector2 = Vector2()
func _on_possition_change(player_pos):
	# should generate infinitely!
	player_position = player_pos

func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()
	altitude.frequency = 0.005

func _process(delta):
	var current_chunk = world_to_chunk_position(player_position)
	load_chunks_around(current_chunk)
	unload_distant_chunks(current_chunk)
#	generate_chunk(player_position)

func world_to_chunk_position(world_pos):
	return Vector2(
		floor(world_pos.x / (chunk_size.x * cell_size)),
		floor(world_pos.y / (chunk_size.y * cell_size)))

func load_chunks_around(chunk_pos):
	# Load the chunk that the player is in and the surrounding ones
	for x in range(chunk_pos.x -2, chunk_pos.x + 3):
		for y in range(chunk_pos.y -2, chunk_pos.y + 3):
			var chunk_key = Vector2(x, y)
			if not loaded_chunks.has(chunk_key):
				load_chunk(chunk_key)
				
func load_chunk(chunk_key):
	# gen logic
	generate_chunk(chunk_key)
	loaded_chunks[chunk_key] = true

func unload_distant_chunks(current_chunk):
	# Go through the loaded_chunks and unload any that are too far from the current_chunk
	var unload_distance = 3 # Number of chunks away to start unloading
	var keys_to_unload = []
	for key in loaded_chunks.keys():
		if key.distance_to(current_chunk) > unload_distance:
			keys_to_unload.append(key)
	
	for key in keys_to_unload:
		unload_chunk(key)

func unload_chunk(chunk_key):
	# Unload the chunk, freeing up resources
	clear_chunk(chunk_key)
	loaded_chunks.erase(chunk_key)

func clear_chunk(chunk_key):
	var world_origin = chunk_key * chunk_size
	for x in range(chunk_size.x):
		for y in range(chunk_size.y):
			var gen_x = world_origin.x + x
			var gen_y = world_origin.y + y
			
			# Deletes a cell
			set_cell(0, Vector2i(gen_x, gen_y), -1, Vector2(-1, -1))

#################

func generate_chunk(chunk_key):
	# Position from world cords to tile cords
	var world_origin = chunk_key * chunk_size
	for x in range(chunk_size.x):
		for y in range(chunk_size.y):
			# Centers generation around player!
			var gen_x = world_origin.x + x
			var gen_y = world_origin.y + y
			# Getting values from -10 to 10
			var moist = moisture.get_noise_2d(gen_x, gen_y) * 10
			var temp = temperature.get_noise_2d(gen_x, gen_y) * 10
			var alt = altitude.get_noise_2d(gen_x, gen_y) * 10
			
			# y axis is temperature, x axis is moisture (on graph)
			# https://youtu.be/ztPbGyQnKPo?si=H_cgn_uB94nIt6oA&t=962
			
			var alt_index = clamp(round((alt + 10) / 5), 0, 3)
			var temp_index = clamp(round((temp + 10) / 5), 0, 3)
			var moist_index = clamp(round((moist + 10) / 5), 0, 3)
			
			if alt < 2:
				set_cell(0, Vector2i(gen_x, gen_y), 1, Vector2(3, temp_index))
			else:
				set_cell(0, Vector2i(gen_x, gen_y), 1, Vector2(moist_index, temp_index))
			
			# tile_layer, position, image source id, atlas = cords of tile on sheet
			# set_cell(0, Vector2i(gen_x, gen_y), 0, Vector2i(0, 1))

#########################




