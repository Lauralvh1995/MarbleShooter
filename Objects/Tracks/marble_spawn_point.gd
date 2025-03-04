extends Node2D

@export var enabled : bool = false
@export var marble_set : PackedScene = preload("res://Objects/Marble/TrackMarble.tscn")
@export var track : Path2D
@export var opening_seed : String

var numerical_seed : String
var seed_position := 0

func _ready() -> void:
	global_position = track.curve.get_point_position(0)
	_parse_opening_seed()

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
	var spawn_marble = marble_set.instantiate()
	track.add_child(spawn_marble)
	if seed_position <= numerical_seed.length() - 1:
		var index = numerical_seed[seed_position].to_int()
		print(index)
		spawn_marble.set_color(index)
		seed_position += 1
	else:
		spawn_marble.set_color(-1)
