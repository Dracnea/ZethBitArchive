#!/bin/bash

start_range=0
clk=0
start_time=$(date +%s.%N)
wait_time=60

# Declare an associative array to create a map
declare -A chipMap

# Add key-value pairs to the map
chipMap["XCVU13P"]="ft232" # CVP13
chipMap["SQRL FK"]="ft2232" # FK33
chipMap["A-U55N"]="ft4232" # C1100
chipMap["U50C"]="ft4232" # ECU50
chipMap["TH53"]="ft4232" # TH53
chipMap["TH53M"]="ft4232" # TH53
chipMap["XCVU33P_CIV"]="ft4232" # TH53
chipMap["TH55"]="ft4232" # TH55
chipMap["CB-U1-AEBE"]="ft4232" # BCU1525
chipMap["XBB1525"]="ft4232" # ECU200
chipMap["A-U200-P64G"]="ft4232" #U200 


# Run the openFPGALoader and capture its output

output_boardName=$(sudo ./nextjtag | awk '/Board [0-9]*:/')
output_deviceName=$(sudo ./nextjtag | awk '/Device [0-9].*/')


# Initialize an empty array
declare -A boardName
declare -A deviceName
declare -A serialList

while read -r line; do
    board_number=$(echo "$line" | sed -n 's/Board \([0-9]\+\):.*/\1/p')
    board_name=$(echo "$line" | sed -n 's/Board [0-9]\+: \([^)]\+\) (serial: .*/\1/p')
    serial_number=$(echo "$line" | sed -n 's/.*serial: \([^),]\+\).*/\1/p')
    # echo "Board $board_number: $board_name, Serial: $serial_number"
	boardName["$board_number"]="$board_name"
	serialList["$board_number"]="$serial_number"
done <<< "$output_boardName"

while read -r line; do
    # if [[ $line =~ Device\ ([0-9]+)\ ([A-Z0-9]+) ]]; then
	if [[ $line =~ Device\ ([0-9]+)\.([0-9]+):\ ([A-Z0-9]+) ]]; then
		device_number="${BASH_REMATCH[1]}"
		device_name="${BASH_REMATCH[3]}"
		deviceName["$device_number"]="$device_name"
	fi
done < <(echo "$output_deviceName")

sudo rm NUM_FPGA.txt
echo "${#boardName[@]}" > NUM_FPGA.txt

/home/miner/Zetheron-Alphium-V2.1/alephium_bits/FK33/BurstlLoader -a -m -b /home/miner/Zetheron-Alphium-V1.1/alephium_bits/FK33/Alephium_FK33_Top.bit -b /home/miner/Zetheron-Alphium-V1.1/alephium_bits/FK33/K1.bit -b /home/miner/Zetheron-Alphium-V1.1/alephium_bits/FK33/K2.bit -b /home/miner/Zetheron-Alphium-V1.1/alephium_bits/FK33/K3.bit -b /home/miner/Zetheron-Alphium-V1.1/alephium_bits/FK33/K4.bit

sleep 60