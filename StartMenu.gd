extends Control

func _ready():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

func _on_Start_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_Quit_pressed():
	get_tree().quit()
