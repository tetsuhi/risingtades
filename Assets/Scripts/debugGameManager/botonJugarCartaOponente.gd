extends Button

@onready var game_manager = $"../../GameManager"
var rng = RandomNumberGenerator.new()

func _process(delta):
	if game_manager.turn_manager.juegaTurno != "oponente"  or game_manager.estadoJuego == "fin":
		disabled = true
	else:
		disabled = false

func _on_pressed():
	game_manager.tide_manager.mareaOponente += 4
	game_manager.tide_manager.estadoMareaOponente = game_manager.tide_manager.comprobarMarea(game_manager.tide_manager.mareaOponente, game_manager.tide_manager.estadoMareaOponente)
