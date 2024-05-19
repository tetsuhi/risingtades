extends Node

const MAX_CARTAS_MANO : int = 7

var cantidadBaraja : int = 60
var cantidadMano : int = 0

var estadoJuego : String;

@onready var turn_manager = $TurnManager
@onready var torch_manager = $TorchManager
@onready var tide_manager = $TideManager

func _ready():
	estadoJuego = "decide"
	turn_manager.determinarInicio()
	estadoJuego = "jugando"
	torch_manager.iniciarAntorchas()
	tide_manager.iniciarMareas()

func _process(delta):
	if cantidadBaraja + cantidadMano == 0:
		print("Se acabó el juego")
		get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")
		
	if turn_manager.turnosMareaVivaJugador == 3:
		print("¡Has ganado!")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")
		
	if turn_manager.turnosMareaVivaOponente == 3:
		print("¡Has perdido!")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")
