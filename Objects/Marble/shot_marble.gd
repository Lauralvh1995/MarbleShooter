extends CharacterBody2D

@export var movement_speed : float = 100000
@export var sprite_2d: AnimatedSprite2D
var own_color : String

func _physics_process(delta: float) -> void:
	velocity = transform.x * movement_speed * delta
	move_and_slide()

func set_color(index : String):
	var color = GlobalVariables.color_dictionary[index]
	own_color = index
	sprite_2d.set_modulate(color)
	print(GlobalVariables.game_over.connect(kill))

func kill():
	if GlobalVariables.game_over.is_connected(kill):
		GlobalVariables.game_over.disconnect(kill)
	queue_free()
