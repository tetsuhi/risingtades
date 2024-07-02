extends Control

class_name CardUI

#signal reparent_requested(which_card_ui : CardUI)
#signal make_child(which_card_ui : CardUI)
#signal consulta_antorchas(carta_coste : int)

const CARD_DELAY_SPEED = 12.0

@onready var state_machine : CardStateMachine = $CardStateMachine

@onready var texture_rect = $TextureRect
@onready var nombre = $Nombre
@onready var coste = $Coste
@onready var descripcion = $Descripcion
@onready var marea = $Marea
@onready var vida_label = $Vida
@onready var torch_manager = $TorchManager
@onready var ataque = $Ataque

var vida : int

var card_info : cardResource

var on_card : bool
var is_dragged : bool = false

var disabled_card : bool = false
#var card_on_board : bool = false
var first_turn_resting : bool = true
var has_attacked : bool = false

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	texture_rect.texture = card_info.texture
	descripcion.text = card_info.effect_text
	if card_info.card_type == 0 or card_info.card_type == 1:
		vida_label.text = str(card_info.life)
		vida = card_info.life
	
	if card_info.card_type == 0:
		ataque.text = str(card_info.damage)
	
	if card_info.card_type == 1:
		marea.text = str(card_info.tide_amount)

func _process(delta):
	
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
