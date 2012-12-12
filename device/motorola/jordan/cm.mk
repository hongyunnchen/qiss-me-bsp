#
# Copyright (C) 2011 The Android Open-Source Project
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

-include vendor/cm/config/common_versions.mk

$(call inherit-product, device/motorola/jordan/full_jordan.mk)

# Inherit some common CM9 stuff.
$(call inherit-product-if-exists, vendor/cm/config/common_full_phone.mk)

# Inherit some common CM stuff.
$(call inherit-product-if-exists, vendor/cm/config/gsm.mk)

PRODUCT_NAME := cm_jordan
PRODUCT_BRAND := MOTO
PRODUCT_DEVICE := jordan
PRODUCT_MODEL := MB525
PRODUCT_MANUFACTURER := motorola
PRODUCT_SFX := JOREM_U3
BUILD_ID    :=QiSS_ME
PRODUCT_MOD_DEVICE :=Defy
USER	     :=Qiss


PRODUCT_BUILD_PROP_OVERRIDES += \
PRODUCT_NAME=${PRODUCT_MODEL}_${PRODUCT_SFX} \
TARGET_DEVICE=umts_jordan \
BUILD_FINGERPRINT=MOTO/${PRODUCT_MODEL}_${PRODUCT_SFX}/umts_jordan/jordan:${PLATFORM_VERSION}/${BUILD_ID}/${PRODUCT_VERSION_CODE}${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}/${UTC_DATE}:userdebug/test-keys \
PRODUCT_BRAND=${PRODUCT_BRAND} \
PRODUCT_DEVICE=${PRODUCT_DEVICE} \
PRIVATE_BUILD_DESC="umts_jordan-userdebug ${PLATFORM_VERSION} ${BUILD_ID} ${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS} ${PRODUCT_SFX}_${PRODUCT_SBF} ${UTC_DATE} test-keys" \
BUILD_NUMBER="${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}" \
PRODUCT_INTERNAL_VENDOR_CODE=A \
PRODUCT_INTERNAL_DEVICE_CODE=0 \
PRODUCT_MOD_DEVICE=${PRODUCT_MOD_DEVICE} 



