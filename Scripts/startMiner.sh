#!/bin/bash


#Alephium Wallet Address
wallet=1ueouD2tTePMuXpkeTpXcahwgjGhDBMcWrR3ZS4zuNWh

#Pool URL
pool=stratum+tcp://us.vipor.net:5051

#Worker ID
workerID=ZetheronAlphium


#Temperature Threshold (Celcius); if temp exceeds this the miner will shut down
maxtemp=80

#mininglock; you can set clock per cards, they identified by "," characters; for example clock=clock1,clock2,clock3...,clockn
clock=600,610

# core voltage (vccInt) in MV to set cards to
vccInt=600

skipCommand=0 

#skipCommand=0 : change vccInt and load bitstream  before mining 
#( BCU1525, U200, CVP13 will NOT work with skipCommand=0, and please use skipCommand=1 or skipCommand=2 combine with nextjtag license to set voltage)
#skipCommand=1: load bitstream only before mining
#skipCommand=2: don't load bitstream, don't change vccInt before mining

#check libftdi1-2 libarary
if ! dpkg -l | grep -q "libftdi1-2"; then
	echo "Installing libftdi1-2..."
    sudo apt-get install libftdi1-2 -y
fi


# while true; do
			
			ps -aux |grep ZetheronAlephium  |  awk '{print $2}' |sudo  xargs kill -9

			sudo ./ZetheronAlephiumV2.1 -o $pool  -u $wallet.$workerID --max-temp=$maxtemp -t $clock  -l 15 -v $vccInt --skip $skipCommand -p 4

# 	echo "Restarting the miner in 10 seconds..."
# 	sleep 10
# done

