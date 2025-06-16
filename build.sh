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
rm -rf build/make
rm -rf vendor/lineage

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

# dataservice
git clone https://github.com/shinichi-c/android_vendor_qcom_opensource_dataservices --depth=1 -b lineage-22.2 vendor/qcom/opensource/dataservices

# build/make
git clone https://github.com/shinichi-c/build_evo --depth=1 -b bka build/make

# vendor/lineage
git clone https://github.com/shinichi-c/vendor_evolution --depth=1 -b bka vendor/lineage

#lunch
export PIXELAGE_BUILD="fajita"
source build/envsetup.sh

#!/bin/bash

# Define the target directory and file name
TARGET_DIR="hardware/google/pixel/kernel_headers"
FILE_NAME="Android.bp"
FULL_PATH="${TARGET_DIR}/${FILE_NAME}"

# Define the raw GitHub URL of your new Android.bp file
# IMPORTANT: REPLACE THIS WITH THE ACTUAL RAW GITHUB URL OF YOUR FILE
# Example: https://raw.githubusercontent.com/your-username/your-repo/your-branch/path/to/Android.bp
GITHUB_RAW_URL="https://raw.githubusercontent.com/shinichi-c/android_device_oneplus_fajita_15/refs/heads/lineage-22.1/Android.bp" 

# Check if the GITHUB_RAW_URL has been updated
if [ "$GITHUB_RAW_URL" = "YOUR_RAW_GITHUB_URL_HERE" ]; then
    echo "Error: Please update the 'GITHUB_RAW_URL' variable in the script with the actual raw GitHub URL of your Android.bp file."
    exit 1
fi

# Create the target directory if it doesn't exist
echo "Ensuring target directory exists: $TARGET_DIR..."
mkdir -p "$TARGET_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Could not create or access directory $TARGET_DIR. Check permissions."
    exit 1
fi

# Navigate to the target directory
echo "Navigating to $TARGET_DIR..."
cd "$TARGET_DIR" || { echo "Error: Could not change directory to $TARGET_DIR"; exit 1; }

# Delete the existing file if it exists
echo "Attempting to delete existing $FILE_NAME..."
if [ -f "$FILE_NAME" ]; then
    rm -f "$FILE_NAME"
    if [ $? -eq 0 ]; then
        echo "Existing $FILE_NAME deleted successfully."
    else
        echo "Error: Could not delete existing $FILE_NAME. Check permissions."
        exit 1
    fi
else
    echo "No existing $FILE_NAME found to delete."
fi

# Download the new file from GitHub
echo "Downloading new $FILE_NAME from $GITHUB_RAW_URL..."
curl -sL "$GITHUB_RAW_URL" -o "$FILE_NAME"
if [ $? -eq 0 ]; then
    echo "New $FILE_NAME downloaded successfully."
else
    echo "Error: Could not download new $FILE_NAME from GitHub. Check URL or network connection."
    exit 1
fi

# Set full permissions (777) for the new file
echo "Setting full permissions (777) for $FILE_NAME..."
chmod 777 "$FILE_NAME"
if [ $? -eq 0 ]; then
    echo "Permissions set successfully."
else
    echo "Error: Could not set permissions for $FILE_NAME."
    exit 1
fi

echo "Script completed."

lunch lineage_fajita-bp2a-userdebug
mka bacon
