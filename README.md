
# Battery Nofication Bash Script

I was having problems with charging my laptop as sometimes it would over charge
and sometimes it would shutdown because of discharge. So i made a shell script that notifies me when battery is 100% charged and also when battery reaches at 20% so that i can plug my charger and charge my laptop. You can install this script by following the steps below. Can can also change the values at which it notifies you by editing the values in script which is quiet easy. And this only works on linux as it is a shell script and i am using Ubuntu 23.04.







# Installation

## Install acpi


### Debain and Ubuntu
```bash
 apt-get install acpi
```

### Alpine 
```bash
apk add acpi
```
### Arch Linux

```bash
pacman -S acpi
```
### Fedora

```bash
dnf install acpi
```

## Clone the Repository

```bash
git clone 
```

## Give permission to the script

```bash
sudo chmod +777 battery_notifiier.sh
```

## Run it on startup

```bash
sudo mv script_path /etc/init.d
```
