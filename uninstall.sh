#!/bin/bash

# Uninstallation script for clio
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
NC=$'\033[0m'

# Installation directories
INSTALL_DIR="/usr/local/bin"
SHARE_DIR="/usr/local/share/clio"

if [ "$(id -u)" != "0" ]; then
    printf "%sError: This script must be run as root%s\n" "$RED" "$NC"
    printf "Please try: sudo %s\n" "$0"
    exit 1
fi

# Remove files and directories
rm -f "$INSTALL_DIR/clio"
rm -rf "$SHARE_DIR"

printf "%sclio has been successfully uninstalled.%s\n" "$GREEN" "$NC"
