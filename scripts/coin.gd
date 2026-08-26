extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("im a coin")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	#if ($AnimatedSprite2D.visible):
	GameManager.add_point()
	$coinsound.play()
	$AnimatedSprite2D.visible = false


func _on_coinsound_finished() -> void:
	queue_free()
