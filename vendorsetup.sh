# Remove Pixel kernel header
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Clone vendor tree
git clone -b fifteen https://github.com/alternoegraha/vendor_xiaomi_fog vendor/xiaomi/fog

# Clone kernel tree
git clone --depth=1 -b another-reset https://github.com/alternoegraha/wwy_kernel_xiaomi_fog_rebase kernel/xiaomi/fog

# Clone PixelOS-AOSP hardware/xiaomi
git clone https://github.com/PixelOS-AOSP/hardware_xiaomi hardware/xiaomi

# Clone CertifiedPropsOverlay
git clone https://github.com/pure-soul-kk/vendor_extra vendor/extra

# Kernel fixups
cd kernel/xiaomi/fog
rm -rf Android.bp
rm -rf techpack/audio/Android.bp
cd ../../..