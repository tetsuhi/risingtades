extends Button

@onready var game_manager = $"../../GameManager"
var rng = RandomNumberGenerator.new()

func _process(delta):
	if game_manager.turn_manager.juegaTurno != "jugador" or game_manager.estadoJuego == "fin":
		disabled = true
	else:
		disabled = false

func _on_pressed():
	if game_manager.cantidadMano != 0:
		print("Juego una carta")
		game_manager.cantidadMano -= 1
		print("Te quedan: " + str(game_manager.cantidadMano) + " cartas en la mano.")
		game_manager.tide_manager.mareaJugador += 4
		print("Tu marea cambia en " + str(game_manager.tide_manager.mareaJugador) + " puntos.")
		print("Tu marea: " + str(game_manager.tide_manager.mareaJugador))
		game_manager.tide_manager.estadoMareaJugador = game_manager.tide_manager.comprobarMarea(game_manager.tide_manager.mareaJugador, game_manager.tide_manager.estadoMareaJugador)
		print("La marea se encuentra en el estado: " + game_manager.tide_manager.estadoMareaJugador)
	else:
		print("No te quedan cartas en la mano. ¡Roba!")
