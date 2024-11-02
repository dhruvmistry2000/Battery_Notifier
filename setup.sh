#!/bin/bash

# Define paths
SCRIPT_NAME="battery_notifier.sh"
INSTALL_DIR="/usr/local/bin"
AUTOSTART_DIR="$HOME/.config/autostart"

# Create autostart directory if it doesn't exist
mkdir -p "$AUTOSTART_DIR"

# Copy the battery notifier script to install directory
sudo cp "$SCRIPT_NAME" "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Create desktop entry for autostart
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

echo "Battery notifier has been installed and set to autostart."
echo "The script will start running on next login."

# Start the script immediately
nohup "$INSTALL_DIR/$SCRIPT_NAME" >/dev/null 2>&1 &

echo "Battery notifier is now running in the background."
