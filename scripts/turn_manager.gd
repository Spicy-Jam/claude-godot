extends Node

signal turn_changed(player_index: int)

var current_player: int = 0
var actions_remaining: int = 3
var player_count: int = 0


func _ready() -> void:
	GameManager.game_started.connect(_on_game_started)


func _on_game_started() -> void:
	player_count = GameManager.board_config.player_count
	current_player = 0
	actions_remaining = 3


func advance_turn() -> void:
	current_player = (current_player + 1) % player_count
	actions_remaining = 3
	turn_changed.emit(current_player)


func use_action() -> void:
	actions_remaining -= 1
	if actions_remaining <= 0:
		advance_turn()
