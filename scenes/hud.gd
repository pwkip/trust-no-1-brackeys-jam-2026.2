extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)
	pass # Replace with function body.

func _on_score_changed(new_score: int):
	$Label.text = "x "+str(new_score)
