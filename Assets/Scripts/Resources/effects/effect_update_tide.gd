extends passive_creature

class_name effect_update_tide

enum Execution {Start, End}

@export_group("Card Effect")
#@export var effect_text : String = "Modifica la marea en " + str(tide_amount) + " puntos"
@export var execution : Execution
#@export var tide_amount : int
#
#
#func effect():
	#return tide_amount
