extends CharacterBody2D

@export var movement_speed : float = 10000
@export var sprite_2d: Sprite2D
var own_color : String

func _physics_process(delta: float) -> void:
	velocity = transform.x * movement_speed * delta
	move_and_slide()

func set_color(index : String):
	var color = GlobalVariables.color_dictionary[index]
	own_color = index
	sprite_2d.set_modulate(color)

func kill():
	queue_free()
