#!/tmp/busybox sh
#
# Universal Updater Script for Samsung Galaxy S Phones
# (c) 2011 by Teamhacksung
# Combined GSM & CDMA version
#

check_mount() {
    if ! /tmp/busybox grep -q $1 /proc/mounts ; then
        /tmp/busybox mkdir -p $1
        /tmp/busybox umount -l $2
        if ! /tmp/busybox mount -t $3 $2 $1 ; then
            /tmp/busybox echo "Cannot mount $1."
            exit 1
        fi
    fi
}

set -x
export PATH=/:/sbin:/system/xbin:/system/bin:/tmp:$PATH

# Check if we're in CDMA or GSM mode
# GSM mode
IS_GSM='/tmp/busybox true'
SD_PART='/dev/block/mmcblk0p1'
DATA_PART='/dev/block/mmcblk0p2'

# check if we're running on a bml, mtd (cm7) or mtd (current) device

if /tmp/busybox test -e /dev/block/mtdblock0 ; then
    # we're running on a mtd (current) device

    # make sure sdcard is mounted
    check_mount /sdcard $SD_PART vfat

    # update install - flash boot image then skip back to updater-script

    # flash boot image
     /tmp/bml_over_mtd.sh boot 72 reservoir 2004 /tmp/boot.img

    exit 0
fi

