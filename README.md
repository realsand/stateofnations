# State of Nations

A Roblox prototype focused on nation-level simulation gameplay.

## Prototype scope
This README is based on the Trello prototype list from the Worldforum board: [Cards for prototype](https://trello.com/b/LsdAt3Ok/worldforum).

### Core prototype instructions
1. Countries
   - Define the playable countries for the simulation.
2. Country Statistics
   - Track core nation stats such as GDP, unemployment, immigration, and approval.
   - These stats are modified by bills and read by elections.
3. Player Statistics
   - Track which country each player controls, current approval, and bills passed.
   - Use this data to tie player actions to game outcomes.
4. Time
   - Implement a game clock where 1 year equals 8 minutes.
   - The clock should drive elections, bill timers, and events.
5. Bill customization
   - Allow the player to customize bills as the primary action.
   - Keep scope minimal for the prototype with a small set of bill types that each change 1-2 stats.
6. Single active bill pacing
   - Restrict the player to one active bill at a time.
   - Bills should take time to complete so the player must plan ahead.
7. Elections
   - Add an election feedback loop that responds to country stats.
   - Results should clearly show how bill changes affect the nation.

## Getting started
To build the place from scratch, use:

```bash
rojo build -o "State of Nations.rbxlx"
```

Then open `State of Nations.rbxlx` in Roblox Studio and start the Rojo server:

```bash
rojo serve
```

## Notes
- This project uses [Rojo](https://rojo.space) to sync `src/` with the Roblox place hierarchy.
- Keep the prototype focused on core gameplay flow before adding extra polish.
