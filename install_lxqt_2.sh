#!/bin/bash

# Exit on error
set -e

echo "--- Preparing LXQt for Google Cloud Debian ---"

# 1. Update and Upgrade
sudo apt update && sudo apt upgrade -y

# 2. Install LXQt and a light Display Manager
# We include 'task-lxqt-desktop' for a complete set of tools
echo "Installing LXQt Desktop Environment..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y task-lxqt-desktop

# 3. Install Chrome Remote Desktop
echo "Downloading and installing Chrome Remote Desktop..."
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install -y ./chrome-remote-desktop_current_amd64.deb

# 4. Final Cleanup
sudo apt autoremove -y

echo "--- Installation Finished! ---"
echo "Follow the steps below to finish the connection."