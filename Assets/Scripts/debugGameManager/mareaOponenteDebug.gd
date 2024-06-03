extends Label

@onready var tide_manager = $"../../TideManager"
@onready var turn_manager = $"../../TurnManager"

func _process(delta):
	text = "Opo - Cantidad: " + str(tide_manager.mareaOponente) + ". Estado: " + str(tide_manager.estadoMareaOponente) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaOponente)
