# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone -b fifteen https://github.com/r0ddty/vendor_xiaomi_fog vendor/xiaomi/fog --depth 1

# Clone kernel tree
git clone -b andromeda https://github.com/r0ddty/kernel_xiaomi_fog kernel/xiaomi/fog --depth 1

# Clone prebuilt kernel
git clone -b andromeda https://github.com/r0ddty/device_xiaomi_fog-kernel device/xiaomi/fog-kernel --depth 1

# Clone LOS hardware/xiaomi
git clone -b lineage-22.0 https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi --depth 1

# LineageOS SEpolicy
git clone -b lineage-22.0 https://github.com/LineageOS/android_device_lineage_sepolicy device/lineage/sepolicy --depth 1

# libfmjni duplicate fixup
mv vendor/nxp/opensource/libfmjni/Android.mk vendor/nxp/opensource/libfmjni/Android.mk.old
