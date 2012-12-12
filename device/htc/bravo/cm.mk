
-include vendor/cm/config/common_versions.mk
$(call inherit-product, device/htc/bravo/full_bravo.mk)

PRODUCT_RELEASE_NAME := Desire
# Inherit some common evervolv stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

#
# Setup device specific product configuration.
#
PRODUCT_NAME    := cm_bravo
#PRODUCT_BRAND   := htc_wwe
PRODUCT_BRAND   := HTC
PRODUCT_DEVICE  := bravo
PRODUCT_MODEL   := HTC Desire
PRODUCT_MANUFACTURER := HTC

PRODUCT_MOD_DEVICE :=Desire
PRODUCT_BUILD_PROP_OVERRIDES += \
PRODUCT_NAME=${PRODUCT_NAME} \
TARGET_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_MODEL="${PRODUCT_MODEL}" \
PRODUCT_BRAND=${PRODUCT_BRAND} \
PRODUCT_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_INTERNAL_VENDOR_CODE=C \
PRODUCT_INTERNAL_DEVICE_CODE=1 \
BUILD_FINGERPRINT="${PRODUCT_BRAND} ${PRODUCT_MODEL} ${PRODUCT_DEVICE} ${PLATFORM_VERSION} ${BUILD_ID} ${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS} ${UTC_DATE} ${TARGET_BUILD_VARIANT}test-keys" \
PRIVATE_BUILD_DESC="${PRODUCT_BRAND}/${PRODUCT_MODEL}/${PRODUCT_DEVICE}:${PLATFORM_VERSION}/${BUILD_ID}/${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}/${UTC_DATE}:${TARGET_BUILD_VARIANT}/test-keys" \
PRODUCT_MOD_DEVICE=${PRODUCT_MOD_DEVICE}  

#PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_bravo BUILD_FINGERPRINT=htc_wwe/htc_bravo/bravo:2.3.3/GRI40/96875.1:user/release-keys TARGET_BUILD_TYPE=userdebug BUILD_VERSION_TAGS=release-keys PRIVATE_BUILD_DESC="3.14.405.1 CL96875 release-keys"

#
# Set up the product codename, build version & MOTD.
#
PRODUCT_CODENAME := Turba
PRODUCT_VERSION_DEVICE_SPECIFIC := p9

#PRODUCT_MOTD :="\n\n\n--------------------MESSAGE---------------------\nThank you for choosing Evervolv for your HTC Desire\nPlease visit us at \#evervolv on irc.freenode.net\nFollow @preludedrew for the latest Evervolv updates\nGet the latest rom at evervolv.com\n------------------------------------------------\n"

#
# Extra Packages
#
PRODUCT_PACKAGES += \
    Camera \
    Stk

# Extra RIL settings
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.enable.managed.roaming=1 \
    ro.ril.oem.nosim.ecclist=911,112,999,000,08,118,120,122,110,119,995 \
    ro.ril.emc.mode=2

# Use the n1 stock boot animation until we get a custom evervolv one.
#PRODUCT_COPY_FILES += \
    device/htc/passion/extras/bootanimation_passion_ics.zip:system/media/bootanimation.zip

# Hot reboot
PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/hot_reboot

# Get some gapps
ifeq ($(GAPPS),true)
$(call inherit-product, vendor/cm/prebuilt/gapps/gapps.mk)
endif
