#!/bin/bash

repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs
# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf device/lineage/sepolicy
rm -rf device/qcom/sepolicy_vndr/legacy-um
rm -rf kernel/oneplus/sdm845
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf hardware/oneplus
rm -rf hardware/qcom-caf/sdm845/media
rm -rf hardware/qcom-caf/sdm845/audio
rm -rf hardware/qcom-caf/sdm845/display
rm -rf frameworks/native
rm -rf frameworks/base
rm -rf external/libhybris
rm -rf vendor/lindroid
rm -rf external/lxc
rm -r vendor/gms/common/common-vendor.mk

# Clone repositories
git clone https://github.com/Terminator-J/crdroid_kernel_oneplus_sdm845 --depth=1 -b 14.0-4.19-test2 kernel/oneplus/sdm845
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 vendor/oneplus/fajita
git clone https://github.com/shinichi-c/proprietary_vendor_oneplus_sdm845-common --depth=1 vendor/oneplus/sdm845-common
git clone https://github.com/shinichi-c/device_lineage_sepolicy --depth=1 device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 device/qcom/sepolicy_vndr/legacy-um
git clone https://github.com/shinichi-c/media --depth=1 hardware/qcom-caf/sdm845/media
git clone https://github.com/shinichi-c/audio --depth=1 hardware/qcom-caf/sdm845/audio
git clone https://github.com/shinichi-c/display --depth=1 hardware/qcom-caf/sdm845/display
git clone https://github.com/Linux-on-droid/vendor_lindroid --depth=1 vendor/lindroid
git clone https://github.com/Linux-on-droid/libhybris --depth=1 -b staging/lindroid-21 external/libhybris
git clone https://github.com/Linux-on-droid/external_lxc --depth=1 external/lxc
git clone https://github.com/shinichi-c/android_device_oneplus_fajita --depth=1 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common --depth=1 -b pxl_os device/oneplus/sdm845-common
git clone https://github.com/shinichi-c/frameworks_native_pxl --depth=1 frameworks/native
git clone https://github.com/shinichi-c/frameworks_base_pxlos --depth=1 frameworks/base
git clone https://github.com/LineageOS/android_hardware_oneplus --depth=1 hardware/oneplus

# build-setup
make installclean

source build/envsetup.sh
lunch aosp_fajita-ap2a-userdebug
m bacon
