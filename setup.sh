#!/bin/bash

# Define color codes for output messages
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define the Git repository URL and local directory
REPO_DIR="$HOME/Github/Battery_Notifier"
REPO_URL="https://github.com/dhruvmistry2000/Battery_Notifier.git"

# Clone the repository if it doesn't already exist
if [ ! -d "$REPO_DIR" ]; then
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Install required packages based on the Linux distribution
if command -v apt-get &> /dev/null; then
    # For Debian-based systems
    sudo apt-get update
    sudo apt-get install -y acpi libnotify-bin
elif command -v pacman &> /dev/null; then
    # For Arch-based systems
    sudo pacman -Sy acpi libnotify
elif command -v dnf &> /dev/null; then
    # For Fedora
    sudo dnf install -y acpi libnotify
elif command -v zypper &> /dev/null; then
    # For openSUSE
    sudo zypper install -y acpi libnotify
elif command -v brew &> /dev/null; then
    # For Homebrew (macOS)
    brew install acpi libnotify
else
    echo -e "${RED}Unsupported distribution. Please install acpi and libnotify manually.${NC}"
    exit 1
fi

# Define paths for the script and installation
SCRIPT_NAME="$REPO_DIR/battery_notifier.sh"
INSTALL_DIR="/usr/local/bin"
AUTOSTART_DIR="$HOME/.config/autostart"

# Create the autostart directory if it doesn't exist
mkdir -p "$AUTOSTART_DIR"

# Copy the battery notifier script to the installation directory
sudo cp "$SCRIPT_NAME" "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Create a desktop entry for autostart
cat > "$AUTOSTART_DIR/battery-notifier.desktop" << EOL
[Desktop Entry]
Type=Application
Name=Battery Notifier
Exec=$INSTALL_DIR/$SCRIPT_NAME
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOL

# Make the desktop entry executable
chmod +x "$AUTOSTART_DIR/battery-notifier.desktop"

# Notify the user of successful installation
echo -e "${GREEN}Battery notifier has been installed and set to autostart.${NC}"
echo -e "${YELLOW}The script will start running on next login.${NC}"

# Start the script immediately in the background
nohup "$INSTALL_DIR/$SCRIPT_NAME" >/dev/null 2>&1 &
echo -e "${GREEN}Battery notifier is now running in the background.${NC}"

# Create a cron job to run the script every 2 minutes
(crontab -l 2>/dev/null; echo "*/2 * * * * $INSTALL_DIR/$SCRIPT_NAME") | crontab -
echo -e "${YELLOW}Cron job has been set to run the battery notifier every 2 minutes.${NC}"
