#!/bin/bash

# Additional packages in the ISO
PKGS="rpi4-base bzip2 cryptsetup curl dialog ddrescue gnupg2 git gzip makepasswd mdadm mosh nano p7zip rsync wget vim unzip xz zip"

yes y | xbps-install -Su xbps
yes y | xbps-install -Su
yes y | xbps-install -S git make base-system coreutils cross-aarch64-linux-gnu cross-aarch64-linux-gnu-libc
cd /root
[ ! -d 'void-mklive' ] && git clone 'https://github.com/void-linux/void-mklive.git'
cd 'void-mklive/'
make clean
make
./mklive.sh -a aarch64 -b rpi4-base -r 'https://alpha.de.repo.voidlinux.org/current/aarch64' -p "$PKGS"
