extends State

class_name SpellAimState

@onready var collision := get_tree().get_first_node_in_group("collision_jugador")
@onready var puntero := get_tree().get_first_node_in_group("puntero")
@onready var mouse_pos := get_tree().get_first_node_in_group("mouse_pos")
@onready var campo_oponente := get_tree().get_first_node_in_group("boardOponente")
@onready var mano := get_tree().get_first_node_in_group("hand")
@onready var manoOpo := get_tree().get_first_node_in_group("hand_oponente")
@onready var raycast := get_tree().get_first_node_in_group("raycast")
@onready var ui_layer := get_tree().get_first_node_in_group("ui_layer")
@onready var boton_pasar_turno := get_tree().get_first_node_in_group("boton_pasar_turno")
@onready var boton_pausa := get_tree().get_first_node_in_group("boton_pausa")

@export var idle_state : State

var card_pos : Vector2
var on_card : bool

func on_enter():
	
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer)
	card.position = Vector2(get_viewport().size.x/2 - card.size.x/2, get_viewport().size.y/2 - card.size.y/2)
	
	collision.disabled = true
	boton_pasar_turno.set_disabled(true)
	boton_pausa.set_disabled(true)
	puntero.show()
	disabling_cards()

func state_process(delta):
	if puntero.points.size() == 0:
		puntero.add_point(Vector2(card.get_global_rect().position.x + card.size.x/2, card.get_global_rect().position.y + card.size.y/2))
		puntero.add_point(mouse_pos.get_global_mouse_position())
	puntero.points[0] = Vector2(card.get_global_rect().position.x + card.size.x/2, card.get_global_rect().position.y + card.size.y/2)
	puntero.points[1] = mouse_pos.get_global_mouse_position()
	raycast.position = mouse_pos.get_local_mouse_position()
	#raycast.target_position = mouse_pos.get_global_mouse_position()

func state_input(event : InputEvent):
	if event.is_action_pressed("RMB"):
		puntero.hide()
		boton_pasar_turno.set_disabled(false)
		boton_pausa.set_disabled(false)
		collision.disabled = false
		for i in mano.get_children():
			i.disabled_card = false
		for i in campo_oponente.get_children():
			i.disabled_card = true
		next_state = idle_state

	if event.is_action_pressed("LMB"):
		var collider = raycast.get_collider()
		
		if collider != null:
			var card_objective = collider.get_owner()
			if not card_objective.disabled_card:
			
				print(card_objective.card_info.card_name)
				card_objective.queue_free()

				enabling_cards()

				DeckBuild.cementerio_jugador.append(card.card_info.card_id)
				card.queue_free()
				boton_pasar_turno.set_disabled(false)
				boton_pausa.set_disabled(false)
				collision.disabled = false
				puntero.hide()
		#else:
			#enabling_cards()
#
			#collision.disabled = false
			#puntero.hide()

func disabling_cards():
	for i in mano.get_children():
		i.disabled_card = true
	for i in campo_oponente.get_children():
		i.disabled_card = false

func enabling_cards():
	for i in mano.get_children():
		i.disabled_card = false
	for i in campo_oponente.get_children():
		i.disabled_card = true

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
