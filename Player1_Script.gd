extends Player

signal player_death
onready var health = $Health
onready var life = $Life
onready var health_bar = $"Animated Sprite/ProgressBar"
const SPAWN_POSITION: = Vector2(260,60)

func _ready() -> void:
	health.connect("changed", health_bar, "set_value")
	health.connect("max_changed", health_bar, "set_max")
	health.initialize()
	
func _physics_process(delta):
	if Input.is_action_pressed("sprint"):
		speed = 800
	else:
		speed = 500
		
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = true
	else:
		$"Animated Sprite".play("idle")
	if not is_on_floor():
		$"Animated Sprite".play("jump")
	
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		$SoundJump.play()
		
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.1)
	
	if Input.is_action_just_pressed("shove"):
		$SoundShove.play()
	


func _on_fall_zone_body_entered(body):
	if body.name == "Player1":
		health.set_current(0)

func _on_Health_depleted() -> void:
	lose_life()
	if lives == 0:
		on_player_death()
		return
	health.set_current(health.max_amount)
	position = SPAWN_POSITION
	print("Player 1 lives: " + str(lives))

	
func lose_life() -> void:
	lives -= 1
	if lives == 2:
		$"Animated Sprite/ProgressBar/heart1".hide()
	elif lives == 1:
		$"Animated Sprite/ProgressBar/heart2".hide()
	elif lives == 0:
		$"Animated Sprite/ProgressBar/heart3".hide()

#Implement on death logic
# send through which player dies
func on_player_death() -> void:
	print("game over")
	emit_signal("player_death")
