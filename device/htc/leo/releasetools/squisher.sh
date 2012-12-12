#!/bin/sh
# This script is included in squisher
# It is the final build step (after OTA package)

echo "updater-script: Making MAGLDR/CLK Compatible Update script"
cd $REPACK/ota/META-INF/com/google/android
echo 'assert(getprop("ro.product.device") == "leo" || getprop("ro.build.product") == "leo");' >> temp
#Brian add CLK/magldr update script start
echo 'package_extract_file("boot/checksys.sh","/tmp/checksys.sh");' >> temp
echo 'set_perm(0, 0, 755, "/tmp/checksys.sh");' >> temp
echo 'run_program("/tmp/checksys.sh");' >> temp
echo 'if file_getprop("/tmp/nfo.prop","clk") == "true" then' >> temp
echo '  ui_print("cLK Bootloader found.");'  >> temp
echo '  ui_print("Flashing cLK kernel...");' >> temp
echo '  assert(' >> temp
echo '    package_extract_file("boot/initrd.gz", "/tmp/initrd.gz"),' >> temp
echo '    package_extract_file("boot/zImage", "/tmp/zImage"),' >> temp
echo '    package_extract_file("boot/mkbootimg","/tmp/mkbootimg"),' >> temp
echo '    package_extract_file("boot/mkbootimg.sh","/tmp/mkbootimg.sh"));' >> temp
echo '  set_perm(0, 0, 0755, "/tmp/mkbootimg");' >> temp
echo '  set_perm(0, 0, 0755, "/tmp/mkbootimg.sh");' >> temp
echo '  assert(' >> temp
echo '    run_program("/tmp/mkbootimg.sh"),' >> temp
echo '    write_raw_image("/tmp/boot.img", "boot"),' >> temp
echo '    delete("/tmp/boot.img"));' >> temp
echo '  #package_extract_dir("boot/clk-ppp-patch", "/system");' >> temp
echo '  #set_perm(0, 0, 0777, "/system/etc/init.d/97ppp");' >> temp
echo 'else' >> temp
echo '  ui_print("MAGLDR Bootloader found.");' >> temp
echo '  ui_print("Flashing MAGLDR kernel...");' >> temp
echo '  mount("yaffs2", "MTD", "boot", "/boot");' >> temp
echo '  package_extract_dir("boot", "/boot");' >> temp
echo '  unmount("/boot");' >> temp
echo '  #delete("/system/ppp");' >> temp
echo '  #delete("/system/etc/init.d/97ppp");' >> temp
echo 'endif;' >> temp
echo '#set_perm_recursive(0, 2000, 0755, 0750, "/system/etc/init.d");' >> temp
echo '#set_perm(0, 0, 0755, "/system/etc/init.d");' >> temp
echo '#set_perm_recursive(0, 1001, 0755, 0775, "/system/etc/ppp");' >> temp
echo '#set_perm(0, 0, 04755, "/system/bin/pppd");' >> temp
#Brian add CLK/magldr update script end
grep -vw assert  updater-script >> temp
rm -rf updater-script
#Brian add CLK/magldr update script start
grep -vw 'package_extract_file("boot.img", "/tmp/boot.img")'  temp > updater-script
#Brian add CLK/magldr update script end
rm -rf temp

cd $REPACK/ota
echo "Removing: $REPACK/ota/boot.img"
rm -rf $REPACK/ota/boot.img
echo "Removing: $REPACK/ota/boot"
rm -rf $REPACK/ota/boot

echo "Copying: $OUT/boot ($REPACK/ota/boot)"
cp -a $OUT/boot $REPACK/ota/boot

if [ ! -e $REPACK/ota/boot/initrd.gz ] ; then
  echo "Copying: $OUT/ramdisk.img ($REPACK/ota/boot/initrd.gz)"
  cp -a $OUT/ramdisk.img $REPACK/ota/boot/initrd.gz
fi

