extends Player

signal player_death
onready var health = $Health
onready var life = $Life
onready var attack_collision = $AttackArea/AttackCollision
onready var attack_timer = $AttackDurationTimer
onready var health_bar = $"Animated Sprite/ProgressBar"
onready var attack_area = $AttackArea
var direction = Vector2.ZERO
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
		direction = Vector2.RIGHT
		if attack_collision.position.x < 0:
			attack_collision.position.x *= -1
		velocity.x = speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = false

	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		if attack_collision.position.x > 0:
			attack_collision.position.x *= -1
		velocity.x = -speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = true
	else:
		$"Animated Sprite".play("idle")
	
	if not is_on_floor():
		$"Animated Sprite".play("jump")
	
	if Input.is_action_just_pressed("attack_P1"):
		attack()
		
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	attack_area.knockback_vector = set_area_knockback(velocity)
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.1)


func set_area_knockback(velocity: Vector2) -> Vector2:
	if velocity.x < 1:
		return direction
	return velocity.normalized()
	

func attack() -> void:
	attack_timer.one_shot
	attack_timer.start(0.1)
	$AttackArea/AttackCollision.disabled = false
	
	
func _on_fall_zone_body_entered(body):
	if body.name == "Player1":
		health.set_current(0)

func _on_Health_depleted() -> void:
	print("game over")
	emit_signal("player_death")

#Implement on death logic
# send through which player dies
func on_player_death() -> void:
	print("game over")
	emit_signal("player_death")


func _on_AttackDurationTimer_timeout() -> void:
	$AttackArea/AttackCollision.disabled = true

