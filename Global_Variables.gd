extends Node

signal game_over
var trackMarble : PackedScene = preload("res://Objects/Marble/TrackMarble.tscn")
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
	"BLACK" = Color.BLACK
}
enum color_strings {RED, GREEN, BLUE, YELLOW, MAGENTA, CYAN, ORANGE, WHITE, GRAY, BLACK}


func _on_game_over():
	game_over.emit()
