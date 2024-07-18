#!/bin/bash
top=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/BCU_Ximiq_Top_B.bit
b1=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/SuperCore1_WNS_-2.088.bit
b2=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/SuperCore2_WNS_-2.121.bit
b3=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/SuperCore3_WNS_-2.43.bit
b4=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/Supercore4_WNS_-2.185.bit
b5=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/SuperCore5_WNS_-2.135.bit
b6=/ZethMultiMiner/Bitstreams/Nimiq/BCU1525/SuperCore6_WNS_-1.85.bit
/ZethMultiMiner/Tools/nextjtagtools/nextjtag -m -f xcvu13p -b $top -b $b1 -b $b2 -b $b3 -b $b4 -b $b5 -b $b6
