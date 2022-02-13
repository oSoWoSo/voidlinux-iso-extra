#!/bin/sh

cd /root

[ ! -d 'void-packages' ] && git clone --depth 1 'https://github.com/void-linux/void-packages.git' 'void-packages'
[ ! -d 'custom-void-packages' ] && git clone --depth 1 'https://github.com/notchtc/custom-void-packages.git' 'custom-void-packages'

cp -r custom-void-packages/* void-packages/srcpkgs

cd void-packages

./xbps-src binary-bootstrap

custompkgs="connman dmenu libXft mksh numix-solarized-gtk-theme slock st stylua ytfzf"

for i in $custompkgs; do
    ./xbps-src pkg $i
done
