extends Camera2D

onready var p1 = get_parent().get_parent().get_node("Player1")
onready var p2 = get_parent().get_parent().get_node("Player2")

var zoommin = 0.8
var zoommax = 1

func _physics_process(delta):
	position = (p1.position + p2.position) / Vector2(2,2)
	
	zoom.x = max(zoommin, abs((p1.position.x-p2.position.x)/1000))
	zoom.y = zoom.x
	
	if zoom.x > zoommax:
		zoom.y = zoommax
		zoom.x = zoommax
