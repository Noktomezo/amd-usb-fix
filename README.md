<div align="center">
	<img src="assets/thumbnail.svg" alt="thumbnail"/>
</div>

Disables power saving options on all USB controllers to prevent crashes and BSODs on AMD-based systems.
No more random disconnects, blue screens, or USB instability.

> 💡 Inspired by [ThioJoe's original script](https://gist.github.com/ThioJoe/3ee8fb39eecd34495b228ac63bbac9e3#file-disableusbpowermanagement-ps1-L17) <br>
> 🧩 Extended with better device searching method, logging and some other features.

## ⚠️ Why this exists

Some AMD-based systems (especially with Ryzen CPUs and chipsets like B550/X570 and newer) suffer from:
- USB dropouts
- Blue screens of death (BSOD)
- Device instability

due to aggressive **USB power saving** enabled by default in Windows.

This script finds all USB devices and disables the setting that allows Windows to turn them off to save power.

## ▶️ How to use

1. Run the following command in powershell as administrator:
```pwsh
irm "https://dub.sh/dusbps" | iex
```

2. Follow the prompt to reboot (if changes were applied)

## 📄 License

[MIT License](LICENSE)

## 🙏 Credits

Original idea and base script by [ThioJoe](https://gist.github.com/ThioJoe/3ee8fb39eecd34495b228ac63bbac9e3)
