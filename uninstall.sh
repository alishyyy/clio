#!/bin/bash

declare -r RED='\033[0;31m'
declare -r GREEN='\033[0;32m'
declare -r BLUE='\033[0;34m'
declare -r NC='\033[0m'


declare -r INSTALL_DIR="/usr/local/bin"
declare -r SHARE_DIR="/usr/share/clio"

print_banner() {
    printf "${BLUE}
    ┌──────────────────────┐
    │  Uninstalling Clio   │
    └──────────────────────┘
    ${NC}\n"
}

print_status() {
    local message="$1"
    printf "${BLUE}→ %s...${NC} " "$message"
}

print_success() {
    printf "${GREEN}done${NC}\n"
}

error_exit() {
    printf "${RED}error: %s${NC}\n" "$1" >&2
    exit 1
}

check_root() {
    if [ "$(id -u)" != "0" ]; then
        error_exit "this script must be run as root\nPlease run: sudo $0"
    fi
}

check_installation() {
    local files_exist=false

    if [ -f "$INSTALL_DIR/clio" ] || [ -d "$SHARE_DIR" ]; then
        files_exist=true
    fi

    if [ "$files_exist" = false ]; then
        error_exit "Clio is not installed"
    fi
}

remove_files() {
    local had_errors=false

    if [ -f "$INSTALL_DIR/clio" ]; then
        if ! rm -f "$INSTALL_DIR/clio"; then
            error_exit "failed to remove $INSTALL_DIR/clio"
        fi
    fi

    if [ -d "$SHARE_DIR" ]; then
        if ! rm -rf "$SHARE_DIR"; then
            error_exit "failed to remove $SHARE_DIR"
        fi
    fi
}

verify_uninstall() {
    if [ -f "$INSTALL_DIR/clio" ]; then
        error_exit "uninstallation failed: clio binary still present"
    fi

    if [ -d "$SHARE_DIR" ]; then
        error_exit "uninstallation failed: clio data directory still present"
    fi
}

confirm_uninstall() {
    read -r -p "Do you want to uninstall Clio? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            error_exit "uninstallation cancelled by user"
            ;;
    esac
}

show_completion() {
    printf "\n${GREEN}Clio has been successfully uninstalled${NC}\n"
}

main() {
    clear
    print_banner

    print_status "Checking root privileges"
    check_root
    print_success

    print_status "Checking for Clio installation"
    check_installation
    print_success

    confirm_uninstall

    print_status "Removing Clio"
    remove_files
    print_success

    print_status "Verifying uninstallation"
    verify_uninstall
    print_success

    show_completion
}

main "$@"
