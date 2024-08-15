extends cardResource

class_name active_creature

enum Execution {Start, End, OnPlay}

@export_group("Card Effect")
@export var effect_text : String = "Maldito seas estado de israel"
@export var execution : Execution
@export var damage : int
@export var life : int
