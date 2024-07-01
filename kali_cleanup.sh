#!/bin/bash

# Function to check if the script is run as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root or using sudo."
        exit 1
    fi
}

# Function to clean package cache
clean_package_cache() {
    echo "Cleaning package cache..."
    apt-get clean
    apt-get autoclean
}

# Function to remove orphaned packages
remove_orphaned_packages() {
    echo "Removing orphaned packages..."
    apt-get autoremove -y
}

# Function to clear systemd journal logs
clear_journal_logs() {
    echo "Clearing systemd journal logs..."
    journalctl --vacuum-time=3d
}

# Function to clear tmp directory
clear_tmp() {
    echo "Clearing /tmp directory..."
    rm -rf /tmp/*
}

# Function to clear thumbnail cache
clear_thumbnails() {
    echo "Clearing thumbnail cache..."
    rm -rf ~/.cache/thumbnails/*
}

# Function to update the system
update_system() {
    echo "Updating system..."
    apt-get update
    apt-get upgrade -y
    
}

# Main function
main() {
    check_root
    clean_package_cache
    remove_orphaned_packages
    clear_journal_logs
    clear_tmp
    clear_thumbnails
    update_system
    echo "System cleanup complete!"
}

# Run the main function
main
