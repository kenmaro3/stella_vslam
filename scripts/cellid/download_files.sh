#!/bin/sh

# For downloading files that needed to generate the run_video_vslam_headless

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error
set -o pipefail  # Prevents errors in a pipeline from being masked

TOPDIR="$(dirname "$(realpath "$0")")"/../../  # stella_vslam directory
DATA_DIR="${TOPDIR}/data"

# Google Drive Files
FOLDER_ID="1IlmQaFhSw9AqacWDXwMMp3TCjjqzI68Q"
VIDEO="office_1280_960.mp4"
EQUI_YAML="equirectangular.yaml"
VOCAB="orb_vocab.fbow"
VSLAM_HEADLESS="run_video_slam_headless.cc"

# Create data directory if it doesn't exist
mkdir -p "$DATA_DIR"

download_from_drive() {
    FOLDER_ID="$1"
    OUTPUT_FILE="$DATA_DIR/$2"

    if [ -f "$OUTPUT_FILE" ]; then
        echo "$OUTPUT_FILE already exists. Skipping download."
        return
    fi

    echo "Downloading $OUTPUT_FILE..."
    COOKIE_FILE=$(mktemp)

    curl -sc "$COOKIE_FILE" "https://drive.google.com/uc?export=download&id=${FOLDER_ID}" > /dev/null
    CODE="$(awk '/_warning_/ {print $NF}' "$COOKIE_FILE")"
    curl -sLb "$COOKIE_FILE" "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FOLDER_ID}" -o "$OUTPUT_FILE"

    rm -f "$COOKIE_FILE"
    echo "Downloaded $OUTPUT_FILE successfully."
}

# Download files only if they don’t already exist
download_from_drive "$FOLDER_ID" "$VIDEO"
download_from_drive "$FOLDER_ID" "$EQUI_YAML"
download_from_drive "$FOLDER_ID" "$VOCAB"
download_from_drive "$FOLDER_ID" "$VSLAM_HEADLESS"

echo "All downloads completed successfully."
