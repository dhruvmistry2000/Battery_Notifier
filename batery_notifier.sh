#!/bin/bash

show_notification() {
    notify-send "Battery Notification" "$1"
}

while true; do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

    if [ "$battery_level" -eq 10 ]; then
        show_notification "Battery is fully charged. Please unplug the charger."
    elif [ "$battery_level" -eq 20 ]; then
        show_notification "Battery level is low (20%). Connect the charger."
    fi

    sleep 60 
done
