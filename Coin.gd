extends Area2D

func _ready():
	$Sprite.play("default")
	pass # Replace with function body.

func _process(delta):
	if(overlaps_body(get_node("/root/World/Hero"))):
		queue_free()
		get_node("/root/World/Hero/Coin_Counter").increase_coin_count()
