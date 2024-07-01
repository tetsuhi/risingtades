extends cardResource

class_name effect_upgrade_passive

enum Execution {Start, End}

@export_group("Card Effect")
@export var effect_text : String = "Mejoro la marea pasiva de carta aliada en +1"
@export var execution : Execution
@export var tide_amount : int


#func effect():
	#return tide_amount
