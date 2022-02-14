LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := fstab.mt8695
LOCAL_SRC_FILES := etc/fstab.mt8695
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := fstab.mt8695_ramdisk
LOCAL_MODULE_STEM := fstab.mt8695
LOCAL_SRC_FILES := etc/fstab.mt8695
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RAMDISK_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.mt8695.rc
LOCAL_SRC_FILES := etc/init.recovery.mt8695.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_OUT)/root
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.kamakiri.sh
LOCAL_SRC_FILES    := etc/init.kamakiri.sh
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_RECOVERY_OUT)/root
include $(BUILD_PREBUILT)
