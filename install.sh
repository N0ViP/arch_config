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
    "ttf-jetbrains-mono-nerd"
    "qt5-graphicaleffects"
    "qt5-quickcontrols2"
    "qt5-svg"
    "nwg-look"
    "candy-icons-git"
    "spotify"
    "google-chrome"
    "visual-studio-code-bin"
    "bash-completion"
)

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

echo "Applying GTK theme via gsettings..."
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' || true
gsettings set org.gnome.desktop.interface icon-theme 'candy-icons' || true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true

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

echo "Hiding cluttered system apps from Wofi launcher..."
mkdir -p "$HOME/.local/share/applications"
clutter_apps=(
    "avahi-discover.desktop" "bssh.desktop" "bvnc.desktop" "qv4l2.desktop" "qvidcap.desktop"
    "org.gnupg.pinentry-qt.desktop" "cartes-geo-handler.desktop" "google-maps-geo-handler.desktop"
    "openstreetmap-geo-handler.desktop" "wheelmap-geo-handler.desktop" "com.microsoft.VSCode.UrlHandler.desktop"
    "kitty-open.desktop" "imv-dir.desktop" "kcm_netpref.desktop" "kcm_proxy.desktop" "kcm_trash.desktop"
    "kcm_webshortcuts.desktop" "org.kde.kiod6.desktop" "org.kde.knewstuff-dialog6.desktop"
    "org.kde.ksecretd.desktop" "org.kde.kwalletd.desktop" "org.kde.polkit-kde-authentication-agent-1.desktop"
    "thunar-bulk-rename.desktop" "thunar-settings.desktop" "thunar-volman-settings.desktop"
    "lstopo.desktop" "uuctl.desktop" "xgps.desktop" "xgpsspeed.desktop"
    "io.elementary.granite-7.demo.desktop" "ktelnetservice6.desktop" "org.freedesktop.Xwayland.desktop"
    "xdg-desktop-portal-gtk.desktop" "xfce4-about.desktop" "vim.desktop" "org.kde.dolphin.desktop"
)
for app in "${clutter_apps[@]}"; do
    if [ -f "/usr/share/applications/$app" ]; then
        cp "/usr/share/applications/$app" "$HOME/.local/share/applications/"
        if ! grep -q "NoDisplay=true" "$HOME/.local/share/applications/$app"; then
            echo "NoDisplay=true" >> "$HOME/.local/share/applications/$app"
        fi
    fi
done

echo "Installation complete!"
echo "Note: You will still need to log into Discord and Spotify as those configs were excluded to keep the repo clean."
