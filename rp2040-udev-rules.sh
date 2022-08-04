#!/usr/bin/env bash

# Original vendor "2e8a"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE:="0666"

# Actual vendor "2341"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", MODE:="0666"

rp2040rules () {
    echo ""
    echo "# Raspberry Pi RP2040 bootloader mode UDEV rules"
    echo ""
cat <<EOF
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", MODE:="0666"
EOF
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

rp2040rules > /etc/udev/rules.d/60-rp2040.rules

# reload udev rules
echo "Reload rules..."
udevadm trigger
udevadm control --reload-rules

