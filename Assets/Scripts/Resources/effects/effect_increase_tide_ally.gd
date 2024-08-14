extends cardResource

class_name effect_increase_tide_ally

#enum Execution {Start, End}

@export_group("Card Effect")
@export var effect_text : String
@export var tide_increase : int
#@export var execution : Execution
#@export var tide_amount : int


func effect(card_objective):
	card_objective.marea += tide_increase
	card_objective.marea_on_board.text = str(card_objective.marea)
