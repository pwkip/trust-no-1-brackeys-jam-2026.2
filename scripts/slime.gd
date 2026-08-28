extends Node2D

@export var number = 1
@export var statement = ""
@export var has_coin = false

signal coin_dropped(body)

var isHidden = false

func _ready() -> void:
	$Statement.text = statement
	$Label.text = "Slime\nN°%d" % number
	$Statement.visible = false
	$Label.visible = true
	
	for slime in get_parent().get_children():
		slime.coin_dropped.connect(_on_coin_dropped)
	
	
func _process(delta: float) -> void:
	if (%player.position.x < position.x):
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if isHidden:
		return
	$Statement.visible = true
	$Label.visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if isHidden:
		return
	$Statement.visible = false
	$Label.visible = true

func take_hit():
	$AnimatedSprite2D.play("hit")
	if (has_coin):
		has_coin = false
		$coin.visible = true
		$coin.monitoring = true
		await $AnimatedSprite2D.animation_finished
		coin_dropped.emit(self)
		$slimeGoesAudio.play()
	else:
		#retaliate
		await $AnimatedSprite2D.animation_finished
		%player.take_hit()
		$AnimatedSprite2D.play("attack")

		
func _on_coin_dropped(body: Node2D):
	$Area2D/CollisionShape2D.queue_free()
	isHidden = true
	$Label.visible = false
	$Statement.visible = false
	$AnimatedSprite2D.play("go_away")
	
	
