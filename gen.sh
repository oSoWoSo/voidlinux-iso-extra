#!/bin/bash
set -euo pipefail

# Additional packages in the ISO
PKGS='bzip2 connman connman-ui cryptsetup curl gnupg git gptfdisk gzip efibootmgr lvm2 makepasswd mdadm p7zip wget unzip xz zip xorg-minimal xorg-fonts xf86-input-synaptics setxkbmap xbacklight xev xkill xprop xrandr xrdb base-devel mesa-dri vulkan-loader mesa-vulkan-radeon xf86-video-amdgpu mesa-vaapi mesa-vdpau bleachbit chrony cmus cmus-flac cmus-opus cmus-pulseaudio cmusfm iwd dunst ffmpeg firefox fzf gimp herbstluftwm hsetroot htop keepassxc maim mpv neovim newsboat nicotine+ opendoas opus opusfile pamixer picard qbittorrent telegram-desktop trash-cli xclip xf86-input-evdev yt-dlp zathura zathura-pdf-mupdf pipewire unclutter qt5ct polybar adwaita-plus elogind tlp xdg-user-dirs noto-fonts-emoji noto-fonts-cjk void-repo-nonfree nsxiv steam'

# Base packages required for livecd
# Source: https://github.com/void-linux/void-mklive/blob/master/build-x86-images.sh.in
BASE_PKGS='dialog cryptsetup lvm2 mdadm void-docs-browse grub-i386-efi grub-x86_64-efi'

REPO='https://mirrors.dotsrc.org/voidlinux/current'
NONFREE="$REPO/nonfree"

# Set repository for xbps
rm -fr /etc/xbps.d
mkdir -p -m 755 /etc/xbps.d
echo "repository=$REPO" > /etc/xbps.d/00-repository-main.conf
echo "repository=$NONFREE" > /etc/xbps.d/10-repository-nonfree.conf

xbps-install --yes -Su xbps
xbps-install --yes -Su
xbps-install --yes -S git make

cd '/root'
[ ! -d 'void-mklive' ] && git clone -b master --single-branch --depth 1 'https://github.com/void-linux/void-mklive.git' 'void-mklive'
cd 'void-mklive/'
make clean
make
./mklive.sh -a 'x86_64' -r "${NONFREE}" -r "${REPO}" -p "${BASE_PKGS} ${PKGS}"
