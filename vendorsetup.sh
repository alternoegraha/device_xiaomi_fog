# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone https://github.com/alternoegraha/vendor_xiaomi_fog vendor/xiaomi/fog

# Clone prebuilt kernel and kernel headers
git clone -b prebuilt-qti https://github.com/alternoegraha/device_xiaomi_fog-kernel device/xiaomi/fog-kernel
git clone https://github.com/alternoegraha/kernel_xiaomi_fog_header kernel/xiaomi/fog

# Clone my fork of hardware/xiaomi
# git clone https://github.com/alternoegraha/hardware_xiaomi hardware/xiaomi