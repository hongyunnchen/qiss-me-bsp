/*
 * Copyright (C) 2012 Raviprasad V Mummidi.
 * Copyright (c) 2011 Code Aurora Forum. All rights reserved.
 *
 * Modified by Andrew Sutherland <dr3wsuth3rland@gmail.com>
 *              for The Evervolv Project's qsd8k lineup
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
//#define LOG_NDEBUG 0
//#define LOG_FULL_PARAMS 1
#define LOG_TAG "QcomCamera"

#include <hardware/hardware.h>
#include <binder/IMemory.h>
#include <fcntl.h>
#include <linux/ioctl.h>
#include <linux/msm_mdp.h>
#include <gralloc_priv.h>

#include "CameraHardwareInterface.h"
/* include QCamera Hardware Interface Header*/
#include "QcomCamera.h"
#ifndef QCOM_QSD8K_SEMC_ES209RA
//#include "QualcommCameraHardware.h"
#else
#include "QualcommCameraHardware.h"
#endif

#include <utils/threads.h>


extern "C" {
#include <sys/time.h>
}

/* HAL function implementation goes here*/

/**
 * The functions need to be provided by the camera HAL.
 *
 * If getNumberOfCameras() returns N, the valid cameraId for getCameraInfo()
 * and openCameraHardware() is 0 to N-1.
 */

struct qcom_mdp_rect {
   uint32_t x;
   uint32_t y;
   uint32_t w;
   uint32_t h;
};

struct qcom_mdp_img {
   uint32_t width;
   int32_t  height;
   int32_t  format;
   int32_t  offset;
   int      memory_id; /* The file descriptor */
};

struct qcom_mdp_blit_req {
   struct   qcom_mdp_img src;
   struct   qcom_mdp_img dst;
   struct   qcom_mdp_rect src_rect;
   struct   qcom_mdp_rect dst_rect;
   uint32_t alpha;
   uint32_t transp_mask;
   uint32_t flags;
};

struct blitreq {
   unsigned int count;
   struct qcom_mdp_blit_req req;
};

/* Prototypes and extern functions. */
#ifndef QCOM_QSD8K_SEMC_ES209RA
extern "C" android::sp<android::CameraHardwareInterface> openCameraHardware(int id);
#else
extern "C" android::QualcommCameraHardware* openCameraHardware(int id);
#endif

/* Global variables. */
camera_notify_callback         origNotify_cb    = NULL;
camera_data_callback           origData_cb      = NULL;
camera_data_timestamp_callback origDataTS_cb    = NULL;
camera_request_memory          origCamReqMemory = NULL;

android::CameraParameters camSettings;
preview_stream_ops_t      *mWindow = NULL;
#ifndef QCOM_QSD8K_SEMC_ES209RA
android::sp<android::CameraHardwareInterface> qCamera;
#else
android::QualcommCameraHardware* qCamera;
#endif

// Hill 120401, Camera porting
static char  prefer_video_size[16]={0};
static char  prefer_preview_size[16]={0};         // Hill for MYUI-02321, 120411
static char  prefer_frame_rate[16]={0};
static char previous_preview_size[16]={0};  
static int previewEnabled = 0;  
static int if_parameter_set = 0;  // hill, for preview fail of Poco camera apk  
volatile int focus_status = 0;

#define RECORDING_WAIT_FOCUS_ACTION  // hill, 120618, for record&focus status sync
#ifdef RECORDING_WAIT_FOCUS_ACTION
    volatile int pending_start_recording = 0;
    volatile int pending_stop_recording = 0;
#endif

android::Mutex mLock;//Brian Mutex the callback handle and stoppreview

static int dummy_raw_image_msg = 0;

static hw_module_methods_t camera_module_methods = {
   open: camera_device_open
};

static hw_module_t camera_common  = {
  tag: HARDWARE_MODULE_TAG,
  version_major: 1,
  version_minor: 0,
  id: CAMERA_HARDWARE_MODULE_ID,
  name: "Camera HAL for ICS",
  author: "Raviprasad V Mummidi",
  methods: &camera_module_methods,
  dso: NULL,
  reserved: {0},
};

camera_module_t HAL_MODULE_INFO_SYM = {
  common: camera_common,
  get_number_of_cameras: get_number_of_cameras,
  get_camera_info: get_camera_info,
};

static int skip_count = 0;   // Hill for MYUI-02321, 120411
#if 0 //TODO: use this instead of declaring in camera_device_open
              it works fine with this but segfaults when
              closing the camera app, so that needs to be addressed.

camera_device_ops_t camera_ops = {
  set_preview_window:         android::set_preview_window,
  set_callbacks:              android::set_callbacks,
  enable_msg_type:            android::enable_msg_type,
  disable_msg_type:           android::disable_msg_type,
  msg_type_enabled:           android::msg_type_enabled,

  start_preview:              android::start_preview,
  stop_preview:               android::stop_preview,
  preview_enabled:            android::preview_enabled,
  store_meta_data_in_buffers: android::store_meta_data_in_buffers,

  start_recording:            android::start_recording,
  stop_recording:             android::stop_recording,
  recording_enabled:          android::recording_enabled,
  release_recording_frame:    android::release_recording_frame,

  auto_focus:                 android::auto_focus,
  cancel_auto_focus:          android::cancel_auto_focus,

  take_picture:               android::take_picture,
  cancel_picture:             android::cancel_picture,

  set_parameters:             android::set_parameters,
  get_parameters:             android::get_parameters,
  put_parameters:             android::put_parameters,
  send_command:               android::send_command,

  release:                    android::release,
  dump:                       android::dump,
};
#endif

namespace android {

/* HAL helper functions. */
void set_focus_sts(int f_status)  // hill, 120618, for record&focus status sync
{
    focus_status = f_status;
}

int get_focus_sts()
{
    return focus_status;
}

void inc_focus_sts()
{
    focus_status++;
}

void dec_focus_sts()
{
    if (focus_status>0)
        focus_status--;
}

#ifdef RECORDING_WAIT_FOCUS_ACTION
    void start_recording_real()
    {
       LOGE("start_recording real");
       pending_start_recording = 0;
       qCamera->enableMsgType(CAMERA_MSG_VIDEO_FRAME);
       qCamera->startRecording();
       usleep(100*1000);
    }

    void stop_recording_real()
    {
       LOGE("stop_recording real");
       pending_stop_recording = 0;
       qCamera->disableMsgType(CAMERA_MSG_VIDEO_FRAME);
       qCamera->stopRecording();
    }
#endif

void
CameraHAL_CopyBuffers_Hw(int srcFd, int destFd,
                         size_t srcOffset, size_t destOffset,
                         int srcFormat, int destFormat,
                         int x, int y, int w, int h, int w_dst, int h_dst)  // Hill for MYUI-02321, 120411
{
    struct blitreq blit;
    int    fb_fd = open("/dev/graphics/fb0", O_RDWR);

    if (fb_fd < 0) {
       LOGE("CameraHAL_CopyBuffers_Hw: Error opening /dev/graphics/fb0");
       return;
    }

    LOGV("CameraHAL_CopyBuffers_Hw: srcFD:%d destFD:%d srcOffset:%#x"
         " destOffset:%#x x:%d y:%d w:%d h:%d w_dst:%d h_dst:%d", srcFd, destFd, srcOffset,
         destOffset, x, y, w, h,w_dst,h_dst);

    memset(&blit, 0, sizeof(blit));
    blit.count = 1;

    blit.req.flags       = 0;
    blit.req.alpha       = 0xff;
    blit.req.transp_mask = 0xffffffff;

    blit.req.src.width     = w;
    blit.req.src.height    = h;
    blit.req.src.offset    = srcOffset;
    blit.req.src.memory_id = srcFd;
    blit.req.src.format    = srcFormat;

    blit.req.dst.width     = w_dst;
    blit.req.dst.height    = h_dst;
    blit.req.dst.offset    = destOffset;
    blit.req.dst.memory_id = destFd;
    blit.req.dst.format    = destFormat;

    blit.req.src_rect.x = blit.req.dst_rect.x = x;
    blit.req.src_rect.y = blit.req.dst_rect.y = y;
    blit.req.src_rect.w = w;
    blit.req.src_rect.h = h;
    blit.req.dst_rect.w = w_dst;
    blit.req.dst_rect.h = h_dst;

    if (ioctl(fb_fd, MSMFB_BLIT, &blit)) {
       LOGE("CameraHAL_CopyBuffers_Hw: MSMFB_BLIT failed = %d %s",
            errno, strerror(errno));
    }
    close(fb_fd);
}

void
CameraHAL_HandlePreviewData(const sp<IMemory>& dataPtr,
                            preview_stream_ops_t *mWindow,
                            camera_request_memory getMemory,
                            int32_t previewWidth, int32_t previewHeight)
{
   if (mWindow != NULL && getMemory != NULL) {
      ssize_t  offset;
      size_t   size;
      int32_t  previewFormat = MDP_Y_CBCR_H2V2;
      int32_t  destFormat    = MDP_RGBX_8888;

    #if 1         // Hill for MYUI-02317, 120416
        // return;

        //ANativeWindow *a = anw(mWindow);
        //LOGE("hhh: width:%d, height:%d", mWindow->get_width(mWindow), mWindow->get_height(mWindow));
        if ( ( mWindow->get_width(mWindow)<20) && (mWindow->get_height(mWindow)<20)
             && ( mWindow->get_width(mWindow)>10) && (mWindow->get_height(mWindow)>10)
             )
        {
            LOGE("hhh,  invalid windows size, skip.   width:%d, height:%d", mWindow->get_width(mWindow), mWindow->get_height(mWindow));
            return;
        }
    #endif
 
      status_t retVal;
      sp<IMemoryHeap> mHeap = dataPtr->getMemory(&offset, &size);

      LOGV("CameraHAL_HandlePreviewData: previewWidth:%d previewHeight:%d " "offset:%#x size:%#x base:%p", 
            previewWidth, previewHeight, (unsigned)offset, size, mHeap != NULL ? mHeap->base() : 0);

#ifdef QCOM_QSD8K_SEMC_ES209RA
		if(previewWidth==1280 && previewHeight==720)
		    retVal = mWindow->set_buffers_geometry(mWindow,
                                             864, 480,
                                             HAL_PIXEL_FORMAT_RGBX_8888);
        else
#endif
      retVal = mWindow->set_buffers_geometry(mWindow,
                                             previewWidth, previewHeight,
                                             HAL_PIXEL_FORMAT_RGBX_8888);

      if (retVal == NO_ERROR) {
         int32_t          stride;
         buffer_handle_t *bufHandle = NULL;

         retVal = mWindow->dequeue_buffer(mWindow, &bufHandle, &stride);

    #if 0
         private_handle_t const *privHandlett = reinterpret_cast<private_handle_t const *>(*bufHandle);       // Hill for MYUI-02317, 120413
        if ( ( privHandlett->width<40) || ( privHandlett->width<40))
        {
            mWindow->enqueue_buffer(mWindow, bufHandle);
            LOGE("hhh,  invalid windows size, skip.      width:%d, height:%d", privHandlett->width, privHandlett->height);
            return;
        }
    #endif
    
         if (retVal == NO_ERROR) {
            retVal = mWindow->lock_buffer(mWindow, bufHandle);
            if (retVal == NO_ERROR) {
                private_handle_t const *privHandle = reinterpret_cast<private_handle_t const *>(*bufHandle);       // Hill for MYUI-02321, 120411
                //LOGV("hhh: size:%d, width:%d, height:%d", privHandle->size, privHandle->width, privHandle->height);
#ifdef QCOM_QSD8K_SEMC_ES209RA
			    if(previewWidth==1280 && previewHeight==720)
				CameraHAL_CopyBuffers_Hw(mHeap->getHeapID(), privHandle->fd,
                                        offset, privHandle->offset,
                                        previewFormat, destFormat,
                                        0, 0, 864, 480, privHandle->width, privHandle->height);
               else
#endif
               CameraHAL_CopyBuffers_Hw(mHeap->getHeapID(), privHandle->fd,
                                        offset, privHandle->offset,
                                        previewFormat, destFormat,
                                        0, 0, previewWidth, previewHeight, privHandle->width, privHandle->height);
               mWindow->enqueue_buffer(mWindow, bufHandle);
            } else {
               LOGE("CameraHAL_HandlePreviewData: ERROR locking the buffer");
               mWindow->cancel_buffer(mWindow, bufHandle);
            }
         } else {
            LOGE("CameraHAL_HandlePreviewData: ERROR dequeueing the buffer");
         }
      }
   }
}

camera_memory_t * CameraHAL_GenClientData(const sp<IMemory> &dataPtr,
                        camera_request_memory reqClientMemory,
                        void *user)
{
   ssize_t          offset;
   size_t           size;
   camera_memory_t *clientData = NULL;
   sp<IMemoryHeap> mHeap = dataPtr->getMemory(&offset, &size);

   //LOGV("CameraHAL_GenClientData: offset:%#x size:%#x base:%p",(unsigned)offset, size, mHeap != NULL ? mHeap->base() : 0);

   clientData = reqClientMemory(-1, size, 1, user);
   if (clientData != NULL) {
      memcpy(clientData->data, (char *)(mHeap->base()) + offset, size);
   } else {
      LOGE("CameraHAL_GenClientData: ERROR allocating memory from client");
   }
   return clientData;
}

void CameraHAL_FixupParams(CameraParameters &settings)
{      // Hill for MYUI-02321, 120411
#ifndef QCOM_QSD8K_SEMC_ES209RA
   const char *preview_sizes =
                  "1280x720,800x480,720x480,640x480,640x384,576x432,480x320,176x144";
#else
   const char *preview_sizes =
                  "1280x720,800x480,640x480,320x240";
#endif
   const char *video_sizes =
      "1280x720,800x480,640x480,480x320,320x240,176x144";
   const char *preferred_size       = "640x480";

#ifndef QCOM_QSD8K_SEMC_ES209RA
   const char *preview_frame_rates  = "15";//"30,27,24,15";
#else
   const char *preview_frame_rates  = "25,15,10";//"30,27,24,15";
#endif
   const char *preferred_frame_rate = "15";
#ifndef QCOM_QSD8K_SEMC_ES209RA
   const char *preview_fps_range = "9000,30019";
   const char *preview_fps_range_value = "(9000,30019)";
#else
   const char *preview_fps_range = "5000,30000";
   const char *preview_fps_range_value = "(5000,30000)";
#endif
// hill 120401, for panomana mode
#ifndef QCOM_QSD8K_SEMC_ES209RA
   // Hill 120524, for HD2 and Desire picture
   const char *picture_sizes = 
        "2592x1552,2560x1920,2048x1536,2048x1216,1280x960,1280x768,640x480,640x384,400x400,272x272";
   settings.set(CameraParameters::KEY_SUPPORTED_PICTURE_SIZES, picture_sizes);
#endif
   settings.set(CameraParameters::KEY_VIDEO_FRAME_FORMAT,
                CameraParameters::PIXEL_FORMAT_YUV420SP);

   //if (!settings.get(CameraParameters::KEY_SUPPORTED_PREVIEW_SIZES)) 
   {
      settings.set(CameraParameters::KEY_SUPPORTED_PREVIEW_SIZES,
                   preview_sizes);
   }

   if (!settings.get(CameraParameters::KEY_SUPPORTED_VIDEO_SIZES)) {
      settings.set(CameraParameters::KEY_SUPPORTED_VIDEO_SIZES,
                   video_sizes);
   }
/*
*{Added by Hill.Hui,for SCR-03929,10/16/2012
*change thumbnail 800x480 to 640x480
*/
    //LOGE("hhh: KEY_JPEG_THUMBNAIL_HEIGHT=%s", settings.get(CameraParameters::KEY_JPEG_THUMBNAIL_HEIGHT));
    //LOGE("hhh: KEY_JPEG_THUMBNAIL_WIDTH=%s", settings.get(CameraParameters::KEY_JPEG_THUMBNAIL_WIDTH));

   if ( !strcmp(settings.get(CameraParameters::KEY_JPEG_THUMBNAIL_WIDTH), "800") && !strcmp(settings.get(CameraParameters::KEY_JPEG_THUMBNAIL_HEIGHT), "480") ) {
    //LOGE("hhh: KEY_JPEG_THUMBNAIL_HEIGHT fixup");
      settings.set(CameraParameters::KEY_JPEG_THUMBNAIL_WIDTH,
                   "640");
   }
/* Added by Hill.Hui,for SCR-03929,10/16/2012}*/
#if 1  // Hill for MYUI-02321, 120411
    if(strlen(prefer_video_size)>0)
    {
        settings.set(CameraParameters::KEY_VIDEO_SIZE, prefer_video_size);
    }
    else
    {
        settings.set(CameraParameters::KEY_VIDEO_SIZE, preferred_size);
    }

    if(strlen(prefer_preview_size)>0)
    {
        settings.set(CameraParameters::KEY_PREVIEW_SIZE, prefer_preview_size);
    }
    else
    {
        settings.set(CameraParameters::KEY_PREVIEW_SIZE, preferred_size);
    }
#else
    
   if (!settings.get(CameraParameters::KEY_VIDEO_SIZE)) {
      settings.set(CameraParameters::KEY_VIDEO_SIZE, preferred_size);
   }
#endif

   if (!settings.get(CameraParameters::KEY_PREFERRED_PREVIEW_SIZE_FOR_VIDEO)) {
      settings.set(CameraParameters::KEY_PREFERRED_PREVIEW_SIZE_FOR_VIDEO,
                   preferred_size);
   }

   if (!settings.get(CameraParameters::KEY_SUPPORTED_PREVIEW_FRAME_RATES)) {
      settings.set(CameraParameters::KEY_SUPPORTED_PREVIEW_FRAME_RATES,
                   preview_frame_rates);
   }

#if 1
    if(strlen(prefer_frame_rate)>0)
        settings.set(CameraParameters::KEY_PREVIEW_FRAME_RATE, prefer_frame_rate);
    else
        settings.set(CameraParameters::KEY_PREVIEW_FRAME_RATE, preferred_frame_rate);
#else    
   if (!settings.get(CameraParameters::KEY_PREVIEW_FRAME_RATE)) {
      settings.set(CameraParameters::KEY_PREVIEW_FRAME_RATE,
                   preferred_frame_rate);
   }
#endif

   if (!settings.get(CameraParameters::KEY_PREVIEW_FPS_RANGE)) {
      settings.set(CameraParameters::KEY_PREVIEW_FPS_RANGE,
                   preview_fps_range);
   }
   if (!settings.get(CameraParameters::KEY_SUPPORTED_PREVIEW_FPS_RANGE)) {
      settings.set(CameraParameters::KEY_SUPPORTED_PREVIEW_FPS_RANGE,
                   preview_fps_range_value);
   }
#ifdef QCOM_QSD8K_SEMC_ES209RA
// modify for x10 panorama mode
    if (!settings.get(CameraParameters::KEY_HORIZONTAL_VIEW_ANGLE)) {
	    settings.set(CameraParameters::KEY_HORIZONTAL_VIEW_ANGLE,"52");
    }

    if (!settings.get(CameraParameters::KEY_VERTICAL_VIEW_ANGLE)) {
	    settings.set(CameraParameters::KEY_VERTICAL_VIEW_ANGLE,"40");
    }
// end modify for x10 panorama mode
#endif
}

static void camera_release_memory(struct camera_memory *mem) { }

void cam_notify_callback(int32_t msg_type, int32_t ext1,
                   int32_t ext2, void *user)
{
   LOGV("cam_notify_callback: msg_type:%d ext1:%d ext2:%d user:%p",
        msg_type, ext1, ext2, user);

   if (msg_type == CAMERA_MSG_FOCUS)  // hill, 120618, for record&focus status sync
   {
        dec_focus_sts();
        LOGE("Auto_focus done: %d", get_focus_sts());
    #ifdef RECORDING_WAIT_FOCUS_ACTION
        if (pending_start_recording >0)
        {
            start_recording_real();
        }
        if (pending_stop_recording >0)
        {
            //usleep(100*1000);
            stop_recording_real();
        }
    #endif
    
        //return;
   }
   
   if (origNotify_cb != NULL) {
      origNotify_cb(msg_type, ext1, ext2, user);
   }
}

static void cam_data_callback(int32_t msgType,
                              const sp<IMemory>& dataPtr,
                              void* user)
{

    Mutex::Autolock lock(mLock);
    if(!mWindow)
    	return;
    
   LOGV("cam_data_callback: msgType:%d user:%p, rec:%d", msgType, user, (int)qCamera->recordingEnabled());
#if 0
    if (skip_count < 100)
    {
        skip_count++;
        LOGE("SKIP, HHH");
        return;
    }
#endif

   if (msgType == CAMERA_MSG_PREVIEW_FRAME) {
      int32_t previewWidth, previewHeight;
      CameraParameters hwParameters = qCamera->getParameters();
      hwParameters.getPreviewSize(&previewWidth, &previewHeight);
      CameraHAL_HandlePreviewData(dataPtr, mWindow, origCamReqMemory,
                                  previewWidth, previewHeight);
   }

   if((msgType ==CAMERA_MSG_RAW_IMAGE)&&(dummy_raw_image_msg))
	{
	dummy_raw_image_msg =0;
	qCamera->disableMsgType(CAMERA_MSG_RAW_IMAGE);
	
	camera_memory_t *clientData = CameraHAL_GenClientData(dataPtr,
                                       origCamReqMemory, user);

#if 0
	char path[128];
	snprintf(path, sizeof(path), "/data/myraw.dat");
	int file_fd = open(path, O_RDWR | O_CREAT, 0666);
	if (file_fd < 0) {
		LOGE("cannot open file:%s (error:%i)\n", path, file_fd);
	}
	else
	{
		LOGV("dumping data, size = %d", clientData->size);
		int written = write(file_fd, (char *)clientData->data,
				clientData->size);
		if(written < 0)
			LOGE("error in data write");
	}
	close(file_fd);
#endif
	clientData->release(clientData);

	return;
	}

   if (origData_cb != NULL && origCamReqMemory != NULL) {
      camera_memory_t *clientData = CameraHAL_GenClientData(dataPtr,
                                       origCamReqMemory, user);
      mLock.unlock();  // hill, for ANR of Poco camera apk

    #if 0
        static int frameCnt = 0;
        int written;
        if (frameCnt >= 0 && frameCnt <= 30 ) {
            char path[128];
            snprintf(path, sizeof(path), "/data/tcc_%d.yuv", frameCnt);
            int file_fd = open(path, O_RDWR | O_CREAT, 0666);
            LOGV("dumping preview frame %d", frameCnt);
            if (file_fd < 0) {
                LOGE("cannot open file:%s (error:%i)\n", path, file_fd);
            }
            else
            {
                LOGV("dumping data, size=%d", clientData->size);
                written = write(file_fd, (char *)clientData->data,
                        clientData->size);
                if(written < 0)
                    LOGE("error in data write");
            }
            close(file_fd);
        }
        frameCnt++;
    #endif
    
      if (clientData != NULL) {
         //LOGV("cam_data_callback: Posting data to client");
         origData_cb(msgType, clientData, 0, NULL, user);
		 
         // release clientdata after data cb
		 clientData->release(clientData);
      }
   }
}

static void cam_data_callback_timestamp(nsecs_t timestamp,
                                        int32_t msgType,
                                        const sp<IMemory>& dataPtr,
                                        void* user)

{      // Hill for MYUI-02321, 120411
   LOGV("cam_data_callback_timestamp: timestamp:%lld msgType:%d user:%p", timestamp /1000, msgType, user);

    Mutex::Autolock lock(mLock);
    if(!mWindow)
    	return;
    
#if 1
    if (skip_count < 15)
    {
        skip_count++;
        qCamera->releaseRecordingFrame(dataPtr);
        LOGV("SKIP, HHH");
        return;
    }
#endif

   if (origDataTS_cb != NULL && origCamReqMemory != NULL) {
      camera_memory_t *clientData = CameraHAL_GenClientData(dataPtr, origCamReqMemory, user);
      mLock.unlock();  // hill, for ANR if change zoom when record
      if (clientData != NULL) {
         //LOGV("cam_data_callback_timestamp: Posting data to client timestamp:%lld", systemTime());

    #if 0
        static int frameCnt = 0;
        int written;
        if (frameCnt >= 0 && frameCnt <= 30 ) {
            char path[128];
            snprintf(path, sizeof(path), "/data/ts_%d.yuv", frameCnt);
            int file_fd = open(path, O_RDWR | O_CREAT, 0666);
            LOGV("dumping preview frame %d", frameCnt);
            if (file_fd < 0) {
                LOGE("cannot open file:%s (error:%i)\n", path, file_fd);
            }
            else
            {
                LOGV("dumping data");
                written = write(file_fd, (char *)clientData->data,
                        clientData->size);
                if(written < 0)
                    LOGE("error in data write");
            }
            close(file_fd);
        }
        frameCnt++;
    #endif

         origDataTS_cb(timestamp, msgType, clientData, 0, user);
         qCamera->releaseRecordingFrame(dataPtr);

         // release clientdata after data cb
        clientData->release(clientData);
      } else {
         LOGE("cam_data_callback_timestamp: ERROR allocating memory from client");
      }
   }
}

extern "C" int get_number_of_cameras(void)
{
   LOGV("get_number_of_cameras:");
   return 1;

//    LOGV("Q%s: E", __func__);
//    return android::HAL_getNumberOfCameras( );
}

extern "C" int get_camera_info(int camera_id, struct camera_info *info)
{
   LOGV("get_camera_info:");
   info->facing      = CAMERA_FACING_BACK;
   info->orientation = 90;
   return NO_ERROR;
}

extern "C" int camera_device_open(const hw_module_t* module, const char* name,
                   hw_device_t** device)
{

   int cameraId = atoi(name);

   LOGV("camera_device_open: name:%s device:%p cameraId:%d",
        name, device, cameraId);

   qCamera = openCameraHardware(cameraId);
   camera_device_t* camera_device = NULL;
   camera_device_ops_t* camera_ops = NULL;

   camera_device = (camera_device_t*)malloc(sizeof(*camera_device));
   camera_ops = (camera_device_ops_t*)malloc(sizeof(*camera_ops));
   memset(camera_device, 0, sizeof(*camera_device));
   memset(camera_ops, 0, sizeof(*camera_ops));

   camera_device->common.tag              = HARDWARE_DEVICE_TAG;
   camera_device->common.version          = 0;
   camera_device->common.module           = (hw_module_t *)(module);
   camera_device->common.close            = close_camera_device;
   camera_device->ops                     = camera_ops;

   camera_ops->set_preview_window         = set_preview_window;
   camera_ops->set_callbacks              = set_callbacks;
   camera_ops->enable_msg_type            = enable_msg_type;
   camera_ops->disable_msg_type           = disable_msg_type;
   camera_ops->msg_type_enabled           = msg_type_enabled;
   camera_ops->start_preview              = start_preview;
   camera_ops->stop_preview               = stop_preview;
   camera_ops->preview_enabled            = preview_enabled;
   camera_ops->store_meta_data_in_buffers = store_meta_data_in_buffers;
   camera_ops->start_recording            = start_recording;
   camera_ops->stop_recording             = stop_recording;
   camera_ops->recording_enabled          = recording_enabled;
   camera_ops->release_recording_frame    = release_recording_frame;
   camera_ops->auto_focus                 = auto_focus;
   camera_ops->cancel_auto_focus          = cancel_auto_focus;
   camera_ops->take_picture               = take_picture;
   camera_ops->cancel_picture             = cancel_picture;

   camera_ops->set_parameters             = set_parameters;
   camera_ops->get_parameters             = get_parameters;
   camera_ops->put_parameters             = put_parameters;
   camera_ops->send_command               = send_command;
   camera_ops->release                    = release;
   camera_ops->dump                       = dump;

   *device = &camera_device->common;
   if_parameter_set = 0;  // hill, for preview fail of Poco camera apk
   set_focus_sts(0);  // hill, 120618, for record&focus status sync
#ifdef RECORDING_WAIT_FOCUS_ACTION
    pending_start_recording = 0;
    pending_stop_recording = 0;
#endif

   return NO_ERROR;
}

extern "C" int close_camera_device(hw_device_t* device)
{
   int rc = -EINVAL;
   LOGV("close_camera_device");
   camera_device_t *cameraDev = (camera_device_t *)device;
   if (cameraDev) {
      camera_device_ops_t *camera_ops = cameraDev->ops;
      if (camera_ops) {
         if (qCamera != NULL) {
#ifndef QCOM_QSD8K_SEMC_ES209RA
            qCamera.clear();
#endif
         }
         free(camera_ops);
      }
      free(cameraDev);
      rc = NO_ERROR;
   }
   return rc;
}

int set_preview_window(struct camera_device * device,
                           struct preview_stream_ops *window)
{
   LOGV("set_preview_window : Window :%p", window);
   if (device == NULL) {
      LOGE("set_preview_window : Invalid device.");
      return -EINVAL;
   } else {
      //LOGV("set_preview_window : window :%p", window);

      mWindow = window;

    // Hill 120420, For MYUI-02491
    if (!window) {
        LOGV("%s---: window is NULL", __FUNCTION__);
        return 0;
    }
	
    int min_bufs = -1;
    int kBufferCount = 4;

#if 0
    if (window->get_min_undequeued_buffer_count(window, &min_bufs)) {
        LOGE("%s---: could not retrieve min undequeued buffer count", __FUNCTION__);
        return -1;
    }

    LOGV("%s: bufs:%i", __FUNCTION__, min_bufs);

    if (min_bufs >= kBufferCount) {
        LOGE("%s: min undequeued buffer count %i is too high (expecting at most %i)",
             __FUNCTION__, min_bufs, kBufferCount - 1);
    }
#endif

#if 1
    LOGV("%s: setting buffer count to %i", __FUNCTION__, kBufferCount);
    if (window->set_buffer_count(window, kBufferCount)) {
        LOGE("%s---: could not set buffer count", __FUNCTION__);
        return -1;
    }
#endif

#if 0
     if (window->set_usage(window, GRALLOC_USAGE_SW_WRITE_MASK)) {
        LOGE("%s---: could not set usage on gralloc buffer", __FUNCTION__);
        return -1;
    }
#endif

      return 0;
   }
}

void set_callbacks(struct camera_device * device,
                      camera_notify_callback notify_cb,
                      camera_data_callback data_cb,
                      camera_data_timestamp_callback data_cb_timestamp,
                      camera_request_memory get_memory, void *user)
{
   LOGV("set_callbacks: notify_cb: %p, data_cb: %p "
        "data_cb_timestamp: %p, get_memory: %p, user :%p",
        notify_cb, data_cb, data_cb_timestamp, get_memory, user);

   origNotify_cb    = notify_cb;
   origData_cb      = data_cb;
   origDataTS_cb    = data_cb_timestamp;
   origCamReqMemory = get_memory;
   qCamera->setCallbacks(cam_notify_callback, cam_data_callback,
                         cam_data_callback_timestamp, user);
}

void enable_msg_type(struct camera_device * device, int32_t msg_type)
{
   LOGV("enable_msg_type: msg_type:%d", msg_type);
   
	LOGV("%s+++: type %i device %p", __FUNCTION__, msg_type,device);
    if (msg_type & CAMERA_MSG_RAW_IMAGE_NOTIFY) {
    	dummy_raw_image_msg = 1;
        //msg_type &= ~CAMERA_MSG_RAW_IMAGE_NOTIFY;
        msg_type |= CAMERA_MSG_RAW_IMAGE;
	}
	//Brian fix a lot of 3rd camera apk glitches start
    else if (msg_type & CAMERA_MSG_COMPRESSED_IMAGE)
	{
	dummy_raw_image_msg = 1;
	msg_type |= CAMERA_MSG_RAW_IMAGE | CAMERA_MSG_SHUTTER;
	}   
   
   qCamera->enableMsgType(msg_type);
}

void disable_msg_type(struct camera_device * device, int32_t msg_type)
{
   LOGV("disable_msg_type: msg_type:%d", msg_type);
   qCamera->disableMsgType(msg_type);
}

int msg_type_enabled(struct camera_device * device, int32_t msg_type)
{
   LOGV("msg_type_enabled: msg_type:%d", msg_type);
   return qCamera->msgTypeEnabled(msg_type);
}

int start_preview(struct camera_device * device)
{
   LOGV("start_preview: Enabling CAMERA_MSG_PREVIEW_FRAME");

    if (if_parameter_set ==0)  // hill, for preview fail of Poco camera apk
        set_parameters(device, get_parameters(device));

   skip_count = 0;      // Hill for MYUI-02321, 120411

   /* TODO: Remove hack. */
   qCamera->enableMsgType(CAMERA_MSG_PREVIEW_FRAME);
   previewEnabled=1;
   return qCamera->startPreview();
}

void stop_preview(struct camera_device * device)
{
   LOGV("stop_preview:");
    Mutex::Autolock lock(mLock);

   skip_count = 0;      // Hill for MYUI-02321, 120411

   /* TODO: Remove hack. */
   qCamera->disableMsgType(CAMERA_MSG_PREVIEW_FRAME);
   previewEnabled=0;
   return qCamera->stopPreview();
}

int preview_enabled(struct camera_device * device)
{
   int en = qCamera->previewEnabled() ? 1 : 0;
   LOGV("preview_enabled: %d", en);
   return en;
}

int store_meta_data_in_buffers(struct camera_device * device, int enable)
{
   LOGV("store_meta_data_in_buffers:");
   //return NO_ERROR;           // hill

   // qsd8k not support store_meta_data_in_buffers.
   int rv = -EINVAL;
   return rv;
}

#ifdef RECORDING_WAIT_FOCUS_ACTION  // hill, 120618, for record&focus status sync
    int start_recording(struct camera_device * device)
    {
       if ( get_focus_sts() !=0)
       {
            LOGE("start_recording pending");
            pending_stop_recording = 0;
            //if ((int)qCamera->recordingEnabled() == 0)
                pending_start_recording = 1;
       }
       else
            start_recording_real();
       return NO_ERROR;
    }

    void stop_recording(struct camera_device * device)
    {
       if ( get_focus_sts() !=0)
       {
            LOGE("stop_recording pending");
            usleep(200*1000);
            pending_start_recording = 0;
            //if ((int)qCamera->recordingEnabled() != 0)
                pending_stop_recording = 1;
            cancel_auto_focus(device);
            usleep(200*1000);
       }
       else
       {
            cancel_auto_focus(device);
            stop_recording_real();
       }
    }

#else

int start_recording(struct camera_device * device)
{
   LOGV("start_recording");

        int i=25;
        while(i--)
        {
            if (get_focus_sts() == 0) break;
            usleep(100*1000);
            LOGE("start_recording sleep: %d, Auto_focus sts: %d", i, get_focus_sts());
        }
        if (i==0)
        {
            LOGE("start_recording, wait Auto_focus status timeout");
            set_focus_sts(0);
        }

   /* TODO: Remove hack. */
   qCamera->enableMsgType(CAMERA_MSG_VIDEO_FRAME);
   qCamera->startRecording();
       usleep(100*1000);
   return NO_ERROR;
}

void stop_recording(struct camera_device * device)
{
   LOGV("stop_recording:");

        int i=25;
        while(i--)
        {
            if (get_focus_sts() == 0) break;
            usleep(100*1000);
            LOGE("stop_recording sleep: %d, Auto_focus sts: %d", i, get_focus_sts());
        }
        if (i==0)
        {
            LOGE("stop_recording, wait Auto_focus status timeout");
            set_focus_sts(0);
        }

   /* TODO: Remove hack. */
   qCamera->disableMsgType(CAMERA_MSG_VIDEO_FRAME);
   qCamera->stopRecording();
}
#endif

int recording_enabled(struct camera_device * device)
{
   LOGV("recording_enabled:%d", qCamera->recordingEnabled());
   return (int)qCamera->recordingEnabled();
}

void release_recording_frame(struct camera_device * device,
                                const void *opaque)
{
   /*
    * We release the frame immediately in cam_data_callback_timestamp after making a
    * copy. So, this is just a NOP.
    */
   LOGV("release_recording_frame: opaque:%p", opaque);
}

int auto_focus(struct camera_device * device)  // hill, 120618, for record&focus status sync
{
   qCamera->enableMsgType(CAMERA_MSG_FOCUS);
   if (get_focus_sts() !=0)
{
       LOGV("Auto_focus redo: %d", get_focus_sts());
       return NO_ERROR;
   }

   inc_focus_sts();
   LOGV("Auto_focus: %d", get_focus_sts());

   qCamera->autoFocus();
   return NO_ERROR;
}

int cancel_auto_focus(struct camera_device * device)  // hill, 120618, for record&focus status sync
{
   LOGV("cancel_auto_focus:");
   qCamera->enableMsgType(CAMERA_MSG_FOCUS);
   dec_focus_sts();
   qCamera->cancelAutoFocus();
   return NO_ERROR;
}

int take_picture(struct camera_device * device)
{
   LOGV("take_picture:");

   /* TODO: Remove hack. */
   qCamera->enableMsgType(CAMERA_MSG_SHUTTER |
                         CAMERA_MSG_POSTVIEW_FRAME |
                         CAMERA_MSG_RAW_IMAGE |
                         CAMERA_MSG_COMPRESSED_IMAGE);

   qCamera->takePicture();
   return NO_ERROR;
}

int cancel_picture(struct camera_device * device)
{
   LOGV("cancel_picture:");
   qCamera->cancelPicture();
   return NO_ERROR;
}

//CameraParameters g_param;
String8 g_str;
int set_parameters(struct camera_device * device, const char *params)
{
	int rv = -EINVAL; 
	CameraParameters camParams;
    int preview_resolution_change = 0;

   //LOGV("set_parameters: %s", params);
   g_str = String8(params);
   //camSettings.unflatten(g_str);
   camParams.unflatten(g_str);

   LOGV("set_parameters, E");
#if LOG_FULL_PARAMS
   camParams.dump();
#endif
   
	if(camParams.get(CameraParameters::KEY_VIDEO_SIZE))
		{
		strcpy(prefer_video_size,camParams.get(CameraParameters::KEY_VIDEO_SIZE));
              //camParams.set(CameraParameters::KEY_PREVIEW_SIZE,
                //  prefer_video_size);//Brian for 2.3 libcamera
    	       }
	if(camParams.get(CameraParameters::KEY_PREVIEW_SIZE))    // Hill for MYUI-02321, 120411
		{
		strcpy(prefer_preview_size,camParams.get(CameraParameters::KEY_PREVIEW_SIZE));
    	       }
    
   //LOGV("KEY_VIDEO_SIZE: %s", prefer_video_size);

/*{Add by Hobo.Shao,for SCR-01796,03/06/2012
*set video record rotation is 0 degree
*/
    //camParams.set(CameraParameters::KEY_ROTATION, 0);	//hobo 03/16/2012 remove for MYUI-01979
/*Add by Hobo.Shao,for SCR-01796,03/06/2012}*/

//Brian for barcode scan fail start
    if(camParams.get(CameraParameters::KEY_PREVIEW_FRAME_RATE))
		strcpy(prefer_frame_rate,camParams.get(CameraParameters::KEY_PREVIEW_FRAME_RATE));

    if(strcmp(camParams.get(CameraParameters::KEY_PREVIEW_SIZE),previous_preview_size))
    {
    	preview_resolution_change = 1;
    	strcpy(previous_preview_size,camParams.get(CameraParameters::KEY_PREVIEW_SIZE));
    }
        Mutex::Autolock lock(mLock);

    if(preview_resolution_change && previewEnabled)
    	qCamera->stopPreview();   
       	
    rv = qCamera->setParameters(camParams);

    if(preview_resolution_change && previewEnabled)
    	qCamera->startPreview();
//Brian for barcode scan fail end
   
   
   //qCamera->setParameters(camSettings);

    if_parameter_set = 1;  // hill, for preview fail of Poco camera apk

#if LOG_FULL_PARAMS
   LOGE("set_parameters, X");
   camParams.dump();
#endif   
   return rv;
   //return NO_ERROR;
}

char * get_parameters(struct camera_device * device)
{    // Hill for MYUI-02321, 120411
   char *rc = NULL;
   LOGV("get_parameters, E");
   camSettings = qCamera->getParameters();
   //LOGV("get_parameters: after calling qCamera->getParameters()");
#if LOG_FULL_PARAMS
   camSettings.dump();
#endif
   CameraHAL_FixupParams(camSettings);
   
   //Brian for video can not record
    camSettings.set(CameraParameters::KEY_SUPPORTED_VIDEO_SIZES,
				  //"1280x720,800x480,720x480,480x320,352x288,320x240,176x144");
				  "1280x720,800x480,640x480,480x320,320x240,176x144");
                  //"1280x720,960x720,800x480,720x480,640x480,640x384,576x432,480x320");	//libcam preview-size-values		   

    // qsd8k x10 only support frame rate 15.
    //camSettings.set(CameraParameters::KEY_SUPPORTED_PREVIEW_FRAME_RATES, "15");	

    // begin modify for panorama mode
	//camSettings.set(CameraParameters::KEY_PREVIEW_FPS_RANGE,"10500,26623");
	//camSettings.set(CameraParameters::KEY_SUPPORTED_PREVIEW_FPS_RANGE,"(10500,26623),(15000,26623),(30000,30000)");
	//camSettings.set(CameraParameters::KEY_HORIZONTAL_VIEW_ANGLE,"54.8");
	//camSettings.set(CameraParameters::KEY_VERTICAL_VIEW_ANGLE,"42.5");
    // end modify for panorama mode

   //Brian for barcode scan fail start
    if(camSettings.get(CameraParameters::KEY_PREVIEW_SIZE))
    	strcpy(previous_preview_size,camSettings.get(CameraParameters::KEY_PREVIEW_SIZE));
   //Brian for barcode scan fail end
   
   g_str = camSettings.flatten();
   rc = strdup((char *)g_str.string());
//   LOGV("get_parameters: returning rc:%p :%s",
//        rc, (rc != NULL) ? rc : "EMPTY STRING");
#if LOG_FULL_PARAMS
   LOGE("get_parameters, X");
   camSettings.dump();
#endif
   return rc;
}

void put_parameters(struct camera_device *device, char *params)
{
   //LOGV("put_parameters: params:%p %s", params, params);
   free(params);
}


int send_command(struct camera_device * device, int32_t cmd,
                        int32_t arg0, int32_t arg1)
{
   LOGV("send_command: cmd:%d arg0:%d arg1:%d",
        cmd, arg0, arg1);
   return NO_ERROR;
}

void release(struct camera_device * device)
{
   LOGV("release:");
   strcpy(prefer_video_size, "\0");     // Hill 120417 for barcode sencond preview fail
   strcpy(prefer_preview_size, "\0");
   strcpy(prefer_frame_rate, "\0");
   strcpy(previous_preview_size, "\0");
   if_parameter_set = 0;  // hill, for preview fail of Poco camera apk
   set_focus_sts(0);  // hill, 120618, for record&focus status sync
#ifdef RECORDING_WAIT_FOCUS_ACTION
    pending_start_recording = 0;
    pending_stop_recording = 0;
#endif
   
   qCamera->setCallbacks(NULL, NULL,
                         NULL, NULL);//Brian avoid unexcept callback after camera release
   qCamera->release();
}

int dump(struct camera_device * device, int fd)
{
   LOGV("dump:");
   Vector<String16> args;
   return qCamera->dump(fd, args);
}

}; // namespace android
