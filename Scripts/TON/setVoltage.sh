#!/bin/bash

./changeVoltage --fpga_vcc_int=610 --debug --hardware=fpga --fpga_clk_core=50  -a ironfish -o stratum+tcp://de.ironfish.herominers.com:1145 -u eda8dccba5acb4a93deb6939e78a8527ca4fced470e612ca6407b1b4dc635202 -u 1HsKNeobhZvQRb3KQhet2PKnb79gwWuu6q &
FOO_PID=$!
sleep 40
kill -9 $FOO_PID