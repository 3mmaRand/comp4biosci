#!/bin/bash

# Loop through all files in the current directory
for file in *; do
  # Check if it's a file and contains at least one underscore
  if [[ -f "$file" && "$file" == *_* ]]; then
    # Create the new name by replacing underscores with hyphens
    new_name="${file//_/-}"
    
    # Rename the file
    mv -- "$file" "$new_name"
    echo "Renamed: $file -> $new_name"
  fi
done
