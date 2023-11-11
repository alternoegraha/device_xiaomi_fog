# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone -b lineage-20-new https://github.com/alternoegraha/vendor_xiaomi_fog vendor/xiaomi/fog

# Clone kernel tree (Sea kernel by Asyanx)
git clone https://github.com/Asyanx/Sea_Kernel-Fog kernel/xiaomi/fog

# Clone my fork of hardware/xiaomi
# git clone https://github.com/alternoegraha/hardware_xiaomi hardware/xiaomi

# Kernel fixups
cd kernel/xiaomi/fog
git reset --hard 6ea05a0
sed -i 's+R¹.+R0/Upstream+' arch/arm64/configs/vendor/fog-perf_defconfig # rebrand to fix kernel compilation issue during build
cd ../../../