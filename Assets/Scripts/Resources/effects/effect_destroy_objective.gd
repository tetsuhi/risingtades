extends cardResource

class_name effect_destroy_objective

#enum Execution {Start, End}

@export_group("Card Effect")
@export var effect_text : String
#@export var execution : Execution
#@export var tide_amount : int


func effect(card_objective):
	card_objective.card_death()
