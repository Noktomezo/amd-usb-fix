If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Try {
		Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
		Exit
	}
 Catch {
		Write-Host "[-] Failed to run as Administrator. Please rerun with elevated privileges." -ForegroundColor Red
		Exit 1
	}
}

Write-Host "[i] Scanning for USB devices..." -ForegroundColor Cyan

$Hubs = Get-CimInstance Win32_PnPEntity |
Where-Object { $_.PNPClass -eq 'USB' -or $_.Name -like "*USB*" } |
Select-Object Name, DeviceID, Manufacturer, PNPDeviceID

if (-not $Hubs) {
	Write-Host "[!] No USB devices found." -ForegroundColor Yellow
	return
}

Write-Host "[+] Found $($Hubs.Count) USB device(s)." -ForegroundColor Green

$PowerManagements = Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root\wmi

if (-not $PowerManagements) {
	Write-Host "[!] No power management entries found in WMI." -ForegroundColor Yellow
	return
}

$Changes = 0
$Skipped = 0

foreach ($PowerManagement in $PowerManagements) {
	$Instance = $PowerManagement.InstanceName.ToUpper()

	foreach ($Hub in $Hubs) {
		$PNPDI = $Hub.PNPDeviceID.ToUpper()

		if ($Instance -like "*$PNPDI*") {
			if ($PowerManagement.Enable -eq $false) {
				Write-Host "[i] Skipping (already disabled): $($Hub.Name)" -ForegroundColor DarkGray
				$Skipped++
				continue
			}

			Write-Host "[*] Disabling power management for: $($Hub.Name)" -ForegroundColor Magenta

			try {
				Set-CimInstance -InputObject $PowerManagement -Property @{Enable = $false }
				Write-Host "[+] Power management disabled for: $($Hub.Name)" -ForegroundColor Green
				$Changes++
			}
			catch {
				Write-Host "[-] Failed to disable power management for: $($Hub.Name)" -ForegroundColor Red
			}
		}
	}
}

if ($Changes -eq 0 -and $Skipped -eq 0) {
	Write-Host "[i] No matching USB power management entries were modified." -ForegroundColor Yellow
}
else {
	Write-Host "[+] Done." -ForegroundColor Cyan
	Write-Host "[i] Modified entries: $Changes" -ForegroundColor Green
	Write-Host "[i] Skipped (already disabled): $Skipped" -ForegroundColor DarkYellow

	# [?] Prompt for reboot
	$response = Read-Host "[?] Would you like to reboot now? [Y/N]"

	if ($response.ToUpper() -eq "Y") {
		Write-Host "[*] Rebooting system..." -ForegroundColor Cyan
		Restart-Computer
	}
	else {
		Write-Host "[i] Reboot skipped. Please restart manually to apply all changes." -ForegroundColor Yellow
	}
}
