#!/bin/bash

# Repo Init
repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs

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
rm -rf hardware/qcom-caf/bootctrl
rm -rf vendor/qcom/opensource/dataservices

# Clone repositories #
# Clang
git clone https://gitlab.com/kei-space/clang/r522817 prebuilts/clang/host/linux-x86/

# Device
git clone https://github.com/shinichi-c/android_device_oneplus_fajita_15 --depth=1 -b Evo_16 device/oneplus/fajita
git clone https://github.com/shinichi-c/android_device_oneplus_sdm845-common_15 --depth=1 -b Evo_16 device/oneplus/sdm845-common

# Vendor
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita --depth=1 -b lineage-22.0 vendor/oneplus/fajita
git clone https://github.com/shinichi-c/proprietary_vendor_oneplus_sdm845-common --depth=1 -b elf_checks vendor/oneplus/sdm845-common

# Kernel
git clone https://github.com/shinichi-c/android_kernel_qcom_sdm845 --depth=1 -b LineageOS-22.1 kernel/oneplus/sdm845

# Hardware
git clone https://github.com/shinichi-c/android_hardware_oneplus --depth=1 -b pixelage hardware/oneplus

# Hals
git clone https://github.com/shinichi-c/media --depth=1 -b upstream hardware/qcom-caf/sdm845/media
git clone https://github.com/shinichi-c/audio --depth=1 -b pixelage hardware/qcom-caf/sdm845/audio
git clone https://github.com/shinichi-c/display --depth=1 -b upstream hardware/qcom-caf/sdm845/display

# Sepolicy
git clone https://github.com/shinichi-c/android_device_pixelage_sepolicy --depth=1 device/lineage/sepolicy
git clone https://github.com/shinichi-c/android_device_qcom_sepolicy_vndr --depth=1 -b lineage-22.2-legacy-um device/qcom/sepolicy_vndr/legacy-um

# bootctrl
git clone https://github.com/shinichi-c/android_hardware_qcom_bootctrl --depth=1 -b lineage-22.2-caf hardware/qcom-caf/bootctrl

git clone https://github.com/shinichi-c/android_vendor_qcom_opensource_dataservices --depth=1 -b lineage-22.2 vendor/qcom/opensource/dataservices

#lunch
export PIXELAGE_BUILD="fajita"
source build/envsetup.sh
lunch lineage_fajita-bp2a-userdebug
mka bacon
