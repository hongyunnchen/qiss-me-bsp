#!/bin/sh

DEVICE_OUT=$ANDROID_BUILD_TOP/out/target/product/jordan_plus
DEVICE_TOP=$ANDROID_BUILD_TOP/device/motorola/jordan_plus
VENDOR_TOP=$ANDROID_BUILD_TOP/vendor/motorola/jordan_plus

# these scripts are not required
rm -f $PRODUCT_OUT/system/etc/init.d/03firstboot
rm -f $PRODUCT_OUT/system/etc/init.d/04modules

rm -f $PRODUCT_OUT/system/bin/logwrapper

# add an empty script to prevent logcat errors (moto init.rc)
touch $PRODUCT_OUT/system/bin/mount_ext3.sh
chmod +x $PRODUCT_OUT/system/bin/mount_ext3.sh

mkdir -p $PRODUCT_OUT/system/etc/terminfo/x
cp $PRODUCT_OUT/system/etc/terminfo/l/linux $PRODUCT_OUT/system/etc/terminfo/x/xterm

cp -f $PRODUCT_OUT/root/init $PRODUCT_OUT/system/bootmenu/2nd-init/init

# Use a prebuilt adbd configured for root access instead of normal one, for dev purpose
cp -f $PRODUCT_OUT/system/bootmenu/binary/adbd $PRODUCT_OUT/system/bin/adbd
#cp -f $DEVICE_OUT/root/sbin/adbd $REPACK/ota/system/bin/adbd

#cp -f $PRODUCT_OUT/bootmenu/binary/2nd-init $PRODUCT_OUT/system/bootmenu/binary/2nd-init

# use the static busybox as bootmenu shell
cp -f $PRODUCT_OUT/utilities/busybox $PRODUCT_OUT/system/bootmenu/binary/busybox

# ril fix
cp -f $PRODUCT_OUT/system/lib/hw/audio.a2dp.default.so $PRODUCT_OUT/system/lib/liba2dp.so

