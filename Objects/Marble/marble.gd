extends PathFollow2D

signal marble_entered(color : String, marble_self : Node2D)

@export var movement_speed : float = 100
@export var reverse_speed : float = 200
@onready var sprite_2d: Sprite2D = $Sprite2D
var own_color : String
enum roll_state {FORWARD, BACKWARD, STOPPED, GAME_OVER}
var current_roll_state = roll_state.FORWARD

func _physics_process(delta: float) -> void:
	match current_roll_state:
		roll_state.FORWARD : progress += movement_speed * delta
		roll_state.BACKWARD : progress -= reverse_speed * delta
		roll_state.STOPPED : pass
		roll_state.GAME_OVER : progress += 20 * movement_speed * delta 

func set_color(index : String):
	var color = GlobalVariables.color_dictionary[index]
	own_color = index
	sprite_2d.set_modulate(color)
	GlobalVariables.game_over.connect(_on_game_over)

func _on_marble_entered(body : Node2D):
	print("I was hit by a "+ body.own_color + " marble")
	marble_entered.emit(body.own_color, self)
	body.kill()

func _start_rollback():
	pass

func _initiate_match(color : String):
	pass

func _on_game_over():
	current_roll_state = roll_state.GAME_OVER
