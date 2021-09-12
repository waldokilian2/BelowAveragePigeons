extends Node2D

var food_list: Array
onready var player1: = $Player1
onready var player2: = $Player2
onready var timer: = $HealthTickTimer
onready var carrot = preload("res://Carrot.tscn")
onready var clover = preload("res://Clover.tscn")
onready var pom = preload("res://Pom.tscn")
onready var berry = preload("res://Berry.tscn")

func _ready() -> void:
	food_list = [carrot, clover, berry, pom]
	randomize()
	
	
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


func _on_FoodDropperTimer_timeout() -> void:
	var food_item = food_list[rand_range(0, food_list.size())].instance()
	print(food_item)
	var random_x = rand_range(10, 1850)
	var random_y = rand_range(0, 900)
	food_item.global_position = Vector2(random_x, random_y)
	food_item.connect("heal_player1", player1, "heal")
	food_item.connect("heal_player2", player2, "heal")
	add_child(food_item)
