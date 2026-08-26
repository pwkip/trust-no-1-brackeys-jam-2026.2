extends Node2D

@export var number = 1
@export var dialogue = ""
@export var has_coin = false
@export var tells_truth = true

func _ready() -> void:
	var statement = "I have the coin."
	if tells_truth && !has_coin || !tells_truth && has_coin:
		statement = "I don't have the coin."
	if (dialogue):
		statement += "\n"
	$Statement.text = statement + dialogue
	$Label.text = "Slime\nno. %d" % number
	$Statement.visible = false
	$Label.visible = true
	
func _process(delta: float) -> void:
	if (%player.position.x < position.x):
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	$Statement.visible = true
	$Label.visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	$Statement.visible = false
	$Label.visible = true

func take_hit():
	if (has_coin):
		print("drop coin")
		has_coin = false
		$coin.visible = true
		$coin.monitoring = true
	else:
		%player.die()
		
	
