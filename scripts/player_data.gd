class_name PlayerData
extends Resource

@export var player_name: String = ""
@export var player_index: int = 0
@export var color: Color = Color.WHITE

# Quantum cubes remaining to deploy (starts at 5; placing the last one wins).
@export var cubes_remaining: int = 5

# Quantum cubes currently on the board. Reaching 0 cubes_remaining wins the game.
@export var cubes_deployed: int = 0

# Position of this player's active ship on the 9×9 world grid.
# (-1,-1) means not yet placed. Extend to Array[ShipData] in Chunk 3/4.
@export var ship_position: Vector2i = Vector2i(-1, -1)

# Current die face value of the active ship (1–6).
# Lower = more powerful in combat; higher = faster movement.
@export var ship_rank: int = 1
