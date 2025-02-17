#!/bin/bash

# Color definitions
declare -r RED='\033[0;31m'
declare -r GREEN='\033[0;32m'
declare -r BLUE='\033[0;34m'
declare -r NC='\033[0m'

# Installation paths
declare -r INSTALL_DIR="/usr/local/bin"
declare -r SHARE_DIR="/usr/share/clio"
declare -r REQUIRED_DEPS=(tput sed grep cat)
declare -r MIN_DISK_SPACE=10  # Required free space in MB

# Helper functions
print_banner() {
    printf "${BLUE}
    ┌──────────────────────┐
    │    Installing Clio   │
    │    Computing Facts   │
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

check_dependencies() {
    local missing_deps=()

    for dep in "${REQUIRED_DEPS[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        error_exit "missing required tools: ${missing_deps[*]}"
    fi
}

check_existing_installation() {
    if [ -f "$INSTALL_DIR/clio" ]; then
        read -r -p "Existing Clio installation found. Do you want to reinstall? [y/N] " response
        case "$response" in
            [yY][eE][sS]|[yY])
                rm -f "$INSTALL_DIR/clio" "$SHARE_DIR/facts.txt"
                ;;
            *)
                error_exit "installation cancelled by user"
                ;;
        esac
    fi
}

check_system_requirements() {
    # Check disk space
    local free_space
    free_space=$(df -m "$INSTALL_DIR" | awk 'NR==2 {print $4}')
    if [ "$free_space" -lt "$MIN_DISK_SPACE" ]; then
        error_exit "insufficient disk space. Required: ${MIN_DISK_SPACE}MB, Available: ${free_space}MB"
    fi

    # Check filesystem permissions
    if ! touch "$INSTALL_DIR/.write_test" 2>/dev/null; then
        error_exit "unable to write to $INSTALL_DIR"
    fi
    rm -f "$INSTALL_DIR/.write_test"
}

verify_files() {
    local script_dir="$1"

    if [ ! -f "$script_dir/bin/clio" ]; then
        error_exit "clio binary not found in $script_dir/bin/"
    fi

    if [ ! -f "$script_dir/data/facts.txt" ]; then
        error_exit "facts database not found in $script_dir/data/"
    fi

    if [ ! -r "$script_dir/bin/clio" ]; then
        error_exit "cannot read clio binary"
    fi

    if [ ! -r "$script_dir/data/facts.txt" ]; then
        error_exit "cannot read facts database"
    fi
}

install_files() {
    local script_dir
    script_dir="$(dirname "$(readlink -f "$0")")"

    verify_files "$script_dir"

    mkdir -p "$INSTALL_DIR" "$SHARE_DIR" || \
        error_exit "failed to create installation directories"

    cp "$script_dir/bin/clio" "$INSTALL_DIR/" || \
        error_exit "failed to copy clio binary"
    cp "$script_dir/data/facts.txt" "$SHARE_DIR/" || \
        error_exit "failed to copy facts database"

    chmod 755 "$INSTALL_DIR/clio" || \
        error_exit "failed to set executable permissions"
    chmod 644 "$SHARE_DIR/facts.txt" || \
        error_exit "failed to set facts file permissions"
}

verify_installation() {
    if [ ! -f "$INSTALL_DIR/clio" ]; then
        error_exit "installation verification failed: clio binary not found"
    fi

    if [ ! -f "$SHARE_DIR/facts.txt" ]; then
        error_exit "installation verification failed: facts database not found"
    fi

    if [ ! -x "$INSTALL_DIR/clio" ]; then
        error_exit "installation verification failed: clio is not executable"
    fi
}

show_completion() {
    printf "\n${GREEN}Installation complete${NC}\n\n"
    printf "Usage:\n"
    printf "  clio     Display a random computing fact\n"
    printf "  clio -h  Show help information\n\n"
}

main() {
    clear
    print_banner

    print_status "Checking root privileges"
    check_root
    print_success

    print_status "Checking dependencies"
    check_dependencies
    print_success

    print_status "Checking system requirements"
    check_system_requirements
    print_success

    check_existing_installation

    print_status "Installing Clio"
    install_files
    print_success

    print_status "Verifying installation"
    verify_installation
    print_success

    show_completion
}

main "$@"
