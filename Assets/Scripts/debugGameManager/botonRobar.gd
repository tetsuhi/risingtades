extends Button

@onready var game_manager = $"../../../GameManager"
@onready var baraja_manager = $"../../../GameManager/BarajaManager"

func _process(delta):
	if game_manager.turn_manager.juegaTurno != "jugador" or game_manager.estadoJuego == "fin":
		disabled = true
	else:
		disabled = false
