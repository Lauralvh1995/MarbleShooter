extends Area2D

signal game_over

@export var track : Path2D

func _ready() -> void:
	global_position = track.curve.get_point_position(track.curve.point_count-1)
