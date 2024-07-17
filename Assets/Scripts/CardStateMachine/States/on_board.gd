extends State

class_name BoardState

var on_card : bool
@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")

func on_enter():
	var board := get_tree().get_first_node_in_group("board")
	if board:
		card.reparent(board)
		if card.reorder_pos != -1:
			board.move_child(card, card.reorder_pos)
			card.reorder_pos = -1
			activate_cards_in_board()
		turn_manager.reajustar_mesa()
	card.on_hand.hide()
	card.on_board.show()
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	#if event.is_action_pressed("LMB") and on_card and not card.disabled_card:
		#if card.vida - 1 == 0:
			#DeckBuild.cementerio_oponente.append(card.card_info.card_id)
			#card.queue_free()
		#card.vida -= 1
		#card.vida_label.text = str(card.vida)
	pass

func _on_carta_ui_mouse_entered():
	on_card = true

func _on_carta_ui_mouse_exited():
	on_card = false

func activate_cards_in_board():
	for card in turn_manager.campo_jugador1.get_children():
		card.disabled_card = false
