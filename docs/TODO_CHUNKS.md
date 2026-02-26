# Quantum Project — Todo Chunks

A phased implementation plan for the Quantum board game adaptation.

---

## Chunk 1 — Project Skeleton ✅
- [x] Folder structure (`scenes/ui/`, `scenes/board/`, `scenes/dice/`, `scenes/players/`, `scenes/cards/`, `scripts/`, `assets/`, `resources/`)
- [x] Main scene (`main.tscn` — single Node3D with all elements as persistent children)
- [x] Autoloads: `TurnManager`, `GameManager`
- [x] `CardData` resource stub (fields only, no logic)

---

## Chunk 2 — Core Data / Resources ✅
- [x] `PlayerData` resource (name, color, cubes, ship position/rank)
- [x] `TileData` resource (tile ID, planet value)
- [x] `BoardConfig` resource (data-driven layout: tile grid, player count, starting positions)
- [x] `GameState` resource (players array, phase enum, round, winner, planet occupation)
- [x] 24 `TileData` stubs in `resources/tiles/` (planet values TODO from rulebook)
- [x] Layout stubs for 2-, 3-, and 4-player games in `resources/layouts/`
- [x] `GameManager` updated to use `BoardConfig` and instantiate fresh `GameState` on start
- [x] `TurnManager` decoupled from `GameManager` internals — initialised via `game_started` signal
- [x] Switch renderer to **GL Compatibility** (required for web/itch.io export)

---

## Chunk 3 — Dice System
- [ ] Dice 3D scene and roll logic
- [ ] Roll animation
- [ ] Signal output of results

---

## Chunk 4 — Board
- [ ] Board 3D scene (modular tiles, 3×3 grid of 3×3-space sectors)
- [ ] Spaces/tiles and their data
- [ ] Player token placement and movement

---

## Chunk 5 — Turn & Game Flow
- [ ] `TurnManager` logic refinement
- [ ] "Waiting for your turn" UI indicator (replaces pass-the-controller — turn flow is handled by online multiplayer in Chunk 7)
- [ ] Win condition checking

---

## Chunk 6 — UI
- [ ] HUD (scores, current player indicator)
- [ ] Menus (start screen, end screen)

---

## Chunk 7 — Online Multiplayer
- [ ] `NetworkManager` autoload — wraps `WebRTCMultiplayerPeer`, exposes `host_game()` / `join_game(room_code)`
- [ ] Signaling layer integration (gotm.io or equivalent free-tier service for WebRTC peer discovery)
- [ ] Lobby — host creates room, clients join by code, all players ready up before `start_game()` fires
- [ ] Peer-to-`PlayerData` mapping — connect peer IDs to player slots in `GameState`
- [ ] RPC layer on `GameManager` — `submit_action(move_data: Dictionary)` from clients; `sync_game_state()` broadcast from host
- [ ] `TurnManager` authority validation — reject actions from peers whose turn it is not
- [ ] "Waiting for opponent" turn UI (networked equivalent of pass-the-controller)
- [ ] Disconnect / reconnect handling

### Networking notes
- **Protocol:** WebRTC via `WebRTCMultiplayerPeer` — the only option that is both browser-compatible and truly peer-to-peer
- **ENet is not an option for web export** — browsers block raw UDP
- **WebSocket requires a relay server** — not P2P, higher latency
- **Signaling server is still required** for WebRTC peer discovery, but carries no game data — free-tier hosting is sufficient
- **Host is authoritative** — clients submit actions via `@rpc`; host validates, applies, and broadcasts updated `GameState`
- **Rendering:** Project uses GL Compatibility (set in Chunk 2) — required for Godot 4 HTML5/web export
