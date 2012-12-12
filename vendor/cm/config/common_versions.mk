UTC_DATE := $(shell date +%s)

BUILD_YEAR :=$(shell date +%Y)
BUILD_MONTH :=$(shell date +%m)
BUILD_DAYS :=$(shell date +%d)

ifeq ($(TARGET_MYUI_BUILD_FLAG),weeklyrelease)
BUILD_WEEKLY_NEW_DATE :=$(shell ./build/tools/releasetools/weekly_release_date.sh )

ifeq ($(BUILD_WEEKLY_NEW_DATE),false)
$(error build date is invalid for weekly release build,plese check build date time)
endif

BUILD_YEAR :=$(shell date -d "${BUILD_WEEKLY_NEW_DATE}" +%Y)
BUILD_MONTH :=$(shell date -d "${BUILD_WEEKLY_NEW_DATE}" +%m)
BUILD_DAYS :=$(shell date -d "${BUILD_WEEKLY_NEW_DATE}" +%d)
endif

ifeq ($(TARGET_MYUI_BUILD_FLAG),weeklyrc)
BUILD_WEEKLY_NEW_DATE :=$(shell ./build/tools/releasetools/weekly_release_date.sh )

ifeq ($(BUILD_WEEKLY_NEW_DATE),false)
$(error build date is invalid for weekly release build,plese check build date time)
endif

BUILD_YEAR :=$(shell date -d "${BUILD_WEEKLY_NEW_DATE}" +%Y)
BUILD_MONTH :=$(shell date -d "${BUILD_WEEKLY_NEW_DATE}" +%m)
BUILD_DAYS :=$(shell date -d "${BUILD_WEEKLY_NEW_DATE}" +%d)
endif


ifeq ($(TARGET_WEEKLY_TEST_OTA_BUILD_FLAG),true) 
BUILD_WEEKLY_TEST_DATE :=$(shell ./build/tools/releasetools/weekly_release_test_date.sh )
ifeq ($(BUILD_WEEKLY_TEST_DATE),false)
$(error build date is invalid for weekly test ota build,plese check build date time)
endif

BUILD_YEAR :=$(shell date -d "${BUILD_WEEKLY_TEST_DATE}" +%Y)
BUILD_MONTH :=$(shell date -d "${BUILD_WEEKLY_TEST_DATE}" +%m)
BUILD_DAYS :=$(shell date -d "${BUILD_WEEKLY_TEST_DATE}" +%d)

endif

#{Modified by Henry.Wu,FOR Merge ,2012-02-21
#for gengerate ota package
PRODUCT_VERSION_CODE :=  3

ifeq ($(TARGET_MYUI_BUILD_FLAG),nightlybuild)
  PRODUCT_MYUI_BUILD_FLAG :=nightly
  PRODCUT_HUDSON_JOB_NUMBER :=job ${HUDSON_BUILD_NUMBER}
  PRODUCT_VERSION_CODE :=  3
endif
# Modified by Henry.Wu,FOR Merge ,2012-02-21}

#beta version
ifeq ($(TARGET_MYUI_BUILD_FLAG),weeklyrelease)
  PRODUCT_MYUI_BUILD_FLAG :=
  PRODUCT_VERSION_CODE := 0
endif

#RC version
ifeq ($(TARGET_MYUI_BUILD_FLAG),weeklyrc)
  PRODUCT_MYUI_BUILD_FLAG :=
  PRODUCT_VERSION_CODE := 1
endif

ifeq ($(TARGET_MYUI_BUILD_FLAG),strelease)
  PRODUCT_MYUI_BUILD_FLAG :=ST
  PRODCUT_HUDSON_JOB_NUMBER :=job ${HUDSON_BUILD_NUMBER}
  PRODUCT_VERSION_CODE :=  2
endif

#all the code review internal version begin 2
#but nightly/weekly beta/weekly rc plus diff words
ifeq ($(TARGET_MYUI_BUILD_FLAG),codereview)
  PRODUCT_MYUI_BUILD_FLAG :=codereview
  PRODCUT_HUDSON_JOB_NUMBER :=job ${HUDSON_BUILD_NUMBER}
  PRODUCT_VERSION_CODE :=  3
endif
ifeq ($(TARGET_MYUI_BUILD_FLAG),codereview_nightly)
  PRODUCT_MYUI_BUILD_FLAG :=CodeReview_Nightly
  PRODCUT_HUDSON_JOB_NUMBER :=job ${HUDSON_BUILD_NUMBER}
  PRODUCT_VERSION_CODE :=  3
endif

ifeq ($(TARGET_MYUI_BUILD_FLAG),codereview_weekly_beta)
  PRODUCT_MYUI_BUILD_FLAG :=CodeReview_Beta
  PRODCUT_HUDSON_JOB_NUMBER :=job ${HUDSON_BUILD_NUMBER}
  PRODUCT_VERSION_CODE :=  3
endif
ifeq ($(TARGET_MYUI_BUILD_FLAG),codereview_weekly_rc)
  PRODUCT_MYUI_BUILD_FLAG :=CodeReview_RC
  PRODCUT_HUDSON_JOB_NUMBER :=job ${HUDSON_BUILD_NUMBER}
  PRODUCT_VERSION_CODE :=  3
endif


BUILD_YEAR :=$(shell echo $(BUILD_YEAR)| cut -c 4)
BUILD_NUMBER :=${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS}

