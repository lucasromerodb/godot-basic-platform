extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 300
const JUMP_HEIGHT = -400

var motion = Vector2()

func _physics_process(_delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		print(motion.x)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"): 
		print(motion.x)
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
	
	if is_on_floor():
		motion.x = lerp(motion.x, 0, 0.18)
		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			

	motion = move_and_slide(motion, UP)
	pass
