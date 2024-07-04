extends Control

func _input(event):
	
	#Pulsa cualquier botón para empezar
	if event is InputEventKey or event is InputEventMouseButton:
		if event.pressed:
			get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
