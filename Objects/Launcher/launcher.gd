extends Node2D

@export var marble : PackedScene = preload("res://Objects/Marble/ShotMarble.tscn")

@onready var marble_launch_point: Node2D = $MarbleLaunchPoint

@onready var next_marble: Sprite2D = $MarbleLaunchPoint/NextMarble
@onready var swappable_marble: Sprite2D = $SwappableMarble

var launch_color : String
var swap_color : String

var temp_hold_for_swap : String

@export var shoot_cooldown : float = 0.5
@onready var shoot_cooldown_timer: Timer = $Timer
var can_shoot : bool = true
var game_over : bool = false

func _ready() -> void:
	launch_color = GlobalVariables.color_strings.find_key(randi_range(0,9))
	swap_color = GlobalVariables.color_strings.find_key(randi_range(0,9))
	_set_launch_sprite_color()
	_set_swap_sprite_color()

func _input(event: InputEvent) -> void:
	if not game_over:
		if event is InputEventMouseMotion:
			look_at(event.position)
			#may turn it into a paddle on a track, but for now the rotating face works

func _physics_process(delta: float) -> void:
	if can_shoot:
		if Input.is_action_just_pressed("launch"):
			_shoot()
	if Input.is_action_just_pressed("swap"):
		_swap()

func _shoot():
	#spawn marble
	print("PEW!!!!")
	var new_marble = marble.instantiate()
	get_tree().get_first_node_in_group("Level").add_child(new_marble)
	new_marble.global_position = marble_launch_point.global_position
	new_marble.global_rotation = global_rotation
	new_marble.set_color(launch_color)
	
	#set new launch color from swap color
	launch_color = swap_color
	_set_launch_sprite_color()
	#set new swap color
	swap_color = GlobalVariables.color_strings.keys()[randi_range(0,GlobalVariables.color_strings.size()-1)]
	_set_swap_sprite_color()
	
	_block_shoot()

func _block_shoot():
	can_shoot = false
	shoot_cooldown_timer.start(shoot_cooldown)

func _game_over():
	can_shoot = false
	game_over = true

func _unblock_shoot():
	can_shoot = true

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
