extends Button

@onready var game_manager = $"../../../GameManager"

func _process(delta):
	if game_manager.turn_manager.juegaTurno != "jugador" or game_manager.estadoJuego == "fin":
		disabled = true
	else:
		disabled = false

func _on_pressed():
	if game_manager.cantidadMano < 7:
		if game_manager.cantidadBaraja != 0:
			game_manager.cantidadBaraja -= 1
			game_manager.cantidadMano += 1
			print("Robas una carta. Tienes " + str(game_manager.cantidadMano) + " cartas en la mano.")
			print("Te quedan: " + str(game_manager.cantidadBaraja) + " cartas en el mazo.")
		else:
			print("No puedes robar más cartas.")
	else:
		print("Tienes la mano completa")
