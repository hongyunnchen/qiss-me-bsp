OMX_VIDEO_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifneq ($(BUILD_TINY_ANDROID),true)

ifeq ($(TARGET_BOARD_PLATFORM),msm7x30)
    include $(OMX_VIDEO_PATH)/vidc/vdec/Android.mk
    include $(OMX_VIDEO_PATH)/vidc/venc/Android.mk
endif

ifeq ($(TARGET_BOARD_PLATFORM),qsd8k)
#    include $(OMX_VIDEO_PATH)/qdsp6/vdec/Android.mk
# Hill 120405, close libOmxVidenc.so compile, use file for internet
#Brian HTC LEO use SW encoder,other devide try HW
	ifneq ($(PRODUCT_NAME),full_leo)
	    include $(OMX_VIDEO_PATH)/qdsp6/venc/Android.mk
	endif
endif

endif #BUILD_TINY_ANDROID
