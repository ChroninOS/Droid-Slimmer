#!/bin/bash

# UAD GUI Launcher for KDE Plasma Wayland
# Use this if the main installer script fails to launch UAD

cd ~/Downloads

echo "Launching UAD GUI with Wayland compatibility..."

# Force X11 backend (most reliable for KDE Plasma Wayland)
WINIT_UNIX_BACKEND=x11 ./uad_gui-linux

# If the above fails, try these alternatives:
# Alternative 1: Clear Wayland display
# env -u WAYLAND_DISPLAY ./uad_gui-linux

# Alternative 2: Force XWayland
# QT_QPA_PLATFORM=xcb ./uad_gui-linux
