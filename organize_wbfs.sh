#!/bin/bash

# Set source and destination directories
SOURCE_DIR="$1"
DEST_DRIVE="$2"

# Check input arguments
if [[ -z "$SOURCE_DIR" || -z "$DEST_DRIVE" ]]; then
  echo "Usage: $0 <source_directory> <mounted_external_drive_path>"
  exit 1
fi

# Destination WBFS folder
WBFS_DIR="$DEST_DRIVE/wbfs"

# Create wbfs directory if it doesn't exist
mkdir -p "$WBFS_DIR"

# Find all .wbfs files recursively
find "$SOURCE_DIR" -type f -iname '*.wbfs' | while read -r wbfs_file; do
  # Extract filename
  filename=$(basename "$wbfs_file")

  # Match game name and GameID using regex
  if [[ "$filename" =~ ^(.*)\ \[([A-Z0-9]{6})\]\.wbfs$ ]]; then
    game_name="${BASH_REMATCH[1]}"
    game_id="${BASH_REMATCH[2]}"
    
    # Sanitize game name for folder
    folder_name="${game_name//\//-} [${game_id}]"
    
    # Create destination folder
    dest_folder="$WBFS_DIR/$folder_name"
    mkdir -p "$dest_folder"
    
    # Copy or move the file
    echo "Moving: $filename -> $dest_folder/$game_id.wbfs"
    mv "$wbfs_file" "$dest_folder/$game_id.wbfs"
  else
    echo "Skipping: $filename (invalid format)"
  fi
done

