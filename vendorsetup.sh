# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone -b thirteen https://github.com/alternoegraha/vendor_xiaomi_fog vendor/xiaomi/fog

# Clone kernel prebuilt
git clone https://github.com/alternoegraha/device_xiaomi_fog-kernel device/xiaomi/fog-kernel

# Clone LineageOS' hardware/xiaomi
git clone -b lineage-20 https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi