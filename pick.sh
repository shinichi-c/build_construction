#!/bin/bash

# Script location (replace with actual path if needed)
script_url="https://raw.githubusercontent.com/shinichi-c/los-repo/refs/heads/Test/picks.sh"
script_name="picks.sh"  # Local filename (can be same as remote)

# Check if picks.sh already exists
if [ -f "$script_name" ]; then
  echo "$script_name already exists. Skipping download."
else
  echo "Downloading $script_url..."
  curl -sSL "$script_url" -o "$script_name"
  if [ $? -eq 0 ]; then
    echo "Download successful."
    chmod +x "$script_name"
    echo "Executing $script_name..."
    . "$script_name"
  else
    echo "Error downloading script."
  fi
fi
