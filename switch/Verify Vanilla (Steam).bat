@echo off
REM ============================================================
REM  GTA V Enhanced dual-install - VERIFY VANILLA UTILITY
REM  Part of the gta5-enhanced-dual-swap project (MIT license).
REM  Asks Steam to verify the integrity of the ACTIVE install
REM  (GTA V Enhanced, Steam appid 3240220). Run this while the
REM  VANILLA copy is swapped in - it re-downloads any stock file
REM  that was ever modified or corrupted.
REM  Progress shows in Steam: Library - Downloads.
REM ============================================================
title GTA V - Verify Integrity

tasklist /FI "IMAGENAME eq GTA5_Enhanced.exe" 2>NUL | find /I "GTA5_Enhanced.exe" >NUL && goto gameRunning
tasklist /FI "IMAGENAME eq GTA5_Enhanced_BE.exe" 2>NUL | find /I "GTA5_Enhanced_BE.exe" >NUL && goto gameRunning

tasklist /FI "IMAGENAME eq steam.exe" 2>NUL | find /I "steam.exe" >NUL || (
  echo Starting Steam...
  start "" "steam://open"
  timeout /t 10 >NUL
)

start "" "steam://validate/3240220"
echo.
echo  Verify requested from Steam (appid 3240220).
echo  Watch progress in Steam under Library - Downloads.
echo  Wait for it to finish before playing Online.
echo.
pause
exit /b 0

:gameRunning
echo.
echo  GTA V IS STILL RUNNING - quit the game first, then run this again.
pause
exit /b 1
