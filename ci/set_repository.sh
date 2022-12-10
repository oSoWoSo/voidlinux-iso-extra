#!/bin/sh

REPO='https://mirrors.dotsrc.org/voidlinux'

# Set repository for xbps
rm -fr /etc/xbps.d
mkdir -p -m 755 /etc/xbps.d
echo "repository=${REPO}/current" > /etc/xbps.d/repo-main.conf
echo "repository=${REPO}/current/nonfree" > /etc/xbps.d/repo-nonfree.conf
