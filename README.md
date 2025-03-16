# 3D Action Dungeon Crawler

## 🎯 Overview

A 3D Action-Adventure game inspired by dungeon crawlers and ARPGs

Play as a knight traversing levels to get to the goal, while battling enemies, navigating mazes, and solving puzzles.

### MVP (Minimum Viable Product)

This game project should:

- Launch to a title screen, which transitions to gameplay
- Player can run on the ground in all directions, jump, attack, and hold block
- Camera will follow the player at a fixed angle
- At least one full level, with a player spawn point and a goal/end point
- Enemies that pursue the player and attack
- HUD that shows player hit points, time, and items collected

## 🖥️ Installation

### Clone the Repository

```bash
git clone https://github.com/michael-mehr/godot-study
cd godot-study
```

### Run the Project

1. Open Godot 4.4
2. Import project (`project.godot`)
3. Launch game with `F5` or the `Run Project` button

## 🎮 Controls

| Action        | Key/Mouse Input |
| ------------- | --------------- |
| Move Forward  | W               |
| Move Left     | A               |
| Move Backward | S               |
| Move Right    | D               |
| Pause         | Esc/Enter       |

## TODO

- [ ] Player
  - [ ] Model + Animation
  - [ ] Controls
    - [x] Movement/Running
    - [x] Jump
    - [ ] Attack
    - [ ] Block
  - [x] Camera
- [ ] Enemies
  - [ ] Enemy AI
    - [ ] Follow Player
    - [ ] Attack Player
  - [ ] Model + Animations
  - [ ] Despawn on death
- [ ] Level
  - [x] Player Spawn
  - [ ] General Layout
    - [ ] Greybox
    - [ ] Models/Textures
  - [ ] Goal/End
  - [ ] Enemy Spawns
- [ ] UI
  - [x] Pause Menu
    - [x] Resume Button
    - [x] Quit Button
  - [ ] HUD
  - [ ] Title Menu
- [ ] Misc.
  - [x] Pause Function

## License

[MIT](https://choosealicense.com/licenses/mit/)
