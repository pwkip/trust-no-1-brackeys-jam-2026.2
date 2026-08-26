extends Area2D

@export var has_coin = false

func _on_body_entered(body: Node2D) -> void:
	if ($SpriteCoin.visible):
		return
	$Text.visible = true

func _on_body_exited(body: Node2D) -> void:
	$Text.visible = false
	
func take_hit():
	if (has_coin):
		return
	if (GameManager.score == 0):
		print('no coins')
		return
	GameManager.substract_point()
	has_coin = true
	$SpriteCoin.visible = true
	$Text.visible = false
