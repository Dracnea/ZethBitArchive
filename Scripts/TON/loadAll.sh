#!/bin/bash

start_range=0
clk=0
start_time=$(date +%s.%N)
wait_time=270

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
chipMap["A-U200-P64G"]="ft4232" #U200 passive 
chipMap["A-U200-A64G"]="ft4232" #U200 active


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

# for i in {0..6}; do
# 	if [[ -v boardName[$i] ]]; then
# 		chipMapValue="${boardName[$i]}"
# 	elif [[ -v deviceName[$i] ]]; then
# 		chipMapValue="${deviceName[$i]}"
# 	else
# 		chipMapValue="aaaaaa"
# 	fi
# 	echo $chipMapValue
# done

# Print the chip array
# for value in "${boardName[@]}"; do
#     echo "$value"
# done

# for value in "${deviceName[@]}"; do
#     echo "$value"
# done

#detect number of FPGA
sudo rm NUM_FPGA.txt
echo "${#boardName[@]}" > NUM_FPGA.txt

end_range=$(( ${#boardName[@]} - 1 ))
# echo "FPGA Index end $end_range"
if [ "$#" -lt 2 ]||([ "$#" -gt 1 ]&&[ "$2" != "--enable" ]); then
	echo "Not load bitstream"
	exit 0
fi


if [ "$#" -gt 0 ]; then
	clk="$1"
	clk=$((clk * 1000000))
else
	echo "Using ./loadAll clk_MHz --enable"
	exit 0
fi

for i in $(seq "$start_range" "$end_range")
do  
	chipMapKey="${boardName[$i]}"
	chipMapValue=""

	if [[ -v chipMap[$chipMapKey] ]]; then
		chipMapValue="${chipMap[$chipMapKey]}"
	else
		if [[ -v deviceName[$i] ]]; then
			chipMapKey="${deviceName[$i]}"
		else 
			chipMapKey=""
		fi
		if [[ -v chipMap[$chipMapKey] ]]; then
			chipMapValue="${chipMap[$chipMapKey]}"
		else 
			chipMapValue=""
		fi
	fi

	if [ "$chipMapKey" = "SQRL FK" ]; then
		clk=$((15 * 1000000))
		#wait_time=250
	else
		clk="$1"
		clk=$((clk * 1000000))
	fi
	echo "----Load bit for FPGA $i with clk $clk"

	if [ ${chipMapKey// /} == "XCVU13P" ]; then
		wait_time=240
	fi

	# if [ ${chipMapKey// /} == "XBB1525" ]; then
	# 	wait_time=200
	# fi

	# if [ ${chipMapKey// /} == "A-U200-PG64" ]; then
	# 	wait_time=200
	# fi

	# if [ ${chipMapKey// /} == "CB-U1-AEBE" ]; then
	# 	wait_time=200
	# fi

	if [ $chipMapValue = "" ]; then
		echo "Cannot load bitstream unknown board ${boardName[$i]}"
		echo "Cannot load bitstream unknown device ${deviceName[$i]}"
	fi

	if [ "$i" -lt "$end_range" ]; then
		echo "sudo ./openFPGALoader -c $chipMapValue --ftdi-serial ${serialList[$i]} -v --freq $clk ${chipMapKey// /} &"
    	sudo ./openFPGALoader -c $chipMapValue --ftdi-serial ${serialList[$i]} -v --freq $clk ${chipMapKey// /} &
	else
		echo "sudo ./openFPGALoader -c $chipMapValue --ftdi-serial ${serialList[$i]} -v --freq $clk ${chipMapKey// /} "
		sudo ./openFPGALoader -c $chipMapValue --ftdi-serial ${serialList[$i]} -v --freq $clk ${chipMapKey// /}  
	fi
done

end_time=$(date +%s.%N)
running_time=$(printf "%.0f" "$(echo "$end_time - $start_time" | bc)")
if [ $running_time -lt $wait_time ]; then
	remaining_time=$(echo "$wait_time - $running_time" | bc)
	remaining_time_int=$(printf "%.0f" "$remaining_time")
	echo "Remaining time $remaining_time_int ..."
	sleep $remaining_time_int
fi
end_time=$(date +%s.%N)
running_time=$(echo "$end_time - $start_time" | bc)
echo "Load bitstream time: $running_time seconds"