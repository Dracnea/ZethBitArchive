#!/bin/bash

units=4

sudo ./setVoltage.sh
sleep 40
sudo ./loadAll.sh
sleep 40

for i in units
do
	sudo screen -d -m -S GRAM$i ./startMiner.sh
	sleep 30
done
