extends State

class_name BoardState

var on_card : bool

func on_enter():
	var board := get_tree().get_first_node_in_group("board")
	if board:
		card.reparent(board)
	
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

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
