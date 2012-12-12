# Copyright (C) 2011 The Android Open Source Project
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


# LIBS
PRODUCT_COPY_FILES += \
	vendor/motorola/jordan_plus/lib/libaudio.so:obj/lib/libaudio.so \
	vendor/motorola/jordan_plus/lib/libaudio.so:system/lib/libaudio.so \
	vendor/motorola/jordan_plus/lib/libbayercamera.so:system/lib/libbayercamera.so \
	vendor/motorola/jordan_plus/lib/libcaps.so:system/lib/libcaps.so \
	vendor/motorola/jordan_plus/lib/libsoccamera.so:system/lib/libsoccamera.so \
	vendor/motorola/jordan_plus/lib/libbattd.so:system/lib/libbattd.so \
	vendor/motorola/jordan_plus/lib/libganril.so:system/lib/libganril.so \
	vendor/motorola/jordan_plus/lib/libgki.so:system/lib/libgki.so \
	vendor/motorola/jordan_plus/lib/libHPImgApi.so:system/lib/libHPImgApi.so \
	vendor/motorola/jordan_plus/lib/libmotdb.so:system/lib/libmotdb.so \
	vendor/motorola/jordan_plus/lib/libmsl_interface.so:system/lib/libmsl_interface.so \
	vendor/motorola/jordan_plus/lib/libssmgr.so:system/lib/libssmgr.so \
	vendor/motorola/jordan_plus/lib/libril-moto-umts-1.so:system/lib/libril-moto-umts-1.so \
	vendor/motorola/jordan_plus/lib/librilswitch.so:system/lib/librilswitch.so \
	vendor/motorola/jordan_plus/lib/hw/gps.jordan_plus.so:system/lib/hw/gps.jordan_plus.so \
	vendor/motorola/jordan_plus/lib/dsp/baseimage.dof:system/lib/dsp/baseimage.dof \
	vendor/motorola/jordan_plus/lib/dsp/conversions.dll64P:system/lib/dsp/conversions.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/h264vdec_sn.dll64P:system/lib/dsp/h264vdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/h264venc_sn.dll64P:system/lib/dsp/h264venc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/jpegdec_sn.dll64P:system/lib/dsp/jpegdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/jpegenc_sn.dll64P:system/lib/dsp/jpegenc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/m4venc_sn.dll64P:system/lib/dsp/m4venc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/mp3dec_sn.dll64P:system/lib/dsp/mp3dec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/mp4vdec_sn.dll64P:system/lib/dsp/mp4vdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/mpeg4aacdec_sn.dll64P:system/lib/dsp/mpeg4aacdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/mpeg4aacenc_sn.dll64P:system/lib/dsp/mpeg4aacenc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/nbamrdec_sn.dll64P:system/lib/dsp/nbamrdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/nbamrenc_sn.dll64P:system/lib/dsp/nbamrenc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/postprocessor_dualout.dll64P:system/lib/dsp/postprocessor_dualout.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/ringio.dll64P:system/lib/dsp/ringio.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/usn.dll64P:system/lib/dsp/usn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/wbamrdec_sn.dll64P:system/lib/dsp/wbamrdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/wbamrenc_sn.dll64P:system/lib/dsp/wbamrenc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/wmadec_sn.dll64P:system/lib/dsp/wmadec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/720p_h264vdec_sn.dll64P:system/lib/dsp/720p_h264vdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/mpeg4ingenc_sn.dll64P:system/lib/dsp/mpeg4ingenc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/h264ingdec_sn.dll64P:system/lib/dsp/h264ingdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/mpeg4ingdec_sn.dll64P:system/lib/dsp/mpeg4ingdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/720p_mp4vdec_sn.dll64P:system/lib/dsp/720p_mp4vdec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/wmadec_sn.dll64P:system/lib/dsp/wmadec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/720p_h264venc_sn.dll64P:system/lib/dsp/720p_h264venc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/720p_mp4venc_sn.dll64P:system/lib/dsp/720p_mp4venc_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/wmv9dec_sn.dll64P:system/lib/dsp/wmv9dec_sn.dll64P \
	vendor/motorola/jordan_plus/lib/dsp/vpp_sn.dll64P:system/lib/dsp/vpp_sn.dll64P \
	vendor/motorola/jordan_plus/lib/libOMX.TI.720P.Decoder.so:system/lib/libOMX.TI.720P.Decoder.so \
	vendor/motorola/jordan_plus/lib/libOMX.TI.720P.Encoder.so:system/lib/libOMX.TI.720P.Encoder.so \
	vendor/motorola/jordan_plus/lib/libOMX.TI.JPEG.Encoder.so:system/lib/libOMX.TI.JPEG.Encoder.so \
	vendor/motorola/jordan_plus/lib/libOMX.TI.mp4.splt.Encoder.so:system/lib/libOMX.TI.mp4.splt.Encoder.so \
	vendor/motorola/jordan_plus/lib/libOMX.TI.h264.splt.Encoder.so:system/lib/libOMX.TI.h264.splt.Encoder.so \
	vendor/motorola/jordan_plus/lib/libFMRadio.so:system/lib/libFMRadio.so \
	vendor/motorola/jordan_plus/lib/libfmradio_jni.so:system/lib/libfmradio_jni.so \
	vendor/motorola/jordan_plus/lib/libfmradioplayer.so:system/lib/libfmradioplayer.so \
	vendor/motorola/jordan_plus/lib/liboemcamera.so:system/lib/liboemcamera.so 

#Moto etc
PRODUCT_COPY_FILES += \
        vendor/motorola/jordan_plus/etc/wifi/fw_tiwlan_ap.bin:system/etc/wifi/fw_tiwlan_ap.bin \
        vendor/motorola/jordan_plus/etc/wifi/fw_wlan1271.bin:system/etc/wifi/fw_wlan1271.bin \
        vendor/motorola/jordan_plus/etc/firmware/wl1271.bin:system/etc/firmware/wl1271.bin \
        vendor/motorola/jordan_plus/etc/fmc_init_1273.2.bts:system/etc/fmc_init_1273.2.bts \
        vendor/motorola/jordan_plus/etc/fmc_init_6450.2.bts:system/etc/fmc_init_6450.2.bts \
        vendor/motorola/jordan_plus/etc/fm_rx_init_1273.2.bts:system/etc/fm_rx_init_1273.2.bts \
        vendor/motorola/jordan_plus/etc/fm_rx_init_6450.2.bts:system/etc/fm_rx_init_6450.2.bts \
        vendor/motorola/jordan_plus/etc/cameraCalFileDef5M.bin:system/etc/cameraCalFileDef5M.bin \
        vendor/motorola/jordan_plus/etc/cameraCalFileDef8M.bin:system/etc/cameraCalFileDef8M.bin \
        vendor/motorola/jordan_plus/etc/mot_ise_imager_cfg.bin:system/etc/mot_ise_imager_cfg.bin \
	vendor/motorola/jordan_plus/etc/motorola/ap_flex_version.txt:system/etc/motorola/ap_flex_version.txt \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio:system/etc/motorola/bp_nvm_default/File_Audio \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio1_AMR_WB:system/etc/motorola/bp_nvm_default/File_Audio1_AMR_WB \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio2:system/etc/motorola/bp_nvm_default/File_Audio2 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio2_AMR_WB:system/etc/motorola/bp_nvm_default/File_Audio2_AMR_WB \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio3:system/etc/motorola/bp_nvm_default/File_Audio3 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio3_AMR_WB:system/etc/motorola/bp_nvm_default/File_Audio3_AMR_WB \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio4:system/etc/motorola/bp_nvm_default/File_Audio4 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio4_AMR_WB:system/etc/motorola/bp_nvm_default/File_Audio4_AMR_WB \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio5:system/etc/motorola/bp_nvm_default/File_Audio5 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio5_AMR_WB:system/etc/motorola/bp_nvm_default/File_Audio5_AMR_WB \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio6:system/etc/motorola/bp_nvm_default/File_Audio6 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio7:system/etc/motorola/bp_nvm_default/File_Audio7 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Audio8:system/etc/motorola/bp_nvm_default/File_Audio8 \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_GPRS:system/etc/motorola/bp_nvm_default/File_GPRS \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_GSM:system/etc/motorola/bp_nvm_default/File_GSM \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Logger:system/etc/motorola/bp_nvm_default/File_Logger \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_Seem_Flex_Tables:system/etc/motorola/bp_nvm_default/File_Seem_Flex_Tables \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_UMA:system/etc/motorola/bp_nvm_default/File_UMA \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/generic_pds_init:system/etc/motorola/bp_nvm_default/generic_pds_init \
	vendor/motorola/jordan_plus/etc/motorola/bp_nvm_default/File_UMA:system/etc/motorola/bp_nvm_default/File_UMA \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/commdrv_fs.sh:system/etc/motorola/comm_drv/commdrv_fs.sh \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/mmins_cust_emergency_number.cfg:system/etc/motorola/comm_drv/mmins_cust_emergency_number.cfg \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/mmins_settings.cfg:system/etc/motorola/comm_drv/mmins_settings.cfg \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/mmins_telephony.cfg:system/etc/motorola/comm_drv/mmins_telephony.cfg \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/mmins_user_settings.cfg:system/etc/motorola/comm_drv/mmins_user_settings.cfg \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/plmn_text_table.bin:system/etc/motorola/comm_drv/plmn_text_table.bin \
	vendor/motorola/jordan_plus/etc/motorola/comm_drv/PLMN_VERSION.txt:system/etc/motorola/comm_drv/PLMN_VERSION.txt

# basebands
PRODUCT_COPY_FILES += \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/argentina_claro_342.zip:system/etc/motorola/basebands/america/argentina_claro_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/argentina_personal_342.zip:system/etc/motorola/basebands/america/argentina_personal_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/argentina_614.zip:system/etc/motorola/basebands/america/argentina_614.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/brasil_342.zip:system/etc/motorola/basebands/america/brasil_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/brasil_claro_342.zip:system/etc/motorola/basebands/america/brasil_claro_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/brasil_claro_614.zip:system/etc/motorola/basebands/america/brasil_claro_614.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/brasil_tim_342.zip:system/etc/motorola/basebands/america/brasil_tim_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/brasil_vivo_342.zip:system/etc/motorola/basebands/america/brasil_vivo_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/colombia_tigo_342.zip:system/etc/motorola/basebands/america/colombia_tigo_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/us_tmobile_342_4.zip:system/etc/motorola/basebands/america/us_tmobile_342_4.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/us_tmobile_342_9.zip:system/etc/motorola/basebands/america/us_tmobile_342_9.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/america/us_tmobile_6xx.zip:system/etc/motorola/basebands/america/us_tmobile_6xx.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/china_25_26_210.zip:system/etc/motorola/basebands/asia/china_25_26_210.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/china_026_110.zip:system/etc/motorola/basebands/asia/china_026_110.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/china_me722_110.zip:system/etc/motorola/basebands/asia/china_me722_110.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/hktaiwan_259.zip:system/etc/motorola/basebands/asia/hktaiwan_259.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/sea_343_331.zip:system/etc/motorola/basebands/asia/sea_343_331.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/sea_343_361.zip:system/etc/motorola/basebands/asia/sea_343_361.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/asia/southkorea_342.zip:system/etc/motorola/basebands/asia/southkorea_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/australia/optus_342.zip:system/etc/motorola/basebands/australia/optus_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/australia/telstra_226.zip:system/etc/motorola/basebands/australia/telstra_226.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/central_europe_221.zip:system/etc/motorola/basebands/europe/central_europe_221.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/central_europe_234.zip:system/etc/motorola/basebands/europe/central_europe_234.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/central_europe_251.zip:system/etc/motorola/basebands/europe/central_europe_251.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/central_europe_342.zip:system/etc/motorola/basebands/europe/central_europe_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/central_europe_34x.zip:system/etc/motorola/basebands/europe/central_europe_34x.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/france_orange_342.zip:system/etc/motorola/basebands/europe/france_orange_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/france_vodafone_342.zip:system/etc/motorola/basebands/europe/france_vodafone_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/italy_251.zip:system/etc/motorola/basebands/europe/italy_251.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/poland_orange_251.zip:system/etc/motorola/basebands/europe/poland_orange_251.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/poland_orange_342.zip:system/etc/motorola/basebands/europe/poland_orange_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/uk_251.zip:system/etc/motorola/basebands/europe/uk_251.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/uk_342.zip:system/etc/motorola/basebands/europe/uk_342.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/uk_343_3.zip:system/etc/motorola/basebands/europe/uk_343_3.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/uk_343_11.zip:system/etc/motorola/basebands/europe/uk_343_11.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/uk_tmobile_221.zip:system/etc/motorola/basebands/europe/uk_tmobile_221.zip \
	vendor/motorola/jordan_plus/etc/motorola/basebands/europe/uk_tmobile_251.zip:system/etc/motorola/basebands/europe/uk_tmobile_251.zip

#bin

PRODUCT_COPY_FILES += \
        vendor/motorola/jordan_plus/bin/battd_4.3v:system/bin/battd_4.3v \
        vendor/motorola/jordan_plus/bin/battd_asia:system/bin/battd_asia \
        vendor/motorola/jordan_plus/bin/battd_hk:system/bin/battd_hk \
        vendor/motorola/jordan_plus/bin/battd.sh:system/bin/battd.sh \
	vendor/motorola/jordan_plus/bin/protocol_driver:system/bin/protocol_driver \
	vendor/motorola/jordan_plus/bin/opprofdaemon:system/bin/opprofdaemon \
	vendor/motorola/jordan_plus/bin/nvm_daemon:system/bin/nvm_daemon \
	vendor/motorola/jordan_plus/bin/gkisystem:system/bin/gkisystem \
	vendor/motorola/jordan_plus/bin/ap_gain_mmul.bin:system/bin/ap_gain_mmul.bin \
	vendor/motorola/jordan_plus/bin/ap_gain.bin:system/bin/ap_gain.bin \
	vendor/motorola/jordan_plus/bin/fmradioserver:system/bin/fmradioserver \
	vendor/motorola/jordan_plus/bin/brcm_guci_drv:system/bin/brcm_guci_drv \
	vendor/motorola/jordan_plus/bin/akmd2:system/bin/akmd2 \
	vendor/motorola/jordan_plus/bin/usbd:system/bin/usbd \
	vendor/motorola/jordan_plus/bin/location:system/bin/location \
	vendor/motorola/jordan_plus/bin/ssmgrd:system/bin/ssmgrd

# TI SGX DDK 1.8 ES 5.x
PRODUCT_COPY_FILES += \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/gralloc.omap3.so:/system/lib/hw/gralloc.omap3.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libEGL_POWERVR_SGX530_125.so:/system/lib/egl/libEGL_POWERVR_SGX530_125.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libGLESv1_CM_POWERVR_SGX530_125.so:/system/lib/egl/libGLESv1_CM_POWERVR_SGX530_125.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libGLESv2_POWERVR_SGX530_125.so:/system/lib/egl/libGLESv2_POWERVR_SGX530_125.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libpvr2d.so:/system/lib/libpvr2d.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libeglinfo.so:/system/lib/libeglinfo.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libusc.so:/system/lib/libusc.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libglslcompiler.so:/system/lib/libglslcompiler.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libpvrANDROID_WSEGL.so:/system/lib/libpvrANDROID_WSEGL.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libsrv_um.so:/system/lib/libsrv_um.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libIMGegl.so:/system/lib/libIMGegl.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libsrv_init.so:/system/lib/libsrv_init.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/libPVRScopeServices.so:/system/lib/libPVRScopeServices.so \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/pvrsrvctl:/system/bin/pvrsrvctl \
	vendor/motorola/jordan_plus/ti_sgx_es5.x/pvrsrvinit:/system/bin/pvrsrvinit \
#location proxy
PRODUCT_COPY_FILES += \
	vendor/motorola/jordan_plus/framework/com.motorola.android.location.jar:system/framework/com.motorola.android.location.jar

#BEGIN remove by Seac.Cong for MYUI
#app
PRODUCT_COPY_FILES += \
	vendor/motorola/jordan_plus/app/FMRadio.apk:system/app/FMRadio.apk \
	vendor/motorola/jordan_plus/app/FMRadioService.apk:system/app/FMRadioService.apk 
#END remove by Seac.Cong for MYUI

# delete by Brian for Defy+ BL5/6/7 kernel support
#BEGIN add  by Seac.Cong for MYUI
#PRODUCT_COPY_FILES += \
	#vendor/motorola/jordan_plus/boot-234-134.smg:utilities/boot.img \
	#vendor/motorola/jordan_plus/devtree-234-134.smg:utilities/devtree.img

#END add  by Seac.Cong for MYUI
# delete by Brian for Defy+ BL5/6/7 kernel support

#extra
PRODUCT_COPY_FILES += \
	vendor/motorola/jordan_plus/media/Moto.ogg:system/media/audio/ringtones/Moto.ogg
