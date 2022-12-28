#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/fog

# Display
TARGET_SCREEN_DENSITY := 320

# HIDL
ODM_MANIFEST_SKUS += c3qn
ODM_MANIFEST_C3QN_FILES := $(DEVICE_PATH)/manifest_c3qn.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_xiaomi_fog
TARGET_RECOVERY_DEVICE_MODULES := init_xiaomi_fog

# Kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel

# OTA assert
TARGET_OTA_ASSERT_DEVICE := fog,rain,wind

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Inherit from sm6225-common
include device/xiaomi/sm6225-common/BoardConfigCommon.mk

# Inherit from the proprietary version
include vendor/xiaomi/fog/BoardConfigVendor.mk
