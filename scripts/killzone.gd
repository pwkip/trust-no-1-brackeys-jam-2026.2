extends Node2D



func _on_body_entered(body: Node2D) -> void:
	%player.die()


func _on_timer_timeout() -> void:
	GameManager.reset()
	get_tree().reload_current_scene()
	Engine.time_scale = 1
