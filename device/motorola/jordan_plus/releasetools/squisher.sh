# This script is included in squisher
# It is the final build step (after OTA package)

DEVICE_OUT=$ANDROID_BUILD_TOP/out/target/product/jordan_plus
DEVICE_TOP=$ANDROID_BUILD_TOP/device/motorola/jordan_plus
VENDOR_TOP=$ANDROID_BUILD_TOP/vendor/motorola/jordan_plus



# prebuilt boot, devtree, logo & updater-script
rm -f $REPACK/ota/boot.img
cp -f $DEVICE_TOP/updater-script $REPACK/ota/META-INF/com/google/android/updater-script
# delete by Brian for Defy+ BL5/6/7 kernel support
# cat $DEVICE_TOP/updater-script-rel >> $REPACK/ota/META-INF/com/google/android/updater-script
#Modefied by Jerry.Qian, for MYUI-01951, 20120315
  #cp -f $VENDOR_TOP/boot-234-134.smg $REPACK/ota/boot.img
  #cp -f $VENDOR_TOP/devtree-234-134.smg $REPACK/ota/devtree.img
#Modefied by Jerry.Qian, for MYUI-01951, 20120315
# delete by Brian for Defy+ BL5/6/7 kernel support

