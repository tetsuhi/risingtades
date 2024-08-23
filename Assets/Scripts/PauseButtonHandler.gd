extends Control

@onready var pause_menu = $"../pause_menu"
@onready var animation_player: AnimationPlayer = $"../pause_menu/AnimationPlayer"

func _on_pressed():
	
	if not get_tree().paused:
		#pause_menu.pause_panel.visible = true
		animation_player.play("menu_pausa")
		get_tree().paused = true
		
	else:
		get_tree().paused = false
		#pause_menu.pause_panel.visible = false
		animation_player.play_backwards("menu_pausa")
