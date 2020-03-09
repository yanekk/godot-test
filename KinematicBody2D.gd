extends KinematicBody2D

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP_START = "jump_start"
const ANIM_JUMP_END = "jump_end"
const ANIM_FALL_START = "fall_start"
const ANIM_FALL_END = "fall_end"

const JUMP_HEIGHT = -650;
const MAX_SPEED = 300
const SLOWDOWN_SPEED_RATIO = 0.16
const ACCELERATION_RATIO = 0.2
const MAX_GRAVITY = 600
const GRAVITY_ACCELERATION = 20;

const SLOWDOWN_SPEED = MAX_SPEED * SLOWDOWN_SPEED_RATIO
var motion = Vector2()

func _physics_process(delta):
	move()
	animate()
	
func animate():
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		$Sprite.play(ANIM_JUMP_START)
	if abs(motion.x) < SLOWDOWN_SPEED && is_on_floor():
		$Sprite.play(ANIM_IDLE)
	elif (motion.x > 0 || motion.x < 0) && is_on_floor():
		$Sprite.play(ANIM_RUN)
	elif motion.y < 0:
		$Sprite.play(ANIM_JUMP_START if abs(motion.y) > abs(JUMP_HEIGHT / 8) else ANIM_JUMP_END)
	else:
		$Sprite.play(ANIM_FALL_END if motion.y > abs(JUMP_HEIGHT / 8) else ANIM_FALL_START)
			
func move():
	if Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left"):
		motion.x = min(SLOWDOWN_SPEED, motion.x) if motion.x > 0 else max(-SLOWDOWN_SPEED, motion.x)
	
	if Input.is_action_pressed("ui_right"):
		motion.x = lerp(motion.x, MAX_SPEED, ACCELERATION_RATIO)
	elif Input.is_action_pressed("ui_left"):
		motion.x = lerp(motion.x, -MAX_SPEED, ACCELERATION_RATIO)
	elif abs(motion.x) > 0:
		motion.x = lerp(motion.x, 0, 0.1);
		
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		motion.y = JUMP_HEIGHT
		
	if Input.is_action_just_released("jump") && motion.y < 0:
		motion.y = JUMP_HEIGHT/2
		
	if(motion.y <= MAX_GRAVITY):
		motion.y += GRAVITY_ACCELERATION
	motion = move_and_slide(motion, Vector2.UP)
