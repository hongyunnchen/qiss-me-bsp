# Copyright 2011 The Android Open Source Project

#ifneq ($(BUILD_TINY_ANDROID),true)
#ifneq ($(TARGET_PRODUCT),generic)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	charger.c

LOCAL_MODULE := charger_desire
LOCAL_MODULE_TAGS := eng
#LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_FORCE_STATIC_EXECUTABLE := true
#LOCAL_MODULE_PATH := /media/disk-1/kelcy/port_desire/device/htc/bravo
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
#LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_UNSTRIPPED)

LOCAL_C_INCLUDES := bootable/recovery

LOCAL_STATIC_LIBRARIES := libminui libpixelflinger_static libpng
LOCAL_STATIC_LIBRARIES += libz libstdc++ libcutils libc

include $(BUILD_EXECUTABLE)

define _add-charger-image
include $$(CLEAR_VARS)
LOCAL_MODULE := system_core_charger_$(notdir $(1))
LOCAL_MODULE_STEM := $(notdir $(1))
_img_modules += $$(LOCAL_MODULE)
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $$(TARGET_RECOVERY_ROOT_OUT)/res/images/charger
include $$(BUILD_PREBUILT)
endef

_img_modules :=
_images :=
$(foreach _img, $(call find-subdir-subdir-files, "images", "*.png"), \
  $(eval $(call _add-charger-image,$(_img))))

include $(CLEAR_VARS)
LOCAL_MODULE := charger_res_images
LOCAL_MODULE_TAGS := eng
LOCAL_REQUIRED_MODULES := $(_img_modules)
include $(BUILD_PHONY_PACKAGE)

_add-charger-image :=
_img_modules :=

define _add-percent-image
include $$(CLEAR_VARS)
LOCAL_MODULE := system_core_charger_$(notdir $(1))
LOCAL_MODULE_STEM := $(notdir $(1))
_img_modules += $$(LOCAL_MODULE)
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $$(TARGET_RECOVERY_ROOT_OUT)/res/images/charger/battery_numbers
include $$(BUILD_PREBUILT)
endef
_img_modules :=
_images :=
LOCAL_PATH := device/htc/bravo/charger/images
$(foreach _img, $(call find-subdir-subdir-files, "battery_numbers", "*.png"), \
  $(eval $(call _add-percent-image,$(_img))))
#endif # !TARGET_SIMULATOR
#endif
