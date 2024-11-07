# bwtools 18.04 on mmpos 22.04

## bwtools Dependency List

Note the following:
- libqt4-dbus
- libqt4-network
- libqtcore4
- libqtgui4
- libusb-0.1.4
- php7.2-cli
- php7.2-dev
- make
- linux-headers
- qdbus
- gdb

## Pre Dependency Installation:

Perform standard Update and Upgrade

`sudo apt update`

`sudo apt upgrade`

Install the vim tool

`sudo apt -y install vim`

## Modify mmpOS for Package Installation Compatability:

Open the following file:

`sudo vim /etc/lsb-release`

Press 'i' for insert mode

Change DISTRIB_NAME from 'MMP' to 'Ubuntu'

Change DISTRIB_RELEASE to '22.04'

Hit escape, type :wq, and hit enter to save and exit.

Now open the following file:

`sudo vim /usr/lib/python3/dist-packages/aptsources/distro.py`

Within this file search for "for template in self.sourceslist.matcher.templates:"
        
Press 'i' for insert mode

Before the searched section add:
        
`if(self.id  == 'Mmp'): self.id = 'Ubuntu'`
    
Hit escape, type :wq, and hit enter to save and exit.

## Install Libqt

`sudo apt install software-properties-common`

`sudo add-apt-repository ppa:ubuntuhandbook1/ppa`

`sudo apt update`

`sudo apt install -y qt4-default`

## Install libusb

`sudo apt install -y libusb01.0-0-dev`

`sudo apt-get install libusb-0.1-4`

## Install php7.2

Install base dependency:

`sudo apt install software-properties-common`

Grab the custom apt-repository for php:
    
`sudo add-apt-repository ppa:ondrej/php`

Install, this will handle both php -core and -cli dependencies

`sudo apt update`

`sudo apt install -y php7.2-dev`

## Install make

`sudo apt install make`

## Install linux-headers

`sudo apt-get install linux-headers-generic`

## Install qdbus

`sudo apt install qdbus`

## Install gdb

`sudo apt install gdb`

## Install bwtools deb file

Run dpkg to install the included db package.

`sudo dpkg -i bw2tk-lite-2020.1.u18.04.amd64.deb`

In the event that dependencies are not met and errors arise you will have to perform

`sudo mv /var/lib/dpkg/info/bw2tk-lite-2020.1.* /tmp/`

Follow this with:

THEN

`sudo dpkg --purge --force-all bw2tk-lite-2020.1`

OR

`sudo dpkg --remove --force-remove-reinstreq bw2tk-lite-2020.1`
