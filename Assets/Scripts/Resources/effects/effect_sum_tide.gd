extends cardResource

class_name effect_sum_tide

enum marea_afectada {Jugador1, Jugador2}

@export_group("Card Effect")
@export var effect_text : String
@export var tide_sum : int
@export var marea : marea_afectada
