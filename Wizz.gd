extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 300
const JUMPFORCE = -1100
const GRAVITY = 35

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = true
	else:
		$"Animated Sprite".play("idle")
	if not is_on_floor():
		$"Animated Sprite".play("jump")
		
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		
	
	
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.1)
