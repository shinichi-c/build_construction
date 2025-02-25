#!/bin/bash

# Repo Init
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fifteen --git-lfs

# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories

rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf hardware/oneplus
rm -rf hardware/qcom-caf/sdm845/media
rm -rf hardware/qcom-caf/sdm845/audio
rm -rf hardware/qcom-caf/sdm845/display
rm -rf device/lineage/sepolicy
rm -rf device/qcom/sepolicy_vndr/legacy-um
rm -rf external/libhybris
rm -rf vendor/lindroid
rm -rf external/lxc
rm -rf frameworks/native
rm -rf frameworks/base

# Clone repositories #
# Clang
git clone https://gitlab.com/kei-space/clang/r522817 prebuilts/clang/host/linux-x86/

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_15 --depth=1 -b Pixelos device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_15 --depth=1 -b Pixelos device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.0 vendor/oneplus/fajita
git clone https://github.com/shinichi-c/proprietary_vendor_oneplus_sdm845-common --depth=1 -b elf_checks vendor/oneplus/sdm845-common

# Kernel
git clone https://github.com/Terminator-J/crdroid_kernel_oneplus_sdm845 --depth=1 -b 14.0-4.19-test2 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 -b pixelage hardware/oneplus

# Hals
git clone https://github.com/shinichi-c/media --depth=1 -b upstream hardware/qcom-caf/sdm845/media
git clone https://github.com/shinichi-c/audio --depth=1 -b pixelage hardware/qcom-caf/sdm845/audio
git clone https://github.com/shinichi-c/display --depth=1 -b upstream hardware/qcom-caf/sdm845/display

# Sepolicy
git clone https://github.com/shinichi-c/android_device_lineage_sepolicy_axion --depth=1 device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 -b lineage-22.1-legacy-um device/qcom/sepolicy_vndr/legacy-um

# lindroid
git clone https://github.com/Linux-on-droid/libhybris --depth=1 -b lindroid-21 external/libhybris
git clone https://github.com/Linux-on-droid/vendor_lindroid --depth=1 -b lindroid-22.1 vendor/lindroid
git clone https://github.com/Linux-on-droid/external_lxc --depth=1 -b lindroid-21 external/lxc

# framework
git clone https://github.com/shinichi-c/frameworks_native_pixelos --depth=1 -b fifteen frameworks/native
git clone https://github.com/shinichi-c/frameworks_base --depth=1 -b fifteen frameworks/base

# gms script

# Configuration
FILE_URL="https://raw.githubusercontent.com/shinichi-c/Gms/pixelage/common-vendor.mk"
OUTPUT_DIR="vendor/gms/common"  # Target directory
OUTPUT_FILE="common-vendor.mk"   # Filename
OUTPUT_PATH="${OUTPUT_DIR}/${OUTPUT_FILE}"  # Full path

# Create directory (if it doesn't exist)
sudo mkdir -p "$OUTPUT_DIR"

# Delete old file (if exists)
sudo rm -f "$OUTPUT_PATH"

# Download the new file to the target directory
sudo wget "$FILE_URL" -O "$OUTPUT_PATH"

# Check if download succeeded
if [ $? -eq 0 ]; then
  echo "Success: File saved to $OUTPUT_PATH"
else
  echo "Error: Failed to download. Check permissions, URL, or network."
  exit 1
fi

# Lunch
source build/envsetup.sh
lunch aosp_fajita-ap4a-userdebug
mka bacon
