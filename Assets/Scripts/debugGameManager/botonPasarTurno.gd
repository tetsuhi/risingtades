extends Button

@onready var game_manager = $"../../GameManager"

func _process(delta):
	if game_manager.turn_manager.juegaTurno != "jugador" or game_manager.estadoJuego == "fin":
		disabled = true
	else:
		disabled = false

func _on_pressed():
	game_manager.turn_manager.finalizaTurno()
