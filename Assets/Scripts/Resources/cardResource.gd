extends Resource

class_name cardResource

@export_group("Card Attributes")
@export var card_id : String
@export var card_name : String
@export var card_type : String
@export var card_target : String
@export var card_cost : int
@export var tide_bonus_end_turn : int

@export_group("Card Visuals")
@export var texture : Texture
