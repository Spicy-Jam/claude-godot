# Chunk 1 — Project Skeleton ✅

## What was built

### Folder structure
All required directories created under the project root:
- `scenes/ui/`, `scenes/board/`, `scenes/dice/`, `scenes/players/`, `scenes/cards/`
- `scripts/`, `assets/` (with `audio/`, `fonts/`, `models/`, `textures/`), `resources/`

### Main scene
`main.tscn` — single `Node3D` root with all persistent game elements as children.
Registered as the run/main_scene in `project.godot`.

### Autoloads
Both registered in `project.godot`:
- `GameManager` → `res://scripts/game_manager.gd`
- `TurnManager` → `res://scripts/turn_manager.gd`

`GameManager` tracks per-player cube scores and emits `game_started` / `game_ended` signals.
`TurnManager` tracks current player and actions remaining, emits `turn_changed`.

### CardData resource stub
`scripts/card_data.gd` — `class_name CardData extends Resource` with three exported fields:
- `card_name: String`
- `card_type: CardType` (enum: COMMAND, GAMBIT)
- `effect_description: String`

No logic — fields only, as intended.
