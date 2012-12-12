-include vendor/cm/config/common_versions.mk

$(call inherit-product, device/samsung/galaxysmtd/full_galaxysmtd.mk)

# Release name
PRODUCT_RELEASE_NAME := GalaxyS

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/gsm.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := galaxysmtd
PRODUCT_NAME := cm_galaxysmtd
PRODUCT_BRAND := samsung
PRODUCT_MODEL := GT-I9000

PRODUCT_MANUFACTURER := Samsung
PRODUCT_MOD_DEVICE :=GalaxyS
PRODUCT_BUILD_PROP_OVERRIDES += \
PRODUCT_NAME=${PRODUCT_NAME} \
TARGET_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_MODEL="${PRODUCT_MODEL}" \
PRODUCT_BRAND=${PRODUCT_BRAND} \
PRODUCT_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_INTERNAL_VENDOR_CODE=B \
PRODUCT_INTERNAL_DEVICE_CODE=1 \
BUILD_FINGERPRINT="${PRODUCT_BRAND} ${PRODUCT_MODEL} ${PRODUCT_DEVICE} ${PLATFORM_VERSION} ${BUILD_ID} ${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS} ${UTC_DATE} ${TARGET_BUILD_VARIANT}test-keys" \
PRIVATE_BUILD_DESC="${PRODUCT_BRAND}/${PRODUCT_MODEL}/${PRODUCT_DEVICE}:${PLATFORM_VERSION}/${BUILD_ID}/${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}/${UTC_DATE}:${TARGET_BUILD_VARIANT}/test-keys" \
PRODUCT_MOD_DEVICE=${PRODUCT_MOD_DEVICE}  


#Set build fingerprint / ID / Prduct Name ect.
#PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=GT-I9000 TARGET_DEVICE=GT-I9000 BUILD_FINGERPRINT=samsung/GT-I9000/GT-I9000:2.3.5/GINGERBREAD/XXJVT:user/release-keys PRIVATE_BUILD_DESC="GT-I9000-user 2.3.5 GINGERBREAD XXJVT release-keys"
