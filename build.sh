rm -rf .repo/local_manifests/

# Repo Init
repo init -u https://github.com/LineageOS/android.git -b lineage-22.0 --git-lfs
repo init -u https://github.com/LineageOS/android.git -b lineage-22.0 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shinichi-c/local_manifests_oplus --depth 1 .repo/local_manifests

# Resync
/opt/crave/resync.sh

# Lunch
source build/envsetup.sh
curl https://raw.githubusercontent.com/shinichi-c/build_construction/refs/heads/pick.sh/pick.sh | bash
lunch lineage_fajita-ap3a-userdebug
m bacon
