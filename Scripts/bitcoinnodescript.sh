#!/bin/bash
# https://raw.githubusercontent.com/dell1503/Terraform_Trial1/master/Scripts/bitcoinnodescript.sh?token=ATvO-ndktJGbyvoUYqXLY4Hl76c7Zq15ks5cU0_NwA%3D%3D
echo "########### Variables"

config="/usr/bin/bitcoin.conf"
datadir="/media/bitcoin"
defaultuser="ubuntu"

echo "########### Install S3 Mount"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install s3fs
echo "user_allow_other" >> /etc/fuse.conf

echo "########### Changing to home dir"
cd ~
echo "########### Install Bitcoin"

sudo apt-add-repository  --assume-yes  -y ppa:bitcoin/bitcoin
sudo apt-get  --assume-yes -y install bitcoind

echo "########### Creating Swap"
#dd if=/dev/zero of=/swapfile bs=1M count=2048 ; mkswap /swapfile ; swapon /swapfile
#echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

echo "########### Creating config"
config="/usr/bin/bitcoin.conf"
datadir="/media/bitcoin"

sudo touch $config
sudo echo "server=1" > $config
sudo echo "daemon=1" >> $config
sudo echo "datadir="$datadir >> $config
sudo echo "connections=40" >> $config
randUser=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30`
randPass=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30`
sudo echo "rpcuser=$randUser" >> $config
sudo echo "rpcpassword=$randPass" >> $config

echo "############ Create Folders & Premissions"
sudo mkdir $datadir
sudo chmod -R a+rwx /home/$defaultuser/.bitcoin
sudo chmod -R a+rwx $datadir

echo "########### Setting up autostart (cron)"

sudo -u $defaultuser (crontab -l 2>/dev/null; echo "@reboot s3fs bitcoindatadirtest:/  /media/bitcoin -o allow_other,iam_role='bitcoinec2'") | crontab -

sudo -u $defaultuser (crontab -l 2>/dev/null; echo "@reboot /usr/bin/bitcoind -daemon -conf=/usr/bin/bitcoin.conf") | crontab -

sudo -u $defaultuser s3fs bitcoindatadirtest:/  /media/bitcoin -o allow_other,iam_role='bitcoinec2'

# reboot
