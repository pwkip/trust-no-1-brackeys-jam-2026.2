extends Node2D

var isDeparted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_inside_ferry_body_entered(body: Node2D) -> void:
	
	if (isDeparted || !$CoinSlot.has_coin):
		return
	isDeparted = true
	$platform/animationplayer.play("move")
