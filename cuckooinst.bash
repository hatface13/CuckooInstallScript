#!/bin/bash

#Prep
sudo apt-get --assume-yes install curl

#Git
sudo apt-get --assume-yes install git

#Python Libraries
sudo apt-get --assume-yes install python python-pip python-dev libffi-dev libssl-dev
sudo apt-get --assume-yes install python-virtualenv python-setuptools
sudo apt-get --assume-yes install libjpeg-dev zlib1g-dev swig

#MongoDB & PostgreSQL
sudo apt-get --assume-yes install mongodb
sudo apt-get --assume-yes install postgresql libpq-dev

#VirtualBox
echo deb http://download.virtualbox.org/virtualbox/debian jessie contrib | sudo tee -a /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt-get --assume-yes update
sudo apt-get --assume yes install virtualbox-5.1

#TCPDump
sudo apt-get --assume-yes install tcpdump
sudo apt-get --assume-yes install libcap2-bin
sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

#Volatility
git clone https://github.com/volatilityfoundation/volatility.git

#M2Crypto
sudo pip install m2crypto==0.24.0

#YARA
sudo apt-get --assume-yes install  automake libtool make gcc
sudo apt-get --assume-yes install libjansson-dev
sudo apt-get --assume-yes install libssl-dev
sudo wget https://github.com/VirusTotal/yara/archive/v3.7.1.tar.gz

tar -zxf v3.7.1.tar.gz
cd yara-3.7.1
./bootstrap.sh

./configure --enable-cuckoo --enable-dotnet
make
sudo make install

make check

#User Creation

sudo adduser frank
#sudo usermod -a -G vboxusers scanner

echo "  *	hard	nofile	500000
	*	soft	nofile	500000
	root	hard	nofile	500000
	foot 	soft	nofile	500000 " >> /etc/security/limits.conf

#Cuckoo
virtualenv venv			#runs cuckoo in a virtual environment
. venv/bin/activate		#starts virtual environment

sudo pip install -U pip setuptools #updating pip and setuptools
sudo pip install -U cuckoo


