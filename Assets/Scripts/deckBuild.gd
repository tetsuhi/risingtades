extends Node

const MAX_CARTAS_BARAJA = 60
const MIN_CARTAS_BARAJA = 30


var barajaJugador = []
var barajaOponente = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in range(MIN_CARTAS_BARAJA):
		var nueva_carta = load("res://Assets/Cards/Creatures/Juan.tres").duplicate()
		barajaJugador.append(nueva_carta)
		
	for i in range(MIN_CARTAS_BARAJA):
		var nueva_carta = preload("res://Assets/Scenes/CartaUI.tscn").instantiate()
		barajaOponente.append(nueva_carta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
