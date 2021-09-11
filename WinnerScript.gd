extends Sprite
onready var player_1_wins_texture =preload("res://Game assets/Player1Wins.png")
onready var player_2_wins_texture =preload("res://Game assets/Player2Wins.png")

func _ready():
	if Global.winner == 1:
		set_texture(player_1_wins_texture)
	else:
		set_texture(player_2_wins_texture)
