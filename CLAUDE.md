# Quantum — Claude Project Instructions

## Session Transcripts

At the end of every session, when the user indicates they are wrapping up (e.g. "wrap up", "end session", "that's it for today", or similar), automatically save a transcript **without waiting to be asked**.

Transcript location: `./transcripts/` (relative to this project root, i.e. `/home/justin/Documents/AI projects/Claude/Godot AI Dice Game/transcripts/` — create the folder if it doesn't exist)

Follow the format defined in `./transcripts/TEMPLATE.md` exactly.

Filename format: `YYYY-MM-DD_brief-kebab-case-description.md`
Example: `2026-02-26_quantum-project-setup.md`

The transcript must include:
1. The full conversation as a dialogue (User prompt → Assistant summary of actions/response), in order
2. A Key Decisions table
3. Current Project State snapshot
4. Outstanding TODOs

## Project Context

- **Game:** Quantum board game adaptation (Eric Zimmerman) — 2–4 players, 3D Godot
- **Engine:** Godot 4.6, GDScript only, GL Compatibility renderer
- **Repo:** https://github.com/Spicy-Jam/claude-godot.git
- **Coding rules:** See `docs/coding-rules.md`
- **Chunk plan:** See `docs/TODO_CHUNKS.md`
