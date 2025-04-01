extends Node

signal game_over
var trackMarble : PackedScene = preload("res://Objects/Marble/TrackMarble.tscn")
var min_match_size := 3
var color_dictionary : Dictionary = {
	"RED" = Color.RED,
	"GREEN" = Color.GREEN,
	"BLUE" = Color.BLUE,
	"YELLOW" = Color.YELLOW,
	"MAGENTA" = Color.MAGENTA,
	"CYAN" = Color.CYAN,
	"ORANGE" = Color.ORANGE,
	"WHITE" = Color.WHITE,
	"GRAY" = Color.GRAY,
	"BLACK" = Color.BLACK + Color(0.1,0.1,0.1)
}
enum color_strings {RED, GREEN, BLUE, YELLOW, MAGENTA, CYAN, ORANGE, WHITE, GRAY, BLACK}


func _on_game_over():
	game_over.emit()
