#!/bin/bash
cd /writable/var
cp -R /media/QUMOUSB_sdb1/mountScripts ./
cd mountScripts
chmod +x curl.sh
chmod +x curl-inject.sh
chmod +x curl
chmod +x curl-action.sh
chmod +x curl-inject-action.sh
cp 01_cssi_mount_usb.rules /writable/etc/udev/rules.d/01_monitoring_mount_usb.rules
udevadm control --reload-rules
echo 'Скрипты успешно записаны'