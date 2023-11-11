#!/bin/bash
#Current dir variable
	salt="tNk)s"
	pstr="U2FsdGVkX1/RHIs4Gn01SSJKlo1yvuMLLZCwFotJaPI="
	cred=$(echo $pstr | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$salt)
	oldpstr="U2FsdGVkX1+oIx2n7QFD/cd6UuXC9/WLbRehy/Y61kg="
	oldcred=$(echo $oldpstr | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$salt)
	curdir=$(dirname $(readlink -e "$0"))
	newdir=/usr/share

#Passchange
	(echo $cred | su - dcadmin -c "echo $cred | sudo -S install -m 777 /dev/null /usr/share/temp && echo $cred > /usr/share/temp") || (echo $oldcred | su - dcadmin -c "echo $oldcred | sudo -S install -m 777 /dev/null /usr/share/temp && echo $oldcred > /usr/share/temp") 
	pass=$(cat $newdir/temp)
	echo $pass | su - dcadmin -c "echo $pass | sudo rm $newdir/temp"

#Change background
	chmod +rw $curdir/wall
	echo $pass | su - dcadmin -c "echo $pass | sudo -S mv $curdir/wall $newdir/wall"
	echo $pass | su - dcadmin -c "echo $pass | sudo -S chmod 777 $newdir/wall"
	gsettings set org.gnome.desktop.background picture-uri "file://$newdir/wall"

#Change lockground
	cd $curdir
	echo $pass | su - dcadmin -c "echo $pass | sudo -S apt-get install libglib2.0-dev-bin -y"
	wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background && chmod +x ubuntu-gdm-set-background
	echo $pass | su - dcadmin -c "echo $pass | sudo -S $curdir/ubuntu-gdm-set-background --image $newdir/wall"

#
#reboot -i