#!/bin/bash

rm -rf packages/apps/Calendar
rm -rf proprietary/product/app/Photos/Photos.apk
rm -rf proprietary/product/app/PrebuiltGmail/PrebuiltGmail.apk
rm -rf proprietary/product/priv-app/PrebuiltBugle/PrebuiltBugle.apk
rm -rf proprietary/product/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk


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
git clone https://github.com/uwu-gl/kernel_oneplus_sdm845 --depth=1 -b fifteen kernel/oneplus/sdm845
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 vendor/oneplus/fajita
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_sdm845-common --depth=1 vendor/oneplus/sdm845-common
git clone https://github.com/uwu-gl/device_oneplus_fajita --depth=1 -b fifteen device/oneplus/fajita
git clone https://github.com/uwu-gl/device_oneplus_sdm845-common --depth=1 -b fifteen device/oneplus/sdm845-common
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 hardware/oneplus

source build/envsetup.sh
lunch yaap_fajita-ap3a-userdebug
m bacon
