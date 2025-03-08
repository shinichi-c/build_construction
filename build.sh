#!/bin/bash

# Repo Init
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs

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
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_15 --depth=1 -b Evolution_X device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_15 --depth=1 -b Evolution_X device/oneplus/sdm845-common

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
git clone https://github.com/shinichi-c/device_evolution_sepolicy --depth=1 device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 -b lineage-22.1-legacy-um device/qcom/sepolicy_vndr/legacy-um

# lindroid
git clone https://github.com/Linux-on-droid/libhybris --depth=1 -b lindroid-21 external/libhybris
git clone https://github.com/Linux-on-droid/vendor_lindroid --depth=1 -b lindroid-22.1 vendor/lindroid
git clone https://github.com/Linux-on-droid/external_lxc --depth=1 -b lindroid-21 external/lxc

# framework
git clone https://github.com/shinichi-c/frameworks_native_evo --depth=1 -b vic frameworks/native
git clone https://github.com/shinichi-c/frameworks_base_evo --depth=1 -b vic frameworks/base

# Lunch
source build/envsetup.sh

# gms

# Configuration (verified working URL)
FILE_URL="https://raw.githubusercontent.com/shinichi-c/Gms/refs/heads/Evolution_X/gms_full.mk"
OUTPUT_DIR="vendor/gms"  # Use relative path inside AOSP workspace
OUTPUT_FILE="gms_full.mk"
OUTPUT_PATH="${OUTPUT_DIR}/${OUTPUT_FILE}"

# Create directory (no sudo needed in AOSP workspace)
mkdir -p "$OUTPUT_DIR"

# Delete old file (if exists)
rm -f "$OUTPUT_PATH"

# Download file
wget "$FILE_URL" -O "$OUTPUT_PATH"

# Set BASIC permissions (rw-r--r--, avoid 777 for security)
if [ -f "$OUTPUT_PATH" ]; then
  chmod 777 "$OUTPUT_PATH"
  echo "Success: File downloaded to $OUTPUT_PATH with permissions 644"
else
  echo "Error: File download failed. Check URL: $FILE_URL"
  exit 1
fi

lunch lineage_fajita-ap4a-userdebug
m evolution
