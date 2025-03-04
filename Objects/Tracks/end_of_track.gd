extends Area2D

signal game_over

@export var track : Path2D

func _ready() -> void:
	global_position = track.curve.get_point_position(track.curve.point_count-1)
	game_over.connect(GlobalVariables._on_game_over)

func _end_of_track_reached(area : Area2D):
	game_over.emit()
