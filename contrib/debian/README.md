
Debian
====================
This directory contains files used to package slimecoind/slimecoin-qt
for Debian-based Linux systems. If you compile slimecoind/slimecoin-qt yourself, there are some useful files here.

## slimecoin: URI support ##


slimecoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install slimecoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your slimecoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/slimecoin128.png` to `/usr/share/pixmaps`

slimecoin-qt.protocol (KDE)

