#!/bin/bash

# Remove existing directories
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf frameworks/native
rm -rf frameworks/base
rm -rf hardware/oneplus

# Clone repositories
git clone https://github.com/zamasu0/android_device_oneplus_fajita_4.19 --depth=1 -b pxl device/oneplus/fajita
git clone https://github.com/zamasu0/android_device_oneplus_sdm845-common --depth=1 -b pxl_os device/oneplus/sdm845-common
git clone https://github.com/zamasu0/frameworks_native --depth=1 frameworks/native
git clone https://github.com/zamasu0/frameworks_base --depth=1 frameworks/base
git clone https://github.com/zamasu0/android_hardware_oneplus --depth=1 hardware/oneplus

# build-setup
source build/envsetup.sh
lunch aosp_fajita-ap2a-userdebug
m bacon
