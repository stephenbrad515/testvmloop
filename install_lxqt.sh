#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting LXQt Installation for Debian ---"

# 1. Update package lists
echo "Updating package repositories..."
sudo apt update

# 2. Install LXQt and the Xorg display server
# Note: lxqt-core is the minimal version. 
# We'll use 'lxqt' for a more complete experience.
echo "Installing LXQt and X11..."
sudo apt install -y xorg lxqt sddm

# 3. Optional: Install a web browser and terminal (if not already present)
echo "Installing essential apps (QTerminal and Firefox)..."
sudo apt install -y qterminal firefox-esr

# 4. Set the default display manager to SDDM (standard for LXQt)
echo "Setting SDDM as the default display manager..."
sudo systemctl set-default graphical.target

echo "--- Installation Complete! ---"
echo "You can now reboot your system to enter LXQt."
read -p "Would you like to reboot now? (y/n): " choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    sudo reboot
fi