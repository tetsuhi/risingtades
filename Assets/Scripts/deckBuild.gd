extends Node

var save_path = "user://save_file.save"

const MAX_CARTAS_BARAJA = 60
const MIN_CARTAS_BARAJA = 30


var barajaJugador = []
var barajaOponente = []

func _ready():
	pass #load_data()

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(barajaJugador)
	file.close()

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		barajaJugador = file.get_var()
		print(barajaJugador)
	else:
		barajaJugador = []
