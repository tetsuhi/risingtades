extends Node

@onready var game_manager = $".."

var cantidadBarajaJugador : int = 10
var cantidadBarajaOponente : int = 10

var barajaJugador = []
var barajaOponente = []

func _ready():

	for i in range(10):
		var nueva_carta = load("res://Assets/Scenes/CartaUI.tscn").instantiate()
		barajaJugador.append(nueva_carta)
	print(barajaJugador)
	barajaJugador.shuffle()
	print(barajaJugador)
	
	for i in range(10):
		var nueva_carta = preload("res://Assets/Scenes/CartaUI.tscn").instantiate()
		barajaOponente.append(nueva_carta)
	barajaOponente.shuffle()

func robaCarta():
	if game_manager.mano_jugador.get_child_count() < 7:
		if barajaJugador.size() != 0:
			var nueva_carta = barajaJugador.pop_back()
			game_manager.mano_jugador.add_child(nueva_carta)
			print(barajaJugador.size())
