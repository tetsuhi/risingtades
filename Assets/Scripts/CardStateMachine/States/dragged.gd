extends State

class_name DraggedState

const DRAG_MINIMUM_THRESHOLD : float = 0.05

@export var idle_state : State
@export var onBoard_state : State

var on_board : bool = false
var minimum_drag_time_elapsed = false

func on_enter():
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer)
	
	on_board = false
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD,false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func state_process(delta):
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	
	card.position = card.position.lerp(mousePos - card.size/2, delta * card.CARD_DELAY_SPEED)

func state_input(event : InputEvent):
	var confirm = event.is_action_released("LMB")
	var cancel = event.is_action_pressed("RMB")
	if confirm and minimum_drag_time_elapsed:
		if on_board:
			print("On Board")
			next_state = onBoard_state
	elif cancel:
		next_state = idle_state

func _on_detector_colision_area_entered(area):
	on_board = true

func _on_detector_colision_area_exited(area):
	on_board = false
