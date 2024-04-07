extends TileMap
class_name World

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var width = 64
var height = 64

var player_position : Vector2 = Vector2()

func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()

func _process(delta):
	generate_chunk(player_position)

func _on_possition_change(player_pos):
	# should generate infinitely!
	player_position = player_pos

func generate_chunk(position):
	# Position from world cords to tile cords
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			# Centers generation around player!
			var gen_x = tile_pos.x - width/2 + x
			var gen_y = tile_pos.y - width/2 + y
			# Getting values from -10 to 10
			var moist = moisture.get_noise_2d(gen_x, gen_y) * 10
			var temp = temperature.get_noise_2d(gen_x, gen_y) * 10
			var alt = altitude.get_noise_2d(gen_x, gen_y) * 10
			
			# y axis is temperature, x axis is moisture (on graph)
			# https://youtu.be/ztPbGyQnKPo?si=H_cgn_uB94nIt6oA&t=962
			set_cell(0, Vector2i(gen_x, gen_y), 1, Vector2(round((moist+10)/5), round((temp+10)/5)))
			if alt < 2:
				set_cell(0, Vector2i(gen_x, gen_y), 1, Vector2(3, round((temp+10)/5)))
			
			# tile_layer, position, image source id, atlas = cords of tile on sheet
			# set_cell(0, Vector2i(gen_x, gen_y), 0, Vector2i(0, 1))







