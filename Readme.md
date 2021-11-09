# voidlinux-iso-extra

This is almost official ISO for [Linux Void](https://voidlinux.org/). It has few additional packages that I find essential but are missing in official ISO.

This repo contains instruction for building it yourself and link to ISO generated by me.

## Download ISO

2021-10-20:
* checksum [void-live-x86_64-5.13.19_1-20211020.iso.checksum](https://raw.githubusercontent.com/kotoko/voidlinux-iso-extra/master/void-live-x86_64-5.13.19_1-20211020.iso.checksum)
* ISO [void-live-x86_64-5.13.19_1-20211020.iso](https://github.com/kotoko/voidlinux-iso-extra/releases/download/2021-10-20/void-live-x86_64-5.13.19_1-20211020.iso)
* ISO [void-live-x86_64-5.13.19_1-20211020.iso](https://www.dropbox.com/s/5o7rf21rtqufqe4/void-live-x86_64-5.13.19_1-20211020.iso?dl=1)

## Regenerate ISO

Internet is required for your system and also for Void inside VirtualBox.

1. Install VirtualBox.
2. Download latest minimal ISO for x86_64 from official website [https://alpha.de.repo.voidlinux.org/live/current/](https://alpha.de.repo.voidlinux.org/live/current/) (e.g. `void-live-x86_64-20191109.iso`).
3. Add new system to VirtualBox.
    * Create 6GB virtual disk hard drive.
    * Add more RAM (1-2 GB should be OK).
    * Add more CPU (2 is already better)
4. Install Voidlinux in virtualbox.
    * Run Voidlinux from RAM (will be faster).
    * Login as root.
    * Run `void-installer`.
    * Choose local installation (not network installation).
    * Create one partition for /.
    * After installation reboot into new system (not livecd again).
5. Login as root.
6. Copy gen.sh into any ssh server.
7. Use scp to download gen.sh into /root/ in Voidlinux inside virtualbox. (E.g. `scp me@myserver:gen.sh /root`)
8. Run script: `bash /root/gen.sh`
9. New ISO will be in folder /root/void-mklive/. Use scp to copy it outside VirtualBox.

Done!

## Github Actions

I don't use GA for this project and generate ISOs by hand. However it could be useful for others so I added text file with workflow to repository.

I created workflow for GA that generates ISO on commit push. It almost works (is bugged). Script generates ISO which is ~100 MB when ISO generated by hand in virtualbox is ~500 MB. There are lines in the log that mentions problems during (u)mounting filesystem. So treat this workflow as draft. If you manage to fix this bug feel free to create issue with details.

```
[...]
[7/9] Cleaning up rootfs...
mount: /root/void-mklive/tmp.7IAqxqei4Q/tmp-rootfs: wrong fs type, bad option, bad superblock on /dev/loop3, missing codepage or helper program, or other error.
[8/9] Generating squashfs image (xz) from rootfs...
umount: /root/void-mklive/tmp.7IAqxqei4Q/tmp-rootfs: not mounted.
[...]
```
