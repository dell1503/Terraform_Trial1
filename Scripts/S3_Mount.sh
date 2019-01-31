#!/bin/bash
sudo apt-get update
sudo apt-get install s3fs
echo "user_allow_other" >> /etc/fuse.conf
sudo echo "s3fs#bitcoindatadirtest:/ /media/bitcoin fuse allow_other,iam_role="bitcoinec2" 0 0" >> /etc/fstab

s3fs bitcoindatadirtest:/  /media/bitcoin -o allow_other,iam_role="bitcoinec2"