# Guide 1 — Create the vanilla/modded split

This turns one modded GTA V Enhanced (Steam) install into two: a **verified-clean vanilla** copy for GTA Online, and a **fully preserved modded** copy for Story Mode. Expect ~30–45 minutes, mostly unattended (it's one big file copy plus a Steam verify).

You need:
- ~105 GB free on the drive holding the game (for the second copy; the game itself is ~103 GB)
- GTA V Enhanced installed, containing whatever mods you want — **any mods, or none** (the split doesn't care what's in the folder; if you'd like my recommended loadout, it's in [guide 2](2-mod-setup.md))
- Steam logged in

Throughout this guide, `<LIB>` means your `steamapps\common` folder (e.g. `D:\SteamLibrary\steamapps\common`).

## Step 0 — Close everything

Quit GTA V, then close Steam (right-click tray icon → Exit) and the Rockstar Games Launcher. Nothing may be holding files in the game folder.

Quick check (PowerShell):

```powershell
Get-Process GTA5_Enhanced,GTA5_Enhanced_BE,steam,Launcher,RockstarService -ErrorAction SilentlyContinue
```

Empty output (or only `RockstarService`, which is harmless) = good to go.

## Step 1 — Copy the install beside itself

Copy the whole game folder to a sibling folder named `Grand Theft Auto V Enhanced - Modded`. A robocopy one-liner (from an elevated or normal cmd — either works):

```bat
robocopy "<LIB>\Grand Theft Auto V Enhanced" "<LIB>\Grand Theft Auto V Enhanced - Modded" /E /COPY:DAT /DCOPY:DAT /R:2 /W:2 /MT:16 /NP /NFL /NDL /TEE /LOG:"%TEMP%\gta-copy.log"
```

Robocopy exit codes **0–7 are success** (1 = "files were copied"). When it finishes, check the log tail for the summary — `FAILED` must be `0`. Our reference copy: 431 files, 130 dirs, 104.17 GiB, 0 failed, byte totals identical on both sides.

> ⚠️ Do this copy **before** touching any mod files. The modded copy must snapshot your working game exactly as-is.

## Step 2 — Strip every mod file out of the ORIGINAL folder

The original `Grand Theft Auto V Enhanced` folder becomes your Online/vanilla copy. Move (don't delete — keep a backup!) every mod artifact out of it. Park them somewhere outside the game folder, e.g. `<drive>\GTA5-Mod-Files-Backup\`.

Typical mod files at the game root:

```
scripts\                      <- ScriptHookVDotNet script mods (.dll) + their configs
mods\                         <- OpenRPF/OpenIV "mods folder" (modified .rpf archives)
chaosmod\                     <- ChaosMod V config/data
OIV_CW_Logs\                  <- OpenIV OIV package logs
OIV_CW_Uninstall_Data\        <- OpenIV OIV uninstall data
args.txt
*.asi                         <- ChaosMod.asi, OpenRPF.asi, ScriptHookVDotNet.asi, ...
dinput8.dll  xinput1_4.dll    <- ASI loaders
ScriptHookV.dll
ScriptHookVDotNet.ini  ScriptHookVDotNet2.dll  ScriptHookVDotNet3.dll
MinHook.x64.dll
asiloader.log  ScriptHookV.log  ScriptHookVDotNet.log
```

Your modded copy (`- Modded`) already contains all of these, so this "backup" folder is a second, redundant safety net — cheap insurance.

When you're done, the vanilla root must contain **only stock items**: `GTA5_Enhanced.exe`, `GTA5_Enhanced_BE.exe`, `PlayGTAV.exe`, the stock `.dll`s (`steam_api64.dll`, `bink2w64.dll`, `dstorage*.dll`, `sl.*.dll`, `nvngx_*.dll`, `zlib1.dll`, …), the stock `.rpf` archives, `rpf.cache`, `title.rgl`, `installscript*.vdf`, and the folders `BattlEye\`, `D3D12-REDIST\`, `Redistributables\`, `update\`, `x64\`.

Sanity check — this must return nothing:

```bat
dir /s /b "<LIB>\Grand Theft Auto V Enhanced\*.asi"
```

## Step 3 — Verify integrity of the vanilla copy

This is the step that buys you peace of mind: Steam re-hashes every depot file and **re-downloads any stock file that a mod ever modified**. (In our reference setup, a weapon-sound edit had touched two stock audio archives — `x64\audio\sfx\RESIDENT.rpf` and `WEAPONS_PLAYER.rpf`, ~88 MB — and verify quietly restored them to factory bytes.)

1. Start Steam (leave the Rockstar launcher alone).
2. Either run the `Verify Vanilla (Steam).bat` from this repo's `switch/` folder, or do it by hand:
   Steam → Library → **Grand Theft Auto V Enhanced** → right-click → **Properties…** → **Installed Files** → **Verify integrity of game files**.
3. Wait for it to finish (10–15 min for ~103 GB). You can watch progress under Library → Downloads.

Steam's own log (`Steam\logs\content_log.txt`) is a nice second opinion — on success you'll see `Start validating appID 3240220 … ` followed by `finished update … (result No Error)`.

> Why appid 3240220? That's GTA V **Enhanced** on Steam. The older Legacy edition is 271590 — this guide is not about that one.

## Step 4 — Online launch settings (once)

With the vanilla copy active:

- Steam → GTA V Enhanced → Properties → **General → Launch Options**: leave **blank**.
- BattlEye: keep it **enabled** (it's the default). Rockstar requires BattlEye + blank launch arguments for official GTA Online — see [Rockstar's BattlEye article](https://support.rockstargames.com/articles/ocorZr1KpQE8WvoHE3gBG/battleye-troubleshooting-for-grand-theft-auto-v).
- Properties → **Updates** → set **"Only update this game when I launch it."**
  This stops Steam from auto-patching in the background while the *modded* copy is swapped in — a surprise patch would break ScriptHookV, which is build-locked.

## Step 5 — Install the switch scripts

1. Copy the three `.bat` files from this repo's `switch/` folder into a small desktop folder (e.g. `GTA V Switch`).
2. Edit `config.bat`: set `GTA_BASE` to your `<LIB>` path.
3. Test it: run `Switch to MODDED (Story Mode).bat` → the console should announce the swap → run `Switch to VANILLA (Online Safe).bat` → back. Both are instant.

From now on the daily flow is exactly:

| You want | Do |
|---|---|
| Modded Story Mode | quit game → `Switch to MODDED` → **Play** in Steam |
| GTA Online | quit game → `Switch to VANILLA` → **Play** in Steam |

Never launch either copy by double-clicking an exe — the Steam Enhanced build answers with `ERR_NO_LAUNCHER` by design, and Steam is the only correct launch path anyway.

## Housekeeping

- **Updating the modded copy** (only when you *want* new game content): swap to vanilla → let Steam update it → wait until ScriptHookV ships a matching build → re-do the copy in Step 1 (delete the old `- Modded` folder first) → re-install any script-mod updates. Until then the modded copy stays happily frozen on a known-good build.
- **Story saves** live in `Documents\Rockstar Games\` and are shared by both copies — your story progress is identical either side.
- BattlEye is dormant in Story Mode; the vanilla copy carries it, and the modded copy's copy of the folder is inert unless you go Online (which you must never do from the modded side).

→ Next (optional): [guide 2 — my recommended mod loadout](2-mod-setup.md)
