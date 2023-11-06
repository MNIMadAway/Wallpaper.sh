#!/bin/bash
#Current dir variable
	curdir=$(dirname $(readlink -e "$0"))
	newdir=/home/dcadmin/wallpaper
	su="echo 1 | sudo -S -u root"
	#
	#cd $curdir
	#echo $pic

#Change wallpaper
	mkdir $newdir
	mv $curdir/wall $newdir/wall
	gsettings set org.gnome.desktop.background picture-uri "file://$newdir/wall"

#Change background
	cd $curdir
	echo 1 | sudo -S -u root apt-get install libglib2.0-dev-bin -y
	wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background && chmod +x ubuntu-gdm-set-background
	$su $curdir/ubuntu-gdm-set-background --image $newdir/wall

#
#reboot -i
