extends Node2D

@export var marble : PackedScene = preload("res://Objects/Marble/ShotMarble.tscn")

@onready var marble_launch_point: Node2D = $MarbleLaunchPoint

@onready var next_marble: Sprite2D = $MarbleLaunchPoint/NextMarble
@onready var swappable_marble: Sprite2D = $SwappableMarble

var launch_color : String
var swap_color : String

var temp_hold_for_swap : String

var can_shoot : bool = true

func _ready() -> void:
	launch_color = GlobalVariables.color_strings.find_key(randi_range(0,9))
	swap_color = GlobalVariables.color_strings.find_key(randi_range(0,9))
	_set_launch_sprite_color()
	_set_swap_sprite_color()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_at(event.position)

func _physics_process(delta: float) -> void:
	if can_shoot:
		if Input.is_action_just_pressed("launch"):
			_shoot()
		if Input.is_action_just_pressed("swap"):
			_swap()

func _shoot():
	print("PEW!")
	pass

func _swap():
	temp_hold_for_swap = launch_color
	launch_color = swap_color
	swap_color = temp_hold_for_swap
	temp_hold_for_swap = ""
	
	_set_launch_sprite_color()
	_set_swap_sprite_color()

func _set_launch_sprite_color():
	next_marble.modulate = GlobalVariables.color_dictionary[launch_color]

func _set_swap_sprite_color():
	swappable_marble.modulate = GlobalVariables.color_dictionary[swap_color]
