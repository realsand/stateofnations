# Project Folder Structure

- `src/client/` — Client-side scripts
  - `components/` — UI and gameplay components
  - `modules/` — Client-only modules
  - `util/` — Client utilities/helpers
  - `init.client.luau` — Main client entry point
- `src/server/` — Server-side scripts
  - `systems/` — Game systems (economy, combat, etc.)
  - `modules/` — Server-only modules
  - `util/` — Server utilities/helpers
  - `init.server.luau` — Main server entry point
- `src/shared/` — Shared code (client & server)
  - `modules/` — Shared modules
  - `components/` — Shared components
  - `util/` — Shared utilities/helpers
  - `GameState.luau`, `Hello.luau`, `UIManager.luau` — Example shared scripts
- `assets/` — Images, sounds, models, etc.
- `docs/` — Documentation
- `tests/` — Unit and integration tests
- `README.md` — Project overview
- `default.project.json`, `aftman.toml`, `rojo.cmd`, `sourcemap.json` — Project config/build files

This structure keeps code organized, scalable, and easy to navigate.