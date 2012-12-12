#!/sbin/sh
/tmp/mkbootimg --base 0x11800000 --cmdline 'no_console_suspend=1 console=null' --kernel /tmp/zImage --ramdisk /tmp/initrd.gz -o /tmp/boot.img

