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
@onready var torch_manager = $TorchManager


var card_info : cardResource

var on_card : bool

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	texture_rect.texture = card_info.texture

func _process(delta):
	
	if on_card and state_machine.current_state.name == "idleState":
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	elif not on_card:
		scale = scale.lerp(Vector2(1, 1), delta*30)

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
