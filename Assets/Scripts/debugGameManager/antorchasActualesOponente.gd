extends Label

@onready var game_manager = $"../../GameManager"

func _process(delta):
	text = "antorchas: " + str(game_manager.torch_manager.antorchasActualesOponente)
