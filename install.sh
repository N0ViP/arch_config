#!/bin/bash

# Exit on error
set -e

echo "Starting dotfiles installation..."

# Update system and install dependencies using yay
echo "Installing dependencies..."
if ! command -v yay &> /dev/null; then
    echo "yay is not installed. Please install yay first."
    exit 1
fi

packages=(
    "waybar"
    "wofi"
    "discord"
    "mpv"
    "imv"
    "kitty"
    "thunar"
    "hyprland"
    "swaync"
    "swaybg"
    "swaylock"
    "grim"
    "slurp"
    "wl-clipboard"
    "brightnessctl"
    "playerctl"
    "btop"
    "sddm"
)

# We use spotify-launcher as 'spotify' is sometimes not directly in AUR/repos, or 'spotify' itself from AUR
# Let's try to install 'spotify' from AUR
packages+=("spotify")

for pkg in "${packages[@]}"; do
    if ! pacman -Qs "$pkg" > /dev/null; then
        echo "Installing $pkg..."
        yay -S --noconfirm "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

echo "Copying configurations to ~/.config..."
mkdir -p ~/.config

# Get the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy config folders
cp -r "$DOTFILES_DIR/config/"* ~/.config/

# Copy bashrc
cp "$DOTFILES_DIR/bashrc" ~/.bashrc

echo "Setting up SDDM Theme (cyberpunk)..."
# Needs sudo to copy to /usr/share/sddm/themes and write to /etc/sddm.conf
if [ -d "$DOTFILES_DIR/sddm-theme/cyberpunk" ]; then
    sudo mkdir -p /usr/share/sddm/themes/
    sudo cp -r "$DOTFILES_DIR/sddm-theme/cyberpunk" /usr/share/sddm/themes/
    
    # Set the theme in sddm.conf
    if ! grep -q "Current=cyberpunk" /etc/sddm.conf 2>/dev/null; then
        echo -e "[Theme]\nCurrent=cyberpunk" | sudo tee /etc/sddm.conf > /dev/null
    fi
    echo "SDDM theme applied. It will take effect on next boot/login."
else
    echo "SDDM theme not found in dotfiles."
fi

echo "Installation complete!"
echo "Note: You will still need to log into Discord and Spotify as those configs were excluded to keep the repo clean."
