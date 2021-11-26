#!/bin/bash

# Additional packages in the ISO
PKGS="bzip2 cryptsetup curl dialog ddrescue gnupg2 git gptfdisk gzip efibootmgr lvm2 makepasswd mdadm mosh nano p7zip rsync wget vim unzip xz zip"

yes y | xbps-install -Su xbps
yes y | xbps-install -Su
yes y | xbps-install -S git make
cd /root
[ ! -d 'void-mklive' ] && git clone 'https://github.com/void-linux/void-mklive.git'
cd 'void-mklive/'
make clean
make
./mklive.sh -a aarch64 -b rpi4-base -r 'https://mirrors.dotsrc.org/voidlinux/current/aarch64' -p "$PKGS"
