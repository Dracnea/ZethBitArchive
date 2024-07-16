#!/bin/bash

pool=stratum+tcp://nimiq.icemining.ca:2053
wallet=NQ59NTCV20L7GU6P6U325SMKA0SEJ12N6YFP
rig_name=Dracnea_CVP13
core_clock=300

complexWallet=$wallet.$rig_name

/ZethMultiMiner/ZetheronMiners/FPGAMinerNIM-Linux-v10 -o $pool -u $complexWallet -t $core_clock