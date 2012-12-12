#
# Copyright (C) 2009 The Android Open Source Project
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
#

#Brian add prebuild init.rc and uevent.rc
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/init.htcleo.rc:root/init.htcleo.rc \
	device/htc/leo/prebuilt/init.htcleo.usb.rc:root/init.htcleo.usb.rc \
	device/htc/leo/prebuilt/ueventd.htcleo.rc:root/ueventd.htcleo.rc \
	device/htc/leo/prebuilt/logo.rle:root/logo.rle \
	device/htc/leo/prebuilt/init.rc:root/init.rc \
	device/htc/leo/prebuilt/ueventd.rc:root/ueventd.rc

PRODUCT_COPY_FILES += \
    device/htc/leo/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf		
	
# Add the postrecoveryboot.sh so that the recovery.fstab can be changed
PRODUCT_COPY_FILES += \
    device/htc/leo/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/leo/leo-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/htc/leo/overlay


# General properties
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=240 \
	ro.ril.ecc.HTC-ELL=92,93,94 \
	ro.ril.ecc.HTC-WWE=999 \
	ro.ril.enable.a52.HTC-ITA=1 \
	ro.ril.enable.a53.HTC-ITA=1 \
	ro.ril.enable.a52=0 \
	ro.ril.enable.a53=1 \
	ro.ril.enable.dtm=1 \
	ro.ril.gprsclass=12 \
	ro.ril.hsdpa.category=8 \
	ro.ril.hsupa.category=5 \
	ro.ril.hsxpa=2 \
	ro.ril.enable.prl.recognition=1 \
	ro.telephony.ril.v3=signalstrength \
	ro.ril.def.agps.mode=2 \
	ro.ril.enable.managed.roaming=1 \
	ro.ril.oem.nosim.ecclist=911,112,999,000,08,118,120,122,110,119,995 \
	ro.ril.emc.mode=2 \
	mobiledata.interfaces=rmnet0,rmnet1,rmnet2,ppp0
	
PRODUCT_PROPERTY_OVERRIDES += \
	media.a1026.nsForVoiceRec=0 \
	media.a1026.enableA1026=1 \
	ro.media.dec.jpeg.memcap=20000000 \
	ro.opengles.version=131072
	
# Dalvik properties - read from AndroidRuntime
# dexop-flags:
# "v="  verification 'n': none, 'r': remote, 'a': all
# "o="  optimization 'n': none, 'v': verified, 'a': all, 'f': full
# "m=y" register map
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-flags=v=n,o=v,m=y \
    dalvik.vm.checkjni=false \
    dalvik.vm.dexopt-data-only=1

#because cache parition size only 40M
#Modified by Seac.Cong, 2012/04/26
# Default network type.
# 0 => /* GSM/WCDMA (WCDMA preferred) */
# 0 => GSM/WCDMA (WCDMA preferred), 3 => GSM/WCDMA (auto mode, according to PRL)
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.default_network=3
	
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	ro.ril.disable.power.collapse=0 \
	wifi.supplicant_scan_interval=45

# Improve touch responsiveness
PRODUCT_PROPERTY_OVERRIDES += \
	Debug.performance.tuning=1 \
	Video.accelerate.hw=1

# Fix black screen after call
PRODUCT_PROPERTY_OVERRIDES += \
	ro.lge.proximity.delay=10 \
	mot.proximity.delay=10

PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/leo/prebuilt/media_profiles.xml:system/etc/media_profiles.xml\
    device/htc/leo/prebuilt/media_codecs.xml:system/etc/media_codecs.xml\

# audio hw modules config file
PRODUCT_COPY_FILES += \
    device/htc/leo/prebuilt/audio_policy.conf:system/etc/audio_policy.conf

# This file is used to install the enable RMNET and corresponding modules which dont get activated by normal module script, mount cache so that downloads work correctly
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/init.d/01modules:system/etc/init.d/01modules \
	device/htc/leo/prebuilt/init.d/02cache:system/etc/init.d/02cache \
	device/htc/leo/prebuilt/init.d/10mic_level:system/etc/init.d/10mic_level \
	device/htc/leo/prebuilt/init.d/97ppp:system/etc/init.d/97ppp

# Sensors
PRODUCT_PACKAGES += \
    sensors.htcleo \
    lights.htcleo \
    gps.htcleo \
    camera.qsd8k

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.primary.qsd8k \
	audio_policy.qsd8k \
	libaudioutils

# GPU
PRODUCT_PACKAGES += \
	gralloc.qsd8k \
	hwcomposer.default \
	hwcomposer.qsd8k \
	liboverlay \
	libgenlock \
	libmemalloc \
	libtilerenderer \
	libQcomUI\
	copybit.qsd8k
#Hobo.Shao for CR-03391,12/07/12,enable copybit function for improve HD2 3D performance
# Omx
PRODUCT_PACKAGES += \
	libOmxCore \
	libOmxVenc \
	libOmxVdec \
	libstagefrighthw

# htcleo misc
PRODUCT_PACKAGES += \
	camera.qsd8k \
	leo-reference-ril \
	libgps \
	libhtc_ril_wrapper
	
# Omx cli test apps
PRODUCT_PACKAGES += \
	libmm-omxcore \
	mm-vdec-omx-test \
	liblasic \
	ast-mm-vdec-omx-test \
	mm-venc-omx-test

PRODUCT_PACKAGES += \
	Stk \
	Camera \
	Launcher2
	
# strict mode
ADDITIONAL_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
	
# leo uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi mdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi mdpi

PRODUCT_PROPERTY_OVERRIDES += \
	debug.sf.hw=1 \
	debug.composition.type=mdp \
	dalvik.vm.dexopt-flags=m=y \
	dalvik.vm.checkjni=false \
	dalvik.vm.heapsize=128m \
	dalvik.vm.heapgrowthlimit=48m \
	dalvik.vm.heapstartsize=5m \
	dalvik.vm.dexopt-data-only=1 \
	dalvik.vm.verify-bytecode=false \
	dalvik.vm.lockprof.threshold=500 \
	windowsmgr.max_events_per_sec=120

# Force launcher/apps into memory
PRODUCT_PROPERTY_OVERRIDES += \
	ro.HOME_APP_ADJ=1 \
	ro.PERCEPTIBLE_APP_ADJ=0
	
# HardwareRenderer properties
# dirty_regions: "false" to disable partial invalidates, override if enabletr=true
PRODUCT_PROPERTY_OVERRIDES += \
	hwui.render_dirty_regions=false \
	hwui.disable_vsync=true \
	hwui.print_config=choice \
	debug.enabletr=false
	
# Force 2 buffers - gralloc defaults to 3 and we only have 2
PRODUCT_PROPERTY_OVERRIDES += \
	debug.gr.numframebuffers=2

# disable jni check	
PRODUCT_PROPERTY_OVERRIDES += \
	ro.kernel.android.checkjni=0 \
	dalvik.vm.checkjni=0

# Set usb type
PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mass_storage \
	persist.service.adb.enable=1
	
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/vold.fstab:system/etc/vold.fstab

# Keylayouts
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/keylayout/htcleo-keypad.kl:system/usr/keylayout/htcleo-keypad.kl \
	device/htc/leo/prebuilt/keylayout/htcleo-keypad.kcm:system/usr/keychars/htcleo-keypad.kcm \
	device/htc/leo/prebuilt/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl

# Touchscreen
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/htcleo-touchscreen.idc:system/usr/idc/htcleo-touchscreen.idc

# PPP files
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/ppp/ip-up:system/etc/ppp/ip-up \
	device/htc/leo/prebuilt/ppp/ip-down:system/etc/ppp/ip-down \
	device/htc/leo/prebuilt/ppp/ppp:system/ppp \
	device/htc/leo/prebuilt/ppp/options:system/etc/ppp/options

# Kernel Modules
PRODUCT_COPY_FILES += $(shell \
	find device/htc/leo/prebuilt/modules -name '*.ko' \
	| sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
	| tr '\n' ' ')

# kernel
PRODUCT_COPY_FILES += \
    device/htc/leo/prebuilt/kernel:boot/zImage \

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/htc/leo/prebuilt/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# The gps config appropriate for this device
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/gps.conf:system/etc/gps.conf

#Brian for clk tool start
PRODUCT_COPY_FILES += \
	device/htc/leo/prebuilt/clktool/checksys.sh:boot/checksys.sh \
	device/htc/leo/prebuilt/clktool/mkbootimg:boot/mkbootimg \
	device/htc/leo/prebuilt/clktool/mkbootimg.sh:boot/mkbootimg.sh
#Brian for clk tool end
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel


# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

PRODUCT_NAME := htc_leo
PRODUCT_DEVICE := leo
