# My Dotfiles

This repository contains my personal configurations for Arch Linux (Hyprland), including themes, apps, and system settings.

## What's Included

- **Window Manager:** Hyprland
- **App Launcher:** Wofi
- **Bar:** Waybar
- **Terminal:** Kitty
- **Shell:** Bash (with custom Neon Cyberpunk prompt)
- **File Manager:** Thunar
- **Media:** MPV (Video Player), IMV (Image Viewer)
- **Apps:** Spotify, Discord (Configs excluded for cleanliness)
- **System Monitors & Notifications:** Btop, SwayNC
- **Login Manager Theme:** SDDM (Cyberpunk Theme)

## Installation

An automated installation script is provided to install all necessary packages (via `yay`) and copy configurations to their respective locations.

### Prerequisites
- Arch Linux (or an Arch-based distro)
- `yay` (AUR helper) installed
- `git` installed

### Quick Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/Desktop/dotfiles
   cd ~/Desktop/dotfiles
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```
   *Note: The script will prompt for your `sudo` password to install system packages and apply the SDDM theme.*

3. **Post-Installation:**
   - Log into Discord and Spotify.
   - Reboot or restart your display manager to see the new SDDM theme and enter Hyprland.

## Manual Configuration (Optional)

If you prefer to copy things manually:

- Copy contents of `config/` to your `~/.config/` directory.
- Copy `bashrc` to `~/.bashrc`.
- Copy `sddm-theme/cyberpunk/` to `/usr/share/sddm/themes/cyberpunk`.
- Update your `/etc/sddm.conf` to include:
  ```ini
  [Theme]
  Current=cyberpunk
  ```

## License
Feel free to use and modify these dotfiles!
