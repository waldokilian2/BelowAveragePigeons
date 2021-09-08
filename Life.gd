extends Node

signal life_lost
signal depleted

onready var lives: = 3
	
func decrement_life() -> void:
	lives -= 1
	emit_signal("life_lost")
	if lives == 0:
		emit_signal("depleted")
	

