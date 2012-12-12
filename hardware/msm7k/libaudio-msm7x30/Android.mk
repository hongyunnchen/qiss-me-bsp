ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH := $(call my-dir)

# ---------------------------------------------------------------------------------
#             Make the Shared library libaudiopolicy
# ---------------------------------------------------------------------------------

# The audio policy is implemented on top of legacy policy code
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    AudioPolicyManager.cpp \
    audio_policy_hal.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libmedia

LOCAL_STATIC_LIBRARIES := \
    libaudiohw_legacy \
    libmedia_helper \
    libaudiopolicy_legacy

LOCAL_MODULE := audio_policy.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
    LOCAL_CFLAGS += -DWITH_A2DP
endif

ifeq ($(BOARD_USES_QCOM_AUDIO_LPA),true)
    LOCAL_CFLAGS += -DQCOM_TUNNEL_LPA_ENABLED
endif

LOCAL_C_INCLUDES := hardware/libhardware_legacy/audio

include $(BUILD_SHARED_LIBRARY)

# ---------------------------------------------------------------------------------
#             Make the Shared library libaudio
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm
LOCAL_CFLAGS := -D_POSIX_SOURCE

LOCAL_SRC_FILES := \
    AudioHardware.cpp \
    audio_hw_hal.cpp

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
    LOCAL_CFLAGS += -DWITH_A2DP
endif

ifeq ($(BOARD_HAVE_QCOM_FM),true)
    LOCAL_CFLAGS += -DQCOM_FM_ENABLED
endif

ifeq ($(BOARD_USES_QCOM_AUDIO_LPA),true)
    LOCAL_CFLAGS += -DQCOM_TUNNEL_LPA_ENABLED
endif

ifeq ($(BOARD_USES_QCOM_AUDIO_SPEECH),true)
    LOCAL_CFLAGS += -DWITH_QCOM_SPEECH
endif

ifeq ($(BOARD_USES_QCOM_AUDIO_VOIPMUTE),true)
    LOCAL_CFLAGS += -DWITH_QCOM_VOIPMUTE
endif

ifeq ($(BOARD_USES_QCOM_AUDIO_RESETALL),true)
    LOCAL_CFLAGS += -DWITH_QCOM_RESETALL
endif

ifeq ($(BOARD_USES_STEREO_HW_SPEAKER),true)
    LOCAL_CFLAGS += -DWITH_STEREO_HW_SPEAKER
endif

LOCAL_SHARED_LIBRARIES := \
    libcutils       \
    libutils        \
    libmedia        \
    libaudioalsa

# hack for prebuilt
#$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libaudioalsa_intermediates/)
#$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libaudioalsa_intermediates/export_includes)

ifeq ($(BOARD_USES_QCOM_AUDIO_CALIBRATION),true)
    LOCAL_SHARED_LIBRARIES += libaudcal
    LOCAL_CFLAGS += -DWITH_QCOM_CALIBRATION
endif

ifneq ($(TARGET_SIMULATOR),true)
    LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper \
    libaudiohw_legacy \
    libaudiopolicy_legacy

LOCAL_MODULE := audio.primary.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS += -fno-short-enums

LOCAL_C_INCLUDES := $(TARGET_OUT_HEADERS)/mm-audio/audio-alsa
ifeq ($(BOARD_USES_QCOM_AUDIO_CALIBRATION),true)
    LOCAL_C_INCLUDES := $(TARGET_OUT_HEADERS)/mm-audio/audcal
endif
LOCAL_C_INCLUDES += hardware/libhardware/include
LOCAL_C_INCLUDES += hardware/libhardware_legacy/include
LOCAL_C_INCLUDES += frameworks/base/include
LOCAL_C_INCLUDES += system/core/include
LOCAL_C_INCLUDES += device/htc/msm7x30-common/include

include $(BUILD_SHARED_LIBRARY)

endif # not BUILD_TINY_ANDROID
