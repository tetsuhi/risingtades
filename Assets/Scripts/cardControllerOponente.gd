extends CardUI

#Este script hereda de cardController, sirve para las cartas controladas por el jugador2

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	on_hand_tex.texture = card_info.texture
	on_board_tex.texture = card_info.texture
	descripcion.text = card_info.effect_text
	card_owner = 1
	
	#Si la carta es activa o pasiva
	if card_info.card_type == 0 or card_info.card_type == 1:
		vida_label.text = str(card_info.life)
		vida = card_info.life
		vida_on_board.text = vida_label.text
	
	#Si la carta es activa
	if card_info.card_type == 0:
		ataque_label.text = str(card_info.damage)
		ataque = card_info.damage
		ataque_on_board.text = ataque_label.text
	
	#Si la carta es pasiva
	if card_info.card_type == 1:
		marea_label.text = str(card_info.tide_amount)
		marea = card_info.tide_amount
		marea_on_board.text = marea_label.text
	
	_animator.play("turn_card_around")

func _process(delta):
	
	#Hacer zoom en la carta solo cuando estén en la mano
	#if on_card and state_machine.current_state.name == "idleState" and not disabled_card and not is_dragged:
		#scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
		#descripcion.show()
	#else:
		#scale = scale.lerp(Vector2(1, 1), delta*30)
		#descripcion.hide()
	pass

#func _on_area_2d_mouse_entered():
	#if state_machine.current_state.name == "idleState" and not disabled_card:
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.05)
		#position.y -= 90
		#z_index = 1
		#descripcion.show()
	##on_card = true
#
#func _on_area_2d_mouse_exited():
	#if state_machine.current_state.name == "idleState" and not disabled_card:
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.05)
		#position.y += 90
		#z_index = 0
		#descripcion.hide()
	##on_card = false
