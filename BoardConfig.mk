#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/fog

# Display
TARGET_SCREEN_DENSITY := 320

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_xiaomi_fog
TARGET_RECOVERY_DEVICE_MODULES := init_xiaomi_fog

# OTA assert
TARGET_OTA_ASSERT_DEVICE := fog,rain,wind

# Inherit from sm6225-common
include device/xiaomi/sm6225-common/BoardConfigCommon.mk

# Inherit from the proprietary version
include vendor/xiaomi/fog/BoardConfigVendor.mk
