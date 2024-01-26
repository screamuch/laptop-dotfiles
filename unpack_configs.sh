#!/bin/bash
# This script unpacks configs from the repository to a new system

# Set BASEDIR to the directory where this script is located (repository root)
BASEDIR=$(dirname $0)

# Function to create directory if it doesn't exist
create_dir_if_not_exists() {
    if [ ! -d "$1" ]; then
        sudo mkdir -p "$1"
    fi
}

# Xmonad
create_dir_if_not_exists "${HOME}/.xmonad"
sudo cp "${BASEDIR}/.xmonad/xmonad.hs" "${HOME}/.xmonad/"

# Config files in .config
CONFIG_DIR="${HOME}/.config"
create_dir_if_not_exists "${CONFIG_DIR}"
# List all config directories you need to copy
declare -a config_dirs=("xmobar" "alacritty" "dunst" "fish" "micro" "qalculate" "qutebrowser" "rofi" "nvim")

for dir in "${config_dirs[@]}"; do
    create_dir_if_not_exists "${CONFIG_DIR}/${dir}"
    # Copying entire directory
    sudo cp -r "${BASEDIR}/.config/${dir}" "${CONFIG_DIR}/"
done

# LightDM
create_dir_if_not_exists "/etc/lightdm"
sudo cp "${BASEDIR}/etc/lightdm/lightdm.conf" "/etc/lightdm/"
sudo cp "${BASEDIR}/etc/lightdm/lightdm-mini-greeter.conf" "/etc/lightdm/"

# Wallpaper
create_dir_if_not_exists "${HOME}/Pictures/wallpapers"
sudo cp -r "${BASEDIR}/Pictures/wallpapers" "${HOME}/Pictures/"

# Homepage
sudo cp "${BASEDIR}/home.html" "${HOME}/"

# wlan0_active.sh and wifimenu.sh scripts
sudo cp "${BASEDIR}/wlan0_active.sh" "${HOME}/bin/"
sudo cp "${BASEDIR}/wifimenu.sh" "${HOME}/.local/bin/"

# Set permissions for scripts
sudo chmod +x "${HOME}/bin/wlan0_active.sh"
sudo chmod +x "${HOME}/.local/bin/wifimenu.sh"

echo "Configurations unpacked successfully."

