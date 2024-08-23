extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_button_pressed() -> void:
	SceneTransition.change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
