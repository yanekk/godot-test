extends KinematicBody2D

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP_START = "jump_start"
const ANIM_JUMP_END = "jump_end"
const ANIM_FALL_START = "fall_start"
const ANIM_FALL_END = "fall_end"

const UP = Vector2(0, -1)
const JUMP_HEIGHT = -650;
const MAX_SPEED = 300
const SLOWDOWN_SPEED = 50
const ACCELERATION = 15
const MAX_GRAVITY = 600
const GRAVITY_ACCELERATION = 20;

var motion = Vector2()

func _physics_process(delta):
	if Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left"):
		motion.x = min(SLOWDOWN_SPEED, motion.x) if motion.x > 0 else max(-SLOWDOWN_SPEED, motion.x)

	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	elif abs(motion.x) > 0:
		motion.x = lerp(motion.x, 0, 0.1);
		
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		$Sprite.play(ANIM_JUMP_START)
		motion.y = JUMP_HEIGHT
	
	if(motion.y <= MAX_GRAVITY):
		motion.y += GRAVITY_ACCELERATION
	
	if abs(motion.x) < SLOWDOWN_SPEED && is_on_floor():
		$Sprite.play(ANIM_IDLE)
	elif (motion.x > 0 || motion.x < 0) && is_on_floor():
		$Sprite.play(ANIM_RUN)
	elif motion.y < 0:
		if(abs(motion.y) > abs(JUMP_HEIGHT / 8)):
			$Sprite.play(ANIM_JUMP_START)
		else:
			$Sprite.play(ANIM_JUMP_END)
	else:
		if(motion.y > abs(JUMP_HEIGHT / 8)):
			$Sprite.play(ANIM_FALL_END)
		else:
			$Sprite.play(ANIM_FALL_START)
			
	motion = move_and_slide(motion, UP)
	
