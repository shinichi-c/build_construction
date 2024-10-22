#!/bin/bash

# Repo Init
repo init -u https://github.com/LineageOS/android.git -b lineage-22.0 --git-lfs

# Resync
/opt/crave/resync.sh

# Remove existing directories

rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf hardware/oneplus

# Clone repositories #

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_15 --depth=1 -b lineage-22.0 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_15 --depth=1 -b lineage-22.0 device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.0 vendor/oneplus/fajita
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_sdm845-common --depth=1 -b lineage-22.0 vendor/oneplus/sdm845-common

# Kernel
git clone https://github.com/LineageOS/android_kernel_oneplus_sdm845 --depth=1 -b lineage-21 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/LineageOS/android_hardware_oneplus --depth=1 -b lineage-22.0 hardware/oneplus

# Lunch
source build/envsetup.sh
curl https://raw.githubusercontent.com/shinichi-c/build_construction/refs/heads/pick.sh/pick.sh | bash
lunch lineage_fajita-ap3a-userdebug
m bacon
