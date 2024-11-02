#!/bin/bash

# Install required packages based on distribution
if command -v apt-get &> /dev/null; then
    # Debian-based
    sudo apt-get update
    sudo apt-get install -y acpi libnotify-bin
elif command -v pacman &> /dev/null; then
    # Arch-based
    sudo pacman -Sy acpi libnotify
elif command -v dnf &> /dev/null; then
    # Fedora
    sudo dnf install -y acpi libnotify
else
    echo "Unsupported distribution. Please install acpi and libnotify manually."
    exit 1
fi

show_notification() {
    notify-send "Battery Notification" "$1"
}

while true; do
    # Get battery level and charging status
    battery_info=$(acpi -b)
    battery_level=$(echo "$battery_info" | grep -P -o '[0-9]+(?=%)')
    charging_status=$(echo "$battery_info" | grep -o "Charging\|Discharging")

    # Check battery level and status
    if [ "$charging_status" = "Charging" ] && [ "$battery_level" -ge 95 ]; then
        show_notification "Battery is fully charged. Please unplug the charger."
    elif [ "$charging_status" = "Discharging" ]; then
        show_notification "Battery is discharging. Current level: $battery_level%"
        if [ "$battery_level" -le 20 ]; then
            show_notification "Battery level is low ($battery_level%). Connect the charger."
        elif [ "$battery_level" -le 10 ]; then
            show_notification "Battery level is critically low ($battery_level%)! Connect the charger immediately."
        fi
    fi

    sleep 180  # Sleep for 3 minutes
done
