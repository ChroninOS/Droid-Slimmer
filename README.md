# Universal Android Debloater (UAD) Linux Setup

A comprehensive guide and utility script to install ADB/Fastboot and run the UAD GUI binary on Linux. This repository specifically addresses the Wayland/Debian "wl_surface" crash.

---

## 1. Install System Dependencies

Open your terminal and run the command corresponding to your Linux distribution:

**Debian/Ubuntu:**
```bash
sudo apt install adb fastboot
```

**Arch Linux:**
```bash
sudo pacman -S android-tools
```

**Fedora:**
```bash
sudo dnf install android-tools
```

---

## 2. Prepare Your Android Device

1. **Enable Developer Options**  
   Go to `Settings > About Phone` and tap **Build Number** 7 times.

2. **Enable USB Debugging**  
   Go to `Settings > Developer Options` and toggle **USB Debugging** ON.

3. **Authorize Your PC**  
   Connect your phone via USB. Run `adb devices` in your terminal and accept the "Always allow" prompt on your phone screen.

---

## 3. Download and Install UAD GUI

### Option A: Download from GitHub Releases

[**Download UAD GUI**](https://github.com/0x192/universal-android-debloater/releases) (latest release)

### Option B: Download via Terminal

```bash
# Download the binary
wget https://github.com/0x192/universal-android-debloater/releases/download/0.5/uad_gui-linux.tar.gz -P ~/Downloads
```

### Extract and Launch

```bash
# Go to your Downloads folder
cd ~/Downloads

# Extract the binary
tar -xzf uad_gui-linux.tar.gz

# Make it executable
chmod +x uad_gui-linux

# Launch the program
./uad_gui-linux
```

---

## Troubleshooting Wayland Issues

If you encounter a **wl_surface crash** or the GUI fails to launch on Wayland, use one of these solutions:

### Solution 1: Force X11 Backend

```bash
WINIT_UNIX_BACKEND=x11 ./uad_gui-linux
```

### Solution 2: Clear Wayland Environment

If the command above still shows warnings or fails to render, try clearing the Wayland environment variables:

```bash
env -u WAYLAND_DISPLAY ./uad_gui-linux
```

---

## One-Command Script Installation

For a fully automated installation, download and run the install script:

```bash
wget https://raw.githubusercontent.com/ChroninOS/Droid-Slimmer/main/install-uad.sh && chmod +x install-uad.sh && ./install-uad.sh
```

**What this script does:**
- Automatically detects your Linux distribution
- Installs ADB/Fastboot dependencies
- Downloads the UAD GUI binary
- Extracts and sets permissions
- Checks for connected Android devices
- Launches UAD with Wayland compatibility fixes if needed

---

## Support & Contributing

If you encounter issues or have suggestions for improvement:
- Open an issue on the [UAD GitHub repository](https://github.com/0x192/universal-android-debloater)
- Check existing issues for solutions
- Submit pull requests to improve this guide

---

## Credits

- **Universal Android Debloater**: [0x192/universal-android-debloater](https://github.com/0x192/universal-android-debloater)
- This setup guide simplifies UAD installation on Linux systems, particularly for Wayland users

---

## License

This guide is provided as-is for educational purposes. Please refer to the [original UAD repository](https://github.com/0x192/universal-android-debloater) for software licensing information.