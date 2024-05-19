extends Label

@onready var game_manager = $"../../GameManager"

func _process(delta):
	text = "Opo - Cantidad: " + str(game_manager.tide_manager.mareaOponente) + ". Estado: " + str(game_manager.tide_manager.estadoMareaOponente) + ". Turnos marea viva: " + str(game_manager.turn_manager.turnosMareaVivaOponente)
