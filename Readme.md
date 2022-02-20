# voidlinux-iso-extra

This is an unofficial ISO (x86_64) for [Linux Void](https://voidlinux.org/). It has basically most of the packages used in my setup.

This repo contains instruction for building it yourself. If you want more programs to be included in ISO then fork this repository, edit `gen.sh` and regenerate ISO yourself.

## Download ISO
The ISO is in Actions.

## Regenerate ISO

Internet is required for your system and also for Void inside VirtualBox.

1. Install VirtualBox.
2. Download latest minimal ISO for x86_64 from official website [https://alpha.de.repo.voidlinux.org/live/current/](https://alpha.de.repo.voidlinux.org/live/current/) (e.g. `void-live-x86_64-20191109.iso`).
3. Add new system to VirtualBox.
    * Create 6 GB virtual disk hard drive.
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

## Regenerate ISO using Github Actions

I don't use GA for this project and generate ISOs by hand (method above). However it could be useful for other people so I added text file with workflow that generates ISO triggered by commit push.

Steps:

1. Fork this repository.
2. Enable Github Actions in github settings for your forked repository.
3. Modify file(s) and push commit to github. You have two options:
    * It is possible that you want add more programs to the ISO. In that case edit file `gen.sh` and append programs/packages to variable `PKGS`. Create git commit and push it to github.
    * If you do not want change list of programs then create empty file with arbitrary name. Create git commit and push it to github. Build is triggered by new git commit so you have to change something in repository.
4. Wait for build to complete (around 8 minutes last time I checked).
5. Download artifact (ISO file) from github.

Done!

(You can modify workflow to trigger build, e.g., every month. [See Github Actions documentation](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions#onschedule).)

## Continuous Integration

In repo are configurations for generating ISO using:

* Github Actions
* Gitlab CI (currently broken)
* CircleCI

I tested configurations after creating them so they should work. It is also possible that with passing of time there were changes in CI and they stopped working.

Keep in mind I'm not interested in teaching how to use CI so do not ask questions here about it. Search for help in forums for beginners and/or official documentation.

## Customize ISO

If you want to add more programs/packages to ISO then append names to variable `PKGS` in file `gen.sh` and regenerate ISO. You can check [available packages on void's website](https://voidlinux.org/packages/?arch=x86_64).

If you want to do something else check what official script [void-mklive](https://github.com/void-linux/void-mklive) can do. Supported parameters are defined in [usage() function](https://github.com/void-linux/void-mklive/blob/master/mklive.sh.in). Script `mklive` is executed in the last line of `gen.sh`.
