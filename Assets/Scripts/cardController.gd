extends Control

class_name CardUI

#Este script sirve para las cartas del jugador1

const CARD_DELAY_SPEED = 12.0	#Delay al arrastrar la carta con el cursor

@onready var state_machine : CardStateMachine = $CardStateMachine
@onready var texture_rect = $TextureRect
@onready var nombre = $Nombre
@onready var coste = $Coste
@onready var descripcion = $Descripcion
@onready var marea_label = $Marea
@onready var vida_label = $Vida
@onready var torch_manager = $TorchManager
@onready var ataque_label = $Ataque

#Parámetros de la carta, pueden cambiar en el transcurso de la partida
var vida : int
var ataque : int
var marea : int

var card_info : cardResource	#Al crear la carta se le añade su info

var on_card : bool	#Cursor sobre la carta
var is_dragged : bool = false	#Está siendo arrastrada, para que no haga zoom cuando se arrastra con el cursor
var disabled_card : bool = false	#Carta desactivada, no se podrá interactuar con ella cuando true
var has_attacked : bool = true	#Para cartas activas, default en true porque el primer turno de ponerlas no atacan

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	texture_rect.texture = card_info.texture
	descripcion.text = card_info.effect_text
	
	#Si la carta es activa o pasiva
	if card_info.card_type == 0 or card_info.card_type == 1:
		vida_label.text = str(card_info.life)
		vida = card_info.life
	
	#Si la carta es activa
	if card_info.card_type == 0:
		ataque_label.text = str(card_info.damage)
		ataque = card_info.damage
	
	#Si la carta es pasiva
	if card_info.card_type == 1:
		marea_label.text = str(card_info.tide_amount)
		marea = card_info.tide_amount

func _process(delta):
	
	#Hacer zoom en la carta solo cuando estén en la mano
	if on_card and state_machine.current_state.name == "idleState" and not disabled_card and not is_dragged:
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
		descripcion.show()
	else:
		scale = scale.lerp(Vector2(1, 1), delta*30)
		descripcion.hide()

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
