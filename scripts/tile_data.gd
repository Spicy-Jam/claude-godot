class_name TileData
extends Resource

# Matches the physical tile number printed on the board tile (1–24).
@export var tile_id: int = 0

# The sum of ship ranks (die face values) that ships in the 4 orbital spaces must
# total for a player to construct a quantum cube on this planet.
# TODO: fill in correct values per tile from the official rulebook.
@export var planet_value: int = 0
