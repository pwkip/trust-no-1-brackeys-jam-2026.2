# game_manager.gd  (autoload)
extends Node

signal score_changed(new_score)

var score = 0

func add_point():
	score = score + 1
	score_changed.emit(score)
	
func substract_point():
	score = score - 1
	score_changed.emit(score)
	
func reset():
	score = 0
	score_changed.emit(score)
	get_tree().reload_current_scene()
