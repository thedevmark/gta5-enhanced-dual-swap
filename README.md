# GTA V Enhanced — Vanilla + Modded Dual Install with One-Click Swap (Steam)

Keep **two full installs** of GTA V Enhanced side by side on one Steam account:

- a **100% clean, Steam-verified vanilla** copy — the only one you ever take into GTA Online (BattlEye enabled, launch options blank);
- a **fully modded** copy for Story Mode — whatever mods you like (mine, documented below: online cars in traffic, handling/weapon/ragdoll overhauls, smarter police chases, ChaosMod).

Switch between them with a double-click, in under a second.

## Why the swap method exists

The Steam version of GTA V Enhanced **refuses to start from a double-click**. Run `GTA5_Enhanced.exe` directly and you get:

```
ERR_NO_LAUNCHER — Please run Grand Theft Auto V using Rockstar Games Launcher.
```

The exe only starts through the **Steam → Rockstar launcher chain**, and Steam always launches whatever folder is named `Grand Theft Auto V Enhanced` in your Steam library. So the trick is not to launch the modded copy directly at all — instead, **swap which physical folder holds that name**:

```
D:\...\steamapps\common\Grand Theft Auto V Enhanced            <- ACTIVE (the one Steam launches)
D:\...\steamapps\common\Grand Theft Auto V Enhanced - Modded   <- parked modded copy
D:\...\steamapps\common\Grand Theft Auto V Enhanced - Vanilla  <- parked clean copy
```

Renaming a folder on the same drive is instant — no copying, no junctions, no second Steam entry, no Rockstar account tricks. The scripts in [`switch/`](switch/) do the two renames safely, refuse to run while the game is open, detect which side is active (by checking for `ScriptHookV.dll`), and roll back if anything fails.

## What's in this repo (and what is deliberately NOT)

**Included** — all original work, MIT-licensed:
- `switch/` — the folder-swap scripts + a Steam verify utility + a one-line config file
- `docs/` — guide 1 (creating the split — the core method), guide 2 (my personal mod loadout, documented as a recommendation), and guide 3 (tuning the online-cars mod)

**Not included, ever:**
- No game files, no Rockstar/Take-Two assets, no saves
- No mod files. Every mod below belongs to its author and must be downloaded from its official page (linked throughout). This repo links, it does not bundle — that keeps it clean for everyone, including the mod authors.

## Quick start

**Already have a modded install?** Follow [docs/1-create-the-split.md](docs/1-create-the-split.md) to split it into vanilla + modded (~30 min, mostly unattended), then:

1. Copy the three `.bat` files from `switch/` anywhere convenient (a desktop folder works well).
2. Edit `config.bat` so `GTA_BASE` points at your Steam library's `steamapps\common` folder.
3. To play **modded Story Mode**: quit GTA V completely → run `Switch to MODDED (Story Mode).bat` → press **Play** in Steam.
4. To play **Online**: quit GTA V completely → run `Switch to VANILLA (Online Safe).bat` → press **Play** in Steam.

**Starting fresh?** Install the game, add whatever mods you want — my recommended loadout is in [docs/2-mod-setup.md](docs/2-mod-setup.md), or use your own — *then* split it with guide 1.

## My mod loadout — a personal recommendation, NOT part of this project

**The dual-swap system is mod-agnostic.** It just swaps folders — it doesn't know or care what's inside them, and it works with any mods, or with a completely unmodded game. The table below is the loadout **I personally run on my own modded copy and recommend**; it is not required for the split, not bundled here, and nothing breaks if you swap things in or out. Every row links to the mod's official page:

| Component | What it does | Official source |
|---|---|---|
| ScriptHookV | ASI/script loader core | [dev-c.com](http://www.dev-c.com/gtav/scripthookv/) |
| ScriptHookVDotNet (nightly) | .NET script runtime | [GitHub](https://github.com/scripthookvdotnet/scripthookvdotnet) |
| OpenRPF | `mods` folder loader for Enhanced | [gta5-mods](https://www.gta5-mods.com/tools/openrpf-openiv-asi-for-gta-v-enhanced) |
| OpenIV | installs `.oiv` packages | [openiv.com](https://openiv.com) |
| All MP Vehicles in SP 4.0.1 | **all GTA Online cars in single player** | [gta5-mods](https://www.gta5-mods.com/scripts/all-mp-vehicles-in-sp) · [GitHub](https://github.com/sruckstar/gta5-all-mp-vehicles-in-sp) |
| Better Chases+ Enhanced | realistic police/wanted system | [gta5-mods](https://www.gta5-mods.com/scripts/better-chases-enhanced-edition) |
| LemonUI | UI library used by Better Chases+ | [GitHub](https://github.com/LMS01/LemonUI) |
| Swap Main Ride | own any car as a protagonist's personal vehicle | [gta5-mods](https://www.gta5-mods.com/scripts/swap-main-ride) |
| VAutodrive | waypoint autopilot (J to drive) | [LibertyCity mirror](https://libertycity.net/files/gta-5/113753-vautodrive-v8.0.2.html) |
| Drive V | realistic handling & damage | [gta5-mods](https://www.gta5-mods.com/vehicles/drive-v-realistic-driving-car-handling) |
| Full Weapon Overhaul 3.0 | weapon feel rebalance | [gta5-mods](https://www.gta5-mods.com/weapons/gta5-enhanced-penetration-firerate-magsize-damage-fov-recoil-ext) |
| I.R.O (Ins4ne Ragdoll Overhaul) | Euphoria ragdoll reactions | [gta5-mods](https://www.gta5-mods.com/misc/i-r-o-ins4ne-ragdoll-overhaul) |
| ChaosMod V | random chaos effects (+ Twitch voting) | [GitHub](https://github.com/gta-chaos-mod/ChaosModV) |

Full walkthrough for that loadout, load order, and pitfalls: [docs/2-mod-setup.md](docs/2-mod-setup.md).
Tuning its online-cars spawner: [docs/3-online-cars-config.md](docs/3-online-cars-config.md).

## The rules that keep your account safe

1. **Online only ever through the vanilla side** — BattlEye enabled, Steam launch options blank ([Rockstar's own requirements](https://support.rockstargames.com/articles/ocorZr1KpQE8WvoHE3gBG/battleye-troubleshooting-for-grand-theft-auto-v)).
2. **Never enter GTA Online while the MODDED copy is swapped in.** Not once, not "just the menu".
3. **Quit the game completely before switching.** The scripts enforce this, but don't fight them.
4. After the split, run Steam's **Verify integrity** on the vanilla copy once — it re-downloads any stock file a mod ever touched (guide 1 explains; ours caught and restored two modified audio archives).
5. In Steam, set GTA V Enhanced → Properties → Updates → **"Only update this game when I launch it"**, so Steam can never auto-patch the game while the modded copy is swapped in (a surprise patch breaks ScriptHookV's build match).

Nothing here can promise what happens to an account. But with a verified-clean vanilla folder and these rules, the modded side and the Online side never share a single file.

## Troubleshooting

- **`ERR_NO_LAUNCHER` dialog** — you double-clicked an exe. Don't. Use the switch scripts + Steam Play.
- **Switch script says GTA V is still running** — quit fully (check the tray/rockstar launcher), run it again.
- **Switch fails** — close Steam and the Rockstar Launcher, run it again. The scripts roll back the first rename if the second one fails.
- **ScriptHookV stops working after a game update** — Steam updated the game. Update ScriptHookV to the matching build, or see guide 1's "updating the modded copy" section.
- **Cars spawning on top of each other / exploding** — see the "backup DLLs" warning in [docs/2-mod-setup.md](docs/2-mod-setup.md): SHVDN loads `scripts\` **recursively**, so an old mod DLL parked in a subfolder runs as a *second live copy* of the mod.

## Legal

This project is not affiliated with or endorsed by Rockstar Games or Take-Two Interactive. Grand Theft Auto V and related marks belong to Take-Two Interactive. All mods referenced here belong to their respective authors — download them from the linked official pages; nothing of theirs is redistributed here. Single-player modding is at your own risk per Rockstar's Terms of Service; this repo exists precisely to keep mods and GTA Online strictly separated.

## License

MIT — applies to the scripts and documentation in this repo only. See [LICENSE](LICENSE).
