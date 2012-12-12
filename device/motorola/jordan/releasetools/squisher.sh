# This script is included in squisher
# It is the final build step (after OTA package)

DEVICE_OUT=$ANDROID_BUILD_TOP/out/target/product/jordan
DEVICE_TOP=$ANDROID_BUILD_TOP/device/motorola/jordan
VENDOR_TOP=$ANDROID_BUILD_TOP/vendor/motorola/jordan



# prebuilt boot, devtree, logo & updater-script
rm -f $REPACK/ota/boot.img
cp -f $DEVICE_TOP/updater-script $REPACK/ota/META-INF/com/google/android/updater-script
cat $DEVICE_TOP/updater-script-rel >> $REPACK/ota/META-INF/com/google/android/updater-script
#Modefied by Jerry.Qian, for MYUI-01951, 20120315
cp -f $VENDOR_TOP/boot-222-179-4.smg $REPACK/ota/boot.img
cp -f $VENDOR_TOP/devtree-222-179-2.smg $REPACK/ota/devtree.img
#Modefied by Jerry.Qian, for MYUI-01951, 20120315


