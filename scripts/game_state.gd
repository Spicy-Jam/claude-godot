class_name GameState
extends Resource

enum Phase { SETUP, PLAYING, ENDED }

@export var players: Array[PlayerData] = []
@export var phase: Phase = Phase.SETUP
@export var round_number: int = 0

# -1 while game is in progress; set to the winning player's index on game end.
@export var winner_index: int = -1

# Tracks which player has placed a quantum cube on each planet.
# Key:   "x,y" (string encoding of the planet's world-space Vector2i position)
# Value: player_index (int), or -1 for an unclaimed planet
@export var planet_cubes: Dictionary = {}
