#!/bin/bash
#Current dir variable
	SALT="tNk)s"
	PSTR="U2FsdGVkX1/RHIs4Gn01SSJKlo1yvuMLLZCwFotJaPI="
	CRED=$(echo $PSTR | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$SALT)
	curdir=$(dirname $(readlink -e "$0"))
	newdir=/home/dcuser/wallpaper
	#echo $CRED | su - dcadmin -c ""
	#
	#cd $curdir
	#echo $pic

#Change backpaper
	mkdir $newdir
	chmod +rw $curdir/wall
	mv $curdir/wall $newdir/wall
	gsettings set org.gnome.desktop.background picture-uri "file://$newdir/wall"

#Change lockground
	cd $curdir
	echo $CRED | su - dcadmin -c "sudo apt-get install libglib2.0-dev-bin -y"
	wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background && chmod +x ubuntu-gdm-set-background
	echo $CRED | su - dcadmin -c "$curdir/ubuntu-gdm-set-background --image $newdir/wall"

#
#reboot -i