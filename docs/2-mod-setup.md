# Guide 2 — My mod loadout (a personal recommendation — nothing here is required)

Every mod below lives on the **modded copy only** (`Grand Theft Auto V Enhanced - Modded`, or whatever folder currently holds the active name if you've already split).

> **These are *my* mods.** This is the exact loadout I personally run on my own modded copy and recommend — but it is **not part of this project and none of it is needed for the dual-swap system**. Guide 1's split works with any mods, or with a completely stock game. Treat this page as a tested example loadout: install all of it, cherry-pick, or ignore it entirely and use your own mods — the swap scripts don't care what's in the folder.

Download each from its official page — **this repo does not bundle any of them**, and re-uploading someone's mod elsewhere is both rude and against most mod sites' rules.

Reference stack this was built and tested with (GTA V Enhanced, Steam, game build 24129078): ScriptHookV build 3889, ScriptHookVDotNet 3.9.0 nightly, OpenRPF, All MP Vehicles in SP 4.0.1, Better Chases+ Enhanced 1.1.3, LemonUI, Swap Main Ride 1.6, Drive V, Full Weapon Overhaul 3.0, I.R.O Grounded, ChaosMod V.

## Layer 1 — the toolchain (install first)

### 1. ScriptHookV — [dev-c.com/gtav/scripthookv](http://www.dev-c.com/gtav/scripthookv/)
The core loader every GTA script mod needs. Grab the **Enhanced-compatible** build from Alexander Blade's page and drop `ScriptHookV.dll` into the game root. ScriptHookV is **locked to a game build** — if the game updates past it, scripts silently stop loading until SHV updates.

### 2. ScriptHookVDotNet — [github.com/scripthookvdotnet/scripthookvdotnet](https://github.com/scripthookvdotnet/scripthookvdotnet)
The .NET runtime for script mods. On GTA V Enhanced you need a **recent nightly** (API 3.6+; the reference setup runs 3.9.0) — the last stable release predates Enhanced. Install: `ScriptHookVDotNet.asi`, `ScriptHookVDotNet2.dll`, `ScriptHookVDotNet3.dll` (+ the `.ini`) into the game root. A community fork, [SHVDN Enhanced](https://github.com/Chiheb-Bacha/scripthookvdotnetenhanced), also exists if you hit issues with nightlies.
Reload script mods in-game (no restart) with **Insert**; the SHVDN console opens with **F4** (see `ScriptHookVDotNet.ini` → `ReloadKeyBinding` / `ConsoleKey`).

### 3. ASI loader
The `.asi` files need a loader DLL. The [OpenRPF](https://www.gta5-mods.com/tools/openrpf-openiv-asi-for-gta-v-enhanced) package below includes one; the generic source is [Ultimate ASI Loader](https://github.com/ThirteenAG/Ultimate-ASI-Loader) (ships as `dinput8.dll` or `xinput1_4.dll`).

### 4. OpenRPF + OpenIV — the "mods folder" system
- [OpenRPF](https://www.gta5-mods.com/tools/openrpf-openiv-asi-for-gta-v-enhanced) is the Enhanced replacement for `OpenIV.asi`: drop `OpenRPF.asi` in the game root and create a lowercase `mods\` folder. It makes the game load `.rpf` archives from `mods\` instead of the stock ones.
- [OpenIV](https://openiv.com) is the editor that installs `.oiv` packages. **When OpenIV asks where to install an OIV, always choose the `mods` folder** ("Edit mods folder"), never the game files directly — that's the difference between a reversible mod and a Steam-verify flag. (Official mods-folder explainer: [openiv.com/?p=1132](https://openiv.com/?p=1132).)

## Layer 2 — script mods (into `scripts\`)

### 5. All MP Vehicles in SP — [gta5-mods](https://www.gta5-mods.com/scripts/all-mp-vehicles-in-sp) · [GitHub](https://github.com/sruckstar/gta5-all-mp-vehicles-in-sp)
The headline act: every GTA Online vehicle spawning naturally in single player — parking lots, traffic, the LS Car Meet. Install the `.dll` into `scripts\`. Needs the SHVDN nightly (see #2). Full tuning guide: [guide 3](3-online-cars-config.md).
I run a [config-hardened fork](https://github.com/thedevmark/gta5-all-mp-vehicles-in-sp) of it: one spawner fix (a class emptied by the blacklist falls back to normal cars instead of dead lots), a tuned "Healthy Mixed Mode" default ini, and a curated blacklist (police-liveried and hover/fly vehicles removed from traffic). Same license, full credit upstream.

### 6. Better Chases+ Enhanced — [gta5-mods](https://www.gta5-mods.com/scripts/better-chases-enhanced-edition)
Overhauls police behaviour and the wanted system (roadblocks that make sense, suspects that flee on foot, arrest warrants). Port of the classic [Better Chases+](https://www.gta5-mods.com/scripts/better-chases) for Enhanced. Drop `BetterChasesPlus.Enhanced.dll` into `scripts\` and its `BetterChasesConfig.xml` next to it.

### 7. LemonUI — [github.com/LMS01/LemonUI](https://github.com/LMS01/LemonUI)
UI library Better Chases+ depends on. Put the matching `LemonUI.SHVDN3.dll` into `scripts\`.

### 8. Swap Main Ride — [gta5-mods](https://www.gta5-mods.com/scripts/swap-main-ride)
Own any car. Sit in it, press **F7**, set it as that character's main (or secondary) ride — it replaces the protagonist's stock personal vehicle with your pick, through the game's own ownership system: persistent across saves, map blip, recovery when lost, full state capture (damage, doors, windows, locks, engine), autosave while driving. Built exclusively for Enhanced; mission- and cutscene-aware. Copy `SwapMainRide.asi` to the game **root** (it's an ASI plugin, not a `scripts\` mod); `SwapMainRide.ini` generates on first run and remaps the menu key. Story Mode only — the mod states this itself.

The workflow I use: find an online car in traffic (mod #5 feeds them), tune it at a normal Los Santos Customs, press F7, Set Main Ride. That car is now *yours* — permanently, per character.

## Layer 3 — OIV archive mods (install with OpenIV into `mods\`)

### 9. Drive V — [gta5-mods](https://www.gta5-mods.com/vehicles/drive-v-realistic-driving-car-handling)
Realistic handling, traction and damage for every vehicle incl. DLC. Install the OIV via OpenIV **into the mods folder**.

### 10. Full Weapon Overhaul 3.0 — [gta5-mods](https://www.gta5-mods.com/weapons/gta5-enhanced-penetration-firerate-magsize-damage-fov-recoil-ext)
Rebalanced weapon feel (penetration, fire rates, recoil, FOV). Enhanced-compatible; OIV install, same rule: mods folder.

### 11. I.R.O (Ins4ne Ragdoll Overhaul) — [gta5-mods](https://www.gta5-mods.com/misc/i-r-o-ins4ne-ragdoll-overhaul)
Euphoria ragdoll reactions — get the **Grounded** edition for the realistic variant. OIV install.

## Layer 4 — chaos (optional, great for streaming)

### 12. ChaosMod V — [GitHub](https://github.com/gta-chaos-mod/ChaosModV) · [gta5-mods](https://www.gta5-mods.com/scripts/chaos-mod-v)
A random effect every N seconds, with Twitch-chat voting built in (`chaosmod\TwitchChatVotingProxy.exe`). Ships `ChaosMod.asi` + `MinHook.x64.dll` at the root and its data in `chaosmod\`.

## Two war stories (learn from our pain)

### Cars spawning on top of each other and exploding
Symptom: online cars materializing inside each other at parking spots and in traffic, physics explosions everywhere. Cause: **SHVDN nightlies scan `scripts\` recursively** — an old version of the mod parked in `scripts\backup-4.0.0\` was loaded as a *second live copy*, so two spawners ran simultaneously. The SHVDN log showed the smoking gun: `Started script SpawnMP` *and* `Started script SpawnMP1`.
Rule: **never keep any `.dll` in a subfolder of `scripts\`.** Old versions, backups, "disabled" mods — park them outside the game folder entirely. Check with:
```bat
dir /s /b "<game>\scripts\*.dll"
```
…which should only list DLLs sitting directly in `scripts\`.

### A sound mod Steam had to un-mod
If an OIV package was ever installed against the real game files instead of the `mods` folder, the stock `.rpf`s stop matching Steam's hashes. Our split's verify step caught exactly that: two stock audio archives were non-factory and got re-downloaded (~88 MB, `result No Error`). That's the system working — but it's also why the vanilla folder must never be the modded one. Keep OIV installs pointed at `mods\` and the two worlds never collide.

## Daily driver cheatsheet

| Task | How |
|---|---|
| Reload script mods after editing an `.ini` | in game, press **Insert** |
| Open SHVDN console (see what loaded) | **F4** |
| Check what loaded | `ScriptHookVDotNet.log` in the game root |
| Find mod configs | `scripts\*.ini`, `scripts\*.xml` — they live **inside the modded copy**, wherever it's currently swapped |

→ Next: [guide 3 — tuning the online-cars spawner](3-online-cars-config.md)
