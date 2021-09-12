extends Node2D

onready var player1: = $Player1
onready var player2: = $Player2
onready var timer: = $HealthTickTimer

func _ready():
	var random_x
	var random_y
	var carrot = preload("res://Carrot.tscn").instance()
	var clover = preload("res://Clover.tscn").instance()
	var pom = preload("res://Pom.tscn").instance()
	
	randomize()
	for i in range(10):	
		random_x = rand_range(0, 1920)
		random_y = rand_range(0, 1080)
		var berry = preload("res://Berry.tscn").instance()
		berry.global_position = Vector2(random_x, random_y)
		add_child(berry)

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
