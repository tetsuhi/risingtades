extends GridContainer

@onready var cardData = preload("res://Assets/Scripts/cardDataBase.gd")
@onready var carta_ui = preload("res://Assets/Scenes/cartaPreview.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in DeckBuild.baraja_temp.size():
		var resourcePath = cardData.DATA[DeckBuild.baraja_temp[i]]
		var cardInfo = load(resourcePath)
		var _card = cardInfo.duplicate()
		var nueva_carta = carta_ui.instantiate()
		nueva_carta.card_info = _card
		add_child(nueva_carta)
