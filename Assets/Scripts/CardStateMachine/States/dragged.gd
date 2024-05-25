extends State

class_name DraggedState

const DRAG_MINIMUM_THRESHOLD : float = 0.05

@export var idle_state : State
@export var onBoard_state : State

var on_board : bool = false
var minimum_drag_time_elapsed = false

func on_enter():
	initial_position = card.position
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
		card.position = initial_position
		next_state = idle_state

func _on_detector_colision_area_entered(area):
	on_board = true

func _on_detector_colision_area_exited(area):
	on_board = false
