#!/bin/bash

# Repo Init
repo init -u https://github.com/ProjectBlaze-Reborn/manifest.git -b 15 --git-lfs --depth=1

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

# Clone repositories #

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_15 --depth=1 -b blaze device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_15 --depth=1 -b blaze device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.0 vendor/oneplus/fajita
git clone https://github.com/shinichi-c/proprietary_vendor_oneplus_sdm845-common --depth=1 -b pixelage vendor/oneplus/sdm845-common
git clone https://github.com/shinichi-c/vendor_blaze --depth=1 -b 15 vendor/blaze

# Kernel
git clone https://github.com/Terminator-J/crdroid_kernel_oneplus_sdm845 --depth=1 -b 14.0-4.19-test2 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 -b pixelage hardware/oneplus

# Hals
git clone https://github.com/shinichi-c/media --depth=1 -b upstream hardware/qcom-caf/sdm845/media
git clone https://github.com/shinichi-c/audio --depth=1 -b pixelage hardware/qcom-caf/sdm845/audio
git clone https://github.com/shinichi-c/display --depth=1 -b upstream hardware/qcom-caf/sdm845/display

# Sepolicy
git clone https://github.com/shinichi-c/device_blaze_sepolicy --depth=1 device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 -b lineage-22.0-legacy-um device/qcom/sepolicy_vndr/legacy-um

# Lunch
source build/envsetup.sh
lunch blaze_fajita-ap3a-userdebug
make bacon
