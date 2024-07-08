#!/bin/bash
sudo rmmod ftdi_sio
sudo rmmod usbserial
./FPGAMinerGram -o stratum+tcp://de.gpu.hashrate.to:4002 --gpum2m -u gpu:UQBdDtzna0KwR0vG-AthEm0SEQxwQJm4FixxPv6Uny-tIFEf -p utesting -t 430 --fpga-nonce -z <your_serial_or_dna> 
