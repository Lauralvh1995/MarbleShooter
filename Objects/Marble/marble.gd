extends PathFollow2D
class_name Marble

signal marble_entered(color : String, marble_self : Node2D)

@export var movement_speed : float = 100
@export var reverse_speed : float = 200
@export var sprite_2d: Sprite2D
@export var debug_label : Label
var radius : float

var own_color : String
enum roll_state {FORWARD, BACKWARD, STOPPED, GAME_OVER}
var current_roll_state = roll_state.FORWARD

func _ready():
	radius = $DetectionArea/CollisionShape2D.shape.radius

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
	var direction = transform.x.dot(position.direction_to(body.position))
	marble_entered.emit(body.own_color, self, direction)
	body.kill()

func _start_rollback():
	pass

func _initiate_match(color : String):
	pass

func _on_game_over():
	current_roll_state = roll_state.GAME_OVER

func set_debug_text(text: String):
	debug_label.text = text
