#!/bin/sh
# TrueOS System Install Menu
# Copyright 2016 iXsystems, Inc.
# http://www.trueos.com
# Author: Kris Moore
###########################################################################

. /root/functions.sh

while
i="1"
do

if [ -e "/usr/local/bin/startx" ] ; then
	dialog --title "TrueOS Installation Menu" --menu "Please select from the following options:" 20 55 15 xorg "Start graphical install (Auto-Detect Video) " vesa "Start graphical install (VESA)" scfb "Start graphical install (SCFB)" intel "Start graphical install (Legacy Intel)" install "Start text install" utility "System Utilities" reboot "Reboot the system" 2>/tmp/answer
else
  dialog --title "TrueOS Installation Menu" --menu "Please select from the following options:" 20 55 15 install "Start text install" utility "System Utilities" reboot "Reboot the system" 2>/tmp/answer
fi

ANS="`cat /tmp/answer`"

case $ANS in
    install) /usr/local/bin/pc-installdialog ;;
    xorg) echo "Starting graphical Installer (AutoDetect).. Please wait.."
          rm /etc/X11/xorg.conf 2>/dev/null
          start_xorg ;;
     vesa) echo "Starting graphical Installer (VESA).. Please wait.."
 cp /root/cardDetect/XF86Config.compat /etc/X11/xorg.conf
           startx 2>/tmp/Xerrors ;;
     scfb) echo "Starting graphical installer (SCFB).. Please wait.."
 cp /root/cardDetect/XF86Config.scfb /etc/X11/xorg.conf
           startx 2>/tmp/Xerrors ;;
     intel) echo "Starting graphical installer (Legacy Intel).. Please wait.."
 cp /root/cardDetect/XF86Config.intel /etc/X11/xorg.conf
           startx 2>/tmp/Xerrors ;;
    utility) /root/TrueOSUtil.sh
              clear ;;
     reboot)  reboot -q ;;
          *) ;;
esac

done
