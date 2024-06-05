extends Control

#var card_name : String
#var card_type : String
#var card_cost : int
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
		if DeckBuild.barajaJugador.size() < DeckBuild.MAX_CARTAS_BARAJA:
			DeckBuild.barajaJugador.append(card_info.card_id)
			var carta_index = DeckBuild.nombre_cartas.find(card_info.card_name)
			if carta_index == -1:
				DeckBuild.nombre_cartas.append(card_info.card_name)
				DeckBuild.cantidad_cartas.append(1)
			else:
				DeckBuild.cantidad_cartas[carta_index] += 1
			#var nueva_carta = card_info.duplicate()
			#DeckBuild.barajaJugador.append(nueva_carta)
			#var id_carta = DeckBuild.id_jugador.find(card_info.card_id)
			#if id_carta == -1:
				#DeckBuild.id_jugador.append(card_info.card_id)
				#DeckBuild.tipo_jugador.append(card_info.card_name)
				#DeckBuild.cantidad_jugador.append(1)
			#else:
				#DeckBuild.cantidad_jugador[id_carta] += 1
			print("Añadido a baraja: " + card_info.card_name + ". El mazo tiene ahora " + str(DeckBuild.barajaJugador.size()) + " cartas.")
		else:
			print("¡Has alcanzado el máximo de cartas en el mazo!")
	#if event.is_action_pressed("RMB") and on_card:
		#var carta_eliminada = DeckBuild.tipo_jugador.find(card_info.card_name)
		#if carta_eliminada != -1:
			#if DeckBuild.cantidad_jugador[carta_eliminada] - 1 == 0:
				#DeckBuild.cantidad_jugador.remove_at(carta_eliminada)
				#DeckBuild.tipo_jugador.remove_at(carta_eliminada)
				#DeckBuild.tipo_jugador.remove_at(carta_eliminada)
			#else:
				#DeckBuild.cantidad_jugador[carta_eliminada] -= 1
			#DeckBuild.build_deck()
		#print(DeckBuild.tipo_jugador + DeckBuild.cantidad_jugador)
			

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
