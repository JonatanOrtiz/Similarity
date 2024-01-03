#!/bin/bash

# Store the current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Define colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Find all Xcode projects and perform pod deintegrate
find . -name "*.xcodeproj" -type d | while read -r project; do
    project_name=$(basename "$project" .xcodeproj)
    cd "$(dirname "$project")" # Navigate to the project directory
    echo -e "-----------------------------------------------------------------------------"
    echo -e "Module: $project_name\n"
    pod deintegrate
    cd "$SCRIPT_DIR" # Navigate back to the original directory
done

echo -e "-----------------------------------------------------------------------------"
echo -e "\n${GREEN}POD DEINTEGRATION COMPLETED!\n${NC}"
