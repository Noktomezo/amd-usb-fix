@echo off

powershell ^
  -ExecutionPolicy Bypass ^
  -NoProfile ^
  "& '%~dp0disable-usb-power-saving.ps1'"

pause
