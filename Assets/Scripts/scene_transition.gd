extends CanvasLayer

@onready var empezado : bool = false

func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.play("enter_transition")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("enter_transition")
