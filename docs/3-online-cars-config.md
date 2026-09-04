# Guide 3 — Tuning "All MP Vehicles in SP" (the online-cars-in-traffic system)

Mod: [All MP Vehicles in SP](https://www.gta5-mods.com/scripts/all-mp-vehicles-in-sp) by sruckstar ([source](https://github.com/sruckstar/gta5-all-mp-vehicles-in-sp)). It populates single-player Los Santos with GTA Online vehicles — rotating through **parking lots**, **class-based road sections in traffic**, and the **LS Car Meet area** (the best place to farm HSW supercars). There is no dealership and no spawn menu; the world just *has* these cars now.

The config lives at (inside the modded copy, wherever it's currently swapped in):

```
<game>\scripts\AllMpVehiclesInSp.ini
```

Edits apply live: save the ini, press **Insert** in game. No restart.

## The reference tune

Values below are the "vanilla, but sprinkled with online cars" profile — noticeably more interesting streets, nowhere near Online chaos:

```ini
[MAIN]
parking_lots_spawn = 1      ; online cars appear in parking lots
spawn_traffic = 1           ; online cars join road traffic
tuning = 1                  ; spawned cars can be tuned
tuning_hsw = 1              ; ...incl. Hao's Special Works upgrades
doors = 0                   ; locked (realistic - bring a window breaker)
blips = 0                   ; NO map blips on parked online cars
traffic_cars_blips = 0      ; NO map blips on traffic online cars
new_license_plates = 1      ; fresh plates so they don't read as "owned"
time_traffic_gen = 3000     ; ms between traffic spawn passes (3000 = mod minimum)
max_traffic_vehicles = 6    ; online cars per road section (range 1-10)

[ADVANCED]
SpawnDistance = 180.0       ; meters - spawn ring around the player
DespawnDistance = 300.0     ; meters - cleanup ring
ClearSpawnArea = 1          ; CRITICAL - see below

[PRESET]
preset = los_santos_balanced ; free presets: los_santos_balanced, lore (addons on Patreon tiers)
```

## The settings that actually matter

**`ClearSpawnArea = 1` — the invisible-spawns fix.** With `0`, spawn attempts at occupied spots silently fail; the world looks stock and you'll swear the mod does nothing. With `1`, the mod clears the spawn point before placing a car, which is what makes the whole thing visible. Leave it on.

**`max_traffic_vehicles` is your density dial.** 6 = "feels refreshed but not arcade-y". Push toward 10 for chaos streams; drop to 3–4 if streets feel crowded. Note the mod's traffic count and its parking-lot spawns are separate systems — parking density follows the preset.

**Blips stay off (`blips = 0`, `traffic_cars_blips = 0`)** unless you're deliberately hunting: flipping `traffic_cars_blips = 1` temporarily marks online cars on the map, great for finding a specific model once — then turn it back off. Permanent blips turn the map into pimple soup and kill the "it's just… there" immersion.

**`time_traffic_gen = 3000`** is the mod's minimum pass interval; it's already the aggressive end. Raising it (4000–5000) thins the stream further if you ever want that.

## Adding your own cars to the pool

Two files sit next to the ini:

- `scripts\NewVehiclesList.txt` — add **add-on cars** (vehicles installed via their own dlc pack) as `SpawnName,class` on one line, e.g. `gstghell1,muscle`. The class must be lowercase and one of: `boats, commercial, compacts, coupes, cycles, emergency, helicopters, industrial, karting, motorcycles, muscle, openwheel, offroad, planes, sedans, service, sports, sportsclassics, super, suvs, vans`. It only decides where the car spawns (which lots/road sections), not how it performs.
- `scripts\mp_blacklist.txt` — Online vehicles you never want to see, one **model name** per line (not the hash), e.g. `slamtruck`.

## Coverage over time

The mod's vehicle list is synced to whatever GTA Online update was current at the mod's release. After big Rockstar DLC drops, check the [mod page](https://www.gta5-mods.com/scripts/all-mp-vehicles-in-sp) for a version bump — new DLC cars only start appearing after the mod itself updates. Same for the game build: the modded install stays frozen (that's a feature of the split — see [guide 1](1-create-the-split.md)), so nothing breaks until *you* decide to update both.

## Stacking rule

Don't run a popgroup overhaul (Traffic Variety, WoV, etc.) on top of `spawn_traffic = 1` — two systems fighting over the same road population causes exactly the overfilled, jittery traffic people blame this mod for. Pick one system. If you want a specific dream car permanently: spawn it once with a trainer (Simple Trainer / Menyoo), drive it into a story garage, done — it's saved forever and no popgroup mod needed.

## If something looks broken

| Symptom | Check |
|---|---|
| No online cars at all | `ClearSpawnArea = 1`? SHVDN nightly (not stable)? mod DLL in `scripts\` top level? |
| Cars stacked / exploding | An old copy of the mod running in parallel — any `.dll` in a `scripts\` **subfolder** gets auto-loaded (see [guide 2's war story](2-mod-setup.md)) |
| Script won't load | `ScriptHookVDotNet.log` in game root — outdated SHVDN is the #1 cause |
| Spawned cars pause during missions | By design — the mod steps aside during story missions |
