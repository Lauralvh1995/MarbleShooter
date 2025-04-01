extends PathFollow2D
class_name Marble

signal marble_entered(color : String, marble_self : Node2D)

@export var movement_speed : float = 100
@export var reverse_speed : float = 200
@export var color_sprite_2d: AnimatedSprite2D
@export var overlay_sprite_2d: AnimatedSprite2D
@export var debug_label : Label
var radius : float

var own_color : String
enum roll_state {FORWARD, BACKWARD, STOPPED, GAME_OVER}
var current_roll_state = roll_state.FORWARD

func _ready():
	radius = $DetectionArea/CollisionShape2D.shape.radius

func _physics_process(delta: float) -> void:
	match current_roll_state:
		roll_state.FORWARD : 
			progress += movement_speed * delta
		roll_state.BACKWARD : 
			progress -= reverse_speed * delta
		roll_state.STOPPED : 
			pass
		roll_state.GAME_OVER : 
			progress += 20 * movement_speed * delta 

func set_color(index : String):
	var color = GlobalVariables.color_dictionary[index]
	own_color = index
	color_sprite_2d.set_modulate(color)
	GlobalVariables.game_over.connect(_on_game_over)

func _on_marble_entered(body : Node2D):
	print("I was hit by a "+ body.own_color + " marble")
	var direction = transform.x.dot(position.direction_to(body.position))
	marble_entered.emit(body.own_color, self, direction)
	body.kill()

func start_rollback():
	current_roll_state = roll_state.BACKWARD
	color_sprite_2d.play_backwards()
	overlay_sprite_2d.play_backwards()

func _on_game_over():
	current_roll_state = roll_state.GAME_OVER

func set_debug_text(text: String):
	debug_label.text = text

func stop():
	current_roll_state = roll_state.STOPPED
	color_sprite_2d.pause()
	overlay_sprite_2d.pause()

func start():
	current_roll_state = roll_state.FORWARD
	color_sprite_2d.play()
	overlay_sprite_2d.play()
