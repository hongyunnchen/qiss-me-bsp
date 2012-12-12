## Specify phone tech before including full_phone

-include vendor/cm/config/common_versions.mk

#Brian ahead here to override cm setting,eg ringtone/apn etc
#PRODUCT_PROPERTY_OVERRIDES should match first define if more same defines
# Inherit device configuration
$(call inherit-product, device/htc/leo/full_leo.mk)

$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := leo

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)



## Device identifier. This must come after all inclusions
PRODUCT_MODEL := HTC HD2
PRODUCT_MANUFACTURER := HTC
PRODUCT_BRAND := htc
PRODUCT_DEVICE := leo
PRODUCT_NAME := cm_leo
PRODUCT_MOD_DEVICE :=HD2

PRODUCT_BUILD_PROP_OVERRIDES += \
PRODUCT_NAME=${PRODUCT_NAME} \
TARGET_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_MODEL="${PRODUCT_MODEL}" \
PRODUCT_BRAND=${PRODUCT_BRAND} \
PRODUCT_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_INTERNAL_VENDOR_CODE=C \
PRODUCT_INTERNAL_DEVICE_CODE=2 \
BUILD_FINGERPRINT="${PRODUCT_BRAND} ${PRODUCT_MODEL} ${PRODUCT_DEVICE} ${PLATFORM_VERSION} ${BUILD_ID} ${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS} ${UTC_DATE} ${TARGET_BUILD_VARIANT}test-keys" \
PRIVATE_BUILD_DESC="${PRODUCT_BRAND}/${PRODUCT_MODEL}/${PRODUCT_DEVICE}:${PLATFORM_VERSION}/${BUILD_ID}/${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}/${UTC_DATE}:${TARGET_BUILD_VARIANT}/test-keys" \
PRODUCT_MOD_DEVICE=${PRODUCT_MOD_DEVICE}  



