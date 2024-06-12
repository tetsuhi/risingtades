class_name SaveSystem
extends Node

const save_path := "user://savegame.json"

var default_data = {
	"baraja1" : {
		"baraja_jugador" = [],
		"carta_cantidad" = [],
		"carta_nombre" = []
	},
	
	"baraja2" : {
		"baraja_jugador" = [],
		"carta_cantidad" = [],
		"carta_nombre" = []
	},
	
	"baraja_seleccionada" : 0
}

var data = {}

func _ready():
	load_save()
	print(data)

func load_save():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = file.get_as_text()
		var _json = JSON.new()
		data = JSON.parse_string(content)
		load_deck()
		file.close()
	else:
		reset_data()
		print("No hay datos de guardado")
		return

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var _json = JSON.new()
	file.store_line(JSON.stringify(data))
	file.close()

func reset_data():
	data = default_data.duplicate(true)

func load_deck():
	DeckBuild.baraja_jugador1 = data.baraja1.baraja_jugador
	DeckBuild.cantidad_cartas1 = data.baraja1.carta_cantidad
	DeckBuild.nombre_cartas1 = data.baraja1.carta_nombre
	
	DeckBuild.baraja_jugador2 = data.baraja2.baraja_jugador
	DeckBuild.cantidad_cartas2 = data.baraja2.carta_cantidad
	DeckBuild.nombre_cartas2 = data.baraja2.carta_nombre
	
	DeckBuild.baraja_seleccionada = data.baraja_seleccionada
