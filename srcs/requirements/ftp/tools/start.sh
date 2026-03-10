#!/bin/bash

useradd -m -d /var/www/html $FTP_USER

# set user password
echo "$FTP_USER:$FTP_PASS" | chpasswd

chown -R $FTP_USER:$FTP_USER /var/www/html

vsftpd /etc/ftp.conf