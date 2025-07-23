Disables USB power saving to prevent crashes and BSODs on AMD-based systems.
No more random disconnects, blue screens, or USB instability.

> 💡 Inspired by [ThioJoe's original script](https://gist.github.com/ThioJoe/3ee8fb39eecd34495b228ac63bbac9e3#file-disableusbpowermanagement-ps1-L17)
> Extended with better device searching method, logging, admin auto-elevation, safe checks, and reboot prompt.

---

## ⚠️ Why this exists

Some AMD-based systems (especially with Ryzen CPUs and chipsets like B550/X570) suffer from:
- USB dropouts
- Blue screens of death (BSOD)
- Device instability
Due to aggressive **USB power saving** enabled by default in Windows.

This script finds all USB devices and disables the setting that allows Windows to turn them off to save power.

---

## ✨ Features

- 🛡️ Automatically elevates to Administrator if needed
- 🔍 Detects USB devices via WMI
- ⚙️ Skips devices that are already patched
- 🧠 Smart logging with clear color-coded output
- 🔄 Asks for reboot after changes are made
- 💥 Fixes common BSOD and USB disconnect issues on AMD systems

---

## ▶️ How to use

1. **Download and extract [archive](https://github.com/Noktomezo/amd-usb-fix/archive/refs/heads/main.zip) or clone via [git](https://git-scm.com/downloads)**
```bash
$ git clone --depth 1 https://github.com/Noktomezo/amd-usb-fix.git
```

2. **Run `run.bat` with administrator privileges**
3. **Follow the prompt to reboot** (if changes were applied)

---

## 📄 License

[MIT License](LICENSE)

---

## 🙏 Credits

Original idea and base script by [ThioJoe](https://gist.github.com/ThioJoe/3ee8fb39eecd34495b228ac63bbac9e3)
This version rewritten and enhanced by [Noktomezo](https://github.com/Noktomezo)

---
