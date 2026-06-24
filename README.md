# HCI VR Experience

This project is a Godot 4.5 VR prototype (OpenXR) in which the player moves through multiple emotional scenes.  
The experience combines physical interaction (controllers, picking up objects, pumping a balloon) with atmosphere transitions and short tasks.

## What this project does at a high level

The player follows a fixed scene flow:

1. **StartScene**  
   Introductory text and instructions. The player holds the trigger to continue.
2. **JumpScareScene**  
   A tense environment with jump-scare elements and a short balls/bucket task.
3. **BetweenScene**  
   An intermission page with explanatory text and trigger-hold to continue.
4. **NatureScene**  
   A calm nature experience with audio/visual atmosphere.
5. **PartyScene**  
   A playful finale where the player pumps a balloon until it pops.
6. **EndScene**  
   Closing message, followed by application exit.

## Main technical setup

- **Engine & XR**
  - Godot 4.5 with OpenXR.
  - `Scripts/Viewport.gd` enables XR and passthrough.
  - `addons/godot-xr-tools` provides hand/controller and interaction components.

- **Autoloads (global managers)**
  - `Scripts/UDPManager.gd`: central event source (`message_received`) for events such as `"OPEN"`.
  - `Scripts/SceneManager.gd`: stores temporary transition data such as `between_text` and `next_scene`.
  - `Scenes/FadeCanvas.tscn` + `Scripts/fade_canvas.gd`: global fade-in/fade-out and scene transitions.

- **Scene control**
  - Each main scene has its own script logic in `Scripts/`.
  - Transitions happen through `FadeCanvas` and/or `SceneManager` values.
  - In multiple scenes, the right trigger is used as a “hold to continue” mechanic.

- **Interaction**
  - Object interaction and grabbing are handled through XR Tools in `Scenes/Player.tscn`.
  - In the party scene, `Scripts/PartyController.gd` controls balloon growth, the pop moment, confetti, and character animation.

## Main folders

- `Scenes/` – all Godot scenes (`.tscn`)
- `Scripts/` – GDScript logic
- `Assets/` and `Meshes/` – models, textures, audio, and other assets
- `addons/` – external plugins (including `godot-xr-tools`)
- `project.godot` – main project configuration

## Note

In the current version, `"OPEN"` events are simulated through keyboard input in `UDPManager` (key `0`).  
This appears to be intended as a temporary trigger/test path for external input (e.g., hardware integration).
