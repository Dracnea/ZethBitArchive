#!/bin/bash
sudo rmmod ftdi_sio
sudo rmmod usbserial
./FPGAMinerGram -o stratum+tcp://ton.hashrate.to:4002 -u UQAZwEyMpjkLNP3I0ytqWT2N1oanX06hwM10gyN4KljABvT5 -p utesting -t 430 --fpga-nonce -z <your_serial_or_dna> 
