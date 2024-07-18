# FPGA Miner Gram
Latest is v2.0.11

## Troubeshooting
### Device/Bitstream not found/recognized on Linux
```
sudo rmmod ftdi_sio
sudo rmmod usbserial
sudo ./FPGAMinerGram...
```
### Only detecting one device
This is an old miner that will be replaced shortly and only supports one device per instance of the miner software. Run a second instance for your second device and specify the device you wish it to connect to with the ```-z``` option using either the serial number or the DNA.
### Doesn't connect to device based on my DNA
Some devices don't report their DNA until after the bitstream is loaded, so you can specify the device by serial number instead using the same flag. 
For devices that report their serial number with an A-D for each of the sub-devices/interfaces on the FTDI chip, use the root serial number without A-D.  
### Err % is higher than 1.5%
Set your clock a little lower or voltage a little higher. Too low of clock or voltage can also cause this. See the coin specific thread on Discord regarding your bitstream.
### sqrl_bridge
If your device uses sqrl_bridge, currently there is only support on Linux.

### Watchdog Timeout and Disconnects
Use the ```-w``` option to set a longer timeout 

### Exits when pool disconnects
Use the ```-r``` option to set how many retries or -1 for infinite


