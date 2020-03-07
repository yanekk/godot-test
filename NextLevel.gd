extends Area2D

export(String, FILE, "*.tscn") var nextWorld

func _physics_process(delta):
	if(overlaps_body(get_node("/root/World/Hero"))):
		get_tree().change_scene(nextWorld)
		pass
