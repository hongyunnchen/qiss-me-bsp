ifeq ($(BUILD_G729_DEC_TEST),1)
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)



LOCAL_SRC_FILES:= \
	G729DecTest.c \
	
LOCAL_C_INCLUDES := \
	$(TI_OMX_SYSTEM)/common/inc \
	$(TI_OMX_COMP_C_INCLUDES) \
	$(TI_OMX_AUDIO)/g729_dec/inc

LOCAL_SHARED_LIBRARIES := $(TI_OMX_COMP_SHARED_LIBRARIES)

	
LOCAL_CFLAGS := $(TI_OMX_CFLAGS) -DOMX_DEBUG

LOCAL_MODULE:= G729DecTest

include $(BUILD_EXECUTABLE)
endif
