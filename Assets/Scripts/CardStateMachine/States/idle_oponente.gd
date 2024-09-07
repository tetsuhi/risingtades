extends State

class_name IdleStateOponente

@export var dragged_state : State
#@export var on_board_state : State
@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")

var on_card : bool = false;

func on_enter():
	if not card.is_node_ready():
		await card.ready
	
	var mano_jugador2 := get_tree().get_first_node_in_group("hand_oponente")
	if mano_jugador2:
		card.reparent(mano_jugador2)
		card.on_board.hide()
		card.on_hand.show()
		if card.reorder_pos != -1:
			mano_jugador2.move_child(card, card.reorder_pos)
			card.reorder_pos = -1
			activate_cards_in_hand()
		turn_manager.obtener_posiciones_cartas_en_mano(1)
		turn_manager.reajustar_mano(1)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card and not card.disabled_card:
		for i in turn_manager.mano_jugador2.get_child_count():
			if card == turn_manager.mano_jugador2.get_child(i):
				card.reorder_pos = i
		next_state = dragged_state

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false

func activate_cards_in_hand():
	for card in turn_manager.mano_jugador2.get_children():
		card.disabled_card = false
