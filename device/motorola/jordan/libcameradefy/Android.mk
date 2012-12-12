LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS    := optional
LOCAL_MODULE_PATH    := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE         := camera.jordan
LOCAL_SRC_FILES      := cameraHal.cpp
LOCAL_PRELINK_MODULE := false

LOCAL_SHARED_LIBRARIES += \
    liblog \
    libutils \
    libbinder \
    libcutils \
    libmedia \
    libhardware \
    libcamera_client \
    libui \
    libstlport \
    libcamera \

include external/stlport/libstlport.mk

include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)

LOCAL_SRC_FILES:= JordanCameraWrapper.cpp
LOCAL_MODULE_PATH    := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SHARED_LIBRARIES:= libdl libutils libcutils libcamera_client

LOCAL_MODULE := libcamera
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)