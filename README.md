# HCI VR Ervaring

Dit project is een Godot 4.5 VR-prototype (OpenXR) waarin de speler door meerdere emotionele scènes gaat.  
De ervaring combineert fysieke interactie (controllers, objecten oppakken, ballon pompen) met sfeerovergangen en korte opdrachten.

## Wat dit project doet in grote lijnen

De speler doorloopt een vaste flow van scènes:

1. **StartScene**  
   Introductieteksten en instructies. De speler houdt de trigger ingedrukt om verder te gaan.
2. **JumpScareScene**  
   Spannende omgeving met jumpscare-elementen en een korte opdracht met ballen/bucket.
3. **BetweenScene**  
   Tussenpagina met uitlegtekst en trigger-hold om door te gaan.
4. **NatureScene**  
   Rustige natuurervaring met audio/visual sfeer.
5. **PartyScene**  
   Speelse finale waarin de speler een ballon pompt tot deze knapt.
6. **EndScene**  
   Afsluitende boodschap, daarna afsluiten van de applicatie.

## Belangrijkste technische opzet

- **Engine & XR**
  - Godot 4.5 met OpenXR.
  - `Scripts/Viewport.gd` zet XR en passthrough op.
  - `addons/godot-xr-tools` levert hand/controllers en interactiecomponenten.

- **Autoloads (globale managers)**
  - `Scripts/UDPManager.gd`: centrale eventbron (`message_received`) voor o.a. `"OPEN"`.
  - `Scripts/SceneManager.gd`: bewaart tijdelijke overgangsdata zoals `between_text` en `next_scene`.
  - `Scenes/FadeCanvas.tscn` + `Scripts/fade_canvas.gd`: globale fade-in/fade-out en scenewissels.

- **Scènebesturing**
  - Elke hoofdscene heeft eigen scriptlogica in `Scripts/`.
  - Overgangen gebeuren via `FadeCanvas` en/of `SceneManager`-waarden.
  - In meerdere scènes wordt de rechter trigger gebruikt als “hold to continue”-mechanisme.

- **Interactie**
  - Objectinteractie en oppakken via XR Tools in `Scenes/Player.tscn`.
  - In de party-scène stuurt `Scripts/PartyController.gd` de ballon-groei, popmoment, confetti en karakteranimatie.

## Mappen op hoofdlijnen

- `Scenes/` – alle Godot scènes (`.tscn`)
- `Scripts/` – GDScript logica
- `Assets/` en `Meshes/` – modellen, textures, audio en andere assets
- `addons/` – externe plugins (waaronder `godot-xr-tools`)
- `project.godot` – hoofdconfiguratie van het project

## Opmerking

In de huidige versie worden `"OPEN"` events gesimuleerd via toetsenbordinput in `UDPManager` (toets `0`).  
Dit lijkt bedoeld als tijdelijke trigger/testpad voor externe input (bijv. hardware-integratie).
