extends Area2D

@export_multiline var message = "..."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text.text = message
	$Text.visible = false

func _on_body_entered(body: Node2D) -> void:
	$Text.visible = true

func _on_body_exited(body: Node2D) -> void:
	$Text.visible = false
