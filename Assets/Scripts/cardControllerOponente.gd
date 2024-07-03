extends CardUI

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	texture_rect.texture = card_info.texture
	descripcion.text = card_info.effect_text
	if card_info.card_type == 0 or card_info.card_type == 1:
		vida_label.text = str(card_info.life)
		vida = card_info.life
	
	if card_info.card_type == 0:
		ataque_label.text = str(card_info.damage)
		ataque = card_info.damage
	
	if card_info.card_type == 1:
		marea_label.text = str(card_info.tide_amount)
		marea = card_info.tide_amount
	

func _process(delta):
	if on_card and state_machine.current_state.name == "idleState" and not disabled_card and not is_dragged:
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	else:
		scale = scale.lerp(Vector2(1, 1), delta*30)

func _on_area_2d_mouse_entered():
	on_card = true

func _on_area_2d_mouse_exited():
	on_card = false
