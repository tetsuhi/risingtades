extends cardResource

class_name active_creature

#enum Execution {Start, End}

@export_group("Card Effect")
@export var effect_text : String = "Maldito seas estado de israel"
#@export var execution : Execution
@export var tide_amount : int
@export var damage : int


#func effect():
	#return tide_amount
