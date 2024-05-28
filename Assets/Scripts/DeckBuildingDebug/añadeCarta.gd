extends Control

var on_card : bool = false

func _input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card:
		if DeckBuild.barajaJugador.size() == DeckBuild.MAX_CARTAS_BARAJA:
			print("¡No se pueden añadir más cartas a la baraja!")
		else:
			var nueva_carta = load("res://Assets/Scenes/CartaUI.tscn").instantiate()
			DeckBuild.barajaJugador.append(nueva_carta)
			print(DeckBuild.barajaJugador.size())
		

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
