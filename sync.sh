#!/usr/bin/env bash
# sync.sh - Helper script to stage, commit, and push .msch schematic files
# Usage: ./sync.sh ["custom commit message"]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not a git repository. Run 'git init' first.${NC}"
    exit 1
fi

# Check if remote is configured
if ! git remote | grep -q '^origin$'; then
    echo -e "${RED}Error: No 'origin' remote configured.${NC}"
    echo "Run: git remote add origin <your-github-repo-url>"
    exit 1
fi

# Check for .msch files to stage
msch_files=$(git ls-files --others --exclude-standard -- '*.msch' | wc -l)
modified_msch=$(git diff --name-only -- '*.msch' | wc -l)
deleted_msch=$(git diff --name-only --diff-filter=D -- '*.msch' | wc -l)

total_changes=$((msch_files + modified_msch + deleted_msch))

if [[ $total_changes -eq 0 ]]; then
    echo -e "${YELLOW}No .msch file changes detected. Nothing to sync.${NC}"
    exit 0
fi

# Stage all .msch files
echo -e "${GREEN}Staging .msch files...${NC}"
git add -- '*.msch'

# Determine commit message
if [[ $# -gt 0 ]]; then
    commit_msg="$1"
else
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    commit_msg="Update schematics - $timestamp"
fi

# Commit
echo -e "${GREEN}Committing: $commit_msg${NC}"
git commit -m "$commit_msg"

# Push
echo -e "${GREEN}Pushing to origin...${NC}"
git push origin HEAD

echo -e "${GREEN}Done!${NC}"