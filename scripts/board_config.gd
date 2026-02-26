class_name BoardConfig
extends Resource

# Human-readable name for this layout (e.g. "2-Player Layout 1").
@export var layout_name: String = ""

# Number of players this layout is designed for (2, 3, or 4).
@export var player_count: int = 4

# The 9 tile IDs that make up the 3×3 board, stored row-major.
# Index = row * 3 + col.  Tile at grid position (col, row) occupies world
# spaces (col*3 .. col*3+2, row*3 .. row*3+2) on the 9×9 grid.
# The planet of each tile is always at world position (col*3+1, row*3+1).
# TODO: populate from the official rulebook diagrams.
@export var tile_grid: Array[int] = []  # 9 elements

# World-space (9×9) position of each player's starting planet — where their
# first quantum cube is placed at setup.  One entry per player.
@export var player_start_planets: Array[Vector2i] = []

# World-space positions of each player's 3 starting ships, stored flat.
# Player i's ships are at indices i*3, i*3+1, i*3+2.
# TODO: populate from the official rulebook diagrams.
@export var player_start_ships: Array[Vector2i] = []
