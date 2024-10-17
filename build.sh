#!/bin/bash

repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs
# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf hardware/oneplus

# Clone repositories
git clone https://github.com/Terminator-J/crdroid_kernel_oneplus_sdm845 --depth=1 -b 14.0-4.19-test2 kernel/oneplus/sdm845
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 vendor/oneplus/fajita
git clone https://github.com/shinichi-c/proprietary_vendor_oneplus_sdm845-common --depth=1 vendor/oneplus/sdm845-common
git clone https://github.com/shinichi-c/android_device_oneplus_fajita --depth=1 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common --depth=1 -b pxl_os device/oneplus/sdm845-common
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 hardware/oneplus

source build/envsetup.sh
lunch aosp_fajita-ap2a-userdebug
m bacon
