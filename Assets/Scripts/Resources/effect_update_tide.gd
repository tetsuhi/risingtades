extends cardResource

class_name effect_update_tide

enum Execution {Start, End}

@export_group("Card Effect")
var effect_text : String
@export var execution : Execution
@export var tide_amount : int

func _ready():
	effect_text = "Modifica la marea en " + str(tide_amount) + " puntos"
	
func effect():
	return tide_amount
