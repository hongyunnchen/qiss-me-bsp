# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE_PREBUILT := device/motorola/jordan_plus/prebuilt


PRODUCT_COPY_FILES += \
	$(DEVICE_PREBUILT)/etc/terminfo/l/linux:system/etc/terminfo/l/linux \
	$(DEVICE_PREBUILT)/etc/terminfo/x/xterm:system/etc/terminfo/x/xterm \
	$(DEVICE_PREBUILT)/usr/keychars/cpcap-key.kcm.bin:system/usr/keychars/cpcap-key.kcm.bin \
	$(DEVICE_PREBUILT)/usr/keychars/qtouch-touchscreen.kcm.bin:system/usr/keychars/qtouch-touchscreen.kcm.bin \
	$(DEVICE_PREBUILT)/usr/keychars/qtouch-touchscreen.kcm.bin:system/usr/keychars/sholes-keypad.kcm.bin \
	$(DEVICE_PREBUILT)/usr/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
	$(DEVICE_PREBUILT)/usr/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
	$(DEVICE_PREBUILT)/usr/idc/qtouch-touchscreen.idc:system/usr/idc/qtouch-touchscreen.idc \

#key layouts, names must fit the ones in /proc/bus/input/devices, qwerty.kl is the fallback one.
PRODUCT_COPY_FILES += \
	$(DEVICE_PREBUILT)/usr/qwerty.kl:system/usr/keylayout/qwerty.kl \
	$(DEVICE_PREBUILT)/usr/qwerty.kl:system/usr/keylayout/qtouch-touchscreen.kl \
	$(DEVICE_PREBUILT)/usr/keypad.kl:system/usr/keylayout/sholes-keypad.kl \
	$(DEVICE_PREBUILT)/usr/keypad.kl:system/usr/keylayout/umts_jordan-keypad.kl \
	$(DEVICE_PREBUILT)/usr/cpcap.kl:system/usr/keylayout/cpcap-key.kl \

#etc
PRODUCT_COPY_FILES += \
	device/motorola/jordan_plus/bootmenu/recovery/recovery.fstab:system/etc/recovery.fstab \
	device/motorola/jordan_plus/prebuilt/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
	device/motorola/jordan_plus/prebuilt/etc/init.d/03adbd:system/etc/init.d/03adbd \
	device/motorola/jordan_plus/prebuilt/etc/init.d/04pdsbackup:system/etc/init.d/04pdsbackup \
	device/motorola/jordan_plus/prebuilt/etc/init.d/05mountsd:system/etc/init.d/05mountsd \
	device/motorola/jordan_plus/prebuilt/etc/init.d/06filesystems:system/etc/init.d/06filesystems \
	$(DEVICE_PREBUILT)/etc/init.d/07camera:system/etc/init.d/07camera \
	device/motorola/jordan_plus/prebuilt/etc/init.d/08backlight:system/etc/init.d/08backlight \
	device/motorola/jordan_plus/prebuilt/etc/init.d/90multitouch:system/etc/init.d/90multitouch \
	device/motorola/jordan_plus/prebuilt/etc/profile:system/etc/profile \
	device/motorola/jordan_plus/prebuilt/etc/sysctl.conf:system/etc/sysctl.conf \
	device/motorola/jordan_plus/prebuilt/etc/busybox.fstab:system/etc/fstab \
	device/motorola/jordan_plus/prebuilt/etc/wifi/dnsmasq.conf:system/etc/wifi/dnsmasq.conf \
	device/motorola/jordan_plus/prebuilt/etc/wifi/tiwlan.ini:system/etc/wifi/tiwlan.ini \
	device/motorola/jordan_plus/prebuilt/etc/wifi/tiwlan_ap.ini:system/etc/wifi/tiwlan_ap.ini \
	device/motorola/jordan_plus/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	device/motorola/jordan_plus/prebuilt/etc/gpsconfig.xml:system/etc/gpsconfig.xml \
	device/motorola/jordan_plus/prebuilt/etc/location.cfg:system/etc/location.cfg \
	device/motorola/jordan_plus/media_profiles.xml:system/etc/media_profiles.xml \
	device/motorola/jordan_plus/media_codecs.xml:system/etc/media_codecs.xml \
	device/motorola/jordan_plus/audio_policy.conf:system/etc/audio_policy.conf \
	device/motorola/jordan_plus/modules/modules.alias:system/lib/modules/modules.alias \
	device/motorola/jordan_plus/modules/modules.dep:system/lib/modules/modules.dep \
	device/motorola/jordan_plus/prebuilt/etc/switchrndis.sh:system/etc/switchrndis.sh \

ifdef CM_RELEASE
	PRODUCT_COPY_FILES += device/motorola/jordan_plus/custom_backup_release.txt:system/etc/custom_backup_list.txt
else
	PRODUCT_COPY_FILES += device/motorola/jordan_plus/custom_backup_list.txt:system/etc/custom_backup_list.txt
endif

#Bootmenu
$(call inherit-product, device/motorola/jordan_plus/bootmenu/bootmenu.mk)



#end of jordan-blobs.mk
