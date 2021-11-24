#!/bin/bash

# Additional packages in the ISO
PKGS="void-repo-nonfree bzip2 cryptsetup curl dialog ddrescue gnupg2 git gptfdisk gzip efibootmgr lvm2 makepasswd mdadm mosh nano p7zip rsync wget vim unzip xz zip"

yes y | xbps-install -Su xbps
yes y | xbps-install -Su
yes y | xbps-install -S git make void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
cd /root
[ ! -d 'void-mklive' ] && git clone 'https://github.com/void-linux/void-mklive.git'
cd 'void-mklive/'
make clean
make
./mklive.sh -a aarch64 -r 'https://mirrors.dotsrc.org/voidlinux/current/aarch64' -p "$PKGS"
