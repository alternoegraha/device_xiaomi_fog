# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone -b fifteen https://github.com/r0ddty/vendor_xiaomi_fog vendor/xiaomi/fog

# Clone kernel tree
git clone -b another-main https://github.com/r0ddty/kernel_xiaomi_fog kernel/xiaomi/fog

# Clone LOS hardware/xiaomi
git clone -b lineage-22.0 https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi

# MIUI Camera
git clone -b leica-5.0 https://gitlab.com/r0ddty/vendor_xiaomi_miuicamera_fog vendor/xiaomi/miuicamera

# OTA
rm -rf packages/apps/Updater
git clone -b fifteen https://github.com/r0ddty/android_packages_apps_Updater_fog_unoff packages/apps/Updater

rm -rf vendor/risingOTA
git clone -b fifteen https://github.com/r0ddty/android_vendor_RisingOTA_fog_unoff vendor/risingOTA

# Kernel fixups
rm kernel/xiaomi/fog/Android.bp
rm kernel/xiaomi/fog/techpack/audio/Android.bp
