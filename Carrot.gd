extends Food

func _on_HitArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1"):
		emit_signal("heal_player1", health_value)
		queue_free()
	elif area.is_in_group("player2"):
		emit_signal("heal_player2", health_value)
		queue_free()
