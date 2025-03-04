extends Node2D

@export var enabled : bool = false
@export var track : Path2D
@export var opening_seed : String
@onready var timer: Timer = $Timer
@onready var marble_manager: Node2D

var numerical_seed : String
var seed_position := 0

func _ready() -> void:
	global_position = track.curve.get_point_position(0)
	marble_manager = get_tree().get_nodes_in_group("MarbleManager")[0]
	_parse_opening_seed()
	enabled = true

func _parse_opening_seed() -> void:
	var seed : Array[int]
	for char in opening_seed:
		var char_as_string = char as String
		seed.append(char_as_string.unicode_at(0))
	
	var seed_as_string : String
	for unicode in seed:
		var code = unicode as int
		seed_as_string += str(code)
	
	numerical_seed = seed_as_string
	print(seed_as_string)

func _spawn_marble() -> void:
	if enabled:
		var spawn_marble = GlobalVariables.trackMarble.instantiate()
		track.add_child(spawn_marble)
		if seed_position <= numerical_seed.length() - 1:
			var index = numerical_seed[seed_position].to_int()
			var color_index : String
			color_index = GlobalVariables.color_strings.find_key(index)
			spawn_marble.set_color(color_index)
			seed_position += 1
		else:
			var color_index : String
			color_index = GlobalVariables.color_strings.find_key(randi_range(0,9))
			spawn_marble.set_color(color_index)
		marble_manager.add_marble_from_spawn(spawn_marble)
	else:
		pass

func _game_over():
	timer.pause()
	timer.autostart = false
	enabled = false
