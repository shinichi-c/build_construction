#!/bin/bash

# Repo Init
repo init -u https://github.com/Evolution-X/manifest -b bq2 --git-lfs

# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories

rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf hardware/oneplus
rm -rf hardware/qcom-caf/sm8250/audio
rm -rf hardware/qcom-caf/sm8250/display
# rm -rf device/lineage/sepolicy
rm -rf device/qcom/sepolicy_vndr/legacy-um
rm -rf hardware/qcom-caf/common
rm -rf external/libhybris
rm -rf vendor/lindroid
rm -rf external/lxc
rm -rf frameworks/native
rm -rf frameworks/base

# Clone repositories #

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_16 --depth=1 -b Qpr2-mark2 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_16 --depth=1 -b markv21E device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.2 vendor/oneplus/fajita
git clone https://github.com/EdwinMoq/proprietary_vendor_oneplus_sdm845-common --depth=1 -b lineage-23.2-4.19 vendor/oneplus/sdm845-common

# Kernel
git clone https://github.com/shinichi-c/android_kernel_oneplus_sdm845 --depth=1 -b markv8 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 -b Qpr2-markv5_E hardware/oneplus

# Hals
git clone https://github.com/shinichi-c/android_hardware_qcom_audio --depth=1 -b markE2 hardware/qcom-caf/sm8250/audio
git clone https://github.com/shinichi-c/android_hardware_qcom_display --depth=1 -b markE2 hardware/qcom-caf/sm8250/display

# Sepolicy
# git clone https://github.com/shinichi-c/device_evolution_sepolicy.git --depth=1 -b bq2 device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 -b lineage-23.2-legacy-um device/qcom/sepolicy_vndr/legacy-um

# qcom-caf_common
git clone https://github.com/shinichi-c/android_hardware_qcom-caf_common --depth=1 -b markv6 hardware/qcom-caf/common

# framework
git clone https://github.com/Evolution-X/frameworks_native --depth=1 -b bq2 frameworks/native
git clone https://github.com/Evolution-X/frameworks_base --depth=1 -b bq2 frameworks/base

# lindroid
# git clone https://github.com/Linux-on-droid/libhybris --depth=1 -b tmp external/libhybris
# git clone https://github.com/shinichi-c/vendor_lindroid --depth=1 -b lindroid-23.2 vendor/lindroid
# git clone https://github.com/Linux-on-droid/external_lxc --depth=1 -b lindroid-21 external/lxc

#lunch
. build/envsetup.sh
lunch lineage_fajita-bp4a-userdebug
make installclean
m evolution
