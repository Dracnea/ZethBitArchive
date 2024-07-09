#!/bin/bash


#Ton Wallet Address
wallet=UQCKtIStgjhc1GGUlOWo9FPuB75VY7nPjBj72WB-n-0zby2R

#Pool URL
pool=stratum+tcp://ton.hashrate.to:4002

#Password
pass=x

#Worker ID
workerID=Dracnea_CVP13

#Core Mining Clock
clock=540

#Implement Chapa check
tokenType=GRAM # CHAPA GPU

DNA=4002000001291388445025c5

complexWallet=$wallet.$workerID

#check libftdi1-2 libarary
#only run once if upon startup a libftdi error occurs

#if ! dpkg -l | grep -q "libftdi1-2"; then
#	echo "Installing libftdi1-2..."
#    sudo apt-get install libftdi1-2 -y
#fi

sudo rmmod ftdi_sio
sudo rmmod usbserial

#ps -aux | grep FPGAMinerGram | awk '{print $2}' | sudo xargs kill -9


if tokenType == 'CHAPA'; then
	complexWallet=chapa:$wallet.$workerID
fi

sudo ./FPGAMinerGram -o $pool -u $complexWallet -p $pass -t $clock --fpga-nonce -z $DNA
