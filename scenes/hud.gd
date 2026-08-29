extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.hearts_changed.connect(_on_hearts_changed)
	pass # Replace with function body.

func _on_score_changed(new_score: int):
	$Label.text = "x"+str(new_score)
	
func _on_hearts_changed(new_hearts: int):
	
	if (new_hearts == 0):
		%player.die()
	
	for heart in [$Heart3, $Heart2, $Heart1]:
		if heart.visible:
			heart.visible = false
			break
			
func collect_coin(startPosition :Vector2):
	var coin = $AnimatedSprite2D.duplicate()
	add_child(coin)
	coin.position = startPosition
	var t = create_tween()
	t.set_parallel(true)
	t.tween_property(coin,"position", $AnimatedSprite2D.position, 0.5)
	await t.finished
	coin.queue_free()
