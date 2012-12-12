
ifeq ($(TARGET_BUILD_VARIANT),eng)
WITH_DEXPREOPT := false
else
WITH_DEXPREOPT := true
endif

ifeq ($(TARGET_QISSME_RD_BUILD),true)
WITH_DEXPREOPT := false
endif


BUILD_ID    :=QiSS_ME
USER	     :=Qiss
PRODUCT_BRAND := QiSS_ME


PRODUCT_BUILD_PROP_OVERRIDES := \
BUILD_ID=${BUILD_ID} \
BUILD_DISPLAY_ID="${BUILD_ID}_${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAYS} $(PRODUCT_MYUI_BUILD_FLAG) ${PRODCUT_HUDSON_JOB_NUMBER}" \
BUILD_NUMBER=${BUILD_NUMBER} \
PRODUCT_VERSION_CODE=${PRODUCT_VERSION_CODE} \
BUILD_VERSION_TAGS=test-keys \
USER=${USER} \

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0


#BEGIN Add by Seac.Cong,2012/08/24

#product line: 
#	QiSS ME ->QM
#	Cloud Monitor-> CM
#	TV -> TV
#	Other ->OT

PRODUCT_PROPERTY_OVERRIDES += \
	ro.product.line=QM

#END Add by Seac.Cong,2012/08/24


PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    persist.service.adb.enable=1 \
    persist.sys.ring-speaker=1 \
    ro.updgrade.googleapp=1 \
    ro.ril.ecclist=112,911,999




#Enable save log under /data/log
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
persist.sys.timezone=Asia/Taipei \
persist.service.mainlog.enable=1 \
persist.service.radiolog.enable=1 \
persist.service.eventlog.enable=1 \
persist.service.adb.enable=1



PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/fix_permissions:system/bin/fix_permissions \
    vendor/cm/prebuilt/common/bin/modelid_cfg.sh:system/bin/modelid_cfg.sh \
    vendor/cm/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/cm/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache \
    vendor/cm/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/cm/prebuilt/common/etc/init.local.rc:system/etc/init.local.rc \
    vendor/cm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \

PRODUCT_COPY_FILES +=  \
    vendor/cm/prebuilt/common/bootanimation.zip:system/media/bootanimation.zip
  	

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml


PRODUCT_PACKAGES += \
    LatinIME \
    Superuser \
    su


PRODUCT_PACKAGES += \
    VoiceDialer \
    Basic \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam



#BEGIN add by Seac.Cong for MYUI
#PRODUCT_PACKAGES += \
#    CalendarGoogle \
#    CalendarProvider \
#    ChromeBookmarksSyncAdapter \
#    Gmail \
#    GoogleBackupTransport \
#    GoogleCalendarSyncAdapter \
#    GoogleContactsSyncAdapter \
#    GoogleFeedback \
#    GoogleLoginService \
#    GooglePackageVerifier \
#    GooglePackageVerifierUpdater \
#    GooglePartnerSetup \
#    GoogleQuickSearchBox \
#    GoogleServicesFramework \
#    MarketUpdater \
#    MediaUploader \
#    NetworkLocation \
#    OneTimeInitializer \
#    Vending \
#    VoiceSearch 



PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/CalendarGoogle.apk:system/app/CalendarGoogle.apk \
    vendor/cm/prebuilt/common/app/ChromeBookmarksSyncAdapter.apk:system/app/ChromeBookmarksSyncAdapter.apk \
    vendor/cm/prebuilt/common/app/Gmail.apk:system/app/Gmail.apk \
    vendor/cm/prebuilt/common/app/GoogleBackupTransport.apk:system/app/GoogleBackupTransport.apk \
    vendor/cm/prebuilt/common/app/GoogleCalendarSyncAdapter.apk:system/app/GoogleCalendarSyncAdapter.apk \
    vendor/cm/prebuilt/common/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
    vendor/cm/prebuilt/common/app/GoogleFeedback.apk:system/app/GoogleFeedback.apk \
    vendor/cm/prebuilt/common/app/GoogleLoginService.apk:system/app/GoogleLoginService.apk \
    vendor/cm/prebuilt/common/app/GooglePartnerSetup.apk:system/app/GooglePartnerSetup.apk \
    vendor/cm/prebuilt/common/app/GoogleQuickSearchBox.apk:system/app/GoogleQuickSearchBox.apk \
    vendor/cm/prebuilt/common/app/GoogleServicesFramework.apk:system/app/GoogleServicesFramework.apk \
    vendor/cm/prebuilt/common/app/MarketUpdater.apk:system/app/MarketUpdater.apk \
    vendor/cm/prebuilt/common/app/MediaUploader.apk:system/app/MediaUploader.apk \
    vendor/cm/prebuilt/common/app/NetworkLocation.apk:system/app/NetworkLocation.apk \
    vendor/cm/prebuilt/common/app/OneTimeInitializer.apk:system/app/OneTimeInitializer.apk \
    vendor/cm/prebuilt/common/app/Vending.apk:system/app/Vending.apk \
    vendor/cm/prebuilt/common/app/Talk.apk:system/app/Talk.apk \
    vendor/cm/prebuilt/common/app/VoiceSearch.apk:system/app/VoiceSearch.apk 



PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/





PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
    vendor/cm/prebuilt/common/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    vendor/cm/prebuilt/common/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    vendor/cm/prebuilt/common/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml

PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/cm/prebuilt/common/lib/libvideochat_stabilize.so:system/lib/libvideochat_stabilize.so \
    vendor/cm/prebuilt/common/lib/libgcomm_jni.so:system/lib/libgcomm_jni.so \
    vendor/cm/prebuilt/common/lib/libfacelock_jni.so:system/lib/libfacelock_jni.so \
    vendor/cm/prebuilt/common/lib/libfrsdk.so:system/lib/libfrsdk.so \
    vendor/cm/prebuilt/common/lib/libfilterpack_facedetect.so:system/lib/libfilterpack_facedetect.so \
    vendor/cm/prebuilt/common/lib/libflint_engine_jni_api.so:system/lib/libflint_engine_jni_api.so \
    vendor/cm/prebuilt/common/lib/libpicowrapper.so:system/lib/libpicowrapper.so \
    vendor/cm/prebuilt/common/lib/libspeexwrapper.so:system/lib/libspeexwrapper.so \
    vendor/cm/prebuilt/common/lib/libvoicesearch.so:system/lib/libvoicesearch.so    \
    vendor/cm/prebuilt/common/lib/libmotricity.so:system/lib/libmotricity.so    \
    vendor/cm/prebuilt/common/lib/libncurses.so:system/lib/libncurses.so    \
    vendor/cm/prebuilt/common/lib/libspeexresampler.so:system/lib/libspeexresampler.so    

#Modefied by Jerry.Qian, for MYUI-01521, the sound of boot music is too loud, 2012/03/05
#PRODUCT_COPY_FILES += \
    #vendor/cm/prebuilt/common/bin/bootsound:system/bin/bootsound
#Modefied by Jerry.Qian, for MYUI-01521, the sound of boot music is too loud, 2012/03/05	
#END  add by Seac.Cong for MYUI

PRODUCT_COPY_FILES +=  \
    vendor/cm/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/cm/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd


