extends Node

signal max_changed(new_max)
signal changed(new_amount)
signal depleted

export(int) var max_amount = 100 setget set_max
onready var current = max_amount setget set_current

func _ready() -> void:
		initialize()

func set_max(new_max: int) -> void:
	max_amount = new_max
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)
	
func set_current(new_value: int) -> void:
	current = new_value
	current = clamp(current, 0, max_amount)
	emit_signal("changed", current)
	print('Current health: ' + str(current))
	if current == 0:
		emit_signal("depleted")

func initialize() -> void:
	emit_signal("max_changed", max_amount)
	
