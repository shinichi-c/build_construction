#!/bin/bash

repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs
# Sync the repositories
/opt/crave/resync.sh

# Remove existing directories

rm -rf external/libhybris

# Clone repositories

git clone https://github.com/shinichi-c/libhybris --depth=1 external/libhybris

source build/envsetup.sh
lunch aosp_fajita-ap2a-userdebug
m bacon
