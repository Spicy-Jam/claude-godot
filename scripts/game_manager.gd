extends Node

signal game_started
signal game_ended(winner_index: int)

# Assign a pre-made BoardConfig resource in the editor to choose the layout.
@export var board_config: BoardConfig

const CUBES_TO_WIN: int = 5

var state: GameState


func start_game() -> void:
	state = GameState.new()
	state.phase = GameState.Phase.PLAYING
	state.round_number = 0
	state.winner_index = -1
	state.planet_cubes = {}

	for i in board_config.player_count:
		var player := PlayerData.new()
		player.player_index = i
		player.cubes_remaining = CUBES_TO_WIN
		player.cubes_deployed = 0
		state.players.append(player)

	game_started.emit()


func check_win_condition(player_index: int) -> bool:
	return state.players[player_index].cubes_remaining <= 0


func add_cube(player_index: int) -> void:
	var player := state.players[player_index]
	player.cubes_remaining -= 1
	player.cubes_deployed += 1
	if check_win_condition(player_index):
		state.phase = GameState.Phase.ENDED
		state.winner_index = player_index
		game_ended.emit(player_index)
