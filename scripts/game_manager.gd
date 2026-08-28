# game_manager.gd  (autoload)
extends Node

signal score_changed(new_score)
signal hearts_changed(new_hearts)

var score = 0
var hearts = 3

func add_point():
	score = score + 1
	score_changed.emit(score)
	
func subtract_point():
	score = score - 1
	score_changed.emit(score)
	
func subtract_heart():
	hearts = hearts - 1
	hearts_changed.emit(hearts)
	
func reset():
	score = 0
	score_changed.emit(score)
	hearts = 3
	hearts_changed.emit(hearts)
	get_tree().reload_current_scene()
