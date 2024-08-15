extends State

class_name SpellDraggedStateOponente

const DRAG_MINIMUM_THRESHOLD : float = 0.05

@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")
@onready var tide_manager := get_tree().get_first_node_in_group("tide_manager")
@onready var mesa_oponente := get_tree().get_first_node_in_group("mesa_oponente")
@onready var mano_oponente := get_tree().get_first_node_in_group("hand_oponente")

@export var idle_state : State
@export var aim_state : State
#@export var torch_manager : torchManager

#@onready var torch_manager = %TorchManager

var on_board : bool = false
var minimum_drag_time_elapsed = false

func on_enter():
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
	
	print("Antorchas actuales jugador: " + str(card.torch_manager.antorchasActualesOponente))

func state_process(delta):
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	
	card.position = card.position.lerp(mousePos - card.size/2, delta * card.CARD_DELAY_SPEED)

func state_input(event : InputEvent):
	var confirm = event.is_action_released("LMB")
	var cancel = event.is_action_pressed("RMB")
	if confirm and minimum_drag_time_elapsed:
		if on_board and card.torch_manager.antorchasActualesOponente - card.card_info.card_cost >= 0:
			if card.card_info.card_type == 2:
				card.torch_manager.antorchasActualesOponente -= card.card_info.card_cost
				card.torch_manager.antorchas_actuales_oponente.text = "Antorchas: " + str(card.torch_manager.antorchasActualesOponente)
				next_state = aim_state
			elif card.card_info.card_type == 3:
				match card.card_info.card_target:
					1:	#tide
						tide_manager.marea_seleccionada == card.card_info.marea
						tide_manager.update_tide(card.card_info.tide_sum)
						card.queue_free()
					2: #hand
						pass
					3: #oponent hand
						pass
					4: #deck
						pass
					5: #graveyard
						pass 
					6: #allycreatures
						pass 
					7: #enemycreatures
						pass
		else:
			next_state = idle_state
	elif cancel:
		next_state = idle_state

func _on_detector_colision_area_entered(area):
	on_board = true

func _on_detector_colision_area_exited(area):
	on_board = false
