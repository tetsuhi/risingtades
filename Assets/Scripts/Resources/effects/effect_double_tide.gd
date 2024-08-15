extends passive_creature


func effect(card):
	if card.turn_manager.juegaTurno == "jugador" and card.tide_manager.estadoMareaJugador == "alta":
		card.marea *= 2
		card.marea_on_board.text = str(card.marea)
	elif card.turn_manager.juegaTurno == "oponente" and card.tide_manager.estadoMareaOponente == "alta":
		card.marea *= 2
		card.marea_on_board.text = str(card.marea)
	print(card.marea)
