#!/bin/bash

pool=wss://nimiq.icemining.ca:2053
wallet=NQ92K9NXS6MSRE4CDR176GFAQN3B2Y5X6328
rig_name=Dracnea_CVP13
core_clock=300

if ! dpkg -l | grep -q "libftdi1-2"; then
	echo "Installing libftdi1-2..."
    sudo apt-get install libftdi1-2 -y
fi

/ZethMultiMiner/Miners/Nimiq/FPGAMinerNIM-Linux-v10 -o $pool -u $wallet -t $core_clock -p $rig_name --max-temp=80