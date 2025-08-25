#!/bin/bash

# Repo Init
repo init -u https://github.com/DerpFest-AOSP/android_manifest.git -b 16 --git-lfs

# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories

rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf hardware/oneplus
rm -rf hardware/qcom-caf/sdm845/audio
rm -rf hardware/qcom-caf/sm8250/audio
rm -rf hardware/qcom-caf/sm8250/display
rm -rf device/lineage/sepolicy
rm -rf device/qcom/sepolicy_vndr/legacy-um
rm -rf hardware/qcom-caf/common
rm -rf external/libhybris
rm -rf vendor/lindroid
rm -rf external/lxc
rm -rf hardware/lineage/livedisplay

# Clone repositories #

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_16 --depth=1 -b lineage-23.0 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_16 --depth=1 -b lineage-23.0 device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.2 vendor/oneplus/fajita
git clone https://github.com/shinichi-c/proprietary_vendor_oneplus_sdm845-common --depth=1 -b c2-markv4 vendor/oneplus/sdm845-common

# Kernel
git clone https://github.com/shinichi-c/android_kernel_oneplus_sdm845 --depth=1 -b lineage-23.0 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 -b lineage-23.0 hardware/oneplus

# Hals
git clone https://github.com/shinichi-c/android_hardware_qcom_audio --depth=1 -b markv1 hardware/qcom-caf/sdm845/audio
git clone https://github.com/shinichi-c/android_hardware_qcom_audio --depth=1 -b markv1 hardware/qcom-caf/sm8250/audio
git clone https://github.com/shinichi-c/android_hardware_qcom_display --depth=1 -b markv1 hardware/qcom-caf/sm8250/display

# Sepolicy
git clone https://github.com/shinichi-c/android_device_lineage_sepolicy --depth=1 -b derp device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 -b derp device/qcom/sepolicy_vndr/legacy-um

# qcom-caf_common
git clone https://github.com/shinichi-c/android_hardware_qcom-caf_common --depth=1 -b markv1 hardware/qcom-caf/common

#lunch
source build/envsetup.sh
. build/envsetup.sh
lunch lineage_fajita-bp2a-userdebug
make installclean
mka derp
