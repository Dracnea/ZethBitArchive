#!/bin/bash

#Voltage value
coremv=660

# Scan all micro usb devices
/opt/bwtk/2020.1L/bin/bwconfig --scan=usb
# Add scanned devices list to bwtools
/opt/bwtk/2020.1L/bin/bwconfig --add=usb
# TODO: Add for loop to go through each unit in list, grab list length
# Select first unit, set override, and set coremv
/opt/bwtk/2020.1L/bin/bwmonitor --dev=0 --fpgacorev_override=1 --fpgacorev_mv=$coremv