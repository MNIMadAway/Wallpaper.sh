#!/bin/bash
#Current dir variable
	dir=$(dirname $(readlink -e "$0"))
	#
	#cd $dir
	#echo $pic

#Change wallpaper
	mkdir /home/dcadmin/wallpaper
	mv $dir/wall /home/dcadmin/wallpaper/wall
	gsettings set org.gnome.desktop.background picture-uri "file:///home/dcadmin/wallpaper/wall"

#Change background
	wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background && chmod +x ubuntu-gdm-set-background
	echo 1 | sudo -S -u dcadmin sudo apt-get install libglib2.0-dev-bin -y
	echo 1 | sudo -S -u dcadminsudo $dir/ubuntu-gdm-set-background --image $pic

#
#sudo apt install lightdm -y
#reboot -i
