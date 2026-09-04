@echo off
REM ============================================================
REM  GTA V Enhanced dual-install switch - TO MODDED (Story Mode)
REM  Part of the gta5-enhanced-dual-swap project (MIT license).
REM  Swaps which physical folder holds the install name Steam
REM  launches: modded copy becomes "Grand Theft Auto V Enhanced",
REM  the clean copy parks as "... - Vanilla".
REM ============================================================
title GTA V Switch - MODDED
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

if exist "%ACTIVE%\ScriptHookV.dll" goto alreadyModded
if exist "%VAN%" goto badState
if not exist "%MOD%\ScriptHookV.dll" goto noModded

echo Swapping: modded in, vanilla parked...
ren "%ACTIVE%" "%PARKED_VAN%"
if errorlevel 1 goto fail
ren "%MOD%" "%ACTIVE_NAME%"
if errorlevel 1 goto failRestore

echo.
echo  ==========================================================
echo    MODDED is now the active install.
echo    Start Grand Theft Auto V Enhanced in Steam as usual.
echo    STORY MODE ONLY - never enter Online while MODDED.
echo  ==========================================================
echo.
pause
exit /b 0

:failRestore
ren "%VAN%" "%ACTIVE_NAME%"
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

:alreadyModded
echo.
echo  MODDED is already active. Just start GTA V Enhanced in Steam (Story Mode only).
pause
exit /b 0

:noModded
echo.
echo  ERROR: could not find the parked Modded folder:
echo  "%MOD%"
echo  Nothing was changed.
pause
exit /b 1

:badState
echo.
echo  ERROR: "%VAN%" already exists - unexpected state, nothing changed.
echo  If you meant to go back to vanilla, run the other switch script.
pause
exit /b 1

:nobase
echo.
echo  ERROR: could not find "Grand Theft Auto V Enhanced" in common
echo  Steam library locations. Edit config.bat (next to this script)
echo  and set GTA_BASE to your steamapps\common folder.
pause
exit /b 1
