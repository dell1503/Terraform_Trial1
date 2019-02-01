#!/bin/bash

(crontab -l 2>/dev/null; echo "@reboot s3fs bitcoin-3876412:/  /media/bitcoin -o allow_other,iam_role='bitcoinec2'") | crontab -
(crontab -l 2>/dev/null; echo "@reboot /usr/bin/bitcoind -daemon -conf=/usr/bin/bitcoin.conf") | crontab -

s3fs bitcoin-3876412:/  /media/bitcoin -o allow_other,iam_role='bitcoinec2'
/usr/bin/bitcoind -daemon -conf=/usr/bin/bitcoin.conf
