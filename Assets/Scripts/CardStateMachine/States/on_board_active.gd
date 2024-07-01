extends State

class_name ActiveBoardState

var on_card : bool
@export var aim_State : State

func on_enter():
	var board := get_tree().get_first_node_in_group("board")
	if board:
		card.reparent(board)
	#card.card_on_board = true
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	
	if event.is_action_pressed("LMB") and on_card and not card.has_attacked and not card.first_turn_resting and not card.disabled_card:
		#card.vida -= 1
		#card.vida_label.text = str(card.vida)
		#if card.vida == 0:
			#DeckBuild.cementerio_jugador.append(card.card_info.card_id)
			#card.queue_free()
			#print("Cementerio jugador: " + str(DeckBuild.cementerio_jugador))
		next_state = aim_State

func _on_carta_ui_mouse_entered():
	on_card = true;

func _on_carta_ui_mouse_exited():
	on_card = false
