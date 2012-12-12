#!/sbin/sh

sleep 2

if [[ "`grep clk= /proc/cmdline`" == "" ]]; then
sed -i 's/\/boot\t\tmtd/\/boot\t\tyaffs2/g' /etc/recovery.fstab
fi

# Commented out as it may or may not require this
#mount /dev/block/mmcblk0p2 /sd-ext | grep sd-ext | awk '{print $5}'
#FS=`mount | grep sd-ext | awk '{print $5}'`
#umount /sd-ext
#sed -i 's/\/sd-ext\ \ \ \ \ auto/\/sd-ext\t\t'$FS'/g' /etc/recovery.fstab
#cat >> /etc/fstab << EOF
#/dev/block/mmcblk0p2 /sd-ext $FS rw
#EOF
