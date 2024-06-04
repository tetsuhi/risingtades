class_name SaveSystem
extends Node

const save_path := "user://savegame.json"

var default_data = {
	"carta_id" : [],
	"carta_cantidad" : [],
	"carta_tipo" : []
}

var data = {}

func _ready():
	load_save()

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
	DeckBuild.cantidad_jugador = data["carta_cantidad"]
	DeckBuild.id_jugador = data["carta_id"]
	DeckBuild.tipo_jugador = data["carta_tipo"]
	#DeckBuild.build_deck()
