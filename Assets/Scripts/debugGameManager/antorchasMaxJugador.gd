extends Label

@onready var game_manager = $"../../GameManager"

func _process(delta):
	text = "max: " + str(game_manager.torch_manager.maxAntorchas)
