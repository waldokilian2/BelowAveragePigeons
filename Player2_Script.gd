extends Player

signal player_death(loser)
onready var attack_animation = $AttackArea/AttackCollision/ShoveAnimation
onready var health_bar = $"Animated Sprite/ProgressBar"
onready var attack_collision = $AttackArea/AttackCollision
onready var attack_timer = $AttackDurationTimer
onready var attack_area = $AttackArea
onready var health = $Health

func _ready() -> void:
	health.connect("changed", health_bar, "set_value")
	health.connect("max_changed", health_bar, "set_max")
	health.initialize()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	if Input.is_action_pressed("sprint"):
		speed = 800
	else:
		speed = 500
		
	if Input.is_action_pressed("move_right_P2"):
		direction = Vector2.RIGHT
		if attack_collision.position.x < 0:
			attack_collision.position.x *= -1
		velocity.x = speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = false
	elif Input.is_action_pressed("move_left_P2"):
		direction = Vector2.LEFT
		if attack_collision.position.x > 0:
			attack_collision.position.x *= -1
		velocity.x = -speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = true
	else:
		$"Animated Sprite".play("idle")
	
	if Input.is_action_just_pressed("attack_P2"):
		attack()
		
	velocity.y += GRAVITY
	
	attack_area.knockback_vector = set_area_knockback(velocity)
	
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.1)
	
	if not is_on_floor():
		$"Animated Sprite".play("jump")
		
	if Input.is_action_just_pressed("jump_P2") and is_on_floor():
		velocity.y = JUMPFORCE

func attack() -> void:
	set_animation()
	set_attack_timer()
	attack_collision.disabled = false

func set_animation() -> void:
	if direction.x == -1:
		attack_animation.flip_h = true
	else:
		attack_animation.flip_h = false
	$ShoveSound.play()
	attack_animation.play("shove")

func set_attack_timer() -> void:
	attack_timer.one_shot
	attack_timer.start(0.1)
	
func set_area_knockback(velocity: Vector2) -> Vector2:
	if velocity.x < 1:
		return direction
	return velocity.normalized()
	
func _on_fall_zone_body_entered(body):
	if body.name == "Player2":
		health.set_current(0)

func _on_Health_depleted() -> void:
	print("game over")
	emit_signal("player_death","Player2")

func _on_HitArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("melee_attack_p1"):
		knockback = area.knockback_vector * 300
		
func _on_AttackDurationTimer_timeout() -> void:
	attack_collision.disabled = true


func _on_ShoveAnimation_animation_finished() -> void:
	attack_animation.stop()
