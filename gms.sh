#!/bin/bash

# Define the URL of the file
url="https://raw.githubusercontent.com/shinichi-c/Gms/refs/heads/pixelage/common-vendor.mk"

# Define the destination directory
destination_dir="vendor/gms/common"

# Check if the destination directory exists
if [ ! -d "$destination_dir" ]; then
  echo "Error: Destination directory '$destination_dir' does not exist."
  exit 1
fi

# Download the file
wget -O "$destination_dir/common-vendor.mk" "$url"

# Check the download status
if [ $? -eq 0 ]; then
  echo "Successfully downloaded 'common-vendor.mk' to '$destination_dir'."
else
  echo "Error: Download failed."
fi
