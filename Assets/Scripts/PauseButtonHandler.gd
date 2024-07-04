extends Control

@onready var pause_menu = $"../pause_menu"

func _on_pressed():
	
	if not get_tree().paused:
		pause_menu.pause_panel.visible = true
		get_tree().paused = true
		
	else:
		get_tree().paused = false
		pause_menu.pause_panel.visible = false
