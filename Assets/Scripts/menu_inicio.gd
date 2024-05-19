extends Control

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.pressed:
			get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")
