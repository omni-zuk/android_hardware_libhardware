#
# Copyright (C) 2013 The Android Open-Source Project
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

LOCAL_PATH := $(call my-dir)

ifeq ($(USE_SENSOR_MULTI_HAL),true)
ifneq ($(PRODUCT_FULL_TREBLE),true)

include $(CLEAR_VARS)

ifneq ($(BOARD_SENSOR_HAL_SUFFIX),)
    HAL_SUFFIX := $(BOARD_SENSOR_HAL_SUFFIX)
else
    HAL_SUFFIX := $(TARGET_DEVICE)
endif

LOCAL_MODULE := sensors.$(HAL_SUFFIX)

LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true

LOCAL_CFLAGS := -DLOG_TAG=\"MultiHal\"

LOCAL_SRC_FILES := \
    multihal.cpp \
    SensorEventQueue.cpp \

LOCAL_HEADER_LIBRARIES := \
    libhardware_headers \

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libdl \
    liblog \
    libutils \

LOCAL_STRIP_MODULE := false

include $(BUILD_SHARED_LIBRARY)

else
$(warning Treble enabled device have built-in sensor multihal support. \
          USE_SENSOR_MULTI_HAL should not be set.)
endif # PRODUCT_FULL_TREBLE
endif # USE_SENSOR_MULTI_HAL

include $(call all-makefiles-under, $(LOCAL_PATH))
