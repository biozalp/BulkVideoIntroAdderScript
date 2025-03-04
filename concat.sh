#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first."
    exit 1
fi

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <intro_video> <target_directory>"
    echo "Example: $0 intro.mp4 ./videos"
    exit 1
fi

INTRO_VIDEO="$1"
TARGET_DIR="$2"

# Check if intro video exists
if [ ! -f "$INTRO_VIDEO" ]; then
    echo "Error: Intro video '$INTRO_VIDEO' not found"
    exit 1
fi

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory '$TARGET_DIR' not found"
    exit 1
fi

# Create output directory
OUTPUT_DIR="$TARGET_DIR/output"
mkdir -p "$OUTPUT_DIR"

# Create temporary directory for concat files
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# Process each video file in the target directory
find "$TARGET_DIR" -type f \( -name "*.mp4" -o -name "*.mov" -o -name "*.avi" \) | while read -r video; do
    # Skip the intro video if it's in the target directory
    if [ "$(realpath "$video")" = "$(realpath "$INTRO_VIDEO")" ]; then
        continue
    fi
    
    # Skip files in the output directory
    if [[ "$video" == "$OUTPUT_DIR"* ]]; then
        continue
    fi

    filename=$(basename "$video")
    output_file="$OUTPUT_DIR/$filename"
    concat_file="$TMP_DIR/${filename}.txt"

    # Create concat file
    echo "file '$(realpath "$INTRO_VIDEO")'" > "$concat_file"
    echo "file '$(realpath "$video")'" >> "$concat_file"

    echo "Processing: $filename"
    ffmpeg -f concat -safe 0 -i "$concat_file" -c copy "$output_file" </dev/null

    if [ $? -eq 0 ]; then
        echo "Successfully created: $output_file"
    else
        echo "Error processing: $filename"
    fi
done

echo "All videos processed!"
