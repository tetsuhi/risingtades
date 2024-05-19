extends Label

@onready var game_manager = $"../../GameManager"

func _process(delta):
	text = "Jug - Cantidad: " + str(game_manager.tide_manager.mareaJugador) + ". Estado: " + str(game_manager.tide_manager.estadoMareaJugador) + ". Turnos marea viva: " + str(game_manager.turn_manager.turnosMareaVivaJugador)
