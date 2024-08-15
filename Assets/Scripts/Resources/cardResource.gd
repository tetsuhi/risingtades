extends Resource

class_name cardResource

enum CardType {Active, Pasive, Spell, Instant}
enum CardTarget {None, Tide, Hand, OponentHand, Deck, Graveyard, AllyCreatures, OponentCreatures}

@export_group("Card Attributes")
@export var card_id : String
@export var card_name : String
@export var card_type : CardType
@export var card_target : CardTarget
@export var card_cost : int

@export_group("Card Visuals")
@export var texture : Texture
