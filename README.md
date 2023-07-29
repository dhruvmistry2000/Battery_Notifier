
# Battery Notification Bash Script

I was having problems with charging my laptop as sometimes it would overcharge and sometimes it would shut down because of discharge. So I made a shell script that notifies me when the battery is 100% charged and also when the battery reaches 20% so that I can plug my charger and charge my laptop. You can install this script by following the steps below. Can also change the values at which it notifies you by editing the values in the script which is quite easy. And this only works on Linux as it is a shell script and i am using Ubuntu 23.04.







# Installation

## Install acpi


### Debain and Ubuntu
```bash
 sudo apt-get install acpi
```

### Alpine 
```bash
sudo apk add acpi
```
### Arch Linux

```bash
sudo pacman -S acpi
```
### Fedora

```bash
sudo dnf install acpi
```

## Clone the Repository

```bash
git clone https://github.com/dhruvmistry2000/Battery_Notifier.git
```

## Give permission to the script

```bash
sudo chmod +777 battery_notifiier.sh
```

## Run it on startup

```bash
sudo mv path/to/script /etc/init.d
```
