extends Node

@onready var torch_manager = $"../TorchManager"
@onready var tide_manager = $"../TideManager"
@onready var mano_jugador = %Mano

var numTurno : int = 0
var juegaTurno : String
var turnosMareaVivaJugador : int = 0
var turnosMareaVivaOponente : int = 0

func determinarInicio():
	DeckBuild.barajaJugador.shuffle()
	DeckBuild.barajaOponente.shuffle()
	numTurno = 1
	juegaTurno = "Decidiendo..."
	await get_tree().create_timer(2.0).timeout
	var rng = RandomNumberGenerator.new()
	if rng.randi_range(0, 1) == 0:
		juegaTurno = "jugador"
		esTurnoJugador()
	else:
		juegaTurno = "oponente"
		esTurnoOponente()

func esTurnoOponente():
	if tide_manager.estadoMareaOponente == "viva":
		turnosMareaVivaOponente += 1
	print("La marea del oponente está " + tide_manager.comprobarMarea(tide_manager.mareaOponente, tide_manager.estadoMareaOponente))
	await get_tree().create_timer(2.0).timeout
	finalizaTurno()
	
func esTurnoJugador():
	robaCartaJugador()
	if tide_manager.estadoMareaJugador == "viva":
		turnosMareaVivaJugador += 1
	print("La marea del jugador está " + tide_manager.comprobarMarea(tide_manager.mareaJugador, tide_manager.estadoMareaJugador))

func finalizaTurno():
	if juegaTurno == "jugador":
		numTurno += 1
		if numTurno % 2 != 0 and numTurno != 1:
			torch_manager.subeMaximo()
		torch_manager.restauraAntorchasOponente()
		juegaTurno = "oponente"
		esTurnoOponente()

	elif juegaTurno == "oponente":
		numTurno += 1
		if numTurno % 2 != 0 and numTurno != 1:
			torch_manager.subeMaximo()
		torch_manager.restauraAntorchasJugador()
		juegaTurno = "jugador"
		esTurnoJugador()

func robaCartaJugador():
	if mano_jugador.get_child_count() < 7:
		if DeckBuild.barajaJugador.size() != 0:
			var nueva_carta = DeckBuild.barajaJugador.pop_back()
			mano_jugador.add_child(nueva_carta)
			print(DeckBuild.barajaJugador.size())
