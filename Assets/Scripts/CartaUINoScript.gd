extends Control

@onready var texture_rect = $TextureRect
@onready var nombre = $Nombre
@onready var coste = $Coste

var card_info : cardResource

var on_card : bool

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	texture_rect.texture = card_info.texture

func _input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card:
		if DeckBuild.baraja_temp.size() < DeckBuild.MAX_CARTAS_BARAJA:
			DeckBuild.baraja_temp.append(card_info.card_id)
			var carta_index = DeckBuild.nombre_temp.find(card_info.card_name)
			if carta_index == -1:
				DeckBuild.nombre_temp.append(card_info.card_name)
				DeckBuild.cantidad_temp.append(1)
			else:
				DeckBuild.cantidad_temp[carta_index] += 1
			print("Añadido a baraja: " + card_info.card_name + ". El mazo temporal tiene ahora " + str(DeckBuild.baraja_temp.size()) + " cartas.")
		else:
			print("¡Has alcanzado el máximo de cartas en el mazo!")

	if event.is_action_pressed("RMB") and on_card:
		var info_eliminada = DeckBuild.nombre_temp.find(card_info.card_name)
		if info_eliminada != -1:
			if DeckBuild.cantidad_cartas[info_eliminada] == 1:
				DeckBuild.cantidad_cartas.remove_at(info_eliminada)
				DeckBuild.nombre_cartas.remove_at(info_eliminada)
			else:
				DeckBuild.cantidad_cartas[info_eliminada] -= 1

			var carta_eliminada = DeckBuild.barajaJugador.find(card_info.card_id)
			DeckBuild.barajaJugador.remove_at(carta_eliminada)
			

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
