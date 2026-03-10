#!/bin/bash

useradd -m -d /var/www/html $FTP_USER

# set user password
echo "$FTP_USER:$FTP_PASS" | chpasswd

vsftpd /etc/ftp.conf