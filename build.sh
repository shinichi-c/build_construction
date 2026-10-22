#!/bin/bash

# Repo Init
repo init -u https://github.com/Evolution-X/manifest -b cnb --git-lfs

# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories

rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf hardware/oneplus
rm -rf build/soong
rm -rf vendor/lineage

# Clone repositories #

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_16 --depth=1 -b Evo12 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_16 --depth=1 -b marka17E device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.2 vendor/oneplus/fajita
git clone https://github.com/EdwinMoq/proprietary_vendor_oneplus_sdm845-common --depth=1 -b lineage-24.0 vendor/oneplus/sdm845-common

# Kernel
git clone https://github.com/shinichi-c/android_kernel_oneplus_sdm845 --depth=1 -b Evo12 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 -b Evo12 hardware/oneplus

# soong
git clone https://github.com/shinichi-c/build_soong --depth=1 -b cnb build/soong

# vendor
git clone https://github.com/shinichi-c/vendor_evolution --depth=1 -b Evo12 vendor/lineage

#lunch
. build/envsetup.sh
lunch lineage_fajita-cp2a-userdebug
make installclean
m evolution
