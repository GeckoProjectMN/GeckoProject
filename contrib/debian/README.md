
Debian
====================
This directory contains files used to package geckocoind/geckocoin-qt
for Debian-based Linux systems. If you compile geckocoind/geckocoin-qt yourself, there are some useful files here.

## geckocoin: URI support ##


geckocoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install geckocoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your geckocoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/geckocoin128.png` to `/usr/share/pixmaps`

geckocoin-qt.protocol (KDE)

