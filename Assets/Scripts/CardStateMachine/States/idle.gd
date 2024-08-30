extends State

class_name IdleState

#@export var mouse_entered_state : State
@export var dragged_state : State

@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")

var on_card : bool = false;

func on_enter():
	if not card.is_node_ready():
		await card.ready
	
	var mano_jugador := get_tree().get_first_node_in_group("hand")
	if mano_jugador:
		card.reparent(mano_jugador)
		card.on_board.hide()
		card.on_hand.show()
		if card.reorder_pos != -1:
			mano_jugador.move_child(card, card.reorder_pos)
			card.reorder_pos = -1
			activate_cards_in_hand()
		turn_manager.obtener_posiciones_cartas_en_mano(0)
		turn_manager.reajustar_mano(0)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card and not card.disabled_card:
		for i in turn_manager.mano_jugador.get_child_count():
			if card == turn_manager.mano_jugador.get_child(i):
				card.reorder_pos = i
		next_state = dragged_state

func _on_carta_ui_mouse_entered():
	on_card = true

func _on_carta_ui_mouse_exited():
	on_card = false

func activate_cards_in_hand():
	for card in turn_manager.mano_jugador.get_children():
		card.disabled_card = false
