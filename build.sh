#!/bin/bash

# Remove existing directories
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf frameworks/native
rm -rf frameworks/base

# Clone repositories
git clone https://github.com/zamasu0/android_device_oneplus_fajita_4.19 --depth=1 -b pxl device/oneplus/fajita
git clone https://github.com/zamasu0/android_device_oneplus_sdm845-common_4.19_los --depth=1 -b pxl device/oneplus/sdm845-common
git clone https://github.com/zamasu0/android_frameworks_native --depth=1 frameworks/native
git clone https://github.com/zamasu0/android_frameworks_base --depth=1 frameworks/base

# build-setup
source build/envsetup.sh
lunch aosp_fajita-ap2a-userdebug
m bacon
