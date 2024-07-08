#!/bin/bash
sudo rmmod ftdi_sio
sudo rmmod usbserial
./cpuminer -o stratum+tcp://fi.chapa.hashrate.to:4002 --chapa -u chapa:UQBdDtzna0KwR0vG-AthEm0SEQxwQJm4FixxPv6Uny-tIFEf -p utesting -t 430 --fpga-nonce -z <your_serial_or_dna> 
