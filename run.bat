@echo off

powershell ^
  -ExecutionPolicy Bypass ^
  -NoProfile ^
  "& '%~dp0DisableUSBPowerSaving.ps1'"

pause
