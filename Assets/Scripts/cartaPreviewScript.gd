extends Control

#Este script se usa para las cartas mostradas en los menús 'colección' y 'personaliza baraja'

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
	
	#Si se le hace click izq., añade el id de la carta a la baraja
	if event.is_action_pressed("LMB") and on_card:
		if DeckBuild.baraja_temp.size() < DeckBuild.MAX_CARTAS_BARAJA:
			DeckBuild.baraja_temp.append(card_info.card_id)
			var carta_index = DeckBuild.nombre_temp.find(card_info.card_name)
			if carta_index == -1:	#Si la carta no está en la baraja, añade su nombre al array de nombres y crea una cantidad en el array de cantidad
				DeckBuild.nombre_temp.append(card_info.card_name)
				DeckBuild.cantidad_temp.append(1)
			else:	#Si ya existía, solo actualiza la cantidad correspondiente al nombre, ambos arrays comparten posiciones
				DeckBuild.cantidad_temp[carta_index] += 1
			print("Añadido a baraja: " + card_info.card_name + ". El mazo temporal tiene ahora " + str(DeckBuild.baraja_temp.size()) + " cartas.")
		else:
			print("¡Has alcanzado el máximo de cartas en el mazo!")

	#Si se hace click dcho., se elimina la carta de la baraja  
	if event.is_action_pressed("RMB") and on_card:
		var info_eliminada = DeckBuild.nombre_temp.find(card_info.card_name)
		if info_eliminada != -1:	#Si la carta existe en la baraja, se elimina
			if DeckBuild.cantidad_temp[info_eliminada] == 1:	#Si es la última, elimina el nombre y cantidad de sus arrays
				DeckBuild.cantidad_temp.remove_at(info_eliminada)
				DeckBuild.nombre_temp.remove_at(info_eliminada)
			else: #Si no, baja la cantidad
				DeckBuild.cantidad_temp[info_eliminada] -= 1
			
			#Una vez actualizada la información, busca la primera carta en la baraja con la info de la que queremos quitar y la elimina
			var carta_eliminada = DeckBuild.baraja_temp.find(card_info.card_id)
			DeckBuild.baraja_temp.remove_at(carta_eliminada)
			

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
