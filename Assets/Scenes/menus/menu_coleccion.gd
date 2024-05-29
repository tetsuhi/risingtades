extends Control

@onready var cardData = preload("res://Assets/Scripts/cardDataBase.gd")
@onready var CARTA_UI = preload("res://Assets/Scenes/CartaUINoScript.tscn")


var allCardInGame = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in cardData.DATA.size():
		var card_info = cardData.DATA[i]
		
		var _card := CARTA_UI.instantiate()
		add_child(_card)
		
		_card.card_name = card_info[0]
		_card.card_type = card_info[1]
		_card.card_cost = card_info[2]
		
		allCardInGame.append(_card)
	
	for i in allCardInGame.size():
		add_child(allCardInGame[i])
