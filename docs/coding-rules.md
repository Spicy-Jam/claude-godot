# Coding Rules

Conventions established during project planning. These apply to all GDScript files in this project.

---

## 1. GDScript Style & Conventions

Use **Godot 4.x GDScript 2.0** syntax throughout (typed variables, `@export`, `@onready`, etc.).

### Script Member Order

Every script must follow this order, top to bottom:

1. `class_name` — **always the first line**, even before `extends` *(exception: autoload scripts — see note below)*
2. `extends`
3. `signal` declarations
4. `@export` variables
5. `@onready` variables
6. Regular variables / constants
7. Built-in lifecycle functions (`_ready`, `_process`, etc.)
8. Public functions
9. Private functions (prefix with `_`)

```gdscript
# ✅ GOOD
class_name DiceRoller
extends Node3D

signal roll_completed(result: int)

@export var sides: int = 6

@onready var mesh: MeshInstance3D = $Mesh

var _current_value: int = 0

func _ready() -> void:
    pass

func roll() -> int:
    _current_value = randi_range(1, sides)
    roll_completed.emit(_current_value)
    return _current_value

func _calculate_result() -> int:
    return _current_value
```

> **Autoload exception:** Scripts registered as autoloads in `project.godot` (e.g. `GameManager`, `TurnManager`) do not need a `class_name` declaration. Godot makes them globally accessible by their autoload name, so adding `class_name` would create a redundant and potentially confusing duplicate identifier. All other scripts — including custom resources — must have `class_name` as line 1.

```gdscript
# ❌ BAD — extends before class_name, no types, mixed order
extends Node3D
class_name DiceRoller

var current_value
@export var sides

func roll():
    pass
```

### Typing

- Always use static types for variables, parameters, and return values
- Use `->` return type annotations on all functions

### Naming

- Variables and functions: `snake_case`
- Classes and custom resources: `PascalCase`
- Private members: prefix with `_`
- Constants: `ALL_CAPS_SNAKE_CASE`

---

## 2. Composition Over Inheritance

- Prefer building behavior by **combining child nodes** rather than extending custom classes
- Only extend built-in Godot types (e.g. `extends Node3D`, `extends Resource`)
- Avoid chains of custom class inheritance — if two classes share logic, extract it into a shared child node or a helper resource instead

```gdscript
# ✅ GOOD — compose behavior via child nodes
class_name PlayerToken
extends Node3D
# MovementComponent, AnimationComponent etc. are child nodes

# ❌ BAD — deep inheritance chain
class_name PlayerToken
extends BoardPiece  # which extends MovableObject which extends ...
```

---

## 3. Signals for Loose Coupling

- Use signals to communicate **between nodes** — never call up the tree directly
- Dice results, turn changes, and game events should all be emitted as signals
- Connect signals in `_ready()` or via the Godot editor, not scattered through gameplay logic

```gdscript
# ✅ GOOD
signal roll_completed(value: int)

func roll() -> void:
    roll_completed.emit(randi_range(1, sides))

# ❌ BAD — direct parent/sibling call
func roll() -> void:
    get_parent().get_node("TurnManager").advance_turn(randi_range(1, sides))
```

---

## 4. Folder Structure & Co-location

```
res://
├── scenes/
│   ├── ui/           # UI scenes (.tscn) and their attached scripts (.gd)
│   ├── board/        # Board scenes and attached scripts
│   ├── dice/         # Dice scenes and attached scripts
│   ├── players/      # Player token scenes and attached scripts
│   ├── cards/        # Card scenes and attached scripts
│   └── ...           # Add subfolders per functional area as needed
├── scripts/          # Global scripts, autoloads, and custom resource scripts
├── assets/
│   ├── models/
│   ├── textures/
│   ├── audio/
│   └── fonts/
├── resources/        # .tres resource files (data, themes, etc.)
└── docs/             # Planning docs, chunk summaries, and these rules
```

### Co-location Rule

- A script **attached to a scene** lives in the **same subfolder as that scene**
- A script that is a **global/autoload** or defines a **custom resource** goes in `scripts/`

```
# ✅ GOOD
scenes/ui/hud.tscn
scenes/ui/hud.gd          ← attached to hud.tscn, stays with it

scripts/turn_manager.gd   ← autoload, goes in scripts/
scripts/player_data.gd    ← custom Resource class, goes in scripts/

# ❌ BAD
scenes/ui/hud.tscn
scripts/hud.gd            ← attached script separated from its scene
```

### Scene Files

- One `.tscn` file per major game object or UI element
- Keep scene trees shallow — prefer composition via child scenes over large monolithic scenes
- Use 3D nodes (`Node3D`, `MeshInstance3D`, `CollisionShape3D`, etc.) for all visual/physical elements

---

## 5. Turn System

- A single `TurnManager` autoload manages whose turn it is
- "Pass the controller" flow — player count is driven by the active `BoardConfig` resource
- Turn progression is driven by signals, not polling
- Player state is stored as a custom `Resource` (`PlayerData`) in `scripts/`

---

## 6. Custom Resources for Data

- Use `class_name` + `extends Resource` for player data, game state snapshots, board config, etc.
- Store `.tres` files in `res://resources/`
- Global/autoload scripts and resource class definitions go in `scripts/`
