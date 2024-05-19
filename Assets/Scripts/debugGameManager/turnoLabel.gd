extends Label

@onready var game_manager = $"../../GameManager"

func _process(delta):
	if game_manager.turn_manager.juegaTurno == "Decidiendo...":
		text = game_manager.turn_manager.juegaTurno
	else:
		text = "Turno de " + game_manager.turn_manager.juegaTurno + ". Ronda " + str(game_manager.turn_manager.numTurno)
