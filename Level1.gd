extends Node2D

onready var player1: = $Player1
onready var player2: = $Player2
onready var timer: = $HealthTickTimer

func _on_HealthTickTimer_timeout() -> void:
	player1.health.set_current(player1.health.current-1)
	player2.health.set_current(player2.health.current-1)
	
#Implement rest of death logic here
func _on_Player1_player_death() -> void:
	timer.stop()
	Global.winner = 2
	get_tree().change_scene("res://GameOverScreen.tscn")

#Implement rest of death logic here
func _on_Player2_player_death() -> void:
	timer.stop()
	Global.winner = 1
	get_tree().change_scene("res://GameOverScreen.tscn")
