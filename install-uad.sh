#!/bin/bash

# Universal Android Debloater (UAD) - Automated Linux Installer
# This script installs dependencies, downloads UAD GUI, and launches it

set -e  # Exit on error

echo "========================================="
echo "Universal Android Debloater - Auto Installer"
echo "========================================="
echo ""

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Error: Cannot detect Linux distribution"
    exit 1
fi

# Install dependencies based on distribution
echo "[1/5] Installing ADB/Fastboot dependencies..."
case $DISTRO in
    debian|ubuntu|linuxmint|pop)
        sudo apt update
        sudo apt install -y adb fastboot wget
        ;;
    arch|manjaro)
        sudo pacman -S --noconfirm android-tools wget
        ;;
    fedora)
        sudo dnf install -y android-tools wget
        ;;
    *)
        echo "Warning: Unsupported distribution ($DISTRO)"
        echo "Please install 'adb' and 'fastboot' manually, then re-run this script"
        exit 1
        ;;
esac

echo "✓ Dependencies installed"
echo ""

# Create download directory if it doesn't exist
mkdir -p ~/Downloads
cd ~/Downloads

# Download UAD GUI
echo "[2/5] Downloading UAD GUI..."
UAD_URL="https://github.com/0x192/universal-android-debloater/releases/download/0.5/uad_gui-linux.tar.gz"
wget -q --show-progress "$UAD_URL" -O uad_gui-linux.tar.gz

echo "✓ Download complete"
echo ""

# Extract the binary
echo "[3/5] Extracting binary..."
tar -xzf uad_gui-linux.tar.gz

echo "✓ Extraction complete"
echo ""

# Make it executable
echo "[4/5] Setting permissions..."
chmod +x uad_gui-linux

echo "✓ Permissions set"
echo ""

# Check if phone is connected
echo "[5/5] Checking device connection..."
if command -v adb &> /dev/null; then
    DEVICES=$(adb devices | grep -v "List" | grep "device$" | wc -l)
    if [ "$DEVICES" -eq 0 ]; then
        echo ""
        echo "⚠️  WARNING: No Android device detected!"
        echo ""
        echo "Please ensure:"
        echo "  1. USB Debugging is enabled on your phone"
        echo "  2. Your phone is connected via USB"
        echo "  3. You've authorized this computer on your phone"
        echo ""
        echo "Run 'adb devices' to check connection status"
        echo ""
    else
        echo "✓ Android device detected!"
        echo ""
    fi
fi

# Launch UAD GUI
echo "========================================="
echo "Launching UAD GUI..."
echo "========================================="
echo ""

# Try normal launch first
if ./uad_gui-linux 2>/dev/null; then
    exit 0
fi

# If normal launch fails, try X11 backend (Wayland fix)
echo "Detected display issues, trying X11 backend..."
if WINIT_UNIX_BACKEND=x11 ./uad_gui-linux 2>/dev/null; then
    exit 0
fi

# If X11 backend fails, try clearing Wayland environment
echo "Trying alternate Wayland fix..."
env -u WAYLAND_DISPLAY ./uad_gui-linux

echo ""
echo "========================================="
echo "Installation complete!"
echo "========================================="
