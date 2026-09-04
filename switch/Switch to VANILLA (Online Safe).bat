@echo off
REM ============================================================
REM  GTA V Enhanced dual-install switch - TO VANILLA (Online)
REM  Part of the gta5-enhanced-dual-swap project (MIT license).
REM  Swaps which physical folder holds the install name Steam
REM  launches: the clean copy becomes "Grand Theft Auto V Enhanced",
REM  the modded copy parks as "... - Modded".
REM ============================================================
title GTA V Switch - VANILLA
set "ACTIVE_NAME=Grand Theft Auto V Enhanced"
set "PARKED_VAN=Grand Theft Auto V Enhanced - Vanilla"
set "PARKED_MOD=Grand Theft Auto V Enhanced - Modded"

call "%~dp0config.bat" >NUL 2>&1

if not defined GTA_BASE goto detect
if not exist "%GTA_BASE%\%ACTIVE_NAME%" goto detect
goto gotbase

:detect
set "GTA_BASE="
for %%P in ("C:\Program Files (x86)\Steam\steamapps\common" "C:\Program Files\Steam\steamapps\common" "D:\SteamLibrary\steamapps\common" "D:\Steam\steamapps\common" "E:\SteamLibrary\steamapps\common" "E:\Steam\steamapps\common") do (
  if not defined GTA_BASE if exist "%%~P\%ACTIVE_NAME%" set "GTA_BASE=%%~P"
)
if not defined GTA_BASE goto nobase

:gotbase
set "ACTIVE=%GTA_BASE%\%ACTIVE_NAME%"
set "VAN=%GTA_BASE%\%PARKED_VAN%"
set "MOD=%GTA_BASE%\%PARKED_MOD%"

tasklist /FI "IMAGENAME eq GTA5_Enhanced.exe" 2>NUL | find /I "GTA5_Enhanced.exe" >NUL && goto gameRunning
tasklist /FI "IMAGENAME eq GTA5_Enhanced_BE.exe" 2>NUL | find /I "GTA5_Enhanced_BE.exe" >NUL && goto gameRunning

if not exist "%ACTIVE%\ScriptHookV.dll" goto alreadyVanilla
if exist "%MOD%" goto badState
if not exist "%VAN%" goto noVanilla

echo Swapping: vanilla in, modded parked...
ren "%ACTIVE%" "%PARKED_MOD%"
if errorlevel 1 goto fail
ren "%VAN%" "%ACTIVE_NAME%"
if errorlevel 1 goto failRestore

echo.
echo  ==========================================================
echo    VANILLA is now the active install - Online is safe.
echo    Start Grand Theft Auto V Enhanced in Steam
echo    (BattlEye enabled, launch options blank, Online OK).
echo  ==========================================================
echo.
pause
exit /b 0

:failRestore
ren "%MOD%" "%ACTIVE_NAME%"
echo.
echo  SWITCH FAILED - close Steam and the Rockstar Launcher, then run again.
pause
exit /b 1

:fail
echo.
echo  SWITCH FAILED - close Steam and the Rockstar Launcher, then run again.
pause
exit /b 1

:gameRunning
echo.
echo  GTA V IS STILL RUNNING - quit the game first, then run this again.
pause
exit /b 1

:alreadyVanilla
echo.
echo  VANILLA is already active. Start GTA V Enhanced in Steam - Online OK.
pause
exit /b 0

:noVanilla
echo.
echo  ERROR: could not find the parked Vanilla folder:
echo  "%VAN%"
echo  Nothing was changed.
pause
exit /b 1

:badState
echo.
echo  ERROR: "%MOD%" already exists - unexpected state, nothing changed.
echo  If you meant to switch to modded, run the other switch script.
pause
exit /b 1

:nobase
echo.
echo  ERROR: could not find "Grand Theft Auto V Enhanced" in common
echo  Steam library locations. Edit config.bat (next to this script)
echo  and set GTA_BASE to your steamapps\common folder.
pause
exit /b 1
