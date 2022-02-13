#!/bin/bash
set -euo pipefail

# Additional packages in the ISO
PKGS='bzip2 cryptsetup curl gnupg git gptfdisk gzip efibootmgr lvm2 makepasswd mdadm p7zip wget unzip xz zip xorg-minimal xorg-fonts xf86-input-synaptics setxkbmap xbacklight xev xkill xmessage xprop xrandr xrdb base-devel mesa-dri vulkan-loader mesa-vulkan-radeon xf86-video-amdgpu mesa-vaapi mesa-vdpau bleachbit chrony cmus cmus-flac cmus-opus cmus-pulseaudio cmusfm iwd dunst ffmpeg firefox fzf gimp herbstluftwm hsetroot htop imv keepassxc legendary maim mpv neovim newsboat nicotine+ opendoas opus opusfile opustags pamixer picard qbittorrent steam telegram-desktop trash-cli xclip xf86-input-evdev xonotic xonotic-data-low yt-dlp zathura zathura-pdf-mupdf pipewire unclutter libX11-devel libXft-devel libXinerama-devel qt5ct dmenu libXft mksh numix-solarized-gtk-theme slock st stylua ytfzf'

# Base packages required for livecd
# Source: https://github.com/void-linux/void-mklive/blob/master/build-x86-images.sh.in
BASE_PKGS='dialog cryptsetup lvm2 mdadm void-docs-browse grub-i386-efi grub-x86_64-efi'

CUSTOM='https://github.com/notchtc/custom-void-packages/raw/repo/current'
REPO='https://void.sakamoto.pl/current'
MULTILIB='https://void.sakamoto.pl/current/multilib'
NONFREE='https://void.sakamoto.pl/current/nonfree'

# Set repository for xbps
rm -fr /etc/xbps.d
mkdir -p -m 755 /etc/xbps.d
echo "repository=$REPO" > /etc/xbps.d/00-repository-main.conf

xbps-install --yes -Su xbps
xbps-install --yes -Su
xbps-install --yes -S git make

cd '/root'
[ ! -d 'void-mklive' ] && git clone -b master --single-branch --depth 1 'https://github.com/void-linux/void-mklive.git' 'void-mklive'
cd 'void-mklive/'
make clean
make
./mklive.sh -a 'x86_64' -r "${MULTILIB}" -r "${NONFREE}" -r "${REPO}" -r "${CUSTOM}" -p "${BASE_PKGS} ${PKGS}"
