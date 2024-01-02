# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone -b lineage-20-new https://github.com/alternoegraha/vendor_xiaomi_fog vendor/xiaomi/fog

# Clone kernel tree (Sea kernel by Asyanx)
git clone https://github.com/Asyanx/Sea_Kernel-Fog kernel/xiaomi/fog

# Clone hardware/xiaomi from PE
git clone https://github.com/PixelExperience/hardware_xiaomi hardware/xiaomi

# Revert "audio: Use TARGET_HALS_PATH"
cd hardware/qcom-caf/bengal/audio
git revert 29922217e247c35c465f7d0f7c606ea7a442521e
cd ../../../../

# Kernel fixups
cd kernel/xiaomi/fog
## Revert "treewide: Fix all coding errors found by GCC 11.2.1"
#git revert --no-commit 91dc89f
## Revert "kernel: Fix error when compile use GCC"
#git revert --no-commit 7d72ccb
sed -i 's+R¹.+R0/Upstream+' arch/arm64/configs/vendor/fog-perf_defconfig # rebrand to fix kernel compilation issue during build
cd ../../../