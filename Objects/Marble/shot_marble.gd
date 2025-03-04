extends Node2D

@export var movement_speed : float = 100
@onready var sprite_2d: Sprite2D = $Sprite2D
var own_color : String

func _physics_process(delta: float) -> void:
		pass

func set_color(index : int):
	var color_index : String
	if index >= 0:
		color_index = GlobalVariables.color_strings.find_key(index)
	else:
		color_index = GlobalVariables.color_strings.find_key(randi_range(0,9))
	var color = GlobalVariables.color_dictionary[color_index]
	own_color = color_index
	sprite_2d.set_modulate(color)
	print(own_color)
