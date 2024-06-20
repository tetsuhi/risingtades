extends Control

@onready var pause_panel = $pause_panel

func _input(event):

	if event.is_action_pressed("escape") and not get_tree().paused:
		print("estoy pausado")
		pause_panel.visible = true
		get_tree().paused = true

	elif event.is_action_pressed("escape") and get_tree().paused:
		print("no estoy pausado")
		get_tree().paused = false
		pause_panel.visible = false

func _on_reanudar_boton_pressed():
	get_tree().paused = false
	pause_panel.visible = false

func _on_menu_boton_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
