#
# Copyright (C) 2012 The CyanogenMod Project
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
#Brian remove cm version define
-include vendor/cm/config/common_versions.mk

#Brian ahead here to override cm setting,eg ringtone/apn etc
#PRODUCT_PROPERTY_OVERRIDES should match first define if more same defines
# Inherit device configuration
$(call inherit-product, device/samsung/galaxys2/full_galaxys2.mk)
## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := GalaxyS2

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := galaxys2
PRODUCT_NAME := cm_galaxys2
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := GT-I9100

PRODUCT_MANUFACTURER := Samsung
PRODUCT_MOD_DEVICE :=GalaxyS2
PRODUCT_BUILD_PROP_OVERRIDES += \
PRODUCT_NAME=${PRODUCT_NAME} \
TARGET_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_MODEL="${PRODUCT_MODEL}" \
PRODUCT_BRAND=${PRODUCT_BRAND} \
PRODUCT_DEVICE=${PRODUCT_DEVICE} \
PRODUCT_INTERNAL_VENDOR_CODE=B \
PRODUCT_INTERNAL_DEVICE_CODE=2 \
BUILD_FINGERPRINT="${PRODUCT_BRAND} ${PRODUCT_MODEL} ${PRODUCT_DEVICE} ${PLATFORM_VERSION} ${BUILD_ID} ${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS} ${UTC_DATE} ${TARGET_BUILD_VARIANT}test-keys" \
PRIVATE_BUILD_DESC="${PRODUCT_BRAND}/${PRODUCT_MODEL}/${PRODUCT_DEVICE}:${PLATFORM_VERSION}/${BUILD_ID}/${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}/${UTC_DATE}:${TARGET_BUILD_VARIANT}/test-keys" \
PRODUCT_MOD_DEVICE=${PRODUCT_MOD_DEVICE}  

#Set build fingerprint / ID / Prduct Name ect.
#PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=GT-I9100 BUILD_FINGERPRINT=samsung/GT-I9100/GT-I9100:4.0.3/IML74K/XXLPQ:user/release-keys PRIVATE_BUILD_DESC="GT-I9100-user 4.0.3 IML74K XXLPQ release-keys"
