#!/system/xbin/sh
if /system/bin/getprop sys.usb.config | /system/xbin/grep "rndis"
then
	if /system/bin/ndc usb rndisstatus | /system/xbin/grep "stopped"
	then
		/system/bin/ndc usb startrndis
		/system/bin/setprop defy.rndis.status started
	fi
fi

if /system/bin/getprop sys.usb.config | /system/xbin/grep "none"
then
	if /system/bin/ndc usb rndisstatus | /system/xbin/grep "started"
	then
		/system/bin/ndc usb stoprndis
	fi
	/system/bin/setprop defy.rndis.status started
fi