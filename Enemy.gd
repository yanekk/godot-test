extends KinematicBody2D

var velocity = Vector2()
var speed = 50
const MAX_GRAVITY = 600
const GRAVITY_ACCELERATION = 20;

func _ready():
	$Sprite.play("default")
	velocity.x = -speed
	$Sprite.flip_h = true
	
func _physics_process(delta):
	if(velocity.y <= MAX_GRAVITY):
		velocity.y += GRAVITY_ACCELERATION
		
	if(is_on_wall()):
		velocity.x *= -1
		$Sprite.flip_h = !$Sprite.flip_h
	velocity.y = move_and_slide(velocity, Vector2.UP).y

func _on_StompDetector_body_entered(body):
	var bodyGlobalPosition = body.global_position
	var stopDetectorGlobalPosition = get_node("StompDetector").global_position
	print(bodyGlobalPosition.y, " ", stopDetectorGlobalPosition.y)
	if(body.global_position.y > get_node("StompDetector").global_position.y):
		return
	queue_free()
