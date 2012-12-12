#
# Copyright (C) 2011 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
PRODUCT_COPY_FILES += \
    device/htc/ace/gps.conf:system/etc/gps.conf \
    device/htc/ace/apns-conf.xml:system/etc/apns-conf.xml

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

PRODUCT_COPY_FILES += \
    device/htc/ace/init.spade.rc:root/init.spade.rc \
    device/htc/ace/init.spade.usb.rc:root/init.spade.usb.rc \
    device/htc/ace/ueventd.spade.rc:root/ueventd.spade.rc

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/ace/device-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.3_r3 \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y 

# Override /proc/sys/vm/dirty_ratio on UMS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20


DEVICE_PACKAGE_OVERLAYS += device/htc/ace/overlay

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \

# gsm config xml file
PRODUCT_COPY_FILES += \
    device/htc/ace/voicemail-conf.xml:system/etc/voicemail-conf.xml

# Sensors, GPS, Lights
PRODUCT_PACKAGES += \
    gps.spade \
    camera.spade
#    lights.spade \
#    sensors.spade \

# Input device calibration files
PRODUCT_COPY_FILES += \
    device/htc/ace/idc/atmel-touchscreen.idc:system/usr/idc/atmel-touchscreen.idc \
    device/htc/ace/idc/elan-touchscreen.idc:system/usr/idc/elan-touchscreen.idc \
    device/htc/ace/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/ace/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/htc/ace/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/htc/ace/keychars/spade-keypad.kcm.bin:system/usr/keychars/spade-keypad.kcm.bin \
    device/htc/ace/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/htc/ace/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/ace/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/htc/ace/keylayout/spade-keypad.kl:system/usr/keylayout/spade-keypad.kl \
    device/htc/ace/keylayout/atmel-touchscreen.kl:system/usr/keylayout/atmel-touchscreen.kl \
    device/htc/ace/keylayout/elan-touchscreen.kl:system/usr/keylayout/elan-touchscreen.kl \
    device/htc/ace/keylayout/synaptics-rmi-touchscreen.kl:system/usr/keylayout/synaptics-rmi-touchscreen.kl

# Device specific firmware
PRODUCT_COPY_FILES += \
    device/htc/ace/firmware/bcm4329.hcd:system/vendor/firmware/bcm4329.hcd \
    device/htc/ace/firmware/default.acdb:system/etc/firmware/default.acdb \
    device/htc/ace/firmware/default_org.acdb:system/etc/firmware/default_org.acdb

# Audio DSP Profiles
PRODUCT_COPY_FILES += \
    device/htc/ace/dsp/AIC3254_REG.csv:system/etc/AIC3254_REG.csv \
    device/htc/ace/dsp/AIC3254_REG_XD.csv:system/etc/AIC3254_REG_XD.csv \
    device/htc/ace/dsp/AdieHWCodec.csv:system/etc/AdieHWCodec.csv \
    device/htc/ace/dsp/CodecDSPID.txt:system/etc/CodecDSPID.txt \
    device/htc/ace/dsp/HP_Audio.csv:system/etc/HP_Audio.csv \
    device/htc/ace/dsp/HP_Video.csv:system/etc/HP_Video.csv \
    device/htc/ace/dsp/SPK_Combination.csv:system/etc/SPK_Combination.csv \
    device/htc/ace/dsp/soundimage/Sound_Bass_Booster.txt:system/etc/soundimage/Sound_Bass_Booster.txt \
    device/htc/ace/dsp/soundimage/Sound_Blues.txt:system/etc/soundimage/Sound_Blues.txt \
    device/htc/ace/dsp/soundimage/Sound_Classical.txt:system/etc/soundimage/Sound_Classical.txt \
    device/htc/ace/dsp/soundimage/Sound_Country.txt:system/etc/soundimage/Sound_Country.txt \
    device/htc/ace/dsp/soundimage/Sound_Dolby_A_HP.txt:system/etc/soundimage/Sound_Dolby_A_HP.txt \
    device/htc/ace/dsp/soundimage/Sound_Dolby_A_SPK.txt:system/etc/soundimage/Sound_Dolby_A_SPK.txt \
    device/htc/ace/dsp/soundimage/Sound_Dolby_V_HP.txt:system/etc/soundimage/Sound_Dolby_V_HP.txt \
    device/htc/ace/dsp/soundimage/Sound_Dolby_V_SPK.txt:system/etc/soundimage/Sound_Dolby_V_SPK.txt \
    device/htc/ace/dsp/soundimage/Sound_Dualmic.txt:system/etc/soundimage/Sound_Dualmic.txt \
    device/htc/ace/dsp/soundimage/Sound_Dualmic_EP.txt:system/etc/soundimage/Sound_Dualmic_EP.txt \
    device/htc/ace/dsp/soundimage/Sound_Dualmic_SPK.txt:system/etc/soundimage/Sound_Dualmic_SPK.txt \
    device/htc/ace/dsp/soundimage/Sound_Jazz.txt:system/etc/soundimage/Sound_Jazz.txt \
    device/htc/ace/dsp/soundimage/Sound_Latin.txt:system/etc/soundimage/Sound_Latin.txt \
    device/htc/ace/dsp/soundimage/Sound_New_Age.txt:system/etc/soundimage/Sound_New_Age.txt \
    device/htc/ace/dsp/soundimage/Sound_Original.txt:system/etc/soundimage/Sound_Original.txt \
    device/htc/ace/dsp/soundimage/Sound_Original_SPK.txt:system/etc/soundimage/Sound_Original_SPK.txt \
    device/htc/ace/dsp/soundimage/Sound_Piano.txt:system/etc/soundimage/Sound_Piano.txt \
    device/htc/ace/dsp/soundimage/Sound_Pop.txt:system/etc/soundimage/Sound_Pop.txt \
    device/htc/ace/dsp/soundimage/Sound_R_B.txt:system/etc/soundimage/Sound_R_B.txt \
    device/htc/ace/dsp/soundimage/Sound_Rock.txt:system/etc/soundimage/Sound_Rock.txt \
    device/htc/ace/dsp/soundimage/Sound_SRS_A_HP.txt:system/etc/soundimage/Sound_SRS_A_HP.txt \
    device/htc/ace/dsp/soundimage/Sound_SRS_A_SPK.txt:system/etc/soundimage/Sound_SRS_A_SPK.txt \
    device/htc/ace/dsp/soundimage/Sound_SRS_V_HP.txt:system/etc/soundimage/Sound_SRS_V_HP.txt \
    device/htc/ace/dsp/soundimage/Sound_SRS_V_SPK.txt:system/etc/soundimage/Sound_SRS_V_SPK.txt \
    device/htc/ace/dsp/soundimage/Sound_Treble_Booster.txt:system/etc/soundimage/Sound_Treble_Booster.txt \
    device/htc/ace/dsp/soundimage/Sound_Vocal_Booster.txt:system/etc/soundimage/Sound_Vocal_Booster.txt

# Additional NAM Audio DSP Profiles to NAM Package
PRODUCT_COPY_FILES += \
    device/htc/ace/nam/CodecDSPID.txt:system/etc/nam/CodecDSPID.txt \
    device/htc/ace/nam/CodecDSPID_MCLK.txt:system/etc/nam/CodecDSPID_MCLK.txt \
    device/htc/ace/nam/Sound_Treble_Booster_MCLK.txt:system/etc/nam/Sound_Treble_Booster_MCLK.txt \
    device/htc/ace/nam/Sound_Vocal_Booster_MCLK.txt:system/etc/nam/Sound_Vocal_Booster_MCLK.txt \
    device/htc/ace/nam/Sound_SRS_A_SPK_MCLK.txt:system/etc/nam/Sound_SRS_A_SPK_MCLK.txt \
    device/htc/ace/nam/Sound_SRS_V_HP_MCLK.txt:system/etc/nam/Sound_SRS_V_HP_MCLK.txt \
    device/htc/ace/nam/Sound_SRS_V_SPK_MCLK.txt:system/etc/nam/Sound_SRS_V_SPK_MCLK.txt \
    device/htc/ace/nam/Sound_Jazz_MCLK.txt:system/etc/nam/Sound_Jazz_MCLK.txt \
    device/htc/ace/nam/Sound_Latin_MCLK.txt:system/etc/nam/Sound_Latin_MCLK.txt \
    device/htc/ace/nam/Sound_New_Age_MCLK.txt:system/etc/nam/Sound_New_Age_MCLK.txt \
    device/htc/ace/nam/Sound_Original_MCLK.txt:system/etc/nam/Sound_Original_MCLK.txt \
    device/htc/ace/nam/Sound_Piano_MCLK.txt:system/etc/nam/Sound_Piano_MCLK.txt \
    device/htc/ace/nam/Sound_Pop_MCLK.txt:system/etc/nam/Sound_Pop_MCLK.txt \
    device/htc/ace/nam/Sound_R_B_MCLK.txt:system/etc/nam/Sound_R_B_MCLK.txt \
    device/htc/ace/nam/Sound_Rock_MCLK.txt:system/etc/nam/Sound_Rock_MCLK.txt \
    device/htc/ace/nam/Sound_SRS_A_HP_MCLK.txt:system/etc/nam/Sound_SRS_A_HP_MCLK.txt \
    device/htc/ace/nam/Sound_Dualmic_SPK_MCLK.txt:system/etc/nam/Sound_Dualmic_SPK_MCLK.txt \
    device/htc/ace/nam/Sound_Dualmic_EP_MCLK.txt:system/etc/nam/Sound_Dualmic_EP_MCLK.txt \
    device/htc/ace/nam/Sound_Dualmic_MCLK.txt:system/etc/nam/Sound_Dualmic_MCLK.txt \
    device/htc/ace/nam/Sound_Dolby_A_SPK_MCLK.txt:system/etc/nam/Sound_Dolby_A_SPK_MCLK.txt \
    device/htc/ace/nam/Sound_Dolby_HP_MCLK.txt:system/etc/nam/Sound_Dolby_HP_MCLK.txt \
    device/htc/ace/nam/Sound_Dolby_Spk_MCLK.txt:system/etc/nam/Sound_Dolby_Spk_MCLK.txt \
    device/htc/ace/nam/Sound_Dolby_V_HP_MCLK.txt:system/etc/nam/Sound_Dolby_V_HP_MCLK.txt \
    device/htc/ace/nam/Sound_Dolby_V_SPK_MCLK.txt:system/etc/nam/Sound_Dolby_V_SPK_MCLK.txt \
    device/htc/ace/nam/Sound_Dolby_A_HP_MCLK.txt:system/etc/nam/Sound_Dolby_A_HP_MCLK.txt \
    device/htc/ace/nam/Sound_Bass_Booster_MCLK.txt:system/etc/nam/Sound_Bass_Booster_MCLK.txt \
    device/htc/ace/nam/Sound_Blues_MCLK.txt:system/etc/nam/Sound_Blues_MCLK.txt \
    device/htc/ace/nam/Sound_Classical_MCLK.txt:system/etc/nam/Sound_Classical_MCLK.txt \
    device/htc/ace/nam/Sound_Country_MCLK.txt:system/etc/nam/Sound_Country_MCLK.txt \
    device/htc/ace/nam/gps.conf:system/etc/nam/gps.conf \
    device/htc/ace/nam/build.prop:system/etc/nam/build.prop

# Alternate NAM gps.conf to NAM package
# PRODUCT_COPY_FILES += device/common/gps/gps.conf_US:system/etc/nam/gps.conf

PRODUCT_COPY_FILES += \
    device/htc/ace/vold.fstab:system/etc/vold.fstab

PRODUCT_COPY_FILES += \
    device/htc/ace/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf
	
#Brian@  add media profile for camera record start
PRODUCT_COPY_FILES += \
    device/htc/ace/media_profiles.xml:system/etc/media_profiles.xml \
    device/htc/ace/media_codecs.xml:system/etc/media_codecs.xml
#Brian@  add media profile for camera record end

# Kernel modules
#PRODUCT_COPY_FILES += \

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/msm7x30-common/msm7230/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    device/htc/msm7x30-common/msm7230/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/msm7x30-common/msm7230/qc_pcm_in.ko:system/lib/modules/qc_pcm_in.ko

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

# common msm7x30 configs
$(call inherit-product, device/htc/msm7x30-common/msm7x30.mk)

# htc audio settings
$(call inherit-product, device/htc/ace/media_htcaudio.mk)

#$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/htc/ace/device-vendor.mk)
