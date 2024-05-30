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
			var nueva_carta = card_info.duplicate()
			DeckBuild.barajaJugador.append(nueva_carta)
			print("Añadido a baraja: " + card_info.card_name + ". El mazo tiene ahora " + str(DeckBuild.barajaJugador.size()) + " cartas.")
		else:
			print("¡Has alcanzado el máximo de cartas en el mazo!")

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
