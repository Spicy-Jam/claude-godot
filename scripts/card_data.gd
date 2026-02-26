class_name CardData
extends Resource

enum CardType { COMMAND, GAMBIT }

@export var card_name: String = ""
@export var card_type: CardType = CardType.COMMAND
@export var effect_description: String = ""
