#!/bin/bash

# Define color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if required packages are installed
if ! command -v acpi &> /dev/null || ! command -v notify-send &> /dev/null; then
    echo -e "${YELLOW}Required packages not found. Installing...${NC}"
    curl -s https://raw.githubusercontent.com/dhruvmistry2000/Battery_Notifier/refs/heads/main/setup.sh | bash
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
        show_notification "${GREEN}Battery is fully charged. Please unplug the charger.${NC}"
    elif [ "$charging_status" = "Discharging" ]; then
        show_notification "${YELLOW}Battery is discharging. Current level: $battery_level%${NC}"
        if [ "$battery_level" -le 20 ]; then
            show_notification "${YELLOW}Battery level is low ($battery_level%). Connect the charger.${NC}"
        elif [ "$battery_level" -le 10 ]; then
            show_notification "${RED}Battery level is critically low ($battery_level%)! Connect the charger immediately.${NC}"
        fi
    fi

    sleep 180  # Sleep for 3 minutes
done
