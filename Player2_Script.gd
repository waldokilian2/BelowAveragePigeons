extends KinematicBody2D

var velocity = Vector2(0,0)
var speed = 500
var lives = 3
const JUMPFORCE = -1100
const GRAVITY = 35

func _physics_process(delta):
	if Input.is_action_pressed("sprint"):
		speed = 800
	else:
		speed = 500
		
	if Input.is_action_pressed("move_right_P2"):
		velocity.x = speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = false
	elif Input.is_action_pressed("move_left_P2"):
		velocity.x = -speed
		$"Animated Sprite".play("walk")
		$"Animated Sprite".flip_h = true
	else:
		$"Animated Sprite".play("idle")
	if not is_on_floor():
		$"Animated Sprite".play("jump")
	
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump_P2") and is_on_floor():
		velocity.y = JUMPFORCE
		
	
	
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.1)


func _on_fall_zone_body_entered(body):
	if body.name == "Player2":
		if lives > 0:
			lives-=1
			position = Vector2(1600,60)
			print(lives)
		else:
			print("Game over")
