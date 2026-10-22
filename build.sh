#!/bin/bash

rm -rf .repo/local_manifests

# Repo Init
repo init -u https://github.com/Evolution-X/manifest -b cnb --git-lfs

# Device Tree's
git clone https://github.com/shinichi-c/manifest --depth 1 -b main .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh
repo sync -c -j$(nproc --all) --force-sync --force-remove-dirty --no-clone-bundle --no-tags
/opt/crave/resync.sh
repo sync -c -j$(nproc --all) --force-sync --force-remove-dirty --no-clone-bundle --no-tags
/opt/crave/resync.sh

#lunch
. build/envsetup.sh
lunch lineage_fajita-cp2a-userdebug
make installclean
m evolution
