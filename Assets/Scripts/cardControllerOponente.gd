extends CardUI

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	texture_rect.texture = card_info.texture

func _process(delta):
	if on_card and state_machine.current_state.name == "idleState" and not disabled_card and not is_dragged:
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	else:
		scale = scale.lerp(Vector2(1, 1), delta*30)

func _on_area_2d_mouse_entered():
	on_card = true

func _on_area_2d_mouse_exited():
	on_card = false
