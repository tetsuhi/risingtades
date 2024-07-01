extends Control

@onready var pause_panel = $"../pause_menu/pause_panel"

func _on_pause_button_pressed():
	
	if not get_tree().paused:
		print("estoy pausado")
		pause_panel.visible = true
		get_tree().paused = true
		
	else:
		print("no estoy pausado")
		get_tree().paused = false
		pause_panel.visible = false
