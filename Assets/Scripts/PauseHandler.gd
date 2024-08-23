extends Control

@onready var pause_panel = $pause_panel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _input(event):

	if event.is_action_pressed("escape") and not get_tree().paused:
		#pause_panel.visible = true
		animation_player.play("menu_pausa")
		get_tree().paused = true

	elif event.is_action_pressed("escape") and get_tree().paused:
		get_tree().paused = false
		#pause_panel.visible = false
		animation_player.play_backwards("menu_pausa")

func _on_reanudar_boton_pressed():
	get_tree().paused = false
	#pause_panel.visible = false
	animation_player.play_backwards("menu_pausa")

func _on_menu_boton_pressed():
	get_tree().paused = false
	SceneTransition.change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
