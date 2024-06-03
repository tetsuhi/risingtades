extends Label

@onready var tide_manager = $"../../TideManager"
@onready var turn_manager = $"../../TurnManager"

func _process(delta):
	text = "Jug - Cantidad: " + str(tide_manager.mareaJugador) + ". Estado: " + str(tide_manager.estadoMareaJugador) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaJugador)
