extends Area2D

func _on_game_box_body_exited(body: Node2D) -> void:
	body.kill()
