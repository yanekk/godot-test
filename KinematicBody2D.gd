extends KinematicBody2D

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP = "jump"

const UP = Vector2(0, -1)
const jumpHeight = -650;
const maxSpeed = 300
const accelerationStep = 15
const gravity = 600
const gravityAccelerationStep = 20;

var motion = Vector2()

func _physics_process(delta):
	if Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left"):
		motion.x = 0

	if Input.is_action_pressed("ui_right") && motion.x != maxSpeed:
		$Sprite.flip_h = false
		motion.x += accelerationStep
		
	if Input.is_action_pressed("ui_left") && motion.x != -maxSpeed:
		$Sprite.flip_h = true
		motion.x -= accelerationStep
		
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		$Sprite.play(ANIM_JUMP)
		motion.y = jumpHeight
	
	if(motion.y <= gravity):
		motion.y += gravityAccelerationStep
		
	if motion.x == 0 && is_on_floor():
		$Sprite.play(ANIM_IDLE)
	elif (motion.x > 0 || motion.x < 0) && is_on_floor():
		$Sprite.play(ANIM_RUN)
	else:
		$Sprite.play(ANIM_JUMP)
		
	motion = move_and_slide(motion, UP)
