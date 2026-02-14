# Universal Android Debloater (UAD) Linux Setup

A comprehensive guide and utility script to install **ADB/Fastboot** and run the **UAD GUI** binary on Linux. This repository specifically addresses the Wayland/Debian "wl_surface" crash.

## 1. Install System Dependencies
Open your terminal and run the command corresponding to your Linux distribution:

| Distribution | Command |
| :--- | :--- |
| **Debian / Ubuntu / Mint** | `sudo apt update && sudo apt install android-tools-adb android-tools-fastboot` |
| **Arch Linux / Manjaro** | `sudo pacman -S android-tools` |
| **Fedora / Nobara** | `sudo dnf install android-tools` |

## 2. Prepare Your Android Device
1. **Enable Developer Options**: Go to *Settings > About Phone* and tap **Build Number** 7 times.
2. **Enable USB Debugging**: Go to *Settings > Developer Options* and toggle **USB Debugging** ON.
3. **Authorize PC**: Connect your phone via USB. Run `adb devices` in your terminal and accept the "Always allow" prompt on your phone screen.

## 3. Automated Launch Script
To bypass Wayland compatibility issues (like the `interface 'wl_surface' has no event 2` error), use the included `launch_uad.sh` script.

### Create the script:
```bash
cat << 'EOF' > launch_uad.sh
#!/bin/bash
BINARY="./uad_gui-linux"

if [ ! -f "$BINARY" ]; then
    echo "Error: $BINARY not found! Ensure the binary is in this folder."
    exit 1
fi

chmod +x "$BINARY"

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "Wayland detected. Applying X11 compatibility fix..."
    WINIT_UNIX_BACKEND=x11 "$BINARY"
else
    "$BINARY"
fi
EOF

chmod +x launch_uad.sh
