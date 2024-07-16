#!/bin/bash
top=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/CVP_Top_-1.136.bit
b1=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore1_WNS_-1.648.bit
b2=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore2_WNS_-1.809.bit
b3=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore3_WNS_-1.834.bit
b4=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore4_WNS_-1.707.bit
b5=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore5_WNS_-1.378.bit
b6=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore6_WNS_-1.769.bit
b7=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore7_WNS_-1.681.bit
b8=/ZethMultiMiner/Bitstreams/Nimiq/CVP13/SuperCore8_WNS_-1.696.bit
/ZethMultiMiner/Tools/nextjtagtools/nextjtag -m -f xcvu13p -b $top -b $b1 -b $b2 -b $b3 -b $b4 -b $b5 -b $b6 -b $b7 -b $b8
