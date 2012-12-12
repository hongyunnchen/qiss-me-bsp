#!/system/xbin/ash

export PATH=/system/xbin:/system/bin:/sbin

#asia BL7 kernel
cat /proc/version | grep -q ge281b6e
if [ $? -eq 0 ]; then
	/system/bin/battd_asia
	exit
fi

#234 BL5/6 kernel
cat /proc/version | grep -q g21f1a48
if [ $? -eq 0 ]; then
	/system/bin/battd_4.3v
	exit
fi
#hk BL7 kernel
cat /proc/version | grep -q g6977577
if [ $? -eq 0 ]; then
	/system/bin/battd_hk
	exit
fi
#hk BL7 kernel
cat /proc/version | grep -q g6977577
if [ $? -eq 0 ]; then
	/system/bin/battd_hk
	exit
fi
#default
	/system/bin/battd_asia

