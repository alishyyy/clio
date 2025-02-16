#!/bin/bash

# Installation script for clio
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
NC=$'\033[0m'

# Get script directory
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# Installation directories
INSTALL_DIR="/usr/local/bin"
SHARE_DIR="/usr/local/share/clio"

show_install_progress() {
    local -a frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local message="$1"
    local frame_count=${#frames[@]}

    for ((i=0; i<10; i++)); do
        printf "\r${YELLOW}%s ${frames[i % frame_count]}${NC}" "$message"
        sleep 0.1
    done
    printf "\n"
}

if [ "$(id -u)" != "0" ]; then
    printf "%sError: This script must be run as root%s\n" "$RED" "$NC"
    printf "Please try: sudo %s\n" "$0"
    exit 1
fi

# Create directories
show_install_progress "Creating archives directory..."
mkdir -p "$INSTALL_DIR" "$SHARE_DIR"

# Copy files
show_install_progress "Installing clio..."
cp "$SCRIPT_DIR/bin/clio" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/data/facts.txt" "$SHARE_DIR/"

# Set permissions
show_install_progress "Setting permissions..."
chmod 755 "$INSTALL_DIR/clio"
chmod 644 "$SHARE_DIR/facts.txt"

printf "%s✨ clio has been installed successfully! ✨%s\n" "$GREEN" "$NC"
printf "\nRun 'clio' to begin exploring computing history!\n"
