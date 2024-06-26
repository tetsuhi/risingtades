extends Resource

class_name cardResource

enum CardType {Active, Pasive, Spell}
enum CardTarget {None, Single, Multi, Global}

@export_group("Card Attributes")
@export var card_id : String
@export var card_name : String
@export var card_type : CardType = CardType.Active
@export var card_target : CardTarget = CardTarget.None
@export var card_cost : int

@export_group("Card Visuals")
@export var texture : Texture
