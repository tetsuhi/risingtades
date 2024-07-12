extends State

class_name DraggedState

const DRAG_MINIMUM_THRESHOLD : float = 0.05

@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")
@onready var mesa_jugador1 := get_tree().get_first_node_in_group("mesa_jugador1")
@onready var zona_mano_jugador1 := get_tree().get_first_node_in_group("zona_mano_jugador1")

@export var idle_state : State
@export var on_board_state : State
#@export var torch_manager : torchManager

#@onready var torch_manager = %TorchManager

var on_board : bool = false
var reordering : bool = false
var minimum_drag_time_elapsed = false

func on_enter():
	var tween = get_tree().create_tween()
	tween.tween_property(card, "scale", Vector2(1.0, 1.0), 0.05)
	card.descripcion.hide()
	print(card)
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer)
	
	var torch_layer := get_tree().get_first_node_in_group("torch")
	if torch_layer:
		card.torch_manager = torch_layer
	
	on_board = false
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD,false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	
	turn_manager.reajustar_mano()

func state_process(delta):
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	
	card.position = card.position.lerp(mousePos - card.size/2, delta * card.CARD_DELAY_SPEED)

func state_input(event : InputEvent):
	var confirm = event.is_action_released("LMB")
	var cancel = event.is_action_pressed("RMB")
	if confirm and minimum_drag_time_elapsed:
		if on_board and card.torch_manager.antorchasActualesJugador - card.card_info.card_cost >= 0:
			card.torch_manager.antorchasActualesJugador -= card.card_info.card_cost
			card.torch_manager.antorchas_actuales_jugador.text = "Antorchas: " + str(card.torch_manager.antorchasActualesJugador)
			card.is_dragged = false
			next_state = on_board_state
		else:
			card.is_dragged = false
			next_state = idle_state
	elif cancel:
		card.is_dragged = false
		next_state = idle_state
	
	if reordering and not on_board:
		if event.is_action_released("LMB"):
			turn_manager.reordenar_mano(card.position)

func _on_detector_colision_area_entered(area):
	if area == mesa_jugador1:
		on_board = true
	if area == zona_mano_jugador1:
		reordering = true

func _on_detector_colision_area_exited(area):
	if area == mesa_jugador1:
		on_board = false
	if area == zona_mano_jugador1:
		reordering = false
