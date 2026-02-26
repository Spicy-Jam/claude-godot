# Chunk 2 — Core Data / Resources ✅

## What was built

### docs/ folder
- `docs/` directory created at project root
- `TODO_CHUNKS.md` moved here from the project root
- `chunk_01.md` and `chunk_02.md` (this file) added as implementation summaries

### New resource scripts

**`scripts/tile_data.gd`** — `class_name TileData extends Resource`
- `tile_id: int` — matches the physical tile number (1–24)
- `planet_value: int` — sum of ship ranks required to construct a cube here
- TODO markers for planet_value; to be filled from the rulebook

**`scripts/player_data.gd`** — `class_name PlayerData extends Resource`
- `player_name`, `player_index`, `color`
- `cubes_remaining: int` — starts at 5; placing last cube wins
- `cubes_deployed: int` — cubes currently on the board
- `ship_position: Vector2i` — active ship on the 9×9 world grid (-1,-1 = not placed)
- `ship_rank: int` — current die face (1–6); stub for multi-ship support in Chunk 3/4

**`scripts/board_config.gd`** — `class_name BoardConfig extends Resource`
- `layout_name`, `player_count`
- `tile_grid: Array[int]` — 9 tile IDs, row-major, defining the 3×3 board
- `player_start_planets: Array[Vector2i]` — per-player starting planet (world coords)
- `player_start_ships: Array[Vector2i]` — 3 starting ships per player, flattened

**`scripts/game_state.gd`** — `class_name GameState extends Resource`
- `players: Array[PlayerData]`
- `phase: Phase` enum (SETUP / PLAYING / ENDED)
- `round_number: int`, `winner_index: int` (-1 = in progress)
- `planet_cubes: Dictionary` — "x,y" → player_index (-1 = unclaimed)

### Pre-made resources

**`resources/tiles/tile_01.tres` … `tile_24.tres`** — TileData stubs for all 24 physical tiles.
Planet values set to 0 with TODO markers; populate from the official rulebook.

**`resources/layouts/layout_2p_1.tres`** — 2-player layout 1 stub
**`resources/layouts/layout_3p_1.tres`** — 3-player layout 1 stub
**`resources/layouts/layout_4p_1.tres`** — 4-player layout 1 stub
All have placeholder tile_grid values and approximate starting positions.
TODO markers indicate fields to populate from the official rulebook diagrams.

### Modified scripts

**`scripts/game_manager.gd`**
- Added `@export var board_config: BoardConfig` (assign layout in editor)
- Added `var state: GameState`
- `start_game()` now instantiates a fresh `GameState` and builds a `PlayerData` array
  sized to `board_config.player_count`
- `add_cube()` / `check_win_condition()` now operate on `state.players`

**`scripts/turn_manager.gd`**
- Removed hardcoded `PLAYER_COUNT = 4`
- Stores its own `player_count` var; initialised by listening to `GameManager.game_started` signal in `_ready()`
- `advance_turn()` uses only local state — no direct reference to `GameManager` internals

## Board coordinate system
- Full playfield: 9×9 orthogonal grid (Vector2i, 0–8 on each axis)
- Tile at grid position (col, row) → world spaces (col×3 … col×3+2, row×3 … row×3+2)
- Planet of each tile always at world position (col×3+1, row×3+1)
- Orbital spaces (valid cube-construction positions): the 4 orthogonal neighbors of the planet
- Movement and adjacency: orthogonal only ("next to" = 4 cardinal neighbors)
