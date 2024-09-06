extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("estoy cagandoooo")

func _on_area_entered(area: Area2D) -> void:
	if Input.is_action_pressed("LMB"):
		print("me estoy limpiando")
